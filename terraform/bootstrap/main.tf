terraform {
  required_version = ">= 1.6.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.112"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}

provider "azurerm" {
  features {}
}

########################
# EDIT THESE DEFAULTS  #
########################
variable "prefix" {
  description = "Short name for all resources (letters/numbers only)."
  type        = string
  default     = "weather"
}

variable "location" {
  description = "Azure region."
  type        = string
  # Examples: canadacentral, eastus, westus3, etc.
  default     = "canadacentral"
}

variable "node_count" {
  description = "AKS default pool size."
  type        = number
  default     = 1
}

variable "node_size" {
  description = "VM size for AKS nodes."
  type        = string
  default     = "Standard_B2s"
}

# Optional – pin a version or leave null to let Azure pick a default
variable "kubernetes_version" {
  description = "AKS Kubernetes version (or null for default)."
  type        = string
  default     = null
}

variable "tags" {
  description = "Common tags."
  type        = map(string)
  default = {
    project = "CST8918_FinalProject"
    owner   = "student"
    env     = "dev"
  }
}

# Keep names globally-unique where needed
resource "random_string" "suffix" {
  length  = 4
  upper   = false
  special = false
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}-${random_string.suffix.result}-rg"
  location = var.location
  tags     = var.tags
}

# Azure Container Registry (ACR)
# Must be 5-50 chars, lowercase, numbers only (no hyphens)
locals {
  acr_name = lower(replace("${var.prefix}${random_string.suffix.result}acr", "/[^a-z0-9]/", ""))
}

resource "azurerm_container_registry" "acr" {
  name                = local.acr_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic"
  admin_enabled       = true
  tags                = var.tags
}

# AKS Cluster
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.prefix}-${random_string.suffix.result}-aks"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "${var.prefix}-${random_string.suffix.result}"

  kubernetes_version = var.kubernetes_version

  default_node_pool {
    name       = "sys"
    node_count = var.node_count
    vm_size    = var.node_size
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

# Allow AKS to pull images from ACR
resource "azurerm_role_assignment" "aks_to_acr" {
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}
