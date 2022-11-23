variable "resourcegroup_details" {
    type = object ({
        name = string
        location = string
    })
}

variable "virtualnetwork_details" {
  type = object ({
    name = string
    address_space = list(string)
  })

}
variable "subnet_details" {
    type = object ({
    name = list(string)
    address_prefixes = list(string)
    }) 
}

variable "network_interface" {
    type = object ({
    name = list(string)
    })
  
}
variable "network_security_group" {
    type = object ({
    name = string 

    })
}

variable "network_security_rule" {
    type = object ({
    name = string
    access = string
    protocal = string
    priority = number 
    })
}

variable "virtual_machine" {
    type = object ({
        name = list(string)
        vm_size = string 

    })
  
}

variable "public_ip" {
  type = object({
    name              = list(string)
    allocation_method = string
  })
}
variable "os_disk" {
    type = list(string)
    description = "(optional) describe your variable"
 
}

/*

variable "lb_config" {
  type = object({
    name_lb = string
    name_fe = string
    name_be = string
  })
}

variable "lb_probe" {
  type = object({
    name     = string
    protocol = string
    port     = number
  })

}

*/