resource "github_membership" "admins" {
  for_each = toset(["AlexMan123456"])

  username = each.value
  role     = "admin"
}

resource "github_membership" "members" {
  for_each = toset(["Badstagram33"])

  username = each.value
  role     = "member"
}
