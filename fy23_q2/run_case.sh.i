#!/bin/bash 
{SLURM_ARGS}
#SBATCH -o ws{WIND_SPEED}_log_%j.out
#SBATCH -J ws{WIND_SPEED}_iea15mw
{if(EMAIL)}
#SBATCH --mail-type=ALL
#SBATCH --mail-user={EMAIL}
{endif}

# load the modules with exawind executable/setup the run env
# MACHINE_NAME will get populated via aprepro
source ../{MACHINE_NAME}_setup_env.sh

nodes=$SLURM_JOB_NUM_NODES
rpn=$(ranks_per_node)
ranks=$(( $rpn*$nodes ))

nalu_ranks=$(( ($ranks*{NALU_RANK_PERCENTAGE})/100 ))
amr_ranks=$(( ($ranks-$nalu_ranks ))

srun -N 1 -n 1 openfastcpp inp.yaml
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
