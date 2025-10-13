#include "yakhontactor.h"
#include "ShipModelActor.h"
#include "didactorssources.h"
#include "shipactor.h"

///////////////////////////////////////////////////////////////////////////////
//const std::string YakhontMissileActor::EVENT_HANDLER_NAME("HandleGameEvent");
//ini koding msh mbulet Move-nya, kalo ada waktu diperbaiki
///////////////////////////////////////////////////////////////////////////////

//++ Constants
const float YakhontMissileActor::EFECTIVE_RANGE = 300000.0f;
const float YakhontMissileActor::MAX_SPEED = 2.5f;
const float YakhontMissileActor::HEIGHT_HIGH_TRAJECTORY = 14000.0f;
const float YakhontMissileActor::HEIGHT_LOW_TRAJECTORY = 300.0f;

YakhontMissileActor::YakhontMissileActor(dtGame::GameActorProxy &proxy) : 
   MissilesActor(proxy),
	   mSmokeStatus(false),
	   isFirst(true),
	   isFind(false),
	   isFire(false),
	   afterBlast(false),
	   firstSeeker(true),
	   ExcRange(0),
	   nbearing(0),
	   npitch(0),
	   CurrentHeading(0.0f),
	   CurrentSpeed(0.0f),
	   DistanceToTarget(0), 
	   jarakTarget(10000000.0f),
	   Direction2D(0),
	   Range2D(0),
	   mPhase(PHASE_1),
	   mMissileTrack(B),
	   mState(0)
{}

YakhontMissileActor::~YakhontMissileActor(){}

///////////////////////////////////////////////////////////////////////////////

void YakhontMissileActor::TickLocal(const dtGame::Message &tickMessage)
{
	const dtGame::TickMessage &tick = static_cast<const dtGame::TickMessage&>(tickMessage);    
	float deltaSimTime = tick.GetDeltaSimTime();
	if( mSmokeStatus == true){
		if ( mSmoke->IsEnabled()){}
		else mSmoke->SetEnabled(true);
	}

	if(isLaunch == true)
	{
	  /*dtCore::RefPtr<dtDAL::ActorProxy> proxy= CeckCollision(trac.GetSpeed()* DEF_MACH_TO_METRE, tick.GetDeltaSimTime());
	  if ( proxy != NULL ){
		  UpdateStatusDBEffectTo2D(proxy->GetActor(),ST_MISSILE_HIT);
		  YakhontBlast(proxy.get());
		  std::cout << "Collision" << std::endl;
		  afterBlast = true;
	  }*/
	  
		if ( GetGameActorProxy().GetGameManager()->GetMachineInfo().GetName() == C_MACHINE_SERVER )
			CeckCollisionYakhont(deltaSimTime);

		if ( isFire == true)
			Move(tick.GetDeltaSimTime());
		else
			MoveRelease(tick.GetDeltaSimTime());

		if (ExcRange >= EFECTIVE_RANGE){
			isLaunch = false;
			UpdateStatusDBEffectTo2D(mMyParent.get(), ST_MISSILE_DEL);
			std::cout<<"End Of Yakhont "<<std::endl;
		}

		if( afterBlast == true ){
			UpdateStatusDBEffectTo2D(mMyParent.get(), ST_MISSILE_DEL);
			isLaunch = false;
			std::cout<<"End Of Yakhont "<<std::endl;
		}

		//Sound Effect
		if ( missileSound != NULL )
		{
			if ( !missileSound->IsPlaying() ) 
				missileSound->Play();
		}
	}
}

///////////////////////////////////////////////////////////////////////////////
void YakhontMissileActor::TickRemote(const dtGame::Message &tickMessage)
{
   const dtGame::TickMessage &tick = static_cast<const dtGame::TickMessage&>(tickMessage);
}

///////////////////////////////////////////////////////////////////////////////

