Steps to reproduce HFM FY22-Q1 milestone

Develop, implement, and test a strategy for blade-resolved fluid-structure-interaction simulations that enables pitch control. Demonstrate a blade-resolved simulation of the NREL 5-MW turbine using the hybrid-Nalu-Wind/AMR-Wind solver coupled to OpenFAST with under uniform inflow conditions.  Document any challenges that will need to be addressed to complete the FY22 Q4 multi-turbine simulations.

1. Run OpenFAST using the C++ API inside the `openfast_run` folder like so `openfastcpp inp.yaml`. This runs OpenFAST with AeroDyn for 1 revolution at 15m/s. OpenFAST is set to blend from BEM (AeroDyn) to CFD loads at 3 revolutions over 1/4th of a revolution.

2. Copy the `.chkp` and `.dll.chp` files to the `fsi_pitch` folder and run the `exawind` solver like so

``` shell
srun -n 1152 exawind --nwind 360 --awind 792 nrel5mw-01.yaml &> log
```
