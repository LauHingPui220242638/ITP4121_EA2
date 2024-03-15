module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  for_each = toset(["one", "two"])

  name = "instance-${each.key}"

  instance_type          = "t3.micro"
  key_name               = "user1"
  monitoring             = true
  vpc_security_group_ids = ["sg-2"]
  subnet_id              = "subnet-01"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}