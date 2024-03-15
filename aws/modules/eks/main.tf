resource "aws_eks_cluster" "eks" {
  name     = "${var.project}-eks"
  role_arn = var.eks_cluster_role_arn

  vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = [var.eks_cluster_sg_id]
  }
}

resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "default"
  node_role_arn   = var.eks_node_group_role_arn
  subnet_ids      = var.subnet_ids

  scaling_config {
    desired_size = var.node_group_desired_size
    min_size     = var.node_group_min_size
    max_size     = var.node_group_max_size
  }
}

resource "aws_cloudwatch_log_group" "eks_log_group" {
  name              = "/aws/eks/${var.project}-eks/cluster"
  retention_in_days = var.log_retention_in_days
}
