module "music_repository" {
  source = "../modules/github/repository"

  name        = "music"
  description = "My music projects."
  visibility  = "public"
  labels = {
    "breaking change" = {
      color       = "B60205"
      description = "Require a drastic change in how performers consume the song."
    }
    "new section" = {
      color       = "A2EEEF"
      description = "Adds a new section to a song"
    }
    "wrong note fix" = {
      color       = "D73A4A"
      description = "Fixes a misplaced note."
    }
    "timbre change" = {
      color       = "5319E7"
      description = "Changes to the instrumentation and timbre."
    }
    "mixing and mastering" = {
      color       = "28A745"
      description = "Changes to the mixing/mastering."
    }
    "refactor" = {
      color       = "C2E0C6"
      description = "Quality improvements without audible changes."
    }
  }
}
