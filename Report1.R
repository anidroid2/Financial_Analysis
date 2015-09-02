setwd("/home/aniket/Documents/FinancialAnalysis/Dev")
load("R_ws.RData")

#CASH ASSET PLOT
p=ggplot(Asset_C,aes(Asset_C$ValueDate,Asset_C$Total))+geom_line()
print(p)
rm(p)