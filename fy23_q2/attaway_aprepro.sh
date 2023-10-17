{SLURM_ARGS = '
#SBATCH -A FY190020
#SBATCH -t 96:00:00
#SBATCH --qos=long
#SBATCH -N 40'}

{MACHINE_NAME="attaway"}
{NALU_RANK_PERCENTAGE=25}
{MESH="/projects/wind/meshes/split/iea15mw/iea15mw_3blade_volume_v0.1.exo"}
{DLL="/projects/wind/spack-manager/environments/hfm-fsi/opt/linux-rhel7-skylake_avx512/intel-2021.3.0/rosco-2.7.0-tyghuah43gqtdef6cskyksnq2uktlcfq/lib/libdiscon.so"}

{CLEANUP_ARGS = '
chown $USER:wg-sierra-users .
chmod g+s .
'}
