# simc - Hall C/A Physics Monte Carlo

SIMC (simc-file-input) is the standard Hall C Monte Carlo for
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

### Downloading singularity image (experimental)


```
wget \
https://eicweb.phy.anl.gov/jlab/simc-file-input/-/jobs/artifacts/master/raw/build/Singularity.simc.simg\?job\=simc_singularity \
-O Singularity.simc.simg
```


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

## Event file format
simc reads in your events from a plain text file. The format for this file is
one line per event where the following HMS and SHMS variables are given.
Note that at this point, we don't pass the vertex information yet **TODO**.
```bash
px_HMS py_HMS pz_HMS E_HMS vz_HMS px_SHMS py_SHMS pz_SHMS E_SHMS vz_SHMS weight
```
Definitions:
```
*_HMS :  HMS particle
*_SHMS:  SHMS particle
px,py,pz: paricle 3-momentum components in GeV
E: particle Energy in GeV
vz: z-vertex positin in cm (currently unused)
weight: event weight
```
Make sure you use the right coordinate system!
The coordinate system is at the target center with z pointing along the central
spectrometer angle, +x pointing vertical down and +y pointing to the left
(i.e. smaller HMS angles and larger SHMS angles).

## Tutorial
A simple example of how to use simc is installed under 
$SIMC_PREFIX/share/simc/examples.

1. (If needed:) Add the install bin directory to your PATH. For bash this would be:
```bash
export PATH=${SIMC_PREFIX}/bin:$PATH
```
2. Create an output directory for your example, e.g. /tmp/example. Point
   an environment variable to this directory so we can easily refer to it in
   this tutorial
```bash
export SIMC_TUTORIAL_DIR="<YOUR_TUTORIAL_DIR>"
```
3. Look at the simc help using the -h flag
```bash
simc -h
```
4. To run simc, you will need a configuration file (input file) and an event
   list. The input file defines the spectrometer settings, while the event file
   is a text that uses the format as described above. You can find the files
   for this example in $SIMC_PREFIX/share/simc/examples
   1. The configuration file is called example1.inp. You pass it to simc with
      the required -c flag
   2. The event list is called sample_events.dat
5. simc will need to know where to write its output files. You tell simce by
   passing the required -o flag.
6. Lets run simc!
```bash
simc -c $SIMC_PREFIX/share/simc/examples/example1.inp \
     -o $SIMC_TUTORIAL_DIR \
     $SIMC_PREFIX/share/simc/examples/sample_events.dat
```
7. This writes a couple of output files to your output directory. Let's go
   there and check it out!
```bash
cd $SIMC_TUTORIAL_DIR; ls
```
8. The two most important files are:
    1. example1.log: The log file containing the log output from simc
    2. example1.rzdat: An HBOOK file with the simc output. You can convert this
                       to the ROOT format using the h2root program that comes
                       with ROOT.
9. That's all!
