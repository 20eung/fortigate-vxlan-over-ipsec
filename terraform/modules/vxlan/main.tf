terraform {
  required_providers {
    fortios = {
      source      = "fortinetdev/fortios"
    }
  }
}

# IPsec VPN Phase1-interface 설정
resource "fortios_system_vxlan" "default" {
  name            = var.name

  dstport         = var.dstport
  interface       = var.interface
  ip_version      = var.ip_version
  remote_ip {
    ip            = var.remote_ip
  }
  vni             = var.vni
}
