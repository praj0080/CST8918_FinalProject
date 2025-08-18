terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.116"
    }
  }
}

provider "azurerm" {
  features {}
}

# ---------------------------
# Resource Group
# ---------------------------
resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}-rg"
  location = var.location
  tags     = var.tags
}

# ---------------------------
# Azure Container Registry
# ---------------------------
resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = var.acr_sku
  admin_enabled       = true
  tags                = var.tags
}

# ---------------------------
# AKS Cluster
# ---------------------------
resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  dns_prefix          = var.dns_prefix

  kubernetes_version = var.kubernetes_version # null -> latest

  default_node_pool {
    name       = "nodepool1"
    vm_size    = var.node_vm_size
    node_count = var.node_count
    type       = "VirtualMachineScaleSets"

    upgrade_settings {
      max_surge = "33%"
    }
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
  }

  tags = var.tags
}

# Allow AKS kubelet to pull images from ACR
resource "azurerm_role_assignment" "acr_pull" {
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}
