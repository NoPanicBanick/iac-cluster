terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-state-rg"
    storage_account_name = "ryleyterraformstate"
    container_name       = "terraform"
    key                  = "iac_cluster.tfstate"
  }
}