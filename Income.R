
#Dependency : TTadv

#Bills Report
i_stat <- subset(TTadv,TTadv$ProfitCentre=="20SA")

income_month_basis <- aggregate(i_stat$DepositAmount.INR., by= list(i_stat$month,i_stat$year),"sum")

colnames(income_month_basis) <- c("Month","Year","Income")

