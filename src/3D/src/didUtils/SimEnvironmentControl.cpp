#include "SimEnvironmentControl.h"

#include "../didCommon/BaseConstant.h"
#include "../didNetwork/SimTCPDataTypes.h"
#include "../didActors/ShipModelActor.h"
#include "../didActors/treeactor.h" //

#include <dtActors/gamemeshactor.h>

#include <dtCore/dt.h>
#include <dtCore/odebodywrap.h>

#include <dtterrain/dtedterrainreader.h>

#include <osgOcean/ShaderManager>


SimEnvironmentControl::SimEnvironmentControl(void): dtGame::GMComponent("Environment Controller")
{
}

SimEnvironmentControl::~SimEnvironmentControl(void)
{
}

void SimEnvironmentControl::ProcessMessage(const dtGame::Message& message)
{
  if(message.GetMessageType() == SimMessageType::ENVIRONMENT_CONTROL)
  {
    const MsgEnvironmentControl &msg= static_cast<const MsgEnvironmentControl &>(message);
	CreateLevel(*GetGameManager()); 

  }
  if(message.GetMessageType() == SimMessageType::OCEAN_CONTROL)
  {
    ProcessOceanControlMessage(message);
  }
  if(message.GetMessageType() == SimMessageType::UTILITY_AND_TOOLS)
  {
    ProcessUtilityToolsMessage(message);
  }
}

void SimEnvironmentControl::CreateLevel(dtGame::GameManager &gameManager)
{
	SimLevelXML* levelXML = 
			dynamic_cast<SimLevelXML*>(gameManager.GetComponentByName("SimLevelXML"));	

	if (levelXML)
		CreateLevelXMLPorts(gameManager, levelXML);
	else
		CreateDefaultPorts(gameManager);
}

