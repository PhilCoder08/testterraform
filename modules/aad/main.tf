provider "azuread" {
  tenant_id = "392924fc-17eb-4199-94fd-fbd9ee70077e"
}

resource "azuread_application" "api" {
  display_name = "my-api"

  group_membership_claims = [
    "All",
    "ApplicationGroup",
  ]

  identifier_uris = [
    "api://f2777218-978d-4cd9-9b81-1a742e44bb04",
  ]

  owners = [
    "7b804cf4-4a15-4d83-b579-c260b01e93e1",
  ]

  sign_in_audience = "AzureADMultipleOrgs"

  api {
    known_client_applications      = []
    mapped_claims_enabled          = false
    requested_access_token_version = 2

    oauth2_permission_scope {
      admin_consent_description  = "text"
      admin_consent_display_name = "text"
      enabled                    = true
      id                         = "b16ba399-ebc2-4566-a8c8-e09e44e66b70"
      type                       = "User"
      user_consent_description   = "text"
      user_consent_display_name  = "text"
      value                      = "access_as_user"
    }
  }

  optional_claims {
    access_token {
      additional_properties = []
      essential             = false
      name                  = "sid"
    }
    access_token {
      additional_properties = []
      essential             = false
      name                  = "email"
    }
    access_token {
      additional_properties = []
      essential             = false
      name                  = "groups"
    }

    id_token {
      additional_properties = []
      essential             = false
      name                  = "groups"
    }

    saml2_token {
      additional_properties = []
      essential             = false
      name                  = "groups"
    }
  }
  required_resource_access {
    resource_app_id = "00000003-0000-0000-c000-000000000000"

    resource_access {
      id   = "e1fe6dd8-ba31-4d61-89e7-88639da4683d"
      type = "Scope"
    }
    resource_access {
      id   = "64a6cdd6-aab1-4aaf-94b8-3cc8405e90d0"
      type = "Scope"
    }
  }
}

resource "azuread_application" "spa" {
  display_name = "my-spa"
  group_membership_claims = [
    "None",
  ]
  owners = [
    "7b804cf4-4a15-4d83-b579-c260b01e93e1",
  ]
  sign_in_audience = "AzureADMultipleOrgs"
  api {
    known_client_applications      = []
    mapped_claims_enabled          = false
    requested_access_token_version = 2
  }

  optional_claims {
    access_token {
      additional_properties = []
      essential             = false
      name                  = "email"
    }

    id_token {
      additional_properties = []
      essential             = false
      name                  = "email"
    }
  }

  required_resource_access {
    resource_app_id = "00000003-0000-0000-c000-000000000000"

    resource_access {
      id   = "7427e0e9-2fba-42fe-b0c0-848c9e6a8182"
      type = "Scope"
    }
    resource_access {
      id   = "e1fe6dd8-ba31-4d61-89e7-88639da4683d"
      type = "Scope"
    }
    resource_access {
      id   = "37f7f235-527c-4136-accd-4a02d197296e"
      type = "Scope"
    }
    resource_access {
      id   = "64a6cdd6-aab1-4aaf-94b8-3cc8405e90d0"
      type = "Scope"
    }
    resource_access {
      id   = "14dad69e-099b-42c9-810b-d002981feec1"
      type = "Scope"
    }
  }
  required_resource_access {
    resource_app_id = "f2777218-978d-4cd9-9b81-1a742e44bb04"

    resource_access {
      id   = "b16ba399-ebc2-4566-a8c8-e09e44e66b70"
      type = "Scope"
    }
  }

  single_page_application {
    redirect_uris = [
      "http://localhost:4200/",
      "http://localhost:4200/silent-renew.html",
      "https://localhost:4200/",
      "https://localhost:4200/silent-renew.html",
      "https://spaauthfrontend.z6.web.core.windows.net/",
      "https://spaauthfrontend.z6.web.core.windows.net/silent-renew.html",
    ]
  }
}

resource "azuread_application" "developer-portal" {
  display_name = "developer_portal"
  owners = [
    "7b804cf4-4a15-4d83-b579-c260b01e93e1",
  ]

  sign_in_audience = "AzureADMultipleOrgs"
  api {
    known_client_applications      = []
    mapped_claims_enabled          = false
    requested_access_token_version = 2
  }
  required_resource_access {
    resource_app_id = "f2777218-978d-4cd9-9b81-1a742e44bb04"

    resource_access {
      id   = "b16ba399-ebc2-4566-a8c8-e09e44e66b70"
      type = "Scope"
    }
  }
  required_resource_access {
    resource_app_id = "00000003-0000-0000-c000-000000000000"

    resource_access {
      id   = "e1fe6dd8-ba31-4d61-89e7-88639da4683d"
      type = "Scope"
    }
  }
  web {
    redirect_uris = [
      "https://auth-test-apim-2521.developer.azure-api.net/signin-oauth/code/callback/lhtest",
      "https://auth-test-apim-2521.developer.azure-api.net/signin-oauth/implicit/callback",
      "https://spa-auth-apim.developer.azure-api.net/signin-oauth/code/callback/apim-developer-portal-client-provider",
      "https://spa-auth-apim.developer.azure-api.net/signin-oauth/implicit/callback",
    ]

    implicit_grant {
      access_token_issuance_enabled = true
      id_token_issuance_enabled     = true
    }
  }

}

resource "azuread_application_password" "developer-portal" {
  application_object_id = azuread_application.developer-portal.object_id

}
