resource "azurerm_network_interface" "nic1" {
  name                = "${var.project}-nic1"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "vm1" {
  depends_on                      = [azurerm_network_interface.nic1, azurerm_subnet.subnet1]
  name                            = "${var.project}-vm1"
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = azurerm_resource_group.rg.location
  size                            = "Standard_B1ls"
  network_interface_ids           = [azurerm_network_interface.nic1.id]
  disable_password_authentication = false
  admin_username                  = "adminUser"
  admin_password                  = "P@ssw0rd1234!"
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}



resource "azurerm_network_interface" "nic2" {
  name                = "${var.project}-nic2"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "vm2" {
  depends_on                      = [azurerm_network_interface.nic2, azurerm_subnet.subnet2]
  name                            = "${var.project}-vm2"
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = azurerm_resource_group.rg.location
  size                            = "Standard_B1ls"
  network_interface_ids           = [azurerm_network_interface.nic2.id]
  disable_password_authentication = false
  admin_username                  = "adminUser"
  admin_password                  = "P@ssw0rd1234!"

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}
