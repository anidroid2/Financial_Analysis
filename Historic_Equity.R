historic_equity_investment <- TT[TT$TransferCode == "40EQ",]

start_date <- as.Date("30-04-2015","%d-%m-%Y")
end_date <- as.Date("30-04-2016","%d-%m-%Y")

historical_trend <- data.frame()

cal_date <- seq(start_date, current_date,by= "month")

withdraw <- aggregate(historic_equity_investment$WithdrawalAmount.INR., by= list(historic_equity_investment$Account), "sum")
deposit <- aggregate(historic_equity_investment$DepositAmount.INR.,by= list(historic_equity_investment$Account),FUN = "sum")

trend <- historic_equity_investment[historic_equity_investment$ValueDate < current_date,]
hold_value <- sum(trend$WithdrawalAmount.INR.) - sum(trend$DepositAmount.INR.)


#for (i in cal_date){
    
    
    
#}