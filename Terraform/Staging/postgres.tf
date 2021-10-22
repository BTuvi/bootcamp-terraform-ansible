#Create Postgresql Server
resource "azurerm_postgresql_server" "postgres" {
  name                = "postgresql-staging"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku_name = "B_Gen5_2"

  storage_mb                   = 5120
  backup_retention_days        = 7
  geo_redundant_backup_enabled = false
  auto_grow_enabled            = true

  administrator_login          = "postgres"
  administrator_login_password = var.admin_password
  version                      = "11"
  ssl_enforcement_enabled      = false
}




#Create Postgres firewall rule
resource "azurerm_postgresql_firewall_rule" "postgres_firewall" {
  name                = "office"
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_postgresql_server.postgres.name
  start_ip_address    = data.azurerm_public_ip.ip.ip_address
  end_ip_address      = data.azurerm_public_ip.ip.ip_address
}
