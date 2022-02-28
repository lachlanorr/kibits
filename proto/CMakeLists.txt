#-------------------------------------------------------------------------------
# CMakeLists.txt - Build script
#
# Kibits - Distributed Game Blockchain Library
# Copyright (c) 2022 Lachlan Orr
#
# This software is provided 'as-is', without any express or implied
# warranty. In no event will the authors be held liable for any damages
# arising from the use of this software.
#
# Permission is granted to anyone to use this software for any purpose,
# including commercial applications, and to alter it and redistribute it
# freely, subject to the following restrictions:
#
#   1. The origin of this software must not be misrepresented; you must not
#   claim that you wrote the original software. If you use this software
#   in a product, an acknowledgment in the product documentation would be
#   appreciated but is not required.
#
#   2. Altered source versions must be plainly marked as such, and must not be
#   misrepresented as being the original software.
#
#   3. This notice may not be removed or altered from any source
#   distribution.
#-------------------------------------------------------------------------------

SET(PROTO_OUT "${CMAKE_CURRENT_BINARY_DIR}")
SET(PROTO_DIR "${CMAKE_CURRENT_SOURCE_DIR}")


macro(PROTOC path_no_ext)
  add_custom_command(
    OUTPUT ${PROTO_OUT}/${path_no_ext}.pb.cc ${PROTO_OUT}/${path_no_ext}.pb.h
    COMMAND $<TARGET_FILE:protoc> -I=${PROTO_DIR} -I=${PROTOBUF_INCLUDE} --cpp_out=${PROTO_OUT} ${path_no_ext}.proto
    DEPENDS ${PROTO_DIR}/${path_no_ext}.proto
    )

  list(APPEND CPP_SOURCES "${PROTO_OUT}/${path_no_ext}.pb.cc" "${PROTO_OUT}/${path_no_ext}.pb.h" "${PROTO_DIR}/${path_no_ext}.proto")
endmacro()

FILE(GLOB_RECURSE proto_files RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} kibits *.proto)
LIST(TRANSFORM proto_files REPLACE "\\.proto$" "")
foreach(proto_file ${proto_files})
  PROTOC("${proto_file}")
endforeach()

ADD_LIBRARY(kibits_proto ${CPP_SOURCES})
TARGET_INCLUDE_DIRECTORIES(kibits_proto PRIVATE
  ${PROTO_OUT}
  )

source_group("" FILES ${CPP_SOURCES})

ADD_DEPENDENCIES(kibits_proto protoc)

TARGET_LINK_LIBRARIES (kibits_proto
  PUBLIC libprotobuf
  )

TARGET_INCLUDE_DIRECTORIES (kibits_proto INTERFACE
  ${CMAKE_CURRENT_BINARY_DIR}/..
  )
