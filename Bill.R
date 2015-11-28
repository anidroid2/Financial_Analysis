library(ggplot2)
#creating advanced datafram by replication
TTadv <- TT
TTadv$month <- months(TT$ValueDate)


TTadv$month <- factor(TTadv$month,order = TRUE, levels= levels_months)
TTadv$year <- format(TTadv$ValueDate,"%Y")

#Bills Report
BL <- subset(TTadv,TTadv$CostCentre=="10BL")

BL_BYM <- aggregate(BL$WithdrawalAmount.INR., by= list(BL$year,BL$month,BL$SubID),"sum")
colnames(BL_BYM) <- c("Year","Month","SubID","Bill")
BL_BYM <- BL_BYM[order(BL_BYM$Year,BL_BYM$Month),]

BL_BYM$SubID <- sapply(BL_BYM$SubID, function(x) CC_subid2desc(x))

BL_BYM$SubID <- as.factor(BL_BYM$SubID)