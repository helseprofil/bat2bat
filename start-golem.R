## Start with golem
remotes::install_github("Thinkr-open/golem")
library(golem)

golem::create_golem("../../bat2bat")

fs::dir_tree("../../bat2bat")
