explore: jobs_timeline_by_organization_core {
  extension: required

  join: count_interval {
  type: full_outer
  fields: []
  relationship: many_to_one
  sql_on: ${jobs_timeline_by_organization.period_start_hour_of_day} = ${count_interval.hour}
and ${jobs_timeline_by_organization.period_start_day_of_week_index} = ${count_interval.dayofweek} ;;
}
 
}