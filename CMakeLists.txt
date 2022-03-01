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

cmake_minimum_required(VERSION 3.22.0)

set(CMAKE_CXX_STANDARD 17)
set_property(GLOBAL PROPERTY USE_FOLDERS ON)
cmake_policy(SET CMP0091 NEW)
set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")

project(kibits)

option(kibits_BUILD_TESTS "Build tests" ON)

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/src)

add_subdirectory(external)
add_subdirectory(proto)
add_subdirectory(src)

if(kibits_BUILD_TESTS)
  set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY VS_STARTUP_PROJECT kibits_tests)
endif()
