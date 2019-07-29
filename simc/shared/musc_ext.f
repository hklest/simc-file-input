	subroutine musc_ext(m2,p,rad_len,x_len,dth,dph,y,x)
C+_____________________________________________________________________
!
! MUSC - Simulate multiple scattering of any particle.
!        Used for extended scatterers.
!
! According to Particle Data Booklet, July 1994
!
C-_____________________________________________________________________

	implicit none

	real*8 Es, epsilon
	parameter (Es = 13.6)		!MeV
	parameter (epsilon = 0.088)

	real*8 rad_len, x_len, dth, dph, x, y
	real*8 beta, rx1, rx2, ry1, ry2
	real*8 m2, p
	real*8 musc_pdg, musc_with_tail

	if (rad_len.eq.0) return
	if (x_len.le.0 .or. rad_len.lt.0) then
	  write(6,*) 'x_len or rad_len < 0 in musc_ext.f'
	  write(6,*) 'This is bad.  Really bad.  Dont even ask how bad it is.'
	  write(6,*) 'Just fix it now.'
	  stop
	endif
	if (p.lt.10.) write(6,*)
     >    'Momentum passed to musc_ext.f should be in MeV, but p=',p

! Compute new trajectory angles and displacements (units are rad and cm)
	beta = p / sqrt(m2+p*p)

	rx1 = musc_with_tail(beta, p, rad_len)	
	rx2 = musc_with_tail(beta, p, rad_len)	
	ry1 = musc_with_tail(beta, p, rad_len)	
	ry2 = musc_with_tail(beta, p, rad_len)	

	dth = dth + rx1
	x   = x   + rx2*x_len/sqrt(12.) + rx1*x_len/2.
	dph = dph + ry1
	y   = y   + ry2*x_len/sqrt(12.) + ry1*x_len/2.

	return
	end
