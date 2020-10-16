project_name: "block-bq-info-schema"

################ Constants ################

constant: CONFIG_PROJECT_NAME {
  value: "block-bq-info-schema-config"
  export: override_required
}

constant: CONNECTION_NAME {
  value: "Connection Name"
  export: override_required
}

constant: BQ_ADMIN_PROJECT {
  value: "Big Query Admin Project Name"
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
