module "aws_network" {
  source = "../modules/aws/network"

  name               = "alextheman231"
  availability_zones = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
}

moved {
  from = module.aws_network.aws_subnet.public[0]
  to   = module.aws_network.aws_subnet.public["eu-west-2a"]
}

moved {
  from = module.aws_network.aws_subnet.public[1]
  to   = module.aws_network.aws_subnet.public["eu-west-2b"]
}

moved {
  from = module.aws_network.aws_subnet.public[2]
  to   = module.aws_network.aws_subnet.public["eu-west-2c"]
}

moved {
  from = module.aws_network.aws_subnet.private[0]
  to   = module.aws_network.aws_subnet.private["eu-west-2a"]
}

moved {
  from = module.aws_network.aws_subnet.private[1]
  to   = module.aws_network.aws_subnet.private["eu-west-2b"]
}

moved {
  from = module.aws_network.aws_subnet.private[2]
  to   = module.aws_network.aws_subnet.private["eu-west-2c"]
}

moved {
  from = module.aws_network.aws_route_table_association.public_gateway[0]
  to   = module.aws_network.aws_route_table_association.public_gateway["eu-west-2a"]
}

moved {
  from = module.aws_network.aws_route_table_association.public_gateway[1]
  to   = module.aws_network.aws_route_table_association.public_gateway["eu-west-2b"]
}

moved {
  from = module.aws_network.aws_route_table_association.public_gateway[2]
  to   = module.aws_network.aws_route_table_association.public_gateway["eu-west-2c"]
}

moved {
  from = module.aws_network.aws_route_table_association.private_gateway[0]
  to   = module.aws_network.aws_route_table_association.private_gateway["eu-west-2a"]
}

moved {
  from = module.aws_network.aws_route_table_association.private_gateway[1]
  to   = module.aws_network.aws_route_table_association.private_gateway["eu-west-2b"]
}

moved {
  from = module.aws_network.aws_route_table_association.private_gateway[2]
  to   = module.aws_network.aws_route_table_association.private_gateway["eu-west-2c"]
}
