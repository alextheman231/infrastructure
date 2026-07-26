variable "name" {
  description = "The network name"
  type        = string
}

variable "subnet_id" {
  description = "The subnet ID."
  type        = string
}

variable "security_group_ids" {
  description = "List of security group IDs to associate with the Bastion"
  type        = list(string)
}

variable "iam_instance_profile" {
  description = "The IAM instance profile to use to connect to the instance."
  type        = string
  default     = null
}

variable "ami" {
  description = "The AMI to use for the instance."
  type        = string
}
