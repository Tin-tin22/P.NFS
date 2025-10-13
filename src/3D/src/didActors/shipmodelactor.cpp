///////////////////////////////////////////////////////////////////////////////

#include "ShipModelActor.h"
#include "OceanActor.h"
#include "didactorssources.h"
#include <osg/Switch>

using namespace   dtAudio;
using namespace	  dtCore;
using namespace   dtUtil;
using namespace   osgOcean;
using namespace   didEnviro;

/////////////////////////////////////////////////

//Constant
const float MaxSpeed = 50.0f;
const float ShipModelActor::COLLISION_SND_TIMEOUT = 6.0f;

ShipModelActorProxy::ShipModelActorProxy(){}
ShipModelActorProxy::~ShipModelActorProxy(){}

void ShipModelActorProxy::BuildPropertyMap()
{
	ShipActorProxy::BuildPropertyMap();

	ShipModelActor* kri = NULL ;

	GetActor(kri);

	AddProperty(new dtDAL::StringActorProperty(C_SET_MODEL,C_SET_MODEL,
	   dtDAL::StringActorProperty::SetFuncType(kri,&ShipModelActor::LoadModelFile),
	   dtDAL::StringActorProperty::GetFuncType(kri,&ShipModelActor::GetMeshFile), "Loads the model file for the ship", C_TYPE_SHIP));

	AddProperty(new dtDAL::FloatActorProperty(C_SET_SPEED,C_SET_SPEED,
	   dtDAL::FloatActorProperty::SetFuncType(kri, &ShipModelActor::SetSpeed),
	   dtDAL::FloatActorProperty::GetFuncType(kri, &ShipModelActor::GetSpeed), "Sets/gets speed.",C_TYPE_SHIP));

	AddProperty(new dtDAL::FloatActorProperty(C_SET_PITCH,C_SET_PITCH,
	   dtDAL::FloatActorProperty::SetFuncType(kri, &ShipModelActor::SetPitch),
	   dtDAL::FloatActorProperty::GetFuncType(kri, &ShipModelActor::GetPitch), "Sets/gets pitch.", C_TYPE_SHIP));

	AddProperty(new dtDAL::FloatActorProperty(C_SET_HEEL,C_SET_HEEL,
	   dtDAL::FloatActorProperty::SetFuncType(kri, &ShipModelActor::SetHeel),
	   dtDAL::FloatActorProperty::GetFuncType(kri, &ShipModelActor::GetHeel), "Sets/gets heel.", C_TYPE_SHIP));

	AddProperty(new dtDAL::FloatActorProperty(C_SET_COURSE,C_SET_COURSE,
		 dtDAL::FloatActorProperty::SetFuncType(kri, &ShipModelActor::SetCourse),
		 dtDAL::FloatActorProperty::GetFuncType(kri, &ShipModelActor::GetCourse), "Sets/gets course.", C_TYPE_SHIP));

	AddProperty(new dtDAL::FloatActorProperty("DesiredRudderAngle","DesiredRudderAngle",
		dtDAL::FloatActorProperty::SetFuncType(kri, &ShipModelActor::SetDesiredRudderAngle),
		dtDAL::FloatActorProperty::GetFuncType(kri, &ShipModelActor::GetDesiredRudderAngle), "Sets/gets desire rudder angle.", C_TYPE_SHIP));

	AddProperty(new dtDAL::IntActorProperty("ModeGuidance","ModeGuidance",
		dtDAL::IntActorProperty::SetFuncType(kri, &ShipModelActor::SetModeGuidance),
		dtDAL::IntActorProperty::GetFuncType(kri, &ShipModelActor::GetModeGuidance), "Sets/gets course.", C_TYPE_SHIP));

	/*AddProperty(new dtDAL::IntActorProperty("ModeAltitude","ModeAltitude",
		dtDAL::IntActorProperty::SetFuncType(kri, &ShipModelActor::SetModeAltitude),
		dtDAL::IntActorProperty::GetFuncType(kri, &ShipModelActor::GetModeAltitude), "Sets/gets course.", C_TYPE_SHIP));*/

	AddProperty(new dtDAL::FloatActorProperty("MaxAheadSpeed","MaxAheadSpeed",
		dtDAL::FloatActorProperty::SetFuncType(kri, &ShipModelActor::SetMaxAheadSpeed),
		dtDAL::FloatActorProperty::GetFuncType(kri, &ShipModelActor::GetMaxAheadSpeed), "Sets/gets MaxAheadSpeed.", C_TYPE_SHIP));

	AddProperty(new dtDAL::IntActorProperty(C_SET_DAMAGE,C_SET_DAMAGE,
		dtDAL::IntActorProperty::SetFuncType(kri, &ShipModelActor::SetDamage),
		dtDAL::IntActorProperty::GetFuncType(kri, &ShipModelActor::GetDamage), "Sets/gets damage.", C_TYPE_SHIP));
}

void ShipModelActorProxy::BuildInvokables()
{
	ShipActorProxy::BuildInvokables();
}

/////////////////////////////////////////////////
const float ShipModelActor::UNINITIALIZED_WAVE_VALUE = -9999.0f;
const float ShipModelActor::NUMERATOR_DATA[3] = 
{
    0,
    C_UPDATEALLOBJECT_CYCLE_TIME_3D,
    C_UPDATEALLOBJECT_CYCLE_TIME_3D * 2
};

const float ShipModelActor::DENOMINATOR_TWO_DATA[2] =
{
    NUMERATOR_DATA[0] - NUMERATOR_DATA[1], //x0 - x1
    NUMERATOR_DATA[1] - NUMERATOR_DATA[0]  //x1 - x0
};

const float ShipModelActor::DENOMINATOR_THREE_DATA[3] =
{
    (NUMERATOR_DATA[0] - NUMERATOR_DATA[1]) * (NUMERATOR_DATA[0] - NUMERATOR_DATA[2]),    //(x0 - x1).(x0-x2)
    (NUMERATOR_DATA[1] - NUMERATOR_DATA[0]) * (NUMERATOR_DATA[1] - NUMERATOR_DATA[2]),    //(x1 - x0).(x1-x2)
    (NUMERATOR_DATA[2] - NUMERATOR_DATA[0]) * (NUMERATOR_DATA[2] - NUMERATOR_DATA[1]),    //(x2 - x0).(x2-x1)
};

ShipModelActor::ShipModelActor(dtGame::GameActorProxy &proxy) :
	ShipActor(proxy),
	mLogger(dtUtil::Log::GetInstance("ShipModelActor.cpp")),
	oceanHeight(0.0f),  
	oceanNormalX(0.0f),  
	oceanNormalY(0.0f),  
	oceanNormalZ(0.0f),  
	oceanHeightLast(0.0f), 
	oceanNormalLast(),     
	oceanHeightSpeed(0.0f), 
	oceanNormalSpeed(),     
	oceanLastDeltaTime(0.0f),    
	trueHeight(0.0f),    
	trueNormal(),    
	mIsCameraAttached(false),
	mIsNight(false),
	mWeaponSwitch("111111111111111"),
	p1(0.0f),
	p2(0.0f)
{
	mCoordSys = &VehicleActor::CoordSys::SYS_ABS;
	SetPosition(position);
	stackSound = NULL ;
	SndBell1 = NULL ;
	SndBell2 = NULL ;
	SndBell3 = NULL ;
	SndBell4 = NULL ;
	SndBell5 = NULL ;
	SndBell6 = NULL ;
	SndBell7 = NULL ;
	SndBell8 = NULL ;
	SndBell9 = NULL ;
	collisionSound = NULL;
	collisionSound2 = NULL;	

	ResetOceanWaveVars();
	//SetMaxAheadSpeed(40.0f);
}

ShipModelActor::~ShipModelActor(){}

void ShipModelActor::UpdatePosition(float elapsedTime)
{
	float x,y,z,h,p,r;
	float p51Bearing = ConvertTodtCoreBearing(course);
	float p51Pitch = ConvertTodtCoreBearing(pitch); //pitch;//
	float distance = speed * metersPerKnotPerSecond * elapsedTime;

//	float speed_temp = -4.30 * ln(elapsedTime) + 29.98;
	//float distance_temp = speed_temp * metersPerKnotPerSecond * elapsedTime;

	position.Get(x, y, z, h, p, r);

	position.Set(
		x -= distance * sinf(osg::DegreesToRadians(p51Bearing))* cosf(osg::DegreesToRadians(p51Pitch)),
		y += distance * cosf(osg::DegreesToRadians(p51Bearing))* cosf(osg::DegreesToRadians(p51Pitch)),
		z += distance * sinf(osg::DegreesToRadians(p51Pitch)),
		p51Bearing,
		p51Pitch,
		heel);   

	/*position.Set(
		x -= distance_temp * sinf(osg::DegreesToRadians(p51Bearing))* cosf(osg::DegreesToRadians(p51Pitch)),
		y += distance_temp * cosf(osg::DegreesToRadians(p51Bearing))* cosf(osg::DegreesToRadians(p51Pitch)),
		z += distance_temp * sinf(osg::DegreesToRadians(p51Pitch)),
		p51Bearing,
		p51Pitch,
		heel); */

	position.Get(x, y, z, h, p, r);

	osg::Vec3f mXYZ(x,y,z);
	osg::Vec3f mHPR(h,p,r) ;
	osg::Matrix mat, rot ;

	dtUtil::MatrixUtil::PositionAndHprToMatrix(mat,mXYZ,mHPR);

	dtGame::IEnvGameActorProxy* envActorProxy = GetGameActorProxy().GetGameManager()->GetEnvironmentActor();
	OceanActor* actor = NULL;
	if (envActorProxy )
		actor = dynamic_cast<OceanActor*> (envActorProxy->GetActor());
	if (actor != NULL)
	{

		if (oceanLastDeltaTime + elapsedTime >= C_UPDATEALLOBJECT_CYCLE_TIME_3D)
		{
			UpdateOceanWaveVars(); //Server only
		}

		if( oceanHeightLast != oceanHeight &&
			oceanNormalLast.x() != oceanNormalX &&
			oceanNormalLast.y() != oceanNormalY &&
			oceanNormalLast.z() != oceanNormalZ &&
			oceanLastDeltaTime != oceanDeltaTime
			)
		{              
			CalculatePolyOceanWaveVars();  
			oceanLastDeltaTime = oceanDeltaTime;            
			oceanHeightLast = oceanHeight;
			oceanNormalLast.set(oceanNormalX,oceanNormalY,oceanNormalZ);
		}

		CalculatePolyTrueValues(elapsedTime);

		oceanLastDeltaTime += elapsedTime;

		mat.makeTranslate(osg::Vec3f(mXYZ.x(), mXYZ.y(), trueHeight));

		rot.makeIdentity();


		rot.makeRotate( trueNormal.x()/8, osg::Vec3f(1.0f, 0.0f, 0.0f), 
			trueNormal.y()/8, osg::Vec3f(0.0f, 1.0f, 0.0f),
			(1.0f-trueNormal.z()), osg::Vec3f(0.0f, 0.0f, 1.0f));


		mat = rot * mat;

		dtUtil::MatrixUtil::MatrixToHprAndPosition(mXYZ,mHPR,mat);

	}
	SetPitch(mHPR.y());
	heel = mHPR.z();

	position.Set(
		x,
		y,
		mXYZ.z(),
		p51Bearing,
		mHPR.y(),
		mHPR.z()  
		);
}

