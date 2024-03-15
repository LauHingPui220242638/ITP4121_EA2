variable "project" {
  description = "The project name, used for naming resources."
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC where the security group will be created."
  type        = string
}

variable "vpc_cidr" {
  description = "The CIDR block of the VPC to allow inbound traffic from."
  type        = string
}
