resource "azurerm_storage_account" "frontend" {
  access_tier              = "Hot"
  account_kind             = "StorageV2"
  account_replication_type = "LRS"
  account_tier             = "Standard"
  allow_blob_public_access = true
  location                 = "westeurope"
  resource_group_name      = "spa_auth_rg"
  min_tls_version          = "TLS1_2"
  name                     = "spaauthfrontend"

  static_website {
    index_document = "index.html"
  }
}