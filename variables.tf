variable "name" {}
variable "pubkey" {}

variable "location" {
  default = "West Europe"
}

variable "flavor" {
  default = "Standard_B1s" #1C-1GB
  #default = "Standard_B1ms" #1C-2GB
  #default = "Standard_B2s" #2C-4GB
  #default = "Standard_B2ms" #2C-8GB
}

variable "image" {
  default = {
    "publisher" = "Canonical"
    "offer"     = "0001-com-ubuntu-server-focal"
    "sku"       = "20_04-lts-gen2"
    "version"   = "latest"
  }
}

variable "admin" {
  default = {
    "username" = "tux"
    "password" = "Admin.123!"
  }
}

variable "environment_tag" {
  default = "production"
}

variable "network_address_space" {
  default = "10.0.0.0/16"
  validation {
    condition = (
      can(regex("^(?:[0-9]{1,3}\\.){3}[0-9]{1,3}/[0-9]{1,2}$", var.network_address_space))
    )
    error_message = "Invalid IP range format. It must be something like: 10.0.0.0/24 ."
  }
}

variable "network_subnet_range" {
  default = "10.0.2.0/24"
  validation {
    condition = (
      can(regex("^(?:[0-9]{1,3}\\.){3}[0-9]{1,3}/[0-9]{1,2}$", var.network_subnet_range))
    )
    error_message = "Invalid IP range format. It must be something like: 10.0.0.0/24 ."
  }
}

variable "network_vm_interface_ip" {
  default = "10.0.2.10"
  validation {
    condition = (
      can(regex("^(?:[0-9]{1,3}\\.){3}[0-9]{1,3}$", var.network_vm_interface_ip))
    )
    error_message = "Invalid IP address format. It must be something like: 102.168.10.5."
  }
}
