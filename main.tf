resource "azurerm_resource_group" "main" {
  name     = "${var.name}-resource-group"
  location = var.location
}

resource "azurerm_ssh_public_key" "pubkey" {
  name                = var.name
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
  public_key          = var.pubkey
}

resource "azurerm_virtual_machine" "vm" {
  name                             = "${var.name}-vm"
  location                         = azurerm_resource_group.main.location
  resource_group_name              = azurerm_resource_group.main.name
  network_interface_ids            = [azurerm_network_interface.nic.id]
  vm_size                          = var.flavor
  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = var.image["publisher"]
    offer     = var.image["offer"]
    sku       = var.image["sku"]
    version   = var.image["version"]
  }

  storage_os_disk {
    name              = "${var.name}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = var.name
    admin_username = var.admin["username"]
    admin_password = var.admin["password"]
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/${var.admin["username"]}/.ssh/authorized_keys"
      key_data = azurerm_ssh_public_key.pubkey.public_key
    }
  }

  tags = {
    environment = var.environment_tag
  }
}
