resource "azurerm_api_management" "main-apim" {
  location            = "westeurope"
  name                = "spa-auth-apim"
  publisher_email     = "philip.wenger@ti8m.ch"
  publisher_name      = "spa-auth"
  resource_group_name = "spa_auth_rg"
  sku_name            = "Developer_1"
}

resource "azurerm_api_management_api" "main-api" {
  api_management_name = azurerm_api_management.main-apim.name
  name                = "spa-auth-backend"
  resource_group_name = "spa_auth_rg"
  revision            = "1"

  subscription_required = false

  openid_authentication {
    bearer_token_sending_methods = []
    openid_provider_name         = "apim-developer-portal-client-provider"
  }
}

resource "azurerm_api_management_api_policy" "main-api-policy" {
  resource_group_name = "spa_auth_rg"
  api_management_name = azurerm_api_management.main-apim.name
  api_name            = azurerm_api_management_api.main-api.name

  xml_content = file("apim.policy.xml")
}

resource "azurerm_api_management_api_operation" "main-api-get" {
  resource_group_name = "spa_auth_rg"
  api_management_name = azurerm_api_management.main-apim.name
  api_name            = azurerm_api_management_api.main-api.name
  display_name        = "spa-auth-backend_GET"
  method              = "GET"
  operation_id        = "614b35ec8b9d658a102f9498"
  url_template        = "/*"
}

resource "azurerm_api_management_api_operation" "main-api-get-weatherforecast" {
  resource_group_name = "spa_auth_rg"
  api_management_name = azurerm_api_management.main-apim.name
  api_name            = azurerm_api_management_api.main-api.name
  display_name        = "weatherforecast"
  method              = "GET"
  operation_id        = "weatherforecast"
  url_template        = "/weatherforecast"
}

resource "azurerm_api_management_openid_connect_provider" "developer-portal" {
  resource_group_name = "spa_auth_rg"
  name                = "apim-developer-portal-client-provider"
  description         = ""
  api_management_name = azurerm_api_management.main-apim.name
  client_id           = "61ea8f66-3f29-4c4d-a43a-501f10c25057"
  client_secret       = module.test-aad.developer-portal-client-secret
  display_name        = "apim-developer-portal-client-provider"
  metadata_endpoint   = "https://login.microsoftonline.com/392924fc-17eb-4199-94fd-fbd9ee70077e/v2.0/.well-known/openid-configuration"
}
