#include "cannonbodyactor.h"
#include "didactorssources.h"
#include "ShipModelActor.h"
#include <dtUtil/mathdefines.h>
#include "../didUtils/utilityfunctions.h"

////////////////////////////////////////////////////////
CannonBodyActorProxy::CannonBodyActorProxy()
{
	SetClassName("Cannon Body");
}
CannonBodyActorProxy::~CannonBodyActorProxy()
{

}

void CannonBodyActorProxy::BuildInvokables()
{
	LauncherBodyActorProxy::BuildInvokables();
}

void CannonBodyActorProxy::BuildPropertyMap()
{
	LauncherBodyActorProxy::BuildPropertyMap();

	CannonBodyActor* actor = NULL;
	GetActor(actor);

	//property model
	AddProperty(new dtDAL::FloatActorProperty("XTarget","XTarget",
	   dtDAL::FloatActorProperty::SetFuncType(actor, &CannonBodyActor::SetXTarget),
	   dtDAL::FloatActorProperty::GetFuncType(actor, &CannonBodyActor::GetXTarget), 
	   "Sets/gets XTarget." , C_TYPE_MISSILE));

}

void CannonBodyActorProxy::OnEnteredWorld()
{
	LauncherBodyActorProxy::OnEnteredWorld();
	RegisterForMessages(SimMessageType::CANNON_EVENT);
}

//////////////////////////////////////////////////////////////////////////
CannonBodyActor::CannonBodyActor(dtGame::GameActorProxy &proxy )
	:LauncherBodyActor(proxy), 
	mMaxRotation(180), 
	mRate(0), 
	stopMove(true),
	isTrack(false),
	isBTK(false),
	isAirShipTrack(false),
	mCounterRot(0),
	isValid(false),
	BalistikMode(0)
{

}

CannonBodyActor::~CannonBodyActor()
{
}

void CannonBodyActor::ProcessMessage(const dtGame::Message &message)
{
	if(GetGameActorProxy().IsInGM()){

		if(message.GetMessageType().GetName() == SimMessageType::CANNON_EVENT.GetName())
			ProcessOrderEvent(message);
	}
}

void CannonBodyActor::ProcessOrderEvent(const dtGame::Message &message)
{
	const MsgSetCannon &Msg = static_cast<const MsgSetCannon&>(message);

	if (((int)Msg.GetVehicleID()	== mVehicleID	) && 
	    ((int)Msg.GetWeaponID()		== mWeaponID	) && 
	    ((int)Msg.GetLauncherID()	== mLauncherID	))
	{
		switch (Msg.GetOrderID())
	    {
			//// original event
			case ORD_CANNON_LR : 
				{	
					SetMoveRate(Msg.GetUpDown());
					stopMove = false ;
				}
				break;

			//// below prepare for direct event, ex : joystick, modify when joystick already fix.
			case ORD_CANNON_DIRECT_LR : 
				{	
					stopMove = true ;

					dtCore::Transform tx ;
					//GetTransform(tx,dtCore::Transformable::REL_CS);
					GetTransform(tx,dtCore::Transformable::ABS_CS);
					float h,p,r;
					tx.GetRotation(h,p,r);
					h = /*GetInitHeading() +}*/ Msg.GetUpDown();
					//h = GetInitHeading() +  Msg.GetUpDown();
					tx.SetRotation(h,p,r);

					//SetTransform(tx,dtCore::Transformable::REL_CS);
					SetTransform(tx,dtCore::Transformable::ABS_CS);
				}
				break;

			//Added Nando
			//Assigned
			case ORD_CANNON_ASSIGNED :
			{
				if (Msg.GetModeID() == 1)
				{
					isTrack			= true;
					isBTK			= false;
					isAirShipTrack	= false;
					TargetID		= Msg.GetTargetID();
					mCorrBearing	= Msg.GetAutoCorrectBearing();
					mCorrElev		= Msg.GetAutoCorrectElev();
					BalistikMode	= Msg.GetBalistikID();

					std::cout << "Vehicle " << mVehicleID << " RECEIVE ORDER ASSIGNED TARGET ID " << TargetID << std::endl;
				}
				else
				if (Msg.GetModeID() == 2)
				{
					isBTK			= true;
					isTrack			= false;
					isAirShipTrack	= false;
					mCorrBearing	= Msg.GetAutoCorrectBearing();
					mCorrElev		= Msg.GetAutoCorrectElev();
					BalistikMode	= Msg.GetBalistikID();
				}
				else
				if (Msg.GetModeID() == 3)
				{
					isAirShipTrack	= true;
					isTrack			= false;
					isBTK			= false;
					TargetID		= Msg.GetTargetID();
					mCorrBearing	= Msg.GetAutoCorrectBearing();
					mCorrElev		= Msg.GetAutoCorrectElev();
					BalistikMode	= Msg.GetBalistikID();

					std::cout << "Vehicle " << mVehicleID << " RECEIVE ORDER ASSIGNED TARGET ID " << TargetID << std::endl;
				}
			}
			break;

			//Deassigned
			case ORD_CANNON_DEASSIGNED :
			{
				 
				stopMove = false ;

				if (Msg.GetModeID() == 1)
				{
					isTrack	= false;
					TargetID	= 0;

					std::cout << "Vehicle " << mVehicleID << "RECEIVE ORDER DEASSIGNED" << std::endl;
				}
				else
				if (Msg.GetModeID() == 2)
				{
					isBTK		= false;

					std::cout << "Vehicle " << mVehicleID << "RECEIVE ORDER DEASSIGNED" << std::endl;
				}
				else
				if (Msg.GetModeID() == 3)
				{
					isAirShipTrack	= false;
					TargetID	= 0;

					std::cout << "Vehicle " << mVehicleID << "RECEIVE ORDER DEASSIGNED" << std::endl;
				}
				
			}
			break;
			 
		} 
	}
}


