terraform {
  required_providers {
    fortios = {
      source            = "fortinetdev/fortios"
    }
  }
}

# system automation action
resource "fortios_system_automationaction" "this" {
  name                = var.action_name
  action_type         = var.action_type
  delay               = var.delay
  required            = var.required
  script              = var.script
  accprofile          = var.accprofile
  dynamic_sort_subtable = var.dynamic_sort_subtable_action
}

# system automation trigger
resource "fortios_system_automationtrigger" "this" {
  name                = var.stitch_name
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

# system automation stitch
resource "fortios_system_automationstitch" "this" {
  name                = var.stitch_name

  status              = var.status
  trigger             = var.trigger
  dynamic_sort_subtable = var.dynamic_sort_subtable_stitch
  
  dynamic "action" {
    for_each = var.action
    content {
      # name - (optional) is a type of string
      name = action.value["name"]
    }
  }

  dynamic "destination" {
    for_each = var.destination
    content {
      # name - (optional) is a type of string
      name = destination.value["name"]
    }
  }
}
