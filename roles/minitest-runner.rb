name "minitest-runner"
description "Installs minitest-chef-handler as a report handler. This should be the first thing in the node's run_list."
override_attributes(
)
run_list(
        "recipe[minitest-handler-cookbook]"
)
