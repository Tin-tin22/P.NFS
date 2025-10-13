#include "vehicleactor.h"
#include "../didCommon/BaseConstant.h"
#include "didactorssources.h"

///////////////////////////////////////////////////////
VehicleActorProxy::VehicleActorProxy(){}
VehicleActorProxy::~VehicleActorProxy(){}

void VehicleActorProxy::BuildPropertyMap()
{
	dtGame::GameActorProxy::BuildPropertyMap();

	VehicleActor &vas = static_cast<VehicleActor&>(GetGameActor());
	VehicleActor* va = NULL;
	GetActor(va);

	/*AddProperty(new dtDAL::EnumActorProperty<VehicleActor::CoordSys>("CoordinateSystem", "CoordinateSystem",
	   dtUtil::MakeFunctor(&VehicleActor::SetCoordSys, vas),
	   dtUtil::MakeFunctor(&VehicleActor::GetCoordSys, vas),
	   "Sets the coordinate system"));*/

	AddProperty(new dtDAL::IntActorProperty(C_SET_VID, C_SET_VID, 
	   dtDAL::IntActorProperty::SetFuncType(va, &VehicleActor::SetVehicleID), 
	   dtDAL::IntActorProperty::GetFuncType(va, &VehicleActor::GetVehicleID), 
	   "Sets Vehicle Id"));
}

void VehicleActorProxy::BuildInvokables()
{
	dtGame::GameActorProxy::BuildInvokables();
}

dtDAL::ActorProxyIcon* VehicleActorProxy::GetBillBoardIcon()
{
	if(!mBillBoardIcon.valid())
	{
		mBillBoardIcon = new dtDAL::ActorProxyIcon(dtDAL::ActorProxyIcon::IMAGE_BILLBOARD_STATICMESH);
	}
	return mBillBoardIcon.get();
}

///////////////////////////////////////////////////////
IMPLEMENT_ENUM(VehicleActor::CoordSys);
VehicleActor::CoordSys VehicleActor::CoordSys::SYS_ABS("ABS");
VehicleActor::CoordSys VehicleActor::CoordSys::SYS_REL("REL");

VehicleActor::VehicleActor(dtGame::GameActorProxy &proxy) : 
	dtGame::GameActor(proxy), 
	mEngineRunning(true),
	mIsNight(false),
	rudderSwingRate(2.0f),
	throttle(0.0f),
	throttleRate(3.0f),
	speed(0.0f),
	damage(0),
	rudderAngle(0.0f),
	VerEffRudderAngle(.0f),
	VerRudderAngle(0.0f),
	VerDesiredRudderAngle(0.0f) ,
	addAngle(0.0f),
	maxAheadSpeed(500.0f), // kebutuhan aircraft [10/1/2012 DID RKT2]
	maxAsternSpeed(-20.0f),
	desiredRudderAngle(0.0f),
	desiredThrottle(0.0f),
	effRudderAngle(0.0f),
	course(0.0f),
	displacement(2300.0f),
	heelFactor(0.5f),
	heel(0.0f),
	maxRudderAngle(37.0f),
	shaftHP(100000.0f),
	tacticalDiameter(1000.0f),
	position(0.0f, 0.0f, 100.0f),
	trim(0.0f),
	trimFactor(0.5f), 
	desiredAddAngle(0.0f),
	modeGuidance (0),
	modeAltitude (0),
	deltaTime(0.0f),
	lastSpeed(0.0f),
	IsGetLastSpeed(false),
	IsGetLastSpeed2(false),
	IsUpdateSpeed(false),
	mInitSwitchTarget(false),
	mCoordSys(&VehicleActor::CoordSys::SYS_REL)
{}

VehicleActor::~VehicleActor(){}

float VehicleActor::GetAdjustedTacticalPitch()
{
	float adjTacDia = .0f;
	float absSpeed = fabs(speed);

	//check for sufficient water flow over rudder
	if (absSpeed < 3.0f)
		return 30000.0f;

	float factor = (15.0f / absSpeed) * fabs(VerEffRudderAngle);

	adjTacDia = (tacticalDiameter * 15.0f * factor) / (factor * factor);

	if (adjTacDia > 30000.0f)
		adjTacDia = 30000.0f;

	return adjTacDia;
}

float VehicleActor::GetAdjustedTacticalDiameter()
{
	float adjTacDia = .0f;
	adjTacDia = 1.0f * (( speed * speed ) + ( 100.0f / sin(osg::DegreesToRadians(fabs(effRudderAngle))))) ;
	return adjTacDia;
}

