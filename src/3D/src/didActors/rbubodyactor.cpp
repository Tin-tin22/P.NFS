#include "RBUbodyactor.h"
#include "OceanActor.h"
#include "shipactor.h"

#include "didactorssources.h"

////////////////////////////////////////////////////////

RBUBodyActorProxy::RBUBodyActorProxy()
{
	SetClassName("RBU Body");
}
RBUBodyActorProxy::~RBUBodyActorProxy()
{
}

void RBUBodyActorProxy::BuildInvokables()
{
   LauncherBodyActorProxy::BuildInvokables();
}

void RBUBodyActorProxy::BuildPropertyMap()
{
   LauncherBodyActorProxy::BuildPropertyMap();

}

void RBUBodyActorProxy::OnEnteredWorld()
{
	LauncherBodyActorProxy::OnEnteredWorld();
	RegisterForMessages(SimMessageType::RBU_EVENT);
}

void RBUBodyActorProxy::OnRemovedFromWorld()
{
	LauncherBodyActorProxy::OnRemovedFromWorld();
}

////////////////////////////////////////////////////////////
RBUBodyActor::RBUBodyActor(dtGame::GameActorProxy &proxy)
	:LauncherBodyActor(proxy),mRate(0),mRate_LR(0),stopMove_LR(false),stopMove_LR2(false),CorrectBearing(0.0f)
{}

RBUBodyActor::~RBUBodyActor()
{
}

void RBUBodyActor::TickLocal(const dtGame::Message &tickMessage)
{
	const dtGame::TickMessage &tick = static_cast<const dtGame::TickMessage&>(tickMessage);
	osg::Vec3 xyz = GetGameActorProxy().GetRotation();
	float deltaSimTime = tick.GetDeltaSimTime();

	if (ORDER_MANUAL_OR_AUTO == ORD_RBU_ASSIGNED)
	{
		if (!stopMove_LR) {
			MoveWeapon_LR();
		}
	}
	else if (ORDER_MANUAL_OR_AUTO == ORD_RBU_AUTO)
	{
		//if (!stopMove_LR) {
			static dtCore::Transform objectTransform;
			static osg::Vec3 objectPosition;
			static osg::Vec3 objectRotation;
			static dtCore::Transform ownShipTransform;
			static osg::Vec3 ownShipPosition;
			static osg::Vec3 ownShipRotation;

			if ( parentProxy.valid() )
			{

				dtCore::RefPtr<VehicleActor> parent = static_cast<VehicleActor*>(parentProxy->GetActor());
				dtGame::GameActorProxy &pr = parent->GetGameActorProxy();
				parent->GetTransform(objectTransform);
				objectTransform.GetTranslation(objectPosition);
				objectTransform.GetRotation(objectRotation);
			}

			if ( pProxy.valid() )
			{

				dtCore::RefPtr<VehicleActor> parent = static_cast<VehicleActor*>(pProxy->GetActor());
				dtGame::GameActorProxy &pr = parent->GetGameActorProxy();
				parent->GetTransform(ownShipTransform);
				ownShipTransform.GetTranslation(ownShipPosition);
				ownShipTransform.GetRotation(ownShipRotation);
			}

			if (( pProxy.valid() ) && ( parentProxy.valid() )){
				static float nbearing; 
				nbearing = ComputeBearingTo2(ownShipPosition.x(),ownShipPosition.y(),objectPosition.x(),objectPosition.y());
				//std::cout << nbearing << " : " <<ownShipRotation.x() << std::endl;
				nbearing = nbearing + CorrectBearing + ownShipRotation.x();

				mRate			 = -nbearing;

				if (mRate > 180.0f) 
					mRate = mRate - 360.0f;

				if (tempMRate != mRate){
					SetMoveRate(mRate);
					MoveWeapon_LR();
				}
			}
		//}
	}
	if (ORDER_MANUAL_OR_AUTO == ORD_RBU_DEASSIGNED)
	{
		if (stopMove_LR2 == true)
			MoveWeapon_LR();
	}
}


void RBUBodyActor::ProcessMessage(const dtGame::Message &message)
{
	//handle game event
	if(GetGameActorProxy().IsInGM()){

		if(message.GetMessageType().GetName() == SimMessageType::RBU_EVENT.GetName())
			ProcessOrderEvent(message);
	}

}