void YakhontMissileActor::ProcessOrderEvent(const dtGame::Message &message)
{
	const MsgSetYakhont &Msg = static_cast<const MsgSetYakhont&>(message);
	dtCore::RefPtr<dtDAL::ActorProxy> parentProxy = GetShipActorByID(Msg.GetVehicleID());
	if ( parentProxy.valid()){
		dtCore::RefPtr<VehicleActor> parent = static_cast<VehicleActor*>(parentProxy->GetActor());
		if (( !GetLaunched() ) &&  
			( IsMissileValidID( Msg.GetVehicleID(),Msg.GetWeaponID(),Msg.GetLauncherID(),Msg.GetMissileID(),Msg.GetMissileNum() ) ) )
		{
			switch (Msg.GetOrderID()){
			case ORD_YAKHONT_FIRE :
				Direction2D = Msg.GetBearingToTarget();
				Range2D		= Msg.GetDistanceToTarget();

				if((Range2D >= ( 14 * DEF_KM_TO_METRE )) && (Range2D <= ( 300 * DEF_KM_TO_METRE ))){
					mSmokeStatus = true;

					AddToEnvironmentActor();
					
					mMyParent= parent;

					if ((Range2D > ( 4 * DEF_KM_TO_METRE )) && (Range2D <= ( 80 * DEF_KM_TO_METRE ))) mMissileTrack = B1;
					else if ((Range2D > ( 80 * DEF_KM_TO_METRE )) && (Range2D <= ( 120 * DEF_KM_TO_METRE ))) mMissileTrack = B1n;
					else if ((Range2D > ( 120 * DEF_KM_TO_METRE )) && (Range2D <= ( 200 * DEF_KM_TO_METRE ))) mMissileTrack = B2;
					else if ((Range2D > ( 200 * DEF_KM_TO_METRE )) && (Range2D <= ( 300 * DEF_KM_TO_METRE ))) mMissileTrack = B2n;


					UpdateStatusDBEffectTo2D(mMyParent.get(),ST_MISSILE_RUN);
					SetFirstTrack();

					isLaunch = true;
					isFire = true;

					dtCore::RefPtr<MsgUtilityAndTools> msgFindTarget;
					dtGame::GameManager* gm= GetGameActorProxy().GetGameManager();
					dtGame::MessageFactory* mf=&gm->GetMessageFactory();
					mf->CreateMessage(*(mf->GetMessageTypeByName(C_MT_UTILITY_AND_TOOLS)),msgFindTarget);
					msgFindTarget->SetOrderID(TIPE_UTIL_TRAC2D);
					msgFindTarget->SetUAT0(GetVehicleID());
					msgFindTarget->SetUAT1(GetWeaponID());
					msgFindTarget->SetUAT2(GetLauncherID());
					msgFindTarget->SetUAT3(GetMissileID());
					msgFindTarget->SetUAT4(mMissileTrack);
					GetGameActorProxy().GetGameManager()->SendNetworkMessage(*msgFindTarget.get());
					GetGameActorProxy().GetGameManager()->SendMessage(*msgFindTarget.get());
				}
				else
				{
					std::cout << "Not valid Range" <<std::endl;
					isLaunch = false;
					UpdateStatusDBEffectTo2D(mMyParent.get(), ST_MISSILE_DEL);
				}
				
				break;
			case ORD_YAKHONT_RELEASE :
				AddToEnvironmentActor();
				mMyParent= parent;
				UpdateStatusDBEffectTo2D(mMyParent.get(), ST_MISSILE_RUN);
				trac.SetElevation(90.0f);
				trac.SetSpeed(0.25);
				
				//mMissileTrack = -1; //untuk release track = -1
				
				static dtCore::Transform ownShipTransform;
				static osg::Vec3 ownShipPosition; 
				static osg::Vec3 ownShipRotation;

				parent->GetTransform(ownShipTransform);
				ownShipTransform.GetRotation(ownShipRotation);

				if ((Msg.GetLauncherID()==3) || (Msg.GetLauncherID()== 4))
					trac.SetDirection(-90 + ownShipRotation[0]);
				else
					trac.SetDirection(90 + ownShipRotation[0]);
				isLaunch = true;
				break;
			}
		}
	}
}

