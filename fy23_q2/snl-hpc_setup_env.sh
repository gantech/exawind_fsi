module use /projects/wind/spack-manager/modules
if [[ "${SNLCLUSTER}" == "attaway" ]]; then 
module load linux-rhel7-skylake_avx512/hfm-fsi/exawind-intel-2021.3.0
else
module load linux-rhel7-x86_64/hfm-fsi/exawind-intel-2021.3.0
fi