void VehicleActor::MoveVehicle(double deltaTime)
{
	if(mEngineRunning)
	{
		dtCore::Transform tempPos;
		GetTransform(tempPos);
		SetPosition(tempPos);
		Update(deltaTime);
		SetModelPosition();
	}
}

void VehicleActor::SetModelPosition()
{
	dtCore::Transform tempPos;
	dtCore::Transform newPos = GetPosition();

	float speedOffset = 3.5f * GetSpeed() / GetMaxAheadSpeed();
	newPos = GetPosition();
	SetTransform(newPos, *mCoordSys == VehicleActor::CoordSys::SYS_ABS ? ABS_CS : REL_CS);
}

void VehicleActor::UpdatePitch(float elapsedTime)
{
	if (VerEffRudderAngle != 0.0f)
	{
		float deltaPitch = (360.0f * (speed * yardsPerNM / secsPerHour))
			/ (GetAdjustedTacticalPitch() * osg::PI) * elapsedTime;

		if (VerEffRudderAngle > 0.0f)
			pitch += deltaPitch;
		else
			pitch -= deltaPitch;
	}

	//keep in range: 0 <= pitch < 45.0f
	while (pitch >= 360.0f)
		pitch -= 360.0f;

	while (pitch < .0f)
		pitch += 360.0f;

	//std::cout << VerEffRudderAngle << " , " << pitch << std::endl;
}

void VehicleActor::UpdateVerRudder(float elapsedTime)
{
	//update actual rudder angle
	if (VerRudderAngle != VerDesiredRudderAngle)
	{
		//handle right rudder order
		if (VerDesiredRudderAngle > 0.0f)
		{

			//check actual and desired rudder are in same direction
			if (VerRudderAngle > 0.0f)
			{

				//rudder needs to go farther right
				if (VerDesiredRudderAngle - VerRudderAngle > 0.0f)
				{
					VerRudderAngle += rudderSwingRate * elapsedTime;
					if (VerRudderAngle > VerDesiredRudderAngle)
						VerRudderAngle = VerDesiredRudderAngle;
				}

				//rudder too far right
				else
				{
					VerRudderAngle -= rudderSwingRate * elapsedTime;
					if (VerRudderAngle < VerDesiredRudderAngle)
						VerRudderAngle = VerDesiredRudderAngle;
				}
			}

			//handle actual and desired rudder in opposite directions
			else
			{
				VerRudderAngle += rudderSwingRate * elapsedTime;
				if (VerRudderAngle > VerDesiredRudderAngle)
					VerRudderAngle = VerDesiredRudderAngle;
			}
		}

		//handle left rudder order
		else if (VerDesiredRudderAngle < 0.0f)
		{

			//check actual and desired rudder are in same direction
			if (VerRudderAngle < 0.0f)
			{

				//rudder needs to go farther left
				if (VerDesiredRudderAngle - VerRudderAngle < 0.0f)
				{
					VerRudderAngle -= rudderSwingRate * elapsedTime;
					if (VerRudderAngle < VerDesiredRudderAngle)
						VerRudderAngle = VerDesiredRudderAngle;
				}

				//rudder too far left
				else
				{
					VerRudderAngle += rudderSwingRate * elapsedTime;
					if (VerRudderAngle > VerDesiredRudderAngle)
						VerRudderAngle = VerDesiredRudderAngle;
				}
			}

			//handle actual and desired rudder in opposite directions
			else
			{
				VerRudderAngle -= rudderSwingRate * elapsedTime;
				if (VerRudderAngle < VerDesiredRudderAngle)
					VerRudderAngle = VerDesiredRudderAngle;
			}
		}

		//handle rudder amidship order
		else 
		{
			if (VerRudderAngle > 0.0f)
			{
				VerRudderAngle -= rudderSwingRate * elapsedTime;
				if (VerRudderAngle < VerDesiredRudderAngle)
					VerRudderAngle = VerDesiredRudderAngle;
			}
			else
			{
				VerRudderAngle += rudderSwingRate * elapsedTime;
				if (VerRudderAngle > VerDesiredRudderAngle)
					VerRudderAngle = VerDesiredRudderAngle;
			}
		}
	}
}

void VehicleActor::UpdateVerEffRudderAndTrim(float elapsedTime)
{
	//update effective rudder angle
	if (VerRudderAngle > VerEffRudderAngle)
	{
		VerEffRudderAngle += (abs(VerRudderAngle - VerEffRudderAngle)) 
			/ log(displacement) * elapsedTime;
	}
	else if (VerRudderAngle < VerEffRudderAngle)
	{
		VerEffRudderAngle -= (abs(VerRudderAngle - VerEffRudderAngle)) 
			/ log(displacement) * elapsedTime;
	}

	trim = abs(VerEffRudderAngle) * (speed / maxAheadSpeed) * trimFactor;

	//heel to side opposite the turn
	if (VerEffRudderAngle < 0.0f)
		trim *= -1.0f;
}

