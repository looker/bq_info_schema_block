explore: jobs_by_organization_raw_core {
  extension: required

  label: "Completed Queries by Organization"
view_label: "Jobs by Organization"
sql_always_where: ${job_type} = 'QUERY' AND ${state} = 'DONE' ;;

join: jobs_by_organization_snapshot_raw {
  type: left_outer
  relationship: one_to_one
  sql_on: ${jobs_by_organization_raw.job_id} = ${jobs_by_organization_snapshot_raw.job_id} ;;
}

join: jobs_by_organization_snapshot__snapshot {
  view_label: "Jobs by Organization: Timeline"
  relationship: one_to_many
  sql: CROSS JOIN UNNEST (${jobs_by_organization_snapshot_raw.snapshot}) as jobs_by_organization_snapshot__snapshot ;;
}

join: jobs_by_organization_raw__referenced_tables {
  view_label: "Jobs by Organization: Referenced Tables"
  sql: LEFT JOIN UNNEST (${jobs_by_organization_raw.referenced_tables}) as jobs_by_organization_raw__referenced_tables ;;
  relationship: one_to_many
}

join: jobs_by_organization_raw__timeline {
  view_label: "Jobs by Organization: Timeline"
  sql: LEFT JOIN UNNEST (${jobs_by_organization_raw.timeline}) as jobs_by_organization_raw__timeline ;;
  relationship: one_to_many
}

join: jobs_by_organization_raw__job_stages {
  view_label: "Jobs by Organization: Job Stages"
  sql: LEFT JOIN UNNEST(${jobs_by_organization_raw.job_stages}) as jobs_by_organization_raw__job_stages ;;
  relationship: one_to_many
}

join: jobs_by_organization_raw__job_stages__input_stages {
  view_label: "Jobs by Organization: Job Stages"
  sql: LEFT JOIN UNNEST(${jobs_by_organization_raw__job_stages.input_stages}) as jobs_by_organization_raw__job_stages__input_stages ;;
  relationship: one_to_many
}

join: jobs_by_organization_raw__job_stages__steps {
  view_label: "Jobs by Organization: Job Stages"
  sql: LEFT JOIN UNNEST(${jobs_by_organization_raw__job_stages.steps}) as jobs_by_organization_raw__job_stages__steps ;;
  relationship: one_to_many
}

join: jobs_by_organization_raw__job_stages__steps__substeps {
  view_label: "Jobs by Organization: Job Stages"
  sql: LEFT JOIN UNNEST(${jobs_by_organization_raw__job_stages__steps.substeps}) as jobs_by_organization_raw__job_stages__steps__substeps ;;
  relationship: one_to_many
}

join: referenced_datasets_ndt {
  view_label: "Jobs by Organization: Referenced Tables"
  relationship: many_to_one
  type: left_outer
  sql_on: ${jobs_by_organization_raw__referenced_tables.referenced_dataset_id} = ${referenced_datasets_ndt.referenced_dataset} ;;
}

join: commit_facts {
  view_label: "Slot Commitments"
  type: left_outer
  relationship: many_to_one
  sql_on: ${jobs_by_organization_raw.creation_minute} = ${commit_facts.timestamp_minute} ;;
}

join: tables {
  type: left_outer
  relationship: many_to_one
  sql_on: ${jobs_by_organization_raw__referenced_tables.referenced_table_id} = ${tables.table_name} ;;
}

join: columns {
  type: left_outer
  relationship: one_to_many
  sql_on: ${columns.table_name} = ${tables.table_name} ;;
}
 
}