resource "azurerm_resource_group" "madhu" {
  name     = var.rescource_group.name
  location = var.rescource_group.location
}

resource "azurerm_virtual_network" "vent1" {
  name                = var.virtual_network.name
  location            = azurerm_resource_group.madhu.location
  resource_group_name = azurerm_resource_group.madhu.name
  address_space       = ["172.16.0.0/16"]
  depends_on = [
    azurerm_resource_group.madhu
  ]
}

resource "azurerm_subnet" "subnet" {
  name                 = "subnet1"
  resource_group_name  = azurerm_resource_group.madhu.name
  virtual_network_name = azurerm_virtual_network.vent1.name
  address_prefixes     = ["172.16.0.0/24"]
  depends_on = [
    azurerm_virtual_network.vent1
  ]
}

resource "azurerm_public_ip" "ippublic" {
  name                = var.public_ip.name
  resource_group_name = azurerm_resource_group.madhu.name
  location            = azurerm_resource_group.madhu.location
  allocation_method   = "Dynamic"

  depends_on = [
    azurerm_subnet.subnet
  ]
}

resource "azurerm_lb" "LoadBalancer" {
  name                = var.lb_config.name_lb
  location            = azurerm_resource_group.madhu.location
  resource_group_name = azurerm_resource_group.madhu.name

  frontend_ip_configuration {
    name                 = var.lb_config.name_fe
    public_ip_address_id = azurerm_public_ip.ippublic.id
  }
  depends_on = [
    azurerm_public_ip.ippublic
  ]
}

resource "azurerm_lb_backend_address_pool" "backend" {
  loadbalancer_id = azurerm_lb.LoadBalancer.id
  name = "BackEndAddressPool"

  depends_on = [
    azurerm_lb.LoadBalancer
  ]
}


resource "azurerm_lb_probe" "healthprobe" {
  resource_group_name = azurerm_resource_group.madhu.name
  loadbalancer_id     = azurerm_lb.LoadBalancer.id
  name                = var.lb_probe.name
  protocol            = var.lb_probe.protocol
  request_path        = "/health"
  port                = 8080
}

resource "azurerm_linux_virtual_machine_scale_set" "vmss" {
  name                = var.linux_virtual_machine_scale_set.name
  location            = azurerm_resource_group.madhu.location
  resource_group_name = azurerm_resource_group.madhu.name
  instances           = 1
  sku                 = "Standard_F2"
   admin_username = "madhu"
   admin_password ="Devops@123456"
   disable_password_authentication = false

os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

network_interface {
    name    = "example"
    primary = true

    ip_configuration {
      name                                   = "IPConfiguration"
      primary                                = true
            subnet_id                              = azurerm_subnet.subnet.id
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.backend.id]
                                                
    }
  }


  tags = {
    environment = "staging"
  }
}


