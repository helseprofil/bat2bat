## code to prepare `mixFil` dataset goes here

## kom2020 <- data.table::fread("../data/kommuner19og20.csv")
kom2020 <- data.table::fread("../data/kom2020_2021.csv")

## Eksluderer alle kommune som har blitt slått sammen untatt 50 og 11
kom2020[, bort := 0]

## bort == 2 for kommuner som skal bort
kommAll <- kom2020[, .(kodeb4=kom_b4, kode2020=kommnr, bort=bort)]

## beholder bare unike geo
kommAll <- kommAll[!duplicated(kode2020)]

fylke <- kom2020[, .(kodeb4=fylke_b4, kode2020=fylke, bort=bort)]
fylke <- fylke[!duplicated(kode2020), ]

land=data.table::data.table(kodeb4=0, kode2020=0, bort=0)

mixFil <- data.table::rbindlist(list(land,kommAll,fylke))

usethis::use_data(mixFil,  overwrite = TRUE)
