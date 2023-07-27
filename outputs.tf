/*output "published_app_ids" {
  value = data.azuread_application_published_app_ids.well_known.result
}*/

output "application_id" {
  value = azuread_application.rddx.application_id
}