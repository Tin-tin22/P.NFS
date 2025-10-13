#include "MistralBodyActor.h"
#include "OceanActor.h"
#include "ShipModelActor.h"

#include "didactorssources.h"

////////////////////////////////////////////////////////

MistralBodyActorProxy::MistralBodyActorProxy()
{
	SetClassName("Mistral Body");
}
MistralBodyActorProxy::~MistralBodyActorProxy()
{
}

void MistralBodyActorProxy::BuildInvokables()
{
	LauncherBodyActorProxy::BuildInvokables();
}

void MistralBodyActorProxy::BuildPropertyMap()
{
	LauncherBodyActorProxy::BuildPropertyMap();
}

void MistralBodyActorProxy::OnEnteredWorld()
{
	LauncherBodyActorProxy::OnEnteredWorld();
	RegisterForMessages(SimMessageType::MISTRAL_EVENT);
}


////////////////////////////////////////////////////////////
MistralBodyActor::MistralBodyActor(dtGame::GameActorProxy &proxy)
:LauncherBodyActor(proxy),mRate_LR(0),stopMove(true),Assigned(false),stopMove_LR(false)
{
	mWeaponOn = true;
}

MistralBodyActor::~MistralBodyActor()
{
}

void MistralBodyActor::TickLocal(const dtGame::Message &tickMessage)
{
	const dtGame::TickMessage &tick = static_cast<const dtGame::TickMessage&>(tickMessage);
	osg::Vec3 xyz = GetGameActorProxy().GetRotation();
	float deltaSimTime = tick.GetDeltaSimTime();

	if (Assigned)
		if (!stopMove_LR) 
			MoveWeapon_LR();
}

void MistralBodyActor::ProcessMessage(const dtGame::Message &message)
{
	//handle game event
	if(GetGameActorProxy().IsInGM()){
		if(message.GetMessageType().GetName() == SimMessageType::MISTRAL_EVENT.GetName())
			ProcessOrderEvent(message);
	}
}

void MistralBodyActor::ProcessOrderEvent(const dtGame::Message &message)
{
	const MsgSetMistral &Msg = static_cast<const MsgSetMistral&>(message);
	//mLauncherID = Msg.GetLauncherID();
	dtCore::RefPtr<dtDAL::ActorProxy> parentProxy = GetShipActorByID(Msg.GetVehicleID());
	if ( parentProxy.valid() )
	{
		dtCore::RefPtr<VehicleActor> parent = static_cast<VehicleActor*>(parentProxy->GetActor());
		if (((int)Msg.GetVehicleID()	== mVehicleID	) && 
			((int)Msg.GetWeaponID()		== mWeaponID	) && 
			((int)Msg.GetLauncherID()	== mLauncherID	))

		switch (Msg.GetOrderID())
		{
			case ORD_MISTRAL_ASSIGNED :  
				{			
					TargetBearing = Msg.GetTargetBearing();
					if (TargetBearing > 180.0f) TargetBearing = TargetBearing - 360.0f;
					mRate_LR=-TargetBearing;
					printf("Mistral Body Actor assigned OrderEvent\n");
					Assigned = true;
					stopMove_LR = false;
				}
				break;

			case ORD_MISTRAL_DEASSIGNED :  
				{
					Assigned = false;
					stopMove_LR = true;
				}
				break;

			case ORD_MISTRAL :  
				{
					dtCore::RefPtr<dtCore::ParticleSystem> mExplosion= new dtCore::ParticleSystem();
					mExplosion->LoadFile(C_PARTICLES_ASAP,true);
					GetGameActorProxy().GetActor()->AddChild(mExplosion.get());
					mExplosion->SetEnabled(true);
					std::cout<<GetName()<<"  Explode Effef Launcher "<<std::endl;
				}
				break;
				//// below prepare for direct event, ex : joystick, modify when joystick already fix.
			case ORD_MISTRAL_DIRECT_LR : 
				{	
					//std::cout<<"MISTRAL BODY ACOTR MASUK"<<std::endl;
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

void MistralBodyActor::MoveWeapon_LR()//float deltaSimTime
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

void MistralBodyActor::OnEnteredWorld()
{
	LauncherBodyActor::OnEnteredWorld();
}

void MistralBodyActor::OnRemovedFromWorld()
{
	RemoveSender(&(GetGameActorProxy().GetGameManager()->GetScene()));
}