#include "playerActorShip.h"
#include "shipmodelactor.h"
#include "../didUtils/utilityfunctions.h"
#include "../didUtils/SimServerClientComponent.h"

#include <dtGame/gameapplication.h>
#include <osg/Geode>
#include <osg/Geometry>
#include <osg/MatrixTransform>
#include <dtCore/deltawin.h>
#include "playerActorShip.h"


using dtCore::RefPtr;
//using namespace didEnviro;
playerActorShip::playerActorShip(dtGame::GameActorProxy& proxy)
: PlayerActor(proxy)
{
	
}
playerActorShip::~playerActorShip()
{

}

void playerActorShip::TickLocal(const dtGame::Message &Message)
{
	//const dtGame::TickMessage &tick = static_cast<const dtGame::TickMessage&>(tickMessage);
	//float deltaSimTime = tick.GetDeltaSimTime();
	//PlayerActor::
}

void playerActorShip::TickRemote(const dtGame::Message &Message)
{

}

void playerActorShip::ProcessOrderEvent(const dtGame::Message &Message)
{
	const MsgUtilityAndTools &Msg = static_cast<const MsgUtilityAndTools&>(message);

	int orderID		= int(Msg.GetOrderID()); 
	int playerID	= int(Msg.GetUAT0()); 
	int set1		= int(Msg.GetUAT1()); 
	int set2		= int(Msg.GetUAT2()); 
	int set3		= int(Msg.GetUAT3()); 
	int set4		= int(Msg.GetUAT4()); 
	int set5		= int(Msg.GetUAT5()); 
	int set6		= int(Msg.GetUAT6()); 

	isFirst = true;  

	if (mPlayerID == playerID)
	{
		if (orderID == TIPE_UTIL_PLAYER_SETTING)
		{
			if (set1 == PLAYER_SET_ATTACH_SHIP)
			{

			}
		}
	}
}

void playerActorShip::ProcessMessage(const dtGame::Message &Message)
{
	if (GetGameActorProxy().IsInGM())
	{
		if (Message.GetMessageType().GetName() == SimMessageType::UTILITY_AND_TOOLS.GetName())
			ProcessOrderEvent(Message);
	}
}

playerActorShipProxy::playerActorShipProxy()
{

}

playerActorShipProxy::~playerActorShipProxy()
{

}
void playerActorShip::OnEnteredWorld()
{
	PlayerActor::OnEnteredWorld();
}

void playerActorShipProxy::OnEnteredWorld()
{

}

void playerActorShipProxy::OnRemovedFromWorld()
{

}

void playerActorShipProxy::BuildInvokables()
{

}

void playerActorShipProxy::BuildPropertyMap()
{

}

