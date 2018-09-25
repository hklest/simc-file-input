### RPC
set(RPCCOM rpcgen -b)

##############################################################################
## C Compiler Settings 
################################################################################
enable_language (C)

## set special compiler flags
get_filename_component(C_COMPILER_NAME ${CMAKE_C_COMPILER} NAME)
## gcc and clang
if (C_COMPILER_NAME MATCHES "cc.*" OR 
    C_COMPILER_NAME MATCHES "gcc.*" OR 
    C_COMPILER_NAME MATCHES "clang.*")
  set (CC_EXTRA_FLAGS "-Wall -W")
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
## Fortran Compiler Settings 
################################################################################
## f2c settings
add_definitions("-Df2cFortran")
