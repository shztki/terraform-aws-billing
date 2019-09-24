variable "billing_name" {
  type        = "string"
  description = "A prefix name for Alarm."
}

variable "billing_threshold" {
  type        = "list"
  description = "List of thresholds."
}

variable "billing_alarm_actions_arn" {
  type        = "list"
  description = "List of alarm action arn."
}

variable "billing_period" {
  type        = "string"
  description = "The period, in seconds, over which the statistic is applied."
  default     = "21600"
}
