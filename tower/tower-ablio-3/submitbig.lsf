#!/bin/bash
# Begin LSF Directives
#BSUB -P CFD162
#BSUB -W 0:30
#BSUB -nnodes 96
#BSUB -alloc_flags gpumps
#BSUB -q debug
#BSUB -alloc_flags "gpudefault"
#BSUB -J tower_ablio
#BSUB -o tower_ablio.%J
#BSUB -e tower_ablio.%J
#BSUB -u ndeveld@sandia.gov
#BSUB -N
#BSUB -B

umask 0002

# Load the amr-wind modules
source /gpfs/alpine/cfd162/proj-shared/ndevelder/builds/spack-manager-20221208/environments/fullstack/load-env.sh

#CONFFILE=UnstableABL_scaling1.inp
#jsrun -n 6000 -r6 -a 1 -g 1 -c 1 amr_wind $CONFFILE

jsrun -n 576 -r6 -a 1 -g 1 -c 1 exawind --awind 288 --nwind 288 amr-nalu-tower.yaml
