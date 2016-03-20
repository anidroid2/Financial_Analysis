
#dependency : TTadv

CR <- subset(TTadv, TTadv$Account == "301")

KPI_CCdue <- sum(CR$WithdrawalAmount.INR. ) - sum(CR$DepositAmount.INR.)