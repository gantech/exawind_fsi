#!/bin/bash 
{SLURM_ARGS}
#SBATCH -o ws_{WIND_SPEED}_log_%j.out
#SBATCH -J iea15mw_ws{WIND_SPEED}
{if(EMAIL)}
#SBATCH --mail-type=ALL
#SBATCH --mail-user={EMAIL}
{endif}

nodes=$SLURM_JOB_NUM_NODES
ranks=$SLURM_NTASKS
rpn=$SLURM_JOB_SPUS_PER_NODE

nalu_ranks=$(( {NALU_NODES}*$rpn ))
amr_ranks=$(( $ranks-$nalu_ranks ))

# load the modules with exawind executable/setup the run env
# MACHINE_NAME will get populated via aprepro
source ../{MACHINE_NAME}_setup_env.sh

srun -N $nodes -n $ranks \
  exawind --nwind $nalu_ranks \
  --awind $amr_ranks iea15mw-01.yaml &> log

# isolate run artifacts to make it easier to automate restarts in the future
# if necessary
mkdir run_$SLURM_JOBID
mv *.log run_$SLURM_JOBID
mv *_log_* run_$SLURM_JOBID
mv timings.dat run_$SLURM_JOBID
mv forces*dat run_$SLURM_JOBID
