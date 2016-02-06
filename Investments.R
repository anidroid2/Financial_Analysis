#Asset Acct 102
Invest201 <-subset(TT,TT$Account==201,select = c(SNo., ValueDate,Balance.INR.))
Invest201 <- Invest201[order(-Invest201$SNo.),]
Invest201 <- Invest201[!duplicated(Invest201$ValueDate),]
KPI_201 <- head(Invest201$Balance.INR.,1) 

InvestMF <-subset(TT,TT$TransferCode=="40MF",select = c(ValueDate,WithdrawalAmount.INR.))
#Invest201 <- Invest201[!duplicated(Invest201$ValueDate),]

KPI_MF <- sum(InvestMF$WithdrawalAmount.INR.)

InvestEQ <- subset(TT,TT$Account==401,select = c(ValueDate,Balance.INR.))

KPI_EQ <- tail(InvestEQ$Balance.INR.,1)


InvestPie <- c(KPI_CASH,KPI_201,KPI_MF,KPI_EQ)
InvestPie_names <- c("Cash","Fixed Deposit","Mutual Funds","Equity")
    
#p_plot <- pie(InvestPie,InvestPie_names,main="Asset Allocation -Current")