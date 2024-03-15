output "eks_endpoint" {
  value = aws_eks_cluster.eks.endpoint
}

output "eks_name" {
  value = aws_eks_cluster.eks.name
}