void YakhontMissileActor::ProcessMessage(const dtGame::Message &message)
{
	if(GetGameActorProxy().IsInGM()){
		if(message.GetMessageType().GetName() == SimMessageType::YAKHONT_EVENT.GetName())
		{
			ProcessOrderEvent(message);
		}
	}
}

void YakhontMissileActor::CeckCollisionYakhont(float pDeltaTime)
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

					if( IsInCone(missilePosition, TargetPosition, missileRotation.x(), missileRotation.y(), 20 , 20) == true)
					{
						UpdateStatusDBEffectTo2D(SearchShipTarget,ST_MISSILE_HIT, GetMissileLethality());
						YakhontBlast(TargetPosition);
						afterBlast = true;
					}
				}
			}
		}
	}
}


void YakhontMissileActor::SetFirstTrack()
{
	trac.SetElevation(90.0f);
	trac.SetSpeed(1);
}

void YakhontMissileActor::GetCurrentLocation(){
	GetTransform(missileTransform);
	missileTransform.GetTranslation(missilePosition);
	missileTransform.GetRotation(missileRotation);

	if (isFirst == true){
		missileFirstPos=missilePosition;
		isFirst=false;
	}

	ExcRange = GetDistance(missilePosition,missileFirstPos);
}

void YakhontMissileActor::SetCurrentLocation(double deltaSimTime){
	track = trac.Calc_Movement(deltaSimTime);
	trac.Calc_Elevation(deltaSimTime);

	missilePosition.x() += track.x();
	missilePosition.y() += track.y();
	missilePosition.z() += track.z();

	missileRotation[0] = -trac.GetDirection();
	missileRotation[1] = trac.GetElevation();
	missileRotation[2] = 0.0f;

	SetCurrentSpeed(trac.GetSpeed()*DEF_MACH_TO_METRE);
	SetCurrentHeading(trac.GetDirection());
	missileTransform.SetRotation(missileRotation);
	missileTransform.SetTranslation(missilePosition);
	SetTransform(missileTransform);
}


void YakhontMissileActor::Climb_Up(float rateElev, float maxElev, int phase){
	trac.SetElevTurnRate(rateElev);
	if (trac.GetElevation() > maxElev){
		trac.SetElevTurnRate(0.0f);
		trac.SetElevation(maxElev);
		mPhase = phase;
	}	
}

void YakhontMissileActor::Climb_Down(float rateElev, float maxElev, int phase){
	trac.SetElevTurnRate(rateElev);
	if (trac.GetElevation() < maxElev){
		trac.SetElevTurnRate(0.0f);
		trac.SetElevation(maxElev);
		mPhase = phase;
	}
}

void YakhontMissileActor::Move_B1_new (){
	if ((missilePosition.z() > 300)&&(mPhase==PHASE_1))
		Climb_Down(-10,0,PHASE_2);
	if ((missilePosition.z() > 300)&&(mPhase==PHASE_2))
		Climb_Down(-10,-90,PHASE_3);
	if ((missilePosition.z()<15) && (mPhase==PHASE_3))
		Climb_Up(10,0, PHASE_4);
	if (mPhase == PHASE_4)
		SearchingTarget();
}

void YakhontMissileActor::MoveRelease(double deltaSimTime)
{
	GetCurrentLocation();

	if (missilePosition.z() >= 587.13 && mState == 0)
	{
		mState = 1;
	}
	
	if (mState == 1)
	{
		trac.SetElevTurnRate(-90);
		if (trac.GetElevation() <= 0)
		{
			trac.SetElevation(0.0f);
			trac.SetElevTurnRate(0.0f);
			trac.SetSpeed(2.0f);
			mState = 2;
		}
	}

	if ((ExcRange > 2000) && (mState == 2)){
		trac.SetElevTurnRate(-90);
		if (trac.GetElevation() <= -85)
		{
			if (trac.GetElevation() <= -85)
			{
				trac.SetElevation(-85.0f);
				trac.SetElevTurnRate(0.0f);
				if (missilePosition.z() <= 0)
				{
					UpdateStatusDBEffectTo2D(mMyParent.get(), ST_MISSILE_DEL);
					isLaunch = false;
					std::cout<<"End Of Release Yakhont "<<std::endl;
				}
			}			
		}
	}

	SetCurrentLocation(deltaSimTime);
}

