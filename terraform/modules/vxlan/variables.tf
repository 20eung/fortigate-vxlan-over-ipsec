variable "name" {
  description = "VXLAN device or interface name."
  type        = string
  default     = null
}

variable "dstport" {
  description = "VXLAN destination port (1 - 65535, default = 4789)."
  type        = string
  default     = "4789"
}

variable "interface" {
  description = "Outgoing interface for VXLAN encapsulated traffic."
  type        = string
  default     = null
}

variable "ip_version" {
  description = "IP version to use for the VXLAN interface and so for communication over the VXLAN. IPv4 or IPv6 unicast or multicast."
  type        = string
  default     = "ipv4-unicast"
}

variable "remote_ip" {
  description = "IPv4 address of the VXLAN interface on the device at the remote end of the VXLAN"
  type        = string
  default     = null
}

variable "vni" {
  description = "VXLAN network ID"
  type        = string
  default     = null
}

variable "dependson" {
  type        = string
  default     = null
}
