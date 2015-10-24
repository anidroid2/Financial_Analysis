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

f <- function(x){
    year_v <- x[1]
    year_num <- numeric(year_v)
    y_list <- list(year_v = year_num)
    op <- c(op, y_list)
    print(op)
    
}