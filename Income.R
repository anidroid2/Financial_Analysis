
#Dependency : TTadv

#Bills Report
IN <- subset(TTadv,TTadv$ProfitCentre=="20SA")

IN_BYM <- aggregate(IN$DepositAmount.INR., by= list(IN$month,IN$year),"sum")

colnames(IN_BYM) <- c("Month","Year","Income")

