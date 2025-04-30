### RPC
set(RPCCOM rpcgen -b)

##############################################################################
## C Compiler Settings 
################################################################################
enable_language (C)
set(CMAKE_C_STANDARD 89)
set(CMAKE_C_STANDARD_REQUIRED yes)

## set special compiler flags
get_filename_component(C_COMPILER_NAME ${CMAKE_C_COMPILER} NAME)
## gcc and clang
if (C_COMPILER_NAME MATCHES "cc.*" OR 
    C_COMPILER_NAME MATCHES "gcc.*" OR 
    C_COMPILER_NAME MATCHES "clang.*")
  set (CC_EXTRA_FLAGS "-Wall -W -fomit-frame-pointer -Wno-error=return-type -Wno-unused-but-set-variable -Wno-implicit-function-declaration -Wno-unused-parameter -Wno-unused-variable -Wno-sign-compare -Wno-parentheses")
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

################################################################################
## RPCGEN Configuration (macOS Homebrew vs. default)
################################################################################
## On macOS, prefer Homebrew rpcsvc-proto rpcgen to avoid broken system rpcgen.
## On other Unix platforms, use the system-default rpcgen without changes.
set(RPCCOM "rpcgen")  # default fallback
set(RPCGEN_FLAGS "")

if (APPLE)
  find_program(HOMEBREW_RPCGEN NAMES rpcgen PATHS /opt/homebrew/opt/rpcsvc-proto/bin NO_DEFAULT_PATH)
  if (HOMEBREW_RPCGEN)
    message(STATUS "Using Homebrew rpcgen: ${HOMEBREW_RPCGEN}")
    set(RPCCOM ${HOMEBREW_RPCGEN})
    set(RPCGEN_FLAGS -b)
  else ()
    message(WARNING "Homebrew rpcgen not found. Using system default.")
    set(RPCCOM rpcgen)
    set(RPCGEN_FLAGS -b)
  endif ()
else ()
  set(RPCCOM rpcgen)
  set(RPCGEN_FLAGS -b)
endif ()
