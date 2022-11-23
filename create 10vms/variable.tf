
variable "numberofvms" {
  type        = number
  description = "(optional) describe your variable"
}
variable "name" {
  type        = string
  description = "(optional) describe your variable"
}
variable "resourcegroup_details" {
  type = object({
    name     = string
    location = string
  })
}

variable "virtualnetwork_details" {
  type = object({
    address_space = list(string)
  })

}
variable "subnet_details" {
  type = object({
    address_prefixes = list(string)
  })
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