void SimEnvironmentControl::CreateLevelXMLPorts(dtGame::GameManager &gameManager, const SimLevelXML* levelXML)
{
	SimLevelObject terrain = levelXML->GetLevelComponent().mTerrain;
	std::vector<SimLevelObject> staticBuildings = levelXML->GetLevelComponent().mStaticBuildings;
	std::vector<SimLevelObject> staticShips = levelXML->GetLevelComponent().mStaticShips;
	std::vector<SimLevelObject> staticBuoys = levelXML->GetLevelComponent().mStaticBuoys;
    std::vector<SimLevelObject> staticTrees = levelXML->GetLevelComponent().mStaticTrees; // BAWE-20111003: PEPOHONAN

	dMass mass;
	dtCore::Transform tx;
	osg::Matrix matRot;
	dMassSetBox(&mass, 1.0f, 1.0f, 1.0f, 1.0f);
	dtCore::RefPtr<dtDAL::ActorProxy> proxy;
	dtCore::RefPtr<dtActors::GameMeshActor> actMesh;
	dtActors::GameMeshActorProxy *actProxy;

	//Terrain
	if (terrain.mMesh != "")
	{
		proxy = gameManager.CreateActor("dtcore.Game.Actors", "Game Mesh Actor");
		proxy->SetName(terrain.mName);
		if(!proxy.valid())
		{
			LOG_ERROR("Failed to create the object. Aborting.");
		}
		actMesh = static_cast<dtActors::GameMeshActor *>(proxy->GetActor());
		if(!actMesh.valid())
		{
			LOG_ERROR("The object was created, but has an invalid actor. Aborting.");
		}
		actProxy = static_cast<dtActors::GameMeshActorProxy *>(proxy.get());

		tx.SetTranslation(terrain.mTranslationXYZ);
		//tx.SetRotation(360.0f-terrain.mRotationHPR.x(), 360.0f-terrain.mRotationHPR.y(), 360.0f-terrain.mRotationHPR.z());
		tx.SetRotation(terrain.mRotationHPR.x(), terrain.mRotationHPR.y(), terrain.mRotationHPR.z());
		tx.GetRotation(matRot);
		actProxy->SetTranslation(terrain.mTranslationXYZ);
		actProxy->SetRotationFromMatrix(matRot);
		actMesh->SetMesh(terrain.mMesh);
		gameManager.AddActor(*proxy);
		actMesh->SetCollisionMesh();
		actMesh->SetMass(&mass);

		/* test crest foam

		didEnviro::OceanActorProxy* oceanProxy = NULL;
		gameManager.FindActorByName(C_CN_OCEAN, oceanProxy);

		const std::string terrain_vertex   = "terrain.vert";
		const std::string terrain_fragment = "terrain.frag";

		if (oceanProxy)
		{
			didEnviro::OceanActor* oceanActor = NULL;
			oceanActor = static_cast<didEnviro::OceanActor*>(proxy->GetActor());

			osg::Program* program = osgOcean::ShaderManager::instance().createProgram("terrain", terrain_vertex, terrain_fragment, "", "" );
			if(program) program->addBindAttribLocation("aTangent", 6);

			osg::ref_ptr<osg::Node> model = osgDB::readNodeFile(terrain.mMesh);
			//osg::Node *model = actMesh->GetMeshNode();
			if (model != NULL)
			{
				if ( actMesh->GetMatrixNode()->getNumChildren() != 0)
					 actMesh->GetMatrixNode()->removeChild(0,actMesh->GetMatrixNode()->getNumChildren());

				model->setNodeMask( oceanActor->GetOceanScene()->getNormalSceneMask() | 
					oceanActor->GetOceanScene()->getReflectedSceneMask() | 
					oceanActor->GetOceanScene()->getRefractedSceneMask() |
					oceanActor->GetOceanScene()->getHeightmapMask() |
					RECEIVE_SHADOW ); 
				//model->getStateSet()->addUniform( new osg::Uniform( "uTextureMap", 0 ) );

				//model->getOrCreateStateSet()->setAttributeAndModes(program,osg::StateAttribute::ON);
				//model->getStateSet()->addUniform( new osg::Uniform( "uOverlayMap", 1 ) );
				//model->getStateSet()->addUniform( new osg::Uniform( "uNormalMap",  2 ) );

				actMesh->GetMatrixNode()->addChild(model);
			}
		}
		*/

	}

	//Static buildings
	if (staticBuildings.size() > 0)
	{
		for (std::vector<SimLevelObject>::iterator iterBuilding = staticBuildings.begin(); iterBuilding != staticBuildings.end(); ++iterBuilding) 
		{
			if ((*iterBuilding).mMesh != "")
			{
				//Individual static building
				proxy= gameManager.CreateActor("dtcore.Game.Actors", "Game Mesh Actor");
				proxy->SetName((*iterBuilding).mName);
				if(!proxy.valid())
				{
					LOG_ERROR("Failed to create the object. Aborting.");
				}
				actMesh = static_cast<dtActors::GameMeshActor *>(proxy->GetActor());
				if(!actMesh.valid())
				{
					LOG_ERROR("The object was created, but has an invalid actor. Aborting.");
				}
				actProxy= static_cast<dtActors::GameMeshActorProxy *>(proxy.get());
				tx.SetTranslation((*iterBuilding).mTranslationXYZ);
				//tx.SetRotation(360.0f-(*iterBuilding).mRotationHPR.x(), 360.0f-(*iterBuilding).mRotationHPR.y(), 360.0f-(*iterBuilding).mRotationHPR.z());
				tx.SetRotation((*iterBuilding).mRotationHPR.x(), (*iterBuilding).mRotationHPR.y(), (*iterBuilding).mRotationHPR.z());
				tx.GetRotation(matRot);
				actProxy->SetTranslation((*iterBuilding).mTranslationXYZ);
				actProxy->SetRotationFromMatrix(matRot);
				actMesh->SetMesh((*iterBuilding).mMesh);
				gameManager.AddActor(*proxy);
				//actMesh->SetCollisionMesh();
				//actMesh->SetMass(&mass);

			}
		}
	}

	//Static ships
	if (staticShips.size() > 0)
	{
		for (std::vector<SimLevelObject>::iterator iterShip = staticShips.begin(); iterShip != staticShips.end(); ++iterShip) 
		{
			if ((*iterShip).mMesh != "")
			{
				//Individual static ship
				proxy= gameManager.CreateActor("dtcore.Game.Actors", "Game Mesh Actor");
				proxy->SetName("Level Ship");
				if(!proxy.valid())
				{
					LOG_ERROR("Failed to create the object. Aborting.");
				}
				actMesh = static_cast<dtActors::GameMeshActor *>(proxy->GetActor());
				if(!actMesh.valid())
				{
					LOG_ERROR("The object was created, but has an invalid actor. Aborting.");
				}
				actProxy= static_cast<dtActors::GameMeshActorProxy *>(proxy.get());
				tx.SetTranslation((*iterShip).mTranslationXYZ);
				//tx.SetRotation(360.0f-(*iterShip).mRotationHPR.x(), 360.0f-(*iterShip).mRotationHPR.y(), 360.0f-(*iterShip).mRotationHPR.z());
				tx.SetRotation((*iterShip).mRotationHPR.x(), (*iterShip).mRotationHPR.y(), (*iterShip).mRotationHPR.z());
				tx.GetRotation(matRot);
				actProxy->SetTranslation((*iterShip).mTranslationXYZ);
				actProxy->SetRotationFromMatrix(matRot);
				actMesh->SetMesh((*iterShip).mMesh);
				gameManager.AddActor(*proxy);
				//actMesh->SetCollisionMesh();
				//actMesh->SetMass(&mass);
			}
		}
	}

	//Static buoys
	if (staticBuoys.size() > 0)
	{
		for (std::vector<SimLevelObject>::iterator iterBuoy = staticBuoys.begin(); iterBuoy != staticBuoys.end(); ++iterBuoy) 
		{
			if ((*iterBuoy).mMesh != "")
			{
				//Individual static buoy
				proxy= gameManager.CreateActor("dtcore.Game.Actors", "Game Mesh Actor");
				proxy->SetName((*iterBuoy).mName);
				if(!proxy.valid())
				{
					LOG_ERROR("Failed to create the object. Aborting.");
				}
				actMesh = static_cast<dtActors::GameMeshActor *>(proxy->GetActor());
				if(!actMesh.valid())
				{
					LOG_ERROR("The object was created, but has an invalid actor. Aborting.");
				}
				actProxy= static_cast<dtActors::GameMeshActorProxy *>(proxy.get());
				tx.SetTranslation((*iterBuoy).mTranslationXYZ);
				//tx.SetRotation(360.0f-(*iterBuoy).mRotationHPR.x(), 360.0f-(*iterBuoy).mRotationHPR.y(), 360.0f-(*iterBuoy).mRotationHPR.z());
				tx.SetRotation((*iterBuoy).mRotationHPR.x(), (*iterBuoy).mRotationHPR.y(), (*iterBuoy).mRotationHPR.z());
				tx.GetRotation(matRot);
				actProxy->SetTranslation((*iterBuoy).mTranslationXYZ);
				actProxy->SetRotationFromMatrix(matRot);
				actMesh->SetMesh((*iterBuoy).mMesh);
				gameManager.AddActor(*proxy);
				//actMesh->SetCollisionMesh();
				//actMesh->SetMass(&mass);
			}
		}

	}

    //++ BAWE-20111003: PEPOHONAN
	//Static trees
	if (staticTrees.size() > 0)
	{
		for (std::vector<SimLevelObject>::iterator iterTree = staticTrees.begin(); iterTree != staticTrees.end(); ++iterTree) 
		{
			if ((*iterTree).mMesh != "")
			{
				//Individual static buoy
				//proxy= gameManager.CreateActor(C_ACTOR_CAT, C_CN_TREE);
                proxy= gameManager.CreateActor("dtcore.Game.Actors", "Game Mesh Actor");
				proxy->SetName((*iterTree).mName);
				if(!proxy.valid())
				{
					LOG_ERROR("Failed to create the object. Aborting.");
				}
				actMesh = static_cast<TreeActor *>(proxy->GetActor());
				if(!actMesh.valid())
				{
					LOG_ERROR("The object was created, but has an invalid actor. Aborting.");
				}
				actProxy= static_cast<TreeActorProxy *>(proxy.get());
				tx.SetTranslation((*iterTree).mTranslationXYZ);
				//tx.SetRotation(360.0f-(*iterBuoy).mRotationHPR.x(), 360.0f-(*iterBuoy).mRotationHPR.y(), 360.0f-(*iterBuoy).mRotationHPR.z());
				tx.SetRotation((*iterTree).mRotationHPR.x(), (*iterTree).mRotationHPR.y(), (*iterTree).mRotationHPR.z());
				tx.GetRotation(matRot);
				actProxy->SetTranslation((*iterTree).mTranslationXYZ);
				actProxy->SetRotationFromMatrix(matRot);
				actMesh->SetMesh((*iterTree).mMesh);

				gameManager.AddActor(*proxy);
				//actMesh->SetCollisionMesh();
				//actMesh->SetMass(&mass);
			}
		}
	}

    //-- BAWE-20111003: PEPOHONAN

    //BAWE-20110909: Test!
	std::cout<<"create ports. done"<<std::endl;

}
//-- BAWE-20101014: SIM_LEVEL_XML

