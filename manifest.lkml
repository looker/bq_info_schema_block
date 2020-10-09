project_name: "block-bq_info_schema_new"
  
################ Constants ################

constant: CONFIG_PROJECT_NAME {
  value: "block-bq_info_schema_new-config"
  export: override_required
}

constant: CONNECTION_NAME {
  value: "choose connection"
  export: override_required
}

### If needed TODO Add more constants here

################ Dependencies ################

local_dependency: {
  project: "@{CONFIG_PROJECT_NAME}"

  #### If needed TODO Add CONFIG constants here that we want overridden by CORE constants

}
