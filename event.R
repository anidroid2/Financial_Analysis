
TR <- filter(TTadv, CostCentre == "90TR" | ProfitCentre == "90TR" ) %>%
        select(WithdrawalAmount.INR.,DepositAmount.INR. ,SubID) %>%
        group_by(SubID) %>%
        summarise(expenditure= sum(WithdrawalAmount.INR.) - sum (DepositAmount.INR.))

get_event_name <- function(n){
    out <-(filter(CC, SubID == n))[1,3]
    out
}



TR$Desc <- lapply(TR$SubID, function(x) get_event_name(x))

TR <- select(TR, Desc,expenditure)


