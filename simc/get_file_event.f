      subroutine get_file_event(th_spec_e,th_spec_p,
     >    dxdz,dydz,e_mom,e_E,dxdzp,dydzp,p_mom,p_E,weight)
c
c  input variables:
c        th_spec_e : central spec angle for electron (rad)
c        th_spec_p : central spec angle for proton (rad)
c  output variables:
c        dxdz : xptar for electron
c        dydz : yptar for electron
c        e_mom : electron momentum ( MeV)
c        e_E : electron Energy ( MeV)
c        dxdzp : xptar for proton
c        dydzp : yptar for proton
c        p_mom : proton momentum ( MeV)
c        p_E : proton Energy ( MeV)
c        weight: event weight
c
c        NOTE: vertex also read in but currently ignored
c
      implicit none
	include 'simulate.inc'
c
         real*8 e_4v(4), e_4vr(4)
         real*8 p_4v(4), p_4vr(4)
         real*8 cth_hms, sth_hms, cth_shms, sth_shms
         real*8 th_spec_e
         real*8 th_spec_p
         real*8 e_mom,e_E,dxdz,dydz,e_vz
         real*8 p_mom,p_E,dxdzp,dydzp,p_vz
         real*8 w, weight
         character*80 multpifile
         integer count,count_miss
         logical first
         logical end_of_2pi_file
         data first /.true./
         common /eventfile/  end_of_2pi_file
c
        if ( first) then
           first = .false.
           count = 0.
           count_miss = 0.
           write(*,*) ' Which input file ?'
           read(*,'(a80)') multpifile
           write(*,*) ' Opening file ',multpifile
           open(unit=51,file=multpifile)
        endif
c
c
         end_of_2pi_file = .false. 
         read(51,*,end=999,err=999) e_4v,e_vz,p_4v,p_vz,w
         count = count + 1
	       if(debug(5)) then
             write(*,*) ' '
             write(*,*) ' NEW EVENT: ',count, weight
             write(*,*) '       HMS: ',e_4v(1),e_4v(2),e_4v(3),e_4v(4)
             write(*,*) '      SHMS: ',p_4v(1),p_4v(2),p_4v(3),p_4v(4)
             write(*,*) '    vertex: ',e_vz,p_vz
	       endif !debug
c
c Rotate 4-vectors to their respective frames
c This is a rotation around the x-axis, which points downwards
c --> the HMS is at negative angles, and the SHMS at positive angles
         cth_hms = cos(th_spec_e)
         sth_hms = sin(-th_spec_e)
         cth_shms = cos(th_spec_p)
         sth_shms = sin(th_spec_p)
c Rotatation about the x-axis --> only y, and z change
         e_4vr(1) = e_4v(1)
         e_4vr(2) = cth_hms * e_4v(2) - sth_hms * e_4v(3)
         e_4vr(3) = sth_hms * e_4v(2) + cth_hms * e_4v(3)
         e_4vr(4) = e_4v(4)
         p_4vr(1) = p_4v(1)
         p_4vr(2) = cth_shms * p_4v(2) - sth_shms * p_4v(3)
         p_4vr(3) = sth_shms * p_4v(2) + cth_shms * p_4v(3)
         p_4vr(4) = p_4v(4)
	       if(debug(5)) then
             write(*,*) ' '
             write(*,*) '    SPEC:'
             write(*,*) '     HMS: ',-th_spec_e/pi*180
             write(*,*) '    SHMS: ',th_spec_p/pi*180
             write(*,*) ' ROTATED: '
             write(*,*) '     HMS: ',e_4vr(1),e_4vr(2),e_4vr(3),e_4vr(4)
             write(*,*) '    SHMS: ',p_4vr(1),p_4vr(2),p_4vr(3),p_4vr(4)
	       endif !debug
c Calculate dxdz and dydz
         e_mom = sqrt(e_4vr(1)**2 + e_4vr(2)**2 + e_4vr(3)**2)
         p_mom = sqrt(p_4vr(1)**2 + p_4vr(2)**2 + p_4vr(3)**2)
         dxdz = e_4vr(1)/e_mom
         dydz = e_4vr(2)/e_mom
         dxdzp = p_4vr(1)/p_mom
         dydzp = p_4vr(2)/p_mom
c Convert momenta and energies into MeV
         e_mom = e_mom * 1000.
         p_mom = p_mom * 1000.
         e_E = e_4vr(4) * 1000.
         p_E = p_4vr(4) * 1000.
c Weight and vertex positions are read in correctly. 
c Vertez z is read in cm
         e_vz = e_vz * 1.
         p_vz = p_vz * 1.
         weight = w
	       if(debug(5)) then
             write(*,*) ' '
             write(*,*) 'SIMC INPUT: '
             write(*,*) '       HMS: ',dxdz,dydz,e_mom,e_E,e_vz
             write(*,*) '      SHMS: ',dxdzp,dydzp,p_mom,p_E,p_vz
	       endif !debug
c        
         return
c
 999     write(*,*) ' reached end of file'
         write(*,*) ' count = ',count
         write(*,*) ' count_miss = ',count_miss,float(count-count_miss)/float(count)
         end_of_2pi_file = .true.
         return
         end
