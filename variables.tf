variable "redirect_uris" {
  type        = list(string)
  description = "Redirect Uris"
}

variable "logout_url" {
  type        = string
  description = "Logout URL"
}

variable "allowed_member_types_user" {
  type        = list(string)
  description = "Allowed Member Types User"
}

variable "claim_values" {
  type        = list(string)
  description = "Claim Values"
}

variable "application_id" {
  type        = string
  description = "Application Id"
}