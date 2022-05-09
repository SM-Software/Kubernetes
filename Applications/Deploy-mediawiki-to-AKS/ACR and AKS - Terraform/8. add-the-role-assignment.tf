# Add the role assignment so that the AKS will be able to fetch the image from ACR
resource "azurerm_role_assignment" "aks_acr_role_assignment" {
    principal_id = azurerm_kubernetes_cluster.aks_cluster.kubelet_identity[0].object_id
    role_definition_name = "AcrPull"
    scope = azurerm_container_registry.aks_acr.id
    skip_service_principal_aad_check = true 
}