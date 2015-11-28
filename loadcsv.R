#Load Master Data
CC <- read.csv("~/Documents/FinancialAnalysis/DataSource/CC.csv")  #Cost Centre
PC <- read.csv("~/Documents/FinancialAnalysis/DataSource/PC.csv")  #Profit Centre
TC <- read.csv("~/Documents/FinancialAnalysis/DataSource/TC.csv")  #Transfer Codes


#Load Transactional Data form csv
TT <- read.csv("~/Documents/FinancialAnalysis/DataSource/TT.csv")                         #Bank Balance Sheets
#MF <- read.csv("~/Documents/FinancialAnalysis/DataSource/MF.csv",stringsAsFactors=FALSE)  #Mutual Funds

#TB <- read.csv("~/Documents/FinancialAnalysis/DataSource/TB.csv",stringsAsFactors=FALSE)  #TradeBook
#TBadj <- read.csv("~/Documents/FinancialAnalysis/DataSource/TBadj.csv",stringsAsFactors=FALSE)  #TradeBook Adjustments
#NSEcodes <- read.csv("~/Documents/FinancialAnalysis/DataSource/NSEcodes.csv",stringsAsFactors=FALSE)  #NSE codes

#Cleaning Data
TT$ValueDate <- as.character(TT$ValueDate)
TT$ChequeNumber <- as.character(TT$ChequeNumber)
TT$TransactionRemarks <- as.character(TT$TransactionRemarks)
TT$ValueDate <- as.Date(TT$ValueDate,"%d/%m/%Y")

CC$Short.Description <- as.character(CC$Short.Description)
CC$Description <- as.character(CC$Description)

#MF$Date <- as.Date(MF$Date)
#MF$Account <- factor(MF$Account)

#NSEcodes$code <- as.character(NSEcodes$code)

#CE$ValueDate <- as.Date(CE$ValueDate)
#CE$CostCentre <- factor(CE$CostCentre)
#TBtot <- rbind(TB,TBadj)

# TB$Action <- factor(TB$Action)
# TB$Exchange <- factor(TB$Exchange)
# TB$Segment <- factor(TB$Segment)
# TB$Date <- as.Date(TB$Date, "%d-%b-%Y")
# 
# TBadj$Action <- factor(TBadj$Action)
# TBadj$Exchange <- factor(TBadj$Exchange)
# TBadj$Segment <- factor(TBadj$Segment)
# TBadj$Date <- as.Date(TBadj$Date, "%d-%b-%Y")
