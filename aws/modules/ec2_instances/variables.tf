variable "ami_id" {
  description = "The AMI ID to use for the instances."
}

variable "instance_type" {
  description = "The instance type."
  default     = "t3.micro"
}

variable "subnet_ids" {
  description = "A list of subnet IDs where instances will be created."
  type        = list(string)
}

variable "key_name" {
  description = "The key name of the Key Pair to use for the instance; leave empty if no key pair is desired."
  type        = string
  default     = ""
}

variable "project" {
  description = "The project name, used for tagging."
}

variable "vpc_id" {
  description = "The VPC ID where the security group and instances will be created."
}
