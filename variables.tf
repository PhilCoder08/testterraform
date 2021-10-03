variable "resourceGroupName" {
  type    = string
  default = "spa_auth_rg"
}

variable "location" {
  type    = string
  default = "westeurope"
}

variable "appServicePlanName" {
  type    = string
  default = "ASP-spatestrg-afb6"
}

variable "appServiceAppName" {
  type    = string
  default = "spa-auth-backend-app"
}

variable "storageFrontendName" {
  type    = string
  default = "spaauthfrontend"
}

variable "default_tags" {
  description = "Tags to set for all resources"
  type        = map(string)
  default = {
    autodeploy  = 1,
    environment = "dev"
    contact     = "DevOps Team"
  }
}
