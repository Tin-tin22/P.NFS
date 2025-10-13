#include "SimInputServerComponent.h"

#include <dtGame/basemessages.h>
#include <dtGame/messagetype.h>
#include <dtGame/gameactor.h>
#include <dtDAL/enginepropertytypes.h>
#include <dtABC/application.h>
#include <dtCore/refptr.h>
#include <vector>

#include "../didCommon/BaseConstant.h"
#include "../didCommon/SimServerMessage.h"
#include "../didCommon/SimMessages.h"
#include "../didCommon/SimMessageType.h"
#include "../didNetwork/SimTCPDataTypes.h"
#include "../didUtils/SimActorControl.h"
#include "../didUtils/SimEffectControl.h"
#include "../didUtils/SimServerClientComponent.h"
#include "../didActors/shipmodelactor.h"
#include "../didActors/launcherbodyactor.h"
#include "../didUtils/utilityfunctions.h"


#include "../didNetwork/SocketServer.h"

#include <dtTerrain/terrain.h>

#include <dtActors/gamemeshactor.h>
#include <dtCore/system.h>

#include <osg/TexEnv>
#include <osg/Material>
#include <osgViewer/viewer>
#include <osg/Depth>

#define _WINSOCKAPI_
#ifndef WIN32_LEAN_AND_MEAN
#define WIN32_LEAN_AND_MEAN
#endif
#include <dtUtil/mswin.h>
#pragma comment(lib, "ws2_32.lib")

const int DEFAULT_WIN_X   = 60;
const int DEFAULT_WIN_Y   = 30;
const int DEFAULT_VIEW_WIDTH      = 640;
const int DEFAULT_VIEW_HEIGHT     = 480;
const float DEFAULT_ASPECT_RATIO = DEFAULT_VIEW_WIDTH / (float)DEFAULT_VIEW_HEIGHT;


////////////////////////////////////////////////////////////////////
InputComponent::InputComponent(const std::string &name, bool inPlaybackMode) :
   dtGame::BaseInputComponent(name) 
{
  mShipFocusIndex		= -1;
  mSubMarineFocusIndex	= -1 ;
  mMiscFocusIndex		= -1;
  mHeliFocusIndex		= -1 ;
  enableProcessMessage = true;
}

////////////////////////////////////////////////////////////////////
bool InputComponent::HandleKeyReleased(const dtCore::Keyboard* keyboard, int key ) 
{
	bool handled = false;
	
	if (!handled)
		return BaseInputComponent::HandleKeyReleased(keyboard, key );

    return handled;
}