void YakhontMissileActor::Move(double deltaSimTime)
{
	GetCurrentLocation();	

	if (mMissileTrack == B1) Move_B1();
	else if (mMissileTrack == B1n) Move_B1n();
	else if (mMissileTrack == B2) Move_B2();
	else if (mMissileTrack == B2n) Move_B2n();

	if(isFind==true)
	{
		dynamic_cast<VehicleActor*>(mShipTarget.get())->GetTransform(objectTransform);
		objectTransform.GetTranslation(objectPosition);
		objectTransform.GetRotation(objectRotation);

		nbearing = ComputeBearingTo2(missilePosition.x(),missilePosition.y(),objectPosition.x(),objectPosition.y());
		nbearing = ValidateDegree(nbearing);
		npitch	 = GetPitch(missilePosition,objectPosition);

		if (nbearing <= trac.GetDirection()){
			trac.SetDirection(trac.GetDirection()+1);
			if (trac.GetDirection()>=nbearing)
				trac.SetDirection(nbearing);
		}
		else if (nbearing > trac.GetDirection()){
			trac.SetDirection(trac.GetDirection()-1);
			if (trac.GetDirection()<=nbearing)
				trac.SetDirection(nbearing);
		}
	}

	SetCurrentLocation(deltaSimTime);
}

void YakhontMissileActor::Move_B1(){
	if ((missilePosition.z() >= 587.13) && (mPhase == PHASE_1)){
		trac.SetElevTurnRate(-90);
		trac.SetDirection(Direction2D);
		if (trac.GetElevation() <= 0)
		{
			trac.SetElevation(0.0f);
			trac.SetElevTurnRate(0.0f);
			mPhase = PHASE_2;
			trac.SetSpeed(2.0f);
			//printf("z1=%f\n",missilePosition.z());
		}	 
	}

	if ((ExcRange > 2000) && (mPhase == PHASE_2)){
		trac.SetElevTurnRate(-90);
		if (trac.GetElevation() <= -85)
		{
			trac.SetElevation(-85.0f);
			trac.SetElevTurnRate(0.0f);
			mPhase = PHASE_3;
			//printf("z2=%f\n",missilePosition.z());
		}
	}

	if (mPhase == PHASE_3)	{
		trac.SetElevTurnRate(90);
		//if (missilePosition.z() <= 15)
		if (trac.GetElevation() >= 0.0)
		{
			//missilePosition.z() = 15;
			trac.SetElevation(0.0f);
			trac.SetElevTurnRate(0.0f);
			trac.SetSpeed(2.0f);
			printf("z3=%f\n",missilePosition.z());
			mPhase = PHASE_4;
		}
	}

	if ((Range2D >= 50000) && (mPhase == PHASE_4)&&(isFind==false)){
		if (ExcRange >= (Range2D-50000)) {	
			if(firstSeeker==true){
				std::cout << "Seeker ON Range = " << ExcRange << "Metre From Target" <<std::endl;
				firstSeeker = false;
			}
			SearchingTarget();
		}
	}
	else if ((Range2D <= 50000) && (mPhase == PHASE_4)&&(isFind==false)){
		SearchingTarget();
		if(firstSeeker==true){
			std::cout << "Seeker ON Range = " << ExcRange << "Metre From Target" <<std::endl;
			firstSeeker = false;
		}
	}

	if ((ExcRange >= (Range2D - 3000))&&(isFind==true))
	{
		if (npitch<=trac.GetElevation()){
			trac.SetElevation(trac.GetElevation()+1);
			if (trac.GetElevation()>=npitch)
				trac.SetElevation(npitch);
		}
		else if (npitch>trac.GetElevation()){
			trac.SetElevation(trac.GetElevation()-1);
			if (trac.GetElevation()<=npitch)
				trac.SetElevation(npitch);
		}
	}
}

