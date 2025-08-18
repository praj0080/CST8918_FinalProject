output "resource_group_name" {
  value       = azurerm_resource_group.rg.name
  description = "Resource group name"
}

output "acr_login_server" {
  value       = azurerm_container_registry.acr.login_server
  description = "ACR login server (for docker login/push)"
}

output "acr_admin_username" {
  value       = azurerm_container_registry.acr.admin_username
  description = "ACR admin username (admin enabled)"
  sensitive   = true
}

output "acr_admin_password" {
  value       = azurerm_container_registry.acr.admin_password
  description = "ACR admin password (admin enabled)"
  sensitive   = true
}

output "aks_name" {
  value       = azurerm_kubernetes_cluster.aks.name
  description = "AKS cluster name"
}

output "kube_config" {
  value       = azurerm_kubernetes_cluster.aks.kube_config_raw
  description = "kubectl config for this cluster"
  sensitive   = true
}

output "kubelet_object_id" {
  value       = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  description = "Kubelet identity objectId for role assignments"
}
