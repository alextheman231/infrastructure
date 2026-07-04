locals {
  subnet_count = min(4, length(data.aws_availability_zones.available.names))
}
