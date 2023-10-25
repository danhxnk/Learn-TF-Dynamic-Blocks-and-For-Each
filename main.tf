resource "azurerm_resource_group" "Test-RG" {
  name     = "Test-RG"
  location = "UKSouth"
}

resource "azurerm_network_security_group" "Test-NSG" {
  name                = "TestSecurityGroup1"
  location            = azurerm_resource_group.Test-RG.location
  resource_group_name = azurerm_resource_group.Test-RG.name

dynamic "security_rule" {
    for_each = var.fw_ports
        content {
      name                       = "Ingress Rule for ${security_rule.value}" 
      priority                   = 100 + security_rule.key
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = security_rule.value
      destination_port_range     = security_rule.value
      source_address_prefix      = "0.0.0.0/0"
      destination_address_prefix = "*"
    }
  }
dynamic "security_rule" {
    for_each = var.fw_ports
        content {
      name                       = "Egress Rule for ${security_rule.value}" 
      priority                   = 100 + security_rule.key
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = security_rule.value
      destination_port_range     = security_rule.value
      source_address_prefix      = "0.0.0.0/0"
      destination_address_prefix = "*"
    }
  }

  tags = {
    environment = var.env
  }
}