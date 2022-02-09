## code to prepare `kom2020` dataset goes here

kom2020 <- data.table::fread("./data/kommuner19og20.csv")
usethis::use_data(kom2020, overwrite = TRUE)
