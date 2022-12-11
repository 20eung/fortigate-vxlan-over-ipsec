terraform {
  required_providers {
    fortios = {
      source      = "fortinetdev/fortios"
    }
  }
}

# IPsec VPN Phase1-interface 설정
resource "fortios_system_switchinterface" "default" {
  name                = var.name
  vdom                = var.vdom
  dynamic "member" {
    for_each = var.member
    content {
      interface_name = member.value["interface_name"]
    }
  }
  type                = var.type
  intra_switch_policy = var.intra_switch_policy
  mac_ttl             = var.mac_ttl
  span                = var.span
}
