

### create network security group

resource "azurerm_network_security_group" "nsgs" {
  name                = "${var.name}-nsgs"
  location            = azurerm_resource_group.update.location
  resource_group_name = azurerm_resource_group.update.name
}

### create NSG Rules

resource "azurerm_network_security_rule" "nsgrule" {
  name                        = "${var.name}-nsgrule"
  priority                    = "300"
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.update.name
  network_security_group_name = azurerm_network_security_group.nsgs.name
}

resource "azurerm_network_interface_security_group_association" "nsgassociation" {
  count                     = var.numberofvms
  network_security_group_id = azurerm_network_security_group.nsgs.id
  network_interface_id      = var.name == "dev" ? azurerm_network_interface.nicdev[count.index].id : azurerm_network_interface.nicqa[count.index].id
}

resource "azurerm_availability_set" "test" {
  name                = "${var.name}-set"
  location            = azurerm_resource_group.update.location
  resource_group_name = azurerm_resource_group.update.name

}

resource "azurerm_lb" "LoadBalancer" {
  name                = "${var.name}-loadbalancer"
  location            = azurerm_resource_group.update.location
  resource_group_name = azurerm_resource_group.update.name

  frontend_ip_configuration {
    name                 = "frontend"
    public_ip_address_id = azurerm_public_ip.ippublicqa[0].id
  }
  depends_on = [
    azurerm_public_ip.ippublicqa
  ]
}

resource "azurerm_lb_backend_address_pool" "backend" {
  loadbalancer_id = azurerm_lb.LoadBalancer.id
  name            = "internal"
  depends_on = [
    azurerm_lb.LoadBalancer
  ]
}

resource "azurerm_lb_probe" "healthprobe" {
  loadbalancer_id = azurerm_lb.LoadBalancer.id
  name            = "healthprobe"
  protocol        = "Http"
  request_path    = "/health"
  port            = 8080
  #resource_group_name = azurerm_resource_group.update.name
}

resource "azurerm_lb_rule" "lbrule" {
  loadbalancer_id                = azurerm_lb.LoadBalancer.id
  name                           = "lbrule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "frontend"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.backend.id]
  #resource_group_name = azurerm_resource_group.update.name
}

resource "azurerm_network_interface_backend_address_pool_association" "association" {
  count                   = var.numberofvms
  network_interface_id    = azurerm_network_interface.nicqa[count.index].id
  ip_configuration_name   = "internal"
  backend_address_pool_id = azurerm_lb_backend_address_pool.backend.id
}
