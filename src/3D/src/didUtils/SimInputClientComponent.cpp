 #include "SimInputClientComponent.h"
#include "../didCommon/BaseConstant.h"
#include "../didCommon/SimMessages.h"
#include "../didCommon/SimMessageType.h"
#include "../didNetwork/SimTCPDataTypes.h"
#include "../didSimUnit/didJoystickComponent.h"
#include "../didUtils/SimEffectControl.h"
#include "../didUtils/SimServerClientComponent.h"
#include "../didUtils/utilityfunctions.h"

#include <vector>

#include <dtTerrain/terrain.h>
#include <dtGame/basemessages.h>
#include <dtGame/messagetype.h>
#include <dtGame/gameactor.h>
#include <dtDAL/enginepropertytypes.h>
#include <dtABC/application.h>

#include <dtCore/isector.h>
#include <dtActors/gamemeshactor.h>
#include <dtCore/camera.h>
#include <dtCore/refptr.h>

#define _WINSOCKAPI_
#ifndef WIN32_LEAN_AND_MEAN
#define WIN32_LEAN_AND_MEAN
#endif
#include <dtUtil/mswin.h>
#pragma comment(lib, "ws2_32.lib")

////////////////////////////////////////////////////////////////////
InputComponent::InputComponent(const std::string &name, bool inPlaybackMode) :
   dtGame::BaseInputComponent(name) 
{
	mShipFocusIndex		= -1;
	mSubMarineFocusIndex	= -1 ;
	mMiscFocusIndex		= -1;
	mHeliFocusIndex		= -1 ;
}

////////////////////////////////////////////////////////////////////
bool InputComponent::HandleKeyReleased(const dtCore::Keyboard* keyboard, int key ) 
{
	bool handled = true;
 	dtCore::RefPtr<dtDAL::GameEvent> mEvent;
	 
	handled = false;

	if (!handled)
		return BaseInputComponent::HandleKeyReleased(keyboard, key );

    return handled;
}


bool InputComponent::HandleKeyPressed(const dtCore::Keyboard* keyboard, int key )
{
	bool handled = true;
	//////////////////////////////////// test input, !! disable ketika di release  //////////////////////////////////////
	if (key== '1')
	{
		 
		handled= true; 
	} 
	else
	//////////////////////////////////// test input, !! disable ketika di release  //////////////////////////////////////

	////////////////////////////////// used input client ////////////////////////////////////////
	if (key== 'x')
	{
		cycle_player_ship_focus();
		handled= true; 
	}
	else if (key== 'z')
	{
		cycle_player_submarine_focus();

		handled= true;
	}
	else if (key== 'c')
	{
		cycle_player_heli_focus();
		handled= true; 
	}
	else if (key== 'k')
	{
		SimServerClientComponent* simSC = static_cast<SimServerClientComponent*> (GetGameManager()->GetComponentByName(C_COMP_SERVER_CLIENT_CTRL));
		if ( simSC != NULL )
		{
			int PlayerID = simSC->GetPlayerMachineID();
			send_player_message(TIPE_UTIL_PLAYER_SETTING,PlayerID,PLAYER_SET_BASE,SET_BASE_KEYBOARD,0,0,0,0);
		} 
		handled= true; 
	}
	else if (key== 'K')
	{
		SimServerClientComponent* simSC = static_cast<SimServerClientComponent*> (GetGameManager()->GetComponentByName(C_COMP_SERVER_CLIENT_CTRL));
		if ( simSC != NULL )
		{
			int PlayerID = simSC->GetPlayerMachineID();
			send_player_message(TIPE_UTIL_PLAYER_SETTING,PlayerID,PLAYER_SET_BASE,SET_BASE_KEYBOARD,SET_BASE_KEY_ON,0,0,0);
		} 
		handled= true; 
	}
	else if (key=='m')
	{
		dtCore::RefPtr<MsgSetMistral> msg;
		GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::MISTRAL_EVENT, msg);
		msg->SetVehicleID(1);
		msg->SetWeaponID(8);
		msg->SetLauncherID(1); 
		msg->SetMissileID(1);
		msg->SetMissileNum(1);
		msg->SetOrderID(ORD_MISTRAL_STATUS_UNLOCK);
		GetGameManager()->SendNetworkMessage(*msg.get());
		GetGameManager()->SendMessage(*msg.get());
	}
	else if (key=='n')
	{
		dtCore::RefPtr<MsgSetMistral> msg;
		GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::MISTRAL_EVENT, msg);
		msg->SetVehicleID(1);
		msg->SetWeaponID(8);
		msg->SetLauncherID(1); 
		msg->SetMissileID(1);
		msg->SetMissileNum(1);
		msg->SetOrderID(ORD_MISTRAL_STATUS_LOCK);
		GetGameManager()->SendNetworkMessage(*msg.get());
		GetGameManager()->SendMessage(*msg.get());
	}
	/////////////////////////////////////// used input client ///////////////////////////////////
	else
		return BaseInputComponent::HandleKeyPressed(keyboard, key);
	return handled;
}

//////////////////////////////////////////////////////////////////////////
void InputComponent::test_explode(  const int ExplodeID, const int ExplodeType, const float ExplodeLife, const osg::Vec3 pos, const bool setCamera  )
{
	SimEffectControl* simEffect = static_cast<SimEffectControl*> (GetGameManager()->GetComponentByName("SimEffectControl"));
	if ( simEffect != NULL )
	{
		simEffect->AddEffectAndExplode(ExplodeID,0,ExplodeType, 0 ,ExplodeLife,pos);

		if ( setCamera )
		{
			osg::Vec3 xyz = pos ;
			xyz.y() = xyz.y()-50 ;
			dtCore::Transform tmpTrans;
			tmpTrans.SetTranslation(xyz);
			GetGameManager()->GetApplication().GetCamera()->SetTransform(tmpTrans,dtCore::Transformable::ABS_CS);
		}

		std::cout<<GetName()<<"--Explode Effect at : "<<pos<<std::endl;
	}
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
void InputComponent::ProcessMessage(const dtGame::Message& message)
{
	if (message.GetMessageType() == dtGame::MessageType::TICK_LOCAL){
		dtCore::Keyboard *keyboard = GetGameManager()->GetApplication().GetKeyboard();
		dtCore::RefPtr<dtDAL::GameEvent> mEvent;
	}
}

