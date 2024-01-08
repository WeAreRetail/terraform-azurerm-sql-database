variable "caf_prefixes_main" {
  type        = list(string)
  description = "Principal naming prefixes"
}

variable "caf_prefixes_dr" {
  type        = list(string)
  description = "Disaster recovery naming prefixes"
}

variable "instance_index" {
  type        = number
  description = "Instance number"
  default     = 1
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name."
}

variable "server_description" {
  type        = string
  default     = ""
  description = "SQL Server description."
}

variable "database_description" {
  type        = string
  default     = ""
  description = "SQL Database description."
}

variable "tags_main" {
  type        = map(string)
  description = "Tags for main server"
}

variable "tags_dr" {
  type        = map(string)
  description = "Tags for DR server"
}

variable "custom_tags" {
  type        = map(string)
  description = "SQL Server and Database tags."
  default     = {}
}

variable "database_custom_name" {
  type    = string
  default = ""
}

variable "server_custom_name" {
  type    = string
  default = ""
}

variable "custom_location" {
  type    = string
  default = ""
}

variable "admin_group" {
  type = string
}

variable "read_groups" {
  type    = list(string)
  default = []
}

variable "user_groups" {
  type    = list(string)
  default = []
}

variable "database_sku" {
  type    = string
  default = "S0"
}

variable "database_min_capacity" {
  type    = number
  default = 0
}

variable "database_zone_redundant" {
  type    = bool
  default = false
}

variable "database_auto_pause_delay_in_minutes" {
  type    = number
  default = null
}

variable "database_storage_account_type" {
  type    = string
  default = "Local"
}

variable "sql_server_firewall_rules" {
  type        = map(object({ name = string, start = string, end = string }))
  description = "Firewall rules to apply on SQL Server"
  default     = {}
}

variable "sql_server_virtual_network_rules_main" {
  type        = list(string)
  description = "Virtual network rules to apply on SQL Main Server"
  default     = []
}

variable "sql_server_virtual_network_rules_dr" {
  type        = list(string)
  description = "Virtual network rules to apply on SQL DR Server"
  default     = []
}

variable "short_term_retention_policy" {
  type        = object({ retention_days = number, backup_interval_in_hours = number })
  description = "Short Term Retention Policy for Point In Time restoration"
  default     = { retention_days = 7, backup_interval_in_hours = 24 }
  #validation {
  #  condition     = var.short_term_retention_policy == null || (var.short_term_retention_policy.retention_days >= 7 && var.short_term_retention_policy.retention_days <= 35 && (var.short_term_retention_policy.backup_interval_in_hours == 12 || var.short_term_retention_policy.backup_interval_in_hours == 24))
  #  error_message = "The short term retention policy must have retention_days between 7 and 35, backup_interval_in_hours must be 12 or 24."
  #}
}

variable "sql_database_ltr_weekly_policy" {
  type        = string
  description = "Weekly Retention configuration for Azure SQL Database Long Term Retention Policy."
  default     = null

  #validation {
  #  condition     = var.sql_database_ltr_weekly_policy == null || var.sql_database_ltr_weekly_policy == "PT0S" || can(regex("^P([1-9]|[1-9][0-9]|[1-4][0-9]{2}|5[0-1][0-9]|520)W$", var.sql_database_ltr_weekly_policy))
  #  error_message = "The weekly retention policy for an LTR backup is invalid. Value must be 'P{term}Y' where 'term' is between 1 to 520. e.g P1W, P12W or P520W."
  #}
}

variable "sql_database_ltr_monthly_policy" {
  type        = string
  description = "Monthly Retention configuration for Azure SQL Database Long Term Retention Policy."
  default     = null

  #validation {
  #  condition     = var.sql_database_ltr_monthly_policy == null || var.sql_database_ltr_monthly_policy == "PT0S" || can(regex("^P([1-9]|[1-9][0-9]|1[0-1][0-9]|120)M$", var.sql_database_ltr_monthly_policy))
  #  error_message = "The monthly retention policy for an LTR backup is invalid. Value must be 'P{term}M' where 'term' is between 1 to 120. e.g P1M, P12M or P120M."
  #}
}

variable "sql_database_ltr_yearly_policy" {
  type        = object({ yearly_retention = string, week_of_year = number })
  description = "Yearly Retention configuration for Azure SQL Database Long Term Retention Policy."
  default     = { yearly_retention = null, week_of_year = 0 }

  #validation {
  #  condition     = var.sql_database_ltr_yearly_policy.yearly_retention == null || var.sql_database_ltr_yearly_policy.yearly_retention == "PT0S" || can(regex("^P([1-9]|10)Y$", var.sql_database_ltr_yearly_policy.yearly_retention)) && var.sql_database_ltr_yearly_policy.week_of_year >= 0 && var.sql_database_ltr_yearly_policy.week_of_year <= 52
  #  error_message = "The yearly retention policy for an LTR backup is invalid. 'yearly_retention' must be 'P{term}Y' where 'term' is between 1 to 10. e.g P1Y, P9Y or P10Y. 'week_of_year' must be between 1 and 52."
  #}
}

variable "sql_failover_group_policy" {

  type        = object({ location = string, mode = string, grace_minutes = number })
  description = <<EOT
  Microsoft Azure SQL Failover Group policy. If not defined, no Failover Group will be created.

  location - SQL Server DR Location
  mode - specifies the failover mode : 'Manual' or 'Automatic'
  grace_minutes - specifies the grace time in minutes before failover happened on 'Automatic' mode (should be 0 on 'Manual')

  EOT
  default     = null

  #validation {
  #  condition     = var.sql_failover_group_policy == null || (var.sql_failover_group_policy == null ? "" : var.sql_failover_group_policy.mode) == "Manual" || (var.sql_failover_group_policy == null ? 0 : var.sql_failover_group_policy.grace_minutes) >= 60
  #  error_message = "The SQL failover group policy is invalid. If 'mode' is 'Automatic', 'grace_minutes' must be defined and equal or greater than 60."
  #}
}
