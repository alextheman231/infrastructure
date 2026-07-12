output "id" {
  value = sentry_organization.default.id
}

output "github_integration_id" {
  value = data.sentry_organization_integration.github.id
}
