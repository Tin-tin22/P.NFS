#include "C802Actor.h"
#include "ShipModelActor.h"
#include "didactorssources.h"
#include "shipactor.h"

///////////////////////////////////////////////////////////////////////////////
//const std::string C802MissileActor::EVENT_HANDLER_NAME("HandleGameEvent");

///////////////////////////////////////////////////////////////////////////////

//++ Constants
const int C802MissileActor::GATE_NEAR = 0;                              
const int C802MissileActor::GATE_FAR1 = 1;                              
const int C802MissileActor::GATE_FAR2 = 2;                              

const float C802MissileActor::K0_TIME = 1.2f;       
const float C802MissileActor::K1_TIME = 8.0f;
const float C802MissileActor::K2_TIME = 19.0f;
const float C802MissileActor::SELF_CONTROL_FLIGHT_TIME_MIN = 10.0f;     
const float C802MissileActor::SELF_CONTROL_FLIGHT_TIME_MAX = 400.0f;    
const float C802MissileActor::ALTITUDE_MAX = 140.0f;                    
const float C802MissileActor::ALTITUDE_G   = 110.0f;                    
const float C802MissileActor::ALTITUDE_CRUISE_START = 60.0f;            
const float C802MissileActor::ALTITUDE_CRUISE_LEVEL = 20.0f;            
const float C802MissileActor::DISTANCE_CLIMB_PHASE = 400.0f;            
const float C802MissileActor::HIGH_SEA_STATE_ALT = 7.0f;                
const float C802MissileActor::LOW_SEA_STATE_ALT = 5.0f;                 
const float C802MissileActor::DIVING_COMMAND_RANGE = 500.0f;
const float C802MissileActor::EFECTIVE_RANGE = 120000.0f;
const float C802MissileActor::MAX_SPEED = 0.9f;

C802MissileActor::C802MissileActor(dtGame::GameActorProxy &proxy) : 
   MissilesActor(proxy),
	   mSmokeStatus(false),
	   isFirst(true),
	   ExcRange(0),
	   isFind(false),
	   isFire(false),
	   firstSeeker(true),
	   CurrentHeading(0.0f),
	   CurrentSpeed(0.0f),
	   DistanceToTarget(0),
	   Direction2D(0),
	   Range2D(0),
	   SeekerOn(0),
	   nbearing(0),
	   npitch(0),
	   jarakTarget(10000000.0f),
	   mPhase (PHASE_NONE)
{}

C802MissileActor::~C802MissileActor(){}

///////////////////////////////////////////////////////////////////////////////

void C802MissileActor::TickLocal(const dtGame::Message &tickMessage)
{
	const dtGame::TickMessage &tick = static_cast<const dtGame::TickMessage&>(tickMessage);    
	float deltaSimTime = tick.GetDeltaSimTime();

	if( mSmokeStatus == true){
	   if ( mSmoke->IsEnabled()){}
	   else mSmoke->SetEnabled(true);
	}

	if(isLaunch == true){
		/*dtCore::RefPtr<dtDAL::ActorProxy> proxy= CeckCollision(trac.GetSpeed()* DEF_MACH_TO_METRE, tick.GetDeltaSimTime());
		if ( proxy != NULL ){
		  UpdateStatusDBEffectTo2D(proxy->GetActor(),ST_MISSILE_HIT);
		  std::cout<<"C802  hit "<<std::endl;
		  C802Blast(proxy.get());

		  UpdateStatusDBEffectTo2D(mMyParent.get(), ST_MISSILE_DEL);
		  isLaunch = false;
		  std::cout<<"End Of C802 "<<std::endl;
		}*/
		if ( GetGameActorProxy().GetGameManager()->GetMachineInfo().GetName() == C_MACHINE_SERVER )
			CeckCollisionC802(deltaSimTime);

		Move(tick.GetDeltaSimTime());

		if (ExcRange >= EFECTIVE_RANGE){
			isLaunch = false;
			UpdateStatusDBEffectTo2D(mMyParent.get(), ST_MISSILE_DEL );
			std::cout<<"End Of C802 "<<std::endl;
		}

		//Sound Effect
		if ( missileSound != NULL ){
			if ( !missileSound->IsPlaying() ) 
				missileSound->Play();
		}
	}
}

///////////////////////////////////////////////////////////////////////////////
void C802MissileActor::TickRemote(const dtGame::Message &tickMessage)
{
   const dtGame::TickMessage &tick = static_cast<const dtGame::TickMessage&>(tickMessage);
}

///////////////////////////////////////////////////////////////////////////////

