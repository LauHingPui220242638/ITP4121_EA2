resource "aws_security_group" "private_ec2_sg" {
  name        = "${var.project}-private-ec2-sg"
  description = "Security group for EC2 instances in private subnets"
  vpc_id      = var.vpc_id

  // Example rule: Allow outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "${var.project}-PrivateEC2SG"
    Project = var.project
  }
}

resource "aws_instance" "instance" {
  count                  = length(var.subnet_ids)
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = element(var.subnet_ids, count.index)
  vpc_security_group_ids = [aws_security_group.private_ec2_sg.id] # Attach the security group here

  tags = {
    Name = "${var.project}-${count.index + 1}"
  }
}
