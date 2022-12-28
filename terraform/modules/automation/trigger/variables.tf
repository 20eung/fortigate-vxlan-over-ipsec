# fortios_system_automation_trigger

variable "event_type" {
  description = "(optional)"
  type        = string
  default     = null
}

variable "fields" {
  description = "nested block: NestingList, min items: 0, max items: 0"
  type = set(object(
    {
      id    = number
      name  = string
      value = string
    }
  ))
  default = []
}

variable "logid" {
  description = "(optional)"
  type        = number
  default     = null
}

variable "trigger_name" {
  description = "(optional)"
  type        = string
  default     = null
}