void C802MissileActor::ProcessOrderEvent(const dtGame::Message &message)
{
	const MsgSetC802 &Msg = static_cast<const MsgSetC802&>(message);
	dtCore::RefPtr<dtDAL::ActorProxy> parentProxy = GetShipActorByID(Msg.GetVehicleID());
	if ( parentProxy.valid()){
		idLauncher = (int) Msg.GetLauncherID();

		dtCore::RefPtr<VehicleActor> parent = static_cast<VehicleActor*>(parentProxy->GetActor());
		if (( !GetLaunched() ) &&  
			( IsMissileValidID( Msg.GetVehicleID(),Msg.GetWeaponID(),Msg.GetLauncherID(),Msg.GetMissileID(),Msg.GetMissileNum() ) ) )
		{
			switch (Msg.GetOrderID()){
				case ORD_C802_FIRE :
					mSmokeStatus = true;
					mMyParent= parent;
					Direction2D = Msg.GetBearingToTarget(); 
					Range2D = Msg.GetDistanceToTarget();

					if ((Range2D >= 8000)&&(Range2D <= 120000))
					{
						SetVehicleID(Msg.GetVehicleID());

						if ((Range2D >= 10000) && (Range2D <= 15000)) SeekerOn = 5000;
						else if ((Range2D > 15000) && (Range2D <= 25000)) SeekerOn = 9000;
						else if (Range2D > 25000) SeekerOn = 13000;
 
						AddToEnvironmentActor();					
						UpdateStatusDBEffectTo2D(mMyParent.get(),ST_MISSILE_RUN);
						OnPhaseBoost();

						isLaunch = true;
						isFire = true;

						//Send To Instruktur
						dtCore::RefPtr<MsgUtilityAndTools> msgForTrac2D;
						dtGame::GameManager* gm= GetGameActorProxy().GetGameManager();
						dtGame::MessageFactory* mf=&gm->GetMessageFactory();
						mf->CreateMessage(*(mf->GetMessageTypeByName(C_MT_UTILITY_AND_TOOLS)),msgForTrac2D);
						msgForTrac2D->SetOrderID(TIPE_UTIL_TRAC2D);
						msgForTrac2D->SetUAT0(Msg.GetVehicleID());
						msgForTrac2D->SetUAT1(Msg.GetWeaponID());
						msgForTrac2D->SetUAT2(Msg.GetLauncherID());
						msgForTrac2D->SetUAT3(Msg.GetMissileID());
						msgForTrac2D->SetUAT4(1);
						GetGameActorProxy().GetGameManager()->SendNetworkMessage(*msgForTrac2D.get());
						GetGameActorProxy().GetGameManager()->SendMessage(*msgForTrac2D.get());
					}
					else
					{
						std::cout << "Not valid Range" <<std::endl;
						isLaunch = false;
						UpdateStatusDBEffectTo2D(mMyParent.get(), ST_MISSILE_DEL);
					}					
					break;

				case ORD_C802_RELEASE :
					AddToEnvironmentActor();
					mMyParent= parent;
					UpdateStatusDBEffectTo2D(mMyParent.get(), ST_MISSILE_RUN);
					OnPhaseBoost();
					isLaunch = true;
					isFire = false;
					break;
			}
		}
	}
}

void C802MissileActor::ProcessMessage(const dtGame::Message &message)
{
	if(GetGameActorProxy().IsInGM()){
		if(message.GetMessageType().GetName() == SimMessageType::C802_EVENT.GetName())
		{
			ProcessOrderEvent(message);
		}
	}
}

