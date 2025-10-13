# Install script for directory: G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/src/oceanExample

# Set the install prefix
IF(NOT DEFINED CMAKE_INSTALL_PREFIX)
  SET(CMAKE_INSTALL_PREFIX "C:/Program Files (x86)/osgOcean")
ENDIF(NOT DEFINED CMAKE_INSTALL_PREFIX)
STRING(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
IF(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  IF(BUILD_TYPE)
    STRING(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  ELSE(BUILD_TYPE)
    SET(CMAKE_INSTALL_CONFIG_NAME "Release")
  ENDIF(BUILD_TYPE)
  MESSAGE(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
ENDIF(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)

# Set the component getting installed.
IF(NOT CMAKE_INSTALL_COMPONENT)
  IF(COMPONENT)
    MESSAGE(STATUS "Install component: \"${COMPONENT}\"")
    SET(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  ELSE(COMPONENT)
    SET(CMAKE_INSTALL_COMPONENT)
  ENDIF(COMPONENT)
ENDIF(NOT CMAKE_INSTALL_COMPONENT)

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  IF("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
    list(APPEND CPACK_ABSOLUTE_DESTINATION_FILES
     "C:/Program Files (x86)/osgOcean/bin/oceanExample.exe")
FILE(INSTALL DESTINATION "C:/Program Files (x86)/osgOcean/bin" TYPE EXECUTABLE FILES "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/bin/Debug/oceanExample.exe")
  ELSEIF("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    list(APPEND CPACK_ABSOLUTE_DESTINATION_FILES
     "C:/Program Files (x86)/osgOcean/bin/oceanExample.exe")
FILE(INSTALL DESTINATION "C:/Program Files (x86)/osgOcean/bin" TYPE EXECUTABLE FILES "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/bin/Release/oceanExample.exe")
  ELSEIF("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Mm][Ii][Nn][Ss][Ii][Zz][Ee][Rr][Ee][Ll])$")
    list(APPEND CPACK_ABSOLUTE_DESTINATION_FILES
     "C:/Program Files (x86)/osgOcean/bin/oceanExample.exe")
FILE(INSTALL DESTINATION "C:/Program Files (x86)/osgOcean/bin" TYPE EXECUTABLE FILES "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/bin/MinSizeRel/oceanExample.exe")
  ELSEIF("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Rr][Ee][Ll][Ww][Ii][Tt][Hh][Dd][Ee][Bb][Ii][Nn][Ff][Oo])$")
    list(APPEND CPACK_ABSOLUTE_DESTINATION_FILES
     "C:/Program Files (x86)/osgOcean/bin/oceanExample.exe")
FILE(INSTALL DESTINATION "C:/Program Files (x86)/osgOcean/bin" TYPE EXECUTABLE FILES "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/bin/RelWithDebInfo/oceanExample.exe")
  ENDIF()
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  list(APPEND CPACK_ABSOLUTE_DESTINATION_FILES
   "C:/Program Files (x86)/osgOcean/bin/resources/textures/sky_clear/down.png;C:/Program Files (x86)/osgOcean/bin/resources/textures/sky_clear/east.png;C:/Program Files (x86)/osgOcean/bin/resources/textures/sky_clear/north.png;C:/Program Files (x86)/osgOcean/bin/resources/textures/sky_clear/south.png;C:/Program Files (x86)/osgOcean/bin/resources/textures/sky_clear/up.png;C:/Program Files (x86)/osgOcean/bin/resources/textures/sky_clear/west.png")
FILE(INSTALL DESTINATION "C:/Program Files (x86)/osgOcean/bin/resources/textures/sky_clear" TYPE FILE FILES
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/resources/textures/sky_clear/down.png"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/resources/textures/sky_clear/east.png"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/resources/textures/sky_clear/north.png"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/resources/textures/sky_clear/south.png"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/resources/textures/sky_clear/up.png"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/resources/textures/sky_clear/west.png"
    )
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  list(APPEND CPACK_ABSOLUTE_DESTINATION_FILES
   "C:/Program Files (x86)/osgOcean/bin/resources/textures/sky_dusk/down.png;C:/Program Files (x86)/osgOcean/bin/resources/textures/sky_dusk/east.png;C:/Program Files (x86)/osgOcean/bin/resources/textures/sky_dusk/north.png;C:/Program Files (x86)/osgOcean/bin/resources/textures/sky_dusk/south.png;C:/Program Files (x86)/osgOcean/bin/resources/textures/sky_dusk/up.png;C:/Program Files (x86)/osgOcean/bin/resources/textures/sky_dusk/west.png")
FILE(INSTALL DESTINATION "C:/Program Files (x86)/osgOcean/bin/resources/textures/sky_dusk" TYPE FILE FILES
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/resources/textures/sky_dusk/down.png"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/resources/textures/sky_dusk/east.png"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/resources/textures/sky_dusk/north.png"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/resources/textures/sky_dusk/south.png"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/resources/textures/sky_dusk/up.png"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/resources/textures/sky_dusk/west.png"
    )
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  list(APPEND CPACK_ABSOLUTE_DESTINATION_FILES
   "C:/Program Files (x86)/osgOcean/bin/resources/textures/sky_fair_cloudy/down.png;C:/Program Files (x86)/osgOcean/bin/resources/textures/sky_fair_cloudy/east.png;C:/Program Files (x86)/osgOcean/bin/resources/textures/sky_fair_cloudy/north.png;C:/Program Files (x86)/osgOcean/bin/resources/textures/sky_fair_cloudy/south.png;C:/Program Files (x86)/osgOcean/bin/resources/textures/sky_fair_cloudy/up.png;C:/Program Files (x86)/osgOcean/bin/resources/textures/sky_fair_cloudy/west.png")
FILE(INSTALL DESTINATION "C:/Program Files (x86)/osgOcean/bin/resources/textures/sky_fair_cloudy" TYPE FILE FILES
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/resources/textures/sky_fair_cloudy/down.png"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/resources/textures/sky_fair_cloudy/east.png"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/resources/textures/sky_fair_cloudy/north.png"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/resources/textures/sky_fair_cloudy/south.png"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/resources/textures/sky_fair_cloudy/up.png"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/resources/textures/sky_fair_cloudy/west.png"
    )
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  list(APPEND CPACK_ABSOLUTE_DESTINATION_FILES
   "C:/Program Files (x86)/osgOcean/bin/resources/shaders/terrain.vert;C:/Program Files (x86)/osgOcean/bin/resources/shaders/terrain.frag;C:/Program Files (x86)/osgOcean/bin/resources/shaders/terrain_lispsm.vert;C:/Program Files (x86)/osgOcean/bin/resources/shaders/terrain_lispsm.frag;C:/Program Files (x86)/osgOcean/bin/resources/shaders/skydome.vert;C:/Program Files (x86)/osgOcean/bin/resources/shaders/skydome.frag")
FILE(INSTALL DESTINATION "C:/Program Files (x86)/osgOcean/bin/resources/shaders" TYPE FILE FILES
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/resources/shaders/terrain.vert"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/resources/shaders/terrain.frag"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/resources/shaders/terrain_lispsm.vert"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/resources/shaders/terrain_lispsm.frag"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/resources/shaders/skydome.vert"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/resources/shaders/skydome.frag"
    )
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  list(APPEND CPACK_ABSOLUTE_DESTINATION_FILES
   "C:/Program Files (x86)/osgOcean/bin/resources/island/islands.ive")
FILE(INSTALL DESTINATION "C:/Program Files (x86)/osgOcean/bin/resources/island" TYPE FILE FILES "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/resources/island/islands.ive")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  list(APPEND CPACK_ABSOLUTE_DESTINATION_FILES
   "C:/Program Files (x86)/osgOcean/bin/resources/boat/boat.3ds")
FILE(INSTALL DESTINATION "C:/Program Files (x86)/osgOcean/bin/resources/boat" TYPE FILE FILES "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/resources/boat/boat.3ds")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