void YakhontMissileActor::Move_B1n(){
	if ((missilePosition.z() >= 300) && (mPhase == PHASE_1)){
		trac.SetElevTurnRate(-90);
		trac.SetDirection(Direction2D);
		if (trac.GetElevation() <= 0)
		{
			trac.SetElevation(0.0f);
			trac.SetElevTurnRate(0.0f);
			mPhase = PHASE_2;
			trac.SetSpeed(2.0f);
			//printf("z1=%f\n",missilePosition.z());
		}	 
	}

	//if (mPhase == PHASE_2){
	if ((ExcRange > 2000) && (mPhase == PHASE_2)){
		trac.SetElevTurnRate(-90);
		if (trac.GetElevation() <= -85)
		{
			trac.SetElevation(-85.0f);
			trac.SetElevTurnRate(0.0f);
			mPhase = PHASE_3;
			//printf("z2=%f\n",missilePosition.z());
		}
	}

	if (mPhase == PHASE_3)	{
		trac.SetElevTurnRate(90);
		if (missilePosition.z() <= 15) // ?? [9/27/2012 DID RKT2]
		if (trac.GetElevation() >= 0.0)
		{
			missilePosition.z() = 15;
			trac.SetElevation(0.0f);
			trac.SetElevTurnRate(0.0f);
			//printf("z3=%f\n",missilePosition.z());
			mPhase = PHASE_4;
		}
	}

	if ((ExcRange >= (Range2D-50000)) && (mPhase == PHASE_4)){
		trac.SetElevTurnRate(90);
		if (trac.GetElevation() >= 85)
		{
			trac.SetElevation(0.0f);
			trac.SetElevTurnRate(0.0f);
			//printf("z4=%f\n",missilePosition.z());
			mPhase = PHASE_5; 
		}
	}

	//if ((missilePosition.z() >= 400) && (mPhase == PHASE_5)){
	if (mPhase == PHASE_5){
		trac.SetElevTurnRate(-90);
		if (trac.GetElevation() <= -85)
		{
			trac.SetElevation(-85.0f);
			trac.SetElevTurnRate(0.0f);
			mPhase = PHASE_6;
			//printf("z5=%f\n",missilePosition.z());
		}
	}

	if (mPhase == PHASE_6)	{
		trac.SetElevTurnRate(90);
		if (missilePosition.z() <= 15)
		{
			missilePosition.z() = 15;
			trac.SetElevation(0.0f);
			trac.SetElevTurnRate(0.0f);
			trac.SetSpeed(2.0f);
			//printf("z6=%f\n",missilePosition.z());
			mPhase = PHASE_7;
		}
	}

	if ((mPhase == PHASE_7) && (isFind==false)){
		SearchingTarget();
		if(firstSeeker==true){
			std::cout << "Seeker ON Range = " << ExcRange << "Metre From Target" <<std::endl;
			firstSeeker = false;
		}
	}

	if ((ExcRange >= (Range2D - 3000))&&(isFind==true))
	{
		if (npitch<=trac.GetElevation()){
			trac.SetElevation(trac.GetElevation()+1);
			if (trac.GetElevation()>=npitch)
				trac.SetElevation(npitch);
		}
		else if (npitch>trac.GetElevation()){
			trac.SetElevation(trac.GetElevation()-1);
			if (trac.GetElevation()<=npitch)
				trac.SetElevation(npitch);
		}
	}
}

