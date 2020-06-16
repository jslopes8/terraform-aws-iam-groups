## Cria IAM Group
resource "aws_iam_group" "group_new" {
    name = var.iam_group_name
}
## DataSource Policy Document
data "aws_iam_policy_document" "policy_document" {
    statement {
        effect      = var.effect
        actions     = var.iam_policy_read 
        resources   = var.resources
    }
}
resource "aws_iam_policy" "policy_document" {
    name        = var.policy_name
    policy      = data.aws_iam_policy_document.policy_document.json
}
## Anexa Policy ao IAM Group criado
resource "aws_iam_group_policy_attachment" "policy-attachment" {
    group   = var.iam_group_name
    policy_arn  = aws_iam_policy.policy_document.arn
}

