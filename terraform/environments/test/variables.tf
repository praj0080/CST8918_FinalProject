variable "prefix" {
  description = "Short prefix for naming (e.g., cst8918-test)"
  type        = string
  default     = "cst8918-test"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "canadacentral"
}

variable "tags" {
  description = "Common resource tags"
  type        = map(string)
  default = {
    project = "CST8918_FinalProject"
    env     = "test"
  }
}

# ---- ACR ----
variable "acr_name" {
  description = "Globally-unique ACR name"
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
  default     = "cst8918-aks-test"
}

variable "dns_prefix" {
  description = "AKS DNS prefix"
  type        = string
  default     = "cst8918test"
}

variable "node_count" {
  description = "AKS node count"
  type        = number
  default     = 1
}

variable "node_vm_size" {
  description = "AKS node VM size"
  type        = string
  default     = "Standard_B2s"
}

variable "kubernetes_version" {
  description = "AKS version (null = latest supported)"
  type        = string
  default     = null
}
