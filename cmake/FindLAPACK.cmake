# - Find LAPACK, based on LAPACK_ROOT (CMake or environment variable).
#
#  LAPACK_LIBRARIES - Link these libraries when using LAPACK
#  LAPACK_FOUND     - True if LAPACK found (see below)
#
# Normal usage would be:
#  find_package(LAPACK)
#  target_link_libraries(myTarget PRIVATE LAPACK::LAPACK)

find_library(LAPACK_LIBRARIES NAMES lapack HINTS LAPACK_ROOT LAPACK_DIR ENV LAPACK_ROOT ENV LAPACK_DIR PATH_SUFFIXES "" "lib")
mark_as_advanced(LAPACK_LIBRARIES)

if (NOT LAPACK_LIBRARIES)
    message(STATUS "Failed to find LAPACK library")
endif()

# handle the QUIETLY and REQUIRED arguments and set LAPACK_FOUND
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(LAPACK DEFAULT_MSG LAPACK_LIBRARIES)

if (LAPACK_FOUND AND NOT TARGET LAPACK::LAPACK)
    add_library(LAPACK::LAPACK INTERFACE IMPORTED)
    set_target_properties(LAPACK::LAPACK PROPERTIES INTERFACE_LINK_LIBRARIES "${LAPACK_LIBRARIES}")
endif()

