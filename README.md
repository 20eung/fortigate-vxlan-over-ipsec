# 포티게이트 장비에서 VxLAN over IPsec 구현(다중 VLAN)

## 구성도
![Diagram](./img/diagram.png "Diagram")

## 1. WAN 인터페이스 설정

<table>
<tr>
  <td>FG#1</td>
  <td>FG#2</td>
</tr>
<tr>
  <td>

```
config system interface
  edit "wan1"
    set vdom "root"
    set ip 1.1.1.1 255.255.255.0
    set allowaccess ping fgfm
    set type physical
    set role wan
  next
end
```

  </td>
  <td>

```
config system interface
  edit "wan1"
    set vdom "root"
    set ip 1.1.1.2 255.255.255.0
    set allowaccess ping fgfm
    set type physical
    set role wan
  next
end
```

  </td>
</tr>
</table>


## 2. IPsec VPN 터널 설정

<table>
<tr>
  <td>FG#1</td>
  <td>FG#2</td>
</tr>
<tr>
  <td>

```
config vpn ipsec phase1-interface
  edit "fg1-vpn"
    set interface "wan1"
    set peertype any
    set net-device disable
    set proposal aes256-sha1
    set remote-gw 1.1.1.2
    set psksecret PreSharedKey
  next
end

config vpn ipsec phase2-interface
  edit "fg1-vpn"
    set phase1name "fg1-vpn"
    set proposal aes256-sha1
    set auto-negotiate enable
  next
end

config system interface
  edit "fg1-vpn"
    set vdom "root"
    set ip 2.2.2.2 255.255.255.255
    set allowaccess ping
    set type tunnel
    set remote-ip 2.2.2.1 255.255.255.252
    set interface "wan1"
  next
end
```

  </td>
  <td>

```
config vpn ipsec phase1-interface
  edit "fg2-vpn"
    set interface "wan1"
    set peertype any
    set net-device disable
    set proposal aes256-sha1
    set remote-gw 1.1.1.1
    set psksecret PreSharedKey
  next
end

config vpn ipsec phase2-interface
  edit "fg2-vpn"
    set phase1name "fg2-vpn"
    set proposal aes256-sha1
    set auto-negotiate enable
  next
end

config system interface
  edit "fg2-vpn"
    set vdom "root"
    set ip 2.2.2.1 255.255.255.255
    set allowaccess ping
    set type tunnel
    set remote-ip 2.2.2.2 255.255.255.252
    set interface "wan1"
  next
end
```

  </td>
</tr>
</table>



## 3. VLAN 인터페이스 설정

<table>
<tr>
  <td>FG#1</td>
  <td>FG#2</td>
</tr>
<tr>
  <td>

```
config system interface
  edit "vlan10"
    set vdom "root"
    set device-identification enable
    set role lan
    set interface "internal1"
    set vlanid 10
  next
  edit "vlan20"
    set vdom "root"
    set device-identification enable
    set role lan
    set interface "internal1"
    set vlanid 20
  next
end  
```

  </td>
  <td>

```
config system interface
  edit "vlan10"
    set vdom "root"
    set device-identification enable
    set role lan
    set interface "internal1"
    set vlanid 10
  next
  edit "vlan20"
    set vdom "root"
    set device-identification enable
    set role lan
    set interface "internal1"
    set vlanid 20
  next
end  
```

  </td>
</tr>
</table>



## 4. VxLAN 인터페이스 설정

<table>
<tr>
  <td>FG#1</td>
  <td>FG#2</td>
</tr>
<tr>
  <td>

```
config system vxlan
  edit "vxlan.10"
    set interface "fg1-vpn"
    set vni 10
    set remote-ip "2.2.2.1"
  next
  edit "vxlan.20"
    set interface "fg1-vpn"
    set vni 20
    set remote-ip "2.2.2.1"
  next
end
```

  </td>
  <td>

```
config system vxlan
  edit "vxlan.10"
    set interface "fg2-vpn"
    set vni 10
    set remote-ip "2.2.2.2"
  next
  edit "vxlan.20"
    set interface "fg2-vpn"
    set vni 20
    set remote-ip "2.2.2.2"
  next
end
```

  </td>
</tr>
</table>



## 5. Switch 인터페이스 설정

<table>
<tr>
  <td>FG#1</td>
  <td>FG#2</td>
</tr>
<tr>
  <td>

```
config system switch-interface
  edit "vxlan10"
    set vdom "root"
    set member "vlan10" "vxlan.10"
    set type switch
    set intra-switch-policy implicit
    set mac-ttl 300
    set span disable
  next
  edit "vxlan20"
    set vdom "root"
    set member "vlan20" "vxlan.20"
    set type switch
    set intra-switch-policy implicit
    set mac-ttl 300
    set span disable
  next
end
```

  </td>
  <td>