void YakhontMissileActor::Move_B2(){
	if ((missilePosition.z() >= 587.13) && (mPhase == PHASE_1)){
		trac.SetElevTurnRate(-90);
		trac.SetDirection(Direction2D);
		if (trac.GetElevation() <= 0)
		{
			trac.SetElevation(0.0f);
			trac.SetElevTurnRate(0.0f);
			mPhase = PHASE_2;
			trac.SetSpeed(2.0f);
			//printf("z1=%f\n",missilePosition.z());
		}	 
	}

	if ((ExcRange > 2000) && (mPhase == PHASE_2)){
		trac.SetElevTurnRate(10);
		if (trac.GetElevation() >= 80)
		{
			trac.SetElevation(80.0f);
			trac.SetElevTurnRate(0.0f);
			mPhase = PHASE_3;
			//printf("z2=%f\n",missilePosition.z());
		}
	}

	if ((missilePosition.z() > 12373) && (mPhase == PHASE_3)){
		trac.SetElevTurnRate(-10);
		if (trac.GetElevation() <= 0)
		{
			trac.SetElevation(0.0f);
			trac.SetElevTurnRate(0.0f);
			mPhase = PHASE_4;
			trac.SetSpeed(2.0f);
			//printf("z3=%f\n",missilePosition.z());
		}
	}

	if ( (ExcRange >= (Range2D - 60000)) && (mPhase == PHASE_4)){
		trac.SetElevTurnRate(-10);
		if (trac.GetElevation() <= -85.0f)
		{
			trac.SetElevation(-85.0f);
			trac.SetElevTurnRate(0.0f);
			mPhase = PHASE_5;
			//printf("z4=%f\n",missilePosition.z());
		}
	}

	if ((missilePosition.z() < 3596) && (mPhase == PHASE_5)){
		//trac.SetElevTurnRate(10);
		/*if (trac.GetElevation() >= 0.0f)
		{
			trac.SetElevation(0.0f); 
			trac.SetElevTurnRate(0.0f);
			mPhase = PHASE_6;
			printf("z5=%f\n",missilePosition.z());
		}*/
		if (missilePosition.z() <= 15)
		{
			missilePosition.z() = 15;
			trac.SetElevation(0.0f);
			trac.SetElevTurnRate(0.0f);
			trac.SetSpeed(2.0f);
			//printf("z6=%f\n",missilePosition.z());
			mPhase = PHASE_6;
		}
	}

	if ((mPhase == PHASE_6) && (isFind==false)){
		if(firstSeeker==true){
			std::cout << "Seeker ON Range = " << ExcRange << "Metre From Target" <<std::endl;
			firstSeeker = false;
		}
		SearchingTarget();
	}

	if ((ExcRange >= (Range2D - 3000))&&(isFind==true))
	{
		if (npitch<=trac.GetElevation()){
			trac.SetElevation(trac.GetElevation()+1);
			if (trac.GetElevation()>=npitch)
				trac.SetElevation(npitch);
		}
		else if (npitch>trac.GetElevation()){
			trac.SetElevation(trac.GetElevation()-1);
			if (trac.GetElevation()<=npitch)
				trac.SetElevation(npitch);
		}
	}
}

