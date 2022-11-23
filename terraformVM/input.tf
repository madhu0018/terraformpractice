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
    name = string
    })
  
}
variable "azurerm_network_security_group" {
    type = object ({
    name = string    
    })
  
}

variable "azurerm_network_security_rule" {
    type = object ({
    name = string
    access = string
    protocal = string
    priority = number 
    })
  
}

variable "azurerm_virtual_machine" {
    type = object ({
        name = string
        vm_size = string 
    })
  
}
