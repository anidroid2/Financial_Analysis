txtToCode <- function (x){
    return (Scode[Scode$Description==x,][,1])
    
}
# 
# blank_theme <- theme_minimal()+
#     theme(
#         axis.title.x = element_blank(),
#         axis.title.y = element_blank(),
#         panel.border = element_blank(),
#         panel.grid=element_blank(),
#         axis.ticks = element_blank(),
#         plot.title=element_text(size=14, face="bold")
#     )
# 

txt2xts <- function(x)
    return (get(x, pos=-1, envir=as.environment(symbols_env), mode="any", inherits=TRUE))
