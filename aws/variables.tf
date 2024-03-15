variable "project" {
  description = "The project name to be used for resource naming"
  type        = string
  default     = "multicloud"
}

variable "region" {
  description = "The AWS region to deploy resources into"
  type        = string
  default     = "ap-east-1"
}

