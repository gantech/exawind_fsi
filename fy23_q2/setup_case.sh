MESH=/projects/hfm/gvijayak/IEA15MW/mesh/iea15mw_volume.exo
for i in "$@"; do
    case "$1" in
        -w=*|--wind_speed=*)
            WIND_SPEED="${i#*=}"
            shift # past argument=value
            ;;
        -m=*|--mesh=*)
            MESH="${i#*=}"
            shift # past argument=value
            ;;
        --)
            shift
            break
            ;;
    esac
done

target_dir=wind_speed_$WIND_SPEED
mkdir -p $target_dir
cp -R openfast_run/* $target_dir
cp -R fsi_run/* $target_dir
cd $target_dir
# text replace the wind speed and mesh location in these files
aprepro -c# WIND_SPEED=$WIND_SPEED MESH=$MESH iea15mw-nalu-01.yaml iea15mw-nalu-01.yaml 
aprepro -c# WIND_SPEED=$WIND_SPEED iea15mw-amr-01.inp iea15mw-amr-01.inp 
aprepro -c# WIND_SPEED=$WIND_SPEED inp.yaml inp.yaml  
# run the openfast precursor for this file
openfastcpp inp.yaml
