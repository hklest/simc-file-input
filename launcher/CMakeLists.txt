cmake_minimum_required (VERSION 3.8)

################################################################################
# Configure launcher 2 times: 
# - 1. For in-tree use (put in top level build dir)
# - 2. For install (put in current build dir)
################################################################################
# case1: in-tree use
set (SIMC_DATA_PATH ${PROJECT_SOURCE_DIR}/share/data)
set (SIMC_EXE_PATH ${PROJECT_BINARY_DIR}/simc/simc)
configure_file(simc-launcher.in ${PROJECT_BINARY_DIR}/simc-launcher)
#
# case2: install use (not a typo, exe lives in lib, and launcher lives in bin)
set (SIMC_DATA_PATH ${INSTALL_SHARE_DIR}/data)
set (SIMC_EXE_PATH ${INSTALL_LIB_DIR}/simc)
configure_file(simc-launcher.in ${CMAKE_CURRENT_BINARY_DIR}/simc)

################################################################################
## Export and Install
################################################################################
install(PROGRAMS ${CMAKE_CURRENT_BINARY_DIR}/simc 
  DESTINATION "${INSTALL_BIN_DIR}" COMPONENT runtime)