bool InputComponent::HandleKeyPressed(const dtCore::Keyboard* keyboard, int key )
{
	bool handled = true;

	//////////////////////////////////// test input, !! disable ketika di release //////////////////////////////////////
	if (key== '1')   
	{

		test_ship_move_message(6,ORD_THROTTLE,25);
		test_ship_move_message(6,ORD_RUDDER,15);
		send_player_message(TIPE_UTIL_PLAYER_SETTING,0,PLAYER_SET_ATTACH_SHIP,6,0,0,0,0); //game server
		//send_player_message(TIPE_UTIL_PLAYER_SETTING,START_MACHINE_OBSERVER+1,PLAYER_SET_ATTACH_SHIP,6,0,0,0,0);

		/*
		SimServerClientComponent* simSC = static_cast<SimServerClientComponent*> (GetGameManager()->GetComponentByName(C_COMP_SERVER_CLIENT_CTRL));
		if ( simSC != NULL )
		{
			simSC->SetPlayerAttachToVehicle(6);
		}
		*/

		handled= true;
	}
	else if (key== '2')  
	{
		test_delete_ship_message(6);
		handled= true;
	}

	else if (key== '3')  
	{

		test_explode(1,1,5,osg::Vec3(0,0,100),true);

		/*
		dtCore::Camera& camera = *GetGameManager()->GetApplication().GetCamera();
		GetGameManager()->GetApplication().GetView()->GetOsgViewerView()->setLightingMode(osg::View::NO_LIGHT);
		osg::StateSet* globalState = camera.GetOSGCamera()->getOrCreateStateSet();
		globalState->setMode(GL_LIGHTING, osg::StateAttribute::OFF);
		*/

		handled= true;
	}
	else
	if (key == '4')
	{
		test_explode(1,0,5,osg::Vec3(0,0,-100),true);
	}
	else
	if (key == '5')
	{
		test_rbu(10,2,2,12,1);
		//test_assigned_asroc(6,1,1,1,1);
	}
	else
	if (key == '6')
	{
		test_asroc(6,1,1,1,1);
		follow_missile(6,1,1,1,1);
	}
	else
	if (key == '7')
	{
		//test_canon(30,14,1,1,1);
		static int mnum(0);
		mnum++;
		test_canon(20,12,2,1,mnum); //canon 40
	}
	else
	if (key == '8')
	{
		test_yakhont(2,6,1,1,1);
		//test_reload_exocet(30, 10, 1, 1, 1);
	}
	else
		if (key == '9')
		{
			test_sut_fire();
		}
		else
			if (key == '0')
			{
				test_sut_homing();
			}
	else
	//////////////////////////////////// test input, !! disable ketika di release  //////////////////////////////////////

	//////////////////////////////////// used input server //////////////////////////////////////
	if (key== 'x')
	{
		cycle_player_ship_focus();
		handled= true; 
	}
	else if (key== 'z')
	{
		cycle_player_submarine_focus();
		handled= true;
	}else if (key== 'c')
	{
		//cycle_player_heli_focus();
		test_camera();

		handled= true;
	} 
	else if (key== 'k')
	{
		// PlayerID 3DServer = 0 ; always // set keyboard off
		send_player_message(TIPE_UTIL_PLAYER_SETTING,0,PLAYER_SET_BASE,SET_BASE_KEYBOARD,0,0,0,0);
		handled= true;
	}else if (key== 'K')
	{
		// PlayerID 3DServer = 0 ; always // set keyboard off
		send_player_message(TIPE_UTIL_PLAYER_SETTING,0,PLAYER_SET_BASE,SET_BASE_KEYBOARD,SET_BASE_KEY_ON,0,0,0);
		handled= true;
	} 
	else if (key=='w')
	{
		dtCore::RefPtr<MsgOrder> msgSwitch;

		dtGame::GameManager* gm= GetGameManager();
		dtGame::MessageFactory* mf=&gm->GetMessageFactory();
		mf->CreateMessage(*(mf->GetMessageTypeByName(C_MT_ORDER_EVENT)),msgSwitch);

		msgSwitch->SetVehicleID(1023);
		msgSwitch->SetOrderID(ORD_SWITCH_TARGET);
		msgSwitch->SetFloatValue(1); 
		msgSwitch->SetStringValue("true"); 
		//msgSwitch->SetFloatValue1(vpos.x());
		//msgSwitch->SetFloatValue2(vpos.y());
		//msgSwitch->SetFloatValue3(vpos.z());
		GetGameManager()->SendNetworkMessage(*msgSwitch);
		GetGameManager()->SendMessage(*msgSwitch);
		std::cout<<GetName()<<" send status  3D Switch"<<std::endl;
//		std::cout << "Vpos : " << vpos << std::endl;
	}
	else if (key=='a')
	{
		SimActorControl* simCtrl = static_cast<SimActorControl*> (GetGameManager()->GetComponentByName(C_COMP_ACTOR_CONTROLLER));
		if ( simCtrl != NULL )
		{
			dtCore::RefPtr<dtDAL::ActorProxy> ap = simCtrl->GetLauncherActors(C_WEAPON_TYPE_SPOUT,1,8,1 );
			if(!ap.valid())
			{
				simCtrl->CreateLaunchersActors(1,8,1);
			}
		}
		else
		{
			std::cout << "Sim Actor Control Not Valid" << std::endl;
		}
	}
	else if (key=='d')
	{
		SimActorControl* simCtrl = static_cast<SimActorControl*> (GetGameManager()->GetComponentByName(C_COMP_ACTOR_CONTROLLER));
		if ( simCtrl != NULL )
		{
			dtCore::RefPtr<dtDAL::ActorProxy> aps = simCtrl->GetLauncherActors(C_WEAPON_TYPE_SPOUT,1,8,1 );
			if(aps.valid())
			{
				simCtrl->DeleteLauncherActors(C_WEAPON_TYPE_SPOUT, 1, 8, 1);
			}
			else
				std::cout << "No Launcher Spout" << std::endl;

			dtCore::RefPtr<dtDAL::ActorProxy> apb = simCtrl->GetLauncherActors(C_WEAPON_TYPE_BODY,1,8,1 );
			if(apb.valid())
			{
				simCtrl->DeleteLauncherActors(C_WEAPON_TYPE_BODY, 1, 8, 1);

				//harus nya di onremovedfromworld launcherbodyactor.cpp
				dtCore::RefPtr<dtDAL::ActorProxy> parentProxy = simCtrl->GetShipActorByID(1);
				ShipModelActor* shp  = static_cast<ShipModelActor*>(parentProxy->GetActor());
				LauncherBodyActor* lba = static_cast<LauncherBodyActor*>(apb->GetActor());
				if (shp!= NULL) {
					shp->SetSwitchWeaponOFF(lba->GetIndexSwitchWeaponParents(), true);
					shp->GetGameActorProxy().NotifyFullActorUpdate();
				}
			}
			else
				std::cout << "No Launcher Body" << std::endl;
		}
	}
	else if (key=='s')
	{
		TestErrorLooping();
	}
	else if ( key == 'y' )
	{
		dtCore::RefPtr<MsgOrder> orderMsg;
		GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::ORDER_EVENT, orderMsg);

		orderMsg->SetVehicleID(29);
		orderMsg->SetOrderID(ORD_RUDDER);
		//orderMsg->SetFloatValue1(); //x
		//orderMsg->SetFloatValue2(); //y
		//orderMsg->SetFloatValue3(); //z
		orderMsg->SetModeGuidance(3); //waypoint
		orderMsg->SetModeAltitude( 2 );
		//orderMsg->SetModeAltitude((unsigned int)sord.modeAltitude);

		GetGameManager()->SendNetworkMessage(*orderMsg.get());
		GetGameManager()->SendMessage(*orderMsg.get());
	}
	//////////////////////////////// used input client //////////////////////////////////////////
	else
		return BaseInputComponent::HandleKeyPressed(keyboard, key);
	return handled;
}

