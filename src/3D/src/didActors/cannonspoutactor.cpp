#include "cannonspoutactor.h"
#include "ShipModelActor.h"
#include "Cannonbodyactor.h"

#include "didactorssources.h"
#include "../didUtils/utilityfunctions.h"

//  [5/7/2013 DID RKT2]
#include "../didUtils/CanonHandle.h"

////////////////////////////////////////////////////////
CannonSpoutActorProxy::CannonSpoutActorProxy()
{
	SetClassName("Cannon Spout");
}
CannonSpoutActorProxy::~CannonSpoutActorProxy()
{
}

void CannonSpoutActorProxy::BuildInvokables()
{
	LauncherSpoutActorProxy::BuildInvokables();
}

void CannonSpoutActorProxy::BuildPropertyMap()
{
	LauncherSpoutActorProxy::BuildPropertyMap();
}

void CannonSpoutActorProxy::OnEnteredWorld()
{
	LauncherSpoutActorProxy::OnEnteredWorld();
	RegisterForMessages(SimMessageType::CANNON_EVENT);
}

////////////////////////////////////////////////////////////
CannonSpoutActor::CannonSpoutActor(dtGame::GameActorProxy &proxy)
	:LauncherSpoutActor(proxy),
	mRate(0),
	stopMove(true),
	stopMove2(true),
	isTrack(false),
	isBTK(false),
	isAirShipTrack(false),
	mCounterRot(0),
	isValid(false),
	isUnlockToFire(false),
	BalistikMode(0)
{
	
}

CannonSpoutActor::~CannonSpoutActor()
{

}

void CannonSpoutActor::ProcessMessage(const dtGame::Message &message)
{
	//handle game event
	if(GetGameActorProxy().IsInGM()){

		if(message.GetMessageType().GetName() == SimMessageType::CANNON_EVENT.GetName())
			ProcessOrderEvent(message);
	}
}

