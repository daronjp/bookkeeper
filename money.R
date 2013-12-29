library(sqldf)
library(lubridate)

txns <- read.csv("../../../../Downloads/2013-12-29-exported_transactions.csv")
colnames(txns)[9] <- "folder"
txns$Date <- as.POSIXct(txns$Date)
txns$month <- floor_date(txns$Date, "month")
txns$week <- floor_date(txns$Date, "week")

memotxns <- sqldf("select * from txns where memo != ''")
memo6 <- as.character(memotxns$Memo)
memo7 <- unlist(strsplit(memo6, " "))
memo8 <- as.data.frame(memo7)
allWords <- sqldf("select memo7, count(*) as count from memo8 group by 1 order by 2 desc")
allWords <- sqldf("select * from allWords where memo7 not in ('and', 'to', 'with', 'the', 'of', 'from', 'on', 'a')")

allCommonWords <- sqldf("select * from allWords where count > 10")