//void SimEnvironmentControl::CreatePorts(dtGame::GameManager &gameManager) // BAWE-20101014: SIM_LEVEL_XML. ORI DISABLED
void SimEnvironmentControl::CreateDefaultPorts(dtGame::GameManager &gameManager) // BAWE-20101014: SIM_LEVEL_XML. NEW
{
  dMass mass;
  dMassSetBox(&mass, 1.0f, 1.0f, 1.0f, 1.0f);
  dtCore::RefPtr<dtDAL::ActorProxy> proxy= gameManager.CreateActor("dtcore.Game.Actors", "Game Mesh Actor");
  proxy->SetName("Level Terrain");
  if(!proxy.valid())
  {
    LOG_ERROR("Failed to create the object. Aborting.");
  }
  dtCore::RefPtr<dtActors::GameMeshActor> actMesh = static_cast<dtActors::GameMeshActor *>(proxy->GetActor());
  if(!actMesh.valid())
  {
    LOG_ERROR("The object was created, but has an invalid actor. Aborting.");
  }
  dtActors::GameMeshActorProxy *actProxy= static_cast<dtActors::GameMeshActorProxy *>(proxy.get());

  osg::Vec3 posOrigin(0.0f, 0.0f, 0.0f);
  actProxy->SetTranslation(posOrigin);
  actMesh->SetMesh("../data/mesh/Jakarta/Terrain.ive");
  gameManager.AddActor(*proxy);
  actMesh->SetCollisionMesh();
  actMesh->SetMass(&mass);

  proxy= gameManager.CreateActor("dtcore.Game.Actors", "Game Mesh Actor");
  proxy->SetName("Kapal Jakarta");
  if(!proxy.valid())
  {
	  LOG_ERROR("Failed to create the object. Aborting.");
  }
  actMesh = static_cast<dtActors::GameMeshActor *>(proxy->GetActor());
  if(!actMesh.valid())
  {
	  LOG_ERROR("The object was created, but has an invalid actor. Aborting.");
  }
  actProxy= static_cast<dtActors::GameMeshActorProxy *>(proxy.get());
  actProxy->SetTranslation(posOrigin);
  actMesh->SetMesh("../data/mesh/Jakarta/Kapal.ive");
  gameManager.AddActor(*proxy);
  actMesh->SetCollisionMesh();
  actMesh->SetMass(&mass);
  std::cout<<"create ports. done"<<std::endl;

  proxy= gameManager.CreateActor("dtcore.Game.Actors", "Game Mesh Actor");
  proxy->SetName("Building Jakarta");
  if(!proxy.valid())
  {
	  LOG_ERROR("Failed to create the object. Aborting.");
  }
  actMesh = static_cast<dtActors::GameMeshActor *>(proxy->GetActor());
  if(!actMesh.valid())
  {
	  LOG_ERROR("The object was created, but has an invalid actor. Aborting.");
  }
  actProxy= static_cast<dtActors::GameMeshActorProxy *>(proxy.get());
  actProxy->SetTranslation(posOrigin);
  actMesh->SetMesh("../data/mesh/Jakarta/Building.ive");
  gameManager.AddActor(*proxy);
  //actMesh->SetCollisionMesh();
  //actMesh->SetMass(&mass);
  std::cout<<"create ports. done"<<std::endl;

}

