module "vercel_team" {
  source         = "./modules/vercel"
  vercel_team_id = var.vercel_team_id
  name           = "AlexTheMan"
  description    = "Vercel team for my personal alextheman organisation, to help with managing the deployment of my Turborepo apps."
}
