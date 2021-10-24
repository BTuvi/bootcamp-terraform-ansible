# Managed Postgres

resource "azurerm_postgresql_server" "postgres" {
  name                = "postgresql-bar"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku_name = "B_Gen5_2"

  storage_mb                   = 5120
  backup_retention_days        = 7
  geo_redundant_backup_enabled = false
  auto_grow_enabled            = false

  administrator_login          = "postgres"
  administrator_login_password = var.VM_ADMIN_PASSWORD
  version                      = "11"
  ssl_enforcement_enabled      = false
}

resource "azurerm_postgresql_firewall_rule" "postgres_firewall" {
  
  name                = "rule"
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_postgresql_server.postgres.name
  start_ip_address    = data.azurerm_public_ip.ip.ip_address
  end_ip_address      = data.azurerm_public_ip.ip.ip_address
}