void SimEnvironmentControl::CreateOceanActor(dtGame::GameManager &gameManager)
{
	dtCore::RefPtr<dtDAL::ActorProxy> ap= gameManager.CreateActor(C_OCEAN_CAT, C_CN_OCEAN);
	dtCore::RefPtr<dtGame::IEnvGameActorProxy> gap= static_cast<dtGame::IEnvGameActorProxy *>(ap.get());
	dtCore::RefPtr<dtGame::IEnvGameActor> ga= static_cast<dtGame::IEnvGameActor*>(gap->GetActor());
	gameManager.SetEnvironmentActor(gap);
}


//++ BAWE-20110405: ON_THE_FLY_OCEAN_CONTROL
//////////////////////////////////////////////////////////////////////////
void SimEnvironmentControl::ProcessOceanControlMessage(const dtGame::Message& message)
{
    //Cast to MsgOceanControl
    const MsgOceanControl &oceanMsg= static_cast<const MsgOceanControl &>(message);

    //Get the OceanConfigActor
    dtGame::GameManager* gm = GetGameManager();
    const dtDAL::ActorType* type = gm->FindActorType(C_OCEAN_CAT, C_CN_OCEAN_CFG);
    //dtDAL::ActorProxy* proxy = NULL;
    didEnviro::OceanConfigActorProxy* proxy = NULL;
    
    //gm->FindActorByType(*type, proxy);
    gm->FindActorByName(C_CN_OCEAN_CFG, proxy);

    didEnviro::OceanConfigActor* configActor = NULL;
    if (proxy)
        configActor = static_cast<didEnviro::OceanConfigActor*>(proxy->GetActor());
    else
        return; //if not found = return

    //Switch to message
    unsigned int orderID = oceanMsg.GetOrderID();
    float fValue = oceanMsg.GetFloatValue();
    int iValue = oceanMsg.GetIntValue();

    switch (orderID)
    {
        //++ OCEAN_ABOVEWATER_FOG_HEIGHT
        case ORD_OCEAN_ABOVE_FOG_HEIGHT_INC:
            std::cout<< "Receive Increase Fog Height message!" <<std::endl;
            fValue = configActor->GetAboveWaterFogHeight() + fValue;
            if (fValue > 1.0f)
                fValue -= 1.0f;
            configActor->SetAboveWaterFogHeight(fValue);
            break;

        case ORD_OCEAN_ABOVE_FOG_HEIGHT_DEC:
            std::cout<< "Receive Decrease Fog Height message!" <<std::endl;
            fValue = configActor->GetAboveWaterFogHeight() - fValue;
            if (fValue < 0.0f)
                fValue += 1.0f;
            configActor->SetAboveWaterFogHeight(fValue);
            break;

        case ORD_OCEAN_ABOVE_FOG_HEIGHT_CHANGE:
            std::cout<< "Receive Change Fog Height message!" <<std::endl;
            fValue = fValue < 0.0f ? 0.0f : (fValue > 1.0f ? 1.0f : fValue);
            configActor->SetAboveWaterFogHeight(fValue);
            break;
        //-- OCEAN_ABOVEWATER_FOG_HEIGHT

        //++ BAWE-20110426: ON_THE_FLY_OCEAN_CONTROL_2: SEA_STATE
        //++ OCEAN_WAVE_SCALE
        case ORD_OCEAN_WAVE_SCALE_INC:
            std::cout<< "Receive Increase Wave Scale message!" <<std::endl;
            fValue = configActor->GetWaveScale() + fValue;
            if (fValue > 1.0f)
                fValue -= 1.0f;
            configActor->SetWaveScale(fValue);
            break;

        case ORD_OCEAN_WAVE_SCALE_DEC:
            std::cout<< "Receive Decrease Wave Scale message!" <<std::endl;
            fValue = configActor->GetWaveScale() - fValue;
            if (fValue < 0.0f)
                fValue = 0.0f;
            configActor->SetWaveScale(fValue);
            break;

        case ORD_OCEAN_WAVE_SCALE_CHANGE:
            std::cout<< "Receive Change Wave Scale message!" <<std::endl;
            fValue = fValue < 0.0f ? 0.0f : (fValue > 1.0f ? 1.0f : fValue);
            configActor->SetWaveScale(fValue);
            break;
        //-- OCEAN_WAVE_SCALE
        //++ OCEAN_WIND_SPEED
        case ORD_OCEAN_WIND_SPEED_INC:
            std::cout<< "Receive Increase Wind Speed message!" <<std::endl;
            fValue = configActor->GetWindSpeed() + fValue;
            configActor->SetWindSpeed(fValue);
            break;

        case ORD_OCEAN_WIND_SPEED_DEC:
            std::cout<< "Receive Decrease Wind Speed message!" <<std::endl;
            fValue = configActor->GetWindSpeed() - fValue;
            if (fValue < 0.0f)
                fValue = 0.0f;
            configActor->SetWindSpeed(fValue);
            break;

        case ORD_OCEAN_WIND_SPEED_CHANGE:
            std::cout<< "Receive Change Wind Speed message!" <<std::endl;
            fValue = fValue < 0.0f ? 0.0f : fValue;
            configActor->SetWindSpeed(fValue);
            break;
        //-- OCEAN_WIND_SPEED
        //++ OCEAN_WIND_DIRECTION (LENGTH)
        case ORD_OCEAN_WIND_LENGTH_INC:
            std::cout<< "Receive Increase Wind Length message!" <<std::endl;
            fValue = configActor->GetWindLength() + fValue;
            configActor->SetWindLength(fValue);
            break;

        case ORD_OCEAN_WIND_LENGTH_DEC:
            std::cout<< "Receive Decrease Wind Length message!" <<std::endl;
            fValue = configActor->GetWindLength() - fValue;
            if (fValue < 0.0f)
                fValue = 0.1f;
            configActor->SetWindLength(fValue);
            break;

        case ORD_OCEAN_WIND_LENGTH_CHANGE:
            std::cout<< "Receive Change Wind Length message!" <<std::endl;
            fValue = fValue < 0.0f ? 0.1f : fValue;
            configActor->SetWindLength(fValue);
            break;
        //-- OCEAN_WIND_DIRECTION (LENGTH)
        //++ OCEAN_SEA_STATE
        case ORD_OCEAN_SEA_STATE_INC:
            std::cout<< "Receive Increase Sea State message!" <<std::endl;
            iValue = configActor->GetSeaState() + iValue;
            if (iValue > 9)
                iValue = 0;
            configActor->SetSeaState(iValue);
            ResetShipsOceanVars();
            break;

        case ORD_OCEAN_SEA_STATE_DEC:
            std::cout<< "Receive Decrease Sea State message!" <<std::endl;
            iValue = configActor->GetSeaState() - iValue;
            if (iValue < 0)
                iValue = 9;
            configActor->SetSeaState(iValue);
            ResetShipsOceanVars();
            break;

        case ORD_OCEAN_SEA_STATE_CHANGE:
            std::cout<< "Receive Change Sea State message!" <<std::endl;
            iValue = fValue < 0 ? 0 : (iValue > 9 ? 9 : iValue);
            configActor->SetSeaState(iValue);
            ResetShipsOceanVars();
            break;
        //-- OCEAN_SEA_STATE
        //-- BAWE-20110426: ON_THE_FLY_OCEAN_CONTROL_2: SEA_STATE
            
    }


}

