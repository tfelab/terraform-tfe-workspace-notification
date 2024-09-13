###############################
# CONFIGURE WORKSPACE NOTIFICATIONS
###############################

data "tfe_workspace" "this" {
  for_each = { for config in var.workspace_notifications.configs : config.name => config }

  name         = each.value.workspace
  organization = var.workspace_notifications.organization
}

resource "tfe_notification_configuration" "this" {
  for_each = { for config in var.workspace_notifications.configs : config.name => config }

  name             = each.value.name
  destination_type = each.value.destination_type
  email_addresses  = length(each.value.email_addresses) > 0 ? each.value.email_addresses : null
  email_user_ids   = length(each.value.email_user_ids) > 0 ? each.value.email_user_ids : null
  enabled          = each.value.enabled
  token            = each.value.token
  triggers         = each.value.triggers
  url              = each.value.url
  workspace_id     = data.tfe_workspace.this[each.value.name].id
}
