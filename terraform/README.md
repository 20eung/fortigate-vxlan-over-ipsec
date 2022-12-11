# Terraform Source

```
# filename: main.tf

provider "fortios" { }


module "fg1-vpn" {

    source                = "./modules/ipsec_vpn"
    
    ### IPsec VPN Phase1-interface 설정
    name                  = "fg1-vpn"
    interface             = "wan1"
    proposal_phase1       = "aes256-sha1"  # default = aes128-sha256 aes256-sha256 aes128-sha1 aes256-sha1
    remote_gw             = "1.1.2.2"
    psksecret	          = "PreSharedKey"
    
    ### IPsec VPN Phase2-interface 설정
    proposal_phase2       = "aes256-sha1"
    auto_negotiate        = "enable"       # default = disable

    ### System Interface 설정
    vdom                  = "root"         # default = "root"
    ip                    = "2.2.1.1 255.255.255.255"
    remote_ip             = "2.2.1.2 255.255.255.252"
    allowaccess           = "ping"         # default = unset allowaccess
}

module "vlan10" {
    source                = "./modules/interface"

    name                  = "vlan10"
    vdom                  = "root"         # default = "root"
    device_identification = "enable"
    role                  = "lan"
    interface             = "internal1"
    vlanid                = 10             # range   = 1 - 4094
}

module "vlan20" {
    source                = "./modules/interface"

    name                  = "vlan20"
    vdom                  = "root"         # default = "root"
    device_identification = "enable"
    role                  = "lan"
    interface             = "internal1"
    vlanid                = 20             # range   = 1 - 4094
}

module "vxlan10" {
    source                = "./modules/vxlan"

    name                  = "vxlan.10"
    interface             = "fg1-vpn"
    vni                   = 10
    remote_ip             = "2.2.1.2"

    depends_on             = [ module.vlan10 ]
}

module "vxlan20" {
    source                = "./modules/vxlan"

    name                  = "vxlan.20"
    interface             = "fg1-vpn"
    vni                   = 20
    remote_ip             = "2.2.1.2"

    depends_on            = [ module.vlan20 ]
}

module "vxlan10svi" {
    source                = "./modules/switch-interface"

    name                  = "vxlan10"
    vdom                  = "root"         # default = "root"
    member                = [ 
      { interface_name    = "vlan10" },
      { interface_name    = "vxlan.10" }
    ]

    depends_on             = [ module.vxlan10 ]
}

module "vxlan20svi" {
    source                = "./modules/switch-interface"

    name                  = "vxlan20"
    vdom                  = "root"         # default = "root"
    member                = [ 
      { interface_name    = "vlan20" },
      { interface_name    = "vxlan.20" }
    ]

    depends_on            = [ module.vxlan20 ]
}
```
