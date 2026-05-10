module "vercel_team" {
  source         = "./modules/vercel/team"
  vercel_team_id = var.vercel_team_id
  name           = "AlexTheMan"
  description    = "Vercel team for my personal alextheman organisation, to help with managing the deployment of my Turborepo apps."
}

module "lexicon_project" {
  source           = "./modules/vercel/project"
  vercel_team_id   = var.vercel_team_id
  name             = "lexicon-front-end"
  framework        = "vite"
  output_directory = "apps/front-end/dist"
}