void InputComponent::TestErrorLooping()
{
	for (int i=0; i<100; i++)
	{
		std::cout << "=============================================> " << i+1 << std::endl;
		// CREATE
		SimActorControl* simCtrl = static_cast<SimActorControl*> (GetGameManager()->GetComponentByName(C_COMP_ACTOR_CONTROLLER));
		if ( simCtrl != NULL )
		{
			dtCore::RefPtr<dtDAL::ActorProxy> ap = simCtrl->GetLauncherActors(C_WEAPON_TYPE_SPOUT,1,8,1 );
			//if(!ap.valid())
			//{
			simCtrl->CreateLaunchersActors(1,8,1);
			//}
		}
		else
		{
			std::cout << "Sim Actor Control Not Valid" << std::endl;
		}

		// DELETE
		if ( simCtrl != NULL )
		{
			dtCore::RefPtr<dtDAL::ActorProxy> aps = simCtrl->GetLauncherActors(C_WEAPON_TYPE_SPOUT,1,8,1 );
			if(aps.valid())
			{
				simCtrl->DeleteLauncherActors(C_WEAPON_TYPE_SPOUT, 1, 8, 1);
			}
			else
				std::cout << "No Launcher Spout" << std::endl;

			dtCore::RefPtr<dtDAL::ActorProxy> apb = simCtrl->GetLauncherActors(C_WEAPON_TYPE_BODY,1,8,1 );
			if(apb.valid())
			{
				simCtrl->DeleteLauncherActors(C_WEAPON_TYPE_BODY, 1, 8, 1);

				//harus nya di onremovedfromworld launcherbodyactor.cpp
				dtCore::RefPtr<dtDAL::ActorProxy> parentProxy = simCtrl->GetShipActorByID(1);
				ShipModelActor* shp  = static_cast<ShipModelActor*>(parentProxy->GetActor());
				LauncherBodyActor* lba = static_cast<LauncherBodyActor*>(apb->GetActor());
				if (shp!= NULL) {
					shp->SetSwitchWeaponOFF(lba->GetIndexSwitchWeaponParents(), true);
					shp->GetGameActorProxy().NotifyFullActorUpdate();
				}
			}
			else
				std::cout << "No Launcher Body" << std::endl;
		}
	}
}

//////////////////////////////////////////////////////////////////////////
void InputComponent::follow_missile (  const int VID, const int WID, const int LID, const int MID, const int MNUM  )
{
	SimActorControl* simCtrl = static_cast<SimActorControl*> (GetGameManager()->GetComponentByName(C_COMP_ACTOR_CONTROLLER));
	if ( simCtrl != NULL )
	{
		dtCore::RefPtr<dtDAL::ActorProxy> ap = simCtrl->GetMissileActors(VID,WID,LID,MID,MNUM);
		if( ap.valid() )
		{

			dtCore::RefPtr<dtCore::Camera> mCam = GetGameManager()->GetApplication().GetCamera();
			if ( mCam->GetParent() != NULL )
				mCam->GetParent()->RemoveChild(mCam);

			dtCore::Transform tmpTrans;
			tmpTrans.Set(-150,0,15.0f,-90.0f,0,0);

			ap->GetActor()->AddChild(mCam);
			mCam->SetTransform(tmpTrans,dtCore::Transformable::REL_CS);

			std::cout<<"Set camera focus to "<<ap->GetName()<<std::endl;
		}
	}
}

void InputComponent::ceck_missile (  const int VID, const int WID, const int LID, const int MID, const int MNUM  ) 
{
	SimActorControl* simCtrl = static_cast<SimActorControl*> (GetGameManager()->GetComponentByName(C_COMP_ACTOR_CONTROLLER));
	if ( simCtrl != NULL )
	{
		dtCore::RefPtr<dtDAL::ActorProxy> lcr = simCtrl->GetLauncherActors(C_WEAPON_TYPE_SPOUT,VID,WID,LID );
		if(!lcr.valid())
		{
			simCtrl->CreateLaunchersActors(VID,WID,LID);
		}

		dtCore::RefPtr<dtDAL::ActorProxy> msl = simCtrl->GetMissileActors(VID,WID,LID,MID,MNUM);
		if(!msl.valid())
		{
			simCtrl->CreateMissileActors(VID,WID,LID,MID,MNUM);
		}
	}
}

