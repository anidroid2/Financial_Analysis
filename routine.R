blank_adjustments <- function(x){
    op <- x
    for (n in 2:nrow(x)){
        for (m in 2:ncol(x)){
            if(op[n,m] == 0){
                op[n,m] <- op[n-1,m]
            }
        }
    }
    
    return(op)
}

#Return meaning from CC

CC_subid2desc <- function(x){
    p <- subset(CC,CC$SubID==x)[1,3]
    return(p)
    }