resource "azurerm_kubernetes_cluster" "example" {
  name = "dotnet-sandbox-webapp-client-cluster"
  location = "westus"
  dns_prefix = "tf-sandbox-cluster-dns"
  kubernetes_version = "1.19.9"

  resource_group_name = azurerm_resource_group.example.name

  node_resource_group = "tf-sandbox-cluster-node-rg"

  private_cluster_enabled = false
  #private_link_enabled = false # or private_cluster_enabled

  sku_tier = "Free"
  tags = {}

  default_node_pool {
    availability_zones = []
    enable_auto_scaling = false
    enable_host_encryption = false
    enable_node_public_ip = false
    //    max_count = 1 #expanding `default_node_pool`: `max_count`(1) and `min_count`(1) must be set to `null` when `enable_auto_scaling` is set to `false`
    //    min_count = 1
    max_pods = 30
    name = "agentpool"
    node_count = 1
    node_labels = {}
    node_taints = []
    orchestrator_version = "1.19.9"
    os_disk_size_gb = 128
    os_disk_type = "Managed"
    tags = {}
    type = "VirtualMachineScaleSets"
    vm_size = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  role_based_access_control {
    enabled = true
  }

  timeouts {}
}