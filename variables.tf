variable "resourceGroupName" {
  type = string
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
  type = string
}

variable "storageFrontendName" {
  type = string
}

variable "apimName" {
  type = string
}

variable "apimPublisherEmail" {
  type = string
}

variable "apimPublisherName" {
  type = string
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

variable "aadTenantId" {
  type = string
}
