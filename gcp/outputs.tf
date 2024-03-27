output "cluster_name" {
  value = "${var.cluster_name}-${var.env_name}"
}


output "region" {
  value = var.region
}

output "location" {
  value = var.zones
}