
# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.65"
    }
  }

  required_version = ">= 0.14.9"
}

provider "azurerm" {
  features {}
}

#Create public availability set
resource "azurerm_availability_set" "availability_set1" {
  name                = "public-aset-staging"
  location            = var.location
  resource_group_name = var.resource_group_name

}


# Create a Linux virtual machine 1
resource "azurerm_virtual_machine" "vm" {
  name                  = "ansible-server"
  location              = var.location
  resource_group_name   = var.resource_group_name
  availability_set_id   = azurerm_availability_set.availability_set1.id
  network_interface_ids  = [var.network_interface_ids[0]] 
  vm_size               = var.public_vm_size

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
    computer_name  = ""
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}




# Create a Linux virtual machine 2
resource "azurerm_virtual_machine" "vm2" {
  name                  = "bootcampAppVMApp1-staging"
  location              = var.location
  resource_group_name   = var.resource_group_name
  availability_set_id   = azurerm_availability_set.availability_set1.id
  network_interface_ids  = [var.network_interface_ids[1]]
  vm_size               = var.public_vm_size
  #count = length(var.network_interface_ids)

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
    computer_name  = "bootcampAppVMApp1-staging"
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}


# Create a Linux virtual machine 3
resource "azurerm_virtual_machine" "vm3" {
  name                  = "bootcampAppVMApp2-staging"
  location              = var.location
  resource_group_name   = var.resource_group_name
  availability_set_id   = azurerm_availability_set.availability_set1.id
  network_interface_ids  = [var.network_interface_ids[2]]
  vm_size               = var.public_vm_size
 

  storage_os_disk {
    name              = "myOsDisk3"
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
    computer_name  = "bootcampAppVMApp1-staging"
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}
