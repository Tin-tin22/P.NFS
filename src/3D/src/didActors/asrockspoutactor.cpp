#include "asrockspoutactor.h"
#include "didactorssources.h"
#include "shipactor.h"

////////////////////////////////////////////////////////
AsrockSpoutActorProxy::AsrockSpoutActorProxy()
{
	SetClassName("Asrock Spout");
}
AsrockSpoutActorProxy::~AsrockSpoutActorProxy()
{
}

void AsrockSpoutActorProxy::BuildInvokables()
{
    LauncherSpoutActorProxy::BuildInvokables();
}

void AsrockSpoutActorProxy::BuildPropertyMap()
{
	LauncherSpoutActorProxy::BuildPropertyMap();
 
}

void AsrockSpoutActorProxy::OnEnteredWorld()
{
	LauncherSpoutActorProxy::OnEnteredWorld();
	RegisterForMessages(SimMessageType::ASROCK_EVENT);
}

////////////////////////////////////////////////////////////
AsrockSpoutActor::AsrockSpoutActor(dtGame::GameActorProxy &proxy)
:LauncherSpoutActor(proxy),
mRate_UD(0),Elev(0),stopMove_UD(true),stopMove_UD2(true),CorrectRange(0.0),ndistance(0.0),
TipeID(0), TipeLoading(0), TipeAssigned(0),isMatch(false)
{
	engineSound = NULL ;
}

AsrockSpoutActor::~AsrockSpoutActor()
{
}

 
void AsrockSpoutActor::TickLocal(const dtGame::Message &tickMessage)
{
	const dtGame::TickMessage &tick = static_cast<const dtGame::TickMessage&>(tickMessage);
	osg::Vec3 xyz = GetGameActorProxy().GetRotation();
	float deltaSimTime = tick.GetDeltaSimTime();

	if (!stopMove_UD){	
		if ( (parentProxy.valid()) && (pProxy.valid()))
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

			tBearing = ComputeBearingTo2(ownShipPosition.x(),ownShipPosition.y(),objectPosition.x(),objectPosition.y());
			tRange = ComputeDistance(ownShipPosition.x(),ownShipPosition.y(), objectPosition.x(),objectPosition.y());

			static float tSpeed2;
			if (TipeID == ErrikaLow) tSpeed2 = 100;
			if (TipeID == ErrikaHigh) tSpeed2 = 130;
			if (TipeID == NellyLow) tSpeed2 = 166;
			if (TipeID == NellyHigh) tSpeed2 = 207;

			CalcHitPredition(tRange,tBearing,tSpeed,tCourse,tSpeed2,hRange,hBearing,hTime);
			Elev = InitElevation(hRange + CorrectRange);

			//ndistance = Range3D(ownShipPosition.x(), ownShipPosition.y(), 0, objectPosition.x(), objectPosition.y(), 0);
			//Elev = InitElevation(ndistance + CorrectRange);

			if (tempElev != Elev)
			{
				SetMoveRate_UD(Elev);
				MoveWeapon_UD();
			}
		}
	}

	if (stopMove_UD2 == false)
		MoveWeapon_UD();

}

void AsrockSpoutActor::TickRemote(const dtGame::Message &tickMessage)
{
	//
}
 

void AsrockSpoutActor::ProcessMessage(const dtGame::Message &message)
{
	if(GetGameActorProxy().IsInGM()){

		if(message.GetMessageType().GetName() == SimMessageType::ASROCK_EVENT.GetName())
			ProcessOrderEvent(message);
	}

}

