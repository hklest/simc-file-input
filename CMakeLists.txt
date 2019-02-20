## CMake project file for pcsim

################################################################################
## PROJECT: SIMC (Cmake build with file input)
################################################################################
cmake_minimum_required (VERSION 3.5)
project (simc)
set (SIMC_MAJOR_VERSION 0)
set (SIMC_MINOR_VERSION 1)
set (SIMC_PATCH_VERSION 1)
set (SIMC_VERSION 
  ${SIMC_MAJOR_VERSION}.${SIMC_MINOR_VERSION}.${SIMC_PATCH_VERSION})
set (SIMC_SOVERSION ${SIMC_MAJOR_VERSION})

################################################################################
## CMAKE Settings 
################################################################################
include(cmake/options.cmake)
include(cmake/compiler.cmake)
include(cmake/ycm.cmake)

################################################################################
## Add subdirectories
################################################################################
set(TARGETS "")

add_subdirectory(simc)
add_subdirectory(CTP)
add_subdirectory(launcher)
add_subdirectory(share)
add_subdirectory(nanocernlib EXCLUDE_FROM_ALL)

################################################################################
## Prepare the project to be EXPORTed, generate configuration files
################################################################################
include(cmake/export.cmake)

#include(cmake/debug.cmake)
