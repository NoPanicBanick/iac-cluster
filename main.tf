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

// Storage for overseerr config
# resource "azurerm_resource_group" "overseerr" {
#   name     = "bc-overseerr-rg"
#   location = "westus"
# }

# resource "azurerm_storage_account" "overseerr" {
#   name                     = "${local.base_name}overseerr"
#   resource_group_name      = azurerm_resource_group.overseerr.name
#   location                 = azurerm_resource_group.overseerr.location
#   account_tier             = "Standard"
#   account_replication_type = "LRS"
# }

# resource "azurerm_storage_share" "backups" {
#   name                 = "overseerr"
#   storage_account_name = azurerm_storage_account.overseerr.name
#   quota                = 5 # 5 gigabytes
# }

resource "kubernetes_namespace" "overseerr" {
  metadata {
    name = "overseerr"
  }

  depends_on = [ digitalocean_kubernetes_cluster.k8s ]
}

resource "kubernetes_namespace" "cert-manager" {
  metadata {
    name = "cert-manager"
  }

  depends_on = [ digitalocean_kubernetes_cluster.k8s ]
}

# resource "kubernetes_secret" "backup-acct-secret" {
#   metadata {
#     name      = "overseerr-acct"
#     namespace = "overseerr"
#   }

#   data = {
#     azurestorageaccountname = azurerm_storage_account.overseerr.name
#     azurestorageaccountkey  = azurerm_storage_account.overseerr.primary_access_key
#   }

#   depends_on = [kubernetes_namespace.overseerr]
# }