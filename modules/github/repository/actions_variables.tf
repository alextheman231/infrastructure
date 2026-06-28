resource "github_actions_secret" "default" {
  for_each        = nonsensitive(var.secrets)
  repository      = var.name
  secret_name     = each.key
  value_encrypted = each.value
}

resource "github_actions_variable" "default" {
  for_each      = var.variables
  repository    = var.name
  variable_name = each.key
  value         = each.value
}
