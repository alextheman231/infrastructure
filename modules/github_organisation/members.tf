resource "github_membership" "admins" {
  for_each = toset(["AlexMan123456"])

  username = each.value
  role     = "admin"
}

resource "github_membership" "members" {
  for_each = toset(["badstagram", "RLCreates"])

  username = each.value
  role     = "member"
}
