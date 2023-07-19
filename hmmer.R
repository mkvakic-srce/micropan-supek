
library(tidyverse)
gnm.tbl <- suppressMessages(read_delim("rawdata/Clostridia_bacterium.csv", delim = ",")) %>% 
  select(Name = `#Organism Name`, Strain, Level, GenBank_FTP = `GenBank FTP`) %>% 
  mutate(genome_id = str_c("GID", 1:n())) %>% 
  mutate(GenBank_ID = str_remove(GenBank_FTP, "^.+/"))
gnm.tbl <- gnm.tbl[complete.cases(gnm.tbl),]

library(micropan)
pfam.db <- "/apptainer_data/Pfam-A.hmm"
dir.create("pfam")
hmmerScan(file.path("faa", str_c(gnm.tbl$GenBank_ID, "_", gnm.tbl$genome_id, ".faa")),
          dbase = pfam.db,
          threads = 4,
          out.folder = "pfam")
