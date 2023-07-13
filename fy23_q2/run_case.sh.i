#!/bin/bash 
#SBATCH -A hfm
#SBATCH -o ws_{WIND_SPEED}_log_%j.out
#SBATCH -J iea15mw_ws{WIND_SPEED}
#SBATCH -t 48:00:0
#SBATCH -N 32
#SBATCH --qos=high
{if(EMAIL)}
#SBATCH --mail-type=ALL
#SBATCH --mail-user={EMAIL}
{endif}

module use /projects/exawind/psakiev/spack-manager/modules
module load hfm_fsi_fy23/exawind-gcc-9.3.0

srun -n 1152 exawind --nwind 360 --awind 792 iea15mw-01.yaml &> log