void CannonBodyActor::TickLocal(const dtGame::Message &tickMessage)
{
	const dtGame::TickMessage &tick = static_cast<const dtGame::TickMessage&>(tickMessage);
	float deltaSimTime = tick.GetDeltaSimTime();

	mCounterRot += tick.GetDeltaSimTime();

	if (mCounterRot > 5.0f)
	{
		if ( isTrack == true )
		{
			ValidateRotation();
		}
		else
		if ( isBTK == true)
		{
			ValidateRotationForBTK();
		}
		else
		if ( isAirShipTrack == true )
		{
			ValidateRotationForAirTrack();
		}

		mCounterRot = 0;
	}

	if (!stopMove) CannonRotation();

}


void CannonBodyActor::SetMoveRate(float rate)
{
	mRate = mRate + rate;
	//if (mRate >= 90) mRate = 90.0;
	//else if (mRate <= -90) mRate =-90.0;
    stopMove = false;
}

void CannonBodyActor::ValidateRotation()
{
	isValid = false;

	dtCore::RefPtr<dtDAL::ActorProxy> TargetProxy = GetShipActorByID(TargetID);
	if ( TargetProxy.valid() )
	{
		dtCore::RefPtr<VehicleActor> Target = static_cast<VehicleActor*>(TargetProxy->GetActor());
		dtGame::GameActorProxy &Tr = Target->GetGameActorProxy();

		Target->GetTransform(TargetTransform);
		TargetTransform.GetTranslation(TargetPosition);
		TargetTransform.GetRotation(TargetRotation);
	}

	dtCore::RefPtr<dtDAL::ActorProxy> parentProxy = GetShipActorByID(GetVehicleID());
	if ( parentProxy.valid() )
	{
		dtCore::RefPtr<VehicleActor> parent = static_cast<VehicleActor*>(parentProxy->GetActor());
		dtGame::GameActorProxy &pr = parent->GetGameActorProxy();

		parent->GetTransform(ShipTransform);
		ShipTransform.GetTranslation(ShipPosition);
		ShipTransform.GetRotation(ShipRotation);
	}

	if (( TargetProxy.valid() ) && ( parentProxy.valid() ))
	{
		BearingTarget = ComputeBearingTo2(ShipPosition.x(), ShipPosition.y(), TargetPosition.x(), TargetPosition.y());
		BearingTarget = BearingTarget + mCorrBearing;
		BearingTarget = ValidateDegree(BearingTarget);

		//std::cout << "baringan target " << BearingTarget << std::endl;

		RangeTarget	  = Range3D(ShipPosition.x(), ShipPosition.y(), 0, TargetPosition.x(), TargetPosition.y(), 0);
		
		//Debug Mode For Start n End Angle;
		//std::cout << "Start Angle : " << GetStartAngle() << std::endl;
		//std::cout << "End Angle : " << GetEndAngle() << std::endl;

		mAbsolutStartAngle	= -ShipRotation.x() + GetStartAngle();
		mAbsolutStartAngle	= ValidateDegree(mAbsolutStartAngle); 

		mAbsolutEndAngle	= -ShipRotation.x() + GetEndAngle();
		mAbsolutEndAngle	= ValidateDegree(mAbsolutEndAngle);

		if (( mWeaponID == CT_CANNON_57 ) ||
			( mWeaponID == CT_CANNON_76 ))
		{
			if (( DegComp_IsBeetwen( BearingTarget, mAbsolutStartAngle, mAbsolutEndAngle ) == true ) && 
				( RangeTarget < 15000))
			{
				isValid = true;
			}
		}
		else
		if ( mWeaponID == CT_CANNON_40 )
		{
			if (( DegComp_IsBeetwen( BearingTarget, mAbsolutStartAngle, mAbsolutEndAngle ) == true ) && 
				( RangeTarget < 11800))
			{
				isValid = true;
			}
		}
		else
		if ( mWeaponID == CT_CANNON_120 )
		{
			if (( DegComp_IsBeetwen( BearingTarget, mAbsolutStartAngle, mAbsolutEndAngle ) == true ) && 
				( RangeTarget < 18350))
			{
				isValid = true;
			}
		}

		if ( isValid == true )
		{
			//Inside
			CannonBodyRotation();
		}
		else
		{
			//Outside
			std::cout << "Body Cannon Failed To Tracking Object In Outside Area" << std::endl;
			isTrack = false;
		}	
	}
}

