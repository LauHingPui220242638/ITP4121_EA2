
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.project}-network"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet1" {
  name                 = "${var.project}-subnet1"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "subnet2" {
  name                 = "${var.project}-subnet2"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

# resource "azurerm_public_ip" "pip" {
#   name                = "${var.project}-pip"
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name
#   allocation_method   = "Static"
#   sku                 = "Standard"
# }

resource "azurerm_nat_gateway" "natgateway" {
  name                = "${var.project}-natgateway"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

}

# resource "azurerm_nat_gateway_public_ip_association" "natgateway_ip_association" {
#   depends_on           = [azurerm_public_ip.pip, azurerm_nat_gateway.natgateway]
#   nat_gateway_id       = azurerm_nat_gateway.natgateway.id
#   public_ip_address_id = azurerm_public_ip.pip.id
# }

resource "azurerm_subnet_nat_gateway_association" "natgateway_subnet_association" {
  depends_on     = [azurerm_subnet.subnet1, azurerm_nat_gateway.natgateway]
  subnet_id      = azurerm_subnet.subnet1.id
  nat_gateway_id = azurerm_nat_gateway.natgateway.id
}

resource "azurerm_subnet_nat_gateway_association" "natgateway_subnet_association2" {
  depends_on     = [azurerm_subnet.subnet2, azurerm_nat_gateway.natgateway]
  subnet_id      = azurerm_subnet.subnet2.id
  nat_gateway_id = azurerm_nat_gateway.natgateway.id
}