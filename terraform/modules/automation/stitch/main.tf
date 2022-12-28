terraform {
  required_providers {
    fortios = {
      source            = "fortinetdev/fortios"
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
/*
  depends_on            = [ 
    fortios_system_automationaction.this,
    fortios_system_automationtrigger.this
  ]
*/
}
