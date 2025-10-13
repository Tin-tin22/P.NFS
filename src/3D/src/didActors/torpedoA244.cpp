#include "torpedoA244.h"
#include "ShipModelActor.h"
#include "submarineactor.h"

#include "didactorssources.h"

///////////////////////////////////////////////////////////////////////////////
// panjang kabel 15311+20122 yard..14000.3784 +18399.5568 meter =32400.00 meter
// low speed 18knot 
// med speed 23knot
// high speed 34knot

//koding a244 ini masih mbuletisasi :D , au ah binun di trajectori nya, dilema :))
//nanti klo ada waktu di buatkan kayak trajectory nya/movement kapal,tinggal set course, cek effectrudder
///////////////////////////////////////////////////////////////////////////////

TorA244Actor::TorA244Actor(dtGame::GameActorProxy &proxy) : MissilesActor(proxy),
	   isFirst(true),
	   isPertamax(true),
	   isFirstToStartCircleMode(false),
	   isSecondToStartCircleMode(false),
	   isThirdToStartCircleMode(false),
	   isFourthToStartCircleMode(false),
	   isFifthToStartCircleMode(false),
	   isSnakeSearch(false),
	   isSnakeSearchDn(false),
	   isStartSnake(false),
	   isCircle(false),
	   isFind(false),
	   isFirstGetDir(true),
	   firstDirection(0),
	   timeToGoISC(0),
	   jarak1(0),
	   getPitch(0),
	   getDir(0),
	   jarakTarget(10000000.0f),
	   existTime(0),
	   iLoop(0)
{}

TorA244Actor::~TorA244Actor()
{
	
}
///////////////////////////////////////////////////////////////////////////////
void TorA244Actor::TickLocal(const dtGame::Message &tickMessage)
{
	const dtGame::TickMessage &tick = static_cast<const dtGame::TickMessage&>(tickMessage);
	float deltaSimTime = tick.GetDeltaSimTime();

	if(GetGameActorProxy().IsInGM()){
		if(isLaunch == true)
		{
			/*dtCore::RefPtr<dtDAL::ActorProxy> hitTargetProxy= CeckCollision(trac.GetSpeedKnot()* DEF_KNOT_TO_METRE, tick.GetDeltaSimTime());
			if ( hitTargetProxy != NULL )
			{
				std::cout<<"Torpedo "<< mMissileID <<" hit "<<hitTargetProxy->GetName()<<std::endl;
				UpdateStatusDBEffectTo2D(hitTargetProxy->GetActor(), ST_MISSILE_HIT);
				TorpBlast(hitTargetProxy.get());
			}*/

			if ( GetGameActorProxy().GetGameManager()->GetMachineInfo().GetName() == C_MACHINE_SERVER )
				CeckCollisionA244(deltaSimTime);

			Move(tick.GetDeltaSimTime());

			existTime+=deltaSimTime;
			if (existTime>=772) EndOfTorpedo(); //jarak jangkau 13.5km dg kecepatan 34knot

			//Sound Effect
			if ( missileSound != NULL ){
				if ( !missileSound->IsPlaying() ) 
					missileSound->Play();
			}
		}
	} 
}

///////////////////////////////////////////////////////////////////////////////
void TorA244Actor::TickRemote(const dtGame::Message &tickMessage)
{
   const dtGame::TickMessage &tick = static_cast<const dtGame::TickMessage&>(tickMessage);
}