void SimEnvironmentControl::ChangeOceanParameter(const unsigned int orderOcean, const bool value)
{

}

void SimEnvironmentControl::ChangeOceanParameter(const unsigned int orderOcean, const int value)
{


    std::cout<< "Send the parameter to network!" <<std::endl;

    dtCore::RefPtr<MsgOceanControl> toSend;
    switch(orderOcean)
    {
        //Check all float type orders
        case ORD_OCEAN_SEA_STATE_INC:
        case ORD_OCEAN_SEA_STATE_DEC:
        case ORD_OCEAN_SEA_STATE_CHANGE:
            GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::OCEAN_CONTROL, toSend);

            // set message property
            toSend->SetOrderID(orderOcean);
            toSend->SetIntValue(value);

            GetGameManager()->SendNetworkMessage(*toSend.get());
            GetGameManager()->SendMessage(*toSend.get());
            break;
            //Discard the rest and warn
        default:
            std::ostringstream error;

            error << "Order "<< orderOcean <<" and value type int doesn't match! ";

            LOG_WARNING(error.str());
            break;
    };
}

void SimEnvironmentControl::ChangeOceanParameter(const unsigned int orderOcean, const float value)
{

    std::cout<< "Send the parameter to network!" <<std::endl;

    dtCore::RefPtr<MsgOceanControl> toSend;
    switch(orderOcean)
    {
        //Check all float type orders
        case ORD_OCEAN_ABOVE_FOG_HEIGHT_INC:
        case ORD_OCEAN_ABOVE_FOG_HEIGHT_DEC:
        case ORD_OCEAN_ABOVE_FOG_HEIGHT_CHANGE:
        case ORD_OCEAN_WAVE_SCALE_INC:  // BAWE-20110426: ON_THE_FLY_OCEAN_CONTROL_2: SEA_STATE
        case ORD_OCEAN_WAVE_SCALE_DEC:  // BAWE-20110426: ON_THE_FLY_OCEAN_CONTROL_2: SEA_STATE
        case ORD_OCEAN_WAVE_SCALE_CHANGE: // BAWE-20110426: ON_THE_FLY_OCEAN_CONTROL_2: SEA_STATE
        case ORD_OCEAN_WIND_SPEED_INC:  // BAWE-20110426: ON_THE_FLY_OCEAN_CONTROL_2: SEA_STATE
        case ORD_OCEAN_WIND_SPEED_DEC:  // BAWE-20110426: ON_THE_FLY_OCEAN_CONTROL_2: SEA_STATE
        case ORD_OCEAN_WIND_SPEED_CHANGE: // BAWE-20110426: ON_THE_FLY_OCEAN_CONTROL_2: SEA_STATE
        case ORD_OCEAN_WIND_LENGTH_INC: // BAWE-20110427: ON_THE_FLY_OCEAN_CONTROL_2: SEA_STATE
        case ORD_OCEAN_WIND_LENGTH_DEC: // BAWE-20110427: ON_THE_FLY_OCEAN_CONTROL_2: SEA_STATE
        case ORD_OCEAN_WIND_LENGTH_CHANGE: // BAWE-20110427: ON_THE_FLY_OCEAN_CONTROL_2: SEA_STATE
            GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::OCEAN_CONTROL, toSend);

            // set message property
            toSend->SetOrderID(orderOcean);
            toSend->SetFloatValue(value);

            GetGameManager()->SendNetworkMessage(*toSend.get());
            GetGameManager()->SendMessage(*toSend.get());
            break;
            //Discard the rest and warn
        default:
            std::ostringstream error;

            error << "Order "<< orderOcean <<" and value type float doesn't match! ";

            LOG_WARNING(error.str());
            break;
    };
}

