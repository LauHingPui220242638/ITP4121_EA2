## GKE Resources

data "terraform_remote_state" "gke" {
  backend = "local"
  config = {
    path = "../gcp/terraform.tfstate"
  }
}

provider "google" {
  # credentials = file("<PATH_TO_SERVICE_ACCOUNT_JSON>")
  project     = "fyp-re"
  region      = data.terraform_remote_state.gke.outputs.region
}

data "google_client_config" "cluster" {

}

data "google_container_cluster" "cluster" {
  name       = data.terraform_remote_state.gke.outputs.cluster_name
  location     = data.terraform_remote_state.gke.outputs.location

}

provider "kubernetes" {
  alias = "gke"

  host  = "https://${data.google_container_cluster.cluster.endpoint}"
  token = data.google_client_config.cluster.access_token
  client_certificate     = base64decode(data.google_container_cluster.cluster.master_auth.0.client_certificate)
  client_key             = base64decode(data.google_container_cluster.cluster.master_auth.0.client_key)
  cluster_ca_certificate = base64decode(data.google_container_cluster.cluster.master_auth.0.cluster_ca_certificate)

}




provider "helm" {
  alias = "gke"
  kubernetes {
    host  = "https://${data.google_container_cluster.cluster.endpoint}"
    token = data.google_client_config.cluster.access_token
    client_certificate     = base64decode(data.google_container_cluster.cluster.master_auth.0.client_certificate)
    client_key             = base64decode(data.google_container_cluster.cluster.master_auth.0.client_key)
    cluster_ca_certificate = base64decode(data.google_container_cluster.cluster.master_auth.0.cluster_ca_certificate)
  }
}

resource "helm_release" "consul_dc3" {
  provider   = helm.gke
  name       = "consul"
  repository = "https://helm.releases.hashicorp.com"
  chart      = "consul"
  version    = "1.4.0"

  values = [
    file("dc3.yaml")
  ]

  depends_on = [kubernetes_secret.gke_federation_secret]
}

resource "kubernetes_secret" "gke_federation_secret" {
  provider = kubernetes.gke
  metadata {
    name = "consul-federation"
  }

  data = data.kubernetes_secret.aks_federation_secret.data

  depends_on = [data.kubernetes_secret.aks_federation_secret]
}