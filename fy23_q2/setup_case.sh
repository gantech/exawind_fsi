
for i in "$@"; do
    case "$1" in
        -m=*|--machine=*)
            MACHINE="${i#*=}"
            shift # past argument=value
            ;;
        -w=*|--wind_speed=*)
            WIND_SPEED="${i#*=}"
            shift # past argument=value
            ;;
        -s=*|--submit=*)
            SUBMIT="${i#*=}"
            shift # past argument=value
            ;;
        -e=*|--email=*)
            EMAIL="${i#*=}"
            shift # past argument=value
            ;;
        --)
            shift
            break
            ;;
    esac
done

# must load things so that aprepro is active in the shell
# machine specific params i.e. mesh/restart/etc
aprepro_include=$(pwd)/${MACHINE}_aprepro.txt
source $(pwd)/${MACHINE}_setup_env.sh

# define rpm and pitch inputs for this wind speed
rpm_pitch_time=$(./process_turbine_params.py ${WIND_SPEED})
rpm=$(echo "$rpm_pitch_time" | awk '{print $1}')
pitch=$(echo "$rpm_pitch_time" | awk '{print $2}')
cfd_dt=$(echo "$rpm_pitch_time" | awk '{print $3}')
openfast_dt=$(echo "$rpm_pitch_time" | awk '{print $4}')
one_rev=$(echo "$rpm_pitch_time" | awk '{print $5}')
hun_rev = $((100 * $one_rev))

target_dir=wind_speed_$WIND_SPEED
mkdir -p $target_dir
cp -R openfast_run/* $target_dir
cp -R fsi_run/* $target_dir
cd $target_dir

# text replace the wind speed and mesh location in these files
# cfd input file replacements
aprepro -qW --include ${aprepro_include} WIND_SPEED=$WIND_SPEED iea15mw-nalu-01.yaml iea15mw-nalu-01.yaml 
aprepro -qW WIND_SPEED=$WIND_SPEED CFD_DT=$cfd_dt iea15mw-amr-01.inp iea15mw-amr-01.inp 
aprepro -qW CFD_DT=$cfd_dt ONE_REV=$one_rev HUN_REV=$hun_rev OPENFAST_DT=$openfast_dt iea15mw-nalu-01.yaml iea15mw-nalu-01.yaml  

# openfast model replacements
aprepro -qW --include ${aprepro_include} IEA-15-240-RWT-Monopile_ServoDyn.dat IEA-15-240-RWT-Monopile_ServoDyn.dat
aprepro -qW RPM=$rpm PITCH=$pitch  IEA-15-240-RWT-Monopile_ElastoDyn.dat IEA-15-240-RWT-Monopile_ElastoDyn.dat
aprepro -qW OPENFAST_DT=$openfast_dt IEA-15-240-RWT-Monopile.fst IEA-15-240-RWT-Monopile.fst

# openfastcpp input replacements 
aprepro -qW WIND_SPEED=$WIND_SPEED inp.yaml inp.yaml
aprepro -qW CFD_DT=$cfd_dt inp.yaml inp.yaml 
aprepro -qW ONE_REV=$one_rev inp.yaml inp.yaml 
aprepro -qW HUN_REV=$hun_rev inp.yaml inp.yaml

# submit script replacements
aprepro -qW --include ${aprepro_include} WIND_SPEED=$WIND_SPEED EMAIL=$EMAIL ../run_case.sh.i run_case.sh

# submit case if submit flag given
if [ -n "${SUBMIT}" ]; then
  if [ "${MACHINE}"=="snl-hpc" ]; then
    sbatch -M attaway,chama,skybridge run_case.sh
  else
    sbatch run_case.sh
  fi
fi
