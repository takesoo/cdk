# 1. How to set up the development environment

## 1-1. VSCode

The recommended settings for `.vscode` are placed as `.vscode/sample.setting.json`. If you use this, rename it to `settings.json`.

## 1-2. DevContainer

1. Run `docker compose build` in a terminal
2. Open VSCode in a terminal
3. Press the green button in the lower left corner of the VSCode and click on `Reopen in Container`.

When VSCode is opened in a container, the settings and Extensions described in the `.devcontainer` directory are reflected. Furthermore, the terminal in VSCode is also opened as a terminal in the container.

# 2. Directory structure

The three important directories are **services**, **packages**, and **pipeline**. The services directory contains services divided by lifecycle, and functions and settings commonly used by those services are defined in the packages directory. The pipeline directory describes how to deploy them continuously.

# 3. How to add new services

1. Duplicate the appropriate directory in `/services`, add a new service, and overwrite the infrastructure configuration description there.
2. Rename the copied directory and properly configure `package.json` in that directory.
3. Configure the `eslint.workingDirectories` in `.vscode/settings.json` and `/package.json` and `/Dockerfile` with reference to the already provisioned services.
4. Add the created service to the pipeline stage. (If you do not add it to the pipeline, it will not be deployed.)

# 4. CDK Pipeline

Merging into the main branch will start provisioning the AWS resources. _The service to be provisioned must be added to the pipeline stack._ The pipeline stack consists of three stages: **IAM Stage**, **Common Stage**, and **Application Stage**. First, IAM stage deploys a stack that creates IAM policies and IAM roles. Next, in common stage, stacks are deployed to create container images to be used in all environments and to create services other than those related to CANBRIGHT system. Finally, in application stage, a stack of services related to CANBRIGHT system is deployed. This application stage is instantiated three times from the pipeline stack, as it is used to deploy the development, staging and production environments.

# 5. Useful Commands

## 5-1. for CDK

```bash
# Output CloudFormation
$ yarn cdk synth GithubActionsStack

# Check for change differences in specific stacks
$ yarn cdk diff GithubActionsStack --profile canbright_mfa
$ yarn workspace github-actions cdk diff GithubActionsStack --profile canbright_mfa

# Deploy a specific stack
$ yarn cdk deploy GithubActionsStack --profile canbright_mfa
$ yarn workspace github-actions cdk deploy GithubActionsStack --profile canbright_mfa

# Display detailed information when deploying
$ cdk deploy -vv

# Remove specific stacks
$ yarn cdk destroy GithubActionsStack --profile canbright_mfa
$ yarn workspace github-actions cdk destroy GithubActionsStack --profile canbright_mfa

# Output the contents of console.log without outputting the contents of the template.
$ yarn cdk synth --quiet
```

## 5-2. for TypeScript

```bash
# Static analysis for all files
$ yarn tsc

# Static analysis for a specific directory
$ yarn workspace planning-poker tsc

# Build all files
$ yarn build

# Build specific directories
$ yarn workspace planning-poker build

# Build a specific directory in watch mode
$ yarn workspace planning-poker build:w

# Run all tests
$ yarn test

# Run tests within a specific workspace
$ yarn workspace planning-poker test

# Update snapshots in a specific workspace
$ yarn workspace planning-poker test -u

# Add a package
$ yarn add package-name

# Add a package within a specific workspace
$ yarn workspace planning-poker add package-name

# Add a package for use only in the development environment within a specific workspace (*Added to devDependencies)
$ yarn workspace @billing-notification/lambda add -D @types/aws-lambda

# Remove a package from a specific workspace
$ yarn workspace @billing-notification/lambda remove @types/aws-lambda
