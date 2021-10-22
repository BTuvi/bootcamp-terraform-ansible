#Create public availability set
resource "azurerm_availability_set" "availability_set1" {
  name                = "public-aset-pruduction"
  location            = var.location
  resource_group_name = var.resource_group_name

}


# Create a Linux virtual machine 1
resource "azurerm_virtual_machine" "vm" {
  name                  = "VMproduction"
  location              = var.location
  resource_group_name   = var.resource_group_name
  availability_set_id   = azurerm_availability_set.availability_set1.id
  network_interface_ids  = [var.network_interface_ids[1]]
  vm_size               = var.public_vm_size
  #count = length(var.network_interface_ids)

  storage_os_disk {
    name              = "myOsDisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "StandardSSD_LRS"

  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_profile {
    computer_name  = "VMproduction"
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}


# Create a Linux virtual machine 2
resource "azurerm_virtual_machine" "vm2" {
  name                  = "VM2production"
  location              = var.location
  resource_group_name   = var.resource_group_name
  availability_set_id   = azurerm_availability_set.availability_set1.id
  network_interface_ids  = [var.network_interface_ids[2]]
  vm_size               = var.public_vm_size
 

  storage_os_disk {
    name              = "myOsDisk2"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "StandardSSD_LRS"

  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_profile {
    computer_name  = "VM2production"
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}