void ShipModelActor::SetModelPosition()
{
 	dtCore::Transform tempPos;
	dtCore::Transform newPos = GetPosition();

	float speedOffset = 3.5f * GetSpeed() / GetMaxAheadSpeed();
	newPos = GetPosition();
	SetTransform(newPos, *mCoordSys == VehicleActor::CoordSys::SYS_ABS ? ABS_CS : REL_CS);

	if(CheckWake(portWake.get()))
	{
		tempPos = Offset2DPosition(&newPos, &portWakePosition);
		portWake->SetTransform(tempPos);
	}

	if(CheckWake(stbdWake.get()))
	{
		tempPos = Offset2DPosition(&newPos, &stbdWakePosition);
		stbdWake->SetTransform(tempPos);
	}

	if(CheckWake(portBowWake.get()))
	{
		tempPos = Offset2DPosition(&newPos, &portBowWakePosition);
		AdjustZ(&tempPos, speedOffset, true);
		portBowWake->SetTransform(tempPos);
	}

	if(CheckWake(stbdBowWake.get()))
	{
		tempPos = Offset2DPosition(&newPos, &stbdBowWakePosition);
		AdjustZ(&tempPos, speedOffset, true);
		stbdBowWake->SetTransform(tempPos);
	}

	if(CheckWake(portRooster.get()))
	{
		tempPos = Offset2DPosition(&newPos, &portRoosterPosition);
		AdjustZ(&tempPos, 1.2f * speedOffset, true);
		AdjustX(&tempPos, GetHeel() / -9.0f, true);
		portRooster->SetTransform(tempPos);
	}

	if(CheckWake(stbdRooster.get()))
	{
		tempPos = Offset2DPosition(&newPos, &stbdRoosterPosition);
		AdjustZ(&tempPos, 1.2f * speedOffset, true);
		AdjustX(&tempPos, GetHeel() / -9.0f, true);
		stbdRooster->SetTransform(tempPos);
	}

	if(CheckStack(forwardStack.get(), forwardStackEngaged)){} 
 }

bool ShipModelActor::CheckStack(dtCore::ParticleSystem* stack, bool stackEngaged)
{
 	if(mEngineRunning)
	{
		EngageForwardStack();
		EngageAfterStack();
	}
	else
	{
		DisengageForwardStack();
		DisengageAfterStack();
	}

	if (stack != NULL)
	{
		if(stack->IsEnabled())
		{
			if(!stackEngaged)
				stack->SetEnabled(false);
		}
		else
		{
			if(stackEngaged)
				stack->SetEnabled(true);
		}

		return stack->IsEnabled();
	}
	else
		return false;
 }

void ShipModelActor::SetForwardStack(dtCore::ParticleSystem* tForwardStack, dtCore::Transform tForwardStackPosition)
{
 	if(tForwardStack != NULL)
	{
		forwardStack = tForwardStack;
		forwardStackPosition = tForwardStackPosition;
		forwardStack->SetTransform(forwardStackPosition);
	}
}

void ShipModelActor::SetAfterStack(dtCore::ParticleSystem* tAfterStack, dtCore::Transform tAfterStackPosition)
{
 	if(tAfterStack != NULL)
	{
		afterStack = tAfterStack;
		afterStackPosition = tAfterStackPosition;
		afterStack->SetTransform(afterStackPosition);
	}
}

void ShipModelActor::EngageForwardStack()
{
	forwardStackEngaged = true;
}

void ShipModelActor::DisengageForwardStack()
{
	forwardStackEngaged = false;
}

void ShipModelActor::EngageAfterStack()
{
	afterStackEngaged = true;
}

void ShipModelActor::DisengageAfterStack()
{
	afterStackEngaged = false;
}

void ShipModelActor::SetStackSound(dtAudio::Sound *tStackSound, dtCore::Transform tStackSoundPosition)
{	
	stackSound = tStackSound;
	stackSoundPosition = tStackSoundPosition;
	stackSound->SetTransform(tStackSoundPosition,dtCore::Transformable::REL_CS);
	stackSound->SetMaxDistance(1000.0f);
	stackSound->SetLooping(true);
	stackSound->Play();
}

void ShipModelActor::PlayStackSound()
{
	if(stackSound != NULL)
		stackSound->Play();
}

void ShipModelActor::StopStackSound()
{
	if(stackSound != NULL)
		stackSound->Stop();
}

void ShipModelActor::LoadModelFile(const std::string &fileName)
{
	if (meshFile != fileName)
	{
        std::string trueFileName(fileName);

		if (trueFileName == "")
		trueFileName = "1.IVE";

		if (mIsCameraAttached)
		{
			std::size_t found = trueFileName.find_last_of("/\\");
			trueFileName.insert(found+1, "BO/");
		}
        if (mIsNight)
        {
            std::size_t found = trueFileName.find_last_of("/\\");
            trueFileName.insert(found+1, "Night/");
        }

		dtCore::RefPtr<osgDB::ReaderWriter::Options> options = new osgDB::ReaderWriter::Options();
        options->setObjectCacheHint(osgDB::ReaderWriter::Options::CACHE_NONE);
        osg::Node *model = osgDB::readNodeFile(trueFileName,options.get());  

		if (model != NULL)
		{
			if (GetMatrixNode()->getNumChildren() != 0)
				GetMatrixNode()->removeChild(0,GetMatrixNode()->getNumChildren());

            //    ,_reflectionSceneMask        ( 0x1 )  // 1
            //    ,_refractionSceneMask        ( 0x2 )  // 2
            //    ,_normalSceneMask            ( 0x4 )  // 4
            //    ,_surfaceMask                ( 0x8 )  // 8
            //    ,_siltMask                   ( 0x10 ) // 16
            //    ,_heightmapMask              ( 0x20 ) // 32
            
            model->setNodeMask( 0x4 | 0x1 | 0x2 );

			GetMatrixNode()->addChild(model);

            model->getOrCreateStateSet()->setMode(GL_DEPTH_TEST, osg::StateAttribute::ON | osg::StateAttribute::OVERRIDE);
            model->getOrCreateStateSet()->setMode(GL_CULL_FACE, osg::StateAttribute::ON | osg::StateAttribute::OVERRIDE);
            
            meshFile = fileName;  

			dMass mass;
			dMassSetBox(&mass, 1.0f, 1.0f, 1.0f, 1.0f);
			SetCollisionBox();
			SetMass(&mass);
			
			GetGameActorProxy().GetGameManager()->GetScene().AddDrawable(this);



		}
		else
		{
			LOG_ERROR("Unable to load model file: " + fileName);
		}


		//the game manager is not set when this property is first set at map load time.
		if (!IsRemote() && GetGameActorProxy().IsInGM()) 
		{
			dtCore::RefPtr<dtGame::Message> updateMsg = GetGameActorProxy().GetGameManager()->GetMessageFactory().CreateMessage(dtGame::MessageType::INFO_ACTOR_UPDATED);
			dtGame::ActorUpdateMessage *message = static_cast<dtGame::ActorUpdateMessage *> (updateMsg.get());
			GetGameActorProxy().PopulateActorUpdate(*message);
			GetGameActorProxy().GetGameManager()->SendMessage(*updateMsg);
		}
	}
}

//////////////////////////////////////////////////////////////////////////////////////////////////

void ShipModelActor::TickLocal(const dtGame::Message &tickMessage)
{
	const dtGame::TickMessage &tick = static_cast<const dtGame::TickMessage&>(tickMessage);
	float deltaSimTime = tick.GetDeltaSimTime();
	
	/*if ( !mFirstInitSwitchWeapon ) CeckInitialSwitchWeapon();
	if ( !mFirstInitSwitchLamps ) CeckInitialSwitchLamps();
	if ( !mFirstInitSwitchTarget ) CeckInitialSwitchTarget();*/

	MoveVehicle(deltaSimTime);

	if ( GetGameActorProxy().GetGameManager()->GetMachineInfo().GetName()== C_MACHINE_SERVER )
	{
		CeckDataCollision();

		//TestOwnCollision();

		if( bIsCollisionSound )
		{
			mCollisionSoundTime += deltaSimTime;
			if (mCollisionSoundTime > COLLISION_SND_TIMEOUT)
			{
				mCollisionSoundTime = 0.0f;
				bIsCollisionSound = false;
				collisionSound->Stop();
				collisionSound2->Stop();
			}
		}
	}
}

void ShipModelActor::TestOwnCollision()
{
	static dtCore::Transform objectTransform;
	static osg::Vec3 objectPosition;
	static osg::Vec3 objectRotation;
	dtCore::RefPtr<dtDAL::ActorProxy> parentProxy = GetShipActorByID(6);
	if ( parentProxy.valid() )
	{
		dtCore::RefPtr<VehicleActor> parent = static_cast<VehicleActor*>(parentProxy->GetActor());
		dtGame::GameActorProxy &pr = parent->GetGameActorProxy();
		parent->GetTransform(objectTransform);
		objectTransform.GetTranslation(objectPosition);
		objectTransform.GetRotation(objectRotation);

		boxShip.h = 100;
		boxShip.w = 20 ;
		boxShip.x = objectPosition.x();
		boxShip.y = objectPosition.y();

		//std::cout << "nala pos x : " << objectPosition.x() << ", nala heading : " << objectRotation.x() << std::endl;
	}

	static dtCore::Transform ownShipTransform;
	static osg::Vec3 ownShipPosition;
	static osg::Vec3 ownShipRotation;

	dtCore::RefPtr<dtDAL::ActorProxy> pProxy = GetShipActorByID(1);
	if ( pProxy.valid() )
	{

		dtCore::RefPtr<VehicleActor> parent = static_cast<VehicleActor*>(pProxy->GetActor());
		dtGame::GameActorProxy &pr = parent->GetGameActorProxy();
		parent->GetTransform(ownShipTransform);
		ownShipTransform.GetTranslation(ownShipPosition);
		ownShipTransform.GetTranslation(ownShipRotation);

		boxShip2.h = 100;
		boxShip2.w = 25;
		boxShip2.x = ownShipPosition.x();
		boxShip2.y = ownShipPosition.y();
	}

	if (IsInBox(boxShip,boxShip2))
		std::cout << "collision ship" <<std::endl;
}

bool ShipModelActor::IsInBox(const Box& boxship, const Box& boxship2)
{
	if(boxship.x > (boxship2.x+boxship2.w)) return false; // box1 is too far right, no collision
	else if((boxship.x+boxship2.w) < boxship2.x) return false; // box1 is too far left, no collision
	else if(boxship.y > (boxship2.y+boxship2.h)) return false; // box1 is too far down, no collision
	else if((boxship.y+boxship.h) < boxship2.y) return false; // box1 is too far up, no collision
	else return true; // there is a collision
}

dtCore::RefPtr<dtDAL::ActorProxy> ShipModelActor::GetShipActorByID(int mVehicleID )
{
	dtCore::RefPtr<dtDAL::ActorProxy> proxy ;

	std::vector<dtGame::GameActorProxy *> fill;
	std::vector<dtGame::GameActorProxy *>::iterator iter;
	GetGameActorProxy().GetGameManager()->GetAllGameActors(fill);

	for (iter = fill.begin(); iter < fill.end(); iter++)
	{
		if (((*iter)->GetActorType().GetName()== C_CN_SHIP ) || ((*iter)->GetActorType().GetName()== C_CN_SUBMARINE )
			|| ((*iter)->GetActorType().GetName()== C_CN_HELICOPTER )|| ((*iter)->GetActorType().GetName()== C_CN_AIRCRAFT )) 
		{
			dtCore::RefPtr<dtDAL::ActorProperty> PVehID( (*iter)->GetProperty(C_SET_VID) );
			dtCore::RefPtr<dtDAL::IntActorProperty> ValID( static_cast<dtDAL::IntActorProperty*>( PVehID.get() ) );
			int tgt( ValID->GetValue() );
			if ( tgt == mVehicleID )
			{
				proxy = (*iter);
				break;
			}
		}
	}
	if(!proxy.valid())
	{
		return NULL;
	}
	return proxy;
}

void ShipModelActor::ProcessMessage(const dtGame::Message &message)
{
	if(message.GetMessageType().GetName() == SimMessageType::ORDER_EVENT.GetName()){
		ProcessOrderEvent(message);
	}
}

void ShipModelActor::OnMessage(dtCore::Base::MessageData* msgData)
{
	if (msgData->message== "collision")
	{
		dtCore::Scene::CollisionData* cd = static_cast< dtCore::Scene::CollisionData* >(msgData->userData);
		if(
			(cd->mBodies[0]== this || cd->mBodies[1]== this)
			&&
			//!SALAH kurang lengkap
			(cd->mBodies[0]->GetName()!= "Infinite Terrain" && cd->mBodies[1]->GetName()!= "Infinite Terrain")
			)
		{
			mCollisionData.push_back(*cd);
		}
	}
}

