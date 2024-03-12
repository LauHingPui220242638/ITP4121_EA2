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

# VPC and subnet variables
variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "The CIDR blocks for the public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "The CIDR blocks for the subnets"
  type        = list(string)
  default     = ["10.0.4.0/22", "10.0.8.0/22"]
}


