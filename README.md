# TFE Workspace Notification Terraform module

Terraform module to manage Terraform Enterprise workspace notifications.

## Usage

[Generating user token](https://app.terraform.io/app/settings/tokens)

### Complete

```hcl
module "tfe-workspace-notification" {
  source = "tfelab/workspace-notification/tfe"

  tfe_token = var.token

  workspace_notifications = {
    organization = "tfelab"
    configs = [
      {
        name             = "ecommerce-dev-aws-slack-deployment-state"
        destination_type = "slack"
        enabled          = true
        triggers         = ["run:completed", "run:errored"]
        url              = "https://hooks.slack.com/services/xxxxxxxxxxx/xxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxx"
        workspace        = "ecommerce-dev-aws"
      },
      {
        name             = "ecommerce-dev-aws-slack-assessment-failure-drift-detection"
        destination_type = "slack"
        enabled          = true
        triggers         = ["assessment:drifted", "assessment:failed"]
        url              = "https://hooks.slack.com/services/xxxxxxxxxxx/xxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxx"
        workspace        = "ecommerce-dev-aws"
      },
      {
        name             = "ecommerce-dev-aws-slack-workspace-autodestroy"
        destination_type = "slack"
        enabled          = true
        triggers         = ["workspace:auto_destroy_reminder", "workspace:auto_destroy_run_results"]
        url              = "https://hooks.slack.com/services/xxxxxxxxxxx/xxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxx"
        workspace        = "ecommerce-dev-aws"
      }
    ]
  }
}
```

## Examples

- [Slack](https://github.com/tfelab/terraform-tfe-workspace-notification/tree/main/examples/slack)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 0.12 |
| <a name="requirement_tfe"></a> [tfe](#requirement_tfe) | >= 0.58.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_tfe"></a> [tfe](#provider_tfe) | >= 0.58.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [tfe_notification_configuration.this](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/notification_configuration) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_tfe_token"></a> [tfe_token](#input_tfe_token) | The token use in connecting to TFE | `string` | `null` | yes |
| <a name="input_workspace_notifications"></a> [workspace_notifications](#input_workspace_notifications) | List of workspace notifications and their configuration | `list` | [] | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_tfe_notification_configuration_id"></a> [tfe_notification_configuration_id](#output_tfe_notification_configuration_id) | The id's of the TFE workspace notifications |
| <a name="output_tfe_notification_configuration_name"></a> [tfe_notification_configuration_name](#output_tfe_notification_configuration_name) | The names of the TFE workspace notifications |

## Authors

Module is maintained by [John Ajera](https://github.com/jajera).

## License

MIT Licensed. See [LICENSE](https://github.com/tfelab/terraform-tfe-workspace-notification/tree/main/LICENSE) for full details.
