module use /projects/wind/spack-manager/modules
module load linux-rhel7-skylake_avx512/hfm-fsi/exawind-intel-2021.3.0
function ranks_per_node(){
  return lscpu | grep -m 1 "CPU(s):" | awk '{print $2}'
}
