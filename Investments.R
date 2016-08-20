#Asset Acct 102
Invest201 <-subset(TT,TT$Account==201,select = c(SNo., ValueDate,Balance.INR.))
Invest201 <- Invest201[order(-Invest201$SNo.),]
Invest201 <- Invest201[!duplicated(Invest201$ValueDate),]
KPI_201 <- head(Invest201$Balance.INR.,1) 

InvestMF <-subset(TT,TT$TransferCode=="40MF",select = c(ValueDate,WithdrawalAmount.INR.))
#Invest201 <- Invest201[!duplicated(Invest201$ValueDate),]

KPI_MF <- sum(InvestMF$WithdrawalAmount.INR.)

InvestEQ <- TTadv %>%
            filter(TransferCode == "40EQ") %>%
            select( qtryear ,WithdrawalAmount.INR.,DepositAmount.INR.) %>%
            mutate(Net = WithdrawalAmount.INR. - DepositAmount.INR.) %>%
            select(qtryear ,Net ) %>%
            group_by(qtryear) %>%
            summarise(Net = sum(Net))

InvestEQ$qtryear <- chartr(".","/" , InvestEQ$qtryear)
InvestEQ$inout <- ifelse(InvestEQ$Net < 0,"Out","In")

