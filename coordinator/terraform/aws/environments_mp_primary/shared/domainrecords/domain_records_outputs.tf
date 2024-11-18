# Copyright 2023 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

########################
# DO NOT EDIT MANUALLY #
########################

# This file is meant to be shared across all environments (either copied or
# symlinked). In order to make the upgrade process easier, this file should not
# be modified for environment-specific customization.

output "domain_name" {
  description = "Domain name to create Route53 hosted zone for."
  value       = var.domain_name
}

output "name_servers" {
  description = <<EOT
        Domain record nameservers associated with the zone generated by this module.
        To be added as NS records to the DNS provider which manages var.domain_name.
        EOT
  value       = module.domainrecords.name_servers
}
