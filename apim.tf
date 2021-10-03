resource "azurerm_api_management" "main-apim" {
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  name                = var.apimName
  publisher_email     = var.apimPublisherEmail
  publisher_name      = var.apimPublisherName
  sku_name            = "Developer_1"
}

resource "azurerm_api_management_api" "main-api" {
  resource_group_name = azurerm_resource_group.main.name
  api_management_name = azurerm_api_management.main-apim.name
  name                = "spa-auth-backend"
  revision            = "1"

  subscription_required = false

  openid_authentication {
    bearer_token_sending_methods = []
    openid_provider_name         = "apim-developer-portal-client-provider"
  }
}

resource "azurerm_api_management_api_policy" "main-api-policy" {
  resource_group_name = azurerm_resource_group.main.name
  api_management_name = azurerm_api_management.main-apim.name
  api_name            = azurerm_api_management_api.main-api.name

  xml_content = file("apim.policy.xml")
}

resource "azurerm_api_management_api_operation" "main-api-get" {
  resource_group_name = azurerm_resource_group.main.name
  api_management_name = azurerm_api_management.main-apim.name
  api_name            = azurerm_api_management_api.main-api.name
  operation_id        = "614b35ec8b9d658a102f9498"
  display_name        = "spa-auth-backend_GET"
  method              = "GET"
  url_template        = "/*"
}

resource "azurerm_api_management_api_operation" "main-api-get-weatherforecast" {
  resource_group_name = azurerm_resource_group.main.name
  api_management_name = azurerm_api_management.main-apim.name
  api_name            = azurerm_api_management_api.main-api.name
  operation_id        = "weatherforecast"
  display_name        = "weatherforecast"
  method              = "GET"
  url_template        = "/weatherforecast"
}

resource "azurerm_api_management_openid_connect_provider" "developer-portal" {
  resource_group_name = azurerm_resource_group.main.name
  name                = "apim-developer-portal-client-provider"
  description         = ""
  api_management_name = azurerm_api_management.main-apim.name
  client_id           = module.test-aad.developerPortalClientId
  client_secret       = module.test-aad.developer-portal-client-secret
  display_name        = "apim-developer-portal-client-provider"
  metadata_endpoint   = "https://login.microsoftonline.com/${var.aadTenantId}/v2.0/.well-known/openid-configuration"
}
