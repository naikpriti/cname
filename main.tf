resource "azurerm_dns_zone" "primary_child" {
  name                = "${local.dns.primary_prefix}.${local.dns.domain}"
  resource_group_name = "test-grp"
}

  
resource "azurerm_dns_cname_record" "record" {
  for_each            = local.dns.cname_records
  name                = each.key
  zone_name           = local.dns.domain
  resource_group_name = "test-grp"
  ttl                 = 300
  record              = each.value.record
}
