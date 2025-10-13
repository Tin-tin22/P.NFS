#include "TetralSpoutActor.h"
#include "ShipModelActor.h"
#include "TetralBodyActor.h"
#include "didactorssources.h"

////////////////////////////////////////////////////////
TetralSpoutActorProxy::TetralSpoutActorProxy()
{
	SetClassName("Tetral Spout");
}
TetralSpoutActorProxy::~TetralSpoutActorProxy(){}

void TetralSpoutActorProxy::BuildInvokables()
{
	LauncherSpoutActorProxy::BuildInvokables();
}

void TetralSpoutActorProxy::BuildPropertyMap()
{
	LauncherSpoutActorProxy::BuildPropertyMap();
}

void TetralSpoutActorProxy::OnEnteredWorld()
{
	LauncherSpoutActorProxy::OnEnteredWorld();
	RegisterForMessages(SimMessageType::TETRAL_EVENT);
}

////////////////////////////////////////////////////////////
TetralSpoutActor::TetralSpoutActor(dtGame::GameActorProxy &proxy)
:LauncherSpoutActor(proxy),mRate_UD(0),stopMove_UD(true)
{}

TetralSpoutActor::~TetralSpoutActor(){}

void TetralSpoutActor::TickLocal(const dtGame::Message &tickMessage)
{
	const dtGame::TickMessage &tick = static_cast<const dtGame::TickMessage&>(tickMessage);
	osg::Vec3 xyz = GetGameActorProxy().GetRotation();
	float deltaSimTime = tick.GetDeltaSimTime();
	float temp;

	if (!stopMove_UD)
	{
		if ((Elev<=90)) temp = (Elev-xyz.x());
		SetMoveRate_UD(temp);
		MoveWeapon_UD();
	}
}

void TetralSpoutActor::TickRemote(const dtGame::Message &tickMessage){}

void TetralSpoutActor::ProcessMessage(const dtGame::Message &message)
{
	if(GetGameActorProxy().IsInGM()){

		if(message.GetMessageType().GetName() == SimMessageType::TETRAL_EVENT.GetName())
			ProcessOrderEvent(message);
	}
}

void TetralSpoutActor::ProcessOrderEvent(const dtGame::Message &message)
{
	const MsgSetTetral &Msg = static_cast<const MsgSetTetral&>(message);
	 
	if (((int)Msg.GetVehicleID()	== mVehicleID	) && 
		((int)Msg.GetWeaponID()		== mWeaponID	) && 
		((int)Msg.GetLauncherID()	== mLauncherID	))

		switch (Msg.GetOrderID())
		{
			case ORD_TETRAL_ASSIGNED :  
				{
					Elev = Msg.GetTargetElev();
					stopMove_UD = false;
				}
				break;
			case ORD_TETRAL_DIRECT_UD : 
				{  
					dtCore::Transform tx ;
					GetTransform(tx,dtCore::Transformable::REL_CS);
					float h,p,r;
					tx.GetRotation(h,p,r);
					
					p = GetInitHeading() + Msg.GetTargetBearing();
					
					tx.SetRotation(h,p,r);
					SetTransform(tx,dtCore::Transformable::REL_CS);
				}
				break;
		}
}

void TetralSpoutActor::SetMoveRate_UD(float rate)
{
	mRate_UD = mRate_UD + rate;
	if (mRate_UD >= 90) mRate_UD = 90.0;
	else if (mRate_UD <= 0) mRate_UD =0.0;
}

void TetralSpoutActor::MoveWeapon_UD()
{
	osg::Vec3 xyz = GetGameActorProxy().GetRotation();

	if (xyz.x() < mRate_UD )
	{
		xyz.x() +=   1 ;
		if (xyz.x() >= mRate_UD) {stopMove_UD = true;}
	}
	else if (xyz.x() > mRate_UD )
	{
		xyz.x() -=   1 ;
		if (xyz.x() <= mRate_UD) {stopMove_UD = true;}
	}
	xyz.y() = 0;
	GetGameActorProxy().SetRotation(xyz);
} 

void TetralSpoutActor::OnEnteredWorld()
{
	LauncherSpoutActor::OnEnteredWorld();
}

void TetralSpoutActor::OnRemovedFromWorld()
{
	RemoveSender(&(GetGameActorProxy().GetGameManager()->GetScene()));
}