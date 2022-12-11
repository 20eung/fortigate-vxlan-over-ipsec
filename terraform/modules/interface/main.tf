terraform {
  required_providers {
    fortios = {
      source	    = "fortinetdev/fortios"
    }
  }
}

# IPsec VPN Phase1-interface 설정
resource "fortios_system_interface" "default" {
  name            = var.name
  vdom            = var.vdom

  device_identification = var.device_identification
  role            = var.role
  interface       = var.interface
  vlanid          = var.vlanid

  ip              = var.ip
  remote_ip       = var.remote_ip
  allowaccess     = var.allowaccess
  
  tcp_mss         = var.tcp_mss
  mtu_override    = var.mtu_override
  mtu             = var.mtu

  autogenerated   = var.autogenerated
  depends_on      = [ var.dependson ]
}
