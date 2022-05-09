resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name = "${var.appname}-aks-cluster"
  location = var.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  dns_prefix = "${var.appname}-dns"
  kubernetes_version = data.azurerm_kubernetes_service_versions.aks_version.latest_version
  node_resource_group = "${var.appname}-nrg"

  default_node_pool {
    name = "${var.appname}"
    vm_size = var.aks_node_vm_size
    orchestrator_version = data.azurerm_kubernetes_service_versions.aks_version.latest_version
    #availability_zones = [ "1" ] # enable this only if you are defining sku = "Standard" in ACR
    enable_auto_scaling = true
    max_count = var.default_aks_node_count
    min_count = var.default_aks_node_count
    os_disk_size_gb = 30
    type = "VirtualMachineScaleSets"
    node_labels = {
      "app" = "mediawiki"
      "environment" = "Dev"
      "app-version" = "1.39-alpha"
    }
    tags = {
      "app" = "mediawiki"
      "environment" = "Dev"
      "app-version" = "1.39-alpha"
    }
  }

  # Identity provider
  identity{
      type = "SystemAssigned"
  }

  # Windows profile
  windows_profile {
    admin_username = var.windows_admin_username
    admin_password = var.windows_admin_password
  }

  # Linux profile
  linux_profile {
    admin_username = "ubuntu"
    ssh_key {
      key_data = file(var.ssh_public_key)
    }
  }

  # Netwrok profile
  network_profile {
    network_plugin = "azure"
    load_balancer_sku = "Standard"
  }

  tags = {
      "app" = "mediawiki"
      "environment" = "Dev"
      "app-version" = "1.39-alpha"
  }
}