void CannonBodyActor::ValidateRotationForAirTrack()
{
	isValid = false;

	dtCore::RefPtr<dtDAL::ActorProxy> TargetProxy = GetShipActorByID(TargetID);
	if ( TargetProxy.valid() )
	{
		dtCore::RefPtr<VehicleActor> Target = static_cast<VehicleActor*>(TargetProxy->GetActor());
		dtGame::GameActorProxy &Tr = Target->GetGameActorProxy();

		Target->GetTransform(TargetTransform);
		TargetTransform.GetTranslation(TargetPosition);
		TargetTransform.GetRotation(TargetRotation);
	}

	dtCore::RefPtr<dtDAL::ActorProxy> parentProxy = GetShipActorByID(GetVehicleID());
	if ( parentProxy.valid() )
	{
		dtCore::RefPtr<VehicleActor> parent = static_cast<VehicleActor*>(parentProxy->GetActor());
		dtGame::GameActorProxy &pr = parent->GetGameActorProxy();

		parent->GetTransform(ShipTransform);
		ShipTransform.GetTranslation(ShipPosition);
		ShipTransform.GetRotation(ShipRotation);
	}

	if (( TargetProxy.valid() ) && ( parentProxy.valid() ))
	{
		BearingTarget = ComputeBearingTo2(ShipPosition.x(), ShipPosition.y(), TargetPosition.x(), TargetPosition.y());
		BearingTarget = BearingTarget + mCorrBearing;
		BearingTarget = ValidateDegree(BearingTarget);

		RangeTarget	  = Range3D(ShipPosition.x(), ShipPosition.y(), 0, TargetPosition.x(), TargetPosition.y(), 0);

		//Debug Mode For Start n End Angle;
		//std::cout << "Start Angle : " << GetStartAngle() << std::endl;
		//std::cout << "End Angle : " << GetEndAngle() << std::endl;

		mAbsolutStartAngle	= -ShipRotation.x() + GetStartAngle();
		mAbsolutStartAngle	= ValidateDegree(mAbsolutStartAngle); 

		mAbsolutEndAngle	= -ShipRotation.x() + GetEndAngle();
		mAbsolutEndAngle	= ValidateDegree(mAbsolutEndAngle);

		if (( mWeaponID == CT_CANNON_57 ) ||
			( mWeaponID == CT_CANNON_76 ))
		{
			if (( DegComp_IsBeetwen( BearingTarget, mAbsolutStartAngle, mAbsolutEndAngle ) == true ) && 
				( RangeTarget < 15000))
			{
				isValid = true;
			}
		}
		else
		if ( mWeaponID == CT_CANNON_40 )
		{
			if (( DegComp_IsBeetwen( BearingTarget, mAbsolutStartAngle, mAbsolutEndAngle ) == true ) && 
				( RangeTarget < 11800))
			{
				isValid = true;
			}
		}
		else
		if ( mWeaponID == CT_CANNON_120 )
		{
			if (( DegComp_IsBeetwen( BearingTarget, mAbsolutStartAngle, mAbsolutEndAngle ) == true ) && 
				( RangeTarget < 18350))
			{
				isValid = true;
			}
		}

		if ( isValid == true )
		{	
			CannonBodyRotationForAirTrack();
			std::cout << "Body Cannon Tracking Object" << std::endl;
			isAirShipTrack = false;
		}
		else
		{
			//Outside
			std::cout << "Body Cannon Failed To Tracking Object In Outside Area" << std::endl;
			isAirShipTrack = false;
		}	
	}
}

