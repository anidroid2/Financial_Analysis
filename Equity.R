TBtot <- rbind(TB,TBadj)
TBtot$Stock <- factor(TBtot$Stock)

transaction_history <- aggregate(TBtot$Qty, by =list(TBtot$Stock,TBtot$Action),FUN="sum")

transaction_history<-transform(transaction_history,x=ifelse(Group.2 == "Buy",x,-x))

Holding_equity<-aggregate(transaction_history$x,by= list(transaction_history$Group.1),"sum")

Holding_equity <- subset(Holding_equity,x>0) 
Holding_equity$Group.1 <- as.character(Holding_equity$Group.1)

for (n in 1:nrow(Holding_equity)){
    Holding_equity[n,3] <- get_code(Holding_equity[n,1])
    Holding_equity[n,4] <- get_stock_price_day_close(Holding_equity[n,3],current_date)
}
    
Holding_equity$net_mrkt <- Holding_equity$x * Holding_equity$V4
colnames(Holding_equity) <- c("Stock","Quantity","QuantdlCode","Value","Holding")

AssetNetEquity <-sum(Holding_equity$Holding)


Demat_Holding<-transform(TBtot,x=ifelse(Action == "Buy",Qty,-Qty))
Demat_Holding <- aggregate(Demat_Holding$x,by=list(Demat_Holding$Date,Demat_Holding$Stock),FUN="sum")
Demat_Holding <- subset(Demat_Holding,x!=0) 
colnames(Demat_Holding) <- c("ActionDate","Stock","Action")


#Calculating Demat Valuation

Demat_action_dates<-unique(Demat_Holding$ActionDate)
Demat_action_dates <- sort(Demat_action_dates,decreasing = FALSE)
demat_valuation <- data.frame(Demat_action_dates)

j=1
for (n in Demat_action_dates){
    n <- as.Date(n)
    x <- subset(Demat_Holding, Demat_Holding$ActionDate <= n)
    
    
    x1 <- aggregate(x$Action,by=list(x$Stock),FUN="sum")
    colnames(x1) <- c("Stock","Qty")
    x1$Stock <- as.character(x1$Stock)
    
    for(i in 1:nrow(x1)){
        
        x1[i,3] <- get_code(x[i,2])
        x1[i,4] <- get_stock_price_day_close(x1[i,3],n)
        
    }
    x1$net <- x1$Qty * x1$V4
    demat_valuation[j,2] = sum(x1$net)
    j=j+1
}