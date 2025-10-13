#include "RBUspoutactor.h"
#include "shipactor.h" 
#include "didactorssources.h"

////////////////////////////////////////////////////////
RBUSpoutActorProxy::RBUSpoutActorProxy()
{
	SetClassName("RBU Spout");
}
RBUSpoutActorProxy::~RBUSpoutActorProxy(){}

void RBUSpoutActorProxy::BuildInvokables()
{
    LauncherSpoutActorProxy::BuildInvokables();
}

void RBUSpoutActorProxy::BuildPropertyMap()
{
	LauncherSpoutActorProxy::BuildPropertyMap(); 
}

void RBUSpoutActorProxy::OnEnteredWorld()
{
	LauncherSpoutActorProxy::OnEnteredWorld();
	RegisterForMessages(SimMessageType::RBU_EVENT);
}

////////////////////////////////////////////////////////////
RBUSpoutActor::RBUSpoutActor(dtGame::GameActorProxy &proxy)
:LauncherSpoutActor(proxy),mRate_UD(0),CorrectElev(0.0f),Elev(0),ndistance(0),stopMove_UD(true),stopMove_UD2(false)
{}

RBUSpoutActor::~RBUSpoutActor(){}
 
void RBUSpoutActor::TickLocal(const dtGame::Message &tickMessage)
{
	const dtGame::TickMessage &tick = static_cast<const dtGame::TickMessage&>(tickMessage);
	osg::Vec3 xyz = GetGameActorProxy().GetRotation();
	float deltaSimTime = tick.GetDeltaSimTime(); 
	//float temp;

	if (ORDER_AUTO_OR_MANUAL == ORD_RBU_ASSIGNED)
	{
		if (!stopMove_UD)
		{
			//if ((Elev<=90)) temp = (Elev-xyz.x()); // iki laopo yo ngene @Lupa@
			SetMoveRate_UD(Elev);
			MoveWeapon_UD();
		}
	}
	else if (ORDER_AUTO_OR_MANUAL == ORD_RBU_AUTO)
	{
		//if (!stopMove_UD)
		//{	
			static dtCore::Transform objectTransform;
			static osg::Vec3 objectPosition;
			static osg::Vec3 objectRotation;
			static dtCore::Transform ownShipTransform;
			static osg::Vec3 ownShipPosition;
			static osg::Vec3 ownShipRotation;

			//dtCore::RefPtr<dtDAL::ActorProxy> parentProxy = GetShipActorByID(TargetID);
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

			//dtCore::RefPtr<dtDAL::ActorProxy> pProxy = GetShipActorByID(ShipID);
			if ( pProxy.valid() )
			{
				dtCore::RefPtr<VehicleActor> parent = static_cast<VehicleActor*>(pProxy->GetActor());
				dtGame::GameActorProxy &pr = parent->GetGameActorProxy();
				parent->GetTransform(ownShipTransform);
				ownShipTransform.GetTranslation(ownShipPosition);
				ownShipTransform.GetRotation(ownShipRotation);
			}

			if (( pProxy.valid() ) && ( parentProxy.valid() )){

				ndistance = Range3D(ownShipPosition.x(), ownShipPosition.y(), 0, objectPosition.x(), objectPosition.y(), 0);

				static float tSpeed2;
				if (TipeID==Balistik1){
					tSpeed2 = 137;
					if ( ndistance < 500 ){
						ndistance = 500;
						hRange = 500;
					}
					else if ( ndistance > 1500){
						ndistance = 1500;
						hRange = 1500;
					}
				}
				else if (TipeID==Balistik2){
					tSpeed2 = 267;
					if ( ndistance < 1500 ){
						ndistance = 1500;
						hRange = 1500;
					}
					else if ( ndistance > 5500){
						ndistance = 5500;
						hRange = 5500;
					}
				}

				//Elev	  = InitElevation(ndistance);
				//Elev	  = Elev + CorrectElev ;

				tBearing = ComputeBearingTo2(ownShipPosition.x(),ownShipPosition.y(),objectPosition.x(),objectPosition.y());
				tRange = ComputeDistance(ownShipPosition.x(),ownShipPosition.y(), objectPosition.x(),objectPosition.y());

				CalcHitPredition(tRange,tBearing,tSpeed,tCourse,tSpeed2,hRange,hBearing,hTime);
				Elev = InitElevation(hRange);

				if (tempElev != Elev)
				{
					SetMoveRate_UD(Elev);
					MoveWeapon_UD();
				}
				//std::cout << "Range " << ndistance << " , Elevasi " <<Elev<<std::endl;
			}
		//}
	}
	else if (ORDER_AUTO_OR_MANUAL == ORD_RBU_LOADING)
	{
		if (!stopMove_UD)
		{
			SetMoveRate_UD(ElevLoading);
			MoveWeapon_UD();
		}
	}
	else if (ORDER_AUTO_OR_MANUAL == ORD_RBU_DEASSIGNED)
	{
		if (stopMove_UD2 == true)
			MoveWeapon_UD();
	}
}

