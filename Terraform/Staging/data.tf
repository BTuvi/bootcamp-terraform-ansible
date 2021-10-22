#Get data from vnet
data "azurerm_virtual_network" "data_vnet" {
  name                = azurerm_virtual_network.vnet.name
  resource_group_name = var.resource_group_name
}
#Get data from lb
data "azurerm_lb" "data_lb" {
  name                = azurerm_lb.publicLB.name
  resource_group_name = var.resource_group_name
}
#Get data from backend address pool
data "azurerm_lb_backend_address_pool" "data_pool" {
  name            = azurerm_lb_backend_address_pool.backend_address_pool_public.name
  loadbalancer_id = data.azurerm_lb.data_lb.id
}

#Get ip data
data "azurerm_public_ip" "ip" {
  name                = azurerm_public_ip.publicip.name
  resource_group_name = var.resource_group_name
}