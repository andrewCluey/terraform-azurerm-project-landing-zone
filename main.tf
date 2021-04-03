locals {
    name_prefix = ""

}

# New Resource Group
resource "azurerm_resource_group" "application_rg" {
  name     = ""
  location = var.location
}

# New vNET
resource "azurerm_virtual_network" "example" {
  name                = ""
  location            = var.location
  resource_group_name = azurerm_resource_group.application_rg.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]
  tags                = var.tags

  ddos_protection_plan {
      count = ????
      id     = azurerm_network_ddos_protection_plan.example.id
      enable = true
  }

# dynamic rule for subnet creation
    dynamic "subnet" {
    for_each = var.subnet
    content {
      name           = subnet.value.name
      address_prefix = subnet.address_prefix
      security_group = lookup(subnet.value, "security_group", null) 
    }
  }

  subnet {
    name           = "subnet3"
    address_prefix = "10.0.3.0/24"
    security_group = azurerm_network_security_group.example.id
  }

}

## DDOS protection
resource "azurerm_network_ddos_protection_plan" "example" {
  name                = "ddospplan1"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}



# Attach/create new UDR



# Create new Key Vault True/False



# Create Azure Firewall True / False



# Monitoring policies (Log Analytics)



# 