void VehicleActor::UpdateRudder(float elapsedTime)
{
	//update actual rudder angle
	if (rudderAngle != desiredRudderAngle)
	{
		//rudder needs to go farther right
		if (desiredRudderAngle > rudderAngle )
		{
			rudderAngle += rudderSwingRate * elapsedTime;
			if (rudderAngle > desiredRudderAngle)
				rudderAngle = desiredRudderAngle;
		}

		//rudder too far right
		else
		{
			rudderAngle -= rudderSwingRate * elapsedTime;
			if (rudderAngle < desiredRudderAngle)
				rudderAngle = desiredRudderAngle;
		}
	}
}

void VehicleActor::UpdateAddAngle(float elapsedTime)
{
	//update actual rudder angle
	if (addAngle != desiredAddAngle)
	{
		//rudder needs to go farther right
		if (desiredAddAngle > addAngle )
		{
			addAngle += rudderSwingRate * elapsedTime;
			if (addAngle > desiredAddAngle)
				addAngle = desiredAddAngle;
		}

		//rudder too far right
		else
		{
			addAngle -= rudderSwingRate * elapsedTime;
			if (addAngle < desiredAddAngle)
				addAngle = desiredAddAngle;
		}
	}
}

void VehicleActor::UpdateThrottle(float elapsedTime)
{
	if (desiredThrottle != throttle)
	{
		if (desiredThrottle > throttle)
		{
			throttle += throttleRate * elapsedTime;
			if (throttle > desiredThrottle)
				throttle = desiredThrottle;
		}
		else
		{
			throttle -= throttleRate * elapsedTime;
			if (throttle < desiredThrottle)
				throttle = desiredThrottle; 
		}
	}
}

void VehicleActor::UpdateSpeed(float elapsedTime)
{
	//if ( IsGetLastSpeed )
	//{
	//	lastSpeed = speed ;
	//	lastSpeed2 = fabs(lastSpeed);
	//	//deltaTime = 0.0f ;
	//	xtime = 0.0f;
	//	IsGetLastSpeed = false ;
	//	IsGetLastSpeed2 = true ;
	//	IsUpdateSpeed = true ;
	//	isStepOne = true;
	//}

	//if ( IsUpdateSpeed )
	//{
	//	if ( (lastSpeed >= 0) && (desiredThrottle > lastSpeed) )
	//		Acceleration_GoForward(elapsedTime);
	//	if ( (lastSpeed <= 0) && (desiredThrottle < lastSpeed) )
	//		Acceleration_GoBack(elapsedTime);
	//	if ( (lastSpeed > 0) && (desiredThrottle < lastSpeed) && (desiredThrottle >= 0))
	//		Deceleration_GoForward(elapsedTime);
	//	if ( (lastSpeed < 0) && (desiredThrottle > lastSpeed) && (desiredThrottle <= 0))
	//		Deceleration_GoBack2(elapsedTime);
	//	if ( (lastSpeed < 0) && (desiredThrottle > 0))
	//	{
	//		if (speed < 0)
	//			Deceleration_GoBack2(elapsedTime);
	//		else{
	//			//deltaTime = 0;
	//			Acceleration_GoForward(elapsedTime);
	//		}
	//	}
	//	if ( (lastSpeed > 0) && (desiredThrottle < 0))
	//	{
	//		if (speed > 0)
	//			Deceleration_GoForward(elapsedTime);
	//		else{
	//			//deltaTime = 0;
	//			Acceleration_GoBack(elapsedTime);
	//		}
	//	}
	//}

	speed += (throttle - speed - ( speed * fabs(rudderAngle + addAngle)* fabs(VerRudderAngle)  * 0.005f)) * 0.09f * elapsedTime; 
}

void VehicleActor::UpdateEffRudderAndHeel(float elapsedTime)
{
	if ((rudderAngle + addAngle) > effRudderAngle)
	{
		effRudderAngle += (abs((rudderAngle + addAngle) - effRudderAngle)) 
			/ log(displacement) * elapsedTime;
	}
	else if ((rudderAngle + addAngle) < effRudderAngle)
	{
		effRudderAngle -= (abs((rudderAngle + addAngle) - effRudderAngle)) 
			/ log(displacement) * elapsedTime;
	}

	if (speed > 0.0f)
	{
		heel = abs(effRudderAngle) * (speed / maxAheadSpeed) * heelFactor;

		//heel to side opposite the turn
		if (effRudderAngle < 0.0f)
			heel *= -1.0f;
	}
	else
	{
		heel = abs(effRudderAngle) * (speed / maxAheadSpeed) * heelFactor;

		//heel to side opposite the turn
		if (effRudderAngle < 0.0f)
			heel *= -1.0f;
	}
}

