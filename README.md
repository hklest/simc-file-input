# simc_gfortran - Hall C/A Physics Monte Carlo

SIMC (simc_gfortran) is the standard Hall C Monte Carlo for
coincidence reactions, written in FORTRAN.

## Features


* SIMC simulates the optics (using COSY models) and apertures of the
  Hall C spectrometers (HMS, SOS, SHMS) and other spectrometers at
  [Jefferson Lab](http://www.jlab.org/) (HRS's, BigCal, ...)
* Radiative effects, multiple scattering, ionization energy loss and
  particle decay are included
* Simple presecriptions are available for Final State Interactions,
  Coulomb Corrections and other effects.
* This is a modified version of simc with the following additions:
  1. Capable of reading events from an input file. ***This is currently the
     the only mode that is supported***
  2. CMAKE based build system
  3. Launcher that allows the simc program to be invoked from any directory

## Building This Version

### On your own machine
1. Ensure you have the dependencies installed:
    1. gfortran
    2. python3
2. Pick a directory where you would like to build simc, e.g. $HOME/build, go to
   this directory.
3. Clone the simc-file-input repository
```bash
git clone --recurse-submodules git@gitlab.com:jpsi007/simc-file-input.git
cd simc-file-input
mkdir build  && cd build
```
3. Decide where you would like to install the package, e.g. /usr/local or 
   $HOME/stow/simc_file_input
4. Point the SIMC_PREFIX environment variable to this install directory.
```bash
export SIMC_PREFIX="<YOUR_INSTALL_DIRECTORY_HERE>"
```
5. Run cmake and make:
```bash
cmake ../. -DCMAKE_INSTALL_PREFIX=$SIMC_PREFIX
make -j4 install
```

### On the farm
1. Use bash
```bash
bash
```
2. Enable the module system
```bash
source /etc/profile.d/modules.sh
source /group/c-csv/local/setup.sh
```
3. Load the dependencies
```bash
module load gcc/latest
module load cmake/latest
export PATH=/apps/python/3.4.3/bin/:$PATH
```
2. Pick a directory where you would like to build simc, e.g. in your work 
   directory$HOME/build, go to this directory.
3. Clone the simc-file-input repository
```bash
git clone --recurse-submodules git@gitlab.com:jpsi007/simc-file-input.git
cd simc-file-input
mkdir build  && cd build
```
3. Decide where you would like to install the package, e.g 
   $HOME/stow/simc_file_input
4. Point the SIMC_PREFIX environment variable to this install directory.
```bash
export SIMC_PREFIX="<YOUR_INSTALL_DIRECTORY_HERE>"
```
5. Run cmake and make:
```bash
cmake ../. -DCMAKE_INSTALL_PREFIX=$SIMC_PREFIX
make -j4 install
```

# Old simc documentation

## Reactions

***At this time, this version of simc only supports running from an external
   event list. Running with the internal generator will be enabled in the
   launcher soon.***
   
SIMC has physics models for the following reactions.
* Elastic and quasi-elastic scatering: H(e,e'p), A(e,e'p)
* Exclusive pion production: H(e,e'pi+)n, A(e,e'pi+/-)
(quasifree or coherent)
* Kaon electroproduction: H(e,e'K+)Lambda,Sigma, A(e,e'K+/-),A(e,e'K-)
* Semi-inclusive pion production: H(e,e'pi+/-)X, D(e,e'pi+/-)X
* Semi-inclusive kaon production: H(e,e'K+/-)X, D(e,e'K+/-)X
* Diffractive rho production: H(e,e'rho->pi+ pi-)p, D(e,e'rho->pi+
pi-)

## SIMC is NOT

* Not a full detector response simulation a la GEANT/GEANT4
* Does NOT simulate a large class of processes simultaneously to
gerate backgrounds (like Pythia for example)
* Not a generic event generator.  Processes are generated over a
limited phase space matching the spectrometer acceptances
* Not hard to modify

## Overview

An overview of SIMC can be found in
[this presentation at the 2009 Hall A Collaboration
Meeting](http://hallaweb.jlab.org/collab/meeting/2009-winter/talks/Analysis%20Workshop%20--%20Dec%2014/simc_overview.pdf)

## Documentation

For more information, see the [SIMC Monte Carlo page in the Hall C
Wiki](https://hallcweb.jlab.org/wiki/index.php/SIMC_Monte_Carlo)