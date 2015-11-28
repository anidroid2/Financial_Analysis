library(ggplot2)

#Dependency : TTadv

#Bills Report
SH <- subset(TTadv,TTadv$CostCentre=="15SH")


SH_BYM <- aggregate(SH$WithdrawalAmount.INR., by= list(SH$year,SH$month,SH$SubID),"sum")
#bills_month_wide$SubID <- as.character(bills_month_wide$SubID)
colnames(SH_BYM) <- c("Year","Month","SubID","shop_expense")
SH_BYM <- SH_BYM[order(SH_BYM$Year,SH_BYM$Month),]

SH_BYM$SubID <- sapply(SH_BYM$SubID, function(x) CC_subid2desc(x))
#bills_month_wide$SubID <- as.character(bills_month_wide$SubID)

SH_BYM$SubID <- as.factor(SH_BYM$SubID)