void TorA244Actor::ProcessOrderEvent(const dtGame::Message &message)
{
	const MsgSetTorpedo &Msg = static_cast<const MsgSetTorpedo&>(message);

	int vhcID = (int) Msg.GetVehicleID();

	dtCore::RefPtr<dtDAL::ActorProxy> parentProxy = GetShipActorByID(vhcID);

	if ( parentProxy.valid() )
	{
		mMyParent = parentProxy->GetActor();
		dtCore::RefPtr<VehicleActor> parent = static_cast<VehicleActor*>(parentProxy->GetActor());
		int lcrID = (int) Msg.GetLauncherID();
		int misID = (int) Msg.GetMissileID();

		idLauncher = (int) Msg.GetLauncherID();

		if (( !GetLaunched() ) &&  
			( IsMissileValidID( Msg.GetVehicleID(),Msg.GetWeaponID(),Msg.GetLauncherID(),Msg.GetMissileID(),Msg.GetMissileNum() ) ) )
		{
			int orderID = (int) Msg.GetOrderID();
			switch ( orderID ){
				case ORD_TORPEDO_FIRED : 
				{
					if( isLaunch == false )
					{
						mMyParent = parentProxy->GetActor();
							
						CSetTorpedoISC(Msg.GetTorpedoISC());
						CSetTorpedoISR(Msg.GetTorpedoISR());
						CSetTorpedoPRG(Msg.GetTorpedoPRG());
						CSetTorpedoWTR(Msg.GetTorpedoWTR());
						CSetTorpedoCEI(-1*Msg.GetTorpedoCEI());
						CSetTorpedoFLO(-1*Msg.GetTorpedoFLO());
						CSetTorpedoACE(Msg.GetTorpedoACE());
						CSetTorpedoISD(-1*Msg.GetTorpedoISD());

						SetVehicleID(Msg.GetVehicleID());

						course[0]=CGetTorpedoISC(); 

						if (course[0]>=45.0f)
							course[1]=course[0]-45;
						else
							course[1]=course[0]+45;

						course[2]=course[1]+90;
						course[3]=course[2]+90;
						course[4]=course[3]+90;  
						

						// - Close ISC [5/19/2014 EKA]
						/*course[1] = ValidateDegree(course[0]-45);
						course[2] = ValidateDegree(course[1]+90);
						course[3] = ValidateDegree(course[2]+90);
						course[4] = ValidateDegree(course[3]+90);*/
						
						AddToEnvironmentActor();

						InitRun();

						isLaunch = true;

						UpdateStatusDBEffectTo2D(mMyParent.get(),ST_MISSILE_RUN);
						std::cout << GetName() << " " << mMissileID << " run." << std::endl ;
					} else 
						std::cout << GetName() <<" "<< mMissileID <<" already launching." << std::endl ;

				}
				break;

			} // end switch

		} /// end if ( lcrID == idLauncher  && misID == mMissileID  )
	} // end if ( parentProxy.valid() )
}

///////////////////////////////////////////////////////////////////////////////
void TorA244Actor::ProcessMessage(const dtGame::Message &message)
{
  if(GetGameActorProxy().IsInGM())
  {
    if(message.GetMessageType().GetName() == SimMessageType::TORPEDO_EVENT.GetName())
      ProcessOrderEvent(message);
  }
}

void TorA244Actor::CeckCollisionA244(float pDeltaTime)
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
	GetGameActorProxy().GetGameManager()->FindActorsByType(*(GetGameActorProxy().GetGameManager()->FindActorType(C_ACTOR_CAT, C_CN_SUBMARINE)), SearchShipProxy );

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
						std::cout<<"Torpedo "<< mMissileID <<" hit "<<SearchShipTarget->GetName()<<std::endl;
						UpdateStatusDBEffectTo2D(SearchShipTarget, ST_MISSILE_HIT, GetMissileLethality());
						TorpBlast(TargetPosition);
					}
				}
			}
		}
	}
}


void TorA244Actor::SearchingTarget() //eka - 17022012
{	
	mShipTarget = NULL ;
	dtCore::RefPtr<dtCore::DeltaDrawable> TempTarget;
	typedef std::vector<dtDAL::ActorProxy*> ActorProxyVector;
	ActorProxyVector TempProxy;
	GetGameActorProxy().GetGameManager()->FindActorsByType(*(GetGameActorProxy().GetGameManager()->FindActorType(C_ACTOR_CAT, C_CN_SUBMARINE)), TempProxy );

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
				SubMarineActor* TargetAct = dynamic_cast<SubMarineActor*>(TempTarget.get());
				if ( TargetAct != NULL )
				{
					TargetAct->GetTransform(objectTransform);
					objectTransform.GetTranslation(objectPosition);
					objectTransform.GetRotation(objectRotation);

					objectTransform.SetTranslation(objectPosition);
					objectTransform.SetRotation(objectRotation);
					TargetAct->SetTransform(objectTransform);

					if(IsInCone(missilePosition, objectPosition, missileRotation.x(), missileRotation.y(), 2000, 2310)){		
						std::cout<< GetName() << " find target " << TempTarget->GetName() << std::endl;
						jarakSubmarine = GetDistanceCone(missilePosition,objectPosition);
						if (jarakSubmarine<=jarakTarget){
							jarakTarget=jarakSubmarine;
							isFind=true;
							mShipTarget = TempTarget ;
						}
					}
				}
			}
		}	
	}
}

