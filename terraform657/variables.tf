variable "resource_group_name" {
    type = string
    default = "rg-jenkins"
}
variable "location" {
    type = string
    default = "centralindia"

}
variable "app_service_plan_name" {
    type = string
    default = "webapiyashpjenkins82648plan"
}
variable "app_service_name" {
    type = string
    default = "webapiyashpjenkins82648"
}
variable "deployment_slot_name" {}