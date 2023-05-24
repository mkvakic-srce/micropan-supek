#!/bin/bash

#PBS -l ncpus=4
#PBS -o output/
#PBS -e output/
#PBS -J 1-128
#PBS -m bae
#PBS -M marko.kvakic@srce.hr
#PBS -N micropan-Clostridia

# cd
cd ${PBS_O_WORKDIR:-""}

# clean
rm -f blast/

# sleep
sleep $PBS_ARRAY_INDEX

# run
apptainer exec \
  --pwd /host_pwd \
  --bind ${PWD}:/host_pwd \
  micropan-2.1.sif \
    Rscript blastpaa.R
