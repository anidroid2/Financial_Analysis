#setup working directory
setwd("/home/aniket/Documents/FinancialAnalysis/Dev")

#Getting dependencies
library(Quandl)
library(quantmod)
library(stringr)
library(dplyr)
library(tidyr)
library(lubridate)

source("AdvDef.R")
source("routine.R")
source("Quandl.R")

library(ggplot2)
library(shiny)
source("def.R")

#Phase I -Financial Analysis

#Loading from CSV and formatting data
source("loadcsv.R")

#Bills tables
source("Bill.R") #Q01
#subroutine for Cash Segment Calculations
source("Cash.R") #Q02

#subroutine for shopping expenses
source("ShoppingExpense.R") #Q03

#subroutine for Equity Segment Calculations
#source("Equity.R")  #Q11
source("Income.R")  #Q12
#source("Historic_Equity.R")

source("Investments.R")

source("Credit.R")

#Phase II -Stock Analysis

source("importStockData.R")




#Save all tabels in workspace to be used by reporting scripts
save.image(file="R_ws.RData")