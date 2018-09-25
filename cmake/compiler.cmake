################################################################################
## global defines
################################################################################
## set the RPATH for OsX
if (${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
  set(CMAKE_MACOSX_RPATH 1)
endif()

################################################################################
## C Compiler Settings 
################################################################################
enable_language (C)

## set special compiler flags
get_filename_component(C_COMPILER_NAME ${CMAKE_C_COMPILER} NAME)
## gcc and clang
if (C_COMPILER_NAME MATCHES "cc.*" OR 
    C_COMPILER_NAME MATCHES "gcc.*" OR 
    C_COMPILER_NAME MATCHES "clang.*")
  set (CC_EXTRA_FLAGS "-fomit-frame-pointer -Wno-error=return-type")
  set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${CC_EXTRA_FLAGS}")
  set (CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} ${CC_EXTRA_FLAGS}")
  set (CMAKE_C_FLAGS_DEBUG   "${CMAKE_C_FLAGS_DEBUG} ${CC_EXTRA_FLAGS}")
  set (CMAKE_C_FLAGS_RELWITHDEBINFO "${CMAKE_C_FLAGS_RELWITHDEBINFO} ${CC_EXTRA_FLAGS}")
## add additional compilers here
## other compilers use the defaults:
else ()
  message ("CMAKE_C_COMPILER full path: " ${CMAKE_C_COMPILER})
  message ("C compiler: " ${C_COMPILER_NAME})
  message ("No optimized C compiler flags are known, using the defaults...")
  message ("Add the correct rules to cmake/compiler.cmake if other behavior is"
           "required.")
endif ()

################################################################################
## CXX Compiler Settings 
################################################################################
enable_language (CXX)

## set special compiler flags
get_filename_component(CXX_COMPILER_NAME ${CMAKE_CXX_COMPILER} NAME)
## gcc and clang
if (CXX_COMPILER_NAME MATCHES "c\\+\\+.*" OR 
    CXX_COMPILER_NAME MATCHES "g\\+\\+.*" OR 
    CXX_COMPILER_NAME MATCHES "clang\\+\\+.*")
  set (CXX_EXTRA_FLAGS "-fomit-frame-pointer -fpermissive")
  set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${CXX_EXTRA_FLAGS}")
  set (CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} ${CXX_EXTRA_FLAGS}")
  set (CMAKE_CXX_FLAGS_DEBUG   "${CMAKE_CXX_FLAGS_DEBUG} ${CXX_EXTRA_FLAGS}")
  set (CMAKE_CXX_FLAGS_RELWITHDEBINFO "${CMAKE_CXX_FLAGS_RELWITHDEBINFO} ${CXX_EXTRA_FLAGS}")
## add additional compilers here
## other compilers use the defaults:
else ()
  message ("CMAKE_CXX_COMPILER full path: " ${CMAKE_CXX_COMPILER})
  message ("C++ compiler: " ${CXX_COMPILER_NAME})
  message ("No optimized C++ compiler flags are known, using the defaults...")
  message ("Add the correct rules to cmake/compiler.cmake if other behavior is"
           "required.")
endif ()
## do not check for missing symbols when creating shared libraries with clang
if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
  set(CMAKE_SHARED_LIBRARY_CREATE_CXX_FLAGS "${CMAKE_SHARED_LIBRARY_CREATE_CXX_FLAGS} -undefined dynamic_lookup")
endif()

################################################################################
## Fortran Compiler Settings 
################################################################################
enable_language (Fortran)

## set special compiler flags
get_filename_component (Fortran_COMPILER_NAME ${CMAKE_Fortran_COMPILER} NAME)
## gfortran
if (Fortran_COMPILER_NAME MATCHES "gfortran.*")

  set (gfortran_EXTRA_FLAGS "-fomit-frame-pointer -fno-automatic -fno-second-underscore -ffixed-line-length-none -fno-range-check")
  set (CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} ${gfortran_EXTRA_FLAGS}")
  set (CMAKE_Fortran_FLAGS_RELEASE "${CMAKE_Fortran_FLAGS_RELEASE} ${gfortran_EXTRA_FLAGS}")
  set (CMAKE_Fortran_FLAGS_DEBUG   "${CMAKE_Fortran_FLAGS_DEBUG} ${gfortran_EXTRA_FLAGS}")
  set (CMAKE_Fortran_FLAGS_RELWITHDEBINFO "${CMAKE_Fortran_FLAGS_RELWITHDEBINFO} ${gfortran_EXTRA_FLAGS}")

## g77
elseif (Fortran_COMPILER_NAME MATCHES "g77.*")

  set (g77_EXTRA_FLAGS "-fomit-frame-pointer -fno-automatic -fno-second-underscore -ffixed-line-length-none -finit-local-zero")
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

################################################################################
## External Libraries
#############################################################################
### RPC
set(RPCCOM, "rpcgen -b")
### nanocernlib
include_directories(${PROJECT_SOURCE_DIR}/nanocernlib)
set(NANOCERNLIB_LIBRARIES 
  nanocernlib_packlib 
  nanocernlib_mathlib
  nanocernlib_mclibs
  nanocernlib_geant321)
set(NANOCERNLIB_LIBRARIES ${NANOCERNLIB_LIBRARIES} ${NANOCERNLIB_LIBRARIES})