/** 
test_ship_move_message(6,ORD_RUDDER,15);
**/
void InputComponent::test_ship_move_message(const int shipID, const int orderID, const float orderVal )
{

	dtCore::RefPtr<MsgOrder> Msg;
	GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::ORDER_EVENT, Msg);

	Msg->SetVehicleID(shipID);
	Msg->SetOrderID(orderID);
	Msg->SetFloatValue(orderVal);

	GetGameManager()->SendNetworkMessage(*Msg.get());
	GetGameManager()->SendMessage(*Msg.get());
}

/**
test_asroc(6,CT_ASROC,1,1,1);
**/
void InputComponent::test_asroc(  const int VID, const int WID, const int LID, const int MID, const int MNUM  ) 
{
	ceck_missile(VID,WID,LID,MID,MNUM);

	dtCore::RefPtr<MsgSetAsrock> Msg;
	GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::ASROCK_EVENT, Msg);

	Msg->SetVehicleID(VID);
	Msg->SetWeaponID(WID);
	Msg->SetLauncherID(LID);
	Msg->SetMissileID(MID);
	Msg->SetMissileNum(MNUM);

	Msg->SetOrderID(ORD_ASROCK);
	Msg->SetTargetBearing(45.0f);
	Msg->SetTargetRange(3600);
	Msg->SetMissileType(4);
	/*Msg->SetTargetRange(2350);
	Msg->SetMissileType(3);*/
	/*Msg->SetTargetRange(1040);
	Msg->SetMissileType(2);*/
	/*Msg->SetTargetRange(600);
	Msg->SetMissileType(1);*/
	Msg->SetTargetDepth(15);
	Msg->SetMissileFuze(0);
	Msg->SetTargetID(1023);

	GetGameManager()->SendNetworkMessage(*Msg.get());
	GetGameManager()->SendMessage(*Msg.get());

}


void InputComponent::test_sut_fire()
{
	dtCore::RefPtr<MsgSetTorpedoSUT> Msg = NULL;
	GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::TORPEDOSUT_EVENT, Msg);
	Msg->SetVehicleID(20);
	Msg->SetWeaponID(4);
	Msg->SetLauncherID(1);
	Msg->SetMissileID(1);
	Msg->SetMissileNum(1);
	Msg->SetOrderID(1);
	Msg->SetModePrediction(3);
	Msg->SetTargetID(0);
	Msg->SetTorpedoCourse(0);
	Msg->SetTorpedoSpeed(15);
	Msg->SetTorpedoDepth(50);
	Msg->SetTorpedoSafeDistance(100);
	Msg->SetTorpedoEnDis(200);
	Msg->SetTargetType(1); //surface atau subsurface

	GetGameManager()->SendNetworkMessage(*Msg);   					
	GetGameManager()->SendMessage(*Msg);
}

void InputComponent::test_sut_homing()
{
	dtCore::RefPtr<MsgSetTorpedoSUT> Msg = NULL;
	GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::TORPEDOSUT_EVENT, Msg);
	Msg->SetVehicleID(20);
	Msg->SetLauncherID(2);
	Msg->SetWeaponID(4);	
	Msg->SetMissileID(1);
	Msg->SetMissileNum(1);
	Msg->SetOrderID(3); //11 = targetsearchprogram, 3 = homing
	Msg->SetTorpedoCourse(246);
	Msg->SetTorpedoSpeed(34);
	Msg->SetTorpedoDepth(18);
	Msg->SetTorpedoSafeDistance(249);
	Msg->SetTorpedoEnDis(6000);
	Msg->SetModePrediction(5); //5 = homing, 4=targetsearchprogram
	Msg->SetTargetID(505);
	
	Msg->SetTorpedoSafeDistance(100);
	Msg->SetTorpedoEnDis(200);
	Msg->SetTargetType(1); //surface atau subsurface

	GetGameManager()->SendNetworkMessage(*Msg);   					
	GetGameManager()->SendMessage(*Msg);
}

void InputComponent::test_reload_exocet(  const int VID, const int WID, const int LID, const int MID, const int MNUM  ) 
{
	ceck_missile(VID,WID,LID,MID,MNUM);

	dtCore::RefPtr<MsgSetExocetMM40> Msg;
	GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::EXOCETMM_40_EVENT, Msg);

	Msg->SetVehicleID(VID);
	Msg->SetWeaponID(WID);
	Msg->SetLauncherID(LID);
	Msg->SetMissileID(MID);
	Msg->SetMissileNum(MNUM);
	Msg->SetOrderID(ORD_MM40_RELOAD);
	/*Msg->SetTargetRange(14816.0f);
	Msg->SetTargetBearing(17.0f);
	Msg->SetAngularMode(0);
	Msg->SetAgilityMode(0);
	Msg->SetInitialStepMode(0);
	Msg->SetObstacle_Alt(1000);
	Msg->SetObstacle_Range(500);
	Msg->SetApproach_Range(2000);
	Msg->SetTerminal_Range(1);*/

	GetGameManager()->SendNetworkMessage(*Msg.get());
	GetGameManager()->SendMessage(*Msg.get());

}

