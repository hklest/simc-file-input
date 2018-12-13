cmake_minimum_required (VERSION 3.8)

## Data directory
set (SHARE_DIRS "data" "doc" "infiles" "examples")

################################################################################
## Export and Install
################################################################################
install(DIRECTORY ${SHARE_DIRS} 
  DESTINATION ${INSTALL_SHARE_DIR} COMPONENT runtime)
