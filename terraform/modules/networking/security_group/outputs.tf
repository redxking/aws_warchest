# Module outputs go here

output "example_security_group_name" {
  description = "Name for the security group."
  value       = aws_security_group.example_security_group.name
}
