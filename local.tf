locals {
  environment_variables = yamldecode(file("${path.module}/vars/${var.github_branch}.yml"))
}


locals {
  dns = local.environment_variables.dns
  cname = { for k, cname_records in local.dns.cname_records : k => azurerm_dns_cname_record.record[k] }
}
