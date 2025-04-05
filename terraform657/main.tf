provider "azurerm" {
  features {}
  subscription_id =  "d7384d39-d195-4791-81d7-5b60ed8298fa"
}
resource "azurerm_resource_group" "example" {
    name = var.resource_group_name
    location = var.location
  
}

resource "azurerm_service_plan" "app_service_plan" {
  name                = "${var.app_service_name}-plan"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "S1"
  os_type             = "Windows"
}

resource "azurerm_app_service" "example" {
  name                = var.app_service_name
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  app_service_plan_id = azurerm_service_plan.app_service_plan.id

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }

  
}