void ShipModelActor::SetSoundMaxxRoll()
{
	if(stackSound != NULL)
		stackSound->SetMaxDistance( mMaxDist );

	if(SndBell0 != NULL)
		SndBell0->SetMaxDistance( mMaxDist );

	if(SndBell1 != NULL)
		SndBell1->SetMaxDistance( mMaxDist );

	if(SndBell2 != NULL)
		SndBell2->SetMaxDistance( mMaxDist );

	if(SndBell3 != NULL)
		SndBell3->SetMaxDistance( mMaxDist );

	if(SndBell4 != NULL)
		SndBell4->SetMaxDistance( mMaxDist );

	if(SndBell5 != NULL)
		SndBell5->SetMaxDistance( mMaxDist );

	if(SndBell6 != NULL)
		SndBell6->SetMaxDistance( mMaxDist );

	if(SndBell7 != NULL)
		SndBell7->SetMaxDistance( mMaxDist );

	if(SndBell8 != NULL)
		SndBell8->SetMaxDistance( mMaxDist );

	if(SndBell9 != NULL)
		SndBell9->SetMaxDistance( mMaxDist );

    if(collisionSound != NULL)
		collisionSound->SetMaxDistance( mMaxDist );

    if(collisionSound2 != NULL)
		collisionSound2->SetMaxDistance( mMaxDist );

	std::cout<<GetName()<<" Set Sound Config :: Min Distance = "<<mMinDist<<",Max Distance = "<<mMaxDist<<",Roll Off = "<<mRollOff<<std::endl;
}

void ShipModelActor::SetBellSoundConfig(dtAudio::Sound *tmpSound, dtCore::Transform tmpSoundPos )
{
	tmpSound->SetGain(1.0f);
	tmpSound->SetPitch(1.0f);
    tmpSound->SetRolloffFactor(1.0f);
    tmpSound->SetMinGain(0.0f);
	tmpSound->SetTransform(tmpSoundPos, dtCore::Transformable::REL_CS);
    tmpSound->SetReferenceDistance( 1.0f );
	if ( tmpSound == SndBell0 )
    {
		tmpSound->SetLooping(true);
        tmpSound->SetRolloffFactor(0.2f);
    }
	else
		tmpSound->SetLooping(false);

}

void ShipModelActor::SetSoundFile()
{
	dtCore::Transform trPos ;
	//trPos.Set(0.0f, 12.6f, 9.1f, 0.0f, 0.0f, 0.0f);
    trPos.Set(0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f);
	//std::cout<<"Set sound Position ..."<<trPos.GetTranslation()<<std::endl;

	FreeSound(stackSound.get());
	stackSound = dtAudio::AudioManager::GetInstance().NewSound();
	stackSound->LoadFile("Sounds/engine.wav");
	assert(stackSound);
	SetStackSound(stackSound.get(),trPos);
	AddChild(stackSound.get());
	
	FreeSound(SndBell0.get());
	SndBell0 = dtAudio::AudioManager::GetInstance().NewSound();
	SndBell0->SetName(GetName()+" Bell0");
	SndBell0->LoadFile("Sounds/Bell0.wav");
	assert(SndBell0);
	SetBellSoundConfig(SndBell0.get(),trPos);
	AddChild(SndBell0.get());

	FreeSound(SndBell1.get());
	SndBell1 = dtAudio::AudioManager::GetInstance().NewSound();
	SndBell1->SetName(GetName()+" Bell1");
	SndBell1->LoadFile("Sounds/Bell1.wav");
	assert(SndBell1);
	SetBellSoundConfig(SndBell1.get(),trPos);
	AddChild(SndBell1.get());

	FreeSound(SndBell2.get());
	SndBell2 = dtAudio::AudioManager::GetInstance().NewSound();
	SndBell2->SetName(GetName()+" Bell2");
	SndBell2->LoadFile("Sounds/Bell2.wav");
	assert(SndBell2);
	SetBellSoundConfig(SndBell2.get(),trPos);
	AddChild(SndBell2.get());

	FreeSound(SndBell3.get());
	SndBell3 = dtAudio::AudioManager::GetInstance().NewSound();
	SndBell3->SetName(GetName()+" Bell3");
	SndBell3->LoadFile("Sounds/Bell3.wav");
	assert(SndBell3);
	SetBellSoundConfig(SndBell3.get(),trPos);
	AddChild(SndBell3.get());

	FreeSound(SndBell4.get());
	SndBell4 = dtAudio::AudioManager::GetInstance().NewSound();
	SndBell4->SetName(GetName()+" Bell4");
	SndBell4->LoadFile("Sounds/Bell4.wav");
	assert(SndBell4);
	SetBellSoundConfig(SndBell4.get(),trPos);
	AddChild(SndBell4.get());

	FreeSound(SndBell5.get());
	SndBell5 = dtAudio::AudioManager::GetInstance().NewSound();
	SndBell5->SetName(GetName()+" Bell5");
	SndBell5->LoadFile("Sounds/Bell5.wav");
	assert(SndBell5);
	SetBellSoundConfig(SndBell5.get(),trPos);
	AddChild(SndBell5.get());

	FreeSound(SndBell6.get());
	SndBell6 = dtAudio::AudioManager::GetInstance().NewSound();
	SndBell6->SetName(GetName()+" Bell6");
	SndBell6->LoadFile("Sounds/Bell6.wav");
	assert(SndBell6);
	SetBellSoundConfig(SndBell6.get(),trPos);
	AddChild(SndBell6.get());

	FreeSound(SndBell7.get());
	SndBell7 = dtAudio::AudioManager::GetInstance().NewSound();
	SndBell7->SetName(GetName()+" Bell7");
	SndBell7->LoadFile("Sounds/Bell7.wav");
	assert(SndBell7);
	SetBellSoundConfig(SndBell7.get(),trPos);
	AddChild(SndBell7.get());

	FreeSound(SndBell8.get());
	SndBell8 = dtAudio::AudioManager::GetInstance().NewSound();
	SndBell8->SetName(GetName()+" Bell8");
	SndBell8->LoadFile("Sounds/Bell8.wav");
	assert(SndBell8);
	SetBellSoundConfig(SndBell8.get(),trPos);
	AddChild(SndBell8.get());

	FreeSound(SndBell9.get());
	SndBell9 = dtAudio::AudioManager::GetInstance().NewSound();
	SndBell9->SetName(GetName()+" Bell9");
	SndBell9->LoadFile("Sounds/Bell9.wav");
	assert(SndBell9);
	SetBellSoundConfig(SndBell9.get(),trPos);
	AddChild(SndBell9.get());

	FreeSound(collisionSound.get());
	collisionSound = dtAudio::AudioManager::GetInstance().NewSound();
	collisionSound->SetName(GetName()+" Collision");
	collisionSound->LoadFile("Sounds/Collision.wav");
	assert(collisionSound);
	SetBellSoundConfig(collisionSound.get(),trPos);
	AddChild(collisionSound.get());

	//++ BAWE-20110103: TWO COLLISION SOUNDS
	collisionSound->SetLooping(false);

	FreeSound(collisionSound2.get());
	collisionSound2 = dtAudio::AudioManager::GetInstance().NewSound();
	collisionSound2->SetName(GetName()+" CollisionRepeat");
	collisionSound2->LoadFile("Sounds/Collision2.wav");
	assert(collisionSound2);
	SetBellSoundConfig(collisionSound2.get(),trPos);
	AddChild(collisionSound2.get());
	//-- BAWE-20110103: TWO COLLISION SOUNDS

}

void ShipModelActor::PlayBellSound(int nValue)
{
	switch (nValue)
	{
	case ORD_BELL0: 
		if(SndBell0 != NULL) 
		{ 
			if (bContSound == false ) 
			{
				SndBell0->Play();
				std::cout<<SndBell0->GetName()<<" START "<<std::endl;
                dtCore::Transform xform;
                this->GetTransform(xform);
                SndBell0->SetTransform(xform);
				bContSound = true ;
			}
			else
			{
				SndBell0->Stop();
				std::cout<<SndBell0->GetName()<<" STOP "<<std::endl;
				bContSound = false ;
			}
		}
		break;
	case ORD_BELL1: 
		if(SndBell1 != NULL)
        {
            dtCore::Transform xform;
            this->GetTransform(xform);
            SndBell1->SetTransform(xform);
			SndBell1->Play();
        }
		break;
	case ORD_BELL2: 
		if(SndBell2 != NULL) 
        {
            dtCore::Transform xform;
            this->GetTransform(xform);
            SndBell2->SetTransform(xform);
			SndBell2->Play();
        }
		break;
	case ORD_BELL3: 
		if(SndBell3 != NULL) 
        {
            dtCore::Transform xform;
            this->GetTransform(xform);
            SndBell3->SetTransform(xform);
			SndBell3->Play();
        }
		break;
	case ORD_BELL4: 
		if(SndBell4 != NULL) 
        {
            dtCore::Transform xform;
            this->GetTransform(xform);
            SndBell4->SetTransform(xform);
			SndBell4->Play();
        }
		break;
	case ORD_BELL5: 
		if(SndBell5 != NULL) 
        {
            dtCore::Transform xform;
            this->GetTransform(xform);
            SndBell5->SetTransform(xform);
			SndBell5->Play();
        }
		break;
	case ORD_BELL6: 
		if(SndBell6 != NULL) 
        {
            dtCore::Transform xform;
            this->GetTransform(xform);
            SndBell6->SetTransform(xform);
			SndBell6->Play();
        }
		break;
	case ORD_BELL7: 
		if(SndBell7!= NULL) 
        {
            dtCore::Transform xform;
            this->GetTransform(xform);
            SndBell7->SetTransform(xform);
			SndBell7->Play();
        }
		break;
	case ORD_BELL8: 
		if(SndBell8 != NULL) 
        {
            dtCore::Transform xform;
            this->GetTransform(xform);
            SndBell8->SetTransform(xform);
			SndBell8->Play();
        }
		break;
	case ORD_BELL9: 
		if(SndBell9 != NULL) 
        {
            dtCore::Transform xform;
            this->GetTransform(xform);
            SndBell9->SetTransform(xform);
			SndBell9->Play();
        }
		break;
	}

}

