	real*8 function musc_pdg(beta,p,rad_len)
C+_____________________________________________________________________
!
! MUSC - Implementation of the PDG formula for multiple scattering
!
! According to Particle Data Booklet, July 1994
!
C-_____________________________________________________________________

	implicit none

	real*8 Es, epsilon
	parameter (Es = 13.6)		!MeV
	parameter (epsilon = 0.088)

	real*8 rad_len
	real*8 beta, theta_sigma, p

	real*8 nsig_max
	parameter(nsig_max=99.0e0)      !max #/sigma for gaussian ran #s.

	real*8 gauss1

	theta_sigma = Es/p/beta * sqrt(rad_len) * (1+epsilon*log10(rad_len/beta**2))

	musc_pdg = gauss1(nsig_max) * theta_sigma 
	return
	end 
