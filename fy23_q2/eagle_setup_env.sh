module use /projects/hfm/kmoore/spack-manager/modules
module load gcc/9.3.0
function ranks_per_node(){
  lscpu | grep -m 1 "CPU(s):" | awk '{print $2}'
}