void YakhontMissileActor::Move_B2n(){
	if ((missilePosition.z() >= 300) && (mPhase == PHASE_1)){
		trac.SetElevTurnRate(-90);
		trac.SetDirection(Direction2D);
		if (trac.GetElevation() <= 0)
		{
			trac.SetElevation(0.0f);
			trac.SetElevTurnRate(0.0f);
			mPhase = PHASE_2;
			trac.SetSpeed(2.0f);
			//printf("z1=%f\n",missilePosition.z());
		}		 
	}

	if ((ExcRange > 2000) && (mPhase == PHASE_2)){
		trac.SetElevTurnRate(10);
		if (trac.GetElevation() >= 80)
		{
			trac.SetElevation(80.0f);
			trac.SetElevTurnRate(0.0f);
			mPhase = PHASE_3;
			//printf("z2=%f\n",missilePosition.z());
		}
	}

	if ((missilePosition.z() > 12373) && (mPhase == PHASE_3)){
		trac.SetElevTurnRate(-10);
		if (trac.GetElevation() <= 0)
		{
			trac.SetElevation(0.0f);
			trac.SetElevTurnRate(0.0f);
			mPhase = PHASE_4;
			trac.SetSpeed(2.0f);
			//printf("z3=%f\n",missilePosition.z());
		}
	}

	if ( (ExcRange >= (Range2D - 100000)) && (mPhase == PHASE_4)){
		trac.SetElevTurnRate(-10);
		if (trac.GetElevation() <= -85.0f)
		{
			trac.SetElevation(-85.0f);
			trac.SetElevTurnRate(0.0f);
			mPhase = PHASE_5;
			//printf("z4=%f\n",missilePosition.z());
		}
	}

	if ((missilePosition.z() < 3616) && (mPhase == PHASE_5)){
		trac.SetElevTurnRate(10);
		if (trac.GetElevation() >= 0.0f)
		{
			trac.SetElevation(0.0f);
			trac.SetElevTurnRate(0.0f);
			mPhase = PHASE_6; 
			//printf("z5=%f\n",missilePosition.z());
		}
	}

	if ((ExcRange >= (Range2D - 50000)) && (mPhase == PHASE_6)){
		trac.SetElevTurnRate(30);
		if (trac.GetElevation() >= 80)
		{
			trac.SetElevation(80.0f);
			trac.SetElevTurnRate(0.0f);
			mPhase = PHASE_7;
			//printf("z6=%f\n",missilePosition.z());
		}
	}

	if ((missilePosition.z() > 250) && (mPhase == PHASE_7)){
		trac.SetElevTurnRate(-30);
		if (trac.GetElevation() <= 0)
		{
			trac.SetElevation(0.0f);
			trac.SetElevTurnRate(0.0f);
			mPhase = PHASE_8;
			trac.SetSpeed(2.0f);
			//printf("z7=%f\n",missilePosition.z());
		}
	}

	if ((ExcRange >= (Range2D - 30000)) && (mPhase == PHASE_8)){
		trac.SetElevTurnRate(-30);
		if (trac.GetElevation() <= -85)
		{
			trac.SetElevation(-85.0f);
			trac.SetElevTurnRate(0.0f);
			mPhase = PHASE_9;
			//printf("z8=%f\n",missilePosition.z());
		}
	}

	
	if ((missilePosition.z() < 1150) && (mPhase == PHASE_9)){
		/*trac.SetElevTurnRate(90);
		if (trac.GetElevation() >= 0)
		{
			trac.SetElevation(0.0f);
			trac.SetElevTurnRate(0.0f);
			mPhase = PHASE_10;
			trac.SetSpeed(2.0f);
			printf("z9=%f\n",missilePosition.z());
		}*/
		//trac.SetElevTurnRate(90);
		if (missilePosition.z() <= 15)
		{
			missilePosition.z() = 15;
			trac.SetElevation(0.0f);
			trac.SetElevTurnRate(0.0f);
			trac.SetSpeed(2.0f);
			//printf("z10=%f\n",missilePosition.z());
			mPhase = PHASE_10;
		}
	}

	if((mPhase == PHASE_10) && (isFind==false)){
		SearchingTarget();
		if(firstSeeker==true){
			std::cout << "Seeker ON Range = " << ExcRange << "Metre From Target" <<std::endl;
			firstSeeker = false;
		}
	}

	if ((ExcRange >= (Range2D - 3000))&&(isFind==true))
	{
		if (npitch<=trac.GetElevation()){
			trac.SetElevation(trac.GetElevation()+1);
			if (trac.GetElevation()>=npitch)
				trac.SetElevation(npitch);
		}
		else if (npitch>trac.GetElevation()){
			trac.SetElevation(trac.GetElevation()-1);
			if (trac.GetElevation()<=npitch)
				trac.SetElevation(npitch);
		}
	}
}

