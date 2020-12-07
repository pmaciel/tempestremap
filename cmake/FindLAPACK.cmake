# - Find LAPACK
# Find the native LAPACK includes and library
#
#  LAPACK_INCLUDES  - where to find LAPACK.h, etc
#  LAPACK_LIBRARIES - Link these libraries when using LAPACK
#  LAPACK_FOUND     - True if LAPACK found including required interfaces (see below)
#
# You can require certain interfaces via COMPONENTS: C (requires header)
#
# The following are not for general use and are included in
# LAPACK_LIBRARIES if the corresponding option above is set.
#
#  LAPACK_LIBRARIES_C - C interface (if available)
#
# Normal usage would be:
#  find_package(LAPACK COMPONENTS CXX REQUIRED)
#  target_link_libraries(myTarget PRIVATE LAPACK::LAPACK)

find_path(LAPACK_INCLUDES LAPACK.h HINTS LAPACK_ROOT LAPACK_DIR ENV LAPACK_ROOT LAPACK_DIR PATH_SUFFIXES "" "include")
if (LAPACK_INCLUDES)
    set(LAPACK_INCLUDE_DIRS "${LAPACK_INCLUDES}")
endif()

find_library(LAPACK_LIBRARIES_C NAMES LAPACK HINTS LAPACK_ROOT LAPACK_DIR ENV LAPACK_ROOT LAPACK_DIR PATH_SUFFIXES "" "lib")
mark_as_advanced(LAPACK_LIBRARIES_C)

set(LAPACK_has_interfaces "YES") # will be set to NO if we're missing any interface headers
set(LAPACK_has_libraries "YES") # will be set to NO if we're missing any libraries
set(LAPACK_libs "${LAPACK_LIBRARIES_C}")

get_filename_component(LAPACK_lib_dirs "${LAPACK_LIBRARIES_C}" PATH)

macro(LAPACK_check_interface lang header)
    find_path(LAPACK_INCLUDES_${lang} NAMES ${header} HINTS "${LAPACK_INCLUDES}" NO_DEFAULT_PATH)
    mark_as_advanced(LAPACK_INCLUDES_${lang})
    if (NOT LAPACK_INCLUDES_${lang})
        set(LAPACK_has_interfaces "NO")
        message(STATUS "Failed to find LAPACK interface for ${lang}")
    endif()
endmacro()

macro(LAPACK_check_library lang libs)
    find_library(LAPACK_LIBRARIES_${lang} NAMES ${libs} HINTS "${LAPACK_lib_dirs}" NO_DEFAULT_PATH)
    mark_as_advanced(LAPACK_INCLUDES_${lang} LAPACK_LIBRARIES_${lang})
    if (NOT LAPACK_LIBRARIES_${lang})
        set(LAPACK_has_libraries "NO")
        message(STATUS "Failed to find LAPACK library for ${lang}")
    else()
        list(INSERT LAPACK_libs 0 ${LAPACK_LIBRARIES_${lang}}) # prepend so that -lLAPACK is last
    endif()
endmacro()

if (LAPACK_FIND_COMPONENTS)
    foreach(component IN LISTS LAPACK_FIND_COMPONENTS)
        if (component STREQUAL "C")
            LAPACK_check_interface(C lapack.h)
            LAPACK_check_library(C lapack)
        endif()
    endforeach()
else()
    LAPACK_check_library(C lapack)
endif()

list(REMOVE_DUPLICATES LAPACK_libs)
set(LAPACK_LIBRARIES "${LAPACK_libs}" CACHE STRING "LAPACK libraries requested")

# handle the QUIETLY and REQUIRED arguments and set LAPACK_FOUND to TRUE if
# all listed variables are TRUE
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(LAPACK DEFAULT_MSG LAPACK_LIBRARIES LAPACK_INCLUDES LAPACK_has_interfaces LAPACK_has_libraries)

if (LAPACK_FOUND AND NOT TARGET LAPACK::LAPACK)
    add_library(LAPACK::LAPACK INTERFACE IMPORTED)
    set_target_properties(LAPACK::LAPACK PROPERTIES INTERFACE_INCLUDE_DIRECTORIES "${LAPACK_INCLUDES}" INTERFACE_LINK_LIBRARIES "${LAPACK_LIBRARIES}")
endif()

mark_as_advanced(LAPACK_LIBRARIES LAPACK_INCLUDES)

