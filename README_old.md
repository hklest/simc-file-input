# Old simc documentation

*You probably won't need the information past this point*.

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
