output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnet_id" {
  value = aws_subnet.public.id
}

output "private_subnet_id" {
  value = aws_subnet.private.id
}

output "security_group_id" {
  value = aws_security_group.allow_all.id
}

output "eks_sg_id" {
  description = "The ID of the EKS security group"
  value       = aws_security_group.eks_sg.id
}