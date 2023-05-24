#!/bin/bash

apptainer exec \
  --pwd /host_pwd \
  --bind ${PWD}:/host_pwd \
  micropan-2.1.sif \
    Rscript prepare.R
