#include "shipactor.h"
#include "oceanconfigactor.h"
#include "oceanactor.h"
#include "didactorssources.h"

/////////////////////////////////////////////////
ShipActorProxy::ShipActorProxy(){}
ShipActorProxy::~ShipActorProxy(){}

void ShipActorProxy::BuildPropertyMap()
{
	VehicleActorProxy::BuildPropertyMap();

	ShipActor* kri = NULL ;

	GetActor(kri);
}

void ShipActorProxy::BuildInvokables()
{
	VehicleActorProxy::BuildInvokables();
}

/////////////////////////////////////////////////
IMPLEMENT_ENUM(ShipActor::ThrottlePosition);
ShipActor::ThrottlePosition ShipActor::ThrottlePosition::BACK_EMERGENCY("BACK_EMERGENCY", 0);
ShipActor::ThrottlePosition ShipActor::ThrottlePosition::BACK_FULL("BACK_FULL", 1);
ShipActor::ThrottlePosition ShipActor::ThrottlePosition::BACK_TWO_THIRDS("BACK_TWO_THIRDS", 2);
ShipActor::ThrottlePosition ShipActor::ThrottlePosition::BACK_ONE_THIRD("BACK_ONE_THIRD", 3);
ShipActor::ThrottlePosition ShipActor::ThrottlePosition::STOP("STOP", 4);
ShipActor::ThrottlePosition ShipActor::ThrottlePosition::AHEAD_ONE_THIRD("AHEAD_ONE_THIRD", 5);
ShipActor::ThrottlePosition ShipActor::ThrottlePosition::AHEAD_TWO_THIRDS("AHEAD_TWO_THIRDS", 6);
ShipActor::ThrottlePosition ShipActor::ThrottlePosition::AHEAD_STANDARD("AHEAD_STANDARD", 7);
ShipActor::ThrottlePosition ShipActor::ThrottlePosition::AHEAD_FULL("AHEAD_FULL",  8);
ShipActor::ThrottlePosition ShipActor::ThrottlePosition::AHEAD_FLANK("AHEAD_FLANK", 9);

IMPLEMENT_ENUM(ShipActor::LampTypes);
ShipActor::LampTypes ShipActor::LampTypes::ANCHOR_LIGHT("ANCHOR_LIGHT",0); 
ShipActor::LampTypes ShipActor::LampTypes::STERN_LIGHT("STERN_LIGHT",1); 
ShipActor::LampTypes ShipActor::LampTypes::MASTHEAD_LIGHT("MASTHEAD_LIGHT",2); 
ShipActor::LampTypes ShipActor::LampTypes::MASTHEAD_LIGHT2("MASTHEAD_LIGHT2",3); 
ShipActor::LampTypes ShipActor::LampTypes::PORT_LIGHT("PORT_LIGHT",4); 		
ShipActor::LampTypes ShipActor::LampTypes::STARBOARD_LIGHT("STARBOARD_LIGHT",5); 
ShipActor::LampTypes ShipActor::LampTypes::SPECIAL_LIGHT_TOP("SPECIAL_LIGHT_TOP",6); 	
ShipActor::LampTypes ShipActor::LampTypes::SPECIAL_LIGHT_MIDDLE("SPECIAL_LIGHT_MIDDLE",7); 	
ShipActor::LampTypes ShipActor::LampTypes::SPECIAL_LIGHT_BOTTOM("SPECIAL_LIGHT_BOTTOM",8); 		
ShipActor::LampTypes ShipActor::LampTypes::OPS_DANGER_LIGHT_PAIR("OPS_DANGER_LIGHT_PAIR",9); 
ShipActor::LampTypes ShipActor::LampTypes::SPECIAL_CBD_MODE("SPECIAL_CBD_MODE",10); 	
ShipActor::LampTypes ShipActor::LampTypes::SPECIAL_RAM_MODE("SPECIAL_RAM_MODE",11); 	
ShipActor::LampTypes ShipActor::LampTypes::SPECIAL_NUC_MODE("SPECIAL_NUC_MODE",12); 

ShipActor::ShipActor(dtGame::GameActorProxy &proxy) :
	VehicleActor(proxy), 
	shaftEngaged(true),
	mIsCameraAttached(false)
{}

ShipActor::~ShipActor(){}

bool ShipActor::CheckWake(dtCore::ParticleSystem* wake)
{
	if(wake != NULL)
	{
		if(wake->IsEnabled())
		{
			if(!mEngineRunning || !shaftEngaged)
				wake->SetEnabled(false);
		}
		else
		{
			if(mEngineRunning && shaftEngaged)
				wake->SetEnabled(true);
		}

		return wake->IsEnabled();
	}
	else
		return false;
}