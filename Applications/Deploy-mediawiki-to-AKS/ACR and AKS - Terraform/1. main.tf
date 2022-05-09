# terraform settings
terraform {
  required_version = ">=0.13"
# Add the required providers
  required_providers{
      azurerm = {
          source = "hashicorp/azurerm"
          version = "~> 2.0"
      }
      azuread = {
          source = "hashicorp/azuread"
          version = "~>1.0"
      }
  }
}

# Configure Azure provider
provider "azurerm" {
  features{}
}