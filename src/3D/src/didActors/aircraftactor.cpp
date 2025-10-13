#include "aircraftactor.h"
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

AircraftActorProxy::AircraftActorProxy(){}
AircraftActorProxy::~AircraftActorProxy(){}

void AircraftActorProxy::BuildPropertyMap()
{
	VehicleActorProxy::BuildPropertyMap();

	AircraftActor* kri = NULL ;

	GetActor(kri);

	AddProperty(new dtDAL::StringActorProperty(C_SET_MODEL,C_SET_MODEL,
		dtDAL::StringActorProperty::SetFuncType(kri,&AircraftActor::LoadModelFile),
		dtDAL::StringActorProperty::GetFuncType(kri,&AircraftActor::GetMeshFile), "Loads the model file for the ship", C_TYPE_SHIP));

	AddProperty(new dtDAL::FloatActorProperty(C_SET_SPEED,C_SET_SPEED,
		dtDAL::FloatActorProperty::SetFuncType(kri, &AircraftActor::SetSpeed),
		dtDAL::FloatActorProperty::GetFuncType(kri, &AircraftActor::GetSpeed), "Sets/gets speed.",C_TYPE_SHIP));

	AddProperty(new dtDAL::FloatActorProperty("Pitch","Pitch",
		dtDAL::FloatActorProperty::SetFuncType(kri, &AircraftActor::SetPitch),
		dtDAL::FloatActorProperty::GetFuncType(kri, &AircraftActor::GetPitch), "Sets/gets pitch.", C_TYPE_SHIP));

	AddProperty(new dtDAL::FloatActorProperty("Heel","Heel",
		dtDAL::FloatActorProperty::SetFuncType(kri, &AircraftActor::SetHeel),
		dtDAL::FloatActorProperty::GetFuncType(kri, &AircraftActor::GetHeel), "Sets/gets heel.", C_TYPE_SHIP));

	AddProperty(new dtDAL::FloatActorProperty(C_SET_COURSE,C_SET_COURSE,
		dtDAL::FloatActorProperty::SetFuncType(kri, &AircraftActor::SetCourse),
		dtDAL::FloatActorProperty::GetFuncType(kri, &AircraftActor::GetCourse), "Sets/gets course.", C_TYPE_SHIP));

	AddProperty(new dtDAL::FloatActorProperty("DesiredRudderAngle","DesiredRudderAngle",
		dtDAL::FloatActorProperty::SetFuncType(kri, &AircraftActor::SetDesiredRudderAngle),
		dtDAL::FloatActorProperty::GetFuncType(kri, &AircraftActor::GetDesiredRudderAngle), "Sets/gets desire rudder angle.", C_TYPE_SHIP));

	AddProperty(new dtDAL::IntActorProperty("ModeGuidance","ModeGuidance",
		dtDAL::IntActorProperty::SetFuncType(kri, &AircraftActor::SetModeGuidance),
		dtDAL::IntActorProperty::GetFuncType(kri, &AircraftActor::GetModeGuidance), "Sets/gets course.", C_TYPE_SHIP));

	AddProperty(new dtDAL::IntActorProperty("ModeAltitude","ModeAltitude",
		dtDAL::IntActorProperty::SetFuncType(kri, &AircraftActor::SetModeAltitude),
		dtDAL::IntActorProperty::GetFuncType(kri, &AircraftActor::GetModeAltitude), "Sets/gets course.", C_TYPE_SHIP));

	AddProperty(new dtDAL::FloatActorProperty("MaxAheadSpeed","MaxAheadSpeed",
		dtDAL::FloatActorProperty::SetFuncType(kri, &AircraftActor::SetMaxAheadSpeed),
		dtDAL::FloatActorProperty::GetFuncType(kri, &AircraftActor::GetMaxAheadSpeed), "Sets/gets MaxAheadSpeed.", C_TYPE_SHIP));

	AddProperty(new dtDAL::IntActorProperty(C_SET_DAMAGE,C_SET_DAMAGE,
		dtDAL::IntActorProperty::SetFuncType(kri, &AircraftActor::SetDamage),
		dtDAL::IntActorProperty::GetFuncType(kri, &AircraftActor::GetDamage), "Sets/gets damage.", C_TYPE_SHIP));
}

void AircraftActorProxy::BuildInvokables()
{
	VehicleActorProxy::BuildInvokables();
}

/////////////////////////////////////////////////

AircraftActor::AircraftActor(dtGame::GameActorProxy &proxy) :
VehicleActor(proxy),
	mMinDist(30.0f),
	mMaxDist(80.0f),
	mRollOff(10.0f),
	mFirstInitSwitchTarget(false),
	p1(0.0f),
	p2(0.0f),
	isFall(false)
{
	mCoordSys = &VehicleActor::CoordSys::SYS_ABS;
	SetPosition(position);
	stackSound = NULL ;
	//SetMaxAheadSpeed(850.0f);
}

