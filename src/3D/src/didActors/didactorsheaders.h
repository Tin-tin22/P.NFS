///////////////////////////////////////////////////////////////////////////////
//
// File           : $Workfile: didactorsheader
// Version        : $Revision: 1 $
// Function       : $the headers :p 
// Sam
// 
///////////////////////////////////////////////////////////////////////////////

//#ifndef DID_ACTORS_H_
//#define DID_ACTORS_H_
#pragma once

#include "export.h"

#include <math.h>
#include <iostream>
#include <cassert>

#include <dtCore/transform.h>
#include <dtCore/particlesystem.h>
#include <dtCore/deltawin.h>
#include <dtCore/environment.h>
#include <dtCore/skybox.h>
#include <dtCore/scene.h>
#include <dtCore/transform.h>
#include <dtCore/odebodywrap.h>
#include <dtCore/deltadrawable.h>
#include <dtCore/isector.h>

#include <dtABC/application.h>

#include <dtDAL/enginepropertytypes.h>
#include <dtDAL/gameeventmanager.h>
#include <dtDAL/LibraryManager.h>
#include <dtDAL/actorproxy.h>
#include <dtDAL/resourceactorproperty.h>
#include <dtDAL/ActorProxyIcon.h>

#include <dtGame/gamemanager.h>
#include <dtGame/machineinfo.h>
#include <dtgame/gameactor.h>
#include <dtGame/environmentactor.h>
#include <dtGame/messagetype.h>
#include <dtGame/message.h>
#include <dtGame/basemessages.h>
#include <dtGame/actorupdatemessage.h>

#include <dtActors/gamemeshactor.h>

#include <dtAudio/sound.h>
#include <dtAudio/audiomanager.h>
#include <dtAudio/soundeffectbinder.h>

#include <dtUtil/matrixutil.h>
#include <dtUtil/mathdefines.h>
#include <dtUtil/exception.h>
#include <dtUtil/nodecollector.h>
#include <dtUtil/refstring.h>
#include <dtUtil/enumeration.h>

#include <osg/Matrix>
#include <osg/MatrixTransform>
#include <osg/Math>
#include <osg/Fog>
#include <osg/TextureCubeMap>
#include <osg/LightSource>
#include <osg/PositionAttitudeTransform>
#include <osg/Vec2>
#include <osg/vec3>
#include <osg/Vec4>
#include <osg/Switch>

#include <osgDB/ReadFile>
#include <osgDB/FileUtils>

#include <osgSim/DOFTransform>

#include <osgOcean/OceanScene> 
#include <osgOcean/FFTOceanSurface>
#include <osgOcean/Cylinder>		     //#include "../didutils/cylinder.h"

#include <oceanExample/SkyDome.h>		 //#include "../didutils/skydome.h"
#include <oceanExample/SphereSegment.h>  //#include "../didutils/spheresegment.h"


//#endif /* DID_ACTORS_H_ */