void CannonSpoutActor::ProcessOrderEvent(const dtGame::Message &message)
{
	const MsgSetCannon &Msg = static_cast<const MsgSetCannon&>(message);

	if (((int)Msg.GetVehicleID()	== mVehicleID	) && 
		((int)Msg.GetWeaponID()		== mWeaponID	) && 
		((int)Msg.GetLauncherID()	== mLauncherID	))
	{

		switch (Msg.GetOrderID())
		{
			case ORD_CANNON_UD : 
			{	
				SetMoveRate(Msg.GetUpDown());
				stopMove = false;
				stopMove2 = true;
			}
			break;

			//// below prepare for direct event, ex : joystick, modify when joystick already fix.
			case ORD_CANNON_DIRECT_UD : 
			{  
				stopMove = true;
				stopMove2 = true;

				dtCore::Transform tx ;
				GetTransform(tx,dtCore::Transformable::REL_CS);
				float h,p,r;
				tx.GetRotation(h,p,r);
				//p = GetInitPitch() + Msg.GetXTarget();
				p = GetInitPitch() + Msg.GetUpDown();
				tx.SetRotation(h,p,r);
				SetTransform(tx,dtCore::Transformable::REL_CS);
			}
			break;

			//Nando Added
			//Assigned
			case ORD_CANNON_ASSIGNED :
			{
				stopMove2 = true;

				if (Msg.GetModeID() == 1)
				{
					isTrack			 = true;
					isBTK			 = false;
					isAirShipTrack	 = false;
					TargetID	 = Msg.GetTargetID();
					mCorrBearing = Msg.GetAutoCorrectBearing();
					mCorrElev	 = Msg.GetAutoCorrectElev();
					BalistikMode = Msg.GetBalistikID();

					std::cout << "Vehicle " << mVehicleID << " RECEIVE ORDER ASSIGNED TARGET ID " << TargetID << std::endl;
				}
				else
				if (Msg.GetModeID() == 2)
				{
					isBTK			= true;
					isTrack			= false;
					isAirShipTrack	= false;
					mCorrBearing = Msg.GetAutoCorrectBearing();
					mCorrElev	 = Msg.GetAutoCorrectElev();
					BalistikMode = Msg.GetBalistikID();
				}
				else
				if (Msg.GetModeID() == 3)
				{
					isAirShipTrack	 = true;
					isTrack			 = false;
					isBTK			 = false;
					TargetID	 = Msg.GetTargetID();
					mCorrBearing = Msg.GetAutoCorrectBearing();
					mCorrElev	 = Msg.GetAutoCorrectElev();
					BalistikMode = Msg.GetBalistikID();

					std::cout << "Vehicle " << mVehicleID << " RECEIVE ORDER ASSIGNED TARGET ID " << TargetID << std::endl;
				}
			}
			break;

			//Deassigned
			case ORD_CANNON_DEASSIGNED :
			{
				stopMove = false;
				stopMove2 = false;

				if (Msg.GetModeID() == 1)
				{
					isTrack		 = false;
					TargetID	 = 0;
					SetMoveRate(0.0f);

					std::cout << "Vehicle " << mVehicleID << "RECEIVE ORDER DEASSIGNED" << std::endl;
				}
				else
				if (Msg.GetModeID() == 2)
				{
					isBTK		 = false;
					SetMoveRate(0.0f);

					std::cout << "Vehicle " << mVehicleID << "RECEIVE ORDER DEASSIGNED" << std::endl;
				}
				else
				if (Msg.GetModeID() == 3)
				{
					isAirShipTrack	 = false;
					TargetID	= 0;
					SetMoveRate(0.0f);

					std::cout << "Vehicle " << mVehicleID << "RECEIVE ORDER DEASSIGNED" << std::endl;
				}
			}
			break;

			//Fire
			case ORD_CANNON_F : 
			{
				/* New Explode */
				/* Send Explotion */
				std::string mDOFName;
				/*if ( mWeaponID == CT_CANNON_40 )  mDOFName = "DOF_Meriam40Missile";
				if ( mWeaponID == CT_CANNON_57 )  mDOFName = "DOF_Meriam57Missile";
				if ( mWeaponID == CT_CANNON_76 )  mDOFName = "DOF_Meriam76Missile";
				if ( mWeaponID == CT_CANNON_120 ) mDOFName = "DOF_Meriam120Missile";*/

				/*if ( mWeaponID == CT_CANNON_40 )  mDOFName = C_DOF_NAME_CAMERA_CANNON40_1;
				if ( mWeaponID == CT_CANNON_57 )  mDOFName = C_DOF_NAME_CAMERA_CANNON57_1;
				if ( mWeaponID == CT_CANNON_76 )  mDOFName = C_DOF_NAME_CAMERA_CANNON76_1;
				if ( mWeaponID == CT_CANNON_120 ) mDOFName = C_DOF_NAME_CAMERA_CANNON120_1;*/

				if ( mWeaponID == CT_CANNON_40 )  mDOFName = C_DOF_NAME_CAMERA_CANNON40_1; //"DOF_Meriam40smokefx";
				if ( mWeaponID == CT_CANNON_57 )  mDOFName = "DOF_Meriam57smokefx";
				if ( mWeaponID == CT_CANNON_76 )  mDOFName = "DOF_Meriam76smokefx";
				if ( mWeaponID == CT_CANNON_120 ) mDOFName = "DOF_Meriam120smokefx";

				osg::Node *spoutmodel = GetOSGNode();
				dtCore::RefPtr<dtUtil::NodeCollector> mtColector = new dtUtil::NodeCollector(spoutmodel, dtUtil::NodeCollector::DOFTransformFlag);
				dtCore::RefPtr<osgSim::DOFTransform> mDOFTran = mtColector->GetDOFTransform(mDOFName);
				if (mDOFTran != NULL)
				{
					osg::Vec3 vPos = GetDOFPositionAbsolute(mDOFTran);
					SendExplode(0,0,5, vPos);

					if ( GetGameActorProxy().GetGameManager()->GetMachineInfo().GetName() == C_MACHINE_SERVER )
					{
						static dtCore::Transform CannonSpoutTransform;
						static osg::Vec3 CannonSpoutPosition;
						float Heading ,Pitch ,Roll;

						GetTransform(CannonSpoutTransform);
						CannonSpoutTransform.GetTranslation(CannonSpoutPosition); 
						CannonSpoutTransform.GetRotation(Heading,Pitch,Roll);

						dtGame::GameManager* gm= GetGameActorProxy().GetGameManager();
						dtCore::RefPtr<MsgSetCannon> mess;
						dtGame::MessageFactory* mf=&gm->GetMessageFactory();
						mf->CreateMessage(*(mf->GetMessageTypeByName(C_MT_CANNON_EVENT)),mess);
						
						mess->SetVehicleID(mVehicleID);
						mess->SetWeaponID(mWeaponID);
						mess->SetLauncherID(mLauncherID);
						mess->SetMissileID(0);
						mess->SetMissileNum(0);
						mess->SetOrderID(ORD_CANNON_ADD_DATA);
						mess->SetAutoCorrectBearing(-Heading);
						mess->SetAutoCorrectElev(Pitch);
						mess->SetPosXValue(CannonSpoutPosition.x());
						mess->SetPosYValue(CannonSpoutPosition.y());
						mess->SetPosZValue(CannonSpoutPosition.z());

						gm->SendNetworkMessage(*mess);
						gm->SendMessage(*mess);
					}

				}
				else
					std::cout << "Can not Find DOF " << mDOFName << std::endl;
			}
			break; 

		}
	}
}

