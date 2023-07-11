Steps to run IEA 15-MW FSI simulations

The OpenFAST setup of the IEA 15-MW turbine is based on v1.1.6 adapted to run with OpenFAST 3.0. See branch here https://github.com/gantech/IEA-15-240-RWT/tree/v1.1.6_of3.0

1. Run OpenFAST using the C++ API inside the `openfast_run` folder like so `openfastcpp inp.yaml`. This runs OpenFAST with AeroDyn for 1 revolution at 15m/s. OpenFAST is set to blend from BEM (AeroDyn) to CFD loads at 3 revolutions over 1/4th of a revolution.

2. Copy the `.chkp`, `.dll.chp`, and `.nc` files to the `fsi_run` folder and run the `exawind` solver like so

``` shell
srun -n 1152 exawind --nwind 360 --awind 792 iea15mw-01.yaml &> log
```

3. Need to run a power curve - Suggested wind speeds are 5,6,7,8,9,10,10.59,12,14,17,20,23,25 - Total of 13 simulations. Start with 8, 10.59, 15 and then fill out other wind speeds as we see fit. 

Nate - 8.0, 10.59
Phil - 15.0 - Check parameters necessary for pitch deformations.
Shreyas - 7,9

4. Timesteps are dialed at rated rpm - 0.25 degree rotation for CFD - 1/16th of a degree for OpenFAST. Suggest keeping this fixed for all cases. We may have more time steps per revolution for Region II.

5. Mesh is here - /projects/hfm/gvijayak/IEA15MW/mesh/iea15mw_volume.exo

6. Phil will compile a common version of exawind + fsi for all of us to use on /projects/exawind