void VehicleActor::UpdateCourse(float elapsedTime)
{
	if (modeGuidance == 1) //StraightLine
	{
		float adjTacDia = 1.0f * (( speed * speed ) + ( 100.0f / sin(osg::DegreesToRadians(fabs(15.0f))))) ;
		float rateStraightLine = (360.0f * (speed * yardsPerNM / secsPerHour)) / (adjTacDia * osg::PI) * elapsedTime;

		if (desiredRudderAngle < course){
			float dev = fabs(course-desiredRudderAngle);
			if (dev > 180.0f){
				course += rateStraightLine;
				if (dev < 180)
					course = desiredRudderAngle;
			}
			else{
				course -= rateStraightLine;
				if (course <= desiredRudderAngle)
					course = desiredRudderAngle;
			}
		}
		else {
			float dev = fabs(course-desiredRudderAngle);
			if (dev > 180.0f){
				course -= rateStraightLine;
				if (dev < 180)
					course = desiredRudderAngle;
			}
			else{
				course += rateStraightLine;
				if (course >= desiredRudderAngle) //bagaimana jika desired rudderangle 0/360?
					course = desiredRudderAngle;
			}
		}

		//keep in range: 0 <= course < 360.0f
		while (course >= 360.0f)
			course -= 360.0f;

		while (course < .0f)
			course += 360.0f;
	}
	else
		if (modeGuidance == 2) //Helm
		{
			if (effRudderAngle != 0.0f)
			{
				float deltaCourse = (360.0f * (speed * yardsPerNM / secsPerHour))
					/ (GetAdjustedTacticalDiameter() * osg::PI) * elapsedTime;

				if (effRudderAngle > 0.0f)
					course += deltaCourse;
				else
					course -= deltaCourse;

				//keep in range: 0 <= course < 360.0f
				while (course >= 360.0f)
					course -= 360.0f;

				while (course < .0f)
					course += 360.0f;
			}
		}
	else
		if (modeGuidance == 3) //Waypoint
		{
			double waypoint[3][2] = {
				{-9430.67, 36871}, {-7473.1, 36621.8}, {-8164.62, 35848}
			};

			dtCore::Transform temppos;
			osg::Vec3 pos;
			GetTransform(temppos);
			temppos.GetTranslation(pos);

			static int i = 0;
			static int j = 1;

			float newbearing =  ComputeBearingTo2(pos.x(), pos.y(), waypoint[i][0], waypoint[i][1]);
			newbearing = ValidateDegree(newbearing);

			desiredRudderAngle = newbearing;

			float adjTacDia = 1.0f * (( speed * speed ) + ( 100.0f / sin(osg::DegreesToRadians(fabs(15.0f))))) ;
			float rateStraightLine = (360.0f * (speed * yardsPerNM / secsPerHour)) / (adjTacDia * osg::PI) * elapsedTime;

			if (desiredRudderAngle < course){
				float dev = fabs(course-desiredRudderAngle);
				if (dev > 180.0f){
					course += rateStraightLine;
					if (dev < 180){
						course = desiredRudderAngle;
						//i++;
						//j++;
					}
				}
				else{
					course -= rateStraightLine;
					if (course <= desiredRudderAngle){
						course = desiredRudderAngle;
						//i++;
						//j++;
					}
				}
			}
			else {
				float dev = fabs(course-desiredRudderAngle);
				if (dev > 180.0f){
					course -= rateStraightLine;
					if (dev < 180){
						course = desiredRudderAngle;
						//i++;
						//j++;
					}
				}
				else{
					course += rateStraightLine;
					if (course >= desiredRudderAngle){ //bagaimana jika desired rudderangle 0/360?
						course = desiredRudderAngle;
						//i++;
						//j++;
					}
				}
			}

			float range = ComputeDistance(pos.x(), pos.y(), waypoint[i][0], waypoint[i][1]);
			if (range < 100){
				i++;
			}

			std::cout << newbearing << ", " << range << ", "<< waypoint[i][0] << ", " << waypoint[i][1] << std::endl;

			//keep in range: 0 <= course < 360.0f
			while (course >= 360.0f)
				course -= 360.0f;

			while (course < .0f)
				course += 360.0f;

		}

}