void C802MissileActor::CeckCollisionC802(float pDeltaTime)
{
	/* Target Object */
	static dtCore::Transform TargetTransform;
	static osg::Vec3 TargetPosition, TargetRotation;

	/* Temp Target For Check Nearest Distance */
	static dtCore::Transform TempTargetTransform;
	static osg::Vec3 TempTargetPosition, TempTargetRotation;

	/* Missile Object */
	static dtCore::Transform missileTransform;
	static osg::Vec3 missilePosition, missileRotation;

	dtCore::RefPtr<dtCore::DeltaDrawable> SearchShipTarget;
	typedef std::vector<dtDAL::ActorProxy*> ActorProxyVector;
	ActorProxyVector SearchShipProxy;

	/* Get All Ship In Sceanrio */
	GetGameActorProxy().GetGameManager()->FindActorsByType(*(GetGameActorProxy().GetGameManager()->FindActorType(C_ACTOR_CAT, C_CN_SHIP)), SearchShipProxy );

	for(  ActorProxyVector::iterator iter = SearchShipProxy.begin();
		iter != SearchShipProxy.end();
		++iter )
	{
		if ((*iter)->GetActor() != mMyParent )
		{
			dtCore::RefPtr<dtDAL::ActorProperty> propVID( (*iter)->GetProperty(C_SET_VID) );
			dtCore::RefPtr<dtDAL::IntActorProperty> valVID( static_cast<dtDAL::IntActorProperty*>( propVID.get()));
			int tgtID(  valVID->GetValue() );

			SearchShipTarget = (*iter)->GetActor() ;
			if ( SearchShipTarget != NULL )
			{
				VehicleActor* TargetAct = dynamic_cast<VehicleActor*>(SearchShipTarget.get());
				if ( TargetAct != NULL )
				{
					dtGame::GameActorProxy &pr = TargetAct->GetGameActorProxy();

					/* Set Target Object */
					TargetAct->GetTransform(TargetTransform);
					TargetTransform.GetTranslation(TargetPosition);
					TargetTransform.GetRotation(TargetRotation);

					TargetTransform.SetTranslation(TargetPosition);
					TargetTransform.SetRotation(TargetRotation);
					TargetAct->SetTransform(TargetTransform);

					/* Set Missile Object */
					GetTransform(missileTransform);
					missileTransform.GetTranslation(missilePosition);
					missileTransform.GetRotation(missileRotation);

					if( IsInCone(missilePosition, TargetPosition, missileRotation.x(), missileRotation.y(), 10 , 10) == true)
					{
						UpdateStatusDBEffectTo2D(SearchShipTarget,ST_MISSILE_HIT, GetMissileLethality());
						std::cout<<"C802  hit "<<std::endl;
						C802Blast(TargetPosition);

						UpdateStatusDBEffectTo2D(mMyParent.get(), ST_MISSILE_DEL);
						isLaunch = false;
						std::cout<<"End Of C802 "<<std::endl;
					}
				}
			}
		}
	}
}


