output "resource_group_name" {
  value       = azurerm_resource_group.rg.name
  description = "Resource group for all resources."
}

output "acr_name" {
  value       = azurerm_container_registry.acr.name
  description = "ACR name (globally unique)."
}

output "acr_login_server" {
  value       = azurerm_container_registry.acr.login_server
  description = "ACR login server (for docker login/push)."
}

output "aks_name" {
  value       = azurerm_kubernetes_cluster.aks.name
  description = "AKS cluster name."
}

output "aks_fqdn" {
  value       = azurerm_kubernetes_cluster.aks.fqdn
  description = "AKS API server FQDN."
}

# Sensitive: your kubeconfig
output "kube_config" {
  value     = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive = true
  description = "Raw kubeconfig. Save it to a file if needed."
}
