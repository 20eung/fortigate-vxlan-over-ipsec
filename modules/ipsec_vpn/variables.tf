variable "name" {
  description = "The name of the IPsec VPN interface."
  type        = string
  default     = null
}

variable "interface" {
  description = "The interface for the IPsec VPN ."
  type        = string
  default     = null
}

variable "ike_version" {
  type        = string
  default     = "1"
}

variable "keylife" {
  type        = string
  default     = "86400"
}

variable "mode" {
  type        = string
  default     = "main"
}

variable "peertype" {
  type        = string
  default     = "any"
}

variable "net_device" {
  type        = string
  default     = "disable"
}

variable "proposal_phase1" {
  type        = string
  default     = "aes128-sha256 aes256-sha256 aes128-sha1 aes256-sha1"
}

variable "dpd" {
  type        = string
  default     = "on-demand"
}

variable "dhgrp_phase1" {
  type        = string
  default     = "14 5"
}

variable "nattraversal" {
  type        = string
  default     = "enable"
}

variable "remote_gw" {
  type        = string
  default     = null
}

variable "psksecret" {
  type        = string
  default     = null
}

variable "dpd_retryinterval" {
  type        = string
  default     = "20"
}

variable "proposal_phase2" {
  type        = string
  default     = "aes128-sha256 aes256-sha256 aes128-sha1 aes256-sha1"
}


variable "pfs" {
  type        = string
  default     = "enable"
}

variable "dhgrp_phase2" {
  type        = string
  default     = "14 5"
}

variable "replay" {
  type        = string
  default     = "enable"
}

variable "keepalive" {
  type        = string
  default     = "disable"
}

variable "auto_negotiate" {
  type        = string
  default     = "enable"
}

variable "keylifeseconds" {
  type        = string
  default     = "43200"
}

variable "ip" {
  type        = string
  default     = null
}

variable "remote_ip" {
  type        = string
  default     = null
}

variable "allowaccess" {
  type        = string
  default     = null
}

variable "tcp_mss" {
  type        = string
  default     = "0"
}

variable "enable_mtu_override" {
  type        = string
  default     = "0"
}
variable "mtu_override" {
  type        = string
  default     = "disable"
}

variable "mtu" {
  type        = string
  default     = null
}

variable "vdom" {
  description = "The name of the VDOM."
  type        = string
  default     = "root"
}

