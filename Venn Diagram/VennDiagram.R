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

##-----------------------------------
# Using the ggvenn R package
##-----------------------------------

if (!require(devtools)) install.packages("devtools")
devtools::install_github("yanlinlin82/ggvenn")

library(ggvenn)
ggvenn(
  x, 
  fill_color = c("#0073C2FF", "#EFC000FF", "#868686FF", "#CD534CFF"),
  stroke_size = 0.5, set_name_size = 4
)

##-----------------------------------
# Using the ggVennDiagram R package
##-----------------------------------
if (!require(devtools)) install.packages("devtools")
devtools::install_github("gaospecial/ggVennDiagram")

library("ggVennDiagram")
ggVennDiagram(x, label_alpha = 0)

##-----------------------------------
# Using the VennDiagram R package
##-----------------------------------
install.packages("VennDiagram")

library(VennDiagram)
venn.diagram(x, filename = "venn-4-dimensions.png")

# Helper function to display Venn diagram
display_venn <- function(x, ...){
  library(VennDiagram)
  grid.newpage()
  venn_object <- venn.diagram(x, filename = NULL, ...)
  grid.draw(venn_object)
}

# Four dimension Venn plot
display_venn(x)

# Three dimension Venn plot
display_venn(x[1:3])

# Change category names
# Change fill color
display_venn(
  x,
  category.names = c("Set 1" , "Set 2 " , "Set 3", "Set 4"),
  fill = c("#999999", "#E69F00", "#56B4E9", "#009E73")
)

# Further customization
display_venn(
  x,
  category.names = c("Set 1" , "Set 2 " , "Set 3", "Set 4"),
  # Circles
  lwd = 2,
  lty = 'blank',
  fill = c("#999999", "#E69F00", "#56B4E9", "#009E73"),
  # Numbers
  cex = .9,
  fontface = "italic",
  # Set names
  cat.cex = 1,
  cat.fontface = "bold",
  cat.default.pos = "outer",
  cat.dist = c(0.055, 0.055, 0.1, 0.1)
)


##-----------------------------------
# Using the gplots R package
##-----------------------------------
install.packages("gplots")

library(gplots)
v.table <- venn(x)

# reference: https://www.datanovia.com/en/blog/venn-diagram-with-r-or-rstudio-a-million-ways/
