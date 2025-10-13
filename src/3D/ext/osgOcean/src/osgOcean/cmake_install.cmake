# Install script for directory: G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/src/osgOcean

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
     "C:/Program Files (x86)/osgOcean/lib/osgOceand.lib")
FILE(INSTALL DESTINATION "C:/Program Files (x86)/osgOcean/lib" TYPE STATIC_LIBRARY OPTIONAL FILES "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/lib/Debug/osgOceand.lib")
  ELSEIF("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    list(APPEND CPACK_ABSOLUTE_DESTINATION_FILES
     "C:/Program Files (x86)/osgOcean/lib/osgOcean.lib")
FILE(INSTALL DESTINATION "C:/Program Files (x86)/osgOcean/lib" TYPE STATIC_LIBRARY OPTIONAL FILES "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/lib/Release/osgOcean.lib")
  ELSEIF("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Mm][Ii][Nn][Ss][Ii][Zz][Ee][Rr][Ee][Ll])$")
    list(APPEND CPACK_ABSOLUTE_DESTINATION_FILES
     "C:/Program Files (x86)/osgOcean/lib/osgOceans.lib")
FILE(INSTALL DESTINATION "C:/Program Files (x86)/osgOcean/lib" TYPE STATIC_LIBRARY OPTIONAL FILES "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/lib/MinSizeRel/osgOceans.lib")
  ELSEIF("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Rr][Ee][Ll][Ww][Ii][Tt][Hh][Dd][Ee][Bb][Ii][Nn][Ff][Oo])$")
    list(APPEND CPACK_ABSOLUTE_DESTINATION_FILES
     "C:/Program Files (x86)/osgOcean/lib/osgOceanrd.lib")
