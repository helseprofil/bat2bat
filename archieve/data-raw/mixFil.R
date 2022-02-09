## code to prepare `mixFil` dataset goes here

kom2020 <- data.table::fread("./data/kommuner19og20.csv")


## komm=kom2020[, .(kodeb4=kom_b4, kode2020=kommnr)]

## komm[, dup := 0][
##   duplicated(kode2020) | duplicated(kode2020, fromLast = TRUE), dup  := 1][]

## fylkeRaw=kom2020[, .(kodeb4=fylke_b4, kode2020=fylke)]
## #beholder bare fylke som ikke har blitt slått sammen
## fylke=fylkeRaw[!duplicated(kodeb4), ]
## fylke[, dup := 0][
##   duplicated(kode2020) | duplicated(kode2020, fromLast = TRUE), dup := 1][]


## Eksluderer alle kommune som har blitt slått sammen untatt 50 og 11
kom2020[, bort := 0]

## bort == 2 for kommuner som skal bort
kommAll <- kom2020[, .(kodeb4=kom_b4, kode2020=kommnr, bort=bort)]
## Duplikate kommunenr for kode2020 er eksludert fordi denne kommunen er en
## sammenslåing av flere
komm <- kommAll[duplicated(kode2020)|duplicated(kode2020, fromLast = TRUE), bort := 2]
innKom=c(5001, 1103) #Trondheim (blir slått sammen i 2018 og ikke er i komb4) and Stavanger
komm[kodeb4 %in% innKom, bort := 0]
kommUt <- komm[!duplicated(kodeb4), ]


fylke <- kom2020[, .(kodeb4=fylke_b4, kode2020=fylke, bort=bort)]
## bort == 1 for fylke som skal bort
mixFylke=c(30,34,38,42,46,54)
fylke[kode2020 %in% mixFylke, bort := 1]
fylkeUt <- fylke[!duplicated(kodeb4), ]

land=data.table::data.table(kodeb4=0, kode2020=0, bort=0)

mixFil <- data.table::rbindlist(list(land,kommUt,fylkeUt))

usethis::use_data(mixFil,  overwrite = TRUE)