AircraftActor::~AircraftActor(){}

void AircraftActor::SetParticlePosition(const std::string &dofName,const std::string &fileName, dtCore::ParticleSystem *tParticle )
{
	dtCore::RefPtr<osgDB::ReaderWriter::Options> options = new osgDB::ReaderWriter::Options();
	options->setObjectCacheHint(osgDB::ReaderWriter::Options::CACHE_NONE);
	//osg::Node *model = osgDB::readNodeFile(meshFile,options.get());
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

void AircraftActor::UpdatePosition(float elapsedTime)
{
	float x,y,z,h,p,r;
	float p51Bearing = ConvertTodtCoreBearing(course);
	//float p51Bearing = h1;
	float p51Pitch = p2;//ConvertTodtCoreBearing(pitch);
	if(speed <= 20.0f)
		speed = 20.0f;
	float distance = speed * metersPerKnotPerSecond * elapsedTime;
	static float mAngle;

	position.Get(x, y, z, h, p, r);

	x -= distance * sinf(osg::DegreesToRadians(p51Bearing))* cosf(osg::DegreesToRadians(p51Pitch));
	y += distance * cosf(osg::DegreesToRadians(p51Bearing))* cosf(osg::DegreesToRadians(p51Pitch));
	z += distance * sinf(osg::DegreesToRadians(p51Pitch));

	if ( GetModeAltitude() == 1 )
	{
		if ( z >= p1 && p2 > 0 )
		{
			z = p1;
			p2 = 0;
		}
		else if ( z <= p1 && p2 < 0 )
		{
			z = p1;
			p2 = 0;
		}
	}

	if ( z >= 10000)
	{
		z = 10000;
		p2 = 0;
	}
	else if(z < 0)
	{
		z = 0; 
		p2 = 0;

		dtCore::RefPtr<MsgActorsControl> msgAC;
		dtGame::GameManager* gm= GetGameActorProxy().GetGameManager();
		dtGame::MessageFactory* mf=&gm->GetMessageFactory();
		mf->CreateMessage(*(mf->GetMessageTypeByName(C_MT_ACTORS_CONTROL)),msgAC);

		msgAC->SetOrderID(STATE_AR_DEL);  
		msgAC->SetTipeID(TIPE_AR_AIRCRAFT);  
		msgAC->SetVehicleID(GetVehicleID());    

		GetGameActorProxy().GetGameManager()->SendNetworkMessage(*msgAC.get());
		GetGameActorProxy().GetGameManager()->SendMessage(*msgAC.get());

		isFall = false;
	}

	//position.Set(x,y,z,p51Bearing, p51Pitch, p51Bearing*elapsedTime);
	position.Set(x,y,z,p51Bearing, p51Pitch, 0);
}

void AircraftActor::LoadModelFile(const std::string &fileName)
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

			/*dMass mass;
			dMassSetBox(&mass, 1.0f, 1.0f, 1.0f, 1.0f);
			SetCollisionBox();
			SetMass(&mass);*/

			GetGameActorProxy().GetGameManager()->GetScene().AddDrawable(this);

			InitTargetSwitch();
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

void AircraftActor::TickLocal(const dtGame::Message &tickMessage)
{
	const dtGame::TickMessage &tick = static_cast<const dtGame::TickMessage&>(tickMessage);
	float deltaSimTime = tick.GetDeltaSimTime();

	static bool first=true;
	static float turn=0;
	if ( !mFirstInitSwitchTarget ) CeckInitialSwitchTarget();

	MoveVehicle(deltaSimTime);

	if ( GetDamage() <= 0 )
		isFall = true ;

	if (isFall == true){
		GetTransform(heliTransform);
		heliTransform.GetTranslation(heliPosition);
		heliTransform.GetRotation(heliRotation);

		if (first==true){
			std::cout << "roll first: " <<heliRotation[2] << std::endl;
			first=false;
		}

		float distance = 10 * deltaSimTime;
		heliPosition.z() -= distance;

		turn++;
		heliRotation[2] = turn;

		heliTransform.SetRotation(heliRotation);
		heliTransform.SetTranslation(heliPosition);
		SetTransform(heliTransform);

		if (heliPosition.z() < 0)
		{
			//Send Explode
			dtCore::RefPtr<MsgUtilityAndTools> msgExplode;
			dtGame::GameManager* gm= GetGameActorProxy().GetGameManager();
			dtGame::MessageFactory* mf=&gm->GetMessageFactory();
			mf->CreateMessage(*(mf->GetMessageTypeByName(C_MT_UTILITY_AND_TOOLS)),msgExplode);

			msgExplode->SetOrderID(TIPE_UTIL_EVENT_EXPLODE);
			msgExplode->SetUAT0(CT_EXPLODE_AIRCFART);
			msgExplode->SetUAT1(heliPosition.x());    
			msgExplode->SetUAT2(heliPosition.y());   
			msgExplode->SetUAT3(heliPosition.z());  

			GetGameActorProxy().GetGameManager()->SendNetworkMessage(*msgExplode.get());
			GetGameActorProxy().GetGameManager()->SendMessage(*msgExplode.get());

			//Delete AirCraft
			dtCore::RefPtr<MsgActorsControl> msgAC;
			mf->CreateMessage(*(mf->GetMessageTypeByName(C_MT_ACTORS_CONTROL)),msgAC);
			msgAC->SetOrderID(STATE_AR_DEL);  
			msgAC->SetTipeID(TIPE_AR_AIRCRAFT);  
			msgAC->SetVehicleID(GetVehicleID());    

			GetGameActorProxy().GetGameManager()->SendNetworkMessage(*msgAC.get());
			GetGameActorProxy().GetGameManager()->SendMessage(*msgAC.get());
		}
	}
}

void AircraftActor::TickRemote(const dtGame::Message &tickMessage){}

void AircraftActor::ProcessMessage(const dtGame::Message &message)
{
	LOG_INFO(message.GetMessageType().GetName());
	if(message.GetMessageType().GetName() == SimMessageType::ORDER_EVENT.GetName()){
		LOG_INFO("Order Event Ship");
		ProcessOrderEvent(message);
	}
}

void AircraftActor::SetShipSmokeAircraft(const int OrderValue)
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
	std::cout<<"Set Ship Smoke aircraft = "<<OrderValue<<std::endl;
}

