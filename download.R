
# table
library(tidyverse)
gnm.tbl <- suppressMessages(read_delim("rawdata/Clostridia_bacterium.csv", delim = ",")) %>% 
  select(Name = `#Organism Name`, Strain, Level, GenBank_FTP = `GenBank FTP`) %>% 
  mutate(genome_id = str_c("GID", 1:n())) %>% 
  mutate(GenBank_ID = str_remove(GenBank_FTP, "^.+/"))
gnm.tbl <- gnm.tbl[complete.cases(gnm.tbl),]

# download
library(R.utils)
library(foreach)
library(doParallel)
registerDoParallel(32)
foreach (i=1:nrow(gnm.tbl)) %dopar% {
  filename <- str_c(gnm.tbl$GenBank_ID[i], "_genomic.fna.gz")
  download.file(url = file.path(gnm.tbl$GenBank_FTP[i], filename),
                destfile = file.path("rawdata", filename))
  gunzip(file.path("rawdata", filename), overwrite = F)
}