void ShipModelActor::ProcessOrderEvent(const dtGame::Message &message)
{
	dtGame::GameManager &gm= *GetGameActorProxy().GetGameManager();
	//dtABC::Application& app = gm.GetApplication();
	dtABC::Application& app = GetGameActorProxy().GetGameManager()->GetApplication();

	const MsgOrder &orderMsg = static_cast<const MsgOrder&>(message);
	if (orderMsg.GetVehicleID() == GetVehicleID())
		switch (orderMsg.GetOrderID()){
			case ORD_THROTTLE : 
				PlayStackSound();
				IsGetLastSpeed = true;
				IsGetLastSpeed2 = true;
				SetDesiredThrottlePosition(orderMsg.GetFloatValue());
				std::cout<<"ORDER = THROTTLE. VAL = "<<orderMsg.GetFloatValue()<<std::endl;
				break;
			case ORD_RUDDER : 
				PlayStackSound();
				SetModeGuidance(orderMsg.GetModeGuidance());
				SetDesiredRudderAngle(orderMsg.GetFloatValue());
				std::cout<<"ORDER = RUDDER. VAL = "<<orderMsg.GetFloatValue()<<std::endl;
				break;
			case ORD_ADDANGLE : 
				PlayStackSound();
				SetDesiredAddAngle(orderMsg.GetFloatValue());
				std::cout<<"ORDER = ADDANGLE. VAL = "<<orderMsg.GetFloatValue()<<std::endl;
				break;
			case ORD_ADDFORCE : 
				PlayStackSound();
				dtCore::Physical* phys;
				phys = dynamic_cast<dtCore::Physical*>(this);
				phys->GetBodyWrapper()->ApplyForce(osg::Vec3(1.0f*orderMsg.GetFloatValue(), 0.0f, 0.0f));
				std::cout<<"ORDER = ADDFORCE. VAL = "<<orderMsg.GetFloatValue()<<std::endl;
				break;
			case ORD_VERRUDDER : 
				PlayStackSound();
				SetModeAltitude(2);
				p2 = orderMsg.GetFloatValue();
				SetVerDesiredRudderAngle(p2);
				std::cout<<GetName()<<" GET MESSAGE V RUDDER = "<<orderMsg.GetFloatValue()<<std::endl;
				break;
			case ORD_ALTITUDE :
				SetModeAltitude(1);
				float x,y,z,h,p,r;
				position.Get(x, y, z, h, p, r);
				p1=orderMsg.GetFloatValue();

				if (z < p1)
					p2 = 10.0f;
				else
					p2 = -10.0f;
				SetVerDesiredRudderAngle(p2);
				std::cout<<GetName()<<" GET MESSAGE ALTITUDE = "<<orderMsg.GetFloatValue()<<std::endl;
				break;
			case ORD_STOP : // di gunakan untuk lego jangakar
				PlayStackSound();
				SetDesiredThrottlePosition(0);
				break;
			case ORD_BELL : 
				PlayBellSound(int(orderMsg.GetFloatValue()));
				break;
			case ORD_LAMP : 
				SetShipLamp(int(orderMsg.GetFloatValue()));
				break;
			case ORD_SOSOK :  
				SetSwitchSosokStatus(int(orderMsg.GetFloatValue()));
				break;
			case ORD_SWITCH_WEAPON :  
				SetSwitchWeaponStatus(int(orderMsg.GetFloatValue()));
				break;
			case ORD_SOSOK_ALL_OFF :
				{
					if (sosokswitches.get() )
					{
						osg::Switch *sw = sosokswitches.get() ;
						sw->setAllChildrenOff();
					}
				}
				std::cout<<GetName()<<" Set All Sosok OFF"<<std::endl;
				break;
			case ORD_SWITCH_TARGET : 
				{
					std::string sts = orderMsg.GetStringValue();
					int idx = (int) orderMsg.GetFloatValue();
					osg::Switch *sw = targetswitches.get() ;
					float x = orderMsg.GetFloatValue1();
					float y = orderMsg.GetFloatValue2();
					float z = orderMsg.GetFloatValue3();

					if (targetswitches.get()) 
					{
						if ( sts == "true"){
							//sw->setAllChildrenOff();
							targetswitches->setValue(idx,true);
							std::cout << "index switch true: " <<idx<<std::endl;
						}   
						else{
							//sw->setAllChildrenOff();
							targetswitches->setValue(idx,false);
							std::cout << "index switch false: " <<idx<<std::endl;
						}
					}

					dtCore::RefPtr<dtCore::ParticleSystem> mSmoke;
					mSmoke = new dtCore::ParticleSystem();
					mSmoke->LoadFile(C_PARTICLES_SHIP_ESMOKE,true);
					mSmoke->SetEnabled(true);
					GetGameActorProxy().GetGameManager()->GetScene().AddDrawable(mSmoke.get());
					AddChild(mSmoke.get());
				} 
				break;
			case ORD_SOUND_MINDIST : 
				mMinDist = orderMsg.GetFloatValue();
				SetSoundMaxxRoll();
				break;
			case ORD_SOUND_MAXDIST : 
				mMaxDist = orderMsg.GetFloatValue();
				SetSoundMaxxRoll();
				break;
			case ORD_SOUND_ROLLOFF : 
				mRollOff = orderMsg.GetFloatValue();
				SetSoundMaxxRoll();
				break;
            case ORD_RESETOCEANWAVE:
                ResetOceanWaveVars();
                break;
			case ORD_SND_COLLISION :
				if ( orderMsg.GetFloatValue() ==  ORD_SND_COLLISION_ON )
				{
				 
					if(collisionSound != NULL && collisionSound2 != NULL)
					{
						if(!bIsCollisionSound && !collisionSound->IsPlaying() && !collisionSound2->IsPlaying())
						{
							std::cout<<collisionSound->GetName()<<" PLAY "<<std::endl;
                            dtCore::Transform xform;
                            this->GetTransform(xform);
                            collisionSound->SetTransform(xform);
							collisionSound->Play();
							mCollisionSoundTime = 0.0f;
						}
						else if (bIsCollisionSound && !collisionSound->IsPlaying() && !collisionSound2->IsPlaying())
						{
							std::cout<<collisionSound2->GetName()<<" PLAY "<<std::endl;
                            dtCore::Transform xform;
                            this->GetTransform(xform);
                            collisionSound2->SetTransform(xform);
							collisionSound2->Play();
							mCollisionSoundTime = 0.0f;
						}
					}
					bIsCollisionSound = true;				 
				}
				else
				{
				 
					bIsCollisionSound = false;
					if(collisionSound != NULL && collisionSound2 != NULL)
					{
						collisionSound->Stop();
						collisionSound2->Stop();
						mCollisionSoundTime = 0.0f;
					}
					std::cout<<collisionSound->GetName()<<" STOP "<<std::endl;

				}
				break;

	}

}

void ShipModelActor::SetParticleFile()
{
    SetParticlePosition(C_DOF_NAME_SHIP_BURITAN_KIRI,C_PARTICLES_WAKE,portWake, true);
	SetParticlePosition(C_DOF_NAME_SHIP_BURITAN_KANAN,C_PARTICLES_WAKE,starboardWake, true);
	SetParticlePosition(C_DOF_NAME_SHIP_LAMBUNG_KANAN,C_PARTICLES_WAKE,portBowWake, true);
	SetParticlePosition(C_DOF_NAME_SHIP_LAMBUNG_KIRI,C_PARTICLES_WAKE,stbdBowWake, true);
	SetParticlePosition(C_DOF_NAME_SHIP_HALU_KANAN,C_PARTICLES_WAKE,portRooster, true);
	SetParticlePosition(C_DOF_NAME_SHIP_HALU_KIRI,C_PARTICLES_WAKE,stbdRooster, true);
}

void ShipModelActor::SetSwitchWeaponOFF(int idx,bool state)
{
	if (weaponswitches.get() )
	{
		weaponswitches->setValue(idx,state);
	}
}


//////////////////////////////////////////////////////////////////////////
void ShipModelActor::SetSwitchWeaponStatus(int orderID )
{
	const unsigned int IDX_SWW_Meriam120			= 0;
	const unsigned int IDX_SWW_Meriam76				= 1;
	const unsigned int IDX_SWW_Meriam57				= 2;
	const unsigned int IDX_SWW_Meriam40_1			= 3;
	const unsigned int IDX_SWW_Meriam40_2			= 4;
	const unsigned int IDX_SWW_Meriam40_3			= 5;
	const unsigned int IDX_SWW_Asroc				= 6;
	const unsigned int IDX_SWW_RBU6000L				= 7;
	const unsigned int IDX_SWW_RBU6000R				= 8;
	const unsigned int IDX_SWW_StrelaL				= 9;
	const unsigned int IDX_SWW_StrelaR				= 10;
	const unsigned int IDX_SWW_TetralF				= 11;
	const unsigned int IDX_SWW_TetralB				= 12;
	const unsigned int IDX_SWW_MistralL				= 13;
	const unsigned int IDX_SWW_MistralR  			= 14;

	if (weaponswitches.get()) 
	{
		switch (orderID)
		{
		case ORD_SWW_Meriam120: 
			{
				weaponswitches->setValue(IDX_SWW_Meriam120,true);   
			}
			break;		
		case ORD_SWW_Meriam76: 
			{
				weaponswitches->setValue(IDX_SWW_Meriam76,true);   
			}
			break;			
		case ORD_SWW_Meriam57: 
			{
				weaponswitches->setValue(IDX_SWW_Meriam57,true);   
			}
			break;			
		case ORD_SWW_Meriam40_1: 
			{
				weaponswitches->setValue(IDX_SWW_Meriam40_1,true);   
			}
			break;			
		case ORD_SWW_Meriam40_2: 
			{
				weaponswitches->setValue(IDX_SWW_Meriam40_2,true);   
			}
			break;		
		case ORD_SWW_Meriam40_3: 
			{
				weaponswitches->setValue(IDX_SWW_Meriam40_3,true);   
			}
			break;		
		case ORD_SWW_Asroc: 
			{
				weaponswitches->setValue(IDX_SWW_Asroc,true);   
			}
			break;			
		case ORD_SWW_RBU6000L: 
			{
				weaponswitches->setValue(IDX_SWW_RBU6000L,true);   
			}
			break;			
		case ORD_SWW_RBU6000R: 
			{
				weaponswitches->setValue(IDX_SWW_RBU6000R,true);   
			}
			break;			
		case ORD_SWW_StrelaL: 
			{
				weaponswitches->setValue(IDX_SWW_StrelaL,true);   
			}
			break;			
		case ORD_SWW_StrelaR: 
			{
				weaponswitches->setValue(IDX_SWW_StrelaR,true);   
			}
			break;			
		case ORD_SWW_TetralF: 
			{
				weaponswitches->setValue(IDX_SWW_TetralF,true);   
			}
			break;			
		case ORD_SWW_TetralB: 
			{
				weaponswitches->setValue(IDX_SWW_TetralB,true);   
			}
			break;			
		case ORD_SWW_MistralL: 
			{
				weaponswitches->setValue(IDX_SWW_MistralL,true);   
			}
			break;			
		case ORD_SWW_MistralR: 
			{
				weaponswitches->setValue(IDX_SWW_MistralR,true);   
			}
			break;  		
			//// off case order
		case ORD_SWW_Meriam120_Off: 
			{
				weaponswitches->setValue(IDX_SWW_Meriam120,false);   
			}
			break;	
		case ORD_SWW_Meriam76_Off: 
			{
				weaponswitches->setValue(IDX_SWW_Meriam76,false);   
			}
			break;		
		case ORD_SWW_Meriam57_Off: 
			{
				weaponswitches->setValue(IDX_SWW_Meriam57,false);   
			}
			break;		
		case ORD_SWW_Meriam40_1_Off: 
			{
				weaponswitches->setValue(IDX_SWW_Meriam40_1,false);   
			}
			break;		
		case ORD_SWW_Meriam40_2_Off: 
			{
				weaponswitches->setValue(IDX_SWW_Meriam40_2,false);   
			}
			break;	
		case ORD_SWW_Meriam40_3_Off: 
			{
				weaponswitches->setValue(IDX_SWW_Meriam40_3,false);   
			}
			break;	
		case ORD_SWW_Asroc_Off: 
			{
				weaponswitches->setValue(IDX_SWW_Asroc,false);   
			}
			break;		
		case ORD_SWW_RBU6000L_Off: 
			{
				weaponswitches->setValue(IDX_SWW_RBU6000L,false);   
			}
			break;		
		case ORD_SWW_RBU6000R_Off: 
			{
				weaponswitches->setValue(IDX_SWW_RBU6000R,false);   
			}
			break;		
		case ORD_SWW_StrelaL_Off: 
			{
				weaponswitches->setValue(IDX_SWW_StrelaL,false);   
			}
			break;		
		case ORD_SWW_StrelaR_Off: 
			{
				weaponswitches->setValue(IDX_SWW_StrelaR,false);   
			}
			break;		
		case ORD_SWW_TetralF_Off: 
			{
				weaponswitches->setValue(IDX_SWW_TetralF,false);   
			}
			break;		
		case ORD_SWW_TetralB_Off: 
			{
				weaponswitches->setValue(IDX_SWW_TetralB,false);   
			}
			break;		
		case ORD_SWW_MistralL_Off: 
			{
				weaponswitches->setValue(IDX_SWW_MistralL,false);   
			}
			break;		
		case ORD_SWW_MistralR_Off: 
			{
				weaponswitches->setValue(IDX_SWW_MistralR,false);   
			}
			break;  	
		}

	}
}

