library(micropan)
library(tidyverse)

# read distance files
files <- file.path("distances", list.files("distances"))
dst.tbl <- files %>% map_df(read.table, header = T, fill = T)

# cluster
clst.blast <- bClust(dst.tbl, linkage="complete", threshold=0.75)

# pan matrix
panmat.blast <- panMatrix(clst.blast)
