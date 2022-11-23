rescource_group = {
  location = "centralindia"
  name     = "madhu"
}

virtual_network = {
  address_space = ["172.16.0.0/16"]
  name          = "vnet1"
}

subnet = {
  address_prefixes = ["172.16.0.0/24"]
  name             = "sub1"
}

public_ip = {
  allocation_method = "Static"
  name              = "ippublic"
}

lb_config = {
  name_fe = "front"
  name_lb = "load"
  name_be = "back"
}

lb_probe = {
  name     = "health"
  port     = 8080
  protocol = "Http"
}

linux_virtual_machine_scale_set = {
  name = "vmss"
}