void CannonSpoutActor::SendExplode(const int ExplodeID, const int ExplodeType, const float ExplodeLife, const osg::Vec3 pos)
{
	dtGame::GameManager* gm= GetGameActorProxy().GetGameManager();
	dtCore::RefPtr<MsgUtilityAndTools> mess;
	dtGame::MessageFactory* mf=&gm->GetMessageFactory();
	mf->CreateMessage(*(mf->GetMessageTypeByName(C_MT_UTILITY_AND_TOOLS)),mess);
	mess->SetOrderID(TIPE_UTIL_SPOUT_EXPLODE);
	mess->SetUAT0(mWeaponID);
	mess->SetUAT1(ExplodeID);
	mess->SetUAT2(ExplodeType);  
	mess->SetUAT3(pos.x());
	mess->SetUAT4(pos.y());
	mess->SetUAT5(pos.z());
	gm->SendNetworkMessage(*mess);
	gm->SendMessage(*mess);
}

void CannonSpoutActor::TickLocal(const dtGame::Message &tickMessage)
{
	const dtGame::TickMessage &tick = static_cast<const dtGame::TickMessage&>(tickMessage);
	float deltaSimTime = tick.GetDeltaSimTime();

	mCounterRot += tick.GetDeltaSimTime();

	if (mCounterRot > 5.0f)
	{
		if ( isTrack == true )
		{
			ValidateElevation();
		}
		else
		if ( isBTK == true)
		{
			ValidateElevationForBTK();
		}
		else
		if ( isAirShipTrack == true )
		{
			ValidateElevationForAirTrack();
		}

		mCounterRot = 0;

	}

	if (!stopMove && !stopMove2) 
		SpoutMovement();
}


void CannonSpoutActor::ValidateElevation()
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

		mAbsolutStartAngle	= -ShipRotation.x() + GetStartAngle();
		mAbsolutStartAngle	= ValidateDegree(mAbsolutStartAngle); 

		mAbsolutEndAngle	= -ShipRotation.x() + GetEndAngle();
		mAbsolutEndAngle	= ValidateDegree(mAbsolutEndAngle);

		if (( mWeaponID == CT_CANNON_57 ) ||
			( mWeaponID == CT_CANNON_76 ))
		{

			if ( BalistikMode == 0)
			{
				//balistik low
				if (( DegComp_IsBeetwen( BearingTarget, mAbsolutStartAngle, mAbsolutEndAngle ) == true ) && 
					( RangeTarget < 15000))
				{
					isValid = true;
				}
			}
			else
			{
				//balistik high
				if (( DegComp_IsBeetwen( BearingTarget, mAbsolutStartAngle, mAbsolutEndAngle ) == true ) && 
					( RangeTarget < 15000) && ( RangeTarget > 6200 ) )
				{
					isValid = true;
				}
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
			CannonSpoutElevation();
		}
		else
		{
			//Outside
			std::cout << "Spout Cannon Failed To Tracking Object In Outside Area" << std::endl;
			isTrack = false;
		}	
	}
}

