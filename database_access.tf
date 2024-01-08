
data "azuread_group" "read" {
  for_each         = toset(var.read_groups)
  display_name     = each.value
  security_enabled = true
}

data "azuread_group" "writer" {
  for_each         = toset(var.user_groups)
  display_name     = each.value
  security_enabled = true
}

resource "sqlsso_mssql_server_aad_account" "read" {

  for_each = data.azuread_group.read

  sql_server_dns = azurerm_mssql_server.primary.fully_qualified_domain_name
  database       = local.database_resource_name
  account_name   = each.value.display_name
  object_id      = each.value.object_id
  account_type   = "group"
  role           = "reader"

  depends_on = [
    azurerm_mssql_database.self,
    azurerm_mssql_firewall_rule.primary_rules,
  ]
}

resource "sqlsso_mssql_server_aad_account" "user" {

  for_each = data.azuread_group.writer

  sql_server_dns = azurerm_mssql_server.primary.fully_qualified_domain_name
  database       = local.database_resource_name
  account_name   = each.value.display_name
  object_id      = each.value.object_id
  account_type   = "group"
  role           = "owner"

  depends_on = [
    azurerm_mssql_database.self,
    azurerm_mssql_firewall_rule.primary_rules,
  ]
}
