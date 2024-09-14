variable "tfe_token" {
  description = "The Terraform Cloud API token"
  sensitive   = true
  type        = string
}

variable "workspace_notifications" {
  description = "List of workspace notifications and their configurations"

  type = object({
    organization = string

    configs = optional(list(object({
      name             = string
      destination_type = string
      email_addresses  = optional(list(string), [])
      email_user_ids   = optional(list(string), [])
      enabled          = optional(bool, false)
      token            = optional(string, null)
      triggers         = optional(list(string), [])
      url              = string
      workspace        = string
    })), [])
  })

  validation {
    condition = alltrue([
      for config in var.workspace_notifications.configs :
      contains(["email", "generic", "microsoft-teams", "slack"], config.destination_type)
    ])
    error_message = "'destination_type' must be one of 'email', 'generic', 'microsoft-teams' or 'slack'."
  }

  validation {
    condition = alltrue([
      for config in var.workspace_notifications.configs :
      contains(["generic", "microsoft-teams", "slack"], config.destination_type)
      && length(config.email_addresses) == 0
    ])
    error_message = "The 'email_addresses' value must not be provided if 'destination_type' is 'generic', 'microsoft-teams', or 'slack'."
  }

  validation {
    condition = alltrue([
      for config in var.workspace_notifications.configs :
      contains(["generic", "microsoft-teams", "slack"], config.destination_type)
      && length(config.email_user_ids) == 0
    ])
    error_message = "The 'email_user_ids' value must not be provided if 'destination_type' is 'generic', 'microsoft-teams', or 'slack'."
  }

  validation {
    condition = alltrue([
      for config in var.workspace_notifications.configs :
      contains(["email", "microsoft-teams", "slack"], config.destination_type)
      && config.token == null
    ])
    error_message = "The 'token' value must not be provided if 'destination_type' is 'email', 'microsoft-teams', or 'slack'."
  }

  validation {
    condition = alltrue([
      for config in var.workspace_notifications.configs :
      alltrue([
        for email in config.email_addresses :
        can(regex("^\\S+@\\S+\\.\\S+$", email))
      ])
    ])
    error_message = "'email_addresses' must be valid email addresses in the format 'user@example.com'."
  }

  validation {
    condition = alltrue([
      for config in var.workspace_notifications.configs : alltrue([
        for trigger in config.triggers :
        contains([
          "assessment:check_failure",
          "assessment:drifted",
          "assessment:failed",
          "run:applying",
          "run:completed",
          "run:created",
          "run:errored",
          "run:needs_attention",
          "run:planning",
          "workspace:auto_destroy_reminder",
          "workspace:auto_destroy_run_results"
        ], trigger)
      ])
    ])
    error_message = "'triggers' must be one of 'assessment:check_failure', 'assessment:drifted', 'assessment:failed', 'run:applying', 'run:completed', 'run:created', 'run:errored', 'run:needs_attention', 'run:planning', 'workspace:auto_destroy_reminder', or 'workspace:auto_destroy_run_results'."
  }

  validation {
    condition = alltrue([
      for config in var.workspace_notifications.configs :
      can(regex("^(https?|ftp)://[^\\s/$.?#].[^\\s]*$", config.url))
    ])
    error_message = "'url' must be a valid URL."
  }

  default = {
    organization = ""
    configs      = []
  }
}
