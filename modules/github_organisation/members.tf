resource "github_membership" "admins" {
  for_each = toset(["AlexMan123456"])

  username = each.value
  role     = "admin"
}