void VehicleActor::UpdatePosition(float elapsedTime)
{
	float x,y,z,h,p,r;
	float p51Bearing = ConvertTodtCoreBearing(course);
	float p51Pitch = ConvertTodtCoreBearing(pitch); //pitch;//
	float distance = speed * metersPerKnotPerSecond * elapsedTime;

	position.Get(x, y, z, h, p, r);

	position.Set(
		x -= distance * sinf(osg::DegreesToRadians(p51Bearing))* cosf(osg::DegreesToRadians(p51Pitch)),
		y += distance * cosf(osg::DegreesToRadians(p51Bearing))* cosf(osg::DegreesToRadians(p51Pitch)),
		z += distance * sinf(osg::DegreesToRadians(p51Pitch)),
		p51Bearing,
		p51Pitch,
		heel);   
}

void VehicleActor::Update(float elapsedTime)
{
	UpdateRudder(elapsedTime);
	UpdateAddAngle(elapsedTime);    
	UpdateVerRudder(elapsedTime);
	UpdateThrottle(elapsedTime);
	UpdateSpeed(elapsedTime);
	UpdateEffRudderAndHeel(elapsedTime);
	UpdateVerEffRudderAndTrim(elapsedTime);
	UpdateCourse(elapsedTime);
	UpdatePitch(elapsedTime);
	UpdatePosition(elapsedTime);
}

void VehicleActor::UpdateStatusTargetSwitch( const int idxSwitch, const std::string sts, const osg::Vec3 vpos, const int Lethality)
{
	if ( GetGameActorProxy().GetGameManager()->GetMachineInfo().GetName() == C_MACHINE_SERVER )
	{
		dtCore::RefPtr<MsgOrder> msgSwitch;

		dtGame::GameManager* gm= GetGameActorProxy().GetGameManager();
		dtGame::MessageFactory* mf=&gm->GetMessageFactory();
		mf->CreateMessage(*(mf->GetMessageTypeByName(C_MT_ORDER_EVENT)),msgSwitch);

		msgSwitch->SetVehicleID(GetVehicleID());
		msgSwitch->SetOrderID(ORD_SWITCH_TARGET);
		msgSwitch->SetFloatValue(idxSwitch); 
		msgSwitch->SetStringValue(sts); 
		msgSwitch->SetFloatValue1(vpos.x());
		msgSwitch->SetFloatValue2(vpos.y());
		msgSwitch->SetFloatValue3(vpos.z());
		msgSwitch->SetLethality(Lethality);
		GetGameActorProxy().GetGameManager()->SendNetworkMessage(*msgSwitch);
		GetGameActorProxy().GetGameManager()->SendMessage(*msgSwitch);
		std::cout<<GetName()<<" send status  3D Switch"<<std::endl;
		std::cout << "Vpos : " << vpos << std::endl;

	}
}

void VehicleActor::SetVerDesiredRudderAngle(float rudder)
{
	if (rudder > maxRudderAngle)
		VerDesiredRudderAngle = maxRudderAngle;
	else if (rudder < (-1 * maxRudderAngle))
		VerDesiredRudderAngle = -1 * maxRudderAngle;
	else
		VerDesiredRudderAngle = rudder;
}

void VehicleActor::SetDesiredThrottlePosition(float desiredSpeed)
{
	if (desiredSpeed < maxAheadSpeed)
	{
		if (desiredSpeed > maxAsternSpeed)
			desiredThrottle = desiredSpeed;
		else
			desiredThrottle = maxAsternSpeed;
	}
	else
		desiredThrottle = maxAheadSpeed;
}

void VehicleActor::SetDesiredRudderAngle(float rudder)
{
	if (modeGuidance == 1)
	{
		while (rudder >= 360.0f)
			rudder -= 360.0f;

		while (rudder < .0f)
			rudder += 360.0f;

		desiredRudderAngle = rudder;
	}
	else
	{
		if (rudder > maxRudderAngle)
			desiredRudderAngle = maxRudderAngle;
		else if (rudder < (-1 * maxRudderAngle))
			desiredRudderAngle = -1 * maxRudderAngle;
		else
			desiredRudderAngle = rudder;
	}
}

void VehicleActor::SetSpeed(float spd)
{
	if (spd < maxAheadSpeed)
	{
		if (spd > maxAsternSpeed)
			speed = spd;
		else
			speed = maxAsternSpeed;
	}
	else
		speed = maxAheadSpeed;

	//desiredThrottle = speed; // komen dulu buat updatespeed [6/21/2013 DID RKT2]
	throttle = speed;
}

