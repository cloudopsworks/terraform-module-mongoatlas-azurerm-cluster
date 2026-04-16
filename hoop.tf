##
# (c) 2021-2026
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

locals {
  hoop_enabled     = try(var.settings.hoop.enabled, false) && try(var.settings.admin_user.enabled, false)
  hoop_enterprise  = local.hoop_enabled && !try(var.settings.hoop.community, true)
  hoop_secret_name = replace(
    format("%s-mongodbatlas-%s-admin-conn-string",
      replace(local.secret_store_path, "/", "-"),
      module.cluster.cluster_name
    ),
    "/[^a-zA-Z0-9-]/", "-"
  )
}

# Standalone connection-string secret required for Hoop enterprise (_envs/azure/<secret-name>).
# Azure Key Vault does not support sub-key access; the full credentials JSON cannot be used directly.
resource "azurerm_key_vault_secret" "atlas_cred_conn_string" {
  count        = local.hoop_enterprise ? 1 : 0
  name         = local.hoop_secret_name
  value        = module.cluster.cluster_credentials.connection_string
  key_vault_id = data.azurerm_key_vault.atlas_cred[0].id
  content_type = "text/plain"
  tags         = local.all_tags

  lifecycle {
    ignore_changes = [value]
  }
}

output "hoop_connections" {
  description = <<-EOD
    Hoop connection definition for the cluster admin user.
    Returns null in community mode — Azure Key Vault has no native Hoop community provider.
    Enterprise mode: pass directly as the `connections` input to terraform-module-hoop-connection.
    Note: terraform-module-hoop-connection manages connections via the Hoop provider; ensure your
    Hoop agent has access to retrieve secrets from Azure Key Vault.
  EOD
  value = local.hoop_enterprise ? {
    "admin" = {
      name           = "mongo-db-${lower(module.cluster.cluster_name)}-ow"
      agent_id       = var.settings.hoop.agent_id
      type           = "database"
      subtype        = "mongodb"
      tags           = try(var.settings.hoop.tags, {})
      access_control = toset(try(var.settings.hoop.access_control, []))
      access_modes = {
        connect  = "enabled"
        exec     = "enabled"
        runbooks = "enabled"
        schema   = "enabled"
      }
      import  = try(var.settings.hoop.import, false)
      secrets = {
        "envvar:CONNECTION_STRING" = "_envs/azure/${azurerm_key_vault_secret.atlas_cred_conn_string[0].name}"
      }
    }
  } : null

  precondition {
    condition     = !local.hoop_enterprise || try(var.settings.hoop.agent_id, "") != ""
    error_message = "settings.hoop.agent_id must be set (as a Hoop agent UUID) when settings.hoop.enabled is true and settings.hoop.community is false."
  }
}
