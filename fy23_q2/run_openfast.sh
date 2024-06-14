#!/bin/bash
cd $1/openfast_run
rm *chkp *out
srun --exclusive openfastcpp inp.yaml &> log
