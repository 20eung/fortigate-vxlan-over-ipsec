# 포티게이트 장비에서 VxLAN over IPsec 구현(다중 VLAN)

## 1. WAN 인터페이스 설정

<table>
<tr>
  <td>FG#1</td>
  <td>FG#2</td>
</tr>
<tr>
  <td>

```json
config system interface
  edit "wan1"
    set vdom "root"
    set ip 1.1.1.1 255.255.255.0
    set allowaccess ping fgfm
    set type physical
    set role wan
  next
```

  </td>
  <td>

```json
config system interface
  edit "wan1"
    set vdom "root"
    set ip 1.1.1.2 255.255.255.0
    set allowaccess ping fgfm
    set type physical
    set role wan
  next
```

  </td>
</tr>
</table>


# 참조 링크
- https://community.fortinet.com/t5/FortiGate/Technical-Tip-VXLAN-over-IPsec-for-multiple-VLANs-using-software/ta-p/195488