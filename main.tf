##
# (c) 2021-2026
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

module "cluster" {
  source = "git::https://github.com/cloudopsworks/terraform-module-mongoatlas-cluster.git?ref=v1.2.1"

  is_hub         = var.is_hub
  spoke_def      = var.spoke_def
  org            = var.org
  extra_tags     = var.extra_tags
  name_prefix    = var.name_prefix
  name           = var.name
  project_id     = var.project_id
  project_name   = var.project_name
  cloud_provider = var.cloud_provider
  run_hoop       = var.run_hoop
  # Azure region names (e.g. "eastus2") do not map 1:1 to Atlas region names.
  # Use settings.regions[].region to specify Atlas region names explicitly (e.g. "US_EAST_2").
  region   = var.region
  settings = var.settings
}
