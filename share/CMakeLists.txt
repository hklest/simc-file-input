cmake_minimum_required (VERSION 3.8)

## Data directory
set (DATA_DIR "${CMAKE_CURRENT_SOURCE_DIR}/simc")

################################################################################
## Export and Install
################################################################################
install(DIRECTORY ${DATA_DIR} DESTINATION ${INSTALL_SHARE_DIR})
