locals {
  create_related_cross_account_automation_lambda_role_resources = var.create_cross_account_automation_lambda_role ? true : false
  create_related_cross_account_automation_exec_role_resources   = var.create_cross_account_automation_exec_role ? true : false  
  tags = merge(
    { Namespace: var.namespace },
    { Environment: var.environment },
    { Region: var.region },
    { Provisioner: var.provisioner }
  )
}

################################################################################
# IAM Role & Policy: Cross Account Automation Lambda
################################################################################
data "aws_iam_policy_document" "cross_acct_automation_lambda" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "cross_acct_automation_lambda" {
  count = local.create_related_cross_account_automation_lambda_role_resources ? 1 : 0

  name                = "CrossAcctAutomationLambdaRole"
  assume_role_policy  = data.aws_iam_policy_document.cross_acct_automation_lambda.json
  managed_policy_arns = [aws_iam_policy.cross_acct_automation_lambda[0].arn]

 # Tag(s)
  tags = local.tags 
}

resource "aws_iam_policy" "cross_acct_automation_lambda" {
  count = local.create_related_cross_account_automation_lambda_role_resources ? 1 : 0
  
  name   = "CrossAcctAutomationLambdaPolicy"
  policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action   = ["sts:AssumeRole"]
        Effect   = "Allow"
        Resource = [
          "arn:aws:iam::${var.account_ids["sandbox"]}:role/CrossAcctAutomationExecutionRole",
          "arn:aws:iam::${var.account_ids["develop"]}:role/CrossAcctAutomationExecutionRole",
          "arn:aws:iam::${var.account_ids["staging"]}:role/CrossAcctAutomationExecutionRole",
          "arn:aws:iam::${var.account_ids["product"]}:role/CrossAcctAutomationExecutionRole",
        ] 
      },
      {
        Action   = ["organizations:ListAccounts"]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
 
 # Tag(s)
  tags = local.tags 
}

################################################################################
# IAM Role & Policy: Cross Account Automation Execution
################################################################################
data "aws_iam_policy_document" "cross_acct_automation_exec" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    
    principals {
      type        = "AWS"
      identifiers = [
        "arn:aws:iam::${var.account_ids["commons"]}:role/CrossAcctAutomationLambdaRole"
      ]
    }
  }
}

resource "aws_iam_role" "cross_acct_automation_exec" {
  count = local.create_related_cross_account_automation_exec_role_resources ? 1 : 0
  
  name                = "CrossAcctAutomationExecutionRole"
  assume_role_policy  = data.aws_iam_policy_document.cross_acct_automation_exec.json
  managed_policy_arns = [aws_iam_policy.cross_acct_automation_exec[0].arn]
 
 # Tag(s)
  tags = local.tags 
}

resource "aws_iam_policy" "cross_acct_automation_exec" {
  count = local.create_related_cross_account_automation_exec_role_resources ? 1 : 0
  
  name   = "CrossAcctAutomationExecutionPolicy"
  policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action   = ["ec2:Describe*"]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action   = ["ec2:StopInstances"]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
 
 # Tag(s)
  tags = local.tags 
}