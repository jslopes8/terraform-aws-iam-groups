resource "aws_iam_group" "main" {
    count   = var.create ? 1 : 0

    name    = var.iam_group_name
    path    = var.path
}
resource "aws_iam_group_policy_attachment" "main" {
    count   = var.create ? length(var.import_managed_policies) : 0

    group      = aws_iam_group.admin[0].name
    policy_arn = lookup(var.import_managed_policies[count.index], "policies_arn", null)
}
resource "aws_iam_group_policy_attachment" "main" {
    count   = var.create ? length(var.iam_policy) : 0

    group      = aws_iam_group.admin[0].name
    policy_arn = data.aws_iam_policy_document.policy_document.json
}
data "aws_iam_policy_document" "policy_document" {
    dynamic "statement" {
        for_each = var.iam_policy
        
        content {
            sid         = lookup(statement.value, "sid", null)
            effect      = lookup(statement.value, "effect", null)
            actions     = lookup(statement.value, "actions", null)
            not_actions = lookup(statement.value, "not_actions", null)
            resources   = lookup(statement.value, "resources", null)

        dynamic "condition" {
          for_each = length(keys(lookup(statement.value, "condition", {}))) == 0 ? [] : [lookup(statement.value, "condition", {})]
          content {
            test      = lookup(condition.value, "test", null)
            variable  = lookup(condition.value, "variable", null)
            values    = lookup(condition.value, "values", null)
            
          }
        }

        dynamic "principals" {
          for_each = length(keys(lookup(statement.value, "principals", {}))) == 0 ? [] : [lookup(statement.value, "principals", {})]
          content {
            type        = lookup(principals.value, "type", null)
            identifiers = lookup(principals.value, "identifiers", null)
          }
        }
      }
    }
}
