resource "azurerm_kubernetes_cluster_node_pool" "example" {
  name = "tf-sandbox-aks-node-pool"

  availability_zones = []
  enable_auto_scaling = false
  enable_host_encryption = false
  enable_node_public_ip = true
  kubernetes_cluster_id = azurerm_kubernetes_cluster.example.id
  max_count = 0
  #`max_count`(1) and `min_count`(1) must be set to `null` when `enable_auto_scaling` is set to `false`
  max_pods = 30
  min_count = 0
  mode = "User"
  node_count = 1
  orchestrator_version = "1.19.9"
  os_disk_size_gb = 128
  os_disk_type = "Managed"
  os_type = "Linux"
  priority = "Regular"
  tags = {}
  vm_size = "Standard_DS1_v2"
  #Standard_D2_v2 #https://docs.microsoft.com/en-us/azure/aks/quotas-skus-regions#restricted-vm-sizes


  node_labels = {
    "agentpool" = "client1"
  }
  node_taints = [
    "client=client1:NoExecute"
  ]
}

resource "azurerm_kubernetes_cluster_node_pool" "example_spot_pool" {
  name = "tf-sandbox-aks-node-pool"

  availability_zones = []
  enable_auto_scaling = false
  enable_host_encryption = false
  enable_node_public_ip = true
  kubernetes_cluster_id = azurerm_kubernetes_cluster.example.id
  max_count = 0
  #`max_count`(1) and `min_count`(1) must be set to `null` when `enable_auto_scaling` is set to `false`
  max_pods = 30
  min_count = 0
  mode = "User"
  node_count = 1
  orchestrator_version = "1.19.9"
  os_disk_size_gb = 128
  os_disk_type = "Managed"
  os_type = "Linux"
  priority = "Spot"
  eviction_policy = "Delete"
  spot_max_price = -1
  tags = {}
  vm_size = "Standard_DS1_v2"
  #Standard_D2_v2 #https://docs.microsoft.com/en-us/azure/aks/quotas-skus-regions#restricted-vm-sizes


  node_labels = {
    "agentpool" = "client1"
    "kubernetes.azure.com/scalesetpriority" = "spot"
  }
  node_taints = [
    "kubernetes.azure.com/scalesetpriority=spot:NoSchedule",
    "client=client1:NoExecute"
  ]
}