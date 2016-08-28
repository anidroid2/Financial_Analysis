#setup working directory
setwd("/home/anidroid2/Documents/FinancialAnalysis/Dev")

#setup variable
init_env = 0    #1=reload stock environment with new data , 0= dissble reload

#Getting dependencies
library(Quandl)
library(quantmod)
library(stringr)
library(dplyr)
library(tidyr)
library(lubridate)
library(scales)

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
#source("Equity.R")  #Q11 Decommisioned as ICICI TB is now not in the requirements
source("Income.R")  #Q12
#source("Historic_Equity.R")

source("Investments.R")

source("Credit.R")

source("event.R")


#Phase II -Stock Analysis

source("importStockData.R")




#Save all tabels in workspace to be used by reporting scripts
save.image(file="R_ws.RData")