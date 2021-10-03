resource "azurerm_resource_group" "main" {
  name     = var.resourceGroupName
  tags     = var.default_tags
  location = var.location
}

resource "azurerm_app_service_plan" "test-backend" {
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  name                = var.appServicePlanName
  kind                = "app"

  sku {
    size = "F1"
    tier = "Free"
  }
}

resource "azurerm_app_service" "test-backend-app" {
  resource_group_name     = azurerm_resource_group.main.name
  location                = azurerm_resource_group.main.location
  name                    = var.appServiceAppName
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

resource "azurerm_storage_account" "frontend" {
  access_tier              = "Hot"
  account_kind             = "StorageV2"
  account_replication_type = "LRS"
  account_tier             = "Standard"
  allow_blob_public_access = true
  location                 = azurerm_resource_group.main.location
  resource_group_name      = azurerm_resource_group.main.name
  min_tls_version          = "TLS1_2"
  name                     = var.storageFrontendName

  static_website {
    index_document = "index.html"
  }
}

module "test-aad" {
  source   = "./modules/aad"
  tenantId = var.aadTenantId
}

