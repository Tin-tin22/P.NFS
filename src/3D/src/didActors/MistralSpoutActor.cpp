#include "MistralSpoutActor.h"
#include "ShipModelActor.h"
#include "MistralBodyActor.h"

#include "didactorssources.h"

////////////////////////////////////////////////////////
MistralSpoutActorProxy::MistralSpoutActorProxy()
{
	SetClassName("Mistral Spout");
}
MistralSpoutActorProxy::~MistralSpoutActorProxy()
{
}

void MistralSpoutActorProxy::BuildInvokables()
{
	LauncherSpoutActorProxy::BuildInvokables();
}

void MistralSpoutActorProxy::BuildPropertyMap()
{
	LauncherSpoutActorProxy::BuildPropertyMap();

}

void MistralSpoutActorProxy::OnEnteredWorld()
{
	LauncherSpoutActorProxy::OnEnteredWorld();
	RegisterForMessages(SimMessageType::MISTRAL_EVENT);
}

////////////////////////////////////////////////////////////
MistralSpoutActor::MistralSpoutActor(dtGame::GameActorProxy &proxy)
:LauncherSpoutActor(proxy),mRate_UD(0),stopMove_UD(true),isFind(false)
{
}

MistralSpoutActor::~MistralSpoutActor()
{
}

void MistralSpoutActor::TickLocal(const dtGame::Message &tickMessage)
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
	SearchingTarget();
}

void MistralSpoutActor::TickRemote(const dtGame::Message &tickMessage)
{
}

void MistralSpoutActor::ProcessMessage(const dtGame::Message &message)
{
	if(GetGameActorProxy().IsInGM()){

		if(message.GetMessageType().GetName() == SimMessageType::MISTRAL_EVENT.GetName())
			ProcessOrderEvent(message);
	}
}

void MistralSpoutActor::ProcessOrderEvent(const dtGame::Message &message)
{
	const MsgSetMistral &Msg = static_cast<const MsgSetMistral&>(message);

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
					Elev = Msg.GetTargetElev();
					stopMove_UD = false;
				}
				break;
			case ORD_MISTRAL_DIRECT_UD : 
				{  
					dtCore::Transform tx ;
					GetTransform(tx,dtCore::Transformable::REL_CS);
					float h,p,r;
					tx.GetRotation(h,p,r);

					//p = GetInitHeading() + Msg.GetTargetBearing();
					p = GetInitPitch() + Msg.GetTargetBearing();

					tx.SetRotation(h,p,r);
					SetTransform(tx,dtCore::Transformable::REL_CS);
				}
				break;
		}
	}
}

void MistralSpoutActor::SetMoveRate_UD(float rate)
{
	mRate_UD = mRate_UD + rate;
	if (mRate_UD >= 90) mRate_UD = 90.0;
	else if (mRate_UD <= 0) mRate_UD =0.0;
}

void MistralSpoutActor::MoveWeapon_UD()
{
	osg::Vec3 xyz = GetGameActorProxy().GetRotation();

	if (xyz.x() < mRate_UD )
	{
		xyz.x() +=   0.1 ;
		if (xyz.x() >= mRate_UD) {xyz.x() = mRate_UD; stopMove_UD = true;}
	}
	else if (xyz.x() > mRate_UD )
	{
		xyz.x() -=   0.1 ;
		if (xyz.x() <= mRate_UD) {xyz.x() = mRate_UD; stopMove_UD = true;}
	}
	xyz.y() = 0;
	GetGameActorProxy().SetRotation(xyz);
}

void MistralSpoutActor::OnEnteredWorld()
{
	missileSound = dtAudio::AudioManager::GetInstance().NewSound();
	missileSound->LoadFile("Sounds/beep.wav");
	assert(missileSound);
	missileSound->SetMaxDistance(1000.0f);
	missileSound->SetLooping(true);
	AddChild(missileSound.get());

	LauncherSpoutActor::OnEnteredWorld();
}

void MistralSpoutActor::OnRemovedFromWorld()
{
	RemoveSender(&(GetGameActorProxy().GetGameManager()->GetScene()));
}

void MistralSpoutActor::SearchingTarget()
{	
	std::vector<dtGame::GameActorProxy*> vActors;
	std::vector<dtGame::GameActorProxy*>::iterator iter;
	dtCore::Transformable* actor;
	dtCore::RefPtr<dtCore::DeltaDrawable> TempTarget;

	GetTransform(missileTransform);
	missileTransform.GetTranslation(missilePosition);
	missileTransform.GetRotation(missileRotation);

	GetGameActorProxy().GetGameManager()->GetAllGameActors(vActors);   

	isFind = false;
	for (iter = vActors.begin(); iter < vActors.end(); iter++)
	{
		if (((*iter)->GetActorType().GetName()== C_CN_HELICOPTER ) || ((*iter)->GetActorType().GetName()== C_CN_AIRCRAFT )) 
		{
			TempTarget = (*iter)->GetActor();
			actor = dynamic_cast<dtCore::Transformable*> ((*iter)->GetActor());
			if (actor){
				actor->GetTransform(objectTransform);
				objectTransform.GetTranslation(objectPosition);
				objectTransform.GetRotation(objectRotation);
				objectTransform.SetTranslation(objectPosition);
				objectTransform.SetRotation(objectRotation);
				actor->SetTransform(objectTransform);

				if(IsInCone(missilePosition, objectPosition, missileRotation.x(), missileRotation.y(), 1852, 446)){		
					isFind = true;
					//std::cout<< GetName() << " find target " << actor->GetName() << std::endl;
				}
			}
		}
	}

	//play or stop sound
	/*if (isFind==true)
		if ( missileSound.valid()) 
			missileSound->Play();
	else
		missileSound->Stop();*/
}