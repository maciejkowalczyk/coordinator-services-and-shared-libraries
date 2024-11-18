# Copyright 2022 Google LLC
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

variable "environment" {
  description = "environment where this service is deployed. Eg: dev/prod, etc"
  type        = string
}

variable "sns_topic_arn" {
  description = "SNS topic ARN to forward alerts to"
  type        = string
}

variable "api_gateway_id" {
  description = "ID of the ApiGatewayV2 endpoint to create alarms for"
  type        = string
}

variable "api_name" {
  description = "Name of the APIGatewayV2 endpoint -- used for naming alarms."
  type        = string
}

variable "custom_alarm_label" {
  description = "Add any string to the label to help filtering, allowed chars (a-zA-Z_-) max 30 chars"
  type        = string
}

################################################################################
# Alarm Variables.
################################################################################

variable "max_latency_eval_periods" {
  description = "Evaluation Periods: is the number of the most recent periods, or data points, to evaluate when determining alarm state. Example: '5'."
  type        = string
}

variable "max_latency_ms_threshold" {
  description = "API Gateway max latency to send alarm. Measured in milliseconds. Example: '5000'."
  type        = string
}

variable "error_ratio_4xx_eval_periods" {
  description = "Evaluation Periods: is the number of the most recent periods, or data points, to evaluate when determining alarm state. Example: '5'."
  type        = string
}

variable "error_ratio_4xx_threshold" {
  description = "API Gateway 4xx error ratio rate greater than this to send alarm. Must be in decimal form: 10% = 0.10. Example: '0.0'."
  type        = string
}

variable "error_ratio_5xx_eval_periods" {
  description = "Evaluation Periods: is the number of the most recent periods, or data points, to evaluate when determining alarm state. Example: '5'."
  type        = string
}

variable "error_ratio_5xx_threshold" {
  description = "API Gateway 5xx error ratio rate greater than this to send alarm. Must be in decimal form: 10% = 0.10. Example: '0.0'."
  type        = string
}
