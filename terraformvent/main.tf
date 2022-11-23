resource "azurerm_resource_group" "qt_madhu" {
  name     = "madhu"
  location = "East Us"
}
resource "azurerm_virtual_network" "qt_madhu_vnet" {
  name                = "vnet1"
  location            = "East Us"
  resource_group_name = "madhu"
  address_space       = ["172.16.0.0/16"]
  depends_on = [
    azurerm_resource_group.qt_madhu
  ]
}
resource "azurerm_subnet" "vnet_subnet1" {
  name                 = "web"
  resource_group_name  = "madhu"
  virtual_network_name = "vnet1"
  address_prefixes     = ["172.16.0.0/24"] 
  depends_on = [  
    azurerm_virtual_network.qt_madhu_vnet
  ]
} 
resource "azurerm_subnet" "vnet_subnet2" {
  name                 = "app"
  resource_group_name  = "madhu"
  virtual_network_name = "vnet1"
  address_prefixes     = ["172.16.1.0/24"]
  depends_on = [
    azurerm_subnet.vnet_subnet1
  ]
} 
resource "azurerm_subnet" "vnet_subnet3" {
  name                 = "cache"
  resource_group_name  = "madhu"
  virtual_network_name = "vnet1"
  address_prefixes     = ["172.16.2.0/24"]
  depends_on = [
    azurerm_subnet.vnet_subnet2
  ]
}  
resource "azurerm_subnet" "vnet_subnet4" {
  name                 = "db"
  resource_group_name  = "madhu"
  virtual_network_name = "vnet1"
  address_prefixes     = ["172.16.3.0/24"]
  depends_on = [
    azurerm_subnet.vnet_subnet3
  ]
}  



