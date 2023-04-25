##-----------------------------------
# Demo data
##-----------------------------------
set.seed(20190708)
genes <- paste("gene",1:1000,sep="")
x <- list(
  A = sample(genes,300), 
  B = sample(genes,525), 
  C = sample(genes,440),
  D = sample(genes,350)
)

# create the upset
install.packages("UpSetR")
library(UpSetR)
upset(fromList(x), order.by = "freq")

# Ref: https://www.youtube.com/watch?v=n9MRCZxJOfk&t=319s

