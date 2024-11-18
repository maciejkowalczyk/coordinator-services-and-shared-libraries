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

################################################################################
# Global Variables
################################################################################

variable "environment" {
  description = "environment where this service is deployed. Eg: dev/prod, etc"
  type        = string
}

################################################################################
# API Gateway Variables
################################################################################

variable "name" {
  description = "Name for this API gateway"
  type        = string
}

variable "api_env_stage_name" {
  description = "Stage name for API gateway instances. Must match across environment"
  type        = string
}

variable "api_gateway_logging_retention_days" {
  description = "Number of days to keep logs in Cloudwatch"
  type        = number
}
