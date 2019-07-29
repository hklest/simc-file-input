	real*8 function musc_with_tail(beta,p,rad_len)
C+_____________________________________________________________________
!
! MUSC_WITH_TAILS - Improved implementation of multiple scattering.
!                
!     This implementation improves on the PDG (Highland) formalism by
!     By adding a more realistic "tuned" (to HRS) heavy gaussian tail
!     by Michael Paolone.
!
!     This formalism could further improved by replacing the Gaussian
!     with a Lynch-Dahl Gaussian as suggested by PDG, and by using the
!     true Moliere tail, but this comes at a cost of significantly
!     complicating the formula (everything because explicititly (A,Z)
!     dependent. 
!
!  Sylvester Joosten (sjoosten@anl.gov, 2019)
!
C-_____________________________________________________________________

	implicit none

! Improved formalismas in Lynch-Dahl eq. 6
	real*8 Es, epsilon
	parameter (Es = 13.6)		!MeV
	parameter (epsilon = 0.088)
	real*8 rad_len
	real*8 beta, theta_sigma, p
	real*8 nsig_max
	parameter(nsig_max=99.0e0)   !max #/sigma for gaussian ran #s.
	real*8 gauss1
	real*8 norm, a
	real*8 tail_factor

! This factor adjust the total extra tail width of the wide gaussian
! --> 1.15 to 1.2 works well for the HRS spectrometers. Adjust as
! needed.
	parameter(tail_factor=1.2)

! Start out by calculating theta_sigma as in musc_pdg
	theta_sigma = Es/p/beta * sqrt(rad_len) * (1+epsilon*log10(rad_len/beta**2))

! Empirical fit to normalize the gaussian to have an "identical" width
! below the defined width( good to 1-2%). Good between tail_factor
! between 1.0 --> 20.0. Not good below 1.0
	norm = 0.155619 / (tail_factor + 0.444642) + 1.0 
     > - exp(-tail_factor * tail_factor) / 10.0

! Actual algorithm
	theta_sigma = theta_sigma / norm
	a = gauss1(nsig_max) * theta_sigma
	do while (abs(a) > theta_sigma)
		theta_sigma = tail_factor * abs(a)
		a = gauss1(nsig_max) * theta_sigma
	end do

		musc_with_tail = gauss1(nsig_max) * theta_sigma

	return
	end 
