#pragma once

#ifdef USE_VLD
#include <vld.h>
#endif

#include <dtgame/gmcomponent.h>

#include "../didCommon/simmessages.h"
#include "../didCommon/simmessagetype.h"
#include "../didActors/oceanactor.h"
#include "../didActors/oceanconfigactor.h"

#include "SimLevelXML.h"

class SimEnvironmentControl : public dtGame::GMComponent
{
	private:

	public:
	  //double mLong, mLat;
	  dtCore::RefPtr<dtActors::GameMeshActor> mPort;
	  dtCore::RefPtr<dtActors::GameMeshActor> mEastJava;		
	  SimEnvironmentControl(void);
	  ~SimEnvironmentControl(void);
	  virtual void ProcessMessage(const dtGame::Message& message);
	  void CreateLevel(dtGame::GameManager &gameManager);
	  void CreateLevelXMLPorts(dtGame::GameManager &gameManager, const SimLevelXML* levelXML);
	  void CreateDefaultPorts(dtGame::GameManager &gameManager);
	  void CreateOceanActor(dtGame::GameManager &gameManager);

      virtual void ProcessOceanControlMessage(const dtGame::Message& message);

      void ChangeOceanParameter(const unsigned int orderOcean, const bool value);
      void ChangeOceanParameter(const unsigned int orderOcean, const int value);
      void ChangeOceanParameter(const unsigned int orderOcean, const float value);
      void ChangeOceanParameter(const unsigned int orderOcean, const osg::Vec2& value);
      void ChangeOceanParameter(const unsigned int orderOcean, const osg::Vec3& value);
      void ChangeOceanParameter(const unsigned int orderOcean, const osg::Vec4& value);
       
      void ProcessUtilityToolsMessage(const dtGame::Message& message);

      void ResetShipsOceanVars();
};
