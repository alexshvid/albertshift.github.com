name "fronta"
description "Front Machine"
run_list(
  "recipe[nginx]",
  "recipe[nginx::http_ssl_module]",
  "recipe[nginx::commons]",
  "recipe[nginx::fronta]",
)
