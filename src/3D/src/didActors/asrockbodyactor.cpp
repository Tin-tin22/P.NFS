#include "asrockbodyactor.h"
#include "didactorssources.h"
#include "shipactor.h"

////////////////////////////////////////////////////////

AsrockBodyActorProxy::AsrockBodyActorProxy()
{
	SetClassName("Asrock Body");
}
AsrockBodyActorProxy::~AsrockBodyActorProxy()
{
}

void AsrockBodyActorProxy::BuildInvokables()
{
    LauncherBodyActorProxy::BuildInvokables();
}

void AsrockBodyActorProxy::BuildPropertyMap()
{
	LauncherBodyActorProxy::BuildPropertyMap();
}

void AsrockBodyActorProxy::OnEnteredWorld()
{
	LauncherBodyActorProxy::OnEnteredWorld();
	RegisterForMessages(SimMessageType::ASROCK_EVENT);
}


////////////////////////////////////////////////////////////
AsrockBodyActor::AsrockBodyActor(dtGame::GameActorProxy &proxy)
	:LauncherBodyActor(proxy),mRate_LR(0),mRate(0),Elev(0),stopMove(true),stopMove2(true),isTrack(false)
{}

AsrockBodyActor::~AsrockBodyActor()
{
}

void AsrockBodyActor:: TickLocal(const dtGame::Message &tickMessage)
{
	const dtGame::TickMessage &tick = static_cast<const dtGame::TickMessage&>(tickMessage);
	osg::Vec3 xyz = GetGameActorProxy().GetRotation();
	float deltaSimTime = tick.GetDeltaSimTime();

	if (!stopMove_LR) {
		static dtCore::Transform objectTransform;
		static osg::Vec3 objectPosition;
		static osg::Vec3 objectRotation;
		static dtCore::Transform ownShipTransform;
		static osg::Vec3 ownShipPosition;
		static osg::Vec3 ownShipRotation;

		if ( (parentProxy.valid()) &&  ( pProxy.valid() ))
		{

			dtCore::RefPtr<VehicleActor> parent = static_cast<VehicleActor*>(parentProxy->GetActor());
			dtGame::GameActorProxy &pr = parent->GetGameActorProxy();
			parent->GetTransform(objectTransform);
			objectTransform.GetTranslation(objectPosition);
			objectTransform.GetRotation(objectRotation);

			dtCore::RefPtr<dtDAL::ActorProperty> speedProp(pr.GetProperty(C_SET_SPEED));
			dtCore::RefPtr<dtDAL::FloatActorProperty> vspeedProp( static_cast<dtDAL::FloatActorProperty*>( speedProp.get() ) );
			tSpeed = vspeedProp->GetValue(); 
			dtCore::RefPtr<dtDAL::ActorProperty> courseProp(pr.GetProperty(C_SET_COURSE) );
			dtCore::RefPtr<dtDAL::FloatActorProperty> vcourseProp( static_cast<dtDAL::FloatActorProperty*>( courseProp.get() ) );
			tCourse = vcourseProp->GetValue();

			dtCore::RefPtr<VehicleActor> parent2 = static_cast<VehicleActor*>(pProxy->GetActor());
			dtGame::GameActorProxy &pr2 = parent2->GetGameActorProxy();
			parent2->GetTransform(ownShipTransform);
			ownShipTransform.GetTranslation(ownShipPosition);
			ownShipTransform.GetRotation(ownShipRotation);

			/*tBearing = ComputeBearingTo2(ownShipPosition.x(),ownShipPosition.y(),objectPosition.x(),objectPosition.y());
			tRange = ComputeDistance(ownShipPosition.x(),ownShipPosition.y(), objectPosition.x(),objectPosition.y());

			CalcHitPredition(tRange,tBearing,tSpeed,tCourse,130,hRange,hBearing,hTime);
			hBearing = hBearing + ownShipRotation.x();
			mRate = -hBearing;*/

			static float nbearing;
			nbearing = ComputeBearingTo2(ownShipPosition.x(),ownShipPosition.y(),objectPosition.x(),objectPosition.y());
			nbearing = nbearing + ownShipRotation.x();
			mRate = -nbearing;

			if (mRate > 180.0f) 
				mRate = mRate - 360.0f;

			if (tempMRate != mRate)
			{
				SetMoveRate(mRate);
				MoveWeapon_LR();
			}
		}		
	}

	if (stopMove2 == false)
		MoveWeapon_LR();
}

 

