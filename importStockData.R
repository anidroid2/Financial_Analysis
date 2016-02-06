#get Codes of Stocks
Scode <- read.csv("~/Documents/FinancialAnalysis/DataSource/StockCode.csv",stringsAsFactors=FALSE)
Scode$Type <- factor(Scode$Type)

Sduration <- read.csv("~/Documents/FinancialAnalysis/DataSource/duration.csv",stringsAsFactors=FALSE)

#get stock data from Yahoo Finance
#getSymbols(Scode$Code)
Scode$Code1 <- sapply(Scode$Code, function(x)  str_replace_all(x,"[^[:alnum:][.]]",""))    