void CannonSpoutActor::ValidateElevationForBTK()
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
		BearingTarget = -ShipRotation.x() + mCorrBearing;

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
			CannonSpoutElevationForBTK();
			isBTK = false;
		}
		else
		{
			//Outside
			std::cout << "Spout Cannon Failed To Tracking Object In Outside Area" << std::endl;
			isBTK = false;
		}	
	}
}

void CannonSpoutActor::CannonSpoutElevation()
{
	static dtCore::Transform CannonSpoutTransform;
	static osg::Vec3 CannonSpoutPosition, CannonSpoutRotation;

	GetTransform(CannonSpoutTransform);
	CannonSpoutTransform.GetTranslation(CannonSpoutPosition);
	CannonSpoutTransform.GetRotation(CannonSpoutRotation);

	if (( mWeaponID == CT_CANNON_57 ) ||
		( mWeaponID == CT_CANNON_76 ))
	{
		if ( BalistikMode == 0 )
		{
			//Low Balisktik
			LauncherElev = trac.Gun_76Low_RangeToElev(RangeTarget) + mCorrElev;
		}
		else
		{
			//High Balistik
			LauncherElev = trac.Gun_76High_RangeToElev(RangeTarget) + mCorrElev;
		}
	}
	else
	if ( mWeaponID == CT_CANNON_40) 
	{
		LauncherElev = trac.Gun_40_RangeToElev(RangeTarget) + mCorrElev;
	}
	else
	if ( mWeaponID == CT_CANNON_120) 
	{
		LauncherElev = trac.Gun_120_RangeToElev(RangeTarget) + mCorrElev;
	}
	
	trac.SetElevation(LauncherElev); 

	CannonSpoutRotation[1]	= trac.GetElevation();

	CannonSpoutTransform.SetTranslation(CannonSpoutPosition);
	CannonSpoutTransform.SetRotation(CannonSpoutRotation);
	SetTransform(CannonSpoutTransform);
}

