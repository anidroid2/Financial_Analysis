
#dependency : TTadv

CR <- subset(TTadv, TTadv$Account == "301")

CR_due <- aggregate(CR$, by = list(CR$month), FUN = sum)