void VehicleActor::SetCourse(float crs)
{
	VerifyBearingWithinBounds(crs);

	desiredRudderAngle = .0f;
	rudderAngle = .0f;
	course = crs;
}

void VehicleActorProxy::OnEnteredWorld()
{
	dtGame::GameActorProxy::OnEnteredWorld();
}

void VehicleActor::CeckDataCollision()
{
	while(!mCollisionData.empty())
	{
		float nx, ny ;
		//, nz;
		if(mCollisionData.back().mBodies[0]== this)
		{
			nx= mCollisionData.back().mNormal[0];
			ny= mCollisionData.back().mNormal[1];
			//nz= mCollisionData.back().mNormal[2];
			UpdateStatusSoundCollision(ORD_SND_COLLISION,ORD_SND_COLLISION_ON);
		}
		else if(mCollisionData.back().mBodies[1]== this)
		{
			nx= -mCollisionData.back().mNormal[0];
			ny= -mCollisionData.back().mNormal[1];
			//nz= -mCollisionData.back().mNormal[2];
			UpdateStatusSoundCollision(ORD_SND_COLLISION,ORD_SND_COLLISION_ON);
		}
		else
		{
			std::cout<<"I didn't hit anybody!"<<std::endl;
			mCollisionData.pop_back();
			UpdateStatusSoundCollision(ORD_SND_COLLISION,ORD_SND_COLLISION_OFF);
			continue;
		}

		dtCore::Transform t;
		GetTransform(t);
		float x, y, z;
		t.GetTranslation(x, y, z);
		x+= nx * mCollisionData.back().mDepth;
		y+= ny * mCollisionData.back().mDepth;
		//z+= nz * mCollisionData.back().mDepth; 
		// gak usah naik turun..
		z = 0 ;
		t.SetTranslation(x, y, z);
		SetTransform(t);
		mCollisionData.pop_back();
		//if server send to clients
		if (GetGameActorProxy().GetGameManager()->GetMachineInfo().GetName()== C_MACHINE_SERVER )
		{
			dtCore::RefPtr<dtGame::ActorUpdateMessage> ActUpdate = static_cast<dtGame::ActorUpdateMessage*>
				(GetGameActorProxy().GetGameManager()->GetMessageFactory().CreateMessage(dtGame::MessageType::INFO_ACTOR_UPDATED).get());
			if ( ActUpdate != NULL )
			{
				GetGameActorProxy().PopulateActorUpdate(*ActUpdate);
				GetGameActorProxy().GetGameManager()->SendNetworkMessage(*ActUpdate);
			}
		}
	}
}

void VehicleActor::UpdateStatusSoundCollision(int OrderID, int mValue )
{
	dtGame::GameManager* gm=GetGameActorProxy().GetGameManager();
	std::string komp = gm->GetMachineInfo().GetName();
	if ( komp == C_MACHINE_SERVER )
	{
		dtCore::RefPtr<MsgOrder> mess;
		dtGame::MessageFactory* mf=&gm->GetMessageFactory();
		mf->CreateMessage(*(mf->GetMessageTypeByName(C_MT_ORDER_EVENT)),mess);
		mess->SetVehicleID(GetVehicleID());
		mess->SetOrderID(ORD_SND_COLLISION);
		mess->SetFloatValue(mValue);
		gm->SendNetworkMessage(*mess);
		gm->SendMessage(*mess);
	}
}

void VehicleActor::SetStackSound(dtAudio::Sound *tStackSound, dtCore::Transform tStackSoundPosition)
{
	stackSound = tStackSound;
	stackSoundPosition = tStackSoundPosition;
	stackSound->SetTransform(tStackSoundPosition,dtCore::Transformable::REL_CS);
	stackSound->SetMaxDistance(1000.0f);
	stackSound->SetLooping(true);
	stackSound->Play();
}

void VehicleActor::FreeSound(dtAudio::Sound *tmpSound)
{
	if ( tmpSound != NULL){
		tmpSound->Stop();
		dtAudio::AudioManager::GetInstance().FreeSound( *&tmpSound );
		tmpSound = NULL;
	}
}

void VehicleActor::PlayStackSound()
{
	if(stackSound != NULL)
		stackSound->Play();
}

void VehicleActor::StopStackSound()
{
	if(stackSound != NULL)
		stackSound->Stop();
}

