locals {
  location  = "sfo3" # San Francisco
  base_name = "banicry"
}

resource "digitalocean_kubernetes_cluster" "k8s" {
  name    = "${local.base_name}-aks"
  region  = local.location
  version = "1.27.2-do.0"

  node_pool {
    name       = "default-pool"
    size       = "s-2vcpu-4gb"
    node_count = 1
  }
}
