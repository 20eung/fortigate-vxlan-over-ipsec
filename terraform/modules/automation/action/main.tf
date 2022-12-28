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
