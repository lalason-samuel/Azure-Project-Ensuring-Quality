resource "azurerm_app_service_plan" "test" {
  name                = "${var.application_type}-PLAN"
  location            = var.location
  resource_group_name = var.resource_group

  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_app_service" "test" {
  name                = "${var.application_type}-FAKERESTAPI"
  location            = var.location
  resource_group_name = var.resource_group
  app_service_plan_id = azurerm_app_service_plan.test.id

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = 0
  }
  site_config {
    dotnet_framework_version = "v6.0"
  }
  lifecycle {
    ignore_changes = [
      app_settings["WEBSITE_RUN_FROM_PACKAGE"],
    ]
  }
}
