variable "rescource_group" {
  type = object({
    name     = string
    location = string
  })
}

variable "virtual_network" {
  type = object({
    name          = string
    address_space = list(string)
  })
}

variable "subnet" {
  type = object({
    name             = string
    address_prefixes = list(string)
  })
}

variable "public_ip" {
  type = object({
    name              = string
    allocation_method = string
  })

}

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

variable "linux_virtual_machine_scale_set" {
  type = object({
    name = string
  })
}

