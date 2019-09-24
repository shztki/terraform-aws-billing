# terraform-aws-billing

* Billing alarm を作成する。
  * `billing_alarm_actions_arn` には `us-east-1` で作成した `TopicArn` を指定する必要があるので注意。

## Usage:
```
module "sns_myself" {
  source             = "git::https://github.com/shztki/terraform-aws-snsemail.git?ref=1.0.0"
  topic_name         = "notification-myself"
  topic_display_name = "notification-myself"
  emails             = ["myself@exapmle.com", "myself2@example.com"]
}

module "billing_alarm" {
  source                    = "git::https://github.com/shztki/terraform-aws-billing.git?ref=1.0.0"
  billing_name              = "my billing"
  billing_threshold         = [1, 50, 100]
  billing_alarm_actions_arn = ["${module.sns_myself.sns_topic_arn}"]
  billing_period            = "21600"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| billing\_alarm\_actions\_arn | List of alarm action arn. | list | n/a | yes |
| billing\_name | A prefix name for Alarm. | string | n/a | yes |
| billing\_period | The period, in seconds, over which the statistic is applied. | string | `"21600"` | no |
| billing\_threshold | List of thresholds. | list | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| billing\_alarm\_arn | Billing alarm ARN |
| billing\_alarm\_id | Billing alarm id |
