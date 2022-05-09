# Get the lubernetes service version avaiable in the localtion.
data "azurerm_kubernetes_service_versions" "aks_version" {
 location = var.location
 include_preview = false 
}