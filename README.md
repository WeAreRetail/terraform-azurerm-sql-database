# Azure Aware SQL Database

[![Build Status](https://dev.azure.com/weareretail/Tooling/_apis/build/status/mod_azu_databricks_data?repoName=mod_azu_sql_database&branchName=master)](https://dev.azure.com/weareretail/Tooling/_build/latest?definitionId=11&repoName=mod_azu_sql_database&branchName=master)[![Unilicence](https://img.shields.io/badge/licence-The%20Unilicence-green)](LICENCE)

Common Azure Terraform module to normalize the connection to storage accounts on different environments

# Usage

```hcl
module "sql_database" {
  source = "WeAreRetail/sql-database/azurerm"

  read_group          = var.bdd_read_group
  server_name         = module.sql_server.server_name
  instance_index      = 1
  description         = "Aquarium database"
  resource_group_name = module.aqu_resource_group.name
  caf_prefixes        = module.aqu_naming.resource_prefixes
  name_separator      = ""
}

```

***Autogenerated file - do not edit***

#### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | ~> 2.0 |
| <a name="requirement_azurecaf"></a> [azurecaf](#requirement\_azurecaf) | >= 1.2.5 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=2.62.0 |
| <a name="requirement_sqlsso"></a> [sqlsso](#requirement\_sqlsso) | ~> 1.0 |

#### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_group"></a> [admin\_group](#input\_admin\_group) | n/a | `string` | n/a | yes |
| <a name="input_caf_prefixes_dr"></a> [caf\_prefixes\_dr](#input\_caf\_prefixes\_dr) | Disaster recovery naming prefixes | `list(string)` | n/a | yes |
| <a name="input_caf_prefixes_main"></a> [caf\_prefixes\_main](#input\_caf\_prefixes\_main) | Principal naming prefixes | `list(string)` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group name. | `string` | n/a | yes |
| <a name="input_tags_dr"></a> [tags\_dr](#input\_tags\_dr) | Tags for DR server | `map(string)` | n/a | yes |
| <a name="input_tags_main"></a> [tags\_main](#input\_tags\_main) | Tags for main server | `map(string)` | n/a | yes |
| <a name="input_custom_location"></a> [custom\_location](#input\_custom\_location) | n/a | `string` | `""` | no |
| <a name="input_custom_tags"></a> [custom\_tags](#input\_custom\_tags) | SQL Server and Database tags. | `map(string)` | `{}` | no |
| <a name="input_database_auto_pause_delay_in_minutes"></a> [database\_auto\_pause\_delay\_in\_minutes](#input\_database\_auto\_pause\_delay\_in\_minutes) | n/a | `number` | `null` | no |
| <a name="input_database_custom_name"></a> [database\_custom\_name](#input\_database\_custom\_name) | n/a | `string` | `""` | no |
| <a name="input_database_description"></a> [database\_description](#input\_database\_description) | SQL Database description. | `string` | `""` | no |
| <a name="input_database_min_capacity"></a> [database\_min\_capacity](#input\_database\_min\_capacity) | n/a | `number` | `0` | no |
| <a name="input_database_sku"></a> [database\_sku](#input\_database\_sku) | n/a | `string` | `"S0"` | no |
| <a name="input_database_storage_account_type"></a> [database\_storage\_account\_type](#input\_database\_storage\_account\_type) | n/a | `string` | `"Local"` | no |
| <a name="input_database_zone_redundant"></a> [database\_zone\_redundant](#input\_database\_zone\_redundant) | n/a | `bool` | `false` | no |
| <a name="input_instance_index"></a> [instance\_index](#input\_instance\_index) | Instance number | `number` | `1` | no |
| <a name="input_read_groups"></a> [read\_groups](#input\_read\_groups) | n/a | `list(string)` | `[]` | no |
| <a name="input_server_custom_name"></a> [server\_custom\_name](#input\_server\_custom\_name) | n/a | `string` | `""` | no |
| <a name="input_server_description"></a> [server\_description](#input\_server\_description) | SQL Server description. | `string` | `""` | no |
| <a name="input_short_term_retention_policy"></a> [short\_term\_retention\_policy](#input\_short\_term\_retention\_policy) | Short Term Retention Policy for Point In Time restoration | `object({ retention_days = number, backup_interval_in_hours = number })` | <pre>{<br>  "backup_interval_in_hours": 24,<br>  "retention_days": 7<br>}</pre> | no |
| <a name="input_sql_database_ltr_monthly_policy"></a> [sql\_database\_ltr\_monthly\_policy](#input\_sql\_database\_ltr\_monthly\_policy) | Monthly Retention configuration for Azure SQL Database Long Term Retention Policy. | `string` | `null` | no |
| <a name="input_sql_database_ltr_weekly_policy"></a> [sql\_database\_ltr\_weekly\_policy](#input\_sql\_database\_ltr\_weekly\_policy) | Weekly Retention configuration for Azure SQL Database Long Term Retention Policy. | `string` | `null` | no |
| <a name="input_sql_database_ltr_yearly_policy"></a> [sql\_database\_ltr\_yearly\_policy](#input\_sql\_database\_ltr\_yearly\_policy) | Yearly Retention configuration for Azure SQL Database Long Term Retention Policy. | `object({ yearly_retention = string, week_of_year = number })` | <pre>{<br>  "week_of_year": 0,<br>  "yearly_retention": null<br>}</pre> | no |
| <a name="input_sql_failover_group_policy"></a> [sql\_failover\_group\_policy](#input\_sql\_failover\_group\_policy) | Microsoft Azure SQL Failover Group policy. If not defined, no Failover Group will be created. | `object({ location = string, mode = string, grace_minutes = number })` | `null` | no |
| <a name="input_sql_server_firewall_rules"></a> [sql\_server\_firewall\_rules](#input\_sql\_server\_firewall\_rules) | Firewall rules to apply on SQL Server | `map(object({ name = string, start = string, end = string }))` | `{}` | no |
| <a name="input_sql_server_virtual_network_rules_dr"></a> [sql\_server\_virtual\_network\_rules\_dr](#input\_sql\_server\_virtual\_network\_rules\_dr) | Virtual network rules to apply on SQL Main Server | `list(string)` | `[]` | no |
| <a name="input_sql_server_virtual_network_rules_main"></a> [sql\_server\_virtual\_network\_rules\_main](#input\_sql\_server\_virtual\_network\_rules\_main) | Virtual network rules to apply on SQL Main Server | `list(string)` | `[]` | no |
| <a name="input_user_groups"></a> [user\_groups](#input\_user\_groups) | n/a | `list(string)` | `[]` | no |

#### Outputs

| Name | Description |
|------|-------------|
| <a name="output_database_name"></a> [database\_name](#output\_database\_name) | n/a |
| <a name="output_primary_server_fqdn"></a> [primary\_server\_fqdn](#output\_primary\_server\_fqdn) | n/a |
| <a name="output_primary_server_id"></a> [primary\_server\_id](#output\_primary\_server\_id) | n/a |
| <a name="output_primary_server_name"></a> [primary\_server\_name](#output\_primary\_server\_name) | n/a |
| <a name="output_secondary_server_fqdn"></a> [secondary\_server\_fqdn](#output\_secondary\_server\_fqdn) | n/a |
| <a name="output_secondary_server_id"></a> [secondary\_server\_id](#output\_secondary\_server\_id) | n/a |
| <a name="output_secondary_server_name"></a> [secondary\_server\_name](#output\_secondary\_server\_name) | n/a |