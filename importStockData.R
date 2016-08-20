#get Codes of Stocks
StockMD <- read.csv("~/Documents/FinancialAnalysis/DataSource/StockCodeNew.csv",stringsAsFactors=FALSE)
StockMD$Symbol <- substr( StockMD$Code, 1, nchar(StockMD$Code) - 3 )

Scode <- select(StockMD, 1:3) 

#Scode <- read.csv("~/Documents/FinancialAnalysis/DataSource/StockCode.csv",stringsAsFactors=FALSE)
#Scode$Type <-   factor(Scode$Symbol) 

duration_list <- c(default_year, default_year-1,default_year-2 , default_year-3,default_year -5)
Sduration <- as.data.frame(duration_list)

#get stock data from Yahoo Finance into new environment
if( init_env == 1){
    symbols_env <- new.env()
    getSymbols(Scode$Code,env = symbols_env)
    }
list_symbols <- as.list(symbols_env)
#Scode$Code1 <- sapply(Scode$Symbol, function(x)  str_replace_all(x,"[^[:alnum:][.]]",""))    

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

KPI_EQ <- sum(holding$worth)

MCapDist <- merge(holding, StockMD, by="Symbol")

InvestPie <- c(KPI_CASH,KPI_201,KPI_MF,KPI_EQ)
InvestPie_names <- c("Cash","Fixed Deposit","Mutual Funds","Equity")

MCapDist_byCap <-   MCapDist %>%
                    group_by(MarketCap) %>%
                    summarize(sum(worth))

MCapDist_bySec <-   MCapDist %>%
    group_by(Sector) %>%
    summarize(sum(worth))

MCapDist_byCapPie <- ggplot(MCapDist_byCap, aes(x="", y=MCapDist_byCap$`sum(worth)`, fill=MCapDist_byCap$MarketCap))+geom_bar(width = 1, stat = "identity")
MCapDist_byCapPie <- MCapDist_byCapPie+ coord_polar("y", start=0)
MCapDist_byCapPie <- MCapDist_byCapPie  +blank_theme +theme(axis.text.x=element_blank()) + geom_text(aes(y =`sum(worth)`/3 + c(0, cumsum(`sum(worth)`)[-length(`sum(worth)`)]), label = percent(`sum(worth)`/100000)), size=5)

MCapDist_bySecPie <- ggplot(MCapDist_bySec, aes(x="", y=MCapDist_bySec$`sum(worth)`, fill=MCapDist_bySec$Sector ))+geom_bar(width = 1, stat = "identity")
MCapDist_bySecPie <- MCapDist_bySecPie+ coord_polar("y", start=0)
MCapDist_bySecPie <- MCapDist_bySecPie +blank_theme +theme(axis.text.x=element_blank()) + geom_text(aes(y =`sum(worth)`/3 + c(0, cumsum(`sum(worth)`)[-length(`sum(worth)`)]), label = percent(`sum(worth)`/100000)), size=5)

