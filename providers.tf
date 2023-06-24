terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.61.0"
    }
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "azurerm" {
  features {}
}

variable "do_token" {}

provider "digitalocean" {
  token = var.do_token
}

# provider "kubernetes" {
#   host  = digitalocean_kubernetes_cluster.k8s.endpoint
#   token = digitalocean_kubernetes_cluster.k8s.kube_config[0].token
#   cluster_ca_certificate = base64decode(
#     digitalocean_kubernetes_cluster.k8s.kube_config[0].cluster_ca_certificate
#   )
# }