locals {
  check_name = {
    actions_ci                    = "actions-ci / actions-ci",
    restrict_alex_up_bot_branches = "restrict-alex-up-bot-branches / restrict-alex-up-bot-branches",

    package = {
      source_code_ci    = "package-ci / source-code-ci",
      version_change_ci = "package-ci / version-change-ci / version-change-ci"
    }

    end_to_end_ci = "end-to-end-ci / end-to-end-ci"

    terraform = {
      lint_ci      = "terraform-lint-ci"
      plan_ci      = "terraform-plan-ci"
      comment_plan = "comment-terraform-plan"
    }

    components = {
      end_to_end_ci = "end-to-end-ci"
    }

    github_actions = {
      actions_ci        = "actions-ci"
      version_change_ci = "version-change-ci / version-change-ci"
    }

    lexicon = {
      lint_ci       = "lexicon-lint-ci"
      test_ci       = "lexicon-test-ci"
      end_to_end_ci = "end-to-end-ci"
    }

    neurosongs = {
      ci = "neurosongs-ci"
    }

    alex_g_bot = {
      ci = "alex-g-bot-ci"
    }

    media = {
      ci = "media-ci"
    }
  }

  _base_checks = [
    local.check_name.actions_ci,
    local.check_name.restrict_alex_up_bot_branches
  ]

  check_list = {
    base = local._base_checks

    package = concat(local._base_checks, [
      local.check_name.package.source_code_ci,
      local.check_name.package.version_change_ci,
      local.check_name.actions_ci,
      local.check_name.end_to_end_ci
    ])

    github_actions = {
      base = [
        for check in local._base_checks :
        check
        if check != local.check_name.actions_ci
      ]
    }
  }
}
