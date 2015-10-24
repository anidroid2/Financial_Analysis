
TBtot$Stock <- factor(TBtot$Stock)

TBtot$Date <- paste(TBtot$Date,TBtot$X,TBtot$X.1)
TBtot$Date <- as.Date(TBtot$Date, "%d %b %Y")

t_history <- transform(TBtot, Qty= ifelse(Action == "Sell",-Qty, Qty))

t_history$net_cost <- t_history$Qty * t_history$Price + t_history$Brokerage.incl..taxes

holding <- aggregate(t_history$Qty,by = list(t_history$Stock),FUN= "sum")
colnames(holding) <- c("Stock","Qty")

#Remove stockwith no only previous holdings
holding <- holding[holding$Qty != 0,]

holding$Stockcode <- sapply(holding$Stock, get_code )
holding$NAVperUnit <- sapply(holding$Stockcode, get_stock_price_day_close)
#holding <- mutate(holding, NAV = NAVperUnit * Qty)
holding$NAV <- holding$NAVperUnit * holding$Qty

KPI_ICICI_Equity_Hold <- sum(holding$NAV)

MF_holding <- TTadv[TTadv$TransferCode == "40MF",]
KPI_MF_invest <- sum(MF_holding$WithdrawalAmount.INR.)

pie_value <- c(KPI_CASH, 18385, KPI_MF_invest, 40000)
pie_label <- c("Cash", "ICICI Equity", "Long Term Mutual Fund","Zerodha Equity Account")
pie_slices <- (pie_value/sum(pie_value))*100
asset_df <- data.frame(pie_label,pie_value,pie_slices)
colnames(asset_df) <- c("Type", "Amount in Rs.", "% allocation")

#ggplot(asset_df, aes(y = asset_df$pie_value, x= asset_df$pie_label)) + geom_bar(stat = "identity")