void InputComponent::test_rbu(  const int VID, const int WID, const int LID, const int MID, const int MNUM  ) 
{
	ceck_missile(VID,WID,LID,MID,MNUM);

	dtCore::RefPtr<MsgSetRBU> Msg;
	GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::RBU_EVENT, Msg);

	Msg->SetVehicleID(VID);
	Msg->SetWeaponID(WID);
	Msg->SetLauncherID(LID);
	Msg->SetMissileID(MID);
	Msg->SetMissileNum(MNUM);
	Msg->SetOrderID(ORD_RBU_FIRE);
	Msg->SetTargetBearing(-25.1383);
	Msg->SetTargetRange(3926.52);
	Msg->SetMissileType(2);
	Msg->SetTargetID(507);
	Msg->SetCountRBU(12);
	Msg->SetCorrectBearing(0);
	Msg->SetCorrectElev(0);
	Msg->SetTargetDepth(0);

	GetGameManager()->SendNetworkMessage(*Msg.get());
	GetGameManager()->SendMessage(*Msg.get());

}

/**
test_yakhont release
**/
void InputComponent::test_yakhont(  const int VID, const int WID, const int LID, const int MID, const int MNUM  ) 
{
	ceck_missile(VID,WID,LID,MID,MNUM);

	dtCore::RefPtr<MsgSetYakhont> Msg;
	GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::YAKHONT_EVENT, Msg);

	Msg->SetVehicleID(VID);
	Msg->SetWeaponID(WID);
	Msg->SetLauncherID(LID);
	Msg->SetMissileID(MID);
	Msg->SetMissileNum(MNUM);
	Msg->SetOrderID(ORD_YAKHONT_RELEASE);

	/*Msg->SetOrderID(ORD_YAKHONT_FIRE);
	Msg->SetBearingToTarget(90.04); 
	Msg->SetDistanceToTarget(14445.6);*/

	GetGameManager()->SendNetworkMessage(*Msg.get());
	GetGameManager()->SendMessage(*Msg.get());
	
	/* CAMERA UTIL (dibuat player)*/
	std::cout << "Send Message for firing lock" << std::endl;
	dtCore::RefPtr<MsgUtilityAndTools> MsgCam;
	GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::UTILITY_AND_TOOLS, MsgCam);
	MsgCam->SetOrderID(TIPE_UTIL_PLAYER_SETTING);
	MsgCam->SetUAT0(0);
	MsgCam->SetUAT1(PLAYER_SET_FIRING_LOCK);
	MsgCam->SetUAT2(VID);
	MsgCam->SetUAT3(WID);
	MsgCam->SetUAT4(LID);
	MsgCam->SetUAT5(MID);
	MsgCam->SetUAT6(MNUM);
	GetGameManager()->SendNetworkMessage(*MsgCam);   					
	GetGameManager()->SendMessage(*MsgCam); 
}

void InputComponent::test_canon(  const int VID, const int WID, const int LID, const int MID, const int MNUM  ) 
{
	dtCore::RefPtr<MsgSetCannon> Msg = NULL;
	GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::CANNON_EVENT, Msg);
	Msg->SetVehicleID(VID);
	Msg->SetWeaponID(WID);
	Msg->SetLauncherID(LID);
	Msg->SetMissileID(MID);
	Msg->SetMissileNum(MNUM);
	Msg->SetOrderID(ORD_CANNON_F);
	Msg->SetModeID(1);
	Msg->SetTargetID(1024);
	Msg->SetUpDown(0);
	Msg->SetAutoCorrectElev(0);
	Msg->SetAutoCorrectBearing(0);
	Msg->SetBalistikID(0);

	GetGameManager()->SendNetworkMessage(*Msg.get());
	GetGameManager()->SendMessage(*Msg.get());

	dtCore::RefPtr<MsgUtilityAndTools> MsgCam;
	//GetGameActorProxy().GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::UTILITY_AND_TOOLS, MsgCam);

	dtGame::GameManager* gm = GetGameManager();
	dtGame::MessageFactory* mf=&gm->GetMessageFactory();
	mf->CreateMessage(*(mf->GetMessageTypeByName(C_MT_UTILITY_AND_TOOLS)),MsgCam);

	MsgCam->SetOrderID(52);
	MsgCam->SetUAT0(0);
	MsgCam->SetUAT1(1);
	MsgCam->SetUAT2(0);
	MsgCam->SetUAT3(0);
	MsgCam->SetUAT4(0);
	MsgCam->SetUAT5(0);
	MsgCam->SetUAT6(0);

	GetGameManager()->SendNetworkMessage(*MsgCam);   					
	GetGameManager()->SendMessage(*MsgCam);
}

