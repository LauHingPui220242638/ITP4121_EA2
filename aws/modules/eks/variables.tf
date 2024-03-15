variable "project" {}

variable "eks_cluster_role_arn" {}

variable "eks_node_group_role_arn" {}

variable "subnet_ids" {
  type = list(string)
}

variable "eks_cluster_sg_id" {}

variable "node_group_desired_size" {}

variable "node_group_min_size" {}

variable "node_group_max_size" {}

variable "log_retention_in_days" {
  default = 30
}
