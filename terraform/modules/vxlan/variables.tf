### fortios_system_vxlan


variable "dstport" {
  description = "(optional) 1 - 65535, default = 4789"
  type        = number
  default     = null
}

variable "interface" {
  description = "(required)"
  type        = string
}

variable "ip_version" {
  description = "(required) default=ipv4-unicast"
  type        = string
  default     = "ipv4-unicast"
}

variable "name" {
  description = "(optional)"
  type        = string
  default     = null
}

variable "remote_ip" {
  description = "IPv4 address of the VXLAN interface on the device at the remote end of the VXLAN"
  type        = string
  default     = null
}

variable "vni" {
  description = "(required)"
  type        = number
}
