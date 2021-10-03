output "developerPortalClientId" {
  value = azuread_application.developer-portal.application_id
}

output "developer-portal-client-secret" {
  value     = azuread_application_password.developer-portal.value
  sensitive = true
}

output "metadataOpenIdConfig" {
  value = azuread_application.developer-portal.application_id
}
