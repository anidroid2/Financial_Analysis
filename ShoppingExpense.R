library(ggplot2)

#Dependency : TTadv

#Bills Report
shop_expense_table <- subset(TTadv,TTadv$CostCentre=="15SH")


shop_expense_month_wide <- aggregate(shop_expense_table$WithdrawalAmount.INR., by= list(shop_expense_table$year,shop_expense_table$month,shop_expense_table$SubID),"sum")
#bills_month_wide$SubID <- as.character(bills_month_wide$SubID)
colnames(shop_expense_month_wide) <- c("Year","Month","SubID","shop_expense")
shop_expense_month_wide <- shop_expense_month_wide[order(shop_expense_month_wide$Year,shop_expense_month_wide$Month),]

shop_expense_month_wide$SubID <- sapply(shop_expense_month_wide$SubID, function(x) CC_subid2desc(x))
#bills_month_wide$SubID <- as.character(bills_month_wide$SubID)

shop_expense_month_wide$SubID <- as.factor(shop_expense_month_wide$SubID)