#include "TetralBodyActor.h"
#include "OceanActor.h"
#include "ShipModelActor.h"

#include "didactorssources.h"

////////////////////////////////////////////////////////

TetralBodyActorProxy::TetralBodyActorProxy()
{
	SetClassName("Tetral Body");
}
TetralBodyActorProxy::~TetralBodyActorProxy()
{
}

void TetralBodyActorProxy::BuildInvokables()
{
	LauncherBodyActorProxy::BuildInvokables();
}

void TetralBodyActorProxy::BuildPropertyMap()
{
	LauncherBodyActorProxy::BuildPropertyMap();
}

void TetralBodyActorProxy::OnEnteredWorld()
{
	LauncherBodyActorProxy::OnEnteredWorld();
	RegisterForMessages(SimMessageType::TETRAL_EVENT);
}


////////////////////////////////////////////////////////////
TetralBodyActor::TetralBodyActor(dtGame::GameActorProxy &proxy)
:LauncherBodyActor(proxy),mRate_LR(0),stopMove(true),Assigned(false)
{
	mWeaponOn = true;
}

TetralBodyActor::~TetralBodyActor()
{
}

void TetralBodyActor::TickLocal(const dtGame::Message &tickMessage)
{
	const dtGame::TickMessage &tick = static_cast<const dtGame::TickMessage&>(tickMessage);
	osg::Vec3 xyz = GetGameActorProxy().GetRotation();
	float deltaSimTime = tick.GetDeltaSimTime();

	if (Assigned)
		if (!stopMove_LR) 
			MoveWeapon_LR();
}

void TetralBodyActor::ProcessMessage(const dtGame::Message &message)
{
	//handle game event
	if(GetGameActorProxy().IsInGM()){

		if(message.GetMessageType().GetName() == SimMessageType::TETRAL_EVENT.GetName())
			ProcessOrderEvent(message);
	}
}

void TetralBodyActor::ProcessOrderEvent(const dtGame::Message &message)
{
	const MsgSetTetral &Msg = static_cast<const MsgSetTetral&>(message);
	 
	if (((int)Msg.GetVehicleID()	== mVehicleID	) && 
		((int)Msg.GetWeaponID()		== mWeaponID	) && 
		((int)Msg.GetLauncherID()	== mLauncherID	))

	switch (Msg.GetOrderID())
	{
		case ORD_TETRAL_ASSIGNED :  
			{
				TargetBearing = Msg.GetTargetBearing();
				if (TargetBearing > 180.0f) TargetBearing = TargetBearing - 360.0f;
				mRate_LR=-TargetBearing;
				printf("Tetral Body Actor assigned OrderEvent\n");
				Assigned = true;
				stopMove_LR = false;
			}
			break;

		case ORD_TETRAL_DEASSIGNED :  
			{
				Assigned = false; 
				stopMove_LR = true;
			}
			break;

		case ORD_TETRAL :  
			{
				dtCore::RefPtr<dtCore::ParticleSystem> mExplosion= new dtCore::ParticleSystem();
				mExplosion->LoadFile(C_PARTICLES_ASAP,true);
				GetGameActorProxy().GetActor()->AddChild(mExplosion.get());
				mExplosion->SetEnabled(true);
				std::cout<<GetName()<<"  Explode Effef Launcher "<<std::endl;
			}
			break;
		case ORD_TETRAL_DIRECT_LR : 
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
void TetralBodyActor::MoveWeapon_LR()
{
	osg::Vec3 xyz = GetGameActorProxy().GetRotation();

	if (xyz.z() > mRate_LR ){
		xyz[2] -= 360.0f * 0.1 ;
		if (xyz[2]<=mRate_LR)
		{
			xyz[2] = mRate_LR;
			stopMove_LR = true;
		}
	}
	else if (xyz.z() < mRate_LR){
		xyz[2] += 360.0f * 0.1 ;
		if (xyz[2]>=mRate_LR)
		{
			xyz[2] = mRate_LR;
			stopMove_LR = true;
		}
	}

	GetGameActorProxy().SetRotation(xyz);
}

void TetralBodyActor::OnEnteredWorld()
{
	LauncherBodyActor::OnEnteredWorld();
}

void TetralBodyActor::OnRemovedFromWorld()
{
	RemoveSender(&(GetGameActorProxy().GetGameManager()->GetScene()));
}
 