void RBUBodyActor::ProcessOrderEvent(const dtGame::Message &message)
{
	const MsgSetRBU &Msg = static_cast<const MsgSetRBU&>(message);
	 
	if (((int)Msg.GetVehicleID()	== mVehicleID	) && 
		((int)Msg.GetWeaponID()		== mWeaponID	) && 
		((int)Msg.GetLauncherID()	== mLauncherID	))
	{
		ORDER_MANUAL_OR_AUTO = Msg.GetOrderID();
		switch (Msg.GetOrderID())
		{
		case ORD_RBU_ASSIGNED :  
			{
				CorrectBearing = Msg.GetCorrectBearing();
				TargetBearing  = Msg.GetTargetBearing();
				TargetBearing  = TargetBearing + CorrectBearing ;
				if (TargetBearing > 180.0f) 
					TargetBearing = TargetBearing - 360.0f;
				mRate_LR	   = -TargetBearing;
				stopMove_LR    = false;
				printf("RBU Body Actor assigned OrderEvent\n");
				
			}
			break;

		case ORD_RBU_DEASSIGNED :  
			{
				stopMove_LR = true;
				stopMove_LR2 = true;
				SetMoveRate(0);
			}
			break;

		case ORD_RBU_FIRE :  
			{
				dtCore::RefPtr<dtCore::ParticleSystem> mExplosion= new dtCore::ParticleSystem();
				mExplosion->LoadFile(C_PARTICLES_ASAP,true);
				GetGameActorProxy().GetActor()->AddChild(mExplosion.get());
				mExplosion->SetEnabled(true);
				std::cout<<GetName()<<"  Explode Effef Launcher "<<std::endl;
			}
			break;

		case ORD_RBU_AUTO :
			{
				stopMove_LR     = false;

				CorrectBearing  = Msg.GetCorrectBearing();
				TargetID		= Msg.GetTargetID();
				OwnShipId		= Msg.GetVehicleID();

				static dtCore::Transform objectTransform;
				static osg::Vec3 objectPosition;
				static osg::Vec3 objectRotation;
				static dtCore::Transform ownShipTransform;
				static osg::Vec3 ownShipPosition;
				static osg::Vec3 ownShipRotation;

				parentProxy = GetShipActorByID(TargetID);
				if ( parentProxy.valid() )
				{
					dtCore::RefPtr<VehicleActor> parent = static_cast<VehicleActor*>(parentProxy->GetActor());
					dtGame::GameActorProxy &pr = parent->GetGameActorProxy();
					parent->GetTransform(objectTransform);
					objectTransform.GetTranslation(objectPosition);
					objectTransform.GetRotation(objectRotation);
				}

				pProxy = GetShipActorByID(OwnShipId);
				if ( pProxy.valid() )
				{

					dtCore::RefPtr<VehicleActor> parent = static_cast<VehicleActor*>(pProxy->GetActor());
					dtGame::GameActorProxy &pr = parent->GetGameActorProxy();
					parent->GetTransform(ownShipTransform);
					ownShipTransform.GetTranslation(ownShipPosition);
					ownShipTransform.GetRotation(ownShipRotation);
				}

				if (( pProxy.valid() ) && ( parentProxy.valid() )){
					static float nbearing;
					nbearing = ComputeBearingTo2(ownShipPosition.x(),ownShipPosition.y(),objectPosition.x(),objectPosition.y());
					nbearing = nbearing + CorrectBearing + ownShipRotation.x();
					//nbearing = ValidateDegree(nbearing);				

					mRate			 = -nbearing;

					if (mRate > 180.0f) 
						mRate = mRate - 360.0f;
				}				
			}
			break;
		}
	}
}

void RBUBodyActor::SetMoveRate(float rate)
{
	mRate_LR = rate;
	if (mRate_LR >= 170) mRate_LR = 170;
	else if (mRate_LR <= -170) mRate_LR =-170.0;
}

void RBUBodyActor::MoveWeapon_LR()
{
	if (ORDER_MANUAL_OR_AUTO == ORD_RBU_ASSIGNED || ORD_RBU_DEASSIGNED)
	{
		osg::Vec3 xyz = GetGameActorProxy().GetRotation();

		//std::cout << xyz.z() << "," << mRate_LR << std::endl;

		if (xyz.z() > mRate_LR ){
			xyz[2] -= 360.0f * 0.01 ;
			if (xyz[2] <= mRate_LR) {
				stopMove_LR = true;
				stopMove_LR2 = false;
				xyz[2] = mRate_LR;
			}
		}
		else if (xyz.z() < mRate_LR){
			xyz[2] += 360.0f * 0.01 ;
			if (xyz[2] >= mRate_LR) {
				stopMove_LR = true;
				stopMove_LR2 = false;
				xyz[2] = mRate_LR;
			}
		}
		else if (xyz.z() == mRate_LR){
			stopMove_LR2 = false;
		}

		GetGameActorProxy().SetRotation(xyz);
	} 
	else
	{
		/************************FUNGSI TRACK********************************/

		static dtCore::Transform BodyTransform;
		static osg::Vec3 BodyPosition, BodyRotation;

		GetTransform(BodyTransform);
		BodyTransform.GetTranslation(BodyPosition);
		BodyTransform.GetRotation(BodyRotation);

		if (BodyRotation[0] < mRate )
		{
			BodyRotation[0] +=   1 ;
			if (BodyRotation[0] >= mRate) {
				stopMove_LR = true;
				BodyRotation[0] = mRate;
				tempMRate = mRate;
			}
		}
		else if (BodyRotation.z() > mRate )
		{
			BodyRotation[0] -=   1 ;
			if (BodyRotation[0] <= mRate) {
				stopMove_LR = true;
				BodyRotation[0] = mRate;
				tempMRate = mRate;
			}
		}

		//std::cout<< "bdx " << BodyRotation[0] << std::endl;

		/*if ( abs(BodyRotation[0]-mRate) > 180 )
		{
			BodyRotation[0] +=   1 ;
			if (BodyRotation[0] >= mRate) {
				stopMove_LR = true;
				BodyRotation[0] = mRate;
				tempMRate = mRate;
			}
		}
		else
		{
			BodyRotation[0] -=   1 ;
			if (BodyRotation[0] <= mRate) {
				stopMove_LR = true;
				BodyRotation[0] = mRate;
				tempMRate = mRate;
			}
		}*/

		BodyTransform.SetTranslation(BodyPosition);
		BodyTransform.SetRotation(BodyRotation);
		SetTransform(BodyTransform);

		/*******************************************************************/
	}

}

void RBUBodyActor::OnEnteredWorld()
{
	LauncherBodyActor::OnEnteredWorld();
}

void RBUBodyActor::OnRemovedFromWorld()
{
	LauncherBodyActor::OnRemovedFromWorld();
    RemoveSender(&(GetGameActorProxy().GetGameManager()->GetScene()));
}
