cmake_minimum_required(VERSION 3.14)

include(cmake/prelude.cmake)

project(
    sing
    VERSION 0.1.0
    DESCRIPTION "sing my song"
    HOMEPAGE_URL "https://example.com/"
    LANGUAGES CXX
)

docs_early_return()

include(cmake/project-is-top-level.cmake)
include(cmake/variables.cmake)

# ---- find needed libraries
find_package(PkgConfig REQUIRED)
pkg_check_modules(gstreamer REQUIRED IMPORTED_TARGET gstreamer-1.0)

# ---- compile options ----
set(COMPILE_OPTIONS -g -Wall -Wconversion -Wdouble-promotion -Weffc++ -Wextra -Wfloat-equal -Wformat=2 -Wno-error=unused-variable -Wnull-dereference -Wold-style-cast -Wpedantic -Wshadow -Wuninitialized -Wunreachable-code -Wredundant-move -Wpessimizing-move -Wpadded)

# ---- Declare library ----

add_library(
    sing_lib OBJECT
    source/lib.cpp
)

target_include_directories(
    sing_lib ${sing_warning_guard}
    PUBLIC
    "$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/source>"
)

target_compile_features(sing_lib PUBLIC cxx_std_20)
target_compile_options(sing_lib PRIVATE ${gstreamer_CFLAGS})
target_link_libraries(sing_lib PRIVATE ${gstreamer_LIBRARIES})

# ---- Declare executable ----

add_executable(sing_sing source/main.cpp)
add_executable(sing::sing ALIAS sing_sing)

set_target_properties(
    sing_sing PROPERTIES
    OUTPUT_NAME sing
    EXPORT_NAME sing
)

target_compile_features(sing_sing PRIVATE cxx_std_20)

target_link_libraries(sing_sing PRIVATE sing_lib)

# ---- Install rules ----

if(NOT CMAKE_SKIP_INSTALL_RULES)
  include(cmake/install-rules.cmake)
endif()

# ---- Developer mode ----

if(NOT sing_DEVELOPER_MODE)
  return()
elseif(NOT PROJECT_IS_TOP_LEVEL)
  message(
      AUTHOR_WARNING
      "Developer mode is intended for developers of sing"
  )
endif()

include(cmake/dev-mode.cmake)
