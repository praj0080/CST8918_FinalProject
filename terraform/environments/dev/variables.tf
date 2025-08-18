variable "prefix" {
  description = "Short project/environment prefix for naming (e.g., cst8918-dev)"
  type        = string
  default     = "cst8918-dev"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "canadacentral"
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default = {
    project = "CST8918_FinalProject"
    env     = "dev"
  }
}

# ---- ACR ----
variable "acr_name" {
  description = "Globally unique ACR name (lowercase, 5-50 chars)"
  type        = string
  default     = "cst8918weatheracr"
}

variable "acr_sku" {
  description = "ACR SKU"
  type        = string
  default     = "Basic"
}

# ---- AKS ----
variable "aks_name" {
  description = "AKS cluster name"
  type        = string
  default     = "cst8918-aks-dev"
}

variable "dns_prefix" {
  description = "AKS DNS prefix"
  type        = string
  default     = "cst8918dev"
}

variable "node_count" {
  description = "AKS node count"
  type        = number
  default     = 1
}

variable "node_vm_size" {
  description = "VM size for AKS nodes"
  type        = string
  default     = "Standard_B2s"
}

variable "kubernetes_version" {
  description = "AKS version (null = latest stable)"
  type        = string
  default     = null
}
