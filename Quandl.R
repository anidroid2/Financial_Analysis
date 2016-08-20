library(Quandl)

Quandl.api_key("Y-qwwQZL4fW4hhUNXcy-")
d <- date(now())
current_date <- as.Date(d,"%a %b %d %H:%M:%S %Y")

#stock_data = Quandl("GOOG/NSE_INFY", start_date=current_date-5, end_date=current_date)

get_stock_price_day_close <- function(stock_id , check_date= current_date){
    stock_data = Quandl(stock_id, start_date=check_date-10, end_date=check_date)
    price <- stock_data[1,6]
    return(price)
}

get_code <- function(inp){
    op= (subset(NSEcodes,NSEcodes$Stock==inp)[1,2])
    return(op )
}

