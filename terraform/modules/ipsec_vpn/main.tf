terraform {
  required_providers {
    fortios = {
      source	    = "fortinetdev/fortios"
    }
  }
}

# IPsec VPN Phase1-interface 설정
resource "fortios_vpnipsec_phase1interface" "default" {
  name              = var.name
  interface         = var.interface
  ike_version       = var.ike_version
  keylife           = var.keylife
  mode              = var.mode
  peertype          = var.peertype
  net_device	    = var.net_device
  proposal          = var.proposal_phase1
  dpd               = var.dpd
  dhgrp             = var.dhgrp_phase1
  nattraversal      = var.nattraversal
  remote_gw         = var.remote_gw
  psksecret         = var.psksecret
  dpd_retryinterval = var.dpd_retryinterval
}


# IPsec VPN Phase2-interface 설정
resource "fortios_vpnipsec_phase2interface" "default" {
  name	            = var.name
  phase1name        = var.name
  proposal          = var.proposal_phase2
  pfs               = var.pfs
  dhgrp             = var.dhgrp_phase2
  replay            = var.replay
  keepalive         = var.keepalive
  auto_negotiate    = var.auto_negotiate
  keylifeseconds    = var.keylifeseconds
}

resource "fortios_system_interface" "mtu_override" {
    count           = var.enable_mtu_override

    name            = var.name
    vdom            = var.vdom
    ip              = var.ip
    allowaccess     = var.allowaccess
    tcp_mss         = var.tcp_mss
    remote_ip       = var.remote_ip
    mtu_override    = var.mtu_override
    mtu             = var.mtu
}

resource "fortios_system_interface" "default" {
    count           = var.enable_mtu_override

    name            = var.name
    vdom            = var.vdom
    ip              = var.ip
    allowaccess     = var.allowaccess
    tcp_mss         = var.tcp_mss
    remote_ip       = var.remote_ip
}
