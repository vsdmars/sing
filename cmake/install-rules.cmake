if(PROJECT_IS_TOP_LEVEL)
  set(CMAKE_INSTALL_INCLUDEDIR include/sing CACHE PATH "")
endif()

include(CMakePackageConfigHelpers)
include(GNUInstallDirs)

# find_package(<package>) call for consumers to find this project
set(package sing)

install(
    TARGETS sing_sing
    EXPORT singTargets
    RUNTIME COMPONENT sing_Runtime
)

write_basic_package_version_file(
    "${package}ConfigVersion.cmake"
    COMPATIBILITY SameMajorVersion
)

# Allow package maintainers to freely override the path for the configs
set(
    sing_INSTALL_CMAKEDIR "${CMAKE_INSTALL_DATADIR}/${package}"
    CACHE PATH "CMake package config location relative to the install prefix"
)
mark_as_advanced(sing_INSTALL_CMAKEDIR)

install(
    FILES cmake/install-config.cmake
    DESTINATION "${sing_INSTALL_CMAKEDIR}"
    RENAME "${package}Config.cmake"
    COMPONENT sing_Development
)

install(
    FILES "${PROJECT_BINARY_DIR}/${package}ConfigVersion.cmake"
    DESTINATION "${sing_INSTALL_CMAKEDIR}"
    COMPONENT sing_Development
)

install(
    EXPORT singTargets
    NAMESPACE sing::
    DESTINATION "${sing_INSTALL_CMAKEDIR}"
    COMPONENT sing_Development
)

if(PROJECT_IS_TOP_LEVEL)
  include(CPack)
endif()
