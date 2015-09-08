library(ggplot2)
#creating advanced datafram by replication
TTadv <- TT
TTadv$month <- months(TT$ValueDate)

levels_months <- c("January","February","March","April","May","June","July","August","September","October","November","December")
TTadv$month <- factor(TTadv$month,order = TRUE, levels= levels_months)
TTadv$year <- format(TTadv$ValueDate,"%Y")

#Bills Report
bills_table <- subset(TTadv,TTadv$CostCentre=="10BL" & TTadv$year == 2015)
bills_month_wide$SubID <- as.character(bills_month_wide$SubID)
bills_month_wide <- aggregate(bills_table$WithdrawalAmount.INR., by= list(bills_table$year,bills_table$month,bills_table$SubID),"sum")
colnames(bills_month_wide) <- c("Year","Month","SubID","Bill")
bills_month_wide <- bills_month_wide[order(bills_month_wide$Year,bills_month_wide$Month),]

bills_month_wide$SubID <- lapply(bills_month_wide$SubID, function(x) CC_subid2desc(x))
bills_month_wide$SubID <- as.character(bills_month_wide$SubID)

g <- ggplot(bills_month_wide,aes(x=bills_month_wide$Month,y=bills_month_wide$Bill ,fill=bills_month_wide$SubID)) + geom_bar(stat="identity")

bills_month_wide$SubID <- as.factor(bills_month_wide$SubID)

print(g)