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
  description = "Description for the environment, e.g. dev, staging, production"
  type        = string
}

variable "allowed_principals_set" {
  type        = set(string)
  description = "Set of AWS account IDs, that will assume the coordinator_assume_role."
}

variable "private_key_encryptor_arn" {
  description = "KMS key which will be used to decrypt"
  type        = string
}

variable "private_key_api_gateway_arn" {
  description = "API Gateway used to access the private key service, if empty, no policy is added"
  type        = string
}

variable "privacy_budget_api_gateway_arn" {
  description = "API Gateway used to access the privacy budget service, if empty, no policy is added"
  type        = string
}

variable "attestation_condition_keys" {
  description = "AWS Condition Keys for Nitro Enclaves. Map key defines Condition key type, while list defines acceptable hashes."
  type        = map(list(string))
}

variable "attestation_pcr_allowlist" {
  description = <<-EOT
    List of PCR0s to allowlist for Nitro Enclave attestation.
    If list is empty, then no condition is applied and any enclave can decrypt with the assume_role.
    EOT
  type        = list(string)
}
