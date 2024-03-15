variable "project" {
  description = "The project name to be used for resource naming"
  type        = string
  default     = "multicloud"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
}

variable "public_subnet_cidrs" {
  description = "The CIDR blocks for the public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "The CIDR blocks for the private subnets"
  type        = list(string)
}

variable "availability_zones" {
  description = "A list of availability zones in the region"
  type        = list(string)
}
