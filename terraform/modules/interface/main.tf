terraform {
  required_providers {
    fortios = {
      source            = "fortinetdev/fortios"
    }
  }
}

# IPsec VPN Phase1-interface 설정
resource "fortios_system_interface" "default" {
  name                  = var.name
  vdom                  = var.vdom

  device_identification = var.device_identification
  role                  = var.role
  interface             = var.interface
  vlanid                = var.vlanid

  ip                    = var.ip
  remote_ip             = var.remote_ip
  allowaccess           = var.allowaccess
  
  tcp_mss               = var.tcp_mss
  mtu_override          = var.mtu_override
  mtu                   = var.mtu

  fail_detect           = var.fail_detect
  fail_detect_option    = var.fail_detect_option
  fail_alert_method     = var.fail_alert_method
  
  dynamic "fail_alert_interfaces" {
    for_each = var.fail_alert_interfaces
    content {
      # name - (optional) is a type of string
      name = fail_alert_interfaces.value["name"]
    }
  }

  autogenerated         = var.autogenerated
}
