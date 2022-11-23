resourcegroup_details = {
  location = "East Us"
    name = "murali"
}
virtualnetwork_details = {
  name = "vnetVM"
  address_space = ["172.16.0.0/16"]
}

subnet_details = {
    name           = ["app"]
    address_prefixes = ["172.16.0.0/24"]
}

 public_ip = {
   allocation_method = "Dynamic"
   name = [ "1pubip" , "2pubip" ]
 }

 virtual_machine = {
   name = [ "vm1","vm2" ]
   vm_size = "Standard_B2s"
 }

network_interface = {
  name = ["nic1","nic2"]
}

network_security_group = {
  name = "nsgs1"
}

network_security_rule = {
  access = "Allow"
  name = "nsgrule"
  priority = 310
  protocal = "Tcp"
}
os_disk = [ "disk1","disk2" ]
