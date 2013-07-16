# - Locate SDL_ttf library
# This module defines:
#  SDL_TTF_LIBRARIES, the name of the library to link against
#  SDL_TTF_INCLUDE_DIRS, where to find the headers
#  SDL_TTF_FOUND, if false, do not try to link against
#  SDL_TTF_VERSION_STRING - human-readable string containing the version of SDL_ttf
#
# For backward compatiblity the following variables are also set:
#  SDLTTF_LIBRARY (same value as SDL_TTF_LIBRARIES)
#  SDLTTF_INCLUDE_DIR (same value as SDL_TTF_INCLUDE_DIRS)
#  SDLTTF_FOUND (same value as SDL_TTF_FOUND)
#
# $SDLDIR is an environment variable that would
# correspond to the ./configure --prefix=$SDLDIR
# used in building SDL.
#
# Created by Eric Wing. This was influenced by the FindSDL.cmake
# module, but with modifications to recognize OS X frameworks and
# additional Unix paths (FreeBSD, etc).

#=============================================================================
# Copyright 2005-2009 Kitware, Inc.
# Copyright 2012 Benjamin Eikel
#
# Distributed under the OSI-approved BSD License (the "License");
# see accompanying file Copyright.txt for details.
#
# This software is distributed WITHOUT ANY WARRANTY; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the License for more information.
#=============================================================================
# (To distribute this file outside of CMake, substitute the full
#  License text for the above reference.)

if(NOT SDL_TTF_INCLUDE_DIR AND SDLTTF_INCLUDE_DIR)
  set(SDL_TTF_INCLUDE_DIR ${SDLTTF_INCLUDE_DIR} CACHE PATH "directory cache
entry initialized from old variable name")
endif()
find_path(SDL_TTF_INCLUDE_DIR SDL_ttf.h
  HINTS
    ${CMAKE_CURRENT_SOURCE_DIR}/dependencies/SDL_ttf
    ENV SDLTTFDIR
    ENV SDLDIR
  PATH_SUFFIXES SDL SDL12 SDL11 include
)

if(NOT SDL_TTF_LIBRARY AND SDLTTF_LIBRARY)
  set(SDL_TTF_LIBRARY ${SDLTTF_LIBRARY} CACHE FILEPATH "file cache entry
initialized from old variable name")
endif()
find_library(SDL_TTF_LIBRARY
  NAMES SDL_ttf
  HINTS
	${CMAKE_CURRENT_SOURCE_DIR}/dependencies/SDL_ttf
    ENV SDLTTFDIR
    ENV SDLDIR
  PATH_SUFFIXES lib lib/x86
)

if(SDL_TTF_INCLUDE_DIR AND EXISTS "${SDL_TTF_INCLUDE_DIR}/SDL_ttf.h")
  file(STRINGS "${SDL_TTF_INCLUDE_DIR}/SDL_ttf.h" SDL_TTF_VERSION_MAJOR_LINE REGEX "^#define[ \t]+SDL_TTF_MAJOR_VERSION[ \t]+[0-9]+$")
  file(STRINGS "${SDL_TTF_INCLUDE_DIR}/SDL_ttf.h" SDL_TTF_VERSION_MINOR_LINE REGEX "^#define[ \t]+SDL_TTF_MINOR_VERSION[ \t]+[0-9]+$")
  file(STRINGS "${SDL_TTF_INCLUDE_DIR}/SDL_ttf.h" SDL_TTF_VERSION_PATCH_LINE REGEX "^#define[ \t]+SDL_TTF_PATCHLEVEL[ \t]+[0-9]+$")
  string(REGEX REPLACE "^#define[ \t]+SDL_TTF_MAJOR_VERSION[ \t]+([0-9]+)$" "\\1" SDL_TTF_VERSION_MAJOR "${SDL_TTF_VERSION_MAJOR_LINE}")
  string(REGEX REPLACE "^#define[ \t]+SDL_TTF_MINOR_VERSION[ \t]+([0-9]+)$" "\\1" SDL_TTF_VERSION_MINOR "${SDL_TTF_VERSION_MINOR_LINE}")
  string(REGEX REPLACE "^#define[ \t]+SDL_TTF_PATCHLEVEL[ \t]+([0-9]+)$" "\\1" SDL_TTF_VERSION_PATCH "${SDL_TTF_VERSION_PATCH_LINE}")
  set(SDL_TTF_VERSION_STRING ${SDL_TTF_VERSION_MAJOR}.${SDL_TTF_VERSION_MINOR}.${SDL_TTF_VERSION_PATCH})
  unset(SDL_TTF_VERSION_MAJOR_LINE)
  unset(SDL_TTF_VERSION_MINOR_LINE)
  unset(SDL_TTF_VERSION_PATCH_LINE)
  unset(SDL_TTF_VERSION_MAJOR)
  unset(SDL_TTF_VERSION_MINOR)
  unset(SDL_TTF_VERSION_PATCH)
endif()

set(SDL_TTF_LIBRARIES ${SDL_TTF_LIBRARY})
set(SDL_TTF_INCLUDE_DIRS ${SDL_TTF_INCLUDE_DIR})

include(${CMAKE_CURRENT_SOURCE_DIR}/cmake/Modules/FindPackageHandleStandardArgs.cmake)

FIND_PACKAGE_HANDLE_STANDARD_ARGS(SDL_ttf
                                  REQUIRED_VARS SDL_TTF_LIBRARIES SDL_TTF_INCLUDE_DIRS
                                  VERSION_VAR SDL_TTF_VERSION_STRING)

# for backward compatiblity
set(SDLTTF_LIBRARY ${SDL_TTF_LIBRARIES})
set(SDLTTF_INCLUDE_DIR ${SDL_TTF_INCLUDE_DIRS})
set(SDLTTF_FOUND ${SDL_TTF_FOUND})

mark_as_advanced(SDL_TTF_LIBRARY SDL_TTF_INCLUDE_DIR)
