explore: jobs_by_organization_raw_all_queries_core {
  extension: required

  from: jobs_by_organization_raw
label: "All Jobs by Organization"

join: project_gb_rank_ndt {
  type: left_outer
  relationship: many_to_one
  sql_on: ${jobs_by_organization_raw_all_queries.project_id} = ${project_gb_rank_ndt.project_id} ;;
}
 
}