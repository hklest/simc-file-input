################################################################################
## Fortran Compiler Settings 

## extra fortran compiler flags
get_filename_component (Fortran_COMPILER_NAME ${CMAKE_Fortran_COMPILER} NAME)
## gfortran
if (Fortran_COMPILER_NAME MATCHES "gfortran.*")

  set (gfortran_EXTRA_FLAGS "-fdefault-real-8")
  set (CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} ${gfortran_EXTRA_FLAGS}")
  set (CMAKE_Fortran_FLAGS_RELEASE "${CMAKE_Fortran_FLAGS_RELEASE} ${gfortran_EXTRA_FLAGS}")
  set (CMAKE_Fortran_FLAGS_DEBUG   "${CMAKE_Fortran_FLAGS_DEBUG} ${gfortran_EXTRA_FLAGS}")
  set (CMAKE_Fortran_FLAGS_RELWITHDEBINFO "${CMAKE_Fortran_FLAGS_RELWITHDEBINFO} ${gfortran_EXTRA_FLAGS}")

## g77
elseif (Fortran_COMPILER_NAME MATCHES "g77.*")

  set (g77_EXTRA_FLAGS "-fdefault-real-8")
  set (CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} ${g77_EXTRA_FLAGS}")
  set (CMAKE_Fortran_FLAGS_RELEASE "${CMAKE_Fortran_FLAGS_RELEASE} ${g77_EXTRA_FLAGS}")
  set (CMAKE_Fortran_FLAGS_DEBUG   "${CMAKE_Fortran_FLAGS_DEBUG} ${g77_EXTRA_FLAGS}")
  set (CMAKE_Fortran_FLAGS_RELWITHDEBINFO "${CMAKE_Fortran_FLAGS_RELWITHDEBINFO} ${g77_EXTRA_FLAGS}")

## add additional compilers here
## other compilers use the defaults:
else ()
  message ("CMAKE_Fortran_COMPILER full path: " ${CMAKE_Fortran_COMPILER})
  message ("Fortran compiler: " ${Fortran_COMPILER_NAME})
  message ("No optimized Fortran compiler flags are known, using the defaults...")
  message ("Add the correct rules to cmake/compiler.cmake if other behavior is"
           "required.")
endif ()
