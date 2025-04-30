	subroutine musc(m2,p,rad_len,dth,dph)
C+_____________________________________________________________________
!
! MUSC - Simulate multiple scattering of any particle.
! 
! ASSUMPTIONS: DTH and DPH given in milli-radians, RAD_LEN in radiation
!   lengths. The formula used is due to Rossi and Greisen (See the book
!   by Segre, NUCLEI AND PARTICLES, 1982, p. 48.) The formula assumes a
!   gaussian distribution for the scattering angle. It is further assumed
!   that the angles DTH and DPH are located at an angle with respect 
!   to the beam direction that is large enough so that DTH-DPH space can
!   be approximated as a cartesian space.
!
! D. Potterveld - Sept. 1985
!
! Add option for protons 
!   Precision not good enough for our thick targets. Latest values supplied:
!   Lynch and Dahl, NIM B58 (1991) 6.
!   Note, that there is a typo in Particle data booklet: eps = 0.088 instead
!   of 0.2! Precision: -5% deviation for H2, +8 for 238U at radiation 
!   lengths between ~ 0.01 and 1.
!
! H.J. Bulten - Aug. 1991
C-_____________________________________________________________________

	implicit none
	include '../simulate.inc'

	real*8 musc_pdg, musc_with_tail

	real*8 rad_len, dth, dph
	real*8 beta, m2, p
	logical heavy_tail

	if (rad_len.eq.0) return
	if (p.lt.25.) write(6,*)
     >		'Momentum passed to musc.f should be in MeV, but p=',p

! Compute new trajectory angles (units are rad)

	beta = p / sqrt(m2+p*p)

	if (doing_positron) then
	  dth = dth + musc_with_tail(beta, p, rad_len)
	  dph = dph + musc_with_tail(beta, p, rad_len)
	else
	  dth = dth + musc_pdg(beta, p, rad_len)
	  dph = dph + musc_pdg(beta, p, rad_len)
	endif

	return
	end
