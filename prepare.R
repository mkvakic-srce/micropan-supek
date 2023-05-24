
# table
library(tidyverse)
gnm.tbl <- suppressMessages(read_delim("rawdata/Clostridia_bacterium.csv", delim = ",")) %>% 
  select(Name = `#Organism Name`, Strain, Level, GenBank_FTP = `GenBank FTP`) %>% 
  mutate(genome_id = str_c("GID", 1:n())) %>% 
  mutate(GenBank_ID = str_remove(GenBank_FTP, "^.+/"))
gnm.tbl <- gnm.tbl[complete.cases(gnm.tbl),]

# https://github.com/larssnip/micropan#gene-scores
library(microseq)
dir.create("tmp")
set.seed(2020)
gff.tbl <- readFasta(file.path("rawdata", str_c(gnm.tbl$GenBank_ID[1], "_genomic.fna"))) %>% findGenes()

# https://github.com/larssnip/micropan#the-proteins-and-panprep
library(foreach)
library(doParallel)
registerDoParallel(32)
foreach (i=1:nrow(gnm.tbl)) %dopar% {
  genome <- readFasta(file.path("rawdata", str_c(gnm.tbl$GenBank_ID[i], "_genomic.fna")))
  findGenes(genome) %>%
    filter(Score > 40) %>%
    gff2fasta(genome) %>%
    mutate(Sequence = translate(Sequence)) %>%
    writeFasta(file.path("tmp", str_c(gnm.tbl$GenBank_ID[i], ".faa")))
}
library(micropan)
dir.create("faa")
nrows <- nrow(gnm.tbl)
foreach (i=1:nrow(gnm.tbl)) %dopar% {
  panPrep(file.path("tmp", str_c(gnm.tbl$GenBank_ID[i], ".faa")),
          gnm.tbl$genome_id[i],
          file.path("faa", str_c(gnm.tbl$GenBank_ID[i], ".faa")))
}
