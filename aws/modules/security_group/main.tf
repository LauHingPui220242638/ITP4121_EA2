resource "aws_security_group" "eks_cluster_sg" {
  name        = "${var.project}-eks-cluster-sg"
  description = "Security group for EKS cluster allowing necessary inbound and outbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project}-EKS-Cluster-SG"
  }
}
