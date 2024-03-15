output "eks_cluster_role_arn" {
  value = aws_iam_role.eks_cluster_role.arn
  description = "The ARN of the IAM role for EKS cluster."
}

output "eks_node_group_role_arn" {
  value = aws_iam_role.eks_node_group_role.arn
  description = "The ARN of the IAM role for EKS node group."
}