void AsrockBodyActor::ProcessMessage(const dtGame::Message &message)
{
	//handle game event
	if(GetGameActorProxy().IsInGM()){

		if(message.GetMessageType().GetName() == SimMessageType::ASROCK_EVENT.GetName())
			ProcessOrderEvent(message);
	}

}

void AsrockBodyActor::ProcessOrderEvent(const dtGame::Message &message)
{
	const MsgSetAsrock &Msg = static_cast<const MsgSetAsrock&>(message);
	
	if (((int)Msg.GetVehicleID()	== mVehicleID	) && 
		((int)Msg.GetWeaponID()		== mWeaponID	) && 
		((int)Msg.GetLauncherID()	== mLauncherID	))
	{
		switch (Msg.GetOrderID())
	    {
			

			case ORD_ASROCK_ASSIGNED :  
				{
					stopMove_LR = false;

					static dtCore::Transform objectTransform;
					static osg::Vec3 objectPosition;
					static osg::Vec3 objectRotation;
					static dtCore::Transform ownShipTransform;
					static osg::Vec3 ownShipPosition;
					static osg::Vec3 ownShipRotation;

					TargetID = Msg.GetTargetID();
					OwnShipId = Msg.GetVehicleID();
					parentProxy = GetShipActorByID(TargetID);
					pProxy = GetShipActorByID(OwnShipId);
	
					if ( parentProxy.valid() )
					{

						dtCore::RefPtr<VehicleActor> parent = static_cast<VehicleActor*>(parentProxy->GetActor());
						dtGame::GameActorProxy &pr = parent->GetGameActorProxy();
						parent->GetTransform(objectTransform);
						objectTransform.GetTranslation(objectPosition);
						objectTransform.GetRotation(objectRotation);

						dtCore::RefPtr<dtDAL::ActorProperty> speedProp(pr.GetProperty(C_SET_SPEED));
						dtCore::RefPtr<dtDAL::FloatActorProperty> vspeedProp( static_cast<dtDAL::FloatActorProperty*>( speedProp.get() ) );
						tSpeed = vspeedProp->GetValue(); 
						dtCore::RefPtr<dtDAL::ActorProperty> courseProp(pr.GetProperty(C_SET_COURSE) );
						dtCore::RefPtr<dtDAL::FloatActorProperty> vcourseProp( static_cast<dtDAL::FloatActorProperty*>( courseProp.get() ) );
						tCourse = vcourseProp->GetValue();
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
						nbearing = nbearing + ownShipRotation.x();
						mRate = -nbearing;

						/*tBearing = ComputeBearingTo2(ownShipPosition.x(),ownShipPosition.y(),objectPosition.x(),objectPosition.y());
						tRange = ComputeDistance(ownShipPosition.x(),ownShipPosition.y(), objectPosition.x(),objectPosition.y());

						CalcHitPredition(tRange,tBearing,tSpeed,tCourse,130,hRange,hBearing,hTime);
						hBearing = hBearing + ownShipRotation.x();
						mRate = -hBearing;*/

						if (mRate > 180.0f) 
							mRate = mRate - 360.0f;
					}
				}
			break;

			case ORD_ASROCK_DEASSIGNED :  
				{
					OwnShipId = Msg.GetVehicleID();
					pProxy = GetShipActorByID(OwnShipId);

					static dtCore::Transform objectTransform;
					static osg::Vec3 objectPosition;
					static osg::Vec3 objectRotation;
					
					pProxy = GetShipActorByID(OwnShipId);
					if (pProxy.valid())
					{
						dtCore::RefPtr<VehicleActor> parent = static_cast<VehicleActor*>(pProxy->GetActor());
						dtGame::GameActorProxy &pr = parent->GetGameActorProxy();
						parent->GetTransform(objectTransform);
						objectTransform.GetTranslation(objectPosition);
						objectTransform.GetRotation(objectRotation);

						//SetMoveRate(0.0);
						SetMoveRate(0);
						stopMove_LR = true;
						stopMove2 = false;
						std::cout << GetName() <<"  Deassign To " << objectRotation[0] << std::endl;
					}
					else
						std::cout << "  Not Valid " << std::endl;
				}
			break;

			case ORD_ASROCK :  
				{
					dtCore::RefPtr<dtCore::ParticleSystem> mExplosion= new dtCore::ParticleSystem();
					mExplosion->LoadFile(C_PARTICLES_ASAP,true);
					GetGameActorProxy().GetActor()->AddChild(mExplosion.get());
					mExplosion->SetEnabled(true);
					std::cout<<GetName()<<"  Explode Effef Launcher "<<std::endl;
				}
			break;
		}
	} 
}

