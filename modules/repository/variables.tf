variable "archived" {
  type        = bool
  description = "Whether the repository is archived or not."
  default     = false
}

variable "name" {
  type        = string
  description = "Repository name."
}

variable "description" {
  type        = string
  description = "Repository description."
  default     = null
}

variable "visibility" {
  type        = string
  description = "Whether the repository is public or private."
  default     = "public"
}

variable "has_issues" {
  type    = bool
  default = true
}

variable "has_projects" {
  type    = bool
  default = false
}

variable "has_wiki" {
  type    = bool
  default = false
}

variable "required_ci_checks" {
  type        = list(string)
  description = "List of actions that must pass in the GitHub Actions CI environment before it can be merged into main."
  default     = null
}

variable "enable_branch_protection" {
  type        = bool
  description = "Enable branch protection on main."
  default     = false
}

variable "alex_up_bot_github_token" {
  description = "Token to provide for Actions bot, AlexUpBot"
  type        = string
  sensitive   = true
}
