library(ggplot2)
#creating advanced datafram by replication
TTadv <- TT
TTadv$month <- months(TT$ValueDate)

levels_months <- c("January","February","March","April","May","June","July","August","September","October","November","December")
TTadv$month <- factor(TTadv$month,order = TRUE, levels= levels_months)
TTadv$year <- format(TTadv$ValueDate,"%Y")

#Bills Report
bills_table <- subset(TTadv,TTadv$CostCentre=="10BL")

bills_month_wide <- aggregate(bills_table$WithdrawalAmount.INR., by= list(bills_table$year,bills_table$month,bills_table$SubID),"sum")
colnames(bills_month_wide) <- c("Year","Month","SubID","Bill")
bills_month_wide <- bills_month_wide[order(bills_month_wide$Year,bills_month_wide$Month),]

bills_month_wide$SubID <- sapply(bills_month_wide$SubID, function(x) CC_subid2desc(x))

bills_month_wide$SubID <- as.factor(bills_month_wide$SubID)