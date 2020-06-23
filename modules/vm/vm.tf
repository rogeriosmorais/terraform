resource "azurerm_network_interface" "udacity_interface" {
  name                = "udacity_interface"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = "${var.subnet_id}"
    private_ip_address_allocation = "Dynamic"
	public_ip_address_id          = "${var.publicip}"
  }
}

resource "azurerm_linux_virtual_machine" "udacity_vm" {
  name                  = "udacity_virtual_machine"
  location              = "${var.location}"
  resource_group_name   = "${var.resource_group}"
  size                  = "Standard_B1s"
  admin_username        = "adminuser"
  network_interface_ids = ["${azurerm_network_interface.udacity_interface.id}"]
  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }
  os_disk {
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}