void InputComponent::test_assigned_asroc(  const int VID, const int WID, const int LID, const int MID, const int MNUM  ) 
{
	ceck_missile(VID,WID,LID,MID,MNUM);

	dtCore::RefPtr<MsgSetAsrock> Msg;
	GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::ASROCK_EVENT, Msg);

	Msg->SetVehicleID(VID);
	Msg->SetWeaponID(WID);
	Msg->SetLauncherID(LID);
	Msg->SetMissileID(MID);
	Msg->SetMissileNum(MNUM);

	Msg->SetOrderID(ORD_ASROCK_ASSIGNED);
	/*Msg->SetTargetBearing(45.0f);
	Msg->SetTargetRange(3600);*/
	Msg->SetMissileType(6);
	/*Msg->SetTargetRange(2350);
	Msg->SetMissileType(3);*/
	/*Msg->SetTargetRange(1040);
	Msg->SetMissileType(2);*/
	/*Msg->SetTargetRange(600);
	Msg->SetMissileType(1);*/
	Msg->SetTargetDepth(0);
	Msg->SetMissileFuze(0);
	Msg->SetCorrectRange(0);
	Msg->SetTargetID(511); //type214freigate

	GetGameManager()->SendNetworkMessage(*Msg.get());
	GetGameManager()->SendMessage(*Msg.get());
}

void InputComponent::test_explode(  const int ExplodeID, const int ExplodeType, const float ExplodeLife, const osg::Vec3 pos, const bool setCamera  )
{
	SimEffectControl* simEffect = static_cast<SimEffectControl*> (GetGameManager()->GetComponentByName("SimEffectControl"));
	if ( simEffect != NULL )
	{
		simEffect->AddEffectAndExplode(ExplodeID,0,ExplodeType, 0,ExplodeLife,pos);

		if ( setCamera )
		{
			osg::Vec3 xyz = pos ;
			xyz.y() = xyz.y()-100 ;
			dtCore::Transform tmpTrans;
			tmpTrans.SetTranslation(xyz);
			SimServerClientComponent* simSC = static_cast<SimServerClientComponent*> (GetGameManager()->GetComponentByName(C_COMP_SERVER_CLIENT_CTRL));
			if ( simSC != NULL )
			{
				simSC->set_player_or_camera_transform(tmpTrans);
			}
		}

		std::cout<<GetName()<<"--Explode Effect at : "<<pos<<std::endl;
	}
}

void InputComponent::test_explode_message(  const int ExplodeID, const int ExplodeType, const float ExplodeLife, const osg::Vec3 pos, const bool setCamera  )
{
	dtCore::RefPtr<MsgUtilityAndTools> msgExplode;
	GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::UTILITY_AND_TOOLS, msgExplode);

	msgExplode->SetOrderID(TIPE_UTIL_EVENT_EXPLODE);
	msgExplode->SetUAT0(ExplodeType);
	msgExplode->SetUAT1(pos.x());    
	msgExplode->SetUAT2(pos.y());   
	msgExplode->SetUAT3(pos.z());   
	if ( setCamera )
	{
		msgExplode->SetUAT4(1);		 /// setCamera true
		msgExplode->SetUAT5(50.0f);  /// offset
	}

	GetGameManager()->SendNetworkMessage(*msgExplode.get());
	GetGameManager()->SendMessage(*msgExplode.get());
	
	if ( setCamera )
	{
		osg::Vec3 xyz = pos ;
		xyz.y() = xyz.y()-150 ;
		dtCore::Transform tmpTrans;
		tmpTrans.SetTranslation(xyz);

		SimServerClientComponent* simSC = static_cast<SimServerClientComponent*> (GetGameManager()->GetComponentByName(C_COMP_SERVER_CLIENT_CTRL));
		if ( simSC != NULL )
		{
			simSC->set_player_or_camera_transform(tmpTrans);
		}

	}

	std::cout<<GetName()<<" send status  3D Explode"<<std::endl;

}