//////////////////////////////////////////////////////////////////////////
void ShipModelActor::SetSwitchSosokStatus(int i )
{
	if (sosokswitches.get()) 
	{
		switch (i)
		{
		case ORD_Sosok_BallL1: 
			{
				sosokswitches->setValue(0,true);   
			}
			break;
		case ORD_Sosok_BallL2:
			{
				sosokswitches->setValue(1,true);   
			}
			break;
		case ORD_Sosok_BallL3:
			{
				sosokswitches->setValue(2,true);   
			}
			 break;
		case ORD_Sosok_BallR1:
			{
				sosokswitches->setValue(3,true);   
			}
			break;
		case ORD_Sosok_BallR2:
			{
				sosokswitches->setValue(4,true);   
			}
			break;
		case ORD_Sosok_BallR3:
			{
				sosokswitches->setValue(5,true);   
			}
			break;
		case ORD_Sosok_BallC1:
			{
				sosokswitches->setValue(6,true);   
			}
			break;
		case ORD_Sosok_BallC3:
			{
				sosokswitches->setValue(7,true);   
			}
			break;
		case ORD_Sosok_DiaL1:
			{
				sosokswitches->setValue(8,true);   
			}
			break;
		case ORD_Sosok_DiaL2:
			{
				sosokswitches->setValue(9,true);   
			}
			break;
		case ORD_Sosok_DiaR1:
			{
				sosokswitches->setValue(10,true);   
			}
			break;
		case ORD_Sosok_DiaR2:
			{
				sosokswitches->setValue(11,true);   
			}
			break;
		case ORD_Sosok_DiaC2:
			{
				sosokswitches->setValue(12,true);   
			}
			break;
		case ORD_Sosok_ConeL:
			{
				sosokswitches->setValue(13,true);   
			}
			break;
		case ORD_Sosok_ConeR:
			{
				sosokswitches->setValue(14,true);   
			}
			break;
		case ORD_Sosok_DConeL:
			{
				sosokswitches->setValue(15,true);   
			}
			break;
		case ORD_Sosok_DConeR:
			{
				sosokswitches->setValue(16,true);   
			}
			break;
		case ORD_Sosok_CylL:
			{
				sosokswitches->setValue(17,true);   
			}
			break;
		case ORD_Sosok_CylR:
			{
				sosokswitches->setValue(18,true);   
			}
			break;

		case ORD_Sosok_BallL1_Off: 
			{
				sosokswitches->setValue(0,false);   
			}
			break;
		case ORD_Sosok_BallL2_Off:
			{
				sosokswitches->setValue(1,false);   
			}
			break;
		case ORD_Sosok_BallL3_Off:
			{
				sosokswitches->setValue(2,false);   
			}
			break;
		case ORD_Sosok_BallR1_Off:
			{
				sosokswitches->setValue(3,false);   
			}
			break;
		case ORD_Sosok_BallR2_Off:
			{
				sosokswitches->setValue(4,false);   
			}
			break;
		case ORD_Sosok_BallR3_Off:
			{
				sosokswitches->setValue(5,false);   
			}
			break;
		case ORD_Sosok_BallC1_Off:
			{
				sosokswitches->setValue(6,false);   
			}
			break;
		case ORD_Sosok_BallC3_Off:
			{
				sosokswitches->setValue(7,false);   
			}
			break;
		case ORD_Sosok_DiaL1_Off:
			{
				sosokswitches->setValue(8,false);   
			}
			break;
		case ORD_Sosok_DiaL2_Off:
			{
				sosokswitches->setValue(9,false);   
			}
			break;
		case ORD_Sosok_DiaR1_Off:
			{
				sosokswitches->setValue(10,false);   
			}
			break;
		case ORD_Sosok_DiaR2_Off:
			{
				sosokswitches->setValue(11,false);   
			}
			break;
		case ORD_Sosok_DiaC2_Off:
			{
				sosokswitches->setValue(12,false);   
			}
			break;
		case ORD_Sosok_ConeL_Off:
			{
				sosokswitches->setValue(13,false);   
			}
			break;
		case ORD_Sosok_ConeR_Off:
			{
				sosokswitches->setValue(14,false);   
			}
			break;
		case ORD_Sosok_DConeL_Off:
			{
				sosokswitches->setValue(15,false);   
			}
			break;
		case ORD_Sosok_DConeR_Off:
			{
				sosokswitches->setValue(16,false);   
			}
			break;
		case ORD_Sosok_CylL_Off:
			{
				sosokswitches->setValue(17,false);   
			}
			break;
		case ORD_Sosok_CylR_Off:
			{
				sosokswitches->setValue(18,false);   
			}
			break;
		}
	}
}

//////////////////////////////////////////////////////////////////////////

void ShipModelActor::SetLampStatus( LampTypes &type, short status )
{
	/*
	urutan switch : 
	0  AnchorLight			(AnLi)
	1  AnchorLightOff		(AnLiOff)
	2  SternLight			(StnLi)
	3  SternLightOff		(StnLiOff)
	4  MastheadLight		(MHLi)
	5  MastheadLightOff		(MHLiOff)
	6  MastheadLight2		(MHLi2)
	7  MastheadLightOff		(MhLi2Off)
	-  PortLight			(PoLi) // rem
	-  PortLightOff			(PoLiOff) // rem
	- StarboardLight		(StbLi) // rem
	- StarboardLightOff	(StbLiOff) // rem
	8-12 SpecialLightL1Off	(SpLiL1Off)
	9-13 SpecialLightL1Red	(SpLiL1R)
	10-14 SpecialLightL1White	(SpLiL1W)
	11-15 SpecialLightL2Off	(SpLiL2Off)
	12-16 SpecialLightL2Red	(SpLiL2R)
	13-17 SpecialLightL2White	(SpLiL2W)
	14-18 SpecialLightL3Off	(SpLiL3Off)
	15-19 SpecialLightL3Red	(SpLiL3R)
	16-20 SpecialLightL3White	(SpLiL3W)
	17-21 SpecialLightR1Off	(SpLiR1Off)
	18-22 SpecialLightR1Red	(SpLiR1R)
	19-23 SpecialLightR1White	(SpLiR1W)
	20-24 SpecialLightR2Off	(SpLiR2Off)
	21-25 SpecialLightR2Red	(SpLiR2R)
	22-26 SpecialLightR2White	(SpLiR2W)
	23-27 SpecialLightR3Off	(SpLiR3Off)
	24-28 SpecialLightR3Red	(SpLiR3R)
	25-29 SpecialLightR3White	(SpLiR3W)
	26-30 OpsDangerLightL		(ODLiL)
	27-31 OpsDangerLightLOff	(ODLiLOff)
	28-32 OpsDangerLightR		(ODLiR)
	29-33 OpsDangerLightROff	(ODLiROff)
	*/
	//*std::cout<<"SetLampStatus= "<< type <<", status= "<< status <<std::endl;*/
	if (lampswitches.get()) 
	{
		if (type == ShipActor::LampTypes::ANCHOR_LIGHT)
		{
			if (status == 0) 
			{
				lampswitches->setValue(0,false); //AnLi
			} 
			else 
			{
				lampswitches->setValue(0,true);  //AnLi
			}
		}
		else if (type == ShipActor::LampTypes::STERN_LIGHT)
		{
			if (status == 0) 
			{
				lampswitches->setValue(1,false); //StnLi
			} 
			else 
			{
				lampswitches->setValue(1,true);  //StnLi
			}
		}
		else if (type == ShipActor::LampTypes::MASTHEAD_LIGHT)
		{
			if (status == 0) 
			{
				lampswitches->setValue(2,false); //MHLi
			} 
			else 
			{
				lampswitches->setValue(2,true);  //MHLi
			}
		}
		else if (type == ShipActor::LampTypes::MASTHEAD_LIGHT2)
		{
			if (status == 0) 
			{
				lampswitches->setValue(3,false); //MHLi2
			} 
			else 
			{
				lampswitches->setValue(3,true);  //MHLi2
			}
		}
		else if (type == ShipActor::LampTypes::PORT_LIGHT) // kiri
		{
			if (status == 0) 
			{
				lampswitches->setValue(18,false); //PoLi
			} 
			else 
			{
				lampswitches->setValue(18,true);  //PoLi
			}	
		}
		else if (type == ShipActor::LampTypes::STARBOARD_LIGHT)
		{
			if (status == 0) 
			{
				lampswitches->setValue(19,false); //StbLi
			} 
			else 
			{
				lampswitches->setValue(19,true);  //StbLi
			}
		}
		else if (type == ShipActor::LampTypes::SPECIAL_LIGHT_TOP)
		{
			if (status == 0) 
			{
				lampswitches->setValue(4,false); //SpLiL1R
				lampswitches->setValue(5,false); //SpLiL1W
				lampswitches->setValue(10,false); //SpLiR1R
				lampswitches->setValue(11,false); //SpLiR1W
			} 
			else if (status == 1)
			{
				lampswitches->setValue(4,true);  //SpLiL1R
				lampswitches->setValue(5,false); //SpLiL1W
				lampswitches->setValue(10,true); //SpLiR1R
				lampswitches->setValue(11,false); //SpLiR1W
			}
			else if (status == 2)
			{
				lampswitches->setValue(4,false); //SpLiL1R
				lampswitches->setValue(5,true);  //SpLiL1W
				lampswitches->setValue(10,false); //SpLiR1R
				lampswitches->setValue(11,true); //SpLiR1W
			}
		}
		else if (type == ShipActor::LampTypes::SPECIAL_LIGHT_MIDDLE)
		{
			if (status == 0) 
			{
				lampswitches->setValue(6,false); //SpLiL2R
				lampswitches->setValue(7,false); //SpLiL2W
				lampswitches->setValue(12,false); //SpLiR2R
				lampswitches->setValue(13,false); //SpLiR2W
			} 
			else if (status == 1)
			{
				lampswitches->setValue(6,true);  //SpLiL2R
				lampswitches->setValue(7,false); //SpLiL2W
				lampswitches->setValue(12,true); //SpLiR2R
				lampswitches->setValue(13,false); //SpLiR2W
			}
			else if (status == 2)
			{
				lampswitches->setValue(6,false); //SpLiL2R
				lampswitches->setValue(7,true);  //SpLiL2W
				lampswitches->setValue(12,false); //SpLiR2R
				lampswitches->setValue(13,true); //SpLiR2W
			}
		}
		else if (type == ShipActor::LampTypes::SPECIAL_LIGHT_BOTTOM)
		{
			if (status == 0) 
			{
				lampswitches->setValue(8,false); //SpLiL3R
				lampswitches->setValue(9,false); //SpLiL3W
				lampswitches->setValue(14,false); //SpLiR3R
				lampswitches->setValue(15,false); //SpLiR3W
			} 
			else if (status == 1)
			{
				lampswitches->setValue(8,true);  //SpLiL3R
				lampswitches->setValue(9,false); //SpLiL3W
				lampswitches->setValue(14,true); //SpLiR3R
				lampswitches->setValue(15,false); //SpLiR3W
			}
			else if (status == 2)
			{
				lampswitches->setValue(8,false); //SpLiL3R
				lampswitches->setValue(9,true);  //SpLiL3W
				lampswitches->setValue(14,false); //SpLiR3R
				lampswitches->setValue(15,true); //SpLiR3W
			}
		}
		else if (type == ShipActor::LampTypes::OPS_DANGER_LIGHT_PAIR)
		{
			if (status == 0) 
			{
				lampswitches->setValue(16,false); //ODLiL
				lampswitches->setValue(17,false); //ODLiR
			} 
			else if (status == 1)
			{
				lampswitches->setValue(16,true);  //ODLiL
				lampswitches->setValue(17,false); //ODLiR
			}
			else if (status == 2)
			{
				lampswitches->setValue(16,false); //ODLiL
				lampswitches->setValue(17,true);  //ODLIR
			}
		}
		else if (type == ShipActor::LampTypes::SPECIAL_CBD_MODE)
		{
			if (status == 0) 
			{
				SetLampStatus( ShipActor::LampTypes::SPECIAL_LIGHT_TOP,0);
				SetLampStatus( ShipActor::LampTypes::SPECIAL_LIGHT_MIDDLE,0);
				SetLampStatus( ShipActor::LampTypes::SPECIAL_LIGHT_BOTTOM,0);
			} 
			else 
			{
				SetLampStatus( ShipActor::LampTypes::SPECIAL_LIGHT_TOP, 1 );
				SetLampStatus( ShipActor::LampTypes::SPECIAL_LIGHT_MIDDLE, 1 );
				SetLampStatus( ShipActor::LampTypes::SPECIAL_LIGHT_BOTTOM, 1 );
			}

		}
		else if (type == ShipActor::LampTypes::SPECIAL_RAM_MODE)
		{
			if (status == 0) 
			{
				SetLampStatus( ShipActor::LampTypes::SPECIAL_LIGHT_TOP, 0 );
				SetLampStatus( ShipActor::LampTypes::SPECIAL_LIGHT_MIDDLE, 0 );
				SetLampStatus( ShipActor::LampTypes::SPECIAL_LIGHT_BOTTOM, 0 );
			} 
			else 
			{
				SetLampStatus( ShipActor::LampTypes::SPECIAL_LIGHT_TOP, 1 );
				SetLampStatus( ShipActor::LampTypes::SPECIAL_LIGHT_MIDDLE, 2 );
				SetLampStatus( ShipActor::LampTypes::SPECIAL_LIGHT_BOTTOM, 1 );
			}

		}
		else if (type == ShipActor::LampTypes::SPECIAL_NUC_MODE)
		{
			if (status == 0) 
			{
				SetLampStatus( ShipActor::LampTypes::SPECIAL_LIGHT_TOP, 0 );
				SetLampStatus( ShipActor::LampTypes::SPECIAL_LIGHT_MIDDLE, 0 );
				SetLampStatus( ShipActor::LampTypes::SPECIAL_LIGHT_BOTTOM, 0 );
			} 
			else 
			{
				SetLampStatus( ShipActor::LampTypes::SPECIAL_LIGHT_TOP, 1 );
				SetLampStatus( ShipActor::LampTypes::SPECIAL_LIGHT_MIDDLE, 1 );
				SetLampStatus( ShipActor::LampTypes::SPECIAL_LIGHT_BOTTOM, 0 );
			}

		}
	}
}

