/**
 * ## Usage:
 * ```
 * module "sns_myself" {
 *   region             = "us-east-1"
 *   source             = "git::https://github.com/shztki/terraform-aws-snsemail.git?ref=1.0.0"
 *   topic_name         = "notification-myself"
 *   topic_display_name = "notification-myself"
 *   emails             = ["myself@exapmle.com", "myself2@example.com"]
 * }
 * 
 * module "billing_alarm" {
 *   source                    = "git::https://github.com/shztki/terraform-aws-billing.git?ref=1.0.0"
 *   billing_name              = "my billing"
 *   billing_threshold         = [1, 50, 100]
 *   billing_alarm_actions_arn = ["${module.sns_myself.sns_topic_arn}"]
 *   billing_period            = "21600"
 * }
 * ```
 */

provider "aws" {
  region = "us-east-1"
  alias  = "us-east-1"
}

resource "aws_cloudwatch_metric_alarm" "this" {
  provider            = "aws.us-east-1"
  alarm_name          = "${var.billing_name} lv.${count.index + 1} (${var.billing_threshold[count.index]} USD)"
  namespace           = "AWS/Billing"
  metric_name         = "EstimatedCharges"
  statistic           = "Maximum"
  evaluation_periods  = "1"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  period              = "${var.billing_period}"
  threshold           = "${var.billing_threshold[count.index]}"

  dimensions = {
    "Currency" = "USD"
  }

  alarm_description = "Total Charge ${var.billing_threshold[count.index]} USD"
  alarm_actions     = "${var.billing_alarm_actions_arn}"
  count             = "${length(var.billing_threshold)}"
}
