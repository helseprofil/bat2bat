library(data.table)

dt1 <- data.table(GEO = c(30101,30102,30103,30104,30105),
                  AAR = rep("1990_1990", 5),
                  KJONN = rep(0, 5),
                  TELLER = rep(400, 5),
                  RATE = c(6.3, 5.3, 4.8, 3.8, 5.7),
                  SMR = c(122, 103, 93, 74, 73))

dt2 <- data.table(GEO = c(30101,30102,30103,30104,30105),
                  AAR = rep("1990_1990", 5),
                  KJONN = rep(0, 5),
                  TELLER = rep(405, 5),
                  RATE = c(6.3, 5.3, 4.8, 3.8, 5.7),
                  SMR = c(122, 103, 93, 74, 73))

fwrite(dt1, "~/Test/data/data01.csv")
fwrite(dt2, "~/Test/data/data02.csv")