void AsrockBodyActor::MoveWeapon_LR()//float deltaSimTime
{
	/************************FUNGSI TRACK********************************/

	//static dtCore::Transform BodyTransform;
	//static osg::Vec3 BodyPosition, BodyRotation;

	//GetTransform(BodyTransform);
	//BodyTransform.GetTranslation(BodyPosition);
	//BodyTransform.GetRotation(BodyRotation);

	//std::cout << BodyRotation[0] << ", " << mRate << std::endl;

	//if (BodyRotation[0] < mRate )
	//{
	//	BodyRotation[0] +=   1 ;
	//	if (BodyRotation[0] >= mRate) {
	//		//stopMove_LR = true;
	//		BodyRotation[0] = mRate;
	//		tempMRate = mRate;
	//		stopMove2 = true;
	//	}
	//}
	////else if (BodyRotation.z() > mRate )
	//else if (BodyRotation[0] > mRate )
	//{
	//	BodyRotation[0] -=   1 ;
	//	if (BodyRotation[0] <= mRate){
	//		//stopMove_LR = true;
	//		BodyRotation[0] = mRate;
	//		tempMRate = mRate;
	//		stopMove2 = true;
	//	}
	//}
	////else if (BodyRotation.z() == mRate )
	//else if (BodyRotation[0] == mRate )
	//	stopMove2 = true;

	//BodyTransform.SetTranslation(BodyPosition);
	//BodyTransform.SetRotation(BodyRotation);
	//SetTransform(BodyTransform);
		
	/************************************************************************/

	osg::Vec3 xyz = GetGameActorProxy().GetRotation();

	//std::cout << xyz.z() << "," << mRate_LR << std::endl;

	if (xyz.z() > mRate ){
		xyz[2] -= 1 ;
		if (xyz[2] <= mRate) {
			tempMRate = mRate;
			stopMove2 = true;
			xyz[2] = mRate;
		}
	}
	else if (xyz.z() < mRate){
		xyz[2] += 1 ;
		if (xyz[2] >= mRate) {
			tempMRate = mRate;
			stopMove2 = true;
			xyz[2] = mRate;
		}
	}
	else if (xyz.z() == mRate){
		stopMove2 = false;
	}

	GetGameActorProxy().SetRotation(xyz);
}

void AsrockBodyActor::SetMoveRate(float rate)
{
	mRate = rate;
	if (mRate >= 170) mRate = 170;
	else if (mRate <= -170) mRate =-170.0;

}
  
void AsrockBodyActor::OnEnteredWorld()
{
	LauncherBodyActor::OnEnteredWorld();
}
 
void AsrockBodyActor::OnRemovedFromWorld()
{
	LauncherBodyActor::OnRemovedFromWorld();
	//RegisterForMessages(SimMessageType::ASROCK_EVENT);

    //RemoveSender(&(GetGameActorProxy().GetGameManager()->GetScene()));
}

void AsrockBodyActor::CalcHitPredition ( 
									const float tRange, 
									const float tBearing, 
									const float tSpeed, 
									const float tCourse, 
									const float  pSpeed,
									float &hRange, float &hBearing, float &hTime )
{
	float vR ;
	//float tMinute;
	float dA, dB, dC ;
	float sinA, sinB, sinC;

	if  ( abs(pSpeed) <  0.00000001f ) abort();

	dC = 180 - (tBearing - tCourse);
	sinC = sin(osg::DegreesToRadians(dC));
	sinA = (tSpeed * sinC)/ pSpeed;
	if ((sinA < -1.0) || (sinA > 1.0))
	{
		hTime  = 9999999.99f;  //  tidak terkejar
		hRange = 9999999.99f;  //
		abort();
	}
	dA = osg::RadiansToDegrees(asin(sinA));
	dB = 180 - dC - dA;
	sinB = sin(osg::DegreesToRadians(dB) );

	if  ( abs(sinC) < 0.00000001f )
		vR = pSpeed + tSpeed * cos(osg::DegreesToRadians(dC));
	else
		vR = (pSpeed * sinB) / sinC;

	hBearing = tCourse + dB;
	if ( abs(vR) < 0.00000001f)
	{
		hTime  = 9999999.99f;  //  tidak terkejar
		hRange = 9999999.99f;  //
	}
	else
	{
		hTime = tRange / vR;
		hRange = hTime * pSpeed;
	}
}
