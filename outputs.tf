# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

output "all_server_ids" {
  value = data.null_data_source.values.outputs["all_server_ids"]
}

output "all_server_ips" {
  value = data.null_data_source.values.outputs["all_server_ips"]
}

