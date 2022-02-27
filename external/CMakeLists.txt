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

# googletest
SET(BUILD_GMOCK OFF CACHE BOOL "" FORCE)
SET(INSTALL_GTEST OFF CACHE BOOL "" FORCE)
ADD_SUBDIRECTORY(googletest)
SET_TARGET_PROPERTIES (gtest PROPERTIES
  FOLDER ExternalProjectTargets/googletest
  )
SET_TARGET_PROPERTIES (gtest_main PROPERTIES
  FOLDER ExternalProjectTargets/googletest
  )

#protobuf
SET(protobuf_BUILD_TESTS OFF CACHE BOOL "" FORCE)
SET(protobuf_BUILD_EXAMPLES OFF CACHE BOOL "" FORCE)
SET(protobuf_WITH_ZLIB OFF CACHE BOOL "" FORCE)
ADD_SUBDIRECTORY(protobuf/cmake)
SET_TARGET_PROPERTIES (libprotobuf PROPERTIES
  FOLDER ExternalProjectTargets/protobuf
  )
SET_TARGET_PROPERTIES (libprotobuf-lite PROPERTIES
  FOLDER ExternalProjectTargets/protobuf
  )
SET_TARGET_PROPERTIES (libprotoc PROPERTIES
  FOLDER ExternalProjectTargets/protobuf
  )
SET_TARGET_PROPERTIES (protoc PROPERTIES
  FOLDER ExternalProjectTargets/protobuf
  )
SET (PROTOBUF_INCLUDE "${CMAKE_CURRENT_SOURCE_DIR}/protobuf/src" CACHE INTERNAL "")
