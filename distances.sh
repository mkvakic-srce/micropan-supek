#!/bin/bash

#PBS -l ncpus=1
#PBS -J 1-500
#PBS -M mkvakic@srce.hr
#PBS -m bae
#PBS -o output/
#PBS -e output/

cd ${PBS_O_WORKDIR}

export PBS_ARRAY_INDEX=${PBS_ARRAY_INDEX:-13}

apptainer exec \
  --pwd /host_pwd \
  --bind ${PWD}:/host_pwd \
  micropan-2.1.sif \
    Rscript distances.R
