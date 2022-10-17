locals {  
  tags = merge(
    { Namespace: var.namespace },
    { Environment: var.environment },
    { Region: var.region },
    { Provisioner: var.provisioner }
  )
}


resource "aws_iam_role" "cross_acct_automation" {

}