#include "SubMarineActor.h"
#include "OceanActor.h"
#include "didactorssources.h"

using namespace   dtAudio;
using namespace	  dtCore;
using namespace   dtUtil;
using namespace   osgOcean;
using namespace   didEnviro;

/////////////////////////////////////////////////

//Constant
const float MaxSpeed = 50.0f;
const float SubMarineActor::COLLISION_SND_TIMEOUT = 6.0f;

SubMarineActorProxy::SubMarineActorProxy(){}
SubMarineActorProxy::~SubMarineActorProxy(){}

void SubMarineActorProxy::BuildPropertyMap()
{
	VehicleActorProxy::BuildPropertyMap();

	SubMarineActor* kri = NULL ;

	GetActor(kri);

	AddProperty(new dtDAL::StringActorProperty(C_SET_MODEL,C_SET_MODEL,
	   dtDAL::StringActorProperty::SetFuncType(kri,&SubMarineActor::LoadModelFile),
	   dtDAL::StringActorProperty::GetFuncType(kri,&SubMarineActor::GetMeshFile), "Loads the model file for the ship", C_TYPE_SHIP));

	AddProperty(new dtDAL::FloatActorProperty(C_SET_SPEED,C_SET_SPEED,
	   dtDAL::FloatActorProperty::SetFuncType(kri, &SubMarineActor::SetSpeed),
	   dtDAL::FloatActorProperty::GetFuncType(kri, &SubMarineActor::GetSpeed), "Sets/gets speed.",C_TYPE_SHIP));

	AddProperty(new dtDAL::FloatActorProperty("Pitch","Pitch",
	   dtDAL::FloatActorProperty::SetFuncType(kri, &SubMarineActor::SetPitch),
	   dtDAL::FloatActorProperty::GetFuncType(kri, &SubMarineActor::GetPitch), "Sets/gets pitch.", C_TYPE_SHIP));

	AddProperty(new dtDAL::FloatActorProperty("Heel","Heel",
	   dtDAL::FloatActorProperty::SetFuncType(kri, &SubMarineActor::SetHeel),
	   dtDAL::FloatActorProperty::GetFuncType(kri, &SubMarineActor::GetHeel), "Sets/gets heel.", C_TYPE_SHIP));

	AddProperty(new dtDAL::FloatActorProperty(C_SET_COURSE,C_SET_COURSE,
		dtDAL::FloatActorProperty::SetFuncType(kri, &SubMarineActor::SetCourse),
		dtDAL::FloatActorProperty::GetFuncType(kri, &SubMarineActor::GetCourse), "Sets/gets course.", C_TYPE_SHIP));

	AddProperty(new dtDAL::FloatActorProperty("DesiredRudderAngle","DesiredRudderAngle",
		dtDAL::FloatActorProperty::SetFuncType(kri, &SubMarineActor::SetDesiredRudderAngle),
		dtDAL::FloatActorProperty::GetFuncType(kri, &SubMarineActor::GetDesiredRudderAngle), "Sets/gets desire rudder angle.", C_TYPE_SHIP));

	AddProperty(new dtDAL::IntActorProperty("ModeGuidance","ModeGuidance",
		dtDAL::IntActorProperty::SetFuncType(kri, &SubMarineActor::SetModeGuidance),
		dtDAL::IntActorProperty::GetFuncType(kri, &SubMarineActor::GetModeGuidance), "Sets/gets course.", C_TYPE_SHIP));

	AddProperty(new dtDAL::IntActorProperty("ModeAltitude","ModeAltitude",
		dtDAL::IntActorProperty::SetFuncType(kri, &SubMarineActor::SetModeAltitude),
		dtDAL::IntActorProperty::GetFuncType(kri, &SubMarineActor::GetModeAltitude), "Sets/gets course.", C_TYPE_SHIP));

	AddProperty(new dtDAL::FloatActorProperty("MaxAheadSpeed","MaxAheadSpeed",
		dtDAL::FloatActorProperty::SetFuncType(kri, &SubMarineActor::SetMaxAheadSpeed),
		dtDAL::FloatActorProperty::GetFuncType(kri, &SubMarineActor::GetMaxAheadSpeed), "Sets/gets MaxAheadSpeed.", C_TYPE_SHIP));

	AddProperty(new dtDAL::IntActorProperty(C_SET_DAMAGE,C_SET_DAMAGE,
		dtDAL::IntActorProperty::SetFuncType(kri, &SubMarineActor::SetDamage),
		dtDAL::IntActorProperty::GetFuncType(kri, &SubMarineActor::GetDamage), "Sets/gets damage.", C_TYPE_SHIP));
}

