cmake_minimum_required (VERSION 3.5)

include(compiler.cmake)

################################################################################
## CMAKE Settings
################################################################################
set (PROG "${PROJECT_NAME}")
set (TARGETS ${TARGETS} ${PROG} PARENT_SCOPE)

################################################################################
## Sources and install headers 
## (no install headers)
################################################################################
file (GLOB SOURCES "*.f")
file (GLOB SOS_SOURCES "sos/*.f")
file (GLOB HMS_SOURCES "hms/*.f")
file (GLOB HRSL_SOURCES "hrsl/*.f")
file (GLOB HRSR_SOURCES "hrsr/*.f")
file (GLOB SHARED_SOURCES "shared/*.f")
file (GLOB SHMS_SOURCES "shms/*.f")
file (GLOB CTEQ5_SOURCES "cteq5/*.f")
file (GLOB CALO_SOURCES "calo/*.f")


################################################################################
## Include directories
################################################################################
include_directories("${CMAKE_CURRENT_SOURCE_DIR}")

################################################################################
## Compile and Link
################################################################################
add_library(${PROG}_detectors 
	${SOS_SOURCES} ${HMS_SOURCES} ${HRSL_SOURCES} ${HRSR_SOURCES}
  ${SHMS_SOURCES} ${CALO_SOURCES})
add_library(${PROG}_shared
	${SHARED_SOURCES})
add_library(${PROG}_cteq5
	${CTEQ5_SOURCES})
add_executable(${PROG} ${SOURCES})
target_link_libraries(${PROG} 
	${PROG}_detectors ${PROG}_shared ${PROG}_cteq5
	${PROG}_detectors ${PROG}_shared ${PROG}_cteq5
	${PROG}_CTP
	${NANOCERNLIB_LIBRARIES})

################################################################################
## Export and Install
################################################################################
# NOT A TYPO: exe lives in lib, while launcher script lives in bin
install(TARGETS ${PROG} 
  EXPORT ${PROJECT_NAME}-targets
  RUNTIME DESTINATION "${INSTALL_LIB_DIR}" COMPONENT ${PROJECT_NAME}_runtime)
install(TARGETS ${PROG}_detectors ${PROG}_shared ${PROG}_cteq5
  EXPORT ${PROJECT_NAME}-targets
  RUNTIME DESTINATION "${INSTALL_BIN_DIR}" COMPONENT dev EXCLUDE_FROM_ALL
  ARCHIVE DESTINATION "${INSTALL_LIB_DIR}" COMPONENT dev EXCLUDE_FROM_ALL
  LIBRARY DESTINATION "${INSTALL_LIB_DIR}" COMPONENT dev EXCLUDE_FROM_ALL)
