variable "vercel_team_id" {
  description = "ID for my Vercel team"
  type        = string
}

variable "name" {
  description = "The name of the Vercel team"
  type        = string
}

variable "description" {
  description = "The team description"
  type        = string
  default     = ""
}
