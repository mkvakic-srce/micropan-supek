#!/bin/bash

#PBS -l ncpus=1
#PBS -l mem=150GB
#PBS -M mkvakic@srce.hr
#PBS -m bae
#PBS -o output/
#PBS -e output/

cd ${PBS_O_WORKDIR:-""}

apptainer exec \
  --pwd /host_pwd \
  --bind ${PWD}:/host_pwd \
  micropan-2.1.sif \
    Rscript clustering.R
