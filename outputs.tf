output "tfe_notification_configuration_id" {
  value       = [for config in tfe_notification_configuration.this : config.id]
  description = "The id's of the TFE workspace notification configurations"
}

output "tfe_notification_configuration_name" {
  value       = [for config in tfe_notification_configuration.this : config.name]
  description = "The names of the TFE workspace notification configurations"
}
