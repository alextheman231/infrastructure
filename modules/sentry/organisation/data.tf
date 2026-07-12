data "sentry_organization_integration" "github" {
  organization = sentry_organization.default.name
  provider_key = "github"
  name         = var.name
}