void YakhontMissileActor::SearchingTarget() //eka - 17022012
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
					VehicleActor* TargetAct = dynamic_cast<VehicleActor*>(TempTarget.get());
					if ( TargetAct != NULL )
					{
						TargetAct->GetTransform(objectTransform);
						objectTransform.GetTranslation(objectPosition);
						objectTransform.GetRotation(objectRotation);

						objectTransform.SetTranslation(objectPosition);
						objectTransform.SetRotation(objectRotation);
						TargetAct->SetTransform(objectTransform);

						if(IsInCone(missilePosition, objectPosition, missileRotation.x(), missileRotation.y(), 50000, 25000)){		
							std::cout<< GetName() << " find target " << TempTarget->GetName() << std::endl;
							DistanceToTarget = GetDistanceCone(missilePosition,objectPosition);
							if (DistanceToTarget <= jarakTarget){
								jarakTarget=DistanceToTarget;
								Range2D = GetDistance(missilePosition,objectPosition); // antisipasi input 2D > jarak target pada peta  [9/24/2012 DID RKT2]
								isFind = true;
								mShipTarget = TempTarget ;
							}
						}
					}
				}
			}
		}	
	}
}

void YakhontMissileActor::YakhontBlast(osg::Vec3 TargetPos)
{
	mSmoke ->SetEnabled(false);
	UpdateStatusDBEffectTo3DExplode(TargetPos.x(), TargetPos.y(), TargetPos.z() ,ST_MISSILE_EXPLODE);
}

void YakhontMissileActor::OnEnteredWorld()
{
	mSmoke = new dtCore::ParticleSystem();
	mSmoke->LoadFile("trailyakhont.osg",true);
	//mSmoke->SetEnabled(false);
	GetGameActorProxy().GetActor()->AddChild(mSmoke.get());

	missileSound = dtAudio::AudioManager::GetInstance().NewSound();
	missileSound->LoadFile("Sounds/Missile.wav");
	//missileSound->LoadFile("Sounds/beep.wav");
	assert(missileSound);
	missileSound->SetMaxDistance(1000.0f);
	missileSound->SetLooping(true);
	AddChild(missileSound.get());

	MissilesActor::OnEnteredWorld();
}

void YakhontMissileActor::OnRemovedFromWorld()
{
	MissilesActor::OnRemovedFromWorld();
}


///////////////////////////////////////////////////////////////////////////////

YakhontMissileActorProxy::YakhontMissileActorProxy(){}

///////////////////////////////////////////////////////////////////////////////
void YakhontMissileActorProxy::BuildPropertyMap()
{
	MissilesActorProxy::BuildPropertyMap();

	YakhontMissileActor* actor = NULL;
	GetActor(actor);

	AddProperty(new dtDAL::FloatActorProperty(C_SET_SPEED,C_SET_SPEED,
		dtDAL::FloatActorProperty::SetFuncType(actor, &YakhontMissileActor::SetCurrentSpeed),
		dtDAL::FloatActorProperty::GetFuncType(actor, &YakhontMissileActor::GetCurrentSpeed), "Sets/gets speed.", C_TYPE_MISSILE));

	AddProperty(new dtDAL::FloatActorProperty(C_SET_HEADING,C_SET_HEADING,
		dtDAL::FloatActorProperty::SetFuncType(actor, &YakhontMissileActor::SetCurrentHeading),
		dtDAL::FloatActorProperty::GetFuncType(actor, &YakhontMissileActor::GetCurrentHeading), "Sets/gets Heading.", C_TYPE_MISSILE));

}

///////////////////////////////////////////////////////////////////////////////
void YakhontMissileActorProxy::CreateActor()
{
   SetActor(*new YakhontMissileActor(*this));
}

///////////////////////////////////////////////////////////////////////////////
void YakhontMissileActorProxy::OnEnteredWorld()
{
	MissilesActorProxy::OnEnteredWorld();
	RegisterForMessages(SimMessageType::YAKHONT_EVENT, dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
}