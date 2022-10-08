output "cc_vpc_id" {
  description = "VPC Id"
  value       = aws_vpc.ccVPC.id
}

output "cc_public_subnets" {
  description = "Will be used by Web Server Module to set subnet_ids"
  value = [
    aws_subnet.ccPublicSubnet1,
    aws_subnet.ccPublicSubnet2
  ]
}

output "cc_private_subnets" {
  description = "Will be used by RDS Module to set subnet_ids"
  value = [
    aws_subnet.ccPrivateSubnet1,
    aws_subnet.ccPrivateSubnet2
  ]
}