void RBUSpoutActor::TickRemote(const dtGame::Message &tickMessage){} 

void RBUSpoutActor::ProcessMessage(const dtGame::Message &message)
{
	if(GetGameActorProxy().IsInGM()){

		if(message.GetMessageType().GetName() == SimMessageType::RBU_EVENT.GetName())
			ProcessOrderEvent(message);
	}
}

void RBUSpoutActor::ProcessOrderEvent(const dtGame::Message &message)
{
	const MsgSetRBU &Msg = static_cast<const MsgSetRBU&>(message);

	if (((int)Msg.GetVehicleID()	== mVehicleID	) && 
		((int)Msg.GetWeaponID()		== mWeaponID	) && 
		((int)Msg.GetLauncherID()	== mLauncherID	))
	{
		ORDER_AUTO_OR_MANUAL = Msg.GetOrderID();
		TipeID = Msg.GetMissileType();
		CorrectElev = Msg.GetCorrectElev();

		if (Msg.GetOrderID() == ORD_RBU_ASSIGNED)
		{
			ndistance	= Msg.GetTargetRange();
			if (TipeID==Balistik1)
			{
				if ( ndistance < 500 )
				{
					ndistance = 500;
					std::cout << "RBU set to minimum range Balistik1 caused Outside range" <<std::endl;
				}
				else if ( ndistance > 1500)
				{
					ndistance = 1500;
					std::cout << "RBU set to maximum range Balistik1 caused Outside range" <<std::endl;
				}

				stopMove_UD = false;
				Elev		= InitElevation(ndistance);
				//Elev		= Elev + CorrectElev;
			}
			else if (TipeID==Balistik2)
			{
				if ( ndistance < 1500 )
				{
					ndistance = 1500;
					std::cout << "RBU set to minimum range Balistik2 caused Outside range" <<std::endl;
				}
				else if ( ndistance > 5500)
				{
					ndistance = 5500;
					std::cout << "RBU set to maksimum range Balistik2 caused Outside range" <<std::endl;
				}

				stopMove_UD = false;
				Elev		= InitElevation(ndistance);
				//Elev		= Elev + CorrectElev;
			}
			
		}
		else if(Msg.GetOrderID() == ORD_RBU_LOADING){
			ElevLoading		= 90.0f;
			stopMove_UD = false;
		}
		else if(Msg.GetOrderID() == ORD_RBU_DEASSIGNED)
		{
			SetMoveRate_UD(0);
			stopMove_UD = true;
			stopMove_UD2 = true;
		}
		else if (Msg.GetOrderID() == ORD_RBU_AUTO)
		{
			TargetID	= Msg.GetTargetID();
			ShipID		= Msg.GetVehicleID();

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

			if (( pProxy.valid() ) && ( parentProxy.valid() ))
			{
				ndistance = Range3D(ownShipPosition.x(), ownShipPosition.y(), 0, objectPosition.x(), objectPosition.y(), 0);
				static float tSpeed2;

				if (TipeID==Balistik1)
				{
					tSpeed2 = 137;
					if ( ndistance < 500 )
					{
						ndistance = 500;
						hRange = 500;
						std::cout << "RBU set to minimum range Balistik1 caused Outside range" <<std::endl;
					}
					else if ( ndistance > 1500)
					{
						ndistance = 1500;
						hRange = 1500;
						std::cout << "RBU set to maximum range Balistik1 caused Outside range" <<std::endl;
					}
				}
				else if (TipeID==Balistik2)
				{
					tSpeed2 = 267;
					if ( ndistance < 1500 )
					{
						ndistance = 1500;
						hRange = 1500;
						std::cout << "RBU set to minimum range Balistik2 caused Outside range" <<std::endl;
					}
					else if ( ndistance > 5500)
					{
						ndistance = 5500;
						hRange = 5500;
						std::cout << "RBU set to maksimum range Balistik2 caused Outside range" <<std::endl;
					}
				}

				//Elev	  = InitElevation(ndistance);
				//Elev	  = Elev + CorrectElev ;

				tBearing = ComputeBearingTo2(ownShipPosition.x(),ownShipPosition.y(),objectPosition.x(),objectPosition.y());
				tRange = ComputeDistance(ownShipPosition.x(),ownShipPosition.y(), objectPosition.x(),objectPosition.y());

				CalcHitPredition(tRange,tBearing,tSpeed,tCourse,tSpeed2,hRange,hBearing,hTime);
				Elev = InitElevation(hRange);

				std::cout << "Range " << hRange << " , Elevasi " <<Elev<<std::endl;
			}
			stopMove_UD = false;
		}
	}
}

