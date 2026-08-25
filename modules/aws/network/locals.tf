locals {
  subnet_count = min(3, length(data.aws_availability_zones.available.names))
}
