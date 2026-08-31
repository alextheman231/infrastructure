variable "name" {
  description = "The name of the ECS cluster."
  type        = string
}

variable "cpu" {
  description = "Number of CPU units for the task."
  type        = number
  default     = 256
}

variable "memory" {
  description = "Amount of memory used by the task in MiB."
  type        = number
  default     = 512
}

variable "image" {
  description = "The image to deploy."
  type        = string
}

variable "environment_variables" {
  description = "The environment variables for the service."
  type        = map(string)
}

variable "secret_arns" {
  description = "Mapping of secret environment variable names to AWS Secrets Manager ARNs."
  type        = map(string)
}

variable "fargate_version" {
  description = "The Fargate version"
  type        = string
  default     = "1.4.0"
}

variable "task_definitions" {
  description = "A map of task definitions to associate with the ECS cluster."
  type = map(object({
    command          = optional(list(string))
    is_long_running  = bool
    port             = optional(number)
    target_group_arn = optional(string)
  }))

  validation {
    condition = alltrue([
      for task in var.task_definitions :
      task.target_group_arn == null || (
        task.is_long_running &&
        task.port != null
      )
    ])
    error_message = "Tasks with a target_group_arn must be long-running and define a port."
  }
}

variable "vpc_id" {
  description = "The VPC ID."
  type        = string
}

variable "subnet_ids" {
  description = "The subnet IDs."
  type        = list(string)
}

variable "assign_public_ip" {
  description = "Whether or not to assign a public IP."
  type        = bool
  default     = false
}

variable "execution_role_arn" {
  description = "The ARN of the execution role."
  type        = string
}

variable "region" {
  description = "The AWS region."
  type        = string
}

variable "security_group_ids" {
  description = "List of security group IDs to associate with the ECS service."
  type        = list(string)
}

variable "task_role_arn" {
  description = "The ARN of the task role."
  type        = string
}