void VehicleActor::InitTargetSwitch()
{
	dtCore::RefPtr<dtUtil::NodeCollector> collector = new dtUtil::NodeCollector(GetOSGNode(), dtUtil::NodeCollector::SwitchFlag);
	targetswitches = collector->GetSwitch("HitSwitch");
	if (targetswitches.get() )
	{
		std::cout<<"   ** "<<GetName()<<" Missile Target Switch initializing..."<<std::endl;

		osg::Switch *sw = targetswitches.get() ;
		sw->setAllChildrenOff();	 
		/// normal hit switch
		targetswitches->setValue(0,true);
	}
	else
		std::cout<<"   ** "<<GetName()<<" Missile Target Switch not initializing..."<<std::endl;
}

void VehicleActor::ShipHitByPosition(osg::Vec3 pos, int Lethality )
{
	if (targetswitches.get() )
	{
		std::cout<<"   ** "<<GetName()<<" Target Switch initializing..."<<std::endl;

		osg::Switch *sw = targetswitches.get() ;
		osg::Vec3 vPos;
		unsigned indexFound = 0 ;

		float dist = 50000.0f ;

		// i = IDX_STGT_HitDpn_1 starting from index ke 2, Depan ke Belakang, Ignore Normal and Heavy
		for (unsigned i = 2; i < sw->getNumChildren(); ++i)
		{
			osg::Node* childNode = sw->getChild(i);
			if (childNode)
			{
				vPos = GetNodePositionAbsolute(childNode);
				vPos[2] = pos[2];
					
				/*std::cout << " Hit Position " << pos << std::endl;
				std::cout << " Child Node " << vPos << std::endl;*/

				float temp = CalculateVec3Distance(pos,vPos);
				if ( temp < dist )
				{
					dist = temp ;
					indexFound = i ;
					//break ;
				}
			}

		}

		if ( indexFound > 0 )
		{
			//sw->setAllChildrenOff();
			std::cout << "indexFound : " << indexFound << std::endl;
			UpdateStatusTargetSwitch(indexFound,"true",vPos,Lethality);
		}
	}
}

void VehicleActor::Acceleration_GoForward(float elapsedTime)
{
	static double deltaTime(0.0f);
	deltaTime += elapsedTime;
	static bool isprint(true);
	if (deltaTime <= 9){
		//cari x/time ketika lastspeed
		static double xtime = (-3.820 * pow(lastSpeed,2)) + (20.75*lastSpeed) + 0.006;
		//cari v ketika x/time
		speed = ((0.00054 * pow(deltaTime,2)) + (0.04780*deltaTime) - 0.0005) * 2 ;
		xtime+=elapsedTime;
		IsGetLastSpeed2 = true;
	}
	else{
		static double xtime(0.0f);
		if (IsGetLastSpeed2){
			lastSpeed = speed;
			IsGetLastSpeed2 = false;
			double log_xtime = ( log(2.718281828459045235) * (lastSpeed+8.984)) / 4.305;
			//cari x/time ketika lastspeed
			xtime = pow( 2.718281828459045235,log_xtime );
		}
		//cari v ketika x/time
		speed = (4.305 * ( log(xtime) / log(2.718281828459045235) ) - 8.984) * 2 ;
		if (isprint){
			//std::cout << "lastspeed : " << lastSpeed <<  ", xtime : " << xtime  <<  ", v : " << speed << std::endl;
			isprint = false;
		}
		//dt dimulai dari x/time
		xtime += elapsedTime;
	}
	if (speed >= desiredThrottle ){
		speed = desiredThrottle;
		isprint = true;
		IsUpdateSpeed = false;
		deltaTime = 0;
	}
	//std::cout << "percepatan1 --> t : " << deltaTime <<  ", v : " << speed  << ", desiredThrottle : " << desiredThrottle << std::endl;
}

void VehicleActor::Acceleration_GoBack(float elapsedTime)
{
	static double deltaTime(0.0f);
	deltaTime += elapsedTime;
	static bool isprint(true);
	if (deltaTime <= 9){
		//cari x/time ketika lastspeed
		static double xtime = (3.820 * pow(lastSpeed,2)) - (20.75*lastSpeed) - 0.006;
		//cari v ketika x/time
		speed = (-0.00054 * pow(deltaTime,2)) - (0.04780*deltaTime) + 0.0005;
		xtime+=elapsedTime;
		IsGetLastSpeed2 = true;
	}
	else
	{
		static double xtime(0.0f);
		if (IsGetLastSpeed2){
			lastSpeed = speed;
			IsGetLastSpeed2 = false;
			//cari x/time ketika lastspeed
			double log_xtime = ( log(2.718281828459045235) * (lastSpeed-8.984)) / (-4.305);
			//cari x/time ketika lastspeed
			xtime = pow( 2.718281828459045235,log_xtime );
		}
		//cari v ketika x/time
		speed = -4.305 * ( log(xtime) / log(2.718281828459045235) ) + 8.984;
		if (isprint){
			//std::cout << "lastspeed : " << lastSpeed <<  ", xtime : " << xtime  <<  ", v : " << speed << std::endl;
			isprint = false;
		}
		//dt dimulai dari x/time
		xtime += elapsedTime;
	}
	if (speed <= desiredThrottle ){
		speed = desiredThrottle;
		isprint = true;
		IsUpdateSpeed = false;
		deltaTime = 0;
	}
	//std::cout << "percepatan2 --> t : " << deltaTime <<  ", v : " << speed  << std::endl;
}