FILE(INSTALL DESTINATION "C:/Program Files (x86)/osgOcean/lib" TYPE STATIC_LIBRARY OPTIONAL FILES "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/lib/RelWithDebInfo/osgOceanrd.lib")
  ENDIF()
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  IF("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
    list(APPEND CPACK_ABSOLUTE_DESTINATION_FILES
     "C:/Program Files (x86)/osgOcean/bin/osgOceand.dll")
FILE(INSTALL DESTINATION "C:/Program Files (x86)/osgOcean/bin" TYPE SHARED_LIBRARY FILES "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/bin/Debug/osgOceand.dll")
  ELSEIF("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    list(APPEND CPACK_ABSOLUTE_DESTINATION_FILES
     "C:/Program Files (x86)/osgOcean/bin/osgOcean.dll")
FILE(INSTALL DESTINATION "C:/Program Files (x86)/osgOcean/bin" TYPE SHARED_LIBRARY FILES "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/bin/Release/osgOcean.dll")
  ELSEIF("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Mm][Ii][Nn][Ss][Ii][Zz][Ee][Rr][Ee][Ll])$")
    list(APPEND CPACK_ABSOLUTE_DESTINATION_FILES
     "C:/Program Files (x86)/osgOcean/bin/osgOceans.dll")
FILE(INSTALL DESTINATION "C:/Program Files (x86)/osgOcean/bin" TYPE SHARED_LIBRARY FILES "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/bin/MinSizeRel/osgOceans.dll")
  ELSEIF("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Rr][Ee][Ll][Ww][Ii][Tt][Hh][Dd][Ee][Bb][Ii][Nn][Ff][Oo])$")
    list(APPEND CPACK_ABSOLUTE_DESTINATION_FILES
     "C:/Program Files (x86)/osgOcean/bin/osgOceanrd.dll")
FILE(INSTALL DESTINATION "C:/Program Files (x86)/osgOcean/bin" TYPE SHARED_LIBRARY FILES "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/bin/RelWithDebInfo/osgOceanrd.dll")
  ENDIF()
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  list(APPEND CPACK_ABSOLUTE_DESTINATION_FILES
   "C:/Program Files (x86)/osgOcean/include/osgOcean/Cylinder;C:/Program Files (x86)/osgOcean/include/osgOcean/DistortionSurface;C:/Program Files (x86)/osgOcean/include/osgOcean/FFTOceanTechnique;C:/Program Files (x86)/osgOcean/include/osgOcean/FFTOceanSurface;C:/Program Files (x86)/osgOcean/include/osgOcean/FFTOceanSurfaceVBO;C:/Program Files (x86)/osgOcean/include/osgOcean/FFTSimulation;C:/Program Files (x86)/osgOcean/include/osgOcean/GodRays;C:/Program Files (x86)/osgOcean/include/osgOcean/GodRayBlendSurface;C:/Program Files (x86)/osgOcean/include/osgOcean/MipmapGeometry;C:/Program Files (x86)/osgOcean/include/osgOcean/MipmapGeometryVBO;C:/Program Files (x86)/osgOcean/include/osgOcean/OceanScene;C:/Program Files (x86)/osgOcean/include/osgOcean/OceanTechnique;C:/Program Files (x86)/osgOcean/include/osgOcean/OceanTile;C:/Program Files (x86)/osgOcean/include/osgOcean/RandUtils;C:/Program Files (x86)/osgOcean/include/osgOcean/ScreenAlignedQuad;C:/Program Files (x86)/osgOcean/include/osgOcean/ShaderManager;C:/Program Files (x86)/osgOcean/include/osgOcean/SiltEffect;C:/Program Files (x86)/osgOcean/include/osgOcean/WaterTrochoids;C:/Program Files (x86)/osgOcean/include/osgOcean/Export;C:/Program Files (x86)/osgOcean/include/osgOcean/Version")
FILE(INSTALL DESTINATION "C:/Program Files (x86)/osgOcean/include/osgOcean" TYPE FILE FILES
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/include/osgOcean/Cylinder"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/include/osgOcean/DistortionSurface"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/include/osgOcean/FFTOceanTechnique"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/include/osgOcean/FFTOceanSurface"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/include/osgOcean/FFTOceanSurfaceVBO"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/include/osgOcean/FFTSimulation"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/include/osgOcean/GodRays"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/include/osgOcean/GodRayBlendSurface"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/include/osgOcean/MipmapGeometry"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/include/osgOcean/MipmapGeometryVBO"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/include/osgOcean/OceanScene"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/include/osgOcean/OceanTechnique"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/include/osgOcean/OceanTile"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/include/osgOcean/RandUtils"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/include/osgOcean/ScreenAlignedQuad"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/include/osgOcean/ShaderManager"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/include/osgOcean/SiltEffect"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/include/osgOcean/WaterTrochoids"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/include/osgOcean/Export"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/include/osgOcean/Version"
    )
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  list(APPEND CPACK_ABSOLUTE_DESTINATION_FILES
   "C:/Program Files (x86)/osgOcean/bin/resources/shaders/osgOcean_ocean_surface.frag;C:/Program Files (x86)/osgOcean/bin/resources/shaders/osgOcean_ocean_surface.vert;C:/Program Files (x86)/osgOcean/bin/resources/shaders/osgOcean_ocean_surface_vbo.vert;C:/Program Files (x86)/osgOcean/bin/resources/shaders/osgOcean_godrays.vert;C:/Program Files (x86)/osgOcean/bin/resources/shaders/osgOcean_godrays.frag;C:/Program Files (x86)/osgOcean/bin/resources/shaders/osgOcean_godray_screen_blend.vert;C:/Program Files (x86)/osgOcean/bin/resources/shaders/osgOcean_godray_screen_blend.frag;C:/Program Files (x86)/osgOcean/bin/resources/shaders/osgOcean_godray_glare.vert;C:/Program Files (x86)/osgOcean/bin/resources/shaders/osgOcean_godray_glare.frag;C:/Program Files (x86)/osgOcean/bin/resources/shaders/osgOcean_silt_quads.vert;C:/Program Files (x86)/osgOcean/bin/resources/shaders/osgOcean_silt_quads.frag;C:/Program Files (x86)/osgOcean/bin/resources/shaders/osgOcean_silt_points.vert;C:/Program Files (x86)/osgOcean/bin/resources/shaders/osgOcean_silt_points.frag;C:/Program Files (x86)/osgOcean/bin/resources/shaders/osgOcean_streak.vert;C:/Program Files (x86)/osgOcean/bin/resources/shaders/osgOcean_streak.frag;C:/Program Files (x86)/osgOcean/bin/resources/shaders/osgOcean_glare_composite.vert;C:/Program Files (x86)/osgOcean/bin/resources/shaders/osgOcean_glare_composite.frag;C:/Program Files (x86)/osgOcean/bin/resources/shaders/osgOcean_downsample_glare.frag;C:/Program Files (x86)/osgOcean/bin/resources/shaders/osgOcean_downsample.vert;C:/Program Files (x86)/osgOcean/bin/resources/shaders/osgOcean_downsample.frag;C:/Program Files (x86)/osgOcean/bin/resources/shaders/osgOcean_gaussian.vert;C:/Program Files (x86)/osgOcean/bin/resources/shaders/osgOcean_gaussian1.frag;C:/Program Files (x86)/osgOcean/bin/resources/shaders/osgOcean_gaussian2.frag;C:/Program Files (x86)/osgOcean/bin/resources/shaders/osgOcean_dof_combiner.vert;C:/Program Files (x86)/osgOcean/bin/resources/shaders/osgOcean_dof_combiner.frag;C:/Program Files (x86)/osgOcean/bin/resources/shaders/osgOcean_water_distortion.vert;C:/Program Files (x86)/osgOcean/bin/resources/shaders/osgOcean_water_distortion.frag;C:/Program Files (x86)/osgOcean/bin/resources/shaders/osgOcean_ocean_scene.vert;C:/Program Files (x86)/osgOcean/bin/resources/shaders/osgOcean_ocean_scene.frag;C:/Program Files (x86)/osgOcean/bin/resources/shaders/osgOcean_ocean_scene_lispsm.vert;C:/Program Files (x86)/osgOcean/bin/resources/shaders/osgOcean_ocean_scene_lispsm.frag;C:/Program Files (x86)/osgOcean/bin/resources/shaders/osgOcean_heightmap.vert;C:/Program Files (x86)/osgOcean/bin/resources/shaders/osgOcean_heightmap.frag")
FILE(INSTALL DESTINATION "C:/Program Files (x86)/osgOcean/bin/resources/shaders" TYPE FILE FILES
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/resources/shaders/osgOcean_ocean_surface.frag"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/resources/shaders/osgOcean_ocean_surface.vert"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/resources/shaders/osgOcean_ocean_surface_vbo.vert"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/resources/shaders/osgOcean_godrays.vert"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/resources/shaders/osgOcean_godrays.frag"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/resources/shaders/osgOcean_godray_screen_blend.vert"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/resources/shaders/osgOcean_godray_screen_blend.frag"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/resources/shaders/osgOcean_godray_glare.vert"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/resources/shaders/osgOcean_godray_glare.frag"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/resources/shaders/osgOcean_silt_quads.vert"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/resources/shaders/osgOcean_silt_quads.frag"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/resources/shaders/osgOcean_silt_points.vert"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/resources/shaders/osgOcean_silt_points.frag"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/resources/shaders/osgOcean_streak.vert"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/resources/shaders/osgOcean_streak.frag"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/resources/shaders/osgOcean_glare_composite.vert"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/resources/shaders/osgOcean_glare_composite.frag"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/resources/shaders/osgOcean_downsample_glare.frag"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/resources/shaders/osgOcean_downsample.vert"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/resources/shaders/osgOcean_downsample.frag"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/resources/shaders/osgOcean_gaussian.vert"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/resources/shaders/osgOcean_gaussian1.frag"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/resources/shaders/osgOcean_gaussian2.frag"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/resources/shaders/osgOcean_dof_combiner.vert"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/resources/shaders/osgOcean_dof_combiner.frag"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/resources/shaders/osgOcean_water_distortion.vert"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/resources/shaders/osgOcean_water_distortion.frag"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/resources/shaders/osgOcean_ocean_scene.vert"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/resources/shaders/osgOcean_ocean_scene.frag"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/resources/shaders/osgOcean_ocean_scene_lispsm.vert"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/resources/shaders/osgOcean_ocean_scene_lispsm.frag"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/resources/shaders/osgOcean_heightmap.vert"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/resources/shaders/osgOcean_heightmap.frag"
    )
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  list(APPEND CPACK_ABSOLUTE_DESTINATION_FILES
   "C:/Program Files (x86)/osgOcean/bin/resources/textures/sea_foam.png;C:/Program Files (x86)/osgOcean/bin/resources/textures/sun_glare.png")
FILE(INSTALL DESTINATION "C:/Program Files (x86)/osgOcean/bin/resources/textures" TYPE FILE FILES
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/resources/textures/sea_foam.png"
    "G:/Bawe/Kerjaan/NFS/src/3D/ext/osgOcean/resources/textures/sun_glare.png"
    )
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

