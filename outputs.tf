output "billing_alarm_id" {
  description = "Billing alarm id"
  value       = "${aws_cloudwatch_metric_alarm.this.*.id}"
}

output "billing_alarm_arn" {
  description = "Billing alarm ARN"
  value       = "${aws_cloudwatch_metric_alarm.this.*.arn}"
}
