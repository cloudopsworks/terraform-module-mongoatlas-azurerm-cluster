##
# (c) 2021-2026
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

variable "name_prefix" {
  description = "Prefix for the name of the resources"
  type        = string
  default     = ""
}

variable "name" {
  description = "Name of the resource"
  type        = string
  default     = ""
}

variable "project_id" {
  description = "(optional) The ID of the Atlas project where the cluster will be created"
  type        = string
  default     = ""
}

variable "project_name" {
  description = "(optional) The name of the Atlas project where the cluster will be created"
  type        = string
  default     = ""
}

##
# Variable entries as YAML
# settings:
#   cluster_type: "REPLICASET"           # (Optional) REPLICASET | SHARDED | GEOSHARDED. Default: "REPLICASET"
#   major_version: 7.0                   # (Optional) MongoDB major version. Default: null
#   termination_protection: true         # (Optional) Enable termination protection. Default: null
#   version_release: "LTS"               # (Optional) LTS | CONTINUOUS. Default: "LTS"
#   encryption_at_rest_enabled: false    # (Optional) Enable encryption at rest. Default: false
#   encryption_at_rest_provider: "AZURE" # (Optional) AWS | GCP | AZURE. Default: "AZURE" for this module
#   bi_connector:
#     enabled: false                     # (Optional) Enable BI Connector. Default: false
#     read_preference: "secondary"       # (Optional) primary | secondary | primaryPreferred | secondaryPreferred | nearest
#   admin_user:
#     enabled: false                     # (Optional) Create Atlas admin user. Default: false
#     username: "my-admin"               # (Optional) Username. Default: auto-generated
#     auth_database: "admin"             # (Optional) Authentication database. Default: "admin"
#     key_vault_name: "my-kv"            # (Required when enabled) Azure Key Vault name for secret storage
#     key_vault_resource_group: "my-rg"  # (Required when enabled) Resource group containing the Key Vault
#     password_rotation_period: 90       # (Optional) Terraform time_rotating period in days. Default: 90
#   advanced:
#     default_write_concern: "majority"  # (Optional) Write concern. Default: null
#     javascript: false                  # (Optional) Enable JavaScript. Default: null
#     tls_protocol: "TLS1_2"            # (Optional) TLS1_0 | TLS1_1 | TLS1_2 | TLS1_3. Default: null
#     no_table_scan: false              # (Optional) Disable table scans. Default: null
#     oplog_size: 50                    # (Optional) Oplog size in MB. Default: null
#     oplog_retention: 30               # (Optional) Oplog retention in hours. Default: null
#     bi:
#       sample_size: 1000               # (Optional) BI Connector sample size. Default: null
#       refresh_interval: 60            # (Optional) BI Connector refresh interval in seconds. Default: null
#     transaction_lifetime: 30          # (Optional) Transaction lifetime in seconds. Default: null
#   backup:
#     enabled: false                    # (Optional) Enable cloud backup. Default: false
#     hour_of_day: 0                    # (Optional) Backup hour 0-23. Default: 0
#     minute_of_hour: 0                 # (Optional) Backup minute 0-59. Default: 0
#     restore_window_days: 1            # (Optional) Restore window in days. Default: 1
#     auto_export: false                # (Optional) Enable automatic export. Default: null
#     hourly:
#       interval: 6                     # (Optional) Frequency in hours. Default: 1
#       retention_unit: "days"          # (Optional) days. Default: "days"
#       retention_value: 2              # (Optional) Retention value. Default: 1
#     daily:
#       interval: 1                     # (Optional) Frequency. Default: 1
#       retention_unit: "days"          # (Optional) days. Default: "days"
#       retention_value: 7              # (Optional) Retention value. Default: 7
#     weekly:
#       interval: 1                     # (Optional) Day of week 1-7. Default: 1
#       retention_unit: "weeks"         # (Optional) weeks. Default: "weeks"
#       retention_value: 4              # (Optional) Retention value. Default: 4
#     monthly:
#       interval: 1                     # (Optional) Day of month 1-28. Default: 1
#       retention_unit: "months"        # (Optional) months. Default: "months"
#       retention_value: 12             # (Optional) Retention value. Default: 12
#     yearly:
#       interval: 1                     # (Optional) Month of year 1-12. Default: 1
#       retention_unit: "years"         # (Optional) years. Default: "years"
#       retention_value: 2              # (Optional) Retention value. Default: 2
#     export:
#       cloud_provider: "AZURE"        # (Optional) Override export provider. Default: "AZURE"
#       service_url: "https://..."     # (Required for AZURE) Azure Blob Storage container URL
#       role_id: "role-id"             # (Required for AZURE) Atlas Azure service principal role ID
#       frequency_type: "daily"        # (Optional) hourly | daily | weekly | monthly. Default: "daily"
#   global:
#     zone_name: "Zone 1"             # (Optional) Zone name for global clusters. Default: null
#     zone_id: ""                     # (Optional) Zone ID for global clusters. Default: null
#   regions:
#     - backing_provider: "AZURE"     # (Optional) AWS | GCP | AZURE. Default: null
#       provider: "AZURE"             # (Optional) AWS | GCP | AZURE | TENANT. Default: "TENANT"
#       region: "US_EAST_2"           # (Required for AZURE) Atlas Azure region name. Must be set explicitly.
#                                     #   Note: var.region (e.g. "eastus2") is NOT auto-converted to Atlas format.
#                                     #   See Atlas docs for Azure region names: US_EAST_2, EUROPE_NORTH, etc.
#       priority: 7                   # (Optional) Electable node priority 1-7. Default: 7
#       electable:
#         size: "M10"                 # (Optional) Instance size. Default: "M2"
#         count: 3                    # (Optional) Node count. Default: null
#         disk_size: 100              # (Optional) Disk size in GB. Default: null
#       analytics:
#         size: "M10"                 # (Optional) Analytics instance size. Default: "M2"
#         count: 1                    # (Optional) Node count. Default: null
#       read_only:
#         size: "M10"                 # (Optional) Read-only instance size. Default: "M2"
#         count: 0                    # (Optional) Node count. Default: null
#       auto_scaling:
#         disk: false                 # (Optional) Enable disk auto-scaling. Default: false
#         compute: false              # (Optional) Enable compute auto-scaling. Default: false
#         max_size: "M40"             # (Optional) Maximum instance size. Default: null
#         min_size: "M10"             # (Optional) Minimum instance size. Default: null
#         scale_down: false           # (Optional) Enable scale-down. Default: false
variable "settings" {
  description = "Settings for the MongoDB Atlas cluster and Azure integrations"
  type        = any
  default     = {}
}
