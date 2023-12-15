module load gcc/9.3.0
module load mpt/2.22
export SPACK_MANAGER=/projects/hfm/kmoore/spack-manager
source $SPACK_MANAGER/start.sh
spack-start
spack env activate /projects/hfm/kmoore/spack-manager/environments/exawind
spack load exawind
spack load rosco
spack load nalu-wind
spack load amr-wind
spack load openfast

function ranks_per_node(){
  lscpu | grep -m 1 "CPU(s):" | awk '{print $2}'
}
