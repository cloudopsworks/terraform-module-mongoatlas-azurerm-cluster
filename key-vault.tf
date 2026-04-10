##
# (c) 2021-2026
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

locals {
  secret_name_azure = replace(
    format("%s-mongodbatlas-%s-admin",
      replace(local.secret_store_path, "/", "-"),
      module.cluster.cluster_name
    ),
    "/[^a-zA-Z0-9-]/", "-"
  )
}

data "azurerm_key_vault" "atlas_cred" {
  count               = try(var.settings.admin_user.enabled, false) ? 1 : 0
  name                = var.settings.admin_user.key_vault_name
  resource_group_name = var.settings.admin_user.key_vault_resource_group
}

resource "azurerm_key_vault_secret" "atlas_cred" {
  count        = try(var.settings.admin_user.enabled, false) ? 1 : 0
  name         = local.secret_name_azure
  value        = jsonencode(module.cluster.cluster_credentials)
  key_vault_id = data.azurerm_key_vault.atlas_cred[0].id

  content_type = "application/json"

  tags = local.all_tags

  lifecycle {
    ignore_changes = [
      value
    ]
  }
}