void  TorA244Actor::MoveCheckMissingTarget()
{
	if ( mShipTarget != NULL)
	{
		dynamic_cast<VehicleActor*>(mShipTarget.get())->GetTransform(objectTransform);
		objectTransform.GetTranslation(objectPosition);
		objectTransform.GetRotation(objectRotation);

		GetTransform(missileTransform);
		missileTransform.GetTranslation(missilePosition);
		missileTransform.GetRotation(missileRotation);

		/* If Not Inside Cone Missile, Missile Will Searching New Target */ 
		if( IsInCone( missilePosition, objectPosition, missileRotation.x(), missileRotation.y(), 1852, 446 ) == false )
		{
			//Send Explode
			dtCore::RefPtr<MsgUtilityAndTools> msgExplode;
			dtGame::GameManager* gm= GetGameActorProxy().GetGameManager();
			dtGame::MessageFactory* mf=&gm->GetMessageFactory();
			mf->CreateMessage(*(mf->GetMessageTypeByName(C_MT_UTILITY_AND_TOOLS)),msgExplode);

			msgExplode->SetOrderID(TIPE_UTIL_EVENT_EXPLODE);
			msgExplode->SetUAT0(CT_TORPEDO_A244S);
			msgExplode->SetUAT1(missilePosition.x());    
			msgExplode->SetUAT2(missilePosition.y());   
			msgExplode->SetUAT3(missilePosition.z()); 

			GetGameActorProxy().GetGameManager()->SendNetworkMessage(*msgExplode.get());
			GetGameActorProxy().GetGameManager()->SendMessage(*msgExplode.get());

			std::cout << "A244 Delete By Miss Target " <<std::endl;	
			UpdateStatusDBEffectTo2D(mMyParent.get(), ST_MISSILE_DEL);

		}
	}
}


void TorA244Actor::Move(double deltaSimTime){
	GetTransform(missileTransform);
	missileTransform.GetTranslation(missilePosition);
	missileTransform.GetRotation(missileRotation);

	trac.Calc_SpeedTorp(deltaSimTime);
	dir = trac.Calc_MovementTorp(deltaSimTime);

	missilePosition.x() += dir.x();
	missilePosition.y() += dir.y();
	missilePosition.z() += dir.z();

	missileRotation[0] = -trac.GetDirection();
	//missileRotation[1] = trac.GetElevation();
	missileRotation[2] = 0.0f;

	if (isPertamax== true){
		pertamaxPos=missilePosition;
		isPertamax=false;
	}

	currentRange = GetDistance(missilePosition,pertamaxPos);
	if ((currentRange >= CGetTorpedoACE()) && (isFind == false))
		SearchingTarget();

	trac.SetElevation(-15.0);
	if((missilePosition.z()<=CGetTorpedoISD()) && (isThirdToStartCircleMode==false)){
		trac.SetElevation(0.0f);
	}

	timeToGoISC+=deltaSimTime;

	if (timeToGoISC >= 10.0f) {
		trac.SetSpeedKnot(34.0);
		trac.SetAcceleration(0.0);

		if (isFirst == true){
			missileFirstPos=missilePosition;
			isFirst=false;
		}

		jarak1 = GetDistance(missilePosition,missileFirstPos);

		if(isFind==false)
		{
			if ( ( CGetTorpedoPRG() == Helix ) && ( CGetTorpedoWTR() == Shallow) )
				Move_Helix_Shallow(deltaSimTime);
			else if ( ( CGetTorpedoPRG() == Helix ) && ( CGetTorpedoWTR() == Deep) )
				Move_Helix_Deep(deltaSimTime);
			else if ( ( CGetTorpedoPRG() == Spiral ) && ( CGetTorpedoWTR() == Shallow) )
				Move_Spiral_Shallow(deltaSimTime);
			else if ( ( CGetTorpedoPRG() == Spiral ) && ( CGetTorpedoWTR() == Deep) )
				Move_Spiral_Deep(deltaSimTime);
		}
		else
		{
			dynamic_cast<SubMarineActor*>(mShipTarget.get())->GetTransform(objectTransform);
			objectTransform.GetTranslation(objectPosition);
			objectTransform.GetRotation(objectRotation);

			nbearing = ComputeBearingTo2(missilePosition.x(),missilePosition.y(),objectPosition.x(),objectPosition.y());
			//nbearing = ValidateDegree(nbearing);
			npitch	 = GetPitch(missilePosition,objectPosition);

			if (isFirstGetDir==true){
				getDir=trac.GetDirection();
				getPitch=trac.GetElevation();
				isFirstGetDir=false;

				//std::cout << getDir << " , " << nbearing << std::endl;
			} 

			static const double RATE = 2;

			/*if (nbearing<=getDir){
				trac.SetDirection(trac.GetDirection()-RATE);
				if (trac.GetDirection()<=nbearing)
					trac.SetDirection(nbearing);
			}
			else if (nbearing>getDir){
				trac.SetDirection(trac.GetDirection()+RATE);
				if (trac.GetDirection()>=nbearing)
					trac.SetDirection(nbearing);
			}

			if (npitch<=getPitch){
				trac.SetElevation(trac.GetElevation()+RATE);
				if (trac.GetElevation()>=npitch)
					trac.SetElevation(npitch);
			}
			else if (npitch>getPitch){
				trac.SetElevation(trac.GetElevation()-RATE);
				if (trac.GetElevation()<=npitch)
					trac.SetElevation(npitch);
			}*/

			trac.SetDirection(nbearing);
			trac.SetElevation(npitch);

			//MoveCheckMissingTarget();
		}
	}

	SetCurrentSpeed(trac.GetSpeedKnot()*DEF_KNOT_TO_METRE);
	SetCurrentHeading(trac.GetDirection());
	missileTransform.SetRotation(missileRotation);
	missileTransform.SetTranslation(missilePosition);
	SetTransform(missileTransform);
}

