terraform {
  required_providers {
    fortios = {
      source            = "fortinetdev/fortios"
    }
  }
}

# system automation trigger
resource "fortios_system_automationtrigger" "this" {
  name                = var.trigger_name
  event_type          = var.event_type
  logid               = var.logid
  dynamic "fields" {
    for_each = var.fields
    content {
      # id - (optional) is a type of number
      id = fields.value["id"]
      # name - (optional) is a type of string
      name = fields.value["name"]
      # value - (optional) is a type of string
      value = fields.value["value"]
    }
  }
}
