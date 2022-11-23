## create resource group

resource "azurerm_resource_group" "update" {
  name     = var.resourcegroup_details.name
  location = var.resourcegroup_details.location
}

### create virtual network , depends on Resource group

resource "azurerm_virtual_network" "Vnet" {

  name                = "${var.name}-vnet"
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
  name                 =  "${var.name}-subnet"
  address_prefixes     = [var.subnet_details.address_prefixes[0]]
  depends_on = [
    azurerm_virtual_network.Vnet
  ]
}

### create network interface

resource "azurerm_network_interface" "nic" {
    count = var.numberofvms
  name                = "${var.name}-nic-${count.index}"
  location            = azurerm_resource_group.update.location
  resource_group_name = azurerm_resource_group.update.name

  ip_configuration {
    name                          = "ip1"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.pubip[count.index].id
  }
  depends_on = [
    azurerm_subnet.subnet
  ]
}


### create Virtual Machine

resource "azurerm_virtual_machine" "vm" {
 count = var.numberofvms
  name                  = "${var.name}-vm-${count.index}"
  location              = azurerm_resource_group.update.location
  resource_group_name   = azurerm_resource_group.update.name
  network_interface_ids = [azurerm_network_interface.nic[count.index].id]
  vm_size               = "Standard_B1s"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "osdisk-${count.index}"
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
