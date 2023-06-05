locals {
  location    = "sfo3"
  location_az = "westus"
  base_name   = "banicry"

  //kube_config = azurerm_storage_account.backups.primary_access_key
}

# primary cluster for running the server
resource "digitalocean_kubernetes_cluster" "foo" {
  name    = "${local.base_name}-aks"
  region  = local.location
  version = "1.25.4-do.0"

  node_pool {
    name       = "default-pool"
    size       = "s-2vcpu-4gb"
    node_count = 1
  }
}

# storage account for backups
# resource "azurerm_resource_group" "minecraft" {
#   name     = "minecraft-rg"
#   location = local.location_az
# }

# resource "azurerm_storage_account" "backups" {
#   name                     = "${local.base_name}backups"
#   resource_group_name      = azurerm_resource_group.minecraft.name
#   location                 = azurerm_resource_group.minecraft.location
#   account_tier             = "Standard"
#   account_replication_type = "LRS"
# }

# resource "azurerm_storage_share" "backups" {
#   name                 = "backups"
#   storage_account_name = azurerm_storage_account.backups.name
#   quota                = 50 # 50 gigabytes
# }

# resource "kubernetes_secret" "backup-acct-secret" {
#   metadata {
#     name = "backups-acct"
#   }

#   data = {
#     azurestorageaccountname = azurerm_storage_account.backups.name
#     azurestorageaccountkey  = azurerm_storage_account.backups.primary_access_key
#   }
# }