void CannonBodyActor::ValidateRotationForBTK()
{
	isValid = false;

	dtCore::RefPtr<dtDAL::ActorProxy> parentProxy = GetShipActorByID(GetVehicleID());
	if ( parentProxy.valid() )
	{
		dtCore::RefPtr<VehicleActor> parent = static_cast<VehicleActor*>(parentProxy->GetActor());
		dtGame::GameActorProxy &pr = parent->GetGameActorProxy();

		parent->GetTransform(ShipTransform);
		ShipTransform.GetTranslation(ShipPosition);
		ShipTransform.GetRotation(ShipRotation);
	}

	if ( parentProxy.valid() )
	{
		BearingTarget		= -ShipRotation.x() + mCorrBearing;

		//Debug Mode For Start n End Angle;
		//std::cout << "Start Angle : " << GetStartAngle() << std::endl;
		//std::cout << "End Angle : " << GetEndAngle() << std::endl;

		mAbsolutStartAngle	= -ShipRotation.x() + GetStartAngle();
		mAbsolutStartAngle	= ValidateDegree(mAbsolutStartAngle); 

		mAbsolutEndAngle	= -ShipRotation.x() + GetEndAngle();
		mAbsolutEndAngle	= ValidateDegree(mAbsolutEndAngle);

		if (( mWeaponID == CT_CANNON_57 ) ||
			( mWeaponID == CT_CANNON_76 ))
		{
			if ( BalistikMode == 0)
			{
				//low balistik
				if (( DegComp_IsBeetwen( BearingTarget, mAbsolutStartAngle, mAbsolutEndAngle ) == true ) &&
					( mCorrElev < 35.9 ) && ( mCorrElev > 0.5 ))
				{
					isValid = true;
				}
			}
			else
			{
				//high balistik
				if (( DegComp_IsBeetwen( BearingTarget, mAbsolutStartAngle, mAbsolutEndAngle ) == true ) &&
					( mCorrElev > 40) && ( mCorrElev < 79.9 ))
				{
					isValid = true;
				}
			}
		}
		else
		if ( mWeaponID == CT_CANNON_40 )
		{
			if (( DegComp_IsBeetwen( BearingTarget, mAbsolutStartAngle, mAbsolutEndAngle ) == true ) &&
				(mCorrElev < 37))
			{
				isValid = true;
			}
		}
		else
		if ( mWeaponID == CT_CANNON_120 )
		{
			if (( DegComp_IsBeetwen( BearingTarget, mAbsolutStartAngle, mAbsolutEndAngle ) == true ) &&
				(mCorrElev < 39))
			{
				isValid = true;
			}
		}

		if ( isValid == true )
		{
			//Inside
			CannonBodyRotationForBTK();
			isBTK = false;
		}
		else
		{
			//Outside
			std::cout << "body Cannon Failed To Tracking Object In Outside Area" << std::endl;
			isBTK = false;
		}	
	}
}

