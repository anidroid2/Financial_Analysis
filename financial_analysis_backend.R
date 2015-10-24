#setup working directory
setwd("/home/aniket/Documents/FinancialAnalysis/Dev")

source("routine.R")
source("Quandl.R")


library(ggplot2)
library(shiny)

#Loading from CSV and formatting data
source("loadcsv.R")

#Bills tables
source("Bill.R") #Q01
#subroutine for Cash Segment Calculations
source("Cash.R") #Q02

#subroutine for shopping expenses
source("ShoppingExpense.R")

#subroutine for Equity Segment Calculations
source("Equity.R")

#source("Historic_Equity.R")

#Save all tabels in workspace to be used by reporting scripts
save.image(file="R_ws.RData")