void AircraftActor::CeckInitialSwitchTarget()
{
	if ( GetIsTarget() )
	{
		//if ( targetswitches.get() )
		//SetSwitchTargetStatus(ORD_STGT_Normal);
	}

	mFirstInitSwitchTarget = true ;
}

void AircraftActor::ProcessOrderEvent(const dtGame::Message &message)
{
	dtGame::GameManager &gm= *GetGameActorProxy().GetGameManager();
	dtABC::Application& app = GetGameActorProxy().GetGameManager()->GetApplication();

	const MsgOrder &orderMsg = static_cast<const MsgOrder&>(message);
	if (orderMsg.GetVehicleID() == GetVehicleID())
		switch (orderMsg.GetOrderID()){
			case ORD_THROTTLE : 
				PlayStackSound();
				SetDesiredThrottlePosition(orderMsg.GetFloatValue());
				std::cout<<"ORDER = THROTTLE. VAL = "<<orderMsg.GetFloatValue()<<std::endl;
				break;
			case ORD_RUDDER : 
				PlayStackSound();
				SetModeGuidance(orderMsg.GetModeGuidance());
				SetDesiredRudderAngle(orderMsg.GetFloatValue());
				std::cout<<"ORDER = RUDDER. VAL = "<<orderMsg.GetFloatValue()<<std::endl;
				h1=orderMsg.GetFloatValue();
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
				SetShipSmokeAircraft(int(orderMsg.GetFloatValue()));
				break;
			case ORD_SWITCH_TARGET : 
				{
					//isFall=true;
					int Lethality = orderMsg.GetLethality();
					SetDamage(GetDamage()-Lethality);
					std::cout << "Lethality : " << Lethality << " , Damage : " << GetDamage() << std::endl;

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
	}
}

void AircraftActor::SetParticleFile()
{
	SetParticlePosition(C_DOF_NAME_SUB_EFFECT_HALU,C_PARTICLES_SUB_DOWN,mParticleEffectHalu);
	SetParticlePosition(C_DOF_NAME_SUB_EFFECT_LAMBUNG,C_PARTICLES_SUB_DOWN,mParticleEffectLambung);
	SetParticlePosition(C_DOF_NAME_SUB_EFFECT_BURITAN,C_PARTICLES_SUB_DOWN,mParticleEffectBuritan);
	SetParticlePosition("DOFPropeller",C_PARTICLES_SUB_WAKE,mParticleSubWake);
}

void AircraftActor::OnEnteredWorld()
{
	AddSender(&(GetGameActorProxy().GetGameManager()->GetScene()));
//	SetSoundFile();
	SetParticleFile();
	speed = 10.0f;
}

//////////////////////////////////////////////////////////////////////////
void AircraftActorProxy::OnEnteredWorld()
{
	VehicleActorProxy::OnEnteredWorld();
	RegisterForMessages(SimMessageType::ORDER_EVENT, dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
	RegisterForMessages(dtGame::MessageType::TICK_LOCAL, dtGame::GameActorProxy::TICK_LOCAL_INVOKABLE);
	GetActor()->AddSender(&(GetGameManager()->GetScene()));
}

void AircraftActor::OnRemovedFromWorld()
{
	RemoveSender(&(GetGameActorProxy().GetGameManager()->GetScene()));
}