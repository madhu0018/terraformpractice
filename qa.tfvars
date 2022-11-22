numberofvms = 2
name = "qa"

resourcegroup_details = {
  location = "East Us"
    name = "yanam"
}
virtualnetwork_details = {
  address_space = ["10.10.0.0/16"]
}

subnet_details = {
    address_prefixes = ["10.10.0.0/24"]
}

authentication_details = {
  password = "Adminadmin@123"
  username = "madhu"
}

null_version = "2.8"