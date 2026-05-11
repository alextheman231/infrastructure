variable "name" {
  description = "The name of the project"
  type        = string
}

variable "framework" {
  description = "The framework that is being used for the project"
  type        = string
}

variable "vercel_team_id" {
  description = "ID for my Vercel team"
  type        = string
}

variable "output_directory" {
  description = "The path to the built output of the thing to deploy"
  type        = string
}

variable "build_command" {
  description = "The command to use to build the project"
  type        = string
  default     = "pnpm run build"
}

variable "secrets" {
  description = "A map of secrets for the given Vercel project."
  type        = map(string)
  sensitive   = true
  default     = {}
}

variable "variables" {
  type        = map(string)
  description = "Non-sensitive variables to use in the given Vercel project."
  default     = {}
}
