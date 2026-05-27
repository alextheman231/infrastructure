# Infrastructure

[![CI](https://github.com/alextheman231/infrastructure/actions/workflows/ci.yml/badge.svg)](https://github.com/alextheman231/infrastructure/actions/workflows/ci.yml)
[![Apply](https://github.com/alextheman231/infrastructure/actions/workflows/apply.yml/badge.svg)](https://github.com/alextheman231/infrastructure/actions/workflows/apply.yml)

This repository controls most of our integrations with external services. It gives us a nice way to centralise all our settings per service, which not only makes it quicker for us to create new projects just by adding a new service, but it also gives us a backup of our infrastructure, allowing most of our resources to be recreated from scratch in the worst-possible case scenario.

## Tech Stack

The repository uses Terraform to manage the infrastructure. The Terraform state is managed by HCP Terraform, including secret variables and plan/apply runs. On top of that, all the usual dev tooling is still present here - `alex-c-line` controls the pre-commit, and `@alextheman/eslint-plugin` lints the `package.json` that is now here as a consequence of `alex-c-line` scraping in here.
