cmake_minimum_required(VERSION 3.5)

project(vim-add LANGUAGES NONE)

# Get the project version from the script
file(STRINGS vim-add VERSION REGEX "^VERSION=.*")
string(REPLACE "VERSION=" "" VERSION ${VERSION})
string(REPLACE "." ";" VERSION_LIST ${VERSION})
list(GET VERSION_LIST 0 PROJECT_VERSION_MAJOR)
list(GET VERSION_LIST 1 PROJECT_VERSION_MINOR)
list(GET VERSION_LIST 2 PROJECT_VERSION_PATCH)
set(PROJECT_VERSION "${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}.${PROJECT_VERSION_PATCH}")

# Installation
include(GNUInstallDirs)
install(PROGRAMS vim-add DESTINATION ${CMAKE_INSTALL_BINDIR})
# The slash is required, otherwise the script will be installed into /usr/etc/bash_completion.d
install(PROGRAMS vim-add-completion.bash DESTINATION /${CMAKE_INSTALL_SYSCONFDIR}/bash_completion.d/)

# Packaging
include(InstallRequiredSystemLibraries)

# General CPack settings
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "Install, update and remove vim plugins with a simple bash script")
set(CPACK_PACKAGE_CONTACT "Stephan Weintritt <45856463+sweintritt@users.noreply.github.com>")
set(CPACK_PACKAGE_VERSION "${PROJECT_VERSION}")
set(CPACK_PACKAGE_VERSION_MAJOR "${PROJECT_VERSION_MAJOR}")
set(CPACK_PACKAGE_VERSION_MINOR "${PROJECT_VERSION_MINOR}")
set(CPACK_PACKAGE_VERSION_PATCH "${PROJECT_VERSION_PATCH}")

# TODO This is only a temporary solution
if ("${CMAKE_SYSTEM_PROCESSOR}" STREQUAL "x86_64")
    set(CPACK_PACKAGE_FILE_NAME "${PROJECT_NAME}_${PROJECT_VERSION}_amd64")
else()
    set(CPACK_PACKAGE_FILE_NAME "${PROJECT_NAME}_${PROJECT_VERSION}_${CMAKE_SYSTEM_PROCESSOR}")
endif()

# Set DEB as default
if (NOT CPACK_GENERATOR)
    set(CPACK_GENERATOR "DEB")
endif()

# Debian, Ubuntu
set(CPACK_DEBIAN_PACKAGE_SECTION "utils")
# Autogenerate dependency information
set(CPACK_DEBIAN_PACKAGE_SHLIBDEPS ON)
set(CPACK_DEBIAN_PACKAGE_ARCHITECTURE ${CMAKE_SYSTEM_PROCESSOR})
# Ubtuntu 16.04 and above
set(CPACK_DEBIAN_PACKAGE_DEPENDS "git (>= 2.7), bash (>= 4.3), wget (>= 1.17)")

include(CPack)
