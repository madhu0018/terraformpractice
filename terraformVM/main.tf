## create resource group

resource "azurerm_resource_group" "update" {
  name     = var.resourcegroup_details.name
  location = var.resourcegroup_details.location
}

### create virtual network , depends on Resource group

resource "azurerm_virtual_network" "Vnet" {
  name                = var.virtualnetwork_details.name
  location            = azurerm_resource_group.update.location
  resource_group_name = azurerm_resource_group.update.name
  address_space       = var.virtualnetwork_details.address_space
  depends_on = [
    azurerm_resource_group.update
  ]
}

### create Subnet , depends on Virtual network

resource "azurerm_subnet" "subnet" {
  resource_group_name  = azurerm_resource_group.update.name
  virtual_network_name = azurerm_virtual_network.Vnet.name
  name                 = var.subnet_details.name[0]
  address_prefixes     = [var.subnet_details.address_prefixes[0]]
  depends_on = [
    azurerm_virtual_network.Vnet
  ]
}

### create subnet1 depends on cirtual network

resource "azurerm_subnet" "subnet1" {
  resource_group_name  = azurerm_resource_group.update.name
  virtual_network_name = azurerm_virtual_network.Vnet.name
  name                 = var.subnet_details.name[1]
  address_prefixes     = [var.subnet_details.address_prefixes[1]]
  depends_on = [
    azurerm_virtual_network.Vnet
  ]
}

### create network interface

resource "azurerm_network_interface" "nic" {
  name                = var.network_interface.name
  location            = azurerm_resource_group.update.location
  resource_group_name = azurerm_resource_group.update.name

  ip_configuration {
    name                          = "ip1"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
  depends_on = [
    azurerm_subnet.subnet1
  ]
}



### create network security group

resource "azurerm_network_security_group" "nsgs1" {
  name                = var.azurerm_network_security_group.name
  location            = azurerm_resource_group.update.location
  resource_group_name = azurerm_resource_group.update.name
}

### create NSG Rules

resource "azurerm_network_security_rule" "nsgrule" {
  name                        = var.azurerm_network_security_rule.name
  priority                    = var.azurerm_network_security_rule.priority
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.update.name
  network_security_group_name = azurerm_network_security_group.nsgs1.name
}

### create Virtual Machine

resource "azurerm_virtual_machine" "vmss1" {
  name                  = var.azurerm_virtual_machine.name
  location              = azurerm_resource_group.update.location
  resource_group_name   = azurerm_resource_group.update.name
  network_interface_ids = [azurerm_network_interface.nic.id]
  vm_size               = "Standard_B1s"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "vmss1"
    admin_username = "madhu"
    admin_password = "Adminadmin@123"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "staging"
  }
}
