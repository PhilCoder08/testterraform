resource "azurerm_app_service_plan" "test-backend" {
  resource_group_name = "spa_auth_rg"
  location            = "westeurope"
  name                = "ASP-spatestrg-afb6"
  kind                = "app"

  sku {
    size = "F1"
    tier = "Free"
  }
}

resource "azurerm_app_service" "test-backend-app" {
  name                    = "spa-auth-backend-app"
  resource_group_name     = "spa_auth_rg"
  location                = "westeurope"
  app_service_plan_id     = azurerm_app_service_plan.test-backend.id
  client_affinity_enabled = true

  source_control {
    branch             = "main"
    manual_integration = true
    repo_url           = "https://github.com/PhilCoder08/testbackend.git"
    rollback_enabled   = false
    use_mercurial      = false
  }
}