short ShipModelActor::GetLampStatus( LampTypes &type )
{
	if (lampswitches.get()) {
		if (type == ShipActor::LampTypes::ANCHOR_LIGHT)
		{
			return lampswitches->getValue(0); //AnLi

		}
		else if (type == ShipActor::LampTypes::STERN_LIGHT)
		{
			return lampswitches->getValue(2);  //StnLi
		}
		else if (type == ShipActor::LampTypes::MASTHEAD_LIGHT)
		{
			return lampswitches->getValue(4);  //MHLi
		}
		else if (type == ShipActor::LampTypes::MASTHEAD_LIGHT2)
		{
			return lampswitches->getValue(6);  //MHLi2
		}
		else if (type == ShipActor::LampTypes::PORT_LIGHT) 
		{
			return lampswitches->getValue(8);  //PoLi
		}
		else if (type == ShipActor::LampTypes::STARBOARD_LIGHT)
		{
			return lampswitches->getValue(10);  //StbLi
		}
		else if (type == ShipActor::LampTypes::SPECIAL_LIGHT_TOP)
		{
			if (lampswitches->getValue(13)) //SpLiL1R
			{
				return 1;
			} 
			else if (lampswitches->getValue(14)) //SpLiL1R
			{
				return 2;
			}
			else 
			{
				return 0;
			}
		}
		else if (type == ShipActor::LampTypes::SPECIAL_LIGHT_MIDDLE)
		{
			if (lampswitches->getValue(16)) //SpLiL2R
			{
				return 1;
			} 
			else if (lampswitches->getValue(17)) //SpLiL2R
			{
				return 2;
			}
			else 
			{
				return 0;
			}
		}
		else if (type == ShipActor::LampTypes::SPECIAL_LIGHT_BOTTOM)
		{
			if (lampswitches->getValue(19)) //SpLiL3R
			{
				return 1;
			} 
			else if (lampswitches->getValue(20)) //SpLiL3R
			{
				return 2;
			}
			else 
			{
				return 0;
			}
		}
		else if (type == ShipActor::LampTypes::OPS_DANGER_LIGHT_PAIR)
		{
			return lampswitches->getValue(30); //ODLiL
		}
		else if (type == ShipActor::LampTypes::SPECIAL_CBD_MODE)
		{

			return ((GetLampStatus(ShipActor::LampTypes::SPECIAL_LIGHT_TOP) == 1)
				&& (GetLampStatus(ShipActor::LampTypes::SPECIAL_LIGHT_MIDDLE) == 1)
				&& (GetLampStatus(ShipActor::LampTypes::SPECIAL_LIGHT_BOTTOM) == 1)
				);

		}
		else if (type == ShipActor::LampTypes::SPECIAL_RAM_MODE)
		{
			return ((GetLampStatus(ShipActor::LampTypes::SPECIAL_LIGHT_TOP) == 1)
				&& (GetLampStatus(ShipActor::LampTypes::SPECIAL_LIGHT_MIDDLE) == 2)
				&& (GetLampStatus(ShipActor::LampTypes::SPECIAL_LIGHT_BOTTOM) == 1)
				);
		}
		else if (type == ShipActor::LampTypes::SPECIAL_NUC_MODE)
		{
			return ((GetLampStatus(ShipActor::LampTypes::SPECIAL_LIGHT_TOP) == 1)
				&& (GetLampStatus(ShipActor::LampTypes::SPECIAL_LIGHT_MIDDLE) == 1)
				&& (GetLampStatus(ShipActor::LampTypes::SPECIAL_LIGHT_BOTTOM) == 0)
				);
		}
		else
			return -1;
	} 
	else
		return -1;
}


void ShipModelActor::SetShipLamp(int nValue)
{
	switch (nValue)
	{
	case ORD_AnchorLight: 
		SetLampStatus(LampTypes::ANCHOR_LIGHT,1);
		break;
	case ORD_AnchorLightOff: 
		SetLampStatus(LampTypes::ANCHOR_LIGHT,0);
		break;
	case ORD_SternLight: 
		SetLampStatus(LampTypes::STERN_LIGHT,1);
		break;
	case ORD_SternLightOff: 
		SetLampStatus(LampTypes::STERN_LIGHT,0);
		break;
	case ORD_MastheadLight: 
		SetLampStatus(LampTypes::MASTHEAD_LIGHT,1);
		break;
	case ORD_MastheadLightOff: 
		SetLampStatus(LampTypes::MASTHEAD_LIGHT,0);
		break;
	case ORD_MastheadLight2: 
		SetLampStatus(LampTypes::MASTHEAD_LIGHT2,1);
		break;
	case ORD_MastheadLight2Off: 
		SetLampStatus(LampTypes::MASTHEAD_LIGHT2,0);
		break;
	case ORD_PortLight: 
		SetLampStatus(LampTypes::PORT_LIGHT,1);
		break;
	case ORD_PortLightOff: 
		SetLampStatus(LampTypes::PORT_LIGHT,0);
		break;
	case ORD_StarboardLight: 
		SetLampStatus(LampTypes::STARBOARD_LIGHT,1);
		break;
	case ORD_StarboardLightOff: 
		SetLampStatus(LampTypes::STARBOARD_LIGHT,0);
		break;
	case ORD_SpecialLightTop0: 
		SetLampStatus(LampTypes::SPECIAL_LIGHT_TOP,0);
		break;
	case ORD_SpecialLightTop1: 
		SetLampStatus(LampTypes::SPECIAL_LIGHT_TOP,1);
		break;
	case ORD_SpecialLightTop2: 
		SetLampStatus(LampTypes::SPECIAL_LIGHT_TOP,2);
		break;
	case ORD_SpecialLightMid0: 
		SetLampStatus(LampTypes::SPECIAL_LIGHT_MIDDLE,0);
		break;
	case ORD_SpecialLightMid1: 
		SetLampStatus(LampTypes::SPECIAL_LIGHT_MIDDLE,1);
		break;
	case ORD_SpecialLightMid2: 
		SetLampStatus(LampTypes::SPECIAL_LIGHT_MIDDLE,2);
		break;
	case ORD_SpecialLightBot0: 
		SetLampStatus(LampTypes::SPECIAL_LIGHT_BOTTOM,0);
		break;
	case ORD_SpecialLightBot1: 
		SetLampStatus(LampTypes::SPECIAL_LIGHT_BOTTOM,1);
		break;
	case ORD_SpecialLightBot2: 
		SetLampStatus(LampTypes::SPECIAL_LIGHT_BOTTOM,2);
		break;
	case ORD_SpecialCBD0: 
		SetLampStatus(LampTypes::SPECIAL_CBD_MODE,0);
		break;
	case ORD_SpecialCBD1: 
		SetLampStatus(LampTypes::SPECIAL_CBD_MODE,1);
		break;
	case ORD_SpecialRAM0: 
		SetLampStatus(LampTypes::SPECIAL_RAM_MODE,0);
		break;
	case ORD_SpecialRAM1: 
		SetLampStatus(LampTypes::SPECIAL_RAM_MODE,1);
		break;
	case ORD_SpecialNUC0: 
		SetLampStatus(LampTypes::SPECIAL_NUC_MODE,0);
		break;
	case ORD_SpecialNUC1: 
		SetLampStatus(LampTypes::SPECIAL_NUC_MODE,1);
		break;
	case ORD_OpsDangerLightPair0: 
		SetLampStatus(LampTypes::OPS_DANGER_LIGHT_PAIR,0);
		break;
	case ORD_OpsDangerLightPair1: 
		SetLampStatus(LampTypes::OPS_DANGER_LIGHT_PAIR,1);
		break;
	case ORD_OpsDangerLightPair2: 
		SetLampStatus(LampTypes::OPS_DANGER_LIGHT_PAIR,2);
		break;
	}
	std::cout<<GetName()<<" Set Status Lampu "<<nValue<<std::endl;

}

void ShipModelActor::InitLamps()
{
	dtCore::RefPtr<dtUtil::NodeCollector> collector = new dtUtil::NodeCollector(GetOSGNode(), dtUtil::NodeCollector::SwitchFlag);
	lampswitches = collector->GetSwitch("SwitchLampu"); 

	if (lampswitches.get() )
	{
		osg::Switch *sw = lampswitches.get() ;
		sw->setAllChildrenOff();
		std::cout<<"   ** "<<GetName()<<" Lamps Switch initializing..."<<std::endl;

	}
	else 
		std::cout<<"   ** "<<GetName()<<" Lamps Switch not initializing..."<<std::endl;

}
void ShipModelActor::InitSosok()
{
	dtCore::RefPtr<dtUtil::NodeCollector> collector = new dtUtil::NodeCollector(GetOSGNode(), dtUtil::NodeCollector::SwitchFlag);
	sosokswitches = collector->GetSwitch("SwitchSosok"); 
	if (sosokswitches.get() )
	{
		std::cout<<"   ** "<<GetName()<<" Sosok Switch initializing..."<<std::endl;
		osg::Switch *sw = sosokswitches.get() ;
		sw->setAllChildrenOff();
		GetGameActorProxy().AddProperty(new dtDAL::StringActorProperty("SosokProperty","SosokProperty",
			dtDAL::StringActorProperty::SetFuncType(this, &ShipModelActor::SetSosokProperty),
			dtDAL::StringActorProperty::GetFuncType(this, &ShipModelActor::GetSosokProperty), "Sets/gets SosokProperty.", C_TYPE_SHIP));
	}
	else 
		std::cout<<"   ** "<<GetName()<<" Sosok Switch not initializing..."<<std::endl;
}

void ShipModelActor::InitWeaponSwitch()
{
	dtCore::RefPtr<dtUtil::NodeCollector> collector = new dtUtil::NodeCollector(GetOSGNode(), dtUtil::NodeCollector::SwitchFlag);
	weaponswitches = collector->GetSwitch("SwitchWeapon"); 
	if (weaponswitches.get() )
	{
		std::cout<<"   ** "<<GetName()<<" Weapon Switch initializing..."<<std::endl;
		osg::Switch *sw = weaponswitches.get() ;
		sw->setAllChildrenOn();	 
	} 
	else
		std::cout<<"   ** "<<GetName()<<" Weapon Switch not initializing..."<<std::endl;
}

