# sphinx-dsr-sfk

this repo contains ddex-dsr snowflake SQL templates generation code.

To generate the ddl scripts run:

```shell
yarn generate:ddl envName
```

## CI/CD

This template includes two predefined GitHub build specs:

`.github/workflows/ci.yml` - a basic coninuous integration script which triggers yarn install, build, lint and test processes for checkins on all branches

`.github/workflows/publish.yml` - a packaging and publishing script which lints and tests the code, then auto increments the package version and publishes a package under this repo for all checkins to master

`.github/workflows/dependabot_pr.yml` - captures dependabot pull request and fire eventfor dependabot_ci.yml to pick up.

`.github/workflows/dependabot_ci.yml` - runs ci on PR that was raised by dependabot. On successful ci run merges PR.

NOTE: The publishing step in `publish.yml` is disabled by default. To enable this uncomment all the lines under the `build-and-publish:` section

## Getting started

This repository relies on private `@stage-tech` package dependencies. Run the following command to create a local .npmrc config file and update the {updateYourTokenHere} placeholders in the file with a GitHub token with appropriate permissions:

```shell
echo "@stage-tech:registry=https://npm.pkg.github.com/stage-tech
//npm.pkg.github.com/:_authToken={updateYourTokenHere}
//npm.pkg.github.com/stage-tech/:_authToken={updateYourTokenHere}
//npm.pkg.github.com/downloads/:_authToken={updateYourTokenHere}" >> .nmprc
```

Before starting development run the following commands to refresh your code, configure your local environment to run the correct version of Node, install the latest package dependencies, and lint and test the code:

```shell
git pull
nvm use
yarn
yarn lint
yarn test
```

## Useful scripts

| Command          | What does it do?                                                                                          |
| ---------------- | --------------------------------------------------------------------------------------------------------- |
| yarn             | Installs package dependencies                                                                             |
| yarn build       | Transpiles TypeScript to JavaScript                                                                       |
| yarn test        | Executes all tests                                                                                        |
| yarn start       | Builds and starts the Node process                                                                        |
| yarn lint        | Builds and lints the code base                                                                            |
| yarn lambda:pack | Builds and lints the code base then creates a versioned lambda deployment package (ZIP) under ./packages/ |