void TorA244Actor::Move_Helix_Shallow(double deltaSimTime)
{
	if (fabs(firstDirection-course[iLoop])<=180.0 && isFirstToStartCircleMode==false && isSecondToStartCircleMode==false && isStartSnake==false){
		trac.SetDirection(trac.GetDirection()+(6*deltaSimTime));
		if (trac.GetDirection()>=course[iLoop]){
			trac.SetDirection(course[iLoop]);
			isStartSnake = true;
			isSnakeSearchDn = false;
		}
	}
	else if (fabs(firstDirection-course[iLoop])>=180.0 && isFirstToStartCircleMode==false && isSecondToStartCircleMode==false && isStartSnake==false){
		trac.SetDirection(trac.GetDirection()-(6*deltaSimTime));
		if (trac.GetDirection()<=course[iLoop]){
			trac.SetDirection(course[iLoop]);
			isStartSnake = true;
			isSnakeSearchDn = false;
		}
	}

	if (jarak1 >= CGetTorpedoISR()&& isCircle==false){
		isFirstToStartCircleMode=true;
		isCircle=true;
		isStartSnake = false;

		std::cout << GetName() << mMissileID << " First Circle , Pattern " << iLoop+1 <<std::endl;
	}

	if (isFirstToStartCircleMode == true){
		trac.SetDirection(trac.GetDirection()-(6*deltaSimTime));
		if (trac.GetDirection()<=(-360 + course[iLoop]))
		{
			isSecondToStartCircleMode=true; 
			isFirstToStartCircleMode=false; 

			std::cout << GetName() << mMissileID << " Second Circle , Pattern " << iLoop+1 <<std::endl;
		}
	}

	if (isSecondToStartCircleMode == true)
	{
		trac.SetDirection(trac.GetDirection()+(6*deltaSimTime));
		if (trac.GetDirection()>=course[iLoop])
		{
			tempfirstDirection=firstDirection; 
			firstDirection=course[iLoop];
			//std::cout << "firstDirection" <<firstDirection << std::endl;
			iLoop++;
			if(iLoop==4) EndOfTorpedo();
			isFirstToStartCircleMode=false;
			isSecondToStartCircleMode=false;
			isCircle=false;
			missileFirstPos=missilePosition;
			isSnakeSearch=true;
			dirBeforeSnake = trac.GetDirection();
			
		}
	}

	if ((isSnakeSearch==true)&&(isCircle==false)&&(isStartSnake==true))
	{
		//std::cout << "prepare start snake" <<trac.GetDirection() << std::endl;
		static double timeSnake;
		timeSnake+=deltaSimTime;
		if (timeSnake >= 8)
		{
			//std::cout << "start snake" <<trac.GetDirection() << std::endl;
			trac.SetDirection(trac.GetDirection()-(20*deltaSimTime));
			//std::cout << "start snake" <<firstDirection << std::endl;
			if (trac.GetDirection()<=(tempfirstDirection-40))
			{
				trac.SetDirection(tempfirstDirection-40);
				isSnakeSearch=false;
				isSnakeSearchDn=true;
				//std::cout << trac.GetDirection() << std::endl;
			}
		}
	}

	if ((isSnakeSearchDn==true)&&(isCircle==false)&&(isStartSnake==true))
	{
		static double timeSnake;
		timeSnake+=deltaSimTime;
		if (timeSnake >= 8)
		{
			trac.SetDirection(trac.GetDirection()+(20*deltaSimTime));
			if (trac.GetDirection()>=(tempfirstDirection+80))
			{
				trac.SetDirection(tempfirstDirection+80);
				isSnakeSearchDn=false;
				isSnakeSearch=true;
				//std::cout << trac.GetDirection() << std::endl;
			}
		}
	}

	//std::cout << trac.GetDirection() << std::endl;
}


