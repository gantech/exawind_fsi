*How to run the precursor ABL simulations*

1. Spin up - Run the ABL for 15000s without dumping any boundary data

``` shell
srun -n 540 amr_wind abl.inp
```

2. Run 5000s dumping boundary data restarting from the simulation in step 1.

``` shell
srun -n 540 amr_wind abl_restart.inp
```
