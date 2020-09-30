resource "aws_iam_group" "main" {
    count   = var.create ? 1 : 0

    name    = var.iam_group_name
    path    = var.path
}
resource "aws_iam_group_policy_attachment" "import_managed" {
    count   = var.create ? length(var.import_managed_policies) : 0

    group      = aws_iam_group.main.0.name
    policy_arn = lookup(var.import_managed_policies[count.index], "policies_arn", null)
}
resource "aws_iam_group_policy_attachment" "main" {
    count   = var.create ? length(var.iam_policy) : 0

    group      = aws_iam_group.main.0.name
    policy_arn = element(aws_iam_policy.main.*.arn, count.index)
}
resource "aws_iam_policy" "main" {
    count   = var.create ? length(var.iam_policy) : 0

    name = lookup(var.iam_policy[count.index], "name_policy", null)
    path = "/"
    policy = element(data.aws_iam_policy_document.policy_document.*.json, count.index)
}
data "aws_iam_policy_document" "policy_document" {
    count   = var.create ? length(var.iam_policy) : 0

    statement {
        sid         = lookup(var.iam_policy[count.index], "sid", null)
        effect      = lookup(var.iam_policy[count.index], "effect", null)
        actions     = lookup(var.iam_policy[count.index], "actions", null)
        not_actions = lookup(var.iam_policy[count.index], "not_actions", null)
        resources   = lookup(var.iam_policy[count.index], "resources", null)
    }
}