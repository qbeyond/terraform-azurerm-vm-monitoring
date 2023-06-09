provider "azurerm" {
  features{}
}

resource "azurerm_resource_group" "example" {
  name     = "rg-Monitor-dev-01"
  location = "westeurope"
}

resource "azurerm_log_analytics_workspace" "example" {
  name                = "law-cust-Management-Monitor-01"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

module "monitor" {
  source                  = "../.."
  log_analytics_workspace = {
    id                  = azurerm_log_analytics_workspace.example.id
    name                = azurerm_log_analytics_workspace.example.name
    resource_group_name = azurerm_log_analytics_workspace.example.resource_group_name
    location            = azurerm_log_analytics_workspace.example.location
  }
  webhook_name            = "QBY EventPipeline"
  webhook_service_uri     = "https://function-app.azurewebsites.net/api/Webhook"

  additional_queries    = {
    "alr-prd-diskspace-bkp-law-logsea-warn-01": {
        query_path  = "${path.module}/queries/failed_jobs.kusto"
        description = "Example of monitoring for failed backup jobs"
        time_window = 2280
    }
  }
}