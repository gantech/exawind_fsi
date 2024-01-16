#!/bin/bash

wind_speeds=(5.0 6.0 7.0 8.0 9.0 10.0 10.59 11.0 12.0 14.0 17.0 20.0 23.0)
#wind_speeds=(5.0 8.0 10.59 14.0)
#wind_speeds=(5.0 8.0 12.0)
for w in "${wind_speeds[@]}"; do
  echo "Setting up directory for wind speed $w"
  ./setup_case.sh -m=amber -e="${USER}@sandia.gov" -w="$w" -s=1 -p=1 -c=1 -n=30 -l=80.0 -d=/pscratch/ndeveld/hfm-2023-q4/hfm_fy23_q1_final/full_iea15mw
done
  
