# fortios_system_automation_stitch

variable "action" {
  description = "nested block: NestingList, min items: 0, max items: 0"
  type = set(object(
    {
      name = string
    }
  ))
  default = []
}

variable "destination" {
  description = "nested block: NestingList, min items: 0, max items: 0"
  type = set(object(
    {
      name = string
    }
  ))
  default = []
}

variable "dynamic_sort_subtable_stitch" {
  description = "(optional)"
  type        = string
  default     = null
}

variable "status" {
  description = "(required)"
  type        = string
}

variable "stitch_name" {
  description = "(optional)"
  type        = string
  default     = null
}

variable "trigger" {
  description = "(required)"
  type        = string
}
