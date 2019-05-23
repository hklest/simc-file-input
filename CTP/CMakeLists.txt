################################################################################
## CMAKE Settings
################################################################################
## only really need CTP library, also building client and makereg for
## completeness/future usefullnes
set (LIBRARY "${PROJECT_NAME}_CTP")
set (CLIENT_LIBRARY "${PROJECT_NAME}_CTPclient")
set (PROGRAM "${PROJECT_NAME}_makereg")

set (TARGETS ${TARGETS} ${LIBRARY} ${CLIENT_LIBRARY} ${PROGRAM} PARENT_SCOPE)

## for RPC Command ${RPCCOM}
include (compiler.cmake)

################################################################################
## Sources and install headers
################################################################################
file (GLOB CTP_SOURCES "CTP/*.c")
file (GLOB CLIENT_SOURCES "client/*.c")
file (GLOB MAKEREG_SOURCES "makereg/*.c")

################################################################################
## Auto-generated sources
################################################################################
set (RPC_ORIG "${CMAKE_CURRENT_SOURCE_DIR}/daVarRpc.x")
set (RPC_RAW "${CMAKE_CURRENT_BINARY_DIR}/daVarRpc.x")
set (RPC_DEP_HEADER "${CMAKE_CURRENT_BINARY_DIR}/daVar.h")
set (RPC_DEP_HEADER_SRC "${CMAKE_CURRENT_SOURCE_DIR}/include/daVar.h")
set (RPC_XDR_SOURCE "${CMAKE_CURRENT_BINARY_DIR}/rpc_xdr.c")
set (RPC_SVC_SOURCE "${CMAKE_CURRENT_BINARY_DIR}/rpc_svc.c")
set (RPC_SVC_PATCH_SOURCE "${CMAKE_CURRENT_BINARY_DIR}/rpc_svc_patch.c")
set (RPC_CLNT_SOURCE "${CMAKE_CURRENT_BINARY_DIR}/rpc_clnt.c")
set (RPC_HEADER "${CMAKE_CURRENT_BINARY_DIR}/daVarRpc.h")
#set (RPC_HEADER_HACK "${CMAKE_CURRENT_SOURCE_DIR}/include/daVarRpc.h")
ADD_CUSTOM_COMMAND(
  OUTPUT ${RPC_RAW}
  COMMAND cp ${RPC_ORIG} ${RPC_RAW}
  DEPENDS ${RPC_ORIG} ${RPC_DEP_HEADER})
ADD_CUSTOM_COMMAND(
  OUTPUT ${RPC_DEP_HEADER}
  COMMAND cp ${RPC_DEP_HEADER_SRC} ${RPC_DEP_HEADER}
  DEPENDS ${RPC_DEP_HEADER_SRC})
ADD_CUSTOM_COMMAND(
	OUTPUT ${RPC_XDR_SOURCE}
	COMMAND ${RPCCOM} -o ${RPC_XDR_SOURCE} -c ${RPC_RAW}
	DEPENDS ${RPC_RAW})
ADD_CUSTOM_COMMAND(
	OUTPUT ${RPC_SVC_SOURCE}
	COMMAND ${RPCCOM} -o ${RPC_SVC_SOURCE} -m ${RPC_RAW}
	DEPENDS ${RPC_RAW})
ADD_CUSTOM_COMMAND(
	OUTPUT ${RPC_SVC_PATCH_SOURCE}
	COMMAND sed -e 's/extern/static/g' ${RPC_SVC_SOURCE} > ${RPC_SVC_PATCH_SOURCE}
	DEPENDS ${RCP_SVC_SOURCE})
ADD_CUSTOM_COMMAND(
	OUTPUT ${RPC_CLNT_SOURCE}
	COMMAND ${RPCCOM} -o ${RPC_CLNT_SOURCE} -l ${RPC_RAW}
	DEPENDS ${RPC_RAW})
ADD_CUSTOM_COMMAND(
	OUTPUT ${RPC_HEADER}
	COMMAND ${RPCCOM} -o ${RPC_HEADER} -h ${RPC_RAW}
	DEPENDS ${RPC_RAW})

################################################################################
## Include directories
################################################################################
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include)
include_directories(${CMAKE_CURRENT_BINARY_DIR})

################################################################################
## Compile and Link
################################################################################
add_library(${LIBRARY} STATIC 
	${CTP_SOURCES} 
${RPC_SVC_SOURCE} ${RPC_XDR_SOURCE} ${RPC_HEADER})
set_target_properties(${LIBRARY} PROPERTIES 
  VERSION ${PROJECT_VERSION} 
  SOVERSION ${PROJECT_VERSION_MAJOR})

add_library(${CLIENT_LIBRARY} STATIC 
	${CLIENT_SOURCES} 
	${RPC_CLNT_SOURCE} ${RPC_XDR_SOURCE} ${RPC_HEADER})
set_target_properties(${LIBRARY} PROPERTIES 
  VERSION ${PROJECT_VERSION} 
  SOVERSION ${PROJECT_VERSION_MAJOR})

add_executable(${PROGRAM} ${MAKEREG_SOURCES})
target_link_libraries(${PROGRAM} 
	${CLIENT_LIBRARY} ${LIBRARY} 
	${CLIENT_LIBRARY} ${LIBRARY} 
	${NANOCERNLIB_LIBRARIES})


################################################################################
## Export and Install
################################################################################
install(TARGETS ${LIBRARY} ${CLIENT_LIBRARY} ${PROGRAM}
  EXPORT ${PROJECT_NAME}-targets
  RUNTIME DESTINATION "${INSTALL_BIN_DIR}" COMPONENT dev EXCLUDE_FROM_ALL
  ARCHIVE DESTINATION "${INSTALL_LIB_DIR}" COMPONENT dev EXCLUDE_FROM_ALL
  LIBRARY DESTINATION "${INSTALL_LIB_DIR}" COMPONENT dev EXCLUDE_FROM_ALL)
