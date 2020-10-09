include: "//@{CONFIG_PROJECT_NAME}/views/concurrency_per_second.view.lkml" 
        
        
view: concurrency_per_second {
  extends: [concurrency_per_second_config]
}

###################################################
        
view: concurrency_per_second_core {
  derived_table: {
    sql: WITH seconds as (
          SELECT TIMESTAMP_TRUNC(timestamp, SECOND) timestamp, FROM (SELECT GENERATE_TIMESTAMP_ARRAY(TIMESTAMP_SUB({% date_end jobs_timeline_by_organization.date_filter %}, INTERVAL 2 DAY), {% date_end jobs_timeline_by_organization.date_filter %}, INTERVAL 1 SECOND) timestamps), UNNEST(timestamps) timestamp
      ), filtered_jobs_timeline as (
      SELECT * from `region-us.INFORMATION_SCHEMA`.JOBS_TIMELINE_BY_ORGANIZATION f
      WHERE f.job_creation_time BETWEEN TIMESTAMP_SUB({% date_start jobs_timeline_by_organization.date_filter %}, INTERVAL 6 HOUR) AND {% date_end jobs_timeline_by_organization.date_filter %}
      )
          SELECT
              s.timestamp,
              r.project_id,
              SUM(IF(r.state = "PENDING", 1, 0)) as PENDING,
              SUM(IF(r.state = "RUNNING", 1, 0)) as RUNNING
          FROM
              filtered_jobs_timeline r
              FULL OUTER JOIN seconds s
              ON s.timestamp  = r.period_start
          WHERE
              s.timestamp BETWEEN {% date_start jobs_timeline_by_organization.date_filter %} AND {% date_end jobs_timeline_by_organization.date_filter %}
            --  and t.job_creation_time BETWEEN TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 1 DAY) AND CURRENT_TIMESTAMP()
          GROUP BY s.timestamp, r.project_id ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: avg_pending {
    type: average
    sql: ${pending} ;;
  }

  measure: max_pending {
    type: max
    sql: nullif(${pending},0) ;;
  }

  measure: avg_running {
    label: "Average Concurrency"
    type: average
    sql: nullif(${running},0) ;;
  }

  measure: max_running {
    label: "Max Concurrency"
    type: max
    sql: nullif(${running},0) ;;
  }

  filters: date_window {
    type: date
  }

  dimension_group: timestamp {
    type: time
    timeframes: [raw, minute5]
    allow_fill: no
    sql: ${TABLE}.timestamp ;;
  }

  dimension: project_id {
    type: string
    sql: ${TABLE}.project_id ;;
  }

  dimension: pending {
    type: number
    sql: ${TABLE}.PENDING ;;
  }

  dimension: running {
    type: number
    sql: ${TABLE}.RUNNING ;;
  }

  set: detail {
    fields: [timestamp_raw, pending, running]
  }
}