void InputComponent::test_player_forward()
{
	/// move forward ;
	int orderID		= TIPE_UTIL_PLAYER_EVENT ;
	int playerID	= 0 ; // observer-0 ( 3DServer )
	int actionType	= IS_PLAYER_MOVE_ON ;
	int actionID 	= MOVE_PLAYER_FORWARD ;
	int setSpeed 	= 3 ;

	dtCore::RefPtr<MsgUtilityAndTools> msgPlayer;
	GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::UTILITY_AND_TOOLS, msgPlayer);

	msgPlayer->SetOrderID(orderID);  
	msgPlayer->SetUAT0(playerID);  
	msgPlayer->SetUAT1(actionType);    
	msgPlayer->SetUAT2(actionID); 
	msgPlayer->SetUAT3(setSpeed); 
	msgPlayer->SetUAT4(0); 
	msgPlayer->SetUAT4(0);
	msgPlayer->SetUAT4(0);

	GetGameManager()->SendNetworkMessage(*msgPlayer.get());
	GetGameManager()->SendMessage(*msgPlayer.get());

	std::cout<<GetName()<<" test_player_message"<<std::endl;

}

void InputComponent::test_player_rotate()
{
	/// move forward ;
	int orderID		= TIPE_UTIL_PLAYER_EVENT ;
	int playerID	= 0 ; // observer-0 ( 3DServer )
	int actionType	= IS_PLAYER_ROTATE_ON ;
	int actionID 	= ROTATE_PLAYER_LEFT ;
	int setSpeed 	= 3 ;

	dtCore::RefPtr<MsgUtilityAndTools> msgPlayer;
	GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::UTILITY_AND_TOOLS, msgPlayer);

	msgPlayer->SetOrderID(orderID);  
	msgPlayer->SetUAT0(playerID);  
	msgPlayer->SetUAT1(actionType);    
	msgPlayer->SetUAT2(actionID); 
	msgPlayer->SetUAT3(setSpeed); 
	msgPlayer->SetUAT4(0); 
	msgPlayer->SetUAT4(0);
	msgPlayer->SetUAT4(0);

	GetGameManager()->SendNetworkMessage(*msgPlayer.get());
	GetGameManager()->SendMessage(*msgPlayer.get());

	std::cout<<GetName()<<" test_player_message"<<std::endl;
}

void InputComponent::test_delete_ship_message(const int VID )
{
	dtCore::RefPtr<MsgActorsControl> msgAC;
	GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::ACTORS_CONTROL, msgAC);

	msgAC->SetOrderID(STATE_AR_DEL);  
	msgAC->SetTipeID(TIPE_AR_SHIP);  
	msgAC->SetVehicleID(VID);    

	GetGameManager()->SendNetworkMessage(*msgAC.get());
	GetGameManager()->SendMessage(*msgAC.get());

	std::cout<<GetName()<<" test_delete_ship_message"<<std::endl;
}

void InputComponent::test_follow_message(const int shipID)
{
	dtCore::RefPtr<MsgUtilityAndTools> msgPlayer;
	GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::UTILITY_AND_TOOLS, msgPlayer);

	msgPlayer->SetOrderID(52); // TIPE_UTIL_PLAYER_EVENT
	msgPlayer->SetUAT0(1); // IS_PLAYER_TYPE_ATTACH
	msgPlayer->SetUAT1(0);  // IS_PLAYER_ACTORTYPE_SHIP
	msgPlayer->SetUAT2(shipID); 

	GetGameManager()->SendNetworkMessage(*msgPlayer.get());
	GetGameManager()->SendMessage(*msgPlayer.get());

	std::cout<<GetName()<<" test_player_message"<<std::endl;
}

void InputComponent::send_player_message(const int orderID, const int set0, const int set1, const int set2, const int set3, const int set4, const double set5, const double set6)
{
	dtCore::RefPtr<MsgUtilityAndTools> msgPlayer;
	GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::UTILITY_AND_TOOLS, msgPlayer);

	msgPlayer->SetOrderID(orderID);  
	msgPlayer->SetUAT0(set0);  
	msgPlayer->SetUAT1(set1);    
	msgPlayer->SetUAT2(set2); 
	msgPlayer->SetUAT3(set3); 
	msgPlayer->SetUAT4(set4); 
	msgPlayer->SetUAT4(set5);
	msgPlayer->SetUAT4(set6);

	GetGameManager()->SendNetworkMessage(*msgPlayer.get());
	GetGameManager()->SendMessage(*msgPlayer.get());

	std::cout<<GetName()<<" Send Message Player Command."<<std::endl;
}

//////////////////////////////////////////////////////////////////////////
void InputComponent::cycle_player_ship_focus()
{
	std::vector<dtDAL::ActorProxy*> gaps;
	GetGameManager()->FindActorsByType(*(GetGameManager()->FindActorType(C_ACTOR_CAT, C_CN_SHIP)), gaps);

	if(gaps.size() > 0 ) 
	{
		mShipFocusIndex++;
		if ( mShipFocusIndex >= gaps.size())  mShipFocusIndex = 0;

		dtCore::RefPtr<dtGame::GameActorProxy> gap= static_cast<dtGame::GameActorProxy*>(gaps[mShipFocusIndex]);
		if ( gap!= NULL ) {

			SimServerClientComponent* simSC = static_cast<SimServerClientComponent*> (GetGameManager()->GetComponentByName(C_COMP_SERVER_CLIENT_CTRL));
			if ( simSC != NULL )
			{
				simSC->SetObserverFocusByUID(gap->GetActor()->GetUniqueId());
			}
		}

	} else
		std::cout<<GetName()<<" can not find any ship.."<<std::endl;
}

