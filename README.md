# node-template-repo

![](https://github.com/stage-tech/node-template-repo/workflows/Continuous%20Integration/badge.svg) ![](https://github.com/stage-tech/node-template-repo/workflows/Publish/badge.svg)
[![Publish](https://github.com/stage-tech/node-template-repo/workflows/Publish/badge.svg)](https://github.com/stage-tech/node-template-repo/actions?query=workflow%3A%22Publish%22)
[![Maintainability Rating](https://sonarcloud.io/api/project_badges/measure?project=stage-tech_node-template-repo&metric=sqale_rating&token=37e02397f12383a2c9c57bafde89b2421f961466)](https://sonarcloud.io/dashboard?id=stage-tech_node-template-repo)
[![Reliability Rating](https://sonarcloud.io/api/project_badges/measure?project=stage-tech_node-template-repo&metric=reliability_rating&token=37e02397f12383a2c9c57bafde89b2421f961466)](https://sonarcloud.io/dashboard?id=stage-tech_node-template-repo)
[![Security Rating](https://sonarcloud.io/api/project_badges/measure?project=stage-tech_node-template-repo&metric=security_rating&token=37e02397f12383a2c9c57bafde89b2421f961466)](https://sonarcloud.io/dashboard?id=stage-tech_node-template-repo)
[![Bugs](https://sonarcloud.io/api/project_badges/measure?project=stage-tech_node-template-repo&metric=bugs&token=37e02397f12383a2c9c57bafde89b2421f961466)](https://sonarcloud.io/dashboard?id=stage-tech_node-template-repo)
[![Code Smells](https://sonarcloud.io/api/project_badges/measure?project=stage-tech_node-template-repo&metric=code_smells&token=37e02397f12383a2c9c57bafde89b2421f961466)](https://sonarcloud.io/dashboard?id=stage-tech_node-template-repo)
[![Vulnerabilities](https://sonarcloud.io/api/project_badges/measure?project=stage-tech_node-template-repo&metric=vulnerabilities&token=37e02397f12383a2c9c57bafde89b2421f961466)](https://sonarcloud.io/dashboard?id=stage-tech_node-template-repo)
[![Lines of Code](https://sonarcloud.io/api/project_badges/measure?project=stage-tech_node-template-repo&metric=ncloc&token=37e02397f12383a2c9c57bafde89b2421f961466)](https://sonarcloud.io/dashboard?id=stage-tech_node-template-repo)
[![Duplicated Lines (%)](https://sonarcloud.io/api/project_badges/measure?project=stage-tech_node-template-repo&metric=duplicated_lines_density&token=37e02397f12383a2c9c57bafde89b2421f961466)](https://sonarcloud.io/dashboard?id=stage-tech_node-template-repo)
[![Coverage](https://sonarcloud.io/api/project_badges/measure?project=stage-tech_node-template-repo&metric=coverage&token=37e02397f12383a2c9c57bafde89b2421f961466)](https://sonarcloud.io/dashboard?id=stage-tech_node-template-repo)
[![Technical Debt](https://sonarcloud.io/api/project_badges/measure?project=stage-tech_node-template-repo&metric=sqale_index&token=37e02397f12383a2c9c57bafde89b2421f961466)](https://sonarcloud.io/dashboard?id=stage-tech_node-template-repo)

## Create a new repo from this template

1. Above the file list, click `Use this template`.
2. Use the Owner drop-down menu, and select the account you want to own the repository (`stage-tech`).
3. Type a name for your repository, and an optional description.
4. Choose a repository visibility (`private`).
5. Skip the remaining options.
6. Click `Create repository from template`
7. Clone the new repo and find and replace `node-template-repo` with `your-new-repo-name`
8. Add a token called `BUILD_ACTION_TOKEN` to [settings/secrets](settings/secrets) - it must have all repo and read/write package permissions.
9. Set up branch protection rules under [settings/branches](settings/branches). "Require branches to be up to date before merging" branch rule is mandatory in order for dependabot PR's automerges to work.
10. In repository Pull Requests/labels add new label named automerge.
11. [Add the repo to SonarCloud](https://sonarcloud.io/organizations/stage-tech/projects)
12. Add the SonarCloud token called `SONAR_TOKEN` to [settings/secrets](settings/secrets)
13. Find and replace `{token}` with the SonarCloud status badge token
14. Remove this section from this readme
15. Update readme details below as appropriate

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
