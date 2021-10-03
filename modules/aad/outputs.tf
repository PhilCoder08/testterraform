output "developer-portal-client-secret" {
  value     = azuread_application_password.developer-portal.value
  sensitive = true
}
