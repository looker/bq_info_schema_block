explore: concurrency_per_second_core {
  extension: required

  join: jobs_timeline_by_organization {
  type: left_outer
  relationship: many_to_one
  sql_on: ${concurrency_per_second.timestamp_raw} = ${jobs_timeline_by_organization.period_start_raw} ;;
}

join: count_interval {
  type: full_outer
  fields: []
  relationship: many_to_one
  sql_on: ${jobs_timeline_by_organization.period_start_hour_of_day} = ${count_interval.hour}
      and ${jobs_timeline_by_organization.period_start_day_of_week_index} = ${count_interval.dayofweek} ;;
}
 
}