## Variables
variable "policy_name" {
    type    = string
}
variable "iam_group_name" {
    default = string
}
variable "iam_policy_mq" {
    default = []
}
variable "iam_policy_read" {
    default = []
}
variable "resources" {
    default = []
}
variable "effect" {
    type    = string
}
