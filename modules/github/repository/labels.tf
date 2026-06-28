resource "github_issue_label" "low_risk" {
  count = !var.archived ? 1 : 0

  repository  = github_repository.default.name
  name        = "low risk"
  color       = "008672"
  description = "Low risk change"
}

resource "github_issue_label" "medium_risk" {
  count = !var.archived ? 1 : 0

  repository  = github_repository.default.name
  name        = "medium risk"
  color       = "7057FF"
  description = "Medium risk change"
}

resource "github_issue_label" "high_risk" {
  count = !var.archived ? 1 : 0

  repository  = github_repository.default.name
  name        = "high risk"
  color       = "E4E669"
  description = "High risk change"
}

resource "github_issue_label" "low_priority" {
  count = !var.archived ? 1 : 0

  repository  = github_repository.default.name
  name        = "low priority"
  color       = "0E8A16"
  description = "Low priority change"
}

resource "github_issue_label" "medium_priority" {
  count = !var.archived ? 1 : 0

  repository  = github_repository.default.name
  name        = "medium priority"
  color       = "FBCA04"
  description = "Medium priority change"
}

resource "github_issue_label" "high_priority" {
  count = !var.archived ? 1 : 0

  repository  = github_repository.default.name
  name        = "high priority"
  color       = "D73A4A"
  description = "High priority change"
}

resource "github_issue_label" "critical_priority" {
  count = !var.archived ? 1 : 0

  repository  = github_repository.default.name
  name        = "critical priority"
  color       = "B60205"
  description = "Critical priority change"
}

resource "github_issue_label" "default" {
  for_each = var.labels

  repository  = github_repository.default.name
  name        = each.key
  color       = each.value.color
  description = each.value.description
}
