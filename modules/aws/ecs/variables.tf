variable "name" {
  description = "The name of the service."
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

variable "port" {
  description = "The port to use"
  type        = number
  default     = 8080
}

variable "target_group_arn" {
  description = "The target group ARN."
  type        = string
}

variable "lb_listener_arn" {
  description = "The load balancer listener ARN."
  type        = string
}

variable "task_definitions" {
  description = "A list of tasks to associate with the service. It **must** contain exactly one task definition named 'service'."
  type = list(object({
    name    = string
    command = optional(list(string))
  }))
  validation {
    condition = length([
      for task in var.task_definitions : task
      if task.name == "service"
    ]) == 1

    error_message = "Exactly one task definition named \"service\" is required."
  }
  validation {
    condition = length(var.task_definitions) == length(distinct([
      for task in var.task_definitions : task.name
    ]))

    error_message = "Task definition names must be unique."
  }
}