void VehicleActor::Deceleration_GoForward(float elapsedTime)
{
	static double xtime(0.0f);
	if (IsGetLastSpeed2){
		lastSpeed = speed;
		IsGetLastSpeed2 = false;
		//cari x/time ketika lastspeed
		double log_xtime = ( log(2.718281828459045235) * (lastSpeed-29.984)) / (-4.305);
		//cari x/time ketika lastspeed
		xtime = pow( 2.718281828459045235,log_xtime );
	}
	//cari v ketika x/time
	speed = -4.305 * ( log(xtime) / log(2.718281828459045235) ) + 29.984 ;
	static bool isprint(true);
	if (isprint){
		//std::cout << "lastspeed : " << lastSpeed <<  ", xtime : " << xtime  <<  ", v : " << speed << std::endl;
		isprint = false;
	}
	if (speed <= desiredThrottle ){
		speed = desiredThrottle;
		isprint = true;
		IsUpdateSpeed = false;
	}
	//std::cout << "perlambatan1 --> t : " << xtime <<  ", v : " << speed  << std::endl;
	//dt dimulai dari x/time
	xtime += elapsedTime;
}

void VehicleActor::Deceleration_GoBack(float elapsedTime)
{
	static double xtime(0.0f);
	if (IsGetLastSpeed2){
		lastSpeed = speed;
		IsGetLastSpeed2 = false;
		//cari x/time ketika lastspeed
		double log_xtime = ( log(2.718281828459045235) * (lastSpeed+29.984)) / 4.305;
		//cari x/time ketika lastspeed
		xtime = pow( 2.718281828459045235,log_xtime );
	}
	//cari v ketika x/time
	speed = 4.305 * ( log(xtime) / log(2.718281828459045235) ) - 29.984 ;
	static bool isprint(true);
	if (isprint){
		//std::cout << "lastspeed : " << lastSpeed <<  ", xtime : " << xtime  <<  ", v : " << speed << std::endl;
		isprint = false;
	}
	if (speed >= desiredThrottle ){
		speed = desiredThrottle;
		isprint = true;
		IsUpdateSpeed = false;
	}
	//std::cout << "perlambatan2 --> t : " << xtime <<  ", v : " << speed  << std::endl;
	//dt dimulai dari x/time
	xtime += elapsedTime;
}

void VehicleActor::Deceleration_GoBack2(float elapsedTime)
{
	static double xtime(0.0f);
	if (IsGetLastSpeed2){
		lastSpeed = speed;
		IsGetLastSpeed2 = false;
		//cari x/time ketika lastspeed
		float a0 = 0.00001698558312 * pow(lastSpeed,5);
		float a1 = 0.0013660878716 * pow(lastSpeed,4);
		float a2 =  0.05995011472906 * pow(lastSpeed,3);
		float a3 = 1.362647395615 * pow(lastSpeed,2);
		float a4 = 17.7939615967765 * lastSpeed;
		xtime = a0 + a1 + a2 + a3 + a4 + 201.632192938692;
	}
	float b0 = 0.00000000122821 * pow(xtime,5);
	float b1 = -0.00000060581527 * pow(xtime,4);
	float b2 = 0.00009577464465 * pow(xtime,3);
	float b3 = -0.00480861004067 * pow(xtime,2);
	float b4 = 0.15525294893327 * xtime;
	speed = b0 + b1 + b2 + b3 + b4 - 28.4501578729287;
	static bool isprint(true);
	if (isprint){
		//std::cout << "lastspeed : " << lastSpeed <<  ", xtime : " << xtime  <<  ", v : " << speed << std::endl;
		isprint = false;
	}
	//std::cout << "perlambatan2 --> t : " << xtime <<  ", v : " << speed  << std::endl;
	if (speed >= desiredThrottle ){
		speed = desiredThrottle;
		isprint = true;
		IsUpdateSpeed = false;
	}
	xtime += elapsedTime;
}