void C802MissileActor::Move(double deltaSimTime)
{
	GetTransform(missileTransform);
	missileTransform.GetTranslation(missilePosition);
	missileTransform.GetRotation(missileRotation);

	track = trac.Calc_Movement(deltaSimTime);
	trac.Calc_Elevation(deltaSimTime);
	trac.Calc_Direction(deltaSimTime);

	missilePosition.x() += track.x();
	missilePosition.y() += track.y();
	missilePosition.z() += track.z();

	missileRotation[0] = -trac.GetDirection();
	missileRotation[1] = trac.GetElevation();
	missileRotation[2] = 0.0f;

	if (isFirst == true){
		missileFirstPos=missilePosition;
		isFirst=false;
	}

	ExcRange = GetDistance(missilePosition,missileFirstPos);

	if ((ExcRange >= 500) && (mPhase == PHASE_BOOST)){
		trac.SetElevTurnRate(-15.0f);
		if (trac.GetElevation() < -15.0f){
			trac.SetElevTurnRate(0.0f);
			trac.SetElevation(-15.0f);
			printf("start PHASE_LEVEL_FLIGHT z1=%f\n",missilePosition.z());
			mPhase = PHASE_LEVEL_FLIGHT;
		}
	}

	if ((missilePosition.z() <= 45) && (mPhase == PHASE_LEVEL_FLIGHT))
	{
		trac.SetElevTurnRate(15.0f);
		if (trac.GetElevation() >= 0.0f){
			trac.SetSpeed(MAX_SPEED);
			trac.SetElevTurnRate(0.0f);
			trac.SetElevation(0.0f);
			printf("start PHASE_SAD z2=%f\n",missilePosition.z());
			mPhase = PHASE_SAD;
		}
	}

	if (mPhase == PHASE_SAD && isFire == false)
	{
		if (ExcRange > ( 2 * DEF_KM_TO_METRE ) )
		{
			UpdateStatusDBEffectTo2D(mMyParent.get(), ST_MISSILE_DEL);
			isLaunch = false;
			std::cout<<"End Of C802 "<<std::endl;
		}
	}

	if (mPhase == PHASE_SAD && isFire == true)
	{
		TargetPosition = RangeBearingToCoord(missileFirstPos, Range2D, Direction2D);
		NewTargetBearing = ComputeBearingTo2(missilePosition.x(), missilePosition.y(), TargetPosition.x(), TargetPosition.y());
		NewTargetBearing = ValidateDegree(NewTargetBearing);

		std::cout << "NewTargetBearing " << NewTargetBearing << ", dir " <<trac.GetDirection()<<std::endl;

		if ( fabs(trac.GetDirection() - NewTargetBearing) > 180.0 )
		{
			trac.SetDirection(trac.GetDirection() - 2);    
			//trac.SetTurnRate(-90);
			if (trac.GetDirection() <= NewTargetBearing)
			{
				trac.SetTurnRate(0.0);
				trac.SetDirection(NewTargetBearing);
				mPhase = PHASE_DIVING;
			}	
		}
		else
		{
			trac.SetDirection(trac.GetDirection() + 2);
			//trac.SetTurnRate(90);
			if (trac.GetDirection() >= NewTargetBearing)
			{
				trac.SetTurnRate(0.0);
				trac.SetDirection(NewTargetBearing);
				mPhase = PHASE_DIVING;
			}	
		}
	}

	if ((ExcRange >= (Range2D - SeekerOn)) && (mPhase == PHASE_DIVING)){
		if(firstSeeker==true){
			std::cout << "Seeker ON Range = " << ExcRange << "Metre From Target" <<std::endl;
			firstSeeker = false;
		}

		if (isFind == false)
			SearchingTarget();
		else
		{
			dynamic_cast<VehicleActor*>(mShipTarget.get())->GetTransform(objectTransform);
			objectTransform.GetTranslation(objectPosition);
			objectTransform.GetRotation(objectRotation);


			static float radius = SeekerOn/2;

			if(IsInCone(missilePosition, objectPosition, missileRotation.x(), missileRotation.y(), SeekerOn, radius))
			{		
				nbearing = ComputeBearingTo2(missilePosition.x(),missilePosition.y(),objectPosition.x(),objectPosition.y());
				nbearing = ValidateDegree(nbearing);
				npitch	 = GetPitch(missilePosition,objectPosition);

				//trac.SetDirection(nbearing);
				//trac.SetElevation(npitch);

				if (nbearing <= trac.GetDirection()){
					trac.SetDirection(trac.GetDirection()-1);
					if (trac.GetDirection()<=nbearing)
						trac.SetDirection(nbearing);
				}
				else if (nbearing > trac.GetDirection()){
					trac.SetDirection(trac.GetDirection()+1);
					if (trac.GetDirection()>=nbearing)
						trac.SetDirection(nbearing);
				}

				if (missilePosition.z() > 2.0)
				{
					missilePosition.z() -= 1.0;
					if (missilePosition.z() <= 2.0)
					{
						missilePosition.z() = 2.0;
					}
				}

				//if (npitch < trac.GetElevation())
				//{
				//	//trac.SetElevation(trac.GetElevation() - 1);
				//	trac.SetElevTurnRate(-2);
				//	if (missilePosition.z() < 2)
				//	{
				//		//trac.SetElevation(0);
				//		trac.SetElevTurnRate(0);
				//		missilePosition.z() = 2;
				//	}
				//}
			}
			else{
				isFind = false;
				jarakTarget=10000000.0f;
			}
		}
	}

	SetCurrentSpeed(trac.GetSpeed()*DEF_MACH_TO_METRE);
	SetCurrentHeading(trac.GetDirection());
	missileTransform.SetRotation(missileRotation);
	missileTransform.SetTranslation(missilePosition);
	SetTransform(missileTransform);
}

void C802MissileActor::OnPhaseBoost(){
	trac.SetElevation(15.0f);
	trac.SetSpeed(MAX_SPEED/2);

	float ShipHeading;
	dtCore::RefPtr<dtDAL::ActorProxy> parentProxy = GetShipActorByID(GetVehicleID());
	if ( parentProxy.valid() )
	{
		static dtCore::Transform objectTransform;
		static osg::Vec3 objectPosition;
		static osg::Vec3 objectRotation;
		dtCore::RefPtr<VehicleActor> parent = static_cast<VehicleActor*>(parentProxy->GetActor());
		mMyParent = parent;
		dtGame::GameActorProxy &pr = parent->GetGameActorProxy();
		parent->GetTransform(objectTransform);
		objectTransform.GetTranslation(objectPosition);
		objectTransform.GetRotation(objectRotation);
		ShipHeading = objectRotation.x();
		//printf("heading = %f\n",ShipHeading);
	}

	if ((idLauncher == 2) || (idLauncher == 4)){
		firstDirection = - ShipHeading - 90.0f;
	}
	else if ((idLauncher == 1) || (idLauncher == 3)){
		firstDirection = - ShipHeading + 90.0f;
	}

	trac.SetDirection(firstDirection);
	mPhase = PHASE_BOOST;
}

void C802MissileActor::C802Blast(osg::Vec3 TargetPos)
{
	mSmoke ->SetEnabled(false);
	UpdateStatusDBEffectTo3DExplode(TargetPos.x(), TargetPos.y(), TargetPos.z() ,ST_MISSILE_EXPLODE);
}