void ShipModelActor::InitGunSwitch()
{
	dtCore::RefPtr<dtUtil::NodeCollector> collector = new dtUtil::NodeCollector(GetOSGNode(), dtUtil::NodeCollector::SwitchFlag);
	gunswitches = collector->GetSwitch("GunHitSwitch");
	if (gunswitches.get()){
		std::cout<<"   ** "<<GetName()<<" Gun Target Switch initializing..."<<std::endl;

		osg::Switch *sg = gunswitches.get();
		sg->setAllChildrenOff();
	}
	else
		std::cout<<"   ** "<<GetName()<<" Gun Target Switch not initializing..."<<std::endl;
}

//////////////////////////////////////////////////////////////////////////

bool ShipModelActor::IsValidNode(dtCore::RefPtr <osg::Switch> swIN, const int idx) 
{
	bool valid = false ;
	
	osg::Switch *sw = swIN.get() ;
    osg::Node* childNode = sw->getChild(idx);
	if (childNode) 
		valid = true ;
	else
		std::cout<<"WARNING !!! Set Switch invalid node";

	return valid ;
}

void ShipModelActor::SetWeaponsSwitchProperty(const std::string& sprop) 
{
	if (sprop.empty())
	{
		return;
	}

	if (weaponswitches.get() )
	{
		mWeaponSwitch = sprop ;
		std::string::iterator it;
		int idx = -1 ;

		std::ostringstream oss1;
		std::ostringstream oss2;

		for ( it=mWeaponSwitch.begin() ; it < mWeaponSwitch.end(); it++ )
		{
			idx ++ ;
			int val = (int)*it ;

			if ( IsValidNode(weaponswitches,idx) )
			{
				/*bool bcek  = weaponswitches->getValue(idx);
				
				int icek   ;

				if ( bcek )
					icek = 1 ;
				else
					icek = 0 ;


				if ( icek != val )
				{
					if ( icek == 0 )
					{
						weaponswitches->setValue(idx,false);
						std::cout<<GetVehicleID()<<" "<<idx<<" false "<<std::endl;
					}
					else 
					{
						weaponswitches->setValue(idx,true);
						std::cout<<GetVehicleID()<<" "<<idx<<" true "<<std::endl;
					}
				}*/

				oss1 << *it;
				oss2 << weaponswitches->getValue(idx);

			}
			else
				std::cout<<"WARNING INVALID NODE WEAPON SWITCH"<<std::endl;

		}
		
		std::cout<<"origin ::: "<<oss1.str()<<std::endl;
		std::cout<<"setted ::: "<<oss2.str()<<std::endl;
	}
}

std::string ShipModelActor::GetWeaponsSwitchProperty() 
{
	if ( GetGameActorProxy().GetGameManager()->GetMachineInfo().GetName()== C_MACHINE_SERVER )
	{
		std::ostringstream oss;
		if (weaponswitches.get() )
		{
			osg::Switch *sw = weaponswitches.get() ;
			for (unsigned i = 0; i < sw->getNumChildren(); ++i)
			{
				osg::Node* childNode = sw->getChild(i);
				if (childNode)
				{
					oss << weaponswitches->getChildValue(childNode);
				}
			}
		}

		std::cout<<"getted ::: "<<oss.str()<<std::endl;
		return oss.str();
	}
	else
		return (" ");
}


void ShipModelActor::SetMissileTargetProperty(const std::string& sprop) 
{
	if (sprop.empty())
	{
		return;
	}
	
	if (targetswitches.get() )
	{
		std::string str = sprop ;
		std::string::iterator it;
		int idx = -1 ;

		//std::ostringstream oss1;
		//std::ostringstream oss2;

		for ( it=str.begin() ; it < str.end(); it++ )
		{
			idx ++ ;

			int val = (int)*it ;
			if ( val == 0 )
				targetswitches->setValue(idx,false);
			else  
				targetswitches->setValue(idx,true);

			//oss1 << idx<<"-"<<*it<<", ";
			//oss2 << idx<<"-"<<targetswitches->getValue(idx)<<", ";

		}

		//std::cout<<"origin ::: "<<oss1.str()<<std::endl;
		//std::cout<<"setted ::: "<<oss2.str()<<std::endl;
	}  
}

std::string ShipModelActor::GetMissileTargetProperty() const
{
	std::ostringstream oss;
	if (targetswitches.get() )
	{
		osg::Switch *sw = targetswitches.get() ;
		for (unsigned i = 0; i < sw->getNumChildren(); ++i)
		{
			osg::Node* childNode = sw->getChild(i);
			if (childNode)
			{
				//oss << targetswitches->getValue(i);
				oss << targetswitches->getChildValue(childNode);
			}
		}
	}
	return oss.str();
}

void ShipModelActor::SetGunTargetProperty(const std::string& sprop) 
{
	if (sprop.empty())
	{
		return;
	}

	if (gunswitches.get() )
	{
		std::string str = sprop ;
		std::string::iterator it;
		int idx = -1 ;

		for ( it=str.begin() ; it < str.end(); it++ )
		{
			idx ++ ;

			int val = (int)*it ;
			if ( val == 0 )
				gunswitches->setValue(idx,false);
			else 
				gunswitches->setValue(idx,true);
		}
	}
}

std::string ShipModelActor::GetGunTargetProperty() const
{
	std::ostringstream oss;
	if (gunswitches.get() )
	{
		osg::Switch *sw = gunswitches.get() ;
		for (unsigned i = 0; i < sw->getNumChildren(); ++i)
		{
			osg::Node* childNode = sw->getChild(i);
			if (childNode)
			{
				//oss << targetswitches->getValue(i);
				oss << gunswitches->getChildValue(childNode);
			}
		}
	}
	return oss.str();
}

void ShipModelActor::SetSosokProperty(const std::string& sprop) 
{
	if (sprop.empty())
	{
		return;
	}

	if (sosokswitches.get() )
	{
		std::string str = sprop ;
		std::string::iterator it;
		int idx = -1 ;

		for ( it=str.begin() ; it < str.end(); it++ )
		{
			idx ++ ;

			int val = (int)*it ;
			if ( val == 0 )
				sosokswitches->setValue(idx,false);
			else 
				sosokswitches->setValue(idx,true);

		}
	}
}

std::string ShipModelActor::GetSosokProperty() const
{
	std::ostringstream oss;
	if (sosokswitches.get() )
	{
		osg::Switch *sw = sosokswitches.get() ;
		for (unsigned i = 0; i < sw->getNumChildren(); ++i)
		{
			osg::Node* childNode = sw->getChild(i);
			if (childNode)
			{
				//oss << targetswitches->getValue(i);
				oss << sosokswitches->getChildValue(childNode);
			}
		}
	}
	return oss.str();
}

void ShipModelActor::SetLampsProperty(const std::string& sprop) 
{
	if (sprop.empty())
	{
		return;
	}

	if (lampswitches.get() )
	{
		std::string str = sprop ;
		std::string::iterator it;
		int idx = -1 ;

		for ( it=str.begin() ; it < str.end(); it++ )
		{
			idx ++ ;

			int val = (int)*it ;
			if ( val == 0 )
				lampswitches->setValue(idx,false);
			else 
				lampswitches->setValue(idx,true);

		}
	}
}

std::string ShipModelActor::GetLampsProperty() const
{
	std::ostringstream oss;
	if (lampswitches.get() )
	{
		osg::Switch *sw = lampswitches.get() ;
		for (unsigned i = 0; i < sw->getNumChildren(); ++i)
		{
			osg::Node* childNode = sw->getChild(i);
			if (childNode)
			{
				//oss << targetswitches->getValue(i);
				oss << lampswitches->getChildValue(childNode);
			}
		}
	}
	return oss.str();
}

//////////////////////////////////////////////////////////////////////////
void ShipModelActor::UpdateOceanWaveVars()
{
	if ( GetGameActorProxy().GetGameManager()->GetMachineInfo().GetName()== C_MACHINE_SERVER )
	{
		float x,y,z,h,p,r;

		position.Get(x, y, z, h, p, r);

		osg::Vec3 mXYZ(x,y,z);
		osg::Vec3 mHPR(h,p,r) ;
		dtGame::IEnvGameActorProxy* envActorProxy = GetGameActorProxy().GetGameManager()->GetEnvironmentActor();
		OceanActor* actor = NULL;

		if (envActorProxy )
			actor = dynamic_cast<OceanActor*> (envActorProxy->GetActor());
		if (actor != NULL)
		{

			osg::Vec3 normal;
			float height = ( actor->GetOceanSurfaceHeightAt(mXYZ.x(),mXYZ.y(), &normal));// * 0.01;// * 0.0001;  
			float oceanDT = oceanLastDeltaTime - C_UPDATEALLOBJECT_CYCLE_TIME_3D;

			//float heightSpeed = (height - oceanHeightLast) / C_UPDATEALLOBJECT_CYCLE_TIME_3D;
			//osg::Vec3 normalSpeed = (normal - oceanNormalLast)  / C_UPDATEALLOBJECT_CYCLE_TIME_3D;

			SetOceanHeight(height);
			//SetOceanNormal(normal);
			SetOceanNormalX(normal.x());
			SetOceanNormalY(normal.y());
			SetOceanNormalZ(normal.z());
			SetOceanDeltaTime(oceanDT);

			//oceanHeightLast = height;
			//oceanNormalLast = normal;
		}
	}
}
//////////////////////////////////////////////////////////////////////////

void ShipModelActor::CalculateOceanWaveVars()
{
    //std::cout<<"------------- ShipActor::UpdatePosition ---------------"<<std::endl;
    //std::cout<<"    oceanHeightLast = "<< oceanHeightLast <<". oceanHeight = "<< oceanHeight <<std::endl;
    //std::cout<<"    oceanNormalLast.x() = "<<  oceanNormalLast.x() <<". oceanNormal.x() = "<<  oceanNormal.x() <<std::endl;
    //std::cout<<"    oceanNormalLast.y() = "<<  oceanNormalLast.y() <<". oceanNormal.y() = "<<  oceanNormal.y() <<std::endl;
    //std::cout<<"    oceanNormalLast.z() = "<<  oceanNormalLast.z() <<". oceanNormal.z() = "<<  oceanNormal.z() <<std::endl;

    oceanHeightSpeed = (oceanHeight - oceanHeightLast) / C_UPDATEALLOBJECT_CYCLE_TIME_3D;
    //oceanNormalSpeed.set( (oceanNormal.x() - oceanNormalLast.x()) / C_UPDATEALLOBJECT_CYCLE_TIME_3D,
    //                       (oceanNormal.y() - oceanNormalLast.y()) / C_UPDATEALLOBJECT_CYCLE_TIME_3D,
    //                      (oceanNormal.z() - oceanNormalLast.z()) / C_UPDATEALLOBJECT_CYCLE_TIME_3D );

    oceanNormalSpeed.set( (oceanNormalX - oceanNormalLast.x()) / C_UPDATEALLOBJECT_CYCLE_TIME_3D,
                          (oceanNormalY - oceanNormalLast.y()) / C_UPDATEALLOBJECT_CYCLE_TIME_3D,
                          (oceanNormalZ - oceanNormalLast.z()) / C_UPDATEALLOBJECT_CYCLE_TIME_3D );

}

void ShipModelActor::CalculateTrueValues(float elapsedTime)
{
	trueHeight += ( oceanHeightSpeed * elapsedTime * 0.5 );

	trueHeight = ((trueHeight > (oceanHeightLast + 0.5) && oceanHeightSpeed > 0) || ( trueHeight < (oceanHeightLast + 0.5) && oceanHeightSpeed < 0)) ? 
		 (oceanHeightLast + 0.5) : trueHeight;
	float trueX, trueY, trueZ;

	trueX =  trueNormal.x() + ( oceanNormalSpeed.x() * elapsedTime );
	trueY =  trueNormal.y() + ( oceanNormalSpeed.y() * elapsedTime );
	trueZ =  trueNormal.z() + ( oceanNormalSpeed.z() * elapsedTime );

	trueX = ((trueX > oceanNormalLast.x() && oceanNormalSpeed.x() > 0) || ( trueX < oceanNormalLast.x() && oceanNormalSpeed.x() < 0)) ? 
	  oceanNormalLast.x() : trueX;
	trueY = ((trueY > oceanNormalLast.y() && oceanNormalSpeed.y() > 0) || ( trueY < oceanNormalLast.y() && oceanNormalSpeed.y() < 0)) ? 
	  oceanNormalLast.y() : trueY;
	trueZ = ((trueZ > oceanNormalLast.z() && oceanNormalSpeed.z() > 0) || ( trueZ < oceanNormalLast.z() && oceanNormalSpeed.z() < 0)) ? 
	  oceanNormalLast.z() : trueZ;

	trueNormal.set(  trueX,
				   trueY,
				   trueZ
				);
}