void InputComponent::cycle_player_submarine_focus()
{
	std::vector<dtDAL::ActorProxy*> gaps;
	GetGameManager()->FindActorsByType(*(GetGameManager()->FindActorType(C_ACTOR_CAT, C_CN_SUBMARINE)), gaps);
	if(gaps.size() > 0 ) 
	{
		mSubMarineFocusIndex++;
		if(mSubMarineFocusIndex >= gaps.size())  mSubMarineFocusIndex = 0;

		dtCore::Transform t;
		dtCore::RefPtr<dtGame::GameActorProxy> gap= static_cast<dtGame::GameActorProxy*>(gaps[mSubMarineFocusIndex]);
		if ( gap!= NULL ) {
			SimServerClientComponent* simSC = static_cast<SimServerClientComponent*> (GetGameManager()->GetComponentByName(C_COMP_SERVER_CLIENT_CTRL));
			if ( simSC != NULL )
			{
				simSC->SetObserverFocusByUID(gap->GetActor()->GetUniqueId());
			}			
		}
	} else 
		std::cout<<GetName()<<" can not find any submarine.."<<std::endl;
}

void InputComponent::cycle_player_heli_focus()
{
	std::vector<dtDAL::ActorProxy*> gaps;
	GetGameManager()->FindActorsByType(*(GetGameManager()->FindActorType(C_ACTOR_CAT, C_CN_HELICOPTER)), gaps);
	if(gaps.size() > 0 ) 
	{
		mHeliFocusIndex++;
		if(mHeliFocusIndex >= gaps.size())  mHeliFocusIndex = 0;

		dtCore::Transform t;
		dtCore::RefPtr<dtGame::GameActorProxy> gap= static_cast<dtGame::GameActorProxy*>(gaps[mHeliFocusIndex]);
		if ( gap!= NULL ) {
			
			SimServerClientComponent* simSC = static_cast<SimServerClientComponent*> (GetGameManager()->GetComponentByName(C_COMP_SERVER_CLIENT_CTRL));
			if ( simSC != NULL )
			{
				simSC->SetObserverFocusByUID(gap->GetActor()->GetUniqueId());
			}
		}

	} else 
		std::cout<<GetName()<<" can not find any helicopter.."<<std::endl;
}

//////////////////////////////////////////////////////////////////////////
void InputComponent::ProcessMessage(const dtGame::Message& message)
{
	if (enableProcessMessage)
	{
		if (message.GetMessageType() == dtGame::MessageType::TICK_LOCAL){
			dtCore::Keyboard *keyboard = GetGameManager()->GetApplication().GetKeyboard();
			dtCore::RefPtr<dtDAL::GameEvent> mEvent;
		}
	}
}

void InputComponent::test_camera()
{
	osg::ref_ptr<osg::Texture2D> texture = new osg::Texture2D;
	osg::ref_ptr<osg::Image> image = osgDB::readImageFile(
		"../images/NFS.png" );
	texture->setImage( image.get() );

	osg::ref_ptr<osg::Drawable> quad =
		osg::createTexturedQuadGeometry( osg::Vec3(),
		osg::Vec3(10.0f, 0.0f, 0.0f), osg::Vec3(0.0f, 10.0f, 0.0f) );
	quad->getOrCreateStateSet()->setTextureAttributeAndModes(0, texture.get() );
	osg::ref_ptr<osg::Geode> geode = new osg::Geode;
	geode->addDrawable( quad.get() );


	dtABC::Application& app = GetGameManager()->GetApplication();
	dtCore::Camera& camera = *app.GetCamera();

	osg::ref_ptr<osg::Camera> osgcam =  camera.GetOSGCamera() ;
	osgcam->setCullingActive( false );
	osgcam->setClearMask( 0 );
	osgcam->setAllowEventFocus( false );
	osgcam->setReferenceFrame( osg::Transform::ABSOLUTE_RF );
	osgcam->setRenderOrder( osg::Camera::POST_RENDER );
	osgcam->setProjectionMatrix( osg::Matrix::ortho2D(
		0.0, 1.0, 0.0, 1.0) );
	osgcam->addChild( geode.get() );

	osg::StateSet* ss = osgcam->getOrCreateStateSet();
	ss->setMode( GL_LIGHTING, osg::StateAttribute::OFF );
	ss->setAttributeAndModes( new osg::Depth(osg::Depth::LEQUAL, 1.0, 1.0) );

	osg::Group* root = new osg::Group;//static_cast<osg::Group*>(GetOSGNode());
	root->addChild(osgcam.get());
}