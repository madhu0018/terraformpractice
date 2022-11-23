resourcegroup_details = {
  location = "East Us"
    name = "tony"
}
virtualnetwork_details = {
  name = "vnetVMss"
  address_space = ["172.16.0.0/16"]
}

subnet_details = {
    name           = ["app","db"]
    address_prefixes = ["172.16.0.0/24","172.16.1.0/24"]
}

azurerm_virtual_machine = {
  name = "vmss1"
  vm_size = "Standard_B2s"
}

network_interface = {
  name = "nic"

}

azurerm_network_security_group = {
  name = "nsgs1"
}

azurerm_network_security_rule = {
  access = "Allow"
  name = "nsgrule"
  priority = 310
  protocal = "Tcp"
}
