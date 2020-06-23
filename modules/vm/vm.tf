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

resource "azurerm_linux_virtual_machine" "udacityvm" {
  name                  = "udacityvirtualmachine"
  location              = "${var.location}"
  resource_group_name   = "${var.resource_group}"
  size                  = "Standard_B1s"
  admin_username        = "adminuser"
  network_interface_ids = ["${azurerm_network_interface.udacity_interface.id}"]
  admin_ssh_key {
    username   = "adminuser"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCmyIb1T1y9J8zZaPn31uvb3K7XzyXy6RoxeXoV+Yp3goFygyMuGXS+cIJXvcwybdoHrS5s9366RmXBoKzUvoCMyt7YllUmD0NEZlsdpYfGBhG2ugknsphOud2L4s1vZzGA9WuGcCEQn1TXAMhJzKe3oO6BnK5z9Dxvzl80eg4p9vjpjwmqIohwCK54VxY4WB7CM95odeEPfUOphuXpLZ86a90739Gy/t60rXEwINYwHMJGEIWM8Blc4W37X3VUJePIF4oE13Iai1Jpqjc3P3Ei+UGQKwpML8kuKePtmS42YGpPb3tkztdWMzW+mA/lrf069vm8sbo6otFap52qpnlcP/dfaiGQXG8zqlFHey33g+/r4ErA6aPwzXUyabtNSUaoU0Y8ANx4EZBwMz1IUjAAct7tAT+u65nMerb2QNGDEsm6gYiq5ndcEEe+Pxe+TbVDWgmNSuACDj3R/yvKISteB3RxKoFmNbpL2OACmyotssT41yHHVwT5igxiqLl38r2Hc7njyihPmvB6DIbFy0bjPg2PV5PzI7JxA0RshvGw7kyhhseZGoqzZoU/DId6Fw/9swj7ob29y55Vel2Bs1kfZR2KcFQwqTprmS0xJK9UTbldVOX8KAmHAB87Xy1eYJ+cqkzfHhGP+v50NyEw/MJPrU1aeiuaJZiYlxcu1ByYRw== rogerio@ROGERIO-PC"
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