```
config system switch-interface
  edit "vxlan10"
    set vdom "root"
    set member "vlan10" "vxlan.10"
    set type switch
    set intra-switch-policy implicit
    set mac-ttl 300
    set span disable
  next
  edit "vxlan20"
    set vdom "root"
    set member "vlan20" "vxlan.20"
    set type switch
    set intra-switch-policy implicit
    set mac-ttl 300
    set span disable
  next
end
```

  </td>
</tr>
</table>


## 6. LLCF 설정 (1)

LLCF(Link Loss Carry Forward)는 link 상태를 감지하여 회선의 양 끝단 link를 up 또는 down 시키는 역할을 합니다.

wan1 인터페이스 상태를 감지하여 internal1 인터페이스를 up 또는 down 시킵니다. 또는

internal1 인터페이스 상태를 감지하여 wan1 인터페이스를 up 또는 down 시킵니다.


<table>
<tr>
  <td>FG#1</td>
  <td>FG#2</td>
</tr>
<tr>
  <td>

```
config system interface
  edit "wan1"
    set fail-detect enable
    set fail-detect-option link-down
    set fail-alert-method link-down
    set fail-alert-interface internal1
  next
  edit "internal1"
    set fail-detect enable
    set fail-detect-option link-down
    set fail-alert-method link-down
    set fail-alert-interface wan1
  next
end
```

  </td>
  <td>

```
config system interface
  edit "wan1"
    set fail-detect enable
    set fail-detect-option link-down
    set fail-alert-method link-down
    set fail-alert-interface internal1
  next
  edit "internal1"
    set fail-detect enable
    set fail-detect-option link-down
    set fail-alert-method link-down
    set fail-alert-interface wan1
  next
end
```

  </td>
</tr>
</table>


## 7. LLCF 설정 (2)

VPN Tunnel 상태를 감지하여 internal1 인터페이스를 up 또는 down 시킵니다.

FortiOS Event중 Log ID 37138에 해당하는 IPsec connection status changed를 이용합니다.

Log 의 action 필드 값 중 tunnel-down, tunnel-up 만 필터링하여 trigger를 작성합니다.

<table>

<tr><td>FG#1, FG#2</td></tr>

<tr><td>

```

config system automation-action
   edit "internal1_down"
        set action-type cli-script
        set required enable
        set script "config system interface
edit internal1
set status down
end"
        set accprofile "api_super_admin"
    next
    edit "internal1_up"
        set action-type cli-script
        set required enable
        set script "config system interface
edit internal1
set status up
end"
        set accprofile "api_super_admin"
    next
   edit "ipsecvpn_down"
        set action-type cli-script
        set required enable
        set script "config system interface
edit ipsecvpn
set status down
end"
        set accprofile "api_super_admin"
    next
    edit "ipsecvpn_up"
        set action-type cli-script
        set required enable
        set script "config system interface
edit ipsecvpn
set status up
end"
        set accprofile "api_super_admin"
    next
end

```

</td></tr>

<tr><td>

```

config system automation-trigger
    edit "internal1_down"
        set event-type event-log
        set logid 20099
        config fields
            edit 1
                set name "msg"
                set value "Link monitor: Interface internal1 was turned down"
            next
        end
    next
    edit "internal_up"
        set event-type event-log
        set logid 20099
        config fields
            edit 1
                set name "msg"
                set value "Link monitor: Interface internal1 was turned up"
            next
        end
    next
    edit "ipsecvpn_down"
        set event-type event-log
        set logid 37138
        config fields
            edit 1
                set name "action"
                set value "tunnel-down"
            next
        end
    next
    edit "ipsecvpn_up"
        set event-type event-log
        set logid 37138
        config fields
            edit 1
                set name "action"
                set value "tunnel-up"
            next
        end
    next
end

```

</td></tr>

<tr><td>

```

config system automation-stitch
    edit "internal1_down"
        set trigger "internal1_down"
        set action "ipsecvpn_down"
    next
    edit "internal1_up"
        set trigger "internal1_up"
        set action "ipsecvpn_down"
    next
    edit "ipsecvpn_down"
        set trigger "ipsecvpn_down"
        set action "internal1_down"
    next
    edit "ipsecvpn_up"
        set trigger "ipsecvpn_up"
        set action "internal1_up"
    next
end

```

</td></tr>

</table>


### 참조 링크

- <a href="https://community.fortinet.com/t5/FortiGate/Technical-Tip-VXLAN-over-IPsec-for-multiple-VLANs-using-software/ta-p/195488" target="_blank">VXLAN</a>

- <a href="https://github.com/niveklabs/tfwriter/blob/main/fortios/r/" target="_blank">Terraform Module</a>
