locals {
  labels = {
    standard = {
      "breaking change" = {
        color       = "B60205"
        description = "Introduces breaking changes."
      }
      "new feature" = {
        color       = "A2EEEF"
        description = "Introduces new functionality."
      }
      "feature enhancement" = {
        color       = "28A745"
        description = "Enhances the capabilities of an existing feature."
      }
      "feature rewrite" = {
        color       = "F9D0C4"
        description = "Reimplements an existing feature."
      }
      "bug fix" = {
        color       = "D73A4A"
        description = "Fixes a bug."
      }
      "tooling" = {
        color       = "5319E7"
        description = "Tooling and dependency changes."
      }
      "documentation" = {
        color       = "0075CA"
        description = "Documentation updates."
      }
      "internal" = {
        color       = "FBCA04"
        description = "Changes to internal APIs or implementation details."
      }
      "refactor" = {
        color       = "C2E0C6"
        description = "Code quality improvements without behavioural changes."
      }
    }
    infrastructure = {
      "manual change" = {
        color       = "FBCA04"
        description = "Requires manual Terraform actions and confirmation from AlexMan123456 before deployment."
      }
      "irreversible destruction" = {
        color       = "B60205"
        description = "Destroys managed resources."
      }
      "resource update" = {
        color       = "5319E7"
        description = "Updates an existing resource."
      }
      "resource creation" = {
        color       = "28A745"
        description = "Creates a new managed resource."
      }
      "resource replacement" = {
        color       = "E99695"
        description = "Replaces an existing managed resource."
      }
    }
    app = {
      "migration" = {
        color       = "E99695"
        description = "Involves a database migration."
      }
      "authentication" = {
        color       = "0052CC"
        description = "Changes to the sign-in/sign-up process."
      }
      "authorisation" = {
        color       = "1D76DB"
        description = "Changes to user access permissions."
      }
      "ui" = {
        color       = "7057FF"
        description = "Changes the layout of the UI."
      }
      "accessibility" = {
        color       = "0E8A16"
        description = "Improves the accessibility without changing the UI layout."
      }
    }
  }
}

