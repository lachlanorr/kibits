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

set(proto_out "${CMAKE_CURRENT_BINARY_DIR}")
set(proto_dir "${CMAKE_CURRENT_SOURCE_DIR}")

macro(compile_proto path_no_ext)
  add_custom_command(
    OUTPUT ${proto_out}/${path_no_ext}.pb.cc ${proto_out}/${path_no_ext}.pb.h
    COMMAND $<TARGET_FILE:protoc> -I=${proto_dir} -I=${PROTOBUF_INCLUDE} --cpp_out=${proto_out} ${path_no_ext}.proto
    DEPENDS ${proto_dir}/${path_no_ext}.proto
    )

  list(APPEND proto_gen_SOURCES "${proto_out}/${path_no_ext}.pb.cc" "${proto_out}/${path_no_ext}.pb.h" "${proto_dir}/${path_no_ext}.proto")
endmacro()

file(GLOB_RECURSE proto_files RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} kibits *.proto)
list(TRANSFORM proto_files REPLACE "\\.proto$" "")
foreach(proto_file ${proto_files})
  compile_proto("${proto_file}")
endforeach()

add_library(kibits_proto ${proto_gen_SOURCES})
target_include_directories(kibits_proto PRIVATE
  ${proto_out}
  )

source_group("" FILES ${proto_gen_SOURCES})

add_dependencies(kibits_proto protoc)

target_link_libraries(kibits_proto
  PUBLIC libprotobuf
  )

target_include_directories(kibits_proto INTERFACE
  ${CMAKE_CURRENT_BINARY_DIR}/..
  )
