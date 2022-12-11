provider "fortios" { }

module "fg1-vpn" {

    source              = "./modules/ipsec_vpn"
    
    # IPsec VPN Phase1-interface 설정
    name                = "fg1-vpn"
    interface           = "wan1"
    ike_version         = "2"            # default = 1
    keylife             = "28800"        # default = 86400
    mode                = "main"         # default = main
    peertype            = "any"          # default = any
    net_device	        = "disable"      # default = disable
    proposal_phase1     = "aes256-sha1"  # default = aes128-sha256 aes256-sha256 aes128-sha1 aes256-sha1
    dpd                 = "on-idle"      # default = on-demand  
    dhgrp_phase1        = "2"            # default = 14 5
    nattraversal        = "enable"       # default = enable
    remote_gw           = "1.1.2.2"
    psksecret	        = "PreSharedKey"
    dpd_retryinterval   = "10"           # default = 20
    
    # IPsec VPN Phase2-interface 설정
    proposal_phase2	= "aes256-sha1"
    pfs			= "enable"       # default = enable
    dhgrp_phase2        = "2"            # default = 14 5
    replay              = "enable"       # default = enable
    keepalive           = "disable"      # default = disable
    auto_negotiate      = "enable"       # default = disable
    keylifeseconds	= "27000"        # default = 43200

    # System Interface 설정
    ip                  = "2.2.1.1 255.255.255.255"
    remote_ip           = "2.2.1.2 255.255.255.252"
    allowaccess         = "ping"         # default = unset allowaccess
    tcp_mss             = "1350"         # default = 0
    enable_mtu_override = "0"            # if value is true, set enable below value
    mtu_override        = "disable"      # default = disable
    mtu                 = "1500"         # default = 1500
}