void C802MissileActor::SearchingTarget() //eka - 17022012
{	
	mShipTarget = NULL ;
	dtCore::RefPtr<dtCore::DeltaDrawable> TempTarget;
	typedef std::vector<dtDAL::ActorProxy*> ActorProxyVector;
	ActorProxyVector TempProxy;
	GetGameActorProxy().GetGameManager()->FindActorsByType(*(GetGameActorProxy().GetGameManager()->FindActorType(C_ACTOR_CAT, C_CN_SHIP)), TempProxy );

	for(  ActorProxyVector::iterator iter = TempProxy.begin();
		iter != TempProxy.end();
		++iter )
	{    
		if ((*iter)->GetActor() != mMyParent )
		{
			dtCore::RefPtr<dtDAL::ActorProperty> propVID( (*iter)->GetProperty(C_SET_VID) );
			dtCore::RefPtr<dtDAL::IntActorProperty> valVID( static_cast<dtDAL::IntActorProperty*>( propVID.get() ) );
			int tgt(  valVID->GetValue() );
			TempTarget = (*iter)->GetActor() ;
			if ( TempTarget != NULL )
			{
				VehicleActor* TargetAct = dynamic_cast<VehicleActor*>(TempTarget.get());
				if ( TargetAct != NULL )
				{
					TargetAct->GetTransform(objectTransform);
					objectTransform.GetTranslation(objectPosition);
					objectTransform.GetRotation(objectRotation);

					objectTransform.SetTranslation(objectPosition);
					objectTransform.SetRotation(objectRotation);
					TargetAct->SetTransform(objectTransform);

					static float radius = SeekerOn/2;

					if(IsInCone(missilePosition, objectPosition, missileRotation.x(), missileRotation.y(), SeekerOn, radius)){		
						std::cout<< GetName() << " find target " << TempTarget->GetName() << std::endl;
						DistanceToTarget = GetDistanceCone(missilePosition,objectPosition);
						if (DistanceToTarget<=jarakTarget){
							jarakTarget=DistanceToTarget;
							isFind=true;
							mShipTarget = TempTarget ;
						}
					}
				}
			}
		}	
	}
}

void C802MissileActor::OnEnteredWorld()
{
	mSmoke = new dtCore::ParticleSystem();
	mSmoke->LoadFile("trailc802.osg",true);
	mSmoke->SetEnabled(false);
	GetGameActorProxy().GetActor()->AddChild(mSmoke.get());

	missileSound = dtAudio::AudioManager::GetInstance().NewSound();
	missileSound->LoadFile("Sounds/Missile.wav");
	assert(missileSound);
	missileSound->SetMaxDistance(1000.0f);
	missileSound->SetLooping(true);
	AddChild(missileSound.get());

	MissilesActor::OnEnteredWorld();
}

void C802MissileActor::OnRemovedFromWorld()
{
	MissilesActor::OnRemovedFromWorld();
}


///////////////////////////////////////////////////////////////////////////////

C802MissileActorProxy::C802MissileActorProxy(){}

///////////////////////////////////////////////////////////////////////////////
void C802MissileActorProxy::BuildPropertyMap()
{
	MissilesActorProxy::BuildPropertyMap();

	C802MissileActor* actor = NULL;
	GetActor(actor);

	AddProperty(new dtDAL::FloatActorProperty(C_SET_SPEED,C_SET_SPEED,
		dtDAL::FloatActorProperty::SetFuncType(actor, &C802MissileActor::SetCurrentSpeed),
		dtDAL::FloatActorProperty::GetFuncType(actor, &C802MissileActor::GetCurrentSpeed), "Sets/gets speed.", C_TYPE_MISSILE));

	AddProperty(new dtDAL::FloatActorProperty(C_SET_HEADING,C_SET_HEADING,
		dtDAL::FloatActorProperty::SetFuncType(actor, &C802MissileActor::SetCurrentHeading),
		dtDAL::FloatActorProperty::GetFuncType(actor, &C802MissileActor::GetCurrentHeading), "Sets/gets Heading.", C_TYPE_MISSILE));

}

///////////////////////////////////////////////////////////////////////////////
void C802MissileActorProxy::CreateActor()
{
   SetActor(*new C802MissileActor(*this));
}

///////////////////////////////////////////////////////////////////////////////
void C802MissileActorProxy::OnEnteredWorld()
{
	MissilesActorProxy::OnEnteredWorld();
	RegisterForMessages(SimMessageType::C802_EVENT, dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
}