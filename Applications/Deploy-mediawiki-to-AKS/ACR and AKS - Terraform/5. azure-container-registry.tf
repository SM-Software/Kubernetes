# Create the container registry to keep the images in the private container
resource "azurerm_container_registry" "aks_acr" {
  name = var.acr_name
  resource_group_name = var.resource_group_name
  location = var.location
  sku = "Standard"
  admin_enabled = true

# enable this only if you are defining sku = "Premium" for ACR
#   georeplications {
#     location = "central us"
#     zone_redundancy_enabled = true
#     tags = {
#         "replication" = "central us"
#     }
#   }
}