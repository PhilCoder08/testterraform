# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.65"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.0.0"
    }
  }

  required_version = ">= 0.14.9"
}

provider "azurerm" {
  partner_id = "11c3b2d7-5ac6-47ee-9d94-f64bc6adbe8c"
  features {
  }
}

module "test-aad" {
  source = "./modules/aad"
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  tags     = var.default_tags
  location = "westeurope"
}
