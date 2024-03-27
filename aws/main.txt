provider "aws" {
  region  = var.region
#  profile = "evan"
}

module "network" {
  source = "./modules/network"

  vpc_cidr             = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.4.0/22", "10.0.8.0/22"]
  availability_zones   = ["ap-east-1a", "ap-east-1b"]
}

module "eks_security_group" {
  source = "./modules/security_group"

  project  = var.project
  vpc_id   = module.network.vpc_id
  vpc_cidr = module.network.vpc_cidr
}

module "ec2_instances_private" {
  source        = "./modules/ec2_instances"
  ami_id        = "ami-0a3c416f1c39ae18a" # Ensure this AMI is correct and available in your region
  instance_type = "t3.micro"
  subnet_ids    = module.network.private_subnet_ids
  project       = var.project
  vpc_id        = module.network.vpc_id
  # key_name      = "my-key-pair"
  // key_name is omitted or explicitly set to an empty string
}



module "iam_for_eks" {
  source  = "./modules/iam"
  project = var.project
}

module "eks_cluster" {
  source                  = "./modules/eks"
  project                 = var.project
  eks_cluster_role_arn    = module.iam_for_eks.eks_cluster_role_arn
  eks_node_group_role_arn = module.iam_for_eks.eks_node_group_role_arn
  subnet_ids              = module.network.private_subnet_ids
  eks_cluster_sg_id       = module.ec2_instances_private.private_ec2_sg_id
  node_group_desired_size = 1
  node_group_min_size     = 0
  node_group_max_size     = 2
  log_retention_in_days   = 30
}


resource "null_resource" "kubectl" {
    provisioner "local-exec" {
        command = "aws eks --region ${var.region} update-kubeconfig --name ${module.eks_cluster.eks_cluster_name}"
    }
}