Steps to run IEA 15-MW FSI simulations

The OpenFAST setup of the IEA 15-MW turbine is based on v1.1.6 adapted to run with OpenFAST 3.0. See branch here https://github.com/gantech/IEA-15-240-RWT/tree/v1.1.6_of3.0

1. Run the `setup_case.sh` script and supply a wind speed.

``` shell
./setup_case.sh -w 8.0
```

This will parse the wind speed into the input files consistently and run standalone openfast in new directory `wind_speed_8.0`.

2. Copy the `.chkp`, `.dll.chp`, and `.nc` files to the `fsi_run` folder and run the `exawind` solver like so

``` shell
srun -n 1152 exawind --nwind 360 --awind 792 iea15mw-01.yaml &> log
```

This command will be embedded into a template submission script inside the run directory with the name `run_case.sh` which you can edit as needed.
If you want an automated submission for eagle just include the `-s=True` flag to the setup script.  You can also provide your email to get notificaitons with the `-e=[your email address]` flag.


3. Need to run a power curve - Suggested wind speeds are 5,6,7,8,9,10,10.59,12,14,17,20,23,25 - Total of 13 simulations. Start with 8, 10.59, 15 and then fill out other wind speeds as we see fit. 

Nate - 8.0, 10.59
Phil - 15.0 - Check parameters necessary for pitch deformations.
Shreyas - 7,9

4. Timesteps are dialed at rated rpm - 0.25 degree rotation for CFD - 1/16th of a degree for OpenFAST. Suggest keeping this fixed for all cases. We may have more time steps per revolution for Region II.

5. Mesh is here - /projects/hfm/gvijayak/IEA15MW/mesh/iea15mw_volume.exo which is the default for the setup script but can be changed dynamically by giving the setup script a different mesh location i.e. `-m=/some/new/location`

6. Phil will compile a common version of exawind + fsi for all of us to use on /projects/exawind 


