data "azuread_application_published_app_ids" "well_known" {}


resource "azuread_service_principal" "msgraph" {
  application_id = data.azuread_application_published_app_ids.well_known.result.MicrosoftGraph
  use_existing   = true
}

resource "azuread_application" "rddx" {
  display_name    = "rddxs-app-dev"
  identifier_uris = ["api://${var.application_id}"]

  api {
    mapped_claims_enabled          = true
    requested_access_token_version = 2

    oauth2_permission_scope {
      admin_consent_description  = "Allow the application to access example on behalf of the signed-in user."
      admin_consent_display_name = "api.read"
      enabled                    = true
      id                         = var.application_id
      type                       = "User"
      user_consent_description   = "Allow the application to access example on your behalf."
      value                      = "api.read"
    }
  }

  required_resource_access {
    resource_app_id = data.azuread_application_published_app_ids.well_known.result.MicrosoftGraph

    resource_access {
      id   = azuread_service_principal.msgraph.oauth2_permission_scope_ids["${var.claim_values[0]}"]
      type = "Scope"
    }

    resource_access {
      id   = azuread_service_principal.msgraph.oauth2_permission_scope_ids["${var.claim_values[1]}"]
      type = "Scope"
    }

    resource_access {
      id   = azuread_service_principal.msgraph.oauth2_permission_scope_ids["${var.claim_values[2]}"]
      type = "Scope"
    }

    resource_access {
      id   = azuread_service_principal.msgraph.oauth2_permission_scope_ids["${var.claim_values[3]}"]
      type = "Scope"
    }

    resource_access {
      id   = azuread_service_principal.msgraph.oauth2_permission_scope_ids["${var.claim_values[4]}"]
      type = "Scope"
    }

    resource_access {
      id   = azuread_service_principal.msgraph.oauth2_permission_scope_ids["${var.claim_values[5]}"]
      type = "Scope"
    }

    resource_access {
      id   = azuread_service_principal.msgraph.oauth2_permission_scope_ids["${var.claim_values[6]}"]
      type = "Scope"
    }
  }

  single_page_application {
    redirect_uris = var.redirect_uris

  }

  web {
    logout_url = var.logout_url

    implicit_grant {
      access_token_issuance_enabled = true
      id_token_issuance_enabled     = true
    }
  }

  app_role {
    allowed_member_types = var.allowed_member_types_user
    description          = "Analista"
    display_name         = "Bocc_537_D_Consultas"
    enabled              = true
    id                   = "497406e4-012a-4267-bf18-45a1cb148a01"
    value                = "Bocc_537_D_Consultas"
  }

  app_role {
    allowed_member_types = var.allowed_member_types_user
    description          = "Administrators"
    display_name         = "Bocc_537_D_Administrators"
    enabled              = true
    id                   = "1b19509b-32b1-4e9f-b71d-4992aa991967"
    value                = "Bocc_537_D_Administrators"
  }
}

resource "azuread_service_principal" "rddx" {
  application_id = azuread_application.rddx.application_id
}

resource "azuread_service_principal_delegated_permission_grant" "rddx" {
  service_principal_object_id          = azuread_service_principal.rddx.object_id
  resource_service_principal_object_id = azuread_service_principal.msgraph.object_id
  claim_values                         = var.claim_values
}

resource "azuread_application_pre_authorized" "rddx" {
  application_object_id = azuread_application.rddx.object_id
  authorized_app_id     = azuread_application.rddx.application_id
  permission_ids        = ["${var.application_id}"]
}