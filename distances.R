library(stringr)
library(micropan)

# get pair blasts for index
ind <- Sys.getenv("PBS_ARRAY_INDEX")
pattern <- paste("GID", ind, "_", sep="")
files_pair <- file.path("blast", list.files("blast", pattern=pattern))

# get self blasts for pair files
gids <- str_match(files_pair, '_GID[0-9]+') %>% str_match(., '[0-9]+')
files_self <- lapply(gids, function(x){ sprintf("blast/GID%s_vs_GID%s.txt", x, x) }) %>% unlist

# create table
files <- c(files_pair, files_self)
self.tbl <- readBlastSelf(files)
pair.tbl <- readBlastPair(files)
dst.tbl <- bDist(blast.tbl = bind_rows(self.tbl, pair.tbl))

# save table
dir.create("distances")
table_path <- sprintf("distances/GID%s.R", ind)
write.table(dst.tbl, table_path)