void CannonBodyActor::CannonBodyRotation()
{
	static dtCore::Transform CannonBodyTransform;
	static osg::Vec3 CannonBodyPosition, CannonBodyRotation;

	GetTransform(CannonBodyTransform);
	CannonBodyTransform.GetTranslation(CannonBodyPosition);
	CannonBodyTransform.GetRotation(CannonBodyRotation);

	trac.SetDirection(BearingTarget); 
	//std::cout << "Vehicle ID : " << mVehicleID << " Weapon Bearing : " << BearingTarget << std::endl; 

	CannonBodyRotation[0]	= -trac.GetDirection();

	CannonBodyTransform.SetTranslation(CannonBodyPosition);
	CannonBodyTransform.SetRotation(CannonBodyRotation);
	SetTransform(CannonBodyTransform);
}

void CannonBodyActor::CannonBodyRotationForAirTrack()
{

	static dtCore::Transform CannonBodyTransform;
	static osg::Vec3 CannonBodyPosition, CannonBodyRotation;

	GetTransform(CannonBodyTransform);
	CannonBodyTransform.GetTranslation(CannonBodyPosition);
	CannonBodyTransform.GetRotation(CannonBodyRotation);

	trac.SetDirection(BearingTarget); 
	//std::cout << "Vehicle ID : " << mVehicleID << " Weapon Bearing : " << BearingTarget << std::endl; 

	CannonBodyRotation[0]	= -trac.GetDirection();

	CannonBodyTransform.SetTranslation(CannonBodyPosition);
	CannonBodyTransform.SetRotation(CannonBodyRotation);
	SetTransform(CannonBodyTransform);
}

void CannonBodyActor::CannonBodyRotationForBTK()
{
	static dtCore::Transform CannonBodyTransform;
	static osg::Vec3 CannonBodyPosition, CannonBodyRotation;

	GetTransform(CannonBodyTransform);
	CannonBodyTransform.GetTranslation(CannonBodyPosition);
	CannonBodyTransform.GetRotation(CannonBodyRotation);

	trac.SetDirection(BearingTarget); 
	//std::cout << "Vehicle ID : " << mVehicleID << " Weapon Bearing : " << BearingTarget << std::endl; 

	CannonBodyRotation[0]	= -trac.GetDirection();

	CannonBodyTransform.SetTranslation(CannonBodyPosition);
	CannonBodyTransform.SetRotation(CannonBodyRotation);
	SetTransform(CannonBodyTransform);
}

void CannonBodyActor::CannonRotation()
{
	osg::Vec3 xyz = GetGameActorProxy().GetRotation();
	//std::cout << xyz.z() << "," << mRate << std::endl;
	if (xyz.z() < mRate )
	{
		xyz[2] += 360.0f * 0.001 ;
		if (xyz[2] >= mRate) stopMove = true;
	}
	else if (xyz.z() > mRate)
	{
		xyz[2] -= 360.0f * 0.001 ;
		if (xyz[2] <= mRate) stopMove = true;
	}
	if (xyz.z() == mRate )
		stopMove = true;
	
	if (xyz.z()>= 90) xyz.z()=90.0;
	else if (xyz.z()<= -90) xyz.z()=-90.0;
	
	GetGameActorProxy().SetRotation(xyz);
}


void CannonBodyActor::OnEnteredWorld()
{
	LauncherBodyActor::OnEnteredWorld();
	//SetSoundEngineFile("CannonFar.wav");
}

void CannonBodyActor::OnRemovedFromWorld()
{
    RemoveSender(&(GetGameActorProxy().GetGameManager()->GetScene()));
 
}