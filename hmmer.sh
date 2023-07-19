#!/bin/bash

#PBS -l ncpus=4
#PBS -o output/
#PBS -e output/
#PBS -J 1-32
#PBS -m bae
#PBS -M marko.kvakic@srce.hr

cd ${PBS_O_WORKDIR:-""}

sleep $PBS_ARRAY_INDEX

apptainer exec \
  --pwd /host_pwd \
  --bind ${PWD}:/host_pwd \
  micropan-2.1.sif \
    Rscript hmmer.R
