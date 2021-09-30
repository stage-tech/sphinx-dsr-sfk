#!/bin/bash

VERSION_HASH=$1
GITHUB_SECRET_TOKEN_NAME=$2
GITHUB_REPOSITORY_BRANCH=$3

SCRIPT_NAME='[Lambda Publisher]'
SERVICE_NAME='node-template-repo'
PACKAGE_FILE='package.json'
PACKAGE_POINTER_FILE='package-pointer.json'
WORKING_DIR='temp'

log () {
   echo [Lambda Publisher]: `date` "-" $1
}

# In case command exits unsuccessfully - following message will be printed,
# and the script will be stopped
trap die ERR
die()
{
  log "Failed in script \"$0\" at line $BASH_LINENO"
  exit 1
}

# Mandatory argument check
if [[ -z "${VERSION_HASH// }" ]];
then
    log "Missing mandatory argument: VERSION_HASH (git commit hash version)."
    log "Usage: ./publish-package-pointer.sh [VERSION_HASH](mandatory) [GITHUB_SECRET_TOKEN_NAME](mandatory) [GITHUB_REPOSITORY_BRANCH](mandatory)"
    exit 1
fi
if [[ -z "${GITHUB_SECRET_TOKEN_NAME// }" ]];
then
    log "Missing mandatory argument: GITHUB_SECRET_TOKEN_NAME."
    log "Usage: ./publish-package-pointer.sh [VERSION_HASH](mandatory) [GITHUB_SECRET_TOKEN](mandatory) [GITHUB_REPOSITORY_BRANCH](mandatory)"
    exit 1
fi
if [[ -z "${GITHUB_REPOSITORY_BRANCH// }" ]];
then
    log "Missing mandatory argument: GITHUB_REPOSITORY_BRANCH."
    log "Usage: ./publish-package-pointer.sh [VERSION_HASH](mandatory) [GITHUB_SECRET_TOKEN_NAME](mandatory) [GITHUB_REPOSITORY_BRANCH](mandatory)"
    exit 1
fi

if [[ $GITHUB_REPOSITORY_BRANCH != 'master' ]];
then
    log "Git repository branch must be master to continue (found: '$GITHUB_REPOSITORY_BRANCH'). Skipping publishing step."
    exit 0
fi

# Reads git hub token from AWS secrets manager
log "Reading $GITHUB_SECRET_TOKEN_NAME from AWS secrets manager."
githubSecretToken=$(aws secretsmanager get-secret-value --secret-id $GITHUB_SECRET_TOKEN_NAME --query SecretString --output text)

# Reads current package version
PACKAGE_VERSION=$(cat package.json \
  | grep version \
  | head -1 \
  | awk -F: '{ print $2 }' \
  | sed 's/[",]//g' \
  | tr -d '[[:space:]]')

log "Reading package version $PACKAGE_VERSION"

# Preparing packaging working directory
mkdir -p $WORKING_DIR
cp $PACKAGE_POINTER_FILE $WORKING_DIR/$PACKAGE_FILE
cp README.md $WORKING_DIR/README.md
cd $WORKING_DIR
echo "module.exports = require('./package.json');" > index.js
echo "declare module '@stage-tech/node-template-repo';" > index.d.ts

# Reads content of package-pointer.json and replaces ${hash} with $VERSION_HASH
log "Setting $SERVICE_NAME hash version to $VERSION_HASH"
sed -i 's/${version}/'$PACKAGE_VERSION'/' $PACKAGE_FILE
sed -i 's/${hash}/'$VERSION_HASH'/' $PACKAGE_FILE

# Prepares .npmrc file for authentication
log "Preparing $SERVICE_NAME .npmrc file for authentication '(hash: '$VERSION_HASH')'"
echo '//npm.pkg.github.com/:_authToken='$githubSecretToken'' > .npmrc

# Publishes to the github pkg manager
log "Publishing $SERVICE_NAME to the GitHub pkg manager '(version: '$PACKAGE_VERSION' hash: '$VERSION_HASH')'"
npm publish
