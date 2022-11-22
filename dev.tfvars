numberofvms = 3
name = "dev"

resourcegroup_details = {
  location = "East Us"
    name = "yanam"
}
virtualnetwork_details = {
  address_space = ["172.16.0.0/16"]
}

subnet_details = {
    address_prefixes = ["172.16.0.0/24"]
}

authentication_details = {
  password = "Adminadmin@123"
  username = "madhu"
}

null_version = "2.8"