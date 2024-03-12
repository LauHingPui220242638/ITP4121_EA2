# Security Group for EKS Cluster
resource "aws_security_group" "eks_cluster_sg" {
  name        = "${var.project}-eks-cluster-sg"
  description = "Security group for EKS cluster allowing necessary inbound and outbound traffic"
  vpc_id      = aws_vpc.my_vpc.id

  # Allow inbound traffic from the VPC CIDR block for internal cluster communication
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpc_cidr]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "EKS Cluster SG"
  }
}