void AsrockSpoutActor::ProcessOrderEvent(const dtGame::Message &message)
{
	const MsgSetAsrock &Msg = static_cast<const MsgSetAsrock&>(message);		
	 
	if (((int)Msg.GetVehicleID()	== mVehicleID	) && 
		((int)Msg.GetWeaponID()		== mWeaponID	) && 
		((int)Msg.GetLauncherID()	== mLauncherID	))	 
	{
		ShipID = Msg.GetVehicleID();
		TargetID = Msg.GetTargetID();
		CorrectRange = Msg.GetCorrectRange();	

		switch (Msg.GetOrderID())  
		{
		case ORD_ASROCK_ASSIGNED :  
			{
				TipeAssigned = Msg.GetMissileType();
				TipeID = TipeAssigned;

				if (TipeLoading==Nelly && (TipeAssigned==NellyHigh || TipeAssigned==NellyLow))
					isMatch = true;
				else if (TipeLoading==Errika && (TipeAssigned==ErrikaHigh || TipeAssigned==ErrikaLow))
					isMatch = true;
				else
					isMatch = false;

				if ( isMatch )
				{
					parentProxy = GetShipActorByID(TargetID);
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

					pProxy = GetShipActorByID(ShipID);
					if ( pProxy.valid() )
					{
						dtCore::RefPtr<VehicleActor> parent = static_cast<VehicleActor*>(pProxy->GetActor());
						dtGame::GameActorProxy &pr = parent->GetGameActorProxy();
						parent->GetTransform(ownShipTransform); 
						ownShipTransform.GetTranslation(ownShipPosition);
						ownShipTransform.GetRotation(ownShipRotation);
					}

					if (( pProxy.valid() ) && ( parentProxy.valid() )){

						//ndistance = Range3D(ownShipPosition.x(), ownShipPosition.y(), 0, objectPosition.x(), objectPosition.y(), 0);
						//Elev = InitElevation(ndistance + CorrectRange);						

						tBearing = ComputeBearingTo2(ownShipPosition.x(),ownShipPosition.y(),objectPosition.x(),objectPosition.y());
						tRange = ComputeDistance(ownShipPosition.x(),ownShipPosition.y(), objectPosition.x(),objectPosition.y());

						static float tSpeed2;
						if (TipeID == ErrikaLow) tSpeed2 = 100;
						if (TipeID == ErrikaHigh) tSpeed2 = 130;
						if (TipeID == NellyLow) tSpeed2 = 166;
						if (TipeID == NellyHigh) tSpeed2 = 207;

						CalcHitPredition(tRange,tBearing,tSpeed,tCourse,tSpeed2,hRange,hBearing,hTime);
						Elev = InitElevation(hRange + CorrectRange);

						std::cout << "ndistance assigned asroc = " << hRange << ", Elev = "<<Elev<<std::endl;
					}
					stopMove_UD = false;
				}
				else
				{
					if (TipeLoading == Errika && TipeAssigned == NellyLow)
						TipeID = ErrikaLow ;
					if (TipeLoading == Errika && TipeAssigned == NellyHigh)
						TipeID = ErrikaHigh ;
					if (TipeLoading == Nelly && TipeAssigned == ErrikaLow)
						TipeID = NellyLow ;
					if (TipeLoading == Nelly && TipeAssigned == ErrikaHigh)
						TipeID = NellyHigh ;

					if (TipeID == ErrikaLow)
						ndistance = 820; // minR+((maxR-minR)/2), harusnya menggunakan prosentase
					if (TipeID == ErrikaHigh)
						ndistance = 1130;
					if (TipeID == NellyLow)
						ndistance = 1985;
					if (TipeID == NellyHigh)
						ndistance = 2900;

					Elev = InitElevation(ndistance + CorrectRange);
					SetMoveRate_UD(Elev);
					stopMove_UD = true;
					stopMove_UD2 = false;
				}
			}
			break;

		case ORD_ASROCK_DEASSIGNED :  
			{
				SetMoveRate_UD(0);
				stopMove_UD = true;
				stopMove_UD2 = false;
			}
			break;

		case ORD_ASROCK_RELOAD :  
			{
				TipeLoading = Msg.GetMissileType();
				SetMoveRate_UD(90);
				stopMove_UD = true;
				stopMove_UD2 = false;
			}
			break;

		case ORD_ASROCK :  
			{
				CorrectRange = Msg.GetCorrectRange();

				if ( engineSound.valid()) 
					engineSound->Play();
				dtCore::RefPtr<dtCore::ParticleSystem> mExplosion= new dtCore::ParticleSystem();
				mExplosion->LoadFile(C_PARTICLES_ASAP,true); 
				GetGameActorProxy().GetActor()->AddChild(mExplosion.get());
				mExplosion->SetEnabled(true);
				std::cout<<GetName()<<"  Launch Missile "<<std::endl;
			}
			break;
		}
	}
}

double AsrockSpoutActor::InitElevation(double a)
{
	double dir;
	if ( TipeID == NellyHigh )
		dir = (-0.0292 * a) + 113.62; 
	else if ( TipeID == NellyLow )
		dir = (-0.05 * a) + 126;
	else if ( TipeID == ErrikaHigh )
		dir = (-0.0628 * a) + 110.28;
	else if ( TipeID == ErrikaLow )
		dir = (-0.083 * a) + 94.777;
	return dir; 
};

void AsrockSpoutActor::SetMoveRate_UD(float rate)
{
	mRate_UD = rate;
	if (mRate_UD >= 90.0) 
		mRate_UD = 90.0f;
	else if (mRate_UD <= 0) //8.5
		mRate_UD = 0; 
}

void AsrockSpoutActor::MoveWeapon_UD()
{
		
	osg::Vec3 xyz = GetGameActorProxy().GetRotation();

	//std::cout << xyz.x() << "," << mRate_UD << std::endl;

	if (xyz.x() < mRate_UD )
	{
		xyz.x() +=   0.5 ;
		if (xyz.x() >= mRate_UD) {
			//stopMove_UD = true;
			xyz.x() = mRate_UD;
			tempElev = mRate_UD;
			stopMove_UD2 = true;
		}
	}
	else if (xyz.x() > mRate_UD )
	{
		xyz.x() -=   0.5 ;
		if (xyz.x() <= mRate_UD) {
			//stopMove_UD = true;
			xyz.x() = mRate_UD;
			tempElev = mRate_UD;
			stopMove_UD2 = true;
		}
	}
	else if(xyz.x() == mRate_UD)
		stopMove_UD2 = true;

	//std::cout << Elev << " , " << xyz.x() << std::endl;
	GetGameActorProxy().SetRotation(xyz);
}

 
void AsrockSpoutActor::OnEnteredWorld()
{
	engineSound = dtAudio::AudioManager::GetInstance().NewSound();
	engineSound->LoadFile("Sounds/ledakan.wav");
	assert(engineSound);
	engineSound->SetMaxDistance(1000.0f);
	engineSound->SetLooping(false);
	AddChild(engineSound.get());

	LauncherSpoutActor::OnEnteredWorld();
}

void AsrockSpoutActor::OnRemovedFromWorld()
{
    RemoveSender(&(GetGameActorProxy().GetGameManager()->GetScene()));

}

void AsrockSpoutActor::CalcHitPredition ( 
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


