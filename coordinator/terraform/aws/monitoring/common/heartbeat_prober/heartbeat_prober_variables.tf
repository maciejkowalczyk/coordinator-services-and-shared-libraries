# Copyright 2023 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

variable "aws_region" {
  description = "AWS region where to deploy resources."
  type        = string
}

variable "environment" {
  description = "Environment, This should match/coorelate to the name of the environment of the enpoint being probed. Valid characters are lowercase alphanumeric, hyphen, or underscore. var.environment along with var.heartbeat_name_prefix must have maximum length of 21 characters."
  type        = string
}

variable "heartbeat_name" {
  description = "Heartbeat prober name. Valid characters are lowercase alphanumeric and underscore."
  type        = string
}

variable "heartbeat_name_prefix" {
  description = "(Optional) Heartbeat prober name prefix, defaults to var.alert_service_label. Valid characters are lowercase alphanumeric, hyphen, or underscore. var.heartbeat_name_prefix along with var.environment must have maximum length of 21 characters."
  type        = string
  default     = ""
}

variable "heartbeat_handler" {
  description = "Heartbeat prober code handler name and path for invocaying the heartbeat function. Example: heartbeat/pbs_heartbeat.handler."
  type        = string
}

variable "heartbeat_source_zip" {
  description = "Location of the zip file containing the prober code."
  type        = string
}

variable "heartbeat_timeout_sec" {
  description = "Number of seconds the canary is allowed to run before it must stop. Up to a maximum of 840 (14 minutes)."
  type        = number
}

variable "heartbeat_schedule_expression" {
  description = "Rate expression or cron expression that defines how often the canary is to run. For rate expression, the syntax is rate(number unit). unit can be minute, minutes, or hour. For cron expression, the syntax is cron(expression)."
  type        = string
}

variable "allowed_assume_role" {
  description = "(Optional) Allowed assume role to attach to synthetic canary role for additional privileges."
  type        = string
  default     = ""
}

variable "url_to_probe" {
  description = "Coordinator endpoint API url being probed."
  type        = string
}

################################################################################
# Alarm Variables.
################################################################################

variable "alarms_enabled" {
  description = "Enable alarms for services."
  type        = bool
  default     = false
}

variable "alarms_eval_periods" {
  description = "The number of periods over which the Sum of SuccessPercent is compared to the specified threshold."
  type        = number
}

variable "alarms_threshold" {
  description = "The value against which the Sum of SuccessPercent is compared."
  type        = number
}

variable "alarms_eval_period_sec" {
  description = "The period in seconds over which the specified statistic(Sum) is applied. Valid values are 10, 30, or any multiple of 60."
  type        = number
}

variable "alarms_notification_email" {
  description = "Email to receive alarms for services."
  type        = string
  default     = ""
}

variable "alarms_sns_topic_arn" {
  description = "SNS topic ARN to forward alerts to"
  type        = string
}

variable "alarms_sqs_queue_arn" {
  description = "SQS queue ARN to forward alerts to"
  type        = string
}

variable "alarms_service_label" {
  description = "Alarm service label for alarm name."
  type        = string
}

variable "custom_alarm_label" {
  description = "Add any string to the label to help filtering, allowed chars (a-zA-Z_-) max 30 chars"
  type        = string
}

variable "alarms_priority" {
  description = "Priority to describe an Alarm"
  type        = string
  default     = "Warning"

  validation {
    condition     = contains(["Critical", "Error", "Warning", "Info", "Debug"], var.alarms_priority)
    error_message = "Valid values for var: alarm_priority are Critical, Error, Warning, Info, Debug"
  }
}