void TorA244Actor::Move_Helix_Deep(double deltaSimTime)
{
	if (fabs(firstDirection-course[iLoop])<=180.0f && isFirstToStartCircleMode==false && isSecondToStartCircleMode==false 
		&& isThirdToStartCircleMode==false && isFourthToStartCircleMode==false && isStartSnake==false)
	{
		trac.SetDirection(trac.GetDirection()+(6*deltaSimTime));
		if (trac.GetDirection()>=course[iLoop]){
			trac.SetDirection(course[iLoop]);
			isStartSnake = true;
			isSnakeSearchDn = false;
		}
	}
	else if (fabs(firstDirection-course[iLoop])>=180.0f && isFirstToStartCircleMode==false && isSecondToStartCircleMode==false 
		&& isThirdToStartCircleMode==false && isFourthToStartCircleMode==false && isStartSnake==false)
	{
		trac.SetDirection(trac.GetDirection()-(6*deltaSimTime));
		if (trac.GetDirection()<=course[iLoop]){
			trac.SetDirection(course[iLoop]);
			isStartSnake = true;
			isSnakeSearchDn = false;
		}
	}

	if (jarak1 >= CGetTorpedoISR()&& isCircle==false){
		isFirstToStartCircleMode=true;
		isCircle=true;
		isStartSnake = false;
		std::cout << GetName() << mMissileID << " First Circle , Pattern " << iLoop+1 <<std::endl;
	}

	if (isFirstToStartCircleMode == true){
		trac.SetDirection(trac.GetDirection()-(6*deltaSimTime));
		if (trac.GetDirection()<=(-360.0f+course[iLoop]))
		{
			isSecondToStartCircleMode=true; 
			isFirstToStartCircleMode=false;

			std::cout << GetName() << mMissileID << " Second Circle , Pattern " << iLoop+1 <<std::endl;
		}
	}

	if (isSecondToStartCircleMode == true)
	{
		trac.SetDirection(trac.GetDirection()+(6*deltaSimTime));
		if (trac.GetDirection()>=course[iLoop])
		{
			isSecondToStartCircleMode = false;
			isThirdToStartCircleMode = true;

			std::cout << GetName() << mMissileID << " Third Circle , Pattern " << iLoop+1 <<std::endl;
		}
	}

	if ( isThirdToStartCircleMode == true ) {
		trac.SetDirection(trac.GetDirection()-(6*deltaSimTime));
		trac.SetElevation(-10);
		missileRotation[1] = trac.GetElevation();
		if (missilePosition.z() < CGetTorpedoFLO()){
			isThirdToStartCircleMode = false;
			isFourthToStartCircleMode = true;

			std::cout << GetName() << mMissileID << " On The Floor" <<std::endl;
		}
	}

	if (isFourthToStartCircleMode == true)
	{
		trac.SetDirection(trac.GetDirection()+(6*deltaSimTime));
		trac.SetElevation(10);
		missileRotation[1] = trac.GetElevation();
		if (missilePosition.z() > CGetTorpedoCEI()){
			std::cout << GetName() << mMissileID << " On The Ceiling" << firstDirection << std::endl;
			isFourthToStartCircleMode = false;
			tempfirstDirection=firstDirection;
			firstDirection=course[iLoop];
			iLoop++;
			if(iLoop==4) EndOfTorpedo();
			isCircle=false;
			missileFirstPos=missilePosition;
			isSnakeSearch=true;
		}
	}

	if ((isSnakeSearch==true)&&(isCircle==false)&&(isStartSnake==true))
	{
		//std::cout << "prepare start snake" <<trac.GetDirection() << std::endl;
		static double timeSnake;
		timeSnake+=deltaSimTime;
		if (timeSnake >= 8)
		{
			//std::cout << "start snake" <<trac.GetDirection() << std::endl;
			trac.SetDirection(trac.GetDirection()-(20*deltaSimTime));
			//std::cout << "start snake" <<tempfirstDirection-40 << std::endl;
			if (trac.GetDirection()<=(tempfirstDirection-40))
			{
				trac.SetDirection(tempfirstDirection-40);
				isSnakeSearch=false;
				isSnakeSearchDn=true;
				//std::cout << trac.GetDirection() << std::endl;
			}
		}
	}

	if ((isSnakeSearchDn==true)&&(isCircle==false)&&(isStartSnake==true))
	{
		static double timeSnake;
		timeSnake+=deltaSimTime;
		if (timeSnake >= 8)
		{
			trac.SetDirection(trac.GetDirection()+(20*deltaSimTime));
			if (trac.GetDirection()>=(tempfirstDirection+80))
			{
				trac.SetDirection(tempfirstDirection+80);
				isSnakeSearchDn=false;
				isSnakeSearch=true;
				//std::cout << trac.GetDirection() << std::endl;
			}
		}
	}
}

