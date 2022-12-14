# fortios_system_automation_action

variable "accprofile" {
  description = "(optional)"
  type        = string
  default     = null
}

variable "action_name" {
  description = "(optional)"
  type        = string
  default     = null
}

variable "action_type" {
  description = "(optional)"
  type        = string
  default     = null
}

variable "delay" {
  description = "(optional)"
  type        = number
  default     = null
}

variable "dynamic_sort_subtable_action" {
  description = "(optional)"
  type        = string
  default     = null
}

variable "required" {
  description = "(optional)"
  type        = string
  default     = null
}

variable "script" {
  description = "(optional)"
  type        = string
  default     = null
}


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
