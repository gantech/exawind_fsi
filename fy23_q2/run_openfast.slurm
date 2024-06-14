#!/bin/bash

#SBATCH --nodes=1
#SBATCH --time=4:00:00
#SBATCH --account=hfm
#SBATCH --job-name=iea15mw_powercurve
#SBATCH --output=out.%x_%j
#SBATCH --mail-type=ALL
#SBATCH --mail-user=ganesh.vijayakumar@nrel.gov


module load cray-python
module swap PrgEnv-cray PrgEnv-intel
export EXAWIND_MANAGER=/home/gvijayak/exawind-manager
source /home/gvijayak/exawind-manager/start.sh
spack-start
quick-activate /home/gvijayak/exawind-manager/environments/fsi
spack load openfast

ls -d wind_speed* | xargs -n 1 -P 13 bash run_openfast.sh
