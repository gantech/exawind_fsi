Steps to run IEA 15-MW FSI simulations

The OpenFAST setup of the IEA 15-MW turbine is based on v1.1.6 adapted to run with OpenFAST 3.0. See branch here https://github.com/gantech/IEA-15-240-RWT/tree/v1.1.6_of3.0

1. Run OpenFAST using the C++ API inside the `openfast_run` folder like so `openfastcpp inp.yaml`. This runs OpenFAST with AeroDyn for 1 revolution at 15m/s. OpenFAST is set to blend from BEM (AeroDyn) to CFD loads at 3 revolutions over 1/4th of a revolution.

2. Copy the `.chkp`, `.dll.chp`, and `.nc` files to the `fsi_run` folder and run the `exawind` solver like so

``` shell
srun -n 1152 exawind --nwind 360 --awind 792 iea15mw-01.yaml &> log
```
