output "vpc_id" {
  value = module.network.vpc_id
}

output "private_subnet_ids" {
  value = module.network.private_subnet_ids
}

output "cluster_name" {
  value = module.eks_cluster.eks_cluster_name
}

output "region" {
  value = var.region
}