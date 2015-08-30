#setup working directory
setwd("/home/aniket/Documents/FinancialAnalysis/Dev")
source("routine.R")

library(ggplot2)

#Load Master Data
CC <- read.csv("~/Documents/FinancialAnalysis/DataSource/CC.csv")  #Cost Centre
PC <- read.csv("~/Documents/FinancialAnalysis/DataSource/PC.csv")  #Profit Centre
TC <- read.csv("~/Documents/FinancialAnalysis/DataSource/TC.csv")  #Transfer Codes


#Load Transactional Data form csv
TT <- read.csv("~/Documents/FinancialAnalysis/DataSource/TT.csv")                         #Bank Balance Sheets
MF <- read.csv("~/Documents/FinancialAnalysis/DataSource/MF.csv",stringsAsFactors=FALSE)  #Mutual Funds
CE <- read.csv("~/Documents/FinancialAnalysis/DataSource/CE.csv",stringsAsFactors=FALSE)  #Cash Expense
TB <- read.csv("~/Documents/FinancialAnalysis/DataSource/TB.csv",stringsAsFactors=FALSE)  #TradeBook

#Cleaning Data
TT$ValueDate <- as.character(TT$ValueDate)
TT$ChequeNumber <- as.character(TT$ChequeNumber)
TT$TransactionRemarks <- as.character(TT$TransactionRemarks)
TT$ValueDate <- as.Date(TT$ValueDate,"%d/%m/%Y")

MF$Date <- as.Date(MF$Date)
MF$Account <- factor(MF$Account)

CE$ValueDate <- as.Date(CE$ValueDate)
CE$CostCentre <- factor(CE$CostCentre)

TB$Action <- factor(TB$Action)
TB$Exchange <- factor(TB$Exchange)
TB$Segment <- factor(TB$Segment)
TB$Date <- as.Date(TB$Date, "%d-%b-%Y")
#sort in descending order
TT <- TT[order(TT$SNo., TT$ValueDate, decreasing=TRUE),]

#Asset Acct 101
Asset101 <-subset(TT,TT$Account==101,select = c(ValueDate,Balance.INR.))
Asset101 <- Asset101[!duplicated(Asset101$ValueDate),]
#ggplot(Asset101,aes(Asset101$ValueDate,Asset101$Balance.INR.))+geom_line()

#Asset Acct 102
Asset102 <-subset(TT,TT$Account==102,select = c(ValueDate,Balance.INR.))
Asset102 <- Asset102[!duplicated(Asset102$ValueDate),]
#ggplot(Asset102,aes(Asset102$ValueDate,Asset102$Balance.INR.))+geom_line()

#Asset Acct 103
Asset103 <-subset(TT,TT$Account==103,select = c(ValueDate,Balance.INR.))
Asset103 <- Asset103[!duplicated(Asset103$ValueDate),]
#ggplot(Asset103,aes(Asset103$ValueDate,Asset103$Balance.INR.))+geom_line()

#Asset
Asset_C <- Reduce(function(x, y) merge(x, y,by= "ValueDate", all=TRUE), list(Asset101, Asset102, Asset103))
colnames(Asset_C) <- c("ValueDate","101","102","103")
#Convert NA to zero, hence enabling us to sum
Asset_C[is.na(Asset_C)] <- 0  
#Adjust blank values created due to merge
Asset_C <-blank_adjustments(Asset_C)
Asset_C$Total <- rowSums(Asset_C[,-1])

#Workspace Clean up
rm(list=c("Asset101","Asset102","Asset103"))

#CASH ASSET PLOT
#ggplot(Asset_C,aes(Asset_C$ValueDate,Asset_C$Total))+geom_line()