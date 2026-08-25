module "aws_network" {
  source = "../modules/aws/network"

  name               = "alextheman231"
  availability_zones = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
}