double RBUSpoutActor::InitElevation(double a)
{
	double dir;
	if (TipeID == Balistik1)
		dir = (0.0365 * a) - 9.75 ;
	else
		dir = (0.0091 * a) - 5.1875 ; 
	return dir;
};

void RBUSpoutActor::SetMoveRate_UD(float rate)
{
	mRate_UD = rate;
	if (mRate_UD >= 90) mRate_UD = 90.0;
	else if (mRate_UD <= -90.0) mRate_UD =-90.0;

	//if ((mRate_UD >= 45) && (ORDER_AUTO_OR_MANUAL != ORD_RBU_LOADING)) mRate_UD = 45.0;
	//else if ((mRate_UD <= 8.5) && (ORDER_AUTO_OR_MANUAL != ORD_RBU_LOADING)) mRate_UD =8.5;
}

void RBUSpoutActor::MoveWeapon_UD()
{
	osg::Vec3 xyz = GetGameActorProxy().GetRotation();

	if (xyz.x() < mRate_UD )
	{
		xyz.x() +=   0.5 ;
		if (xyz.x() >= mRate_UD) {
			stopMove_UD = true;
			stopMove_UD2 = false;
			xyz.x() = mRate_UD;
			tempElev = mRate_UD;
		}
	}
	else if (xyz.x() > mRate_UD )
	{
		xyz.x() -=   0.5 ;
		if (xyz.x() <= mRate_UD) {
			stopMove_UD = true;
			stopMove_UD2 = false;
			xyz.x() = mRate_UD;
			tempElev = mRate_UD;
		}
	}
	else if (xyz.x() == mRate_UD )
		stopMove_UD2 = false;

	xyz.y() = 0; 
	GetGameActorProxy().SetRotation(xyz);
}
 
void RBUSpoutActor::OnEnteredWorld()
{
	LauncherSpoutActor::OnEnteredWorld();
}

void RBUSpoutActor::OnRemovedFromWorld()
{
    RemoveSender(&(GetGameActorProxy().GetGameManager()->GetScene()));
}

void RBUSpoutActor::CalcHitPredition ( 
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