void TorA244Actor::Move_Spiral_Shallow(double deltaSimTime)
{
	if (fabs(firstDirection-course[iLoop])<=180.0f && isFirstToStartCircleMode==false && isSecondToStartCircleMode==false 
		&& isThirdToStartCircleMode==false && isStartSnake==false)
	{
		trac.SetDirection(trac.GetDirection()+(6*deltaSimTime));
		//std::cout <<trac.GetDirection() <<" : "<<course[iLoop]<<std::endl;
		if (trac.GetDirection()>=course[iLoop]){
			trac.SetDirection(course[iLoop]);
			isStartSnake = true;
			isSnakeSearchDn = false;
		}
	}
	else if (fabs(firstDirection-course[iLoop])>=180.0 && isFirstToStartCircleMode==false && isSecondToStartCircleMode==false 
		&& isThirdToStartCircleMode==false && isStartSnake==false)
	{
		trac.SetDirection(trac.GetDirection()-(6*deltaSimTime));
		//std::cout <<trac.GetDirection() <<" , "<<course[iLoop]<<std::endl;
		if (trac.GetDirection()<=course[iLoop]){
			trac.SetDirection(course[iLoop]); 
			isStartSnake = true;
			isSnakeSearchDn = false;
		}
	}

	if (jarak1 >= CGetTorpedoISR()&& isCircle==false){
		isFirstToStartCircleMode=true;
		isCircle=true;
		isStartSnake = false;
		std::cout << GetName() << "-" << mMissileID << "-" << mMissileNum << " First Circle , Pattern " << iLoop+1 <<std::endl;
	}

	if (isFirstToStartCircleMode == true){
		trac.SetDirection(trac.GetDirection()-(12*deltaSimTime));
		if (trac.GetDirection()<=(-360.0f+course[iLoop]))
		{
			isSecondToStartCircleMode=true; 
			isFirstToStartCircleMode=false; 

			std::cout <<  GetName() << "-" << mMissileID << "-" << mMissileNum << "Second Circle , Pattern " << iLoop+1 <<std::endl;
		}
	}

	if (isSecondToStartCircleMode == true)
	{
		trac.SetDirection(trac.GetDirection()-(6*deltaSimTime));
		if (trac.GetDirection() <= (-720.0f + course[iLoop]))
		{
			std::cout << GetName() << "-" << mMissileID << "-" << mMissileNum <<  "Third Circle , Pattern " << iLoop+1 <<std::endl;
			isThirdToStartCircleMode = true;
			isSecondToStartCircleMode = false;
		}
	}

	if (isThirdToStartCircleMode == true)
	{
		trac.SetDirection(trac.GetDirection()+(6*deltaSimTime));
		if (trac.GetDirection() >= (course[iLoop] - 360.0f))
		{
			tempfirstDirection=firstDirection;
			firstDirection=course[iLoop];
			iLoop++;
			if(iLoop==4) EndOfTorpedo();
			isFirstToStartCircleMode=false;
			isSecondToStartCircleMode=false;
			isCircle=false;
			missileFirstPos=missilePosition;
			isThirdToStartCircleMode = false;
			isSnakeSearch = true;
		}
	}

	if ((isSnakeSearch==true)&&(isCircle==false)&&(isStartSnake==true))
	{
		//std::cout << "prepare start snake" <<trac.GetDirection() << std::endl;
		static double timeSnake;
		timeSnake+=deltaSimTime;
		if (timeSnake >= 8)
		{
			//std::cout << "start snake" <<trac.GetDirection() << std::endl;
			trac.SetDirection(trac.GetDirection()-(20*deltaSimTime));
			//std::cout << "start snake" <<tempfirstDirection-40 << std::endl;
			if (trac.GetDirection()<=(tempfirstDirection-40))
			{
				trac.SetDirection(tempfirstDirection-40);
				isSnakeSearch=false;
				isSnakeSearchDn=true;
				//std::cout << trac.GetDirection() << std::endl;
			}
		}
	}

	if ((isSnakeSearchDn==true)&&(isCircle==false)&&(isStartSnake==true))
	{
		static double timeSnake;
		timeSnake+=deltaSimTime;
		if (timeSnake >= 8)
		{
			trac.SetDirection(trac.GetDirection()+(20*deltaSimTime));
			if (trac.GetDirection()>=(tempfirstDirection+80))
			{
				trac.SetDirection(tempfirstDirection+80);
				isSnakeSearchDn=false;
				isSnakeSearch=true;
				//std::cout << trac.GetDirection() << std::endl;
			}
		}
	}
}