void SubMarineActorProxy::BuildInvokables()
{
   VehicleActorProxy::BuildInvokables();
}

/////////////////////////////////////////////////


SubMarineActor::SubMarineActor(dtGame::GameActorProxy &proxy) :
	VehicleActor(proxy),
	mMinDist(30.0f),
	mMaxDist(80.0f),
	mRollOff(10.0f),
	bIsCollisionSound(false),
	mCollisionSoundTime(0.0f),
	mFirstInitSwitchTarget(false),
	isVerudder(false),
	isAltitude(false),
	tempPitch(0.0f),
	altitudeVal(0.0f),
	verudderVal(0.0f)
{
	mCoordSys = &VehicleActor::CoordSys::SYS_ABS;
	SetPosition(position);
	stackSound = NULL ;
	collisionSound = NULL;
	collisionSound2 = NULL;
	//SetMaxAheadSpeed(25.0f);
}

SubMarineActor::~SubMarineActor(){}

 
void SubMarineActor::SetParticlePosition(const std::string &dofName,const std::string &fileName, dtCore::ParticleSystem *tParticle )
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
	}
}

float SubMarineActor::GetDynamicPitch(osg::Vec3 point1, osg::Vec3 point2)
{
	dtCore::Transform trans;
	trans.Set(point1, point2, osg::Vec3(0.f,0.f,1.f));
	osg::Vec3 rotation;
	trans.GetRotation(rotation);
	return rotation.y();
}

void SubMarineActor::UpdatePosition(float elapsedTime)
{
	float x,y,z,h,p,r;
	float p51Bearing = ConvertTodtCoreBearing(course);
	float distance = speed * metersPerKnotPerSecond * elapsedTime;

	position.Get(x, y, z, h, p, r);

	//std::cout << "speed submarine : " << speed << std::endl;

	if (speed > -0.3 && speed < 0.3f)
	{
		SetVerDesiredRudderAngle(0.0f);
		isAltitude = false ;
		isVerudder = false ; 
	}

	if ( speed < -0.3f || speed > 0.3f )
	{
		if (isAltitude)
		{
			// dynamic pitch [2/1/2013 DID RKT2]
			dtCore::Transform submarineTransform;
			osg::Vec3 submarinePosition;
			GetTransform(submarineTransform);
			submarineTransform.GetTranslation(submarinePosition);
			static osg::Vec3 firstpos;
			if (firstGetPos==true)
			{
				firstpos.x() = submarinePosition.x() + 5000;
				firstpos.y() = submarinePosition.y() + 5000;
				firstGetPos = false;
				//std::cout << submarinePosition << std::endl;
			}
			osg::Vec3 tpos(firstpos.x(),firstpos.x(),altitudeVal);
			//std::cout << tempPitch << std::endl;
			tempPitch = osg::RadiansToDegrees(GetDynamicPitch(submarinePosition,tpos));

			SetVerDesiredRudderAngle(tempPitch);
		}
		if (isVerudder)
		{
			// dynamic pitch [2/1/2013 DID RKT2]
			dtCore::Transform submarineTransform;
			osg::Vec3 submarinePosition;
			GetTransform(submarineTransform);
			submarineTransform.GetTranslation(submarinePosition);
			static osg::Vec3 firstpos;
			if (firstGetPos==true)
			{
				firstpos.x() = submarinePosition.x() + 5000;
				firstpos.y() = submarinePosition.y() + 5000;
				firstGetPos = false;
			}
			osg::Vec3 tpos(firstpos.x(),firstpos.x(),altitudeVal);
			SetVerDesiredRudderAngle(tempPitch);
		}
	}

	//std::cout << GetName() << " speed submarine = " << speed <<std::endl;

	x -= distance * sinf(osg::DegreesToRadians(p51Bearing))* cosf(osg::DegreesToRadians(VerRudderAngle));
	y += distance * cosf(osg::DegreesToRadians(p51Bearing))* cosf(osg::DegreesToRadians(VerRudderAngle));
	z += distance * sinf(osg::DegreesToRadians(VerRudderAngle));	

	position.Set(x,y,z,p51Bearing, VerRudderAngle, heel);
}

