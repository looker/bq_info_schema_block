explore: timeline_with_commits_core {
  extension: required

  from: jobs_timeline_by_organization

join: commit_facts {
  type: left_outer
  relationship: many_to_one
  sql_on: ${commit_facts.timestamp_minute} = ${timeline_with_commits.period_start_minute} ;;
}

join: count_interval {
  type: full_outer
  fields: []
  relationship: many_to_one
  sql_on: ${timeline_with_commits.period_start_hour_of_day} = ${count_interval.hour}
      and ${timeline_with_commits.period_start_day_of_week_index} = ${count_interval.dayofweek} ;;
}
 
}