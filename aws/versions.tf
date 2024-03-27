terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.6.2"
    }
  }
  required_version = ">= 0.14"
}



# terraform {
#   required_version = ">= 1.2.0"

#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 4.16"
#     }
#   }
# }