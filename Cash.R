#sort in descending order

#Asset Acct 101
Asset101 <-subset(TT,TT$Account==101,select = c(SNo., ValueDate,Balance.INR.))
Asset101 <- Asset101[order(-Asset101$SNo.),]
Asset101 <- Asset101[!duplicated(Asset101$ValueDate),]
Asset101 <- Asset101[order(Asset101$SNo.),]
Asset101 <- Asset101[,-1]
#ggplot(Asset101,aes(Asset101$ValueDate,Asset101$Balance.INR.))+geom_line()

#Asset Acct 102
Asset102 <-subset(TT,TT$Account==102,select = c(SNo.,ValueDate,Balance.INR.))
Asset102 <- Asset102[order(-Asset102$SNo.),]
Asset102 <- Asset102[!duplicated(Asset102$ValueDate),]
Asset102 <- Asset102[order(Asset102$SNo.),]
Asset102 <- Asset102[,-1]

#ggplot(Asset102,aes(Asset102$ValueDate,Asset102$Balance.INR.))+geom_line()

#Asset Acct 103
Asset103 <-subset(TT,TT$Account==103,select = c(SNo.,ValueDate,Balance.INR.))
Asset103 <- Asset103[order(-Asset103$SNo.),]
Asset103 <- Asset103[!duplicated(Asset103$ValueDate),]
Asset103 <- Asset103[order(Asset103$SNo.),]
Asset103 <- Asset103[,-1]

#ggplot(Asset103,aes(Asset103$ValueDate,Asset103$Balance.INR.))+geom_line()

#Asset CASH
Asset_C <- Reduce(function(x, y) merge(x, y,by= "ValueDate", all=TRUE), list(Asset101, Asset102, Asset103))
colnames(Asset_C) <- c("ValueDate","101","102","103")

#Convert NA to zero, hence enabling us to sum
Asset_C[is.na(Asset_C)] <- 0

#Adjust blank values created due to merge
Asset_C <-blank_adjustments(Asset_C)
Asset_C$Total <- rowSums(Asset_C[,-1])

#Cash Holding as on Date
#KPI_CASH = (tail(Asset_C$Total,1))
#Latest Cash Holding
KPI_CASH = tail(Asset101$Balance.INR.,1) + tail(Asset102$Balance.INR.,1) + tail(Asset103$Balance.INR.,1)
 
#Workspace Clean up
#rm(list=c("Asset101","Asset102","Asset103"))

