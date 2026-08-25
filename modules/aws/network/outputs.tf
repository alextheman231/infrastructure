output "vpc_id" {
  value = aws_vpc.default.id
}

output "public_subnet_ids" {
  value = [for subnet in aws_subnet.public : subnet.id]
}

output "private_subnet_ids" {
  value = [for subnet in aws_subnet.private : subnet.id]
}

output "internet_gateway_id" {
  value = aws_internet_gateway.default.id
}

output "public_route_table_id" {
  value = aws_route_table.public.id
}
