resource "sentry_organization" "default" {
  name        = var.name
  slug        = var.slug
  agree_terms = true
}
