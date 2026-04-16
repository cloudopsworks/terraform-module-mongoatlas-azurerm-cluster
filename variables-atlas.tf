##
# (c) 2021-2026
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

variable "cloud_provider" {
  description = "Default cloud provider for Atlas backup export bucket and copy settings. Valid values: 'AWS', 'GCP', 'AZURE'. Can be overridden per-resource in settings."
  type        = string
  default     = "AZURE"
}

variable "run_hoop" {
  description = "DEPRECATED: No-op. Use the hoop_connections output with terraform-module-hoop-connection instead."
  type        = bool
  default     = false
}

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
#   cluster_type: "REPLICASET"             # (Optional) Cluster type: REPLICASET | SHARDED | GEOSHARDED. Default: "REPLICASET"
#   major_version: 7.0                     # (Optional) MongoDB major version. Default: null (uses Atlas default)
#   termination_protection: true           # (Optional) Enable termination protection. Default: null
#   version_release: "LTS"                 # (Optional) Release cadence: LTS | CONTINUOUS. Default: "LTS"
#   encryption_at_rest_enabled: false      # (Optional) Enable encryption at rest. Default: false
#   encryption_at_rest_provider: "AZURE"   # (Optional) Provider for encryption at rest: AWS | GCP | AZURE. Default: "AZURE" for this module
#   cloud_provider: "AZURE"                # (Optional) Default cloud provider for backup export/copy: AWS | GCP | AZURE. Default: "AZURE"
#   bi_connector:
#     enabled: false                       # (Optional) Enable BI Connector. Default: false
#     read_preference: "secondary"         # (Optional) primary | secondary | primaryPreferred | secondaryPreferred | nearest. Default: "secondary"
#   admin_user:
#     enabled: false                       # (Optional) Create an Atlas admin user. Default: false
#     username: "my-admin"                 # (Optional) Username for the admin user. Default: auto-generated from name
#     auth_database: "admin"               # (Optional) Authentication database. Default: "admin"
#     key_vault_name: "my-kv"              # (Required when enabled) Azure Key Vault name for credential storage
#     key_vault_resource_group: "my-rg"    # (Required when enabled) Resource group containing the Key Vault
#     use_external_rotation: false         # (Optional) When true, an external rotation manager handles the password. Default: false
#     rotation_lambda_name: ""             # (Optional) External rotator identifier. Required when use_external_rotation is true.
#     rotation_period: 90                  # (Optional) Password rotation period in days. Default: 90
#     rotation_duration: "1h"              # (Optional) Duration for external rotator execution. Default: "1h"
#     password_rotation_period: 90         # (Optional) time_rotating period in days for Terraform-managed rotation. Default: 90
#   advanced:
#     default_write_concern: "majority"    # (Optional) Write concern. Default: null
#     javascript: false                    # (Optional) Enable JavaScript. Default: null
#     tls_protocol: "TLS1_2"              # (Optional) TLS1_0 | TLS1_1 | TLS1_2 | TLS1_3. Default: null
#     no_table_scan: false                # (Optional) Disable table scans. Default: null
#     oplog_size: 50                      # (Optional) Oplog size in MB. Default: null
#     oplog_retention: 30                 # (Optional) Oplog retention in hours. Default: null
#     bi:
#       sample_size: 1000                 # (Optional) BI Connector sample size. Default: null
#       refresh_interval: 60              # (Optional) BI Connector refresh interval in seconds. Default: null
#     transaction_lifetime: 30            # (Optional) Transaction lifetime in minutes. Default: null
#   backup:
#     enabled: false                      # (Optional) Enable cloud backup. Default: false
#     hour_of_day: 0                      # (Optional) Backup hour 0-23. Default: 0
#     minute_of_hour: 0                   # (Optional) Backup minute 0-59. Default: 0
#     restore_window_days: 1              # (Optional) Restore window in days. Default: 1
#     auto_export: false                  # (Optional) Enable automatic export. Default: false
#     export_prefix: ""                   # (Optional) Prefix for exported backup files. Default: null
#     hourly:
#       interval: 6                       # (Optional) Frequency in hours. Default: 1
#       retention_unit: "days"            # (Optional) days. Default: "days"
#       retention_value: 2                # (Optional) Retention value. Default: 1
#     daily:
#       interval: 1                       # (Optional) Frequency. Default: 1
#       retention_unit: "days"            # (Optional) days. Default: "days"
#       retention_value: 7                # (Optional) Retention value. Default: 7
#     weekly:
#       interval: 1                       # (Optional) Day of week 1-7. Default: 1
#       retention_unit: "weeks"           # (Optional) weeks. Default: "weeks"
#       retention_value: 4                # (Optional) Retention value. Default: 4
#     monthly:
#       interval: 1                       # (Optional) Day of month 1-28. Default: 1
#       retention_unit: "months"          # (Optional) months. Default: "months"
#       retention_value: 12               # (Optional) Retention value. Default: 12
#     yearly:
#       interval: 1                       # (Optional) Month of year 1-12. Default: 1
#       retention_unit: "years"           # (Optional) years. Default: "years"
#       retention_value: 2                # (Optional) Retention value. Default: 2
#     export:
#       cloud_provider: "AZURE"           # (Optional) Override export cloud provider: AWS | GCP | AZURE. Default: settings.cloud_provider
#       bucket_name: ""                   # (Required for AWS) S3 bucket name for export destination
#       iam_role_id: ""                   # (Required for AWS) IAM role ID (assumed role) for bucket access
#       service_url: "https://..."        # (Required for GCP/AZURE) Service URL for the export bucket
#       role_id: "role-id"               # (Required for GCP/AZURE) Role ID for bucket access
#       frecuency_type: "DAILY"           # (Optional) HOURLY | DAILY | WEEKLY | MONTHLY | YEARLY. Default: "DAILY"
#     copy:
#       cloud_provider: "AZURE"           # (Optional) Override cloud provider for copy settings. Default: settings.cloud_provider
#       frequencies: []                   # (Optional) List of snapshot frequency types to copy.
#       region_name: "US_EAST_2"          # (Optional) Target Atlas region for copy. Default: deployment region
#       copy_oplogs: false                # (Optional) Include oplogs in copy. Default: false
#   global:
#     zone_name: "Zone 1"               # (Optional) Zone name for the primary replication spec (GEOSHARDED). Default: null
#   regions:
#     - backing_provider: "AZURE"        # (Optional) Backing cloud provider for TENANT clusters: AWS | GCP | AZURE. Default: null
#       provider: "AZURE"                # (Optional) Atlas provider type: TENANT | AWS | GCP | AZURE. Default: "TENANT"
#       region: "US_EAST_2"              # (Required for AZURE) Atlas Azure region name. Must be set explicitly.
#                                        #   Note: var.region (e.g. "eastus2") is NOT auto-converted to Atlas format.
#                                        #   See Atlas docs for Azure region names: US_EAST_2, EUROPE_NORTH, etc.
#       priority: 7                      # (Optional) Electable node priority 1-7. Default: 7
#       electable:
#         size: "M10"                    # (Optional) Instance size for electable nodes. Default: "M2"
#         count: 3                       # (Optional) Number of electable nodes. Default: null
#         disk_size: 10                  # (Optional) Disk size in GB, set at spec level. Default: null
#       analytics:
#         size: "M10"                    # (Optional) Instance size for analytics nodes. Default: "M2"
#         count: 1                       # (Optional) Number of analytics nodes. Default: null
#         disk_size: 10                  # (Optional) Disk size in GB for analytics nodes. Default: null
#       read_only:
#         size: "M10"                    # (Optional) Instance size for read-only nodes. Default: "M2"
#         count: 0                       # (Optional) Number of read-only nodes. Default: null
#         disk_size: 10                  # (Optional) Disk size in GB for read-only nodes. Default: null
#       auto_scaling:
#         disk: false                    # (Optional) Enable disk auto-scaling. Default: false
#         compute: false                 # (Optional) Enable compute auto-scaling. Default: false
#         max_size: "M40"               # (Optional) Maximum instance size for compute auto-scaling. Default: null
#         min_size: "M10"               # (Optional) Minimum instance size for compute auto-scaling. Default: null
#         scale_down: false             # (Optional) Allow scale-down of compute. Default: false
#         analytics:
#           disk: false                 # (Optional) Enable disk auto-scaling for analytics nodes. Default: false
#           compute: false              # (Optional) Enable compute auto-scaling for analytics nodes. Default: false
#           max_size: "M40"            # (Optional) Maximum instance size for analytics auto-scaling. Default: null
#           min_size: "M10"            # (Optional) Minimum instance size for analytics auto-scaling. Default: null
#           scale_down: false          # (Optional) Allow scale-down for analytics. Default: false
#   shards:                              # (Optional) Additional shards for SHARDED / GEOSHARDED clusters. Default: []
#     - zone_name: "zone-1"             # (Optional) Zone name for this shard (required for GEOSHARDED). Default: null
#       regions:                         # (Optional) Region configs for this shard. Same structure as settings.regions.
#         - provider: "AZURE"
#           region: "EUROPE_WEST"
#           priority: 7
#           electable:
#             size: "M30"
#             count: 3
#             disk_size: 10
#   hoop:
#     enabled: false                              # (Optional) Enable hoop_connections output. Default: false.
#     community: true                             # (Optional) true=community (returns null for AzureRM), false=enterprise (_envs/azure/). Default: true.
#     agent_id: "xxxxxxxx-xxxx-xxxx-xxxx-xxxx"  # (Required when enabled+enterprise) Hoop.dev agent UUID. Replaces deprecated `agent`.
#     tags: {}                                    # (Optional) Tags map for the Hoop connection. Default: {}.
#     access_control: []                          # (Optional) Access control group list. Default: [].
#     import: false                               # (Optional) Import existing Hoop connection instead of creating. Default: false.
variable "settings" {
  description = "Settings for the MongoDB Atlas cluster and Azure integrations"
  type        = any
  default     = {}
}
