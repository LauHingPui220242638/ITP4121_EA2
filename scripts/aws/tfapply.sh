terraform init
terraform fmt
terraform validate
terraform apply -var-file="secret.tfvars" -auto-approve
