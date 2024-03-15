output "security_group_id" {
  value = aws_security_group.eks_cluster_sg.id
  description = "The ID of the security group created for the EKS cluster."
}