void TorA244Actor::Move_Spiral_Deep(double deltaSimTime)
{
	if (fabs(firstDirection-course[iLoop])<=180.0 && isFirstToStartCircleMode==false && isSecondToStartCircleMode==false 
		&& isThirdToStartCircleMode==false && isFourthToStartCircleMode==false && isFifthToStartCircleMode==false && isStartSnake==false)
	{
		trac.SetDirection(trac.GetDirection()+(6*deltaSimTime));
		if (trac.GetDirection()>=course[iLoop]){
			trac.SetDirection(course[iLoop]);
			isStartSnake = true;
			isSnakeSearchDn = false;
		}
	}
	else if (fabs(firstDirection-course[iLoop])>=180.0 && isFirstToStartCircleMode==false && isSecondToStartCircleMode==false 
		&& isThirdToStartCircleMode==false && isFourthToStartCircleMode==false && isFifthToStartCircleMode==false && isStartSnake==false)
	{
		trac.SetDirection(trac.GetDirection()-(6*deltaSimTime));
		if (trac.GetDirection()<=course[iLoop]){
			trac.SetDirection(course[iLoop]);
			isStartSnake = true;
			isSnakeSearchDn = false;
		}
	}

	if (jarak1 >= CGetTorpedoISR()&& isCircle==false){
		isFirstToStartCircleMode=true;
		isCircle=true;
		isStartSnake = false;
		std::cout << GetName() << "-" << mMissileID << "-" << mMissileNum << " First Circle , Pattern " << iLoop+1 <<std::endl;
	}

	if (isFirstToStartCircleMode == true){
		trac.SetDirection(trac.GetDirection()-(12*deltaSimTime));
		if (trac.GetDirection()<=(-360.0f+course[iLoop]))
		{
			isSecondToStartCircleMode=true; 
			isFirstToStartCircleMode=false; 

			std::cout <<  GetName() << "-" << mMissileID << "-" << mMissileNum << "Second Circle , Pattern " << iLoop+1 <<std::endl;
		}
	}

	if (isSecondToStartCircleMode == true)
	{
		trac.SetDirection(trac.GetDirection()-(6*deltaSimTime));
		if (trac.GetDirection() <= (-720.0f + course[iLoop]))
		{
			std::cout << GetName() << "-" << mMissileID << "-" << mMissileNum <<  "Third Circle , Pattern " << iLoop+1 <<std::endl;
			isThirdToStartCircleMode = true;
			isSecondToStartCircleMode = false;
		}
	}

	if (isThirdToStartCircleMode == true)
	{
		trac.SetDirection(trac.GetDirection()+(6*deltaSimTime));
		if (trac.GetDirection() >= (course[iLoop] - 360.0f))
		{
			isThirdToStartCircleMode = false;
			isFourthToStartCircleMode = true;
		}
	}

	if (isFourthToStartCircleMode == true)
	{
		trac.SetDirection(trac.GetDirection()-(6*deltaSimTime));
		trac.SetElevation(-10.0f);
		if ( missilePosition.z() <= CGetTorpedoFLO()  ){
			std::cout << GetName() << mMissileID << " On The Floor" <<std::endl;
			isFourthToStartCircleMode = false;
			isFifthToStartCircleMode = true;
		}
	}

	if (isFifthToStartCircleMode == true){
		trac.SetDirection(trac.GetDirection()+(6*deltaSimTime));
		trac.SetElevation(10.0f);
		if ( missilePosition.z() >= CGetTorpedoCEI()  ){
			tempfirstDirection=firstDirection;
			isFifthToStartCircleMode = false;
			std::cout << GetName() << mMissileID << " On The Ceiling" <<std::endl;
			firstDirection=course[iLoop];
			iLoop++;
			if(iLoop==4) EndOfTorpedo();
			isCircle=false;
			missileFirstPos=missilePosition;
			isSnakeSearch = true;
		}
	}

	if ((isSnakeSearch==true)&&(isCircle==false)&&(isStartSnake==true))
	{
		//std::cout << "prepare start snake" <<trac.GetDirection() << std::endl;
		static double timeSnake;
		timeSnake+=deltaSimTime;
		if (timeSnake >= 8)
		{
			//std::cout << "start snake" <<trac.GetDirection() << std::endl;
			trac.SetDirection(trac.GetDirection()-(20*deltaSimTime));
			//std::cout << "start snake" <<tempfirstDirection-40 << std::endl;
			if (trac.GetDirection()<=(tempfirstDirection-40))
			{
				trac.SetDirection(tempfirstDirection-40);
				isSnakeSearch=false;
				isSnakeSearchDn=true;
				//std::cout << trac.GetDirection() << std::endl;
			}
		}
	}

	if ((isSnakeSearchDn==true)&&(isCircle==false)&&(isStartSnake==true))
	{
		static double timeSnake;
		timeSnake+=deltaSimTime;
		if (timeSnake >= 8)
		{
			trac.SetDirection(trac.GetDirection()+(20*deltaSimTime));
			if (trac.GetDirection()>=(tempfirstDirection+80))
			{
				trac.SetDirection(tempfirstDirection+80);
				isSnakeSearchDn=false;
				isSnakeSearch=true;
				//std::cout << trac.GetDirection() << std::endl;
			}
		}
	}
}