void CannonSpoutActor::ValidateElevationForAirTrack()
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
	else
	{
		std::cout << "Target Not valid" << std::endl;
		isAirShipTrack = false;
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
	else
	{
		std::cout << "Parent Not valid" << std::endl;
		isAirShipTrack = false;
	}

	if (( TargetProxy.valid() ) && ( parentProxy.valid() ))
	{
		BearingTarget = ComputeBearingTo2(ShipPosition.x(), ShipPosition.y(), TargetPosition.x(), TargetPosition.y());
		BearingTarget = BearingTarget + mCorrBearing;
		BearingTarget = ValidateDegree(BearingTarget);

		RangeTarget	  = Range3D(ShipPosition.x(), ShipPosition.y(), 0, TargetPosition.x(), TargetPosition.y(), 0);

		mAbsolutStartAngle	= -ShipRotation.x() + GetStartAngle();
		mAbsolutStartAngle	= ValidateDegree(mAbsolutStartAngle); 

		mAbsolutEndAngle	= -ShipRotation.x() + GetEndAngle();
		mAbsolutEndAngle	= ValidateDegree(mAbsolutEndAngle);

		std::cout << "Check Bearing and Range Target" << std::endl;
		std::cout << "Range : " << RangeTarget << " Bearing target : " << BearingTarget << std::endl;
		std::cout << "Start Angle : " << mAbsolutStartAngle << " End Angle : " << mAbsolutEndAngle << std::endl;

		if (( mWeaponID == CT_CANNON_57 ) ||
			( mWeaponID == CT_CANNON_76 ))
		{

			if ( BalistikMode == 0)
			{
				//balistik low
				if (( DegComp_IsBeetwen( BearingTarget, mAbsolutStartAngle, mAbsolutEndAngle ) == true ) && 
					( RangeTarget < 15000))
				{
					isValid = true;
				}
			}
			else
			{
				//balistik high
				if (( DegComp_IsBeetwen( BearingTarget, mAbsolutStartAngle, mAbsolutEndAngle ) == true ) && 
					( RangeTarget < 15000) && ( RangeTarget > 6200 ) )
				{
					isValid = true;
				}
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
			CannonSpoutElevationForAirTrack();
			isAirShipTrack = false;
		}
		else
		{
			std::cout << "Spout Cannon Failed To Tracking Object In Outside Area" << std::endl;
			isAirShipTrack = false;
		}
	}
}

void CannonSpoutActor::CannonSpoutElevationForAirTrack()
{
	double Elev;
	Elev = 0;

	if ( BalistikMode == 0)
	{
		Elev = trac.SearchLowAngel(RangeTarget, TargetPosition.z());
		
		if ( Elev >= 0)
		{
			LauncherElev = Elev + mCorrElev;
			CannonSpoutElevationForAirTrack();

			std::cout << "Spout Track Object At " << LauncherElev << std::endl;
		}
	}
	else
	{
		Elev = trac.SearchHighAngel(RangeTarget, TargetPosition.z());
		std::cout << "Spout Cannon Elev " << Elev << std::endl;
		if ( Elev >= 0)
		{
			LauncherElev = Elev + mCorrElev;
			CannonSpoutElevationForAirTrack();

			std::cout << "Spout Track Object At " << LauncherElev << std::endl;
		}
	}

	if (Elev > 0)
	{
		static dtCore::Transform CannonSpoutTransform;
		static osg::Vec3 CannonSpoutPosition, CannonSpoutRotation;

		GetTransform(CannonSpoutTransform);
		CannonSpoutTransform.GetTranslation(CannonSpoutPosition);
		CannonSpoutTransform.GetRotation(CannonSpoutRotation);

		trac.SetElevation(LauncherElev); 

		CannonSpoutRotation[1]	= trac.GetElevation();

		CannonSpoutTransform.SetTranslation(CannonSpoutPosition);
		CannonSpoutTransform.SetRotation(CannonSpoutRotation);
		SetTransform(CannonSpoutTransform);
	}
	else
	{
		std::cout << "Failed To Track Object" << std::endl;
	}

}

void CannonSpoutActor::CannonSpoutElevationForBTK()
{
	static dtCore::Transform CannonSpoutTransform;
	static osg::Vec3 CannonSpoutPosition, CannonSpoutRotation;

	GetTransform(CannonSpoutTransform);
	CannonSpoutTransform.GetTranslation(CannonSpoutPosition);
	CannonSpoutTransform.GetRotation(CannonSpoutRotation);

	LauncherElev = mCorrElev;

	trac.SetElevation(LauncherElev); 

	//std::cout << "Vehicle ID : " << mVehicleID << " Weapon ID : " << mWeaponID << " Elev : " << LauncherElev << std::endl;  

	CannonSpoutRotation[1]	= trac.GetElevation();

	CannonSpoutTransform.SetTranslation(CannonSpoutPosition);
	CannonSpoutTransform.SetRotation(CannonSpoutRotation);
	SetTransform(CannonSpoutTransform);
}

void CannonSpoutActor::TickRemote(const dtGame::Message &tickMessage)
{
	
}
void CannonSpoutActor::SetMoveRate(float rate)
{
	mRate = mRate + rate;
	if (mRate >= 90) mRate = 90.0;
	else if (mRate <= 0) mRate =0.0;
}

void CannonSpoutActor::SpoutMovement()
{
		
	osg::Vec3 xyz = GetGameActorProxy().GetRotation();

	//std::cout << "spout movement" <<std::endl;

	if (xyz.x() < mRate )
	{
		xyz.x() +=   0.1 ;
		if (xyz.x() >= mRate) 
		{
			stopMove = true;
			stopMove2 = true;
		}
	}
	else if (xyz.x() > mRate )
	{
		xyz.x() -=   0.1 ;
		if (xyz.x() <= mRate) 
		{
			stopMove = true;
			stopMove2 = true;
		}
	}
	else if (xyz.x() == mRate )
	{
		stopMove = true;
		stopMove2 = true;
	}
	
	GetGameActorProxy().SetRotation(xyz);
}

void CannonSpoutActor::SetIsUnlockToFire(bool val)
{
	isUnlockToFire = val;
}

void CannonSpoutActor::OnEnteredWorld()
{
	LauncherSpoutActor::OnEnteredWorld();
}

void CannonSpoutActor::OnRemovedFromWorld()
{
    RemoveSender(&(GetGameActorProxy().GetGameManager()->GetScene()));
}