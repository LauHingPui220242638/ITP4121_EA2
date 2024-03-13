resource "azurerm_kubernetes_cluster" "aks" {
  depends_on = [azurerm_log_analytics_workspace.logaw]
  name                = "${var.project}-aks"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "${var.project}-aks"

  default_node_pool {
    name                = "default"
    node_count          = 1
    vm_size             = "Standard_D2_v2"
    enable_auto_scaling = true
    min_count           = 1
    max_count           = 3
  }
  
    
  

  linux_profile {
    admin_username = "adminuser"

    ssh_key {
      key_data = jsondecode(azapi_resource_action.ssh_public_key_gen.output).publicKey
    }
  }

  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "standard"


  }
  auto_scaler_profile {

    balance_similar_node_groups      = false
    max_graceful_termination_sec     = 600
    scale_down_delay_after_add       = "10m"
    scale_down_unneeded              = "10m"
    scale_down_unready               = "20m"
    scale_down_utilization_threshold = 0.5
    scan_interval                    = "10s"
  }

  identity {
    type = "SystemAssigned"
  }


  oms_agent {
    msi_auth_for_monitoring_enabled = true
    log_analytics_workspace_id = azurerm_log_analytics_workspace.logaw.id
  }
  
}



resource "azurerm_log_analytics_workspace" "logaw" {
  name                = "${var.project}-logaw"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}