void TorA244Actor::InitRun()
{
	float ShipParchimHeading;
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
		ShipParchimHeading = objectRotation.x();
	}

	if (idLauncher == 1){
		firstDirection = - ShipParchimHeading - 45.0f;
		ValidateDegree(firstDirection);
		trac.SetDirection(firstDirection);
	}
	else if (idLauncher == 2){
		firstDirection = - ShipParchimHeading + 45.0f;
		ValidateDegree(firstDirection);
		trac.SetDirection(firstDirection);
	}

	trac.SetSpeedKnot(34.0f);
	trac.SetAcceleration(2.0);
	trac.SetElevation(0.0f);


	dtCore::RefPtr<dtCore::ParticleSystem> mExplosion= new dtCore::ParticleSystem();
	mExplosion->LoadFile(C_PARTICLES_ASAP,true);
	GetGameActorProxy().GetActor()->AddChild(mExplosion.get());
	mExplosion->SetEnabled(true);
}
 
void TorA244Actor::EndOfTorpedo()
{
	SetLaunched(false);
	UpdateStatusDBEffectTo2D(mMyParent.get(), ST_MISSILE_DEL);
}

void TorA244Actor::UnControled()
{

}

void TorA244Actor::TorpBlast(osg::Vec3 TargetPos)
{
	/*dtCore::Transform tx;
	GetTransform(tx,dtCore::Transformable::ABS_CS);
	mExplosion = new dtCore::ParticleSystem();
	mExplosion->LoadFile(C_PARTICLES_TORPEDO_EXPLODE,true);
	p->GetActor()->AddChild(mExplosion.get());
	mExplosion->SetTransform(tx,dtCore::Transformable::ABS_CS);
	mExplosion->SetEnabled(true);*/

	UpdateStatusDBEffectTo3DExplode(TargetPos.x(), TargetPos.y(), TargetPos.z() ,ST_MISSILE_EXPLODE);
	EndOfTorpedo();
}

void TorA244Actor::OnEnteredWorld()
{
	MissilesActor::OnEnteredWorld();

	/*missileSound = dtAudio::AudioManager::GetInstance().NewSound();
	missileSound->LoadFile("Sounds/Missile.wav");
	assert(missileSound);
	missileSound->SetMaxDistance(1000.0f);
	missileSound->SetLooping(true);
	AddChild(missileSound.get());*/
}

void TorA244Actor::OnRemovedFromWorld()
{
	MissilesActor::OnRemovedFromWorld();
}
 

///////////////////////////////////////////////////////////////////////////////

TorA244ActorProxy::TorA244ActorProxy()
{
   //SetClassName(C_CN_TORPPEDO);
}

///////////////////////////////////////////////////////////////////////////////
void TorA244ActorProxy::BuildPropertyMap()
{
   MissilesActorProxy::BuildPropertyMap();
   
   const std::string GROUP = C_TYPE_MISSILE;

   TorA244Actor* actor = NULL;
   
   GetActor(actor);

   //property
   AddProperty(new dtDAL::FloatActorProperty(C_SET_SPEED,C_SET_SPEED,
	dtDAL::FloatActorProperty::SetFuncType(actor, &TorA244Actor::SetCurrentSpeed),
	dtDAL::FloatActorProperty::GetFuncType(actor, &TorA244Actor::GetCurrentSpeed), "Sets/gets speed.", GROUP));

   AddProperty(new dtDAL::FloatActorProperty(C_SET_HEADING,C_SET_HEADING,
	dtDAL::FloatActorProperty::SetFuncType(actor, &TorA244Actor::SetCurrentHeading),
	dtDAL::FloatActorProperty::GetFuncType(actor, &TorA244Actor::GetCurrentHeading), "Sets/gets Heading.", GROUP));
}

 
///////////////////////////////////////////////////////////////////////////////
void TorA244ActorProxy::OnEnteredWorld()
{
	MissilesActorProxy::OnEnteredWorld();
	RegisterForMessages(SimMessageType::TORPEDO_EVENT);
}
