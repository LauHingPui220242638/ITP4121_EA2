provider "aws" {
  region  = var.region
  profile = "evan"
}


resource "aws_vpc" "my_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "MyVPC"
  }
}

resource "aws_subnet" "my_subnet" {
  count             = length(var.subnet_cidrs)
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.subnet_cidrs[count.index]
  availability_zone = element(["ap-east-1a", "ap-east-1b"], count.index)

  tags = {
    Name = "MySubnet-${count.index + 1}"
  }
}