void SimEnvironmentControl::ChangeOceanParameter(const unsigned int orderOcean, const osg::Vec2& value)
{

}

void SimEnvironmentControl::ChangeOceanParameter(const unsigned int orderOcean, const osg::Vec3& value)
{

}

void SimEnvironmentControl::ChangeOceanParameter(const unsigned int orderOcean, const osg::Vec4& value)
{

}
//-- BAWE-20110405: ON_THE_FLY_OCEAN_CONTROL

void  SimEnvironmentControl::ResetShipsOceanVars()
{
    //typedef std::vector<dtDAL::BaseActorObject*> ProxyArray;
    typedef std::vector<dtDAL::ActorProxy*> ProxyArray;
    ProxyArray proxyArray;

    // Evacuate all the sound actors.
    dtGame::GameManager* gm = GetGameManager();
    gm->FindActorsByType(*(gm->FindActorType(C_ACTOR_CAT, C_CN_SHIP)), proxyArray);

    ProxyArray::iterator curProxy = proxyArray.begin();
    ProxyArray::iterator endProxyList = proxyArray.end();

    for (; curProxy != endProxyList; ++curProxy)
    {

          dtCore::RefPtr<ShipModelActor> actor = 
              dynamic_cast<ShipModelActor*> ( dynamic_cast<ShipModelActorProxy*> (*curProxy)->GetActor());

          actor->ResetOceanWaveVars();
    }
}

//++ BAWE-20110622: PAUSE_GAME
void SimEnvironmentControl::ProcessUtilityToolsMessage(const dtGame::Message& message)
{
    //Cast to MsgUtilityAndTools
    const MsgUtilityAndTools &utilMsg= static_cast<const MsgUtilityAndTools &>(message);

    if (utilMsg.GetOrderID() == TIPE_UTIL_PAUSE_GAME)
        GetGameManager()->SetPaused((utilMsg.GetUAT0() == 0 ? false: true));
}

//-- BAWE-20110622: PAUSE_GAME
