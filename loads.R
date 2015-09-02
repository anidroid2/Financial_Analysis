#setup working directory
setwd("/home/aniket/Documents/FinancialAnalysis/Dev")
source("routine.R")
source("Quandl.R")
library(ggplot2)

#Loading from CSV and formatting data
source("loadcsv.R")

#sort in descending order
TT <- TT[order(TT$SNo., TT$ValueDate, decreasing=TRUE),]

#subroutine for Cash Segment Calculations
source("Cash.R")

#subroutine for Equity Segment Calculations
source("Equity.R")

#Save all tabels in workspace to be used by reporting scripts
save.image(file="R_ws.RData")
