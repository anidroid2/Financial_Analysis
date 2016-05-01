#get Codes of Stocks
Scode <- read.csv("~/Documents/FinancialAnalysis/DataSource/StockCode.csv",stringsAsFactors=FALSE)
Scode$Type <- factor(Scode$Type)

duration_list <- c(default_year, default_year-1,default_year-2 , default_year-3,default_year -5)
Sduration <- as.data.frame(duration_list)

#get stock data from Yahoo Finance into new environment
#symbols_env <- new.env()
#getSymbols(Scode$Code,env = symbols_env)

list_symbols <- as.list(symbols_env)
Scode$Code1 <- sapply(Scode$Code, function(x)  str_replace_all(x,"[^[:alnum:][.]]",""))    

index_symbols <- names(list_symbols)

#transaction data calculations
stock_td <- tbl_df(TBz)
stock_td <- select(stock_td, -Trade.time)


#KPI Calculations
#stock_KPI <- tbl_df(Scode)
stock_holding <- select(stock_td, Symbol:Qty)

holding <-  stock_holding %>%
            group_by(Symbol,Type) %>%
            summarise(sum(Qty)) %>%
            spread(Type, 'sum(Qty)',fill = 0) %>%
            mutate(hold = B-S) %>%
            select(Symbol, hold) %>%
            filter(hold != 0)

holding$value <- sapply(holding$Symbol , function(x) tryCatch(
    {as.numeric(as.data.frame(tail(list_symbols[[paste0(x,".NS")]],1))[4]) }, #expression    
    error = function(err) {                                   #error Function 
        as.numeric(as.data.frame(tail(list_symbols[[paste0(x,".BO")]],1))[4])    #new expre
    }
))

holding <- mutate(holding, worth = hold *value)

KPI_EQ_Worth <- sum(holding$worth)
