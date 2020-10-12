project_name: "block-bq-info-schema"

################ Constants ################

constant: CONFIG_PROJECT_NAME {
  value: "block-bq-info-schema-config"
}

constant: CONNECTION_NAME {
  value: "looker_app_2"
  export: override_required
}

constant: BQ_ADMIN_PROJECT {
  value: "bigquery-trial-250422"
  export: override_required
}

constant: REGION {
  value: "region-us"
  export: override_required
}

### If needed TODO Add more constants here

################ Dependencies ################

local_dependency: {
  project: "@{CONFIG_PROJECT_NAME}"

  #### If needed TODO Add CONFIG constants here that we want overridden by CORE constants

}
