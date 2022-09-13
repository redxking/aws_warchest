# Module resource(s) is defined here

resource "aws_security_group" "example_security_group" {
  description = "Example Security Group"
  name        = "${var.app_name}-SecurityGroup"
  vpc_id      = var.vpc_id

  #   egress {
  #     cidr_blocks = ["0.0.0.0/0"]
  #     from_port   = 0
  #     protocol    = "-1"
  #     to_port     = 0
  #   }

  #   ingress {
  #     cidr_blocks = ["0.0.0.0/0"]
  #     from_port   = 22
  #     protocol    = "tcp"
  #     to_port     = 22
  #   }

  tags = merge(
    var.tags,
    {
      "Name" = "${var.app_name}-SecurityGroup"
    },
  )
}