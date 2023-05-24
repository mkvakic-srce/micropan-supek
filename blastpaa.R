
# index
index <- Sys.getenv("PBS_ARRAY_INDEX")

# https://github.com/larssnip/micropan#the-blastpallall
library(micropan)
dir.create("blast")
faa.files <- list.files("faa",
                        pattern = "\\.faa$",
                        full.names = T)
blastpAllAll(faa.files,
             out.folder = "blast",
             job = strtoi(index)+1,
             start.at = 1,
             threads = 3,
             verbose = T)
