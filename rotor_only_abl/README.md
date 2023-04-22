*How to run the turbine in ABL simulation*


This only contains the turbine rotor. There's NO tower or nacelle.

1. First run the series of precursor simulations in `../precursor`

2. Run the rotor in ABL case as

``` shell
srun -n 1620 exawind --nwind 360 --awind 1260 nrel5mw-01.yaml &> log
```