void SubMarineActor::LoadModelFile(const std::string &fileName)
{
	if (meshFile != fileName)
	{
		dtCore::RefPtr<osgDB::ReaderWriter::Options> options = new osgDB::ReaderWriter::Options();
        options->setObjectCacheHint(osgDB::ReaderWriter::Options::CACHE_NONE);
		osg::Node *model = osgDB::readNodeFile(fileName,options.get());   

		if (model != NULL)
		{
			if (GetMatrixNode()->getNumChildren() != 0)
				GetMatrixNode()->removeChild(0,GetMatrixNode()->getNumChildren());

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

		if (!IsRemote() && GetGameActorProxy().IsInGM())
		{
			dtCore::RefPtr<dtGame::Message> updateMsg = GetGameActorProxy().GetGameManager()->GetMessageFactory().CreateMessage(dtGame::MessageType::INFO_ACTOR_UPDATED);
			dtGame::ActorUpdateMessage *message = static_cast<dtGame::ActorUpdateMessage *> (updateMsg.get());
			GetGameActorProxy().PopulateActorUpdate(*message);
			GetGameActorProxy().GetGameManager()->SendMessage(*updateMsg);
		}
	}

}

void SubMarineActor::TickLocal(const dtGame::Message &tickMessage)
{
	const dtGame::TickMessage &tick = static_cast<const dtGame::TickMessage&>(tickMessage);
	float deltaSimTime = tick.GetDeltaSimTime();
	
	MoveVehicle(deltaSimTime);

	CeckDataCollision();

	if(bIsCollisionSound)
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


void SubMarineActor::TickRemote(const dtGame::Message &tickMessage)
{
	const dtGame::TickMessage &tick = static_cast<const dtGame::TickMessage&>(tickMessage);
	float deltaSimTime = tick.GetDeltaSimTime();
}

void SubMarineActor::ProcessMessage(const dtGame::Message &message)
{
	LOG_INFO(message.GetMessageType().GetName());
	if(message.GetMessageType().GetName() == SimMessageType::ORDER_EVENT.GetName()){
		LOG_INFO("Order Event Ship");
		ProcessOrderEvent(message);
	}

}

void SubMarineActor::SetShipSmokeSubMarine(const int OrderValue)
{
	switch (OrderValue)
	{
		case ORD_SUBSMOKE_HALU_ON : 
			if( mParticleEffectHalu != NULL) mParticleEffectHalu->SetEnabled(true);
			break;
		case ORD_SUBSMOKE_HALU_OFF : 
			if( mParticleEffectHalu != NULL) mParticleEffectHalu->SetEnabled(false);
			break;
		case ORD_SUBSMOKE_LAMBUNG_ON : 
			if( mParticleEffectLambung != NULL) mParticleEffectHalu->SetEnabled(true);
			break;
		case ORD_SUBSMOKE_LAMBUNG_OFF : 
			if( mParticleEffectLambung != NULL) mParticleEffectLambung->SetEnabled(false);
			break;
		case ORD_SUBSMOKE_BURITAN_ON : 
			if( mParticleEffectBuritan != NULL) mParticleEffectBuritan->SetEnabled(true);
			break;
		case ORD_SUBSMOKE_BURITAN_OFF : 
			if( mParticleEffectBuritan != NULL) mParticleEffectBuritan->SetEnabled(false);
			break;
	}
	std::cout<<"Set Ship Smoke SubMarine = "<<OrderValue<<std::endl;
}

//////////////////////////////////////////////////////////////////////////
void SubMarineActor::ProcessOrderEvent(const dtGame::Message &message)
{
	dtGame::GameManager &gm= *GetGameActorProxy().GetGameManager();
	dtABC::Application& app = GetGameActorProxy().GetGameManager()->GetApplication();

	const MsgOrder &orderMsg = static_cast<const MsgOrder&>(message);
	if (orderMsg.GetVehicleID() == GetVehicleID())
		switch (orderMsg.GetOrderID()){
			case ORD_THROTTLE : 
				PlayStackSound();
				if (orderMsg.GetFloatValue()==0)
				{
					SetVerDesiredRudderAngle(0.0f);
					isAltitude = false;
					isVerudder = false;
				}
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
				isVerudder = true;
				isAltitude = false;
				firstGetPos = true;
				verudderVal = orderMsg.GetFloatValue();
				std::cout<<GetName()<<" GET MESSAGE V RUDDER = "<<verudderVal<<std::endl;
				if (verudderVal >= 0)
					verudderVal = 0;
				else if (verudderVal < 0)
					verudderVal = -200;
				break;
			case ORD_ALTITUDE :
				PlayStackSound();
				isVerudder = false;
				isAltitude = true;
				firstGetPos = true;
				altitudeVal = orderMsg.GetFloatValue();
				std::cout<<GetName() <<" GET MESSAGE ALTITUDE = "<<altitudeVal<<std::endl;
				if (altitudeVal > 0)
					altitudeVal = 0;
				else if (altitudeVal < -200)
					altitudeVal = -200;
				break;
			case ORD_STOP : // di gunakan untuk lego jangakar
				PlayStackSound();
				SetDesiredThrottlePosition(0);
				break;
			case ORD_BELL : 
				//PlayBellSound(int(orderMsg.GetFloatValue()));
				break;
			case ORD_SOUND_MINDIST : 
				mMinDist = orderMsg.GetFloatValue();
				//SetSoundMaxxRoll();
				break;
			case ORD_SOUND_MAXDIST : 
				mMaxDist = orderMsg.GetFloatValue();
				//SetSoundMaxxRoll();
				break;
			case ORD_SOUND_ROLLOFF : 
				mRollOff = orderMsg.GetFloatValue();
				//SetSoundMaxxRoll();
				break;
			case ORD_SHIPESMOKE : 
				SetShipSmokeSubMarine(int(orderMsg.GetFloatValue()));
				break;
			case ORD_SWITCH_TARGET :
				{
					std::string sts = orderMsg.GetStringValue();
					int idx = (int) orderMsg.GetFloatValue();
					osg::Switch *sw = targetswitches.get() ;

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

				}
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

void SubMarineActor::SetParticleFile()
{
    SetParticlePosition(C_DOF_NAME_SUB_EFFECT_HALU,C_PARTICLES_SUB_DOWN,mParticleEffectHalu);
	SetParticlePosition(C_DOF_NAME_SUB_EFFECT_LAMBUNG,C_PARTICLES_SUB_DOWN,mParticleEffectLambung);
	SetParticlePosition(C_DOF_NAME_SUB_EFFECT_BURITAN,C_PARTICLES_SUB_DOWN,mParticleEffectBuritan);
	//SetParticlePosition(C_DOF_NAME_SUB_EFFECT_BURITAN,C_PARTICLES_SUB_WAKE,mParticleSubWake);
	//const std::string C_DOF_NAME_SUB_EFFECT_BURITAN		= "DOF_EfekBuritan";// 
	SetParticlePosition("DOFPropeller",C_PARTICLES_SUB_WAKE,mParticleSubWake);
}

  
void SubMarineActor::OnEnteredWorld()
{
	AddSender(&(GetGameActorProxy().GetGameManager()->GetScene()));
	//SetSoundFile();
	SetParticleFile();
	PlayStackSound();
	InitTargetSwitch();
}

//////////////////////////////////////////////////////////////////////////
void SubMarineActorProxy::OnEnteredWorld()
{
	VehicleActorProxy::OnEnteredWorld();
	RegisterForMessages(SimMessageType::ORDER_EVENT, dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
	RegisterForMessages(dtGame::MessageType::TICK_LOCAL, dtGame::GameActorProxy::TICK_LOCAL_INVOKABLE);
    GetActor()->AddSender(&(GetGameManager()->GetScene()));
}

void SubMarineActor::OnRemovedFromWorld()
{
    RemoveSender(&(GetGameActorProxy().GetGameManager()->GetScene()));
}