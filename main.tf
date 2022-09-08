resource "azurerm_dns_zone" "primary_child" {
  name                = "${local.dns.primary_prefix}.${local.dns.domain}"
  resource_group_name = local.dns.resource_group_name
  tags                = module.primary_metadata.tags
}

     
resource "azurerm_dns_ns_record" "primary_child" {
  name                = local.dns.primary_prefix
  zone_name           = local.dns.domain
  resource_group_name = local.dns.resource_group_name
  ttl                 = 300
  tags                = module.primary_metadata.tags
  records             = azurerm_dns_zone.primary_child.name_servers
}
  
resource "azurerm_dns_cname_record" "record" {
  for_each            = local.dns.cname_records
  name                = each.key
  zone_name           = local.dns.domain
  resource_group_name = local.dns.resource_group_name
  ttl                 = 300
  record              = each.value.record
}
