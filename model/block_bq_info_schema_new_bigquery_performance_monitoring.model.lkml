connection: "@{CONNECTION_NAME}"

include: "views/*.view.lkml"
include: "*.explore.lkml"
include: "*.dashboard.lookml"
include: "//@{CONFIG_PROJECT_NAME}/*.view.lkml"
include: "//@{CONFIG_PROJECT_NAME}/*.model.lkml"
include: "//@{CONFIG_PROJECT_NAME}/*.dashboard"

explore: commit_facts {
  extends: [commit_facts_config]
}

explore: jobs_by_organization_raw {
  extends: [jobs_by_organization_raw_config]
}

explore: jobs_by_organization_raw_all_queries {
  extends: [jobs_by_organization_raw_all_queries_config]
}

explore: jobs_timeline_by_organization {
  extends: [jobs_timeline_by_organization_config]
}

explore: timeline_with_commits {
  extends: [timeline_with_commits_config]
}

explore: concurrency_per_second {
  extends: [concurrency_per_second_config]
}

