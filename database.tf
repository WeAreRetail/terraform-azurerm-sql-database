locals {
  database_resource_name = coalesce(var.database_custom_name, azurecaf_name.self_database.result)
  database_tags_main     = { for n, v in merge(local.tags_main, { "description" = var.database_description }, var.custom_tags) : n => v if v != "" }
}

resource "azurecaf_name" "self_database" {
  name          = format("%02d", var.instance_index)
  resource_type = "azurerm_mssql_database"
  prefixes      = var.caf_prefixes_main
  suffixes      = []
  use_slug      = true
  clean_input   = true
  separator     = ""
}

resource "azurerm_mssql_database" "self" {
  name         = local.database_resource_name
  server_id    = azurerm_mssql_server.primary.id
  collation    = "SQL_Latin1_General_CP1_CS_AS"
  license_type = "BasePrice"

  sku_name                    = var.database_sku
  min_capacity                = var.database_min_capacity
  zone_redundant              = var.database_zone_redundant
  auto_pause_delay_in_minutes = var.database_auto_pause_delay_in_minutes
  storage_account_type        = var.database_storage_account_type

  short_term_retention_policy {
    retention_days           = var.short_term_retention_policy.retention_days
    backup_interval_in_hours = var.short_term_retention_policy.backup_interval_in_hours
  }

  long_term_retention_policy {
    weekly_retention  = var.sql_database_ltr_weekly_policy
    monthly_retention = var.sql_database_ltr_monthly_policy
    yearly_retention  = var.sql_database_ltr_yearly_policy.yearly_retention
    week_of_year      = var.sql_database_ltr_yearly_policy.week_of_year
  }

  tags = local.database_tags_main

  lifecycle {
    ignore_changes = [
      license_type
    ]
  }
}
