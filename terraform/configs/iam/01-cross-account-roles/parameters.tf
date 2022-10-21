################################################################################
# SSM Parameters: Cross Account Automation Lambda Role
################################################################################
resource "aws_ssm_parameter" "cross_acct_automation_lambda_role_arn" {
  count = local.create_related_cross_account_automation_lambda_role_resources ? 1 : 0
  
  description = "The Arn of the Cross Account Automation Lamnda IAM Role"
  name        = "/infra/${var.environment}/iam/cross_acct_automation_lambda_role_arn"
  type        = "String"
  value       = aws_iam_role.cross_acct_automation_lambda[0].arn

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [aws_iam_policy.cross_acct_automation_lambda]
}

resource "aws_ssm_parameter" "cross_acct_automation_lambda_role_id" {
  count = local.create_related_cross_account_automation_lambda_role_resources ? 1 : 0
  
  description = "The Id of the Cross Account Automation Lamnda IAM Role"
  name        = "/infra/${var.environment}/iam/cross_acct_automation_lambda_role_id"
  type        = "String"
  value       = aws_iam_role.cross_acct_automation_lambda[0].id

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [aws_iam_policy.cross_acct_automation_lambda]
}

resource "aws_ssm_parameter" "cross_acct_automation_lambda_role_name" {
  count = local.create_related_cross_account_automation_lambda_role_resources ? 1 : 0
  
  description = "The Name of the Cross Account Automation Lamnda IAM Role"
  name        = "/infra/${var.environment}/iam/cross_acct_automation_lambda_role_name"
  type        = "String"
  value       = aws_iam_role.cross_acct_automation_lambda[0].name

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [aws_iam_policy.cross_acct_automation_lambda]
}

resource "aws_ssm_parameter" "cross_acct_automation_lambda_role_unique_id" {
  count = local.create_related_cross_account_automation_lambda_role_resources ? 1 : 0
  
  description = "The Unique Id of the Cross Account Automation Lamnda IAM Role"
  name        = "/infra/${var.environment}/iam/cross_acct_automation_lambda_role_unique_id"
  type        = "String"
  value       = aws_iam_role.cross_acct_automation_lambda[0].unique_id

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [aws_iam_policy.cross_acct_automation_lambda]
}

################################################################################
# SSM Parameter: Cross Account Automation Execution Role
################################################################################
resource "aws_ssm_parameter" "cross_acct_automation_exec_role_arn" {
  count = local.create_related_cross_account_automation_exec_role_resources ? 1 : 0
  
  description = "The Arn of the Cross Account Automation Execution IAM Role"
  name        = "/infra/${var.environment}/iam/cross_acct_automation_exec_role_arn"
  type        = "String"
  value       = aws_iam_role.cross_acct_automation_exec[0].arn

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [aws_iam_policy.cross_acct_automation_exec]
}

resource "aws_ssm_parameter" "cross_acct_automation_exec_role_id" {
  count = local.create_related_cross_account_automation_exec_role_resources ? 1 : 0
  
  description = "The Id of the Cross Account Automation Execution IAM Role"
  name        = "/infra/${var.environment}/iam/cross_acct_automation_exec_role_id"
  type        = "String"
  value       = aws_iam_role.cross_acct_automation_exec[0].id

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [aws_iam_policy.cross_acct_automation_exec]
}

resource "aws_ssm_parameter" "cross_acct_automation_exec_role_name" {
  count = local.create_related_cross_account_automation_exec_role_resources ? 1 : 0
  
  description = "The Name of the Cross Account Automation Execution IAM Role"
  name        = "/infra/${var.environment}/iam/cross_acct_automation_exec_role_name"
  type        = "String"
  value       = aws_iam_role.cross_acct_automation_exec[0].name

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [aws_iam_policy.cross_acct_automation_exec]
}

resource "aws_ssm_parameter" "cross_acct_automation_exec_role_unique_id" {
  count = local.create_related_cross_account_automation_exec_role_resources ? 1 : 0
  
  description = "The Unique Id of the Cross Account Automation Execution IAM Role"
  name        = "/infra/${var.environment}/iam/cross_acct_automation_exec_role_unique_id"
  type        = "String"
  value       = aws_iam_role.cross_acct_automation_exec[0].unique_id

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [aws_iam_policy.cross_acct_automation_exec]
}