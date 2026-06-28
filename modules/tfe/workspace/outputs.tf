output "workspace_id" {
  value = tfe_workspace.default.id
}

output "workspace_name" {
  value = tfe_workspace.default.name
}

output "project_id" {
  value = tfe_workspace.default.project_id
}

output "project_name" {
  value = data.tfe_project.default.name
}
