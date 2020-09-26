## Variables
variable "create" {
    type    = bool
    default = true
}
variable "iam_group_name" {
    type    = string
}
variable "import_managed_policies" {
    type    = any
    default = []
}
variable "iam_policy" {
    type    = any
    default = []
}
variable "path" {
    type = string
    default = "/"
}
