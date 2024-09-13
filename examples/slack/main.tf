module "tfe-workspace-notification" {
  source = "../.."

  tfe_token = var.token

  workspace_notifications = {
    organization = "tfelab"
    configs = [
      {
        name             = "ecommerce-dev-aws-slack-deployment-state"
        destination_type = "slack"
        enabled          = true
        triggers         = ["run:completed", "run:errored"]
        url              = "https://hooks.slack.com/services/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"
        workspace        = "ecommerce-dev-aws"
      },
      {
        name             = "ecommerce-dev-aws-slack-assessment-failure-drift-detection"
        destination_type = "slack"
        enabled          = true
        triggers         = ["assessment:drifted", "assessment:failed"]
        url              = "https://hooks.slack.com/services/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"
        workspace        = "ecommerce-dev-aws"
      },
      {
        name             = "ecommerce-dev-aws-slack-workspace-autodestroy"
        destination_type = "slack"
        enabled          = true
        triggers         = ["workspace:auto_destroy_reminder", "workspace:auto_destroy_run_results"]
        url              = "https://hooks.slack.com/services/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"
        workspace        = "ecommerce-dev-aws"
      }
    ]
  }
}
