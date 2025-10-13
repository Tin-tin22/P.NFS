#include "StrelaBodyActor.h"
#include "OceanActor.h"
#include "ShipModelActor.h"

#include "didactorssources.h"

////////////////////////////////////////////////////////

StrelaBodyActorProxy::StrelaBodyActorProxy()
{
	SetClassName("Strela Body");
}
StrelaBodyActorProxy::~StrelaBodyActorProxy()
{
}

void StrelaBodyActorProxy::BuildInvokables()
{
	LauncherBodyActorProxy::BuildInvokables();
}

void StrelaBodyActorProxy::BuildPropertyMap()
{
	LauncherBodyActorProxy::BuildPropertyMap();
}

void StrelaBodyActorProxy::OnEnteredWorld()
{
	LauncherBodyActorProxy::OnEnteredWorld();
	RegisterForMessages(SimMessageType::STRELA_EVENT);
}


////////////////////////////////////////////////////////////
StrelaBodyActor::StrelaBodyActor(dtGame::GameActorProxy &proxy)
:LauncherBodyActor(proxy),mRate_LR(0),stopMove(true),Assigned(false),stopMove_LR(false)
{
	mWeaponOn = true;
}

StrelaBodyActor::~StrelaBodyActor()
{
}

void StrelaBodyActor::TickLocal(const dtGame::Message &tickMessage)
{
	const dtGame::TickMessage &tick = static_cast<const dtGame::TickMessage&>(tickMessage);
	osg::Vec3 xyz = GetGameActorProxy().GetRotation();
	float deltaSimTime = tick.GetDeltaSimTime();

	if (Assigned)
		if (!stopMove_LR)
			MoveWeapon_LR();
}



void StrelaBodyActor::ProcessMessage(const dtGame::Message &message)
{
	//handle game event
	if(GetGameActorProxy().IsInGM()){

		if(message.GetMessageType().GetName() == SimMessageType::STRELA_EVENT.GetName())
			ProcessOrderEvent(message);
	}
}

void StrelaBodyActor::ProcessOrderEvent(const dtGame::Message &message)
{
	const MsgSetStrela &Msg = static_cast<const MsgSetStrela&>(message);

	dtCore::RefPtr<dtDAL::ActorProxy> parentProxy = GetShipActorByID(Msg.GetVehicleID());
	if ( parentProxy.valid() )
	{
		dtCore::RefPtr<VehicleActor> parent = static_cast<VehicleActor*>(parentProxy->GetActor());
		if (((int)Msg.GetVehicleID()	== mVehicleID	) && 
			((int)Msg.GetWeaponID()		== mWeaponID	) && 
			((int)Msg.GetLauncherID()	== mLauncherID	))
		{
			switch (Msg.GetOrderID())
			{
				case ORD_STRELA_ASSIGNED :  
					{			
						TargetBearing = Msg.GetTargetBearing();
						if (TargetBearing > 180.0f) TargetBearing = TargetBearing - 360.0f;
						mRate_LR=-TargetBearing;
						printf("Strela Body Actor assigned OrderEvent\n");
						Assigned = true;
						stopMove_LR = false;
					}
					break;

				case ORD_STRELA_DEASSIGNED :  
					{
						Assigned = false;
						stopMove_LR = true;
					}
					break;

				case ORD_STRELA :  
					{
						dtCore::RefPtr<dtCore::ParticleSystem> mExplosion= new dtCore::ParticleSystem();
						mExplosion->LoadFile(C_PARTICLES_ASAP,true);
						GetGameActorProxy().GetActor()->AddChild(mExplosion.get());
						mExplosion->SetEnabled(true);
						std::cout<<GetName()<<"  Explode Effef Launcher "<<std::endl;
					}
					break;
				case ORD_STRELA_DIRECT_LR : 
					{	
						dtCore::Transform tx ;
						GetTransform(tx,dtCore::Transformable::REL_CS);
						float h,p,r;
						tx.GetRotation(h,p,r);
						h = GetInitHeading() + Msg.GetTargetBearing();
						tx.SetRotation(h,p,r);
						SetTransform(tx,dtCore::Transformable::REL_CS);
					}
					break;
			}
		}	
	}
}

void StrelaBodyActor::MoveWeapon_LR()
{
	osg::Vec3 xyz = GetGameActorProxy().GetRotation();

	if (xyz.z() > mRate_LR ){
		xyz[2] -= 360.0f * 0.01 ;
		if (xyz[2]<=mRate_LR)
		{
			xyz[2] = mRate_LR;
			stopMove_LR = true;
		}
	}
	else if (xyz.z() < mRate_LR){
		xyz[2] += 360.0f * 0.01 ;
		if (xyz[2]>=mRate_LR)
		{
			xyz[2] = mRate_LR;
			stopMove_LR = true;
		}
	}

	GetGameActorProxy().SetRotation(xyz);
}

void StrelaBodyActor::OnEnteredWorld()
{
	LauncherBodyActor::OnEnteredWorld();
}

void StrelaBodyActor::OnRemovedFromWorld()
{
	RemoveSender(&(GetGameActorProxy().GetGameManager()->GetScene()));
}