variable "intra_switch_policy" {
  description = "(optional)"
  type        = string
  default     = null
}

variable "member" {
  description = "nested block: NestingList, min items: 0, max items: 0"
  type        = list(object(
    {
      interface_name = string
    }
  ))
  default     = []
}

variable "mac_ttl" {
  description = "(optional) default=300"
  type        = number
  default     = null
}

variable "name" {
  description = "(required)"
  type        = string
}

variable "type" {
  description = "(optional)"
  type        = string
  default     = null
}

variable "vdom" {
  description = "(optional)"
  type        = string
  default     = null
}

variable "span" {
  description = "(optional)"
  type        = string
  default     = null
}
