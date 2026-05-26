# Contributing to the Infrastructure

Before we begin, firstly note that **ONLY** members of the `alextheman231` GitHub organisation can contribute to this repository. If you try as an external user putting up a pull request against a fork, it won't work anyway because your CI run won't have access to the secrets. This is by design - most of the operations here are specific to this organisation and so I wouldn't really want people outside the organisation to make changes to it as they wouldn't really have as much knowledge on how it works and everything.

That said, if you are an organisation member, to get started you will need to install Terraform onto your machine. You can do this via Homebrew by running the following:

```bash
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
```

Verify that the installation worked by running

```bash
terraform --version
```

You should see something like

```bash
Terraform v1.14.3
on darwin_arm64
```

## Project Structure

The project is split into two directories.

- `modules` for reusable modules that can be used across all our service definitions.
- `services` for our actual service definitions - the things that Terraform will be controlling.

## Adding a Module

To add a module, first create a folder in the `modules` folder. Each modules folder should have `main.tf` to declare the required providers and associated resources, and `variables.tf` to declare any variables that should be provided by the service.

## Adding a Service

To add a new service, create a new file in the `services` folder. If a new provider is required, add it to `main.tf`. Each service definition should be declared with the `module` keyword and source one of the modules in the `modules` folder.

## Secrets/Variables

Secrets and variables are stored in HCP Terraform. As of now, only I can access this. This is by design so that we limit the amount of access to potentially sensitive information, therefore reducing the chance of leakage. If you need a secret or variable to be added to HCP Terraform, please ask me (AlexMan123456) to add it and I will confirm with you when I have.

**IMPORTANT**: If any of the variables you are adding are considered secret, you **MUST** mark it as sensitive in the variable definition. You must also let me know that it is sensitive and I will also mark it as such in HCP Terraform.

Any HCP Terraform variable must be declared in the root `variables.tf`, and again in the services `variables.tf` and `main.tf`. The root one acts as a way to bring the variables from HCP Terraform to the project, then the one in the services brings them from the root to the service definitions.

## Pull Requests

In order for a pull request to go through, it must pass our CI checks. Our CI process will run linting on the configuration, and generate a plan of expected changes. If you are me you can run `terraform plan` locally as well, but if not then CI is your only chance to see the plan.

The plan must be reviewed before the merge can occur. It will tell us exactly what Terraform plans to change in the next apply when the change is merged. Please do ensure that the changes it plans do correspond with the changes you intend to make. (e.g. if updating the database's Postgres version, confirm that it updated the Postgres version rather than destroy the existing database and create a new one on the new Postgres version)

Once you've confirmed the plan corresponds to your intent, I will then approve it if I think it's a good intent, and the change can be merged in.

Also note that sometimes I may have to make manual changes to the service before the change can be merged in. The most common example is adding variables to HCP Terraform, but another could be manually editing Terraform state. In cases like that, please wait for me to confirm the changes have been made before merging the changes in.