void ShipModelActor::ResetOceanWaveVars()
{
    oceanHeight = 0.0f;
    //oceanNormal.set(0.0f, 0.0f, 0.0f);
    oceanNormalX = 0.0f;
    oceanNormalY = 0.0f;
    oceanNormalZ = 0.0f;
    oceanHeightLast = 0.0f;
    oceanNormalLast.set(0.0f, 0.0f, 0.0f);
    oceanHeightSpeed = 0.0f;
    oceanNormalSpeed.set(0.0f, 0.0f, 0.0f);
    oceanLastDeltaTime = 0.0f;
    trueHeight = 0.0f;
    trueNormal.set(0.0f, 0.0f, 0.0f);
    
    polyOceanHeight[0] = 0.0f; //Initial value always 0

    polyOceanNormalX[0] = 0.0f; //Initial value always 0
    polyOceanNormalY[0] = 0.0f; //Initial value always 0
    polyOceanNormalZ[0] = 0.0f; //Initial value always 0
    
    for (int i = 1; i < 3; ++i)
    {
        polyOceanHeight[i] = UNINITIALIZED_WAVE_VALUE;

        polyOceanNormalX[i] = UNINITIALIZED_WAVE_VALUE;
        polyOceanNormalY[i] = UNINITIALIZED_WAVE_VALUE;
        polyOceanNormalZ[i] = UNINITIALIZED_WAVE_VALUE;
    }

    //Reset the position
     float x,y,z,h,p,r;
     float p51Bearing = ConvertTodtCoreBearing(course);
     float p51Pitch = ConvertTodtCoreBearing(pitch); //pitch;//

     position.Get(x, y, z, h, p, r);

     position.Set(x, y, 0.5f, p51Bearing, 0.0f , 0.0f );
}

void ShipModelActor::CalculatePolyOceanWaveVars()
{
    //std::cout<<"------------- ShipActor::CalculatePolyOceanWaveVars ----------------------------------------------------------------------------------------------------------"<<std::endl;
    osg::Vec3 XYZ, HPR;
    position.Get(XYZ, HPR);
    
    if (polyOceanHeight[1] == UNINITIALIZED_WAVE_VALUE)
    {
        polyOceanHeight[1] = oceanHeight;
        polyOceanNormalX[1] = oceanNormalX;        
        polyOceanNormalY[1] = oceanNormalY;        
        polyOceanNormalZ[1] = oceanNormalZ;        
    }    
    else if (polyOceanHeight[2] == UNINITIALIZED_WAVE_VALUE)
    {
        //polyOceanHeight[1] = trueHeight;    
        polyOceanHeight[2] = oceanHeight; 
        
        //polyOceanNormalX[1] = trueNormal.x();  
        polyOceanNormalX[2] = oceanNormalX;       
        
        //polyOceanNormalY[1] = trueNormal.y();  
        polyOceanNormalY[2] = oceanNormalY;        
        
        //polyOceanNormalZ[1] = trueNormal.z();  
        polyOceanNormalZ[2] = oceanNormalZ;        
    }    
    else
    {
        polyOceanHeight[0] = polyOceanHeight[1];        
        polyOceanHeight[1] = polyOceanHeight[2];
        polyOceanHeight[2] = oceanHeight; 
               
        polyOceanNormalX[0] = polyOceanNormalX[1];        
        polyOceanNormalX[1] = polyOceanNormalX[2];
        polyOceanNormalX[2] = oceanNormalX;                             
        
        polyOceanNormalY[0] = polyOceanNormalY[1];        
        polyOceanNormalY[1] = polyOceanNormalY[2];
        polyOceanNormalY[2] = oceanNormalY;
        
        polyOceanNormalZ[0] = polyOceanNormalZ[1];        
        polyOceanNormalZ[1] = polyOceanNormalZ[2];
        polyOceanNormalZ[2] = oceanNormalZ;
    }
    
}

void ShipModelActor::CalculatePolyTrueValues(float elapsedTime)
{

    float LHeight = 0;    
    float LNormalX = 0;    
    float LNormalY = 0;    
    float LNormalZ = 0;
    float trueX = 0;
    float trueY = 0;
    float trueZ = 0;


    trueHeight = 0;
    float x_value = oceanLastDeltaTime > C_UPDATEALLOBJECT_CYCLE_TIME_3D? C_UPDATEALLOBJECT_CYCLE_TIME_3D * 2 : oceanLastDeltaTime + C_UPDATEALLOBJECT_CYCLE_TIME_3D;
    
    if (polyOceanHeight[2] != UNINITIALIZED_WAVE_VALUE) // Lagrange interpolating polynomial 
    {                 

        for (int i = 0; i < 3; ++i)
        {            
            LHeight = polyOceanHeight[i];
            LNormalX = polyOceanNormalX[i];
            LNormalY = polyOceanNormalY[i];
            LNormalZ = polyOceanNormalZ[i];
            
            for (int j = 0; j < 3; ++j)
            {
                if (i!=j)
                {
                    LHeight *= (x_value - NUMERATOR_DATA[j]);
                    LNormalX *= (x_value - NUMERATOR_DATA[j]);
                    LNormalY *= (x_value - NUMERATOR_DATA[j]);
                    LNormalZ *= (x_value - NUMERATOR_DATA[j]);
                }                
            }
            LHeight /= DENOMINATOR_THREE_DATA[i];
            LNormalX /= DENOMINATOR_THREE_DATA[i];
            LNormalY /= DENOMINATOR_THREE_DATA[i];
            LNormalZ /= DENOMINATOR_THREE_DATA[i];           
            
            trueHeight += LHeight;
            trueX += LNormalX;
            trueY += LNormalY;
            trueZ += LNormalZ;
        }        
    }
    else if ( polyOceanHeight[1] != UNINITIALIZED_WAVE_VALUE ) // linier formula from 2 points
    {
        for (int i = 0; i < 2; ++i)
        {            
            LHeight = polyOceanHeight[i];
            LNormalX = polyOceanNormalX[i];
            LNormalY = polyOceanNormalY[i];
            LNormalZ = polyOceanNormalZ[i];
            
            for (int j = 0; j < 2; ++j)
            {
                if (i!=j)
                {
                    LHeight *= (oceanLastDeltaTime - NUMERATOR_DATA[j]);
                    LNormalX *= (oceanLastDeltaTime - NUMERATOR_DATA[j]);
                    LNormalY *= (oceanLastDeltaTime - NUMERATOR_DATA[j]);
                    LNormalZ *= (oceanLastDeltaTime - NUMERATOR_DATA[j]);
                }                
            }
            LHeight /= DENOMINATOR_TWO_DATA[i];
            LNormalX /= DENOMINATOR_TWO_DATA[i];
            LNormalY /= DENOMINATOR_TWO_DATA[i];
            LNormalZ /= DENOMINATOR_TWO_DATA[i];          
            
            trueHeight += LHeight;
            trueX += LNormalX;
            trueY += LNormalY;
            trueZ += LNormalZ;
        }
    }
    
    //trueHeight = fabs(trueHeight) > fabs(oceanHeight) ? oceanHeight : trueHeight;
    //trueX = fabs(trueX) > fabs(oceanNormalX) ? oceanNormalX : trueX;
    //trueY = fabs(trueY) > fabs(oceanNormalY) ? oceanNormalY : trueY;
    //trueZ = fabs(trueZ) > fabs(oceanNormalZ) ? oceanNormalZ : trueZ;
    
    //DEBUG!!!! ALWAYS SET TO 45
    //trueY = osg::DegreesToRadians((float) 45);

    
    trueNormal.set( trueX,
                    trueY,
                    trueZ
                  );
                  
    //std::cout<<"------------- ShipActor::UpdatePosition ---------------"<<std::endl;
    //std::cout<<"    oceanHeightLast = "<< oceanHeightLast <<". oceanHeight = "<< oceanHeight <<std::endl;
    //std::cout<<"    oceanLastDeltaTime = "<< oceanLastDeltaTime <<". elapsedTime = "<< elapsedTime <<std::endl;
    //std::cout<<"    oceanNormalLast.x() = "<<  oceanNormalLast.x() <<". oceanNormalX = "<<  oceanNormalX <<std::endl;
    //std::cout<<"    oceanNormalLast.y() = "<<  oceanNormalLast.y() <<". oceanNormalY = "<<  oceanNormalY <<std::endl;
    //std::cout<<"    oceanNormalLast.z() = "<<  oceanNormalLast.z() <<". oceanNormalZ = "<<  oceanNormalZ <<std::endl;
    //std::cout<<"    trueHeight = "<<  trueHeight <<std::endl;
    
    //std::ostringstream debug;
    //debug << " x_value: "<< x_value ;
    //debug << " X: "<< trueX ;
    //debug << " Y: "<< trueY ;
    //debug << " Z: "<< trueZ ;

    ////throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
    //mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
    //    debug.str());
    //
}

void ShipModelActor::SetParticlePosition(const std::string &dofName,const std::string &fileName, dtCore::ParticleSystem *tParticle , bool e )
{
	dtCore::RefPtr<osgDB::ReaderWriter::Options> options = new osgDB::ReaderWriter::Options();
	options->setObjectCacheHint(osgDB::ReaderWriter::Options::CACHE_NONE);
	osg::Node *model = this->GetOSGNode();

	dtCore::RefPtr<dtUtil::NodeCollector> mtColector = new dtUtil::NodeCollector(model, dtUtil::NodeCollector::DOFTransformFlag);
	osgSim::DOFTransform *mDOF = mtColector->GetDOFTransform(dofName);

	if (mDOF != NULL)
	{
		tParticle = new dtCore::ParticleSystem;
		tParticle->LoadFile(fileName,true);
		mDOF->addChild(tParticle->GetOSGNode());
		tParticle->SetEnabled(e);
	}
}

//////////////////////////////////////////////////////////////////////////
void ShipModelActor::OnEnteredWorld()
{
	AddSender(&(GetGameActorProxy().GetGameManager()->GetScene()));
	SetSoundFile();
	SetParticleFile();
	PlayStackSound();
	//InitLamps() ;
	//InitSosok();
	if ( GetIsTarget() )
	{
		InitTargetSwitch();
		InitGunSwitch();
		
	} else
	{
		InitTargetSwitch();
		InitGunSwitch();
		InitWeaponSwitch();
	}
}

void ShipModelActor::OnRemovedFromWorld()
{ 
	//
}
//////////////////////////////////////////////////////////////////////////

void ShipModelActorProxy::OnEnteredWorld()
{
	ShipActorProxy::OnEnteredWorld();
	RegisterForMessages(SimMessageType::ORDER_EVENT, dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
	RegisterForMessages(dtGame::MessageType::TICK_LOCAL, dtGame::GameActorProxy::TICK_LOCAL_INVOKABLE);
    GetActor()->AddSender(&(GetGameManager()->GetScene()));
}

void ShipModelActorProxy::OnRemovedFromWorld()
{ 
	ShipModelActor &ship = static_cast<ShipModelActor&>(GetGameActor());

	if (dtAudio::AudioManager::GetInstance().IsInitialized() )
	{
		if ( ship.stackSound != NULL ) dtAudio::AudioManager::GetInstance().FreeSound(ship.stackSound);
		if ( ship.collisionSound != NULL ) dtAudio::AudioManager::GetInstance().FreeSound(ship.collisionSound);
		if ( ship.collisionSound2 != NULL ) dtAudio::AudioManager::GetInstance().FreeSound(ship.collisionSound2);
	}	 
}