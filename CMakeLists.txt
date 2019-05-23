## CMake project file for pcsim

################################################################################
## PROJECT: SIMC (Cmake build with file input)
################################################################################
cmake_minimum_required (VERSION 3.8)

project (simc VERSION 1.0.0 LANGUAGES CXX )

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
