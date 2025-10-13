/*
	Ecoxet MM40 
*/

#include "ExocetMM40Actor.h"
#include "ShipModelActor.h"
#include "didactorssources.h"
#include <dtUtil/mathdefines.h>
#include "../didUtils/utilityfunctions.h"

/* ====================================================================================== */
/* ====  Constructor & Destructor ============*/
ExocetMM40Actor::ExocetMM40Actor(dtGame::GameActorProxy &proxy) : MissilesActor(proxy)
	,TargetPosition(0.0f,0.0f,0.0f)
	,FirstSearchingPosition(0.0f,0.0f,0.0f)
	,missileFirstPos(0.0f,0.0f,0.0f)
{
	mStepMoving		= 0;
	mStepHAFO		= 0;			
	mStepCruise		= 0;		
	mStepSearching	= 0;		
	mModeToTarget	= 0;		
	mFirstTurn		= 0;			
	CurrentHeading	= 0.0f;
	CurrentSpeed	= 0.0f;
	FDegreeToHAFO	= 0.0f;
	FDegreeToCruise	= 0.0f;
	FCruise_Altitude= 0.0f;
	FCruise_Range	= 0.0f;
	FSearchAltitude	= 0.0f;
	FisFindTarget	= false;

	FShipID			= 0;
	FWeaponID		= 0;
	FLauncherID		= 0;
	FMissileID		= 0;
	FMissileNumber	= 0;
	FOrderID		= 0;
	TargetBearing	= 0.0f;
	TargetRange		= 0.0f;
	WithInitialAlt	= 0;
	WithAgilityStep	= 0;
	WithAngularStep	= 0;
	FHAFO_Altitude	= 0.0f;
	FHAFO_Range		= 0.0f;
	FSeekerRange	= 0.0f;
	FTerminalRange	= 0.0f;

	NewTargetBearing = 0.0f;

	MinRange		= 10000.0f;
	MaxRange		= 70000.0f;
  
	MAX_Speed		= 315;
	MIN_Speed		= 200;
	Cruise_Speed	= 200;
	Dive_Speed		= 100;

	/* Turn Every Move */
	TurnElev		 = 30.0f;
	TurnAltitude	 = 2.0f;
	TurnDirection	 = 4.0f;
	TurnDirectionBOL = 10.0f;
	TurnDirectionToTarget = 40.0f;
	TurnAngularDirection = 10.0f;

	/* High Altitude For First STEP Launch */
	FDegreeToHAFO		= 70.0f;
	FHAFO_Altitude		= 500.0f;
	FHAFO_Range			= 500.0f;

	/* Cruise Altitude For Second STEP Launch */
	FDegreeToCruise		= -70.0f;
	FCruise_Altitude	= 10.0f;
	FCruise_Range		= 1000.0f;

	/* Seeking Altitude */
	FSeekerRange		= 10000.0f;
	FSearchAltitude		= 5.0f;

	/* Seeker Property */
	SeekLength_Height   = 3*1852;   /* 3 Nm */
 	SeekLength_Width	= 1.5*1852; /* 1.5 Nm */
	
	mAngularTurn	= 0;
	mModeToTarget	= 1;
	collisionDelay = 0.0f;

	mShipTarget = NULL;
	hitTargetProxy = NULL;

	isCeckCollisionFinish = true;
	isStraight = false;

	//mIsector= new dtCore::Isector;
}

ExocetMM40Actor::~ExocetMM40Actor()
{
	
}

//======================================================================================
int ExocetMM40Actor::GetFirstTurn()
{
	return mFirstTurn;
}

bool ExocetMM40Actor::CheckValidBearingForLauncher(const int LauncherID, float Bearing)
{
	mFirstTurn = 1;
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

		ShipHeading = -objectRotation.x();
		
		std::cout << "Ship Heading : " << ShipHeading << std::endl;
		std::cout << "Target Bearing : " << Bearing << std::endl;

		if ((LauncherID == 2) || (LauncherID == 4))
		{
			double StartAngle;
			double EndAngle;

			StartAngle	= ShipHeading + 170;
			StartAngle	= ValidateDegree(StartAngle);

			EndAngle	= ShipHeading + 10;
			EndAngle	= ValidateDegree(EndAngle);

			if (DegComp_IsBeetwen(Bearing , StartAngle, EndAngle) == true)
			{
				StartAngle	= ShipHeading - 90;
				StartAngle	= ValidateDegree(StartAngle);

				EndAngle	= ShipHeading + 10;
				EndAngle	= ValidateDegree(EndAngle);

				if (DegComp_IsBeetwen(Bearing, StartAngle, EndAngle) == true)
				{
					mFirstTurn = 1;
					std::cout << "Initialize Move Right To Target" << std::endl;
				}
				else
				{
					mFirstTurn = 2;
					std::cout << "Initialize Move Left To Target" << std::endl;
				}

				return true;
			}
			else
				return false;
		}
		else
		if ((LauncherID == 1) || (LauncherID == 3))
		{
			double StartAngle;
			double EndAngle;

			StartAngle	= ShipHeading - 10;
			StartAngle	= ValidateDegree(StartAngle);

			EndAngle	= ShipHeading + 190;
			EndAngle	= ValidateDegree(EndAngle);

			if (DegComp_IsBeetwen(Bearing , StartAngle, EndAngle) == true)
			{	
				StartAngle	= ShipHeading -10;
				StartAngle	= ValidateDegree(StartAngle);

				EndAngle	= ShipHeading +90;
				EndAngle	= ValidateDegree(EndAngle);

				if (DegComp_IsBeetwen(Bearing, StartAngle, EndAngle) == true)
				{
					mFirstTurn = 2;
					std::cout << "Initialize Move Left To Target" << std::endl;
				}
				else
				{	
					mFirstTurn = 1;
					std::cout << "Initialize Move Right To Target" << std::endl;
				}
				
				return true;
			}
			else
				return false;
		}
		else
		{
			return false;
		}


	}
	else
		return false;
}

void ExocetMM40Actor::OnEnteredWorld()
{
	missileTrail = new dtCore::ParticleSystem();
	missileTrail->LoadFile("trailexocet.osg",true);
	missileTrail->SetEnabled(false);
	AddChild(missileTrail.get());
	std::cout << GetName() << " missileTrail End" << std::endl;

	missileSound = dtAudio::AudioManager::GetInstance().NewSound();
	missileSound->LoadFile("Sounds/Missile.wav");
	assert(missileSound);
	missileSound->SetMaxDistance(1000.0f);
	missileSound->SetLooping(true);
	AddChild(missileSound.get());
	std::cout << GetName() << " missileSound End" << std::endl;

	MissilesActor::OnEnteredWorld();
}

void ExocetMM40Actor::OnRemovedFromWorld()
{
	MissilesActor::OnRemovedFromWorld();
}

void ExocetMM40Actor::CeckCollisionExocet(float pDeltaTime)
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

					if( IsInCone(missilePosition, TargetPosition, missileRotation.x(), missileRotation.y(), 15 , 15) == true)
					{ 
						ExocetBlast(TargetPosition);
						UpdateStatusDBEffectTo2D(SearchShipTarget,ST_MISSILE_HIT,GetMissileLethality());
						FisBlast= true;
					}
				}
			}
		}
	}
}

void ExocetMM40Actor::TickLocal(const dtGame::Message &tickMessage)
{
	const dtGame::TickMessage &tick = static_cast<const dtGame::TickMessage&>(tickMessage);
	float deltaSimTime = tick.GetDeltaSimTime();
	float temp_speed = trac.GetSpeed() * DEF_MACH_TO_METRE;
	collisionDelay += tick.GetDeltaSimTime();

	if(GetGameActorProxy().IsInGM())
	{
		if( isLaunch == true )
		{
			//Moving
			Move(tick.GetDeltaSimTime());

			if ( GetGameActorProxy().GetGameManager()->GetMachineInfo().GetName() == C_MACHINE_SERVER )
			{
				//Detect Collision
				CeckCollisionExocet(deltaSimTime);
				/*if ( hitTargetProxy != NULL )
				{
					std::cout << GetName() << " hit " << hitTargetProxy->GetName() <<std::endl;
					ExocetBlast(hitTargetProxy.get());
					UpdateStatusDBEffectTo2D(hitTargetProxy->GetActor(),ST_MISSILE_HIT);
					FisBlast= true;
				}*/
			}			

			//Sound Effect
			if ( missileSound != NULL )
			{
				if ( !missileSound->IsPlaying() ) 
					missileSound->Play();
			}

			//Smoke Effect
			if ( missileTrail != NULL )
			{
				if ( !missileTrail->IsEnabled() )
					missileTrail->SetEnabled(true);
			}
		}

		if( FisBlast == true)
		{
			DestroyExocetMM40();
		}
	}
}

void ExocetMM40Actor::TickRemote(const dtGame::Message &tickMessage)
{
	const dtGame::TickMessage &tick = static_cast<const dtGame::TickMessage&>(tickMessage);
}

void ExocetMM40Actor::ProcessMessage(const dtGame::Message &message)
{
	if(GetGameActorProxy().IsInGM())
	{
		if(message.GetMessageType().GetName() == SimMessageType::EXOCETMM_40_EVENT.GetName())
		{
			std::cout << "Prepare Missile Exocet 40" << std::endl;
			ProcessOrderEvent(message);
		}
	}
}

float ExocetMM40Actor::GetDistance(osg::Vec3 point1, osg::Vec3 point2)
{
	return sqrtf(osg::square(point1.x()-point2.x())+osg::square(point1.y()-point2.y())+osg::square(point1.z()-point2.z()));
}

void ExocetMM40Actor::ProcessOrderEvent(const dtGame::Message &message)
{
	const MsgSetExocetMM40 &Msg = static_cast<const MsgSetExocetMM40&>(message);
	int vhcID = (int) Msg.GetVehicleID();
	dtCore::RefPtr<dtDAL::ActorProxy> parentProxy = GetShipActorByID(vhcID);

	if ( parentProxy.valid() )
	{
		dtCore::RefPtr<VehicleActor> parent = static_cast<VehicleActor*>(parentProxy->GetActor());

		if (( !GetLaunched() ) &&  
			( IsMissileValidID( Msg.GetVehicleID(),Msg.GetWeaponID(),Msg.GetLauncherID(),Msg.GetMissileID(),Msg.GetMissileNum() ) ) )
		{
			std::cout << "===================" << std::endl;
			std::cout << "Process Order Event" << std::endl;

			//==============================
			//Receive From Socket
			//For Ident
			FShipID					= Msg.GetVehicleID(); 
			FWeaponID				= Msg.GetWeaponID();
			FLauncherID				= Msg.GetLauncherID();
			FMissileID				= Msg.GetMissileID();
			FMissileNumber			= Msg.GetMissileNum();
			FOrderID				= Msg.GetOrderID();
			TargetRange				= Msg.GetTargetRange();
			TargetBearing			= Msg.GetTargetBearing();
			WithInitialAlt			= Msg.GetInitialStepMode();
			WithAgilityStep			= Msg.GetAgilityMode();
			WithAngularStep			= Msg.GetAngularMode();
			FHAFO_Altitude			= Msg.GetObstacle_Alt();
			FHAFO_Range				= Msg.GetObstacle_Range();
			FSeekerRange			= Msg.GetApproach_Range();
			FTerminalRange			= Msg.GetTerminal_Range();
			leftAngleSeeker			= Msg.GetLeft_Angle();
			rightAngleSeeker		= Msg.GetRight_Angle();
			farDistance				= Msg.GetFar_Range();
			leftAngle				= Msg.GetLeft_Angle();
			rightAngle				= Msg.GetRight_Angle();
			farRange				= Msg.GetFar_Range();
			nearRange				= Msg.GetNear_Range();
			masking_1				= Msg.GetMasking_1();
			masking_2				= Msg.GetMasking_2();
			masking_3				= Msg.GetMasking_3();
			masking_4				= Msg.GetMasking_4();
			masking_5				= Msg.GetMasking_5();
			masking_6				= Msg.GetMasking_6();
			masking_7				= Msg.GetMasking_7();
			masking_8				= Msg.GetMasking_8();
			masking_9				= Msg.GetMasking_9();
			masking_10				= Msg.GetMasking_10();
			masking_11				= Msg.GetMasking_11();
			masking_12				= Msg.GetMasking_12();
			masking_13				= Msg.GetMasking_13();
			masking_14				= Msg.GetMasking_14();
			masking_15				= Msg.GetMasking_15();
			masking_16				= Msg.GetMasking_16();
			seekerOpenPosX			= Msg.GetSeekerOpenPosX();
			seekerOpenPosY			= Msg.GetSeekerOpenPosY();
			seekerOpenPosHeading	= Msg.GetSeekerOpenHeading();
			//===============================
			int orderID = (int) Msg.GetOrderID();
			switch ( orderID )
			{
				case ORD_MM40_FIRE :
				{
					if ( CheckValidBearingForLauncher(FLauncherID, TargetBearing) == true )
					{
						mMyParent = parent;

						//set seeker jika kiriman paket dari MOC
						if (seekerOpenPosX != 0)
						{
							//set seeker open position (x,y)
							SeekerOpenPos[0] = seekerOpenPosX;
							SeekerOpenPos[1] = seekerOpenPosY;
							//set heading seeker open 
							SeekerOpenRot[0] = seekerOpenPosHeading;
						}
						

						//std::cout<<"X ASLI : "<<SeekerOpenPos[0]<<std::endl;
						//std::cout<<"Y ASLI : "<<SeekerOpenPos[1]<<std::endl;
						//std::cout<<"HEADING ASLI : "<<SeekerOpenRot[0]<<std::endl;


						if (WithAngularStep == 1)
						{
							mAngularTurn = 1;
						}
						else if (WithAngularStep == 2)
						{
							mAngularTurn = 2;
						}
	
						if (TargetRange <= 0)
							mModeToTarget = 2;
						/*else
						if (WithAgilityStep == 1)
							mModeToTarget = 3;
						else
						if (WithAgilityStep == 2)
							mModeToTarget = 4;*/
						else
							mModeToTarget = 1;
						
						//set Angular variable
						flag = 0;
						rateDistAngular = 0.50 * FSeekerRange;

						//set new seeker variable
						/*rightAngle = 10;
						leftAngle = 10;
						farRange = 1000;
						nearRange = 800;*/

						std::cout << "Mode to Target" << mModeToTarget << std::endl;

						std::cout << "Initialize to Launch Exocet 40" << std::endl;
						TargetBearing =  Msg.GetTargetBearing(); 
						TargetRange   =  Msg.GetTargetRange();

						std::cout << "Target Bearing : " << TargetBearing << std::endl;
						std::cout << "Target Range : " << TargetRange << std::endl;

						std::cout << "Mode to Target " << mModeToTarget << std::endl;

						if ((( TargetRange > MinRange) && ( TargetRange < MaxRange)) || (mModeToTarget == 2) && (FHAFO_Range <= 2000)) 
						{
							FLauncherID = Msg.GetLauncherID(); 

							dtCore::Transform t;
							osg::Vec3 vv;
							GetTransform(t);
							t.GetRotation(vv);

							std::vector<dtDAL::ActorProxy *> ap;
							GetGameActorProxy().GetGameManager()->FindActorsByName(C_CN_OCEAN, ap);
							if (ap[0]!= NULL) 
							{
								if ( GetParent() != NULL ) 
									GetParent()->RemoveChild(this);
								static_cast<dtGame::IEnvGameActor*>( ap[0]->GetActor() )->AddActor( *(this) );
							}
							else
								std::cout<<"Environment actor is missing!"<<std::endl;

							SetTransform(t);

							InitializeExocet();
							isLaunch = true;  // Parent
							SetLaunched(true);

							int mistrack;
							
							//std::cout<<"inisital : "<<WithInitialAlt<<std::endl;
							
							if (WithInitialAlt == 0)
							{
								mistrack = 10;
							}
							else
							{
								mistrack = 11;
							}
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
							msgForTrac2D->SetUAT4(mistrack);
							GetGameActorProxy().GetGameManager()->SendNetworkMessage(*msgForTrac2D.get());
							GetGameActorProxy().GetGameManager()->SendMessage(*msgForTrac2D.get());

							UpdateStatusDBEffectTo2D(mMyParent.get(),ST_MISSILE_RUN);
							std::cout << "launch " << GetName() << std::endl;
						}
						else
						{
							std::cout << " Range Too Low or Too High or Not Bearing Launch or To Long Obstacle" << std::endl;
						}
					}
					else
					{
						std::cout << "Bearing Target Not Valid With Trajectory Launcher" << std::endl;
					}
					
				} 
				break;
			}
		}
		else
		{
			std::cout << "Missile has launched or Not Valid Combination " << std::endl;
		}
	}
	else
	{
		std::cout << "parent proxy not valid" << std::endl;
	}
}

void ExocetMM40Actor::InitializeExocet()
{
	//First initialize
	static dtCore::Transform missileTransform;
	static osg::Vec3 missilePosition, missileRotation;
	GetTransform(missileTransform);
	missileTransform.GetTranslation(missilePosition);
	missileTransform.GetRotation(missileRotation);

	missileFirstPos=missilePosition;

	FisDestroy		= false;
	FisBlast		= false;
	mShipTarget		= NULL;

	FisFindTarget	 = false;

	mStepMoving		= 1;
	mStepHAFO		= 1;		
	mStepCruise		= 1;
	mStepSearching	= 1;	
	
	//Set Speed
	trac.SetSpeed(MIN_Speed/DEF_MACH_TO_METRE);
	//Set Elevation
	trac.SetElevation(missileRotation[1]);

	float ShipHeading;
	float MissileDirection;

	std::cout << "initialize exocet" << std::endl;

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

		ShipHeading = -objectRotation.x();
	}

	if ((FLauncherID == 2) || (FLauncherID == 4))
	{
		MissileDirection = ShipHeading - 90.0f;
		trac.SetDirection(MissileDirection);
	}
	else 
	if ((FLauncherID == 1) || (FLauncherID == 3))
	{
		MissileDirection = ShipHeading + 90.0f;
		trac.SetDirection(MissileDirection);
	}
}

bool ExocetMM40Actor::isInRBLSeekerRange(osg::Vec3 missPosSeek, osg::Vec3 targetPosSeek, osg::Vec3 missRotSeek)
{	
	// selisih RTG dan near range(sebagai batas seeker lingkaran bawah)
	float diffRTGNear = FSeekerRange - nearRange;

	//batas jarak exxocet bergerak setelah open seeker
	exxocetMax = farRange + FSeekerRange;
	
	osg::Vec3 LPoint, RPoint;
	float batasAngleKiri, batasAngleKanan;

	if (seekerOpenPosX != 0)
	{
		//batas seeker angle kiri
		LPoint = RangeBearingToCoord(SeekerOpenPos, farRange, ValidateDegree(SeekerOpenRot[0]) - leftAngle);
		batasAngleKiri = ComputeBearingTo2(SeekerOpenPos[0], SeekerOpenPos[1], LPoint[0], LPoint[1]);
		batasAngleKiri = ValidateDegree(batasAngleKiri);
		//batas seeker angle kanan
		RPoint = RangeBearingToCoord(SeekerOpenPos, farRange, ValidateDegree(SeekerOpenRot[0]) + rightAngle);
		batasAngleKanan = ComputeBearingTo2(SeekerOpenPos[0], SeekerOpenPos[1], RPoint[0], RPoint[1]);
		batasAngleKanan = ValidateDegree(batasAngleKanan);
	}
	else
	{
		//batas seeker angle kiri
		LPoint = RangeBearingToCoord(SeekerOpenPos, farRange, ValidateDegree(-(SeekerOpenRot[0])) - leftAngle);
		batasAngleKiri = ComputeBearingTo2(SeekerOpenPos[0], SeekerOpenPos[1], LPoint[0], LPoint[1]);
		batasAngleKiri = ValidateDegree(batasAngleKiri);
		//batas seeker angle kanan
		RPoint = RangeBearingToCoord(SeekerOpenPos, farRange, ValidateDegree(-(SeekerOpenRot[0])) + rightAngle);
		batasAngleKanan = ComputeBearingTo2(SeekerOpenPos[0], SeekerOpenPos[1], RPoint[0], RPoint[1]);
		batasAngleKanan = ValidateDegree(batasAngleKanan);
	}

	
	//sudut missile open seeker ke target
	float bearingOpenMisstoTarget = ComputeBearingTo2(SeekerOpenPos[0], SeekerOpenPos[1], targetPosSeek[0], targetPosSeek[1]);
	bearingOpenMisstoTarget = ValidateDegree(bearingOpenMisstoTarget);

	//jarak missile open seeker ke missile yang berjalan
	float maxMissDist = GetDistance(missPosSeek, SeekerOpenPos);
	//jumlah 2 sudut input right angle dan left angle dibagi 4 bagian daerah bearing exxocet
	float anglePerRegion = (leftAngle + rightAngle)/4;
	//pembagian region berdasarkan bearing
	float regionBearing_1, regionBearing_2, regionBearing_3, regionBearing_4;

	regionBearing_1 = batasAngleKiri + anglePerRegion;
	regionBearing_1 = ValidateDegree(regionBearing_1);

	regionBearing_2 = regionBearing_1 + anglePerRegion;
	regionBearing_2 = ValidateDegree(regionBearing_2);

	regionBearing_3 = regionBearing_2 + anglePerRegion;
	regionBearing_3 = ValidateDegree(regionBearing_3);

	regionBearing_4 = regionBearing_3 + anglePerRegion;
	regionBearing_4 = ValidateDegree(regionBearing_4);
 
	//pembagian region berdasarkan jarak max exxocet
	float regionDist_1, regionDist_2, regionDist_3, regionDist_4;
	float regDistVal = exxocetMax - diffRTGNear;
	float regdistperfour = regDistVal/4;

	regionDist_4 = regDistVal;
	regionDist_3 = regionDist_4 - regdistperfour;
	regionDist_2 = regionDist_3 - regdistperfour;
	regionDist_1 = regionDist_2 - regdistperfour;

	//jarak (RTG - Near Range) ke Target
	float seekerOpenToTarget = GetDistance(SeekerOpenPos, targetPosSeek);
	float RTGNeartoTarget = seekerOpenToTarget - diffRTGNear;
	//float RTGNeartoTarget = seekerOpenToTarget;
	
	/*std::cout<<"batas kiri : "<<batasAngleKiri<<std::endl;
	std::cout<<"batas kanan : "<<batasAngleKanan<<std::endl;
	std::cout<<"Seeker Open Rot : "<< ValidateDegree(-SeekerOpenRot[0])<<std::endl;
	*/
	/*std::cout<<"Region 0 :  "<<diffRTGNear<<std::endl;
	std::cout<<"Region 1 :  "<<regionDist_1<<std::endl;
	std::cout<<"Region 2 :  "<<regionDist_2<<std::endl;
	std::cout<<"Region 3 :  "<<regionDist_3<<std::endl;
	std::cout<<"Region 4 :  "<<regionDist_4<<std::endl;
	std::cout<<"Near to Target : "<<RTGNeartoTarget<<std::endl;*/

	/*std::cout<<"RTGNEARTOTARGET : "<<RTGNeartoTarget<<std::endl;
	std::cout<<"DIFFRTGNEAR : "<<diffRTGNear<<std::endl;
	std::cout<<"REGIONDIST_1 : "<<regionDist_1<<std::endl;*/
	//&& maxMissDist >= diffRTGNear

	if (maxMissDist <= exxocetMax && (DegComp_IsBeetwen(bearingOpenMisstoTarget, batasAngleKiri, batasAngleKanan) == true))
	{
		if (masking_1 == 0 && (DegComp_IsBeetwen(bearingOpenMisstoTarget, batasAngleKiri, regionBearing_1) == true)
			&& seekerOpenToTarget >= diffRTGNear && RTGNeartoTarget < regionDist_1)
		{
			std::cout<<"Mask 1"<<std::endl;
			return true;
		}
		else if (masking_2 == 0 && (DegComp_IsBeetwen(bearingOpenMisstoTarget, regionBearing_1, regionBearing_2) == true)
			&& seekerOpenToTarget >= diffRTGNear && RTGNeartoTarget < regionDist_1)
		{
			std::cout<<"Mask 2"<<std::endl;
			return true;
		}
		else if (masking_3 == 0 && (DegComp_IsBeetwen(bearingOpenMisstoTarget, regionBearing_2, regionBearing_3) == true)
			&& seekerOpenToTarget >= diffRTGNear && RTGNeartoTarget < regionDist_1)
		{
			std::cout<<"Mask 3"<<std::endl;
			return true;
		}
		else if (masking_4 == 0 && (DegComp_IsBeetwen(bearingOpenMisstoTarget, regionBearing_3, regionBearing_4) == true)
			&& seekerOpenToTarget >= diffRTGNear && RTGNeartoTarget < regionDist_1)
		{
			std::cout<<"Mask 4"<<std::endl;
			return true;
		}
		else if (masking_5 == 0 && (DegComp_IsBeetwen(bearingOpenMisstoTarget, batasAngleKiri, regionBearing_1) == true)
			&& RTGNeartoTarget >= regionDist_1 && RTGNeartoTarget < regionDist_2)
		{
			std::cout<<"Mask 5"<<std::endl;
			return true;
		}
		else if (masking_6 == 0 && (DegComp_IsBeetwen(bearingOpenMisstoTarget, regionBearing_1, regionBearing_2) == true)
			&& RTGNeartoTarget >= regionDist_1 && RTGNeartoTarget < regionDist_2)
		{
			std::cout<<"Mask 6"<<std::endl;
			return true;
		}
		else if (masking_7 == 0 && (DegComp_IsBeetwen(bearingOpenMisstoTarget, regionBearing_2, regionBearing_3) == true)
			&& RTGNeartoTarget >= regionDist_1 && RTGNeartoTarget < regionDist_2)
		{
			std::cout<<"Mask 7"<<std::endl;
			return true;
		}
		else if (masking_8 == 0 && (DegComp_IsBeetwen(bearingOpenMisstoTarget, regionBearing_3, regionBearing_4) == true)
			&& RTGNeartoTarget >= regionDist_1 && RTGNeartoTarget < regionDist_2)
		{
			std::cout<<"Mask 8"<<std::endl;
			return true;
		}
		else if (masking_9 == 0 && (DegComp_IsBeetwen(bearingOpenMisstoTarget, batasAngleKiri, regionBearing_1) == true)
			&& RTGNeartoTarget >= regionDist_2 && RTGNeartoTarget < regionDist_3)
		{
			std::cout<<"Mask 9"<<std::endl;
			return true;
		}
		else if (masking_10 == 0 && (DegComp_IsBeetwen(bearingOpenMisstoTarget, regionBearing_1, regionBearing_2) == true)
			&& RTGNeartoTarget >= regionDist_2 && RTGNeartoTarget < regionDist_3)
		{
			std::cout<<"Mask 10"<<std::endl;
			return true;
		}
		else if (masking_11 == 0 && (DegComp_IsBeetwen(bearingOpenMisstoTarget, regionBearing_2, regionBearing_3) == true)
			&& RTGNeartoTarget >= regionDist_2 && RTGNeartoTarget < regionDist_3)
		{
			std::cout<<"Mask 11"<<std::endl;
			return true;
		}
		else if (masking_12 == 0 && (DegComp_IsBeetwen(bearingOpenMisstoTarget, regionBearing_3, regionBearing_4) == true)
			&& RTGNeartoTarget >= regionDist_2 && RTGNeartoTarget < regionDist_3)
		{
			std::cout<<"Mask 12"<<std::endl;
			return true;			
		}
		else if (masking_13 == 0 && (DegComp_IsBeetwen(bearingOpenMisstoTarget, batasAngleKiri, regionBearing_1) == true)
			&& RTGNeartoTarget >= regionDist_3 && RTGNeartoTarget <= regionDist_4)
		{
			std::cout<<"Mask 13"<<std::endl;
			/*std::cout<<"Bearing : "<<bearingOpenMisstoTarget<<std::endl;
			std::cout<<"kiri : "<<batasAngleKiri<<std::endl;
			std::cout<<"kanan : "<<regionBearing_1<<std::endl;*/
			return true;
		}
		else if (masking_14 == 0 && (DegComp_IsBeetwen(bearingOpenMisstoTarget, regionBearing_1, regionBearing_2) == true)
			&& RTGNeartoTarget >= regionDist_3 && RTGNeartoTarget <= regionDist_4)
		{
			std::cout<<"Mask 14"<<std::endl;
			/*std::cout<<"Bearing : "<<bearingOpenMisstoTarget<<std::endl;
			std::cout<<"kiri : "<<regionBearing_1<<std::endl;
			std::cout<<"kanan : "<<regionBearing_2<<std::endl;*/
			return true;
		}

		else if (masking_15 == 0 && (DegComp_IsBeetwen(bearingOpenMisstoTarget, regionBearing_2, regionBearing_3) == true)
			&& RTGNeartoTarget >= regionDist_3 && RTGNeartoTarget <= regionDist_4)
		{
			std::cout<<"Mask 15"<<std::endl;
			/*std::cout<<"Bearing : "<<bearingOpenMisstoTarget<<std::endl;
			std::cout<<"kiri : "<<regionBearing_2<<std::endl;
			std::cout<<"kanan : "<<regionBearing_3<<std::endl;*/
			return true;
		}

		else if (masking_16 == 0 && (DegComp_IsBeetwen(bearingOpenMisstoTarget, regionBearing_3, regionBearing_4) == true)
			&& RTGNeartoTarget >= regionDist_3 && RTGNeartoTarget <= regionDist_4)
		{
			std::cout<<"Mask 16"<<std::endl;
			/*std::cout<<"Bearing : "<<bearingOpenMisstoTarget<<std::endl;
			std::cout<<"kiri : "<<regionBearing_3<<std::endl;
			std::cout<<"kanan : "<<regionBearing_4<<std::endl;*/
			return true;
		}
		else
		{
			std::cout<<"Masuk Region Tapi False"<<std::endl;
			return false;
		}
	}

	else
	{
		return false;
	}
}	

bool ExocetMM40Actor::IsInCone(osg::Vec3 origin, osg::Vec3 pointToTest, float heading, float pitch, float distanceToTarget, float coneRadius){
	float jarak = GetDistance(origin, pointToTest);

	if(GetDistance(origin, pointToTest)<=distanceToTarget){
		/* Setting Target Location */
		osg::Vec3 target(origin);
		target.x() += (distanceToTarget*sin(-heading*3.14/180))*cos(pitch*3.14/180);
		target.y() += (distanceToTarget*cos(-heading*3.14/180))*cos(pitch*3.14/180);
		target.z() += distanceToTarget*sin(pitch*3.14/180);

		/* Getting Tempdir */
		osg::Vec3 tempDir(pointToTest - origin);
		tempDir.normalize();

		/* Getting coneDir */
		osg::Vec3 coneDir(target-origin);
		coneDir.normalize();

		float result(coneDir * tempDir);
		/* getting alpha */
		float alpha(atan(coneRadius/distanceToTarget));
		float cosResult(cos(alpha));
		return result >= cosResult;
	}
	return false;
}

void ExocetMM40Actor::SearchingTarget(double aDt)
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

	/* Distance Target */
	float mDistance_Old, mDistance_New;

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

					//if( IsInCone(missilePosition, TargetPosition, missileRotation.x(), missileRotation.y(), SeekLength_Height , SeekLength_Width) == true)
					if (isInRBLSeekerRange(missilePosition, TargetPosition, missileRotation) == true)
					{
						if ( mShipTarget == NULL )
						{
							mShipTarget  = SearchShipTarget;
							LockTargetID = tgtID;
							
							std::cout << "Set Current Target To " << mShipTarget->GetName() << std::endl;
						}
						else
						{
							/* Old Distance */
							dynamic_cast<VehicleActor*>(mShipTarget.get())->GetTransform(TempTargetTransform);
							TempTargetTransform.GetTranslation(TempTargetPosition);
							TempTargetTransform.GetRotation(TempTargetRotation);
							
							mDistance_Old = GetDistance(TempTargetPosition,SeekerOpenPos); 
							mDistance_New = GetDistance(TargetPosition,SeekerOpenPos);

							if ( mDistance_New < mDistance_Old)
							{
								mShipTarget	= TargetAct;
								LockTargetID = tgtID;

								std::cout << "Set Current Target To " << mShipTarget->GetName() << std::endl;
							}
						}
					}
				}
			}
		}
	}

	MoveToTarget(aDt);
}

/* ================================================================================ */

/* ================================================================================ */
/* ==================== MOVING EXOCET MM40 ======================================== */
void ExocetMM40Actor::Move(double aDt)
{
	/* First STEP ( High Altitude ) */
	if( mStepMoving == 1 )
	{
		if ( WithInitialAlt == 0 )
		{
			MoveWithoutInitialAlt(aDt);
		}
		else
		if (( WithInitialAlt == 1) || ( WithInitialAlt == 2) || ( WithInitialAlt == 3))
		{
			MoveWithInitialAlt(aDt);
		}
	}
	else
	/* Second STEP ( Cruise Altitude ) */
	if( mStepMoving == 2 )
	{
		MoveCruiseAlt(aDt);
	}
	else
	/* Third STEP ( Searching Target ) */
	if( mStepMoving == 3 )
	{
		MoveSearchingAlt(aDt);
	}
}
/* ================================================================================ */

/* ================================================================================ */
/* ================= STEP 1 ========= INITIAL ALTITUDE ============================ */
/* ================= WITH INITIAL ALTITUDE ======================================== */
void ExocetMM40Actor::MoveWithInitialAlt(double aDt)
{
	static dtCore::Transform missileTransform;
	static osg::Vec3 missilePosition, missileRotation, missileHAFOPos;
	static osg::Vec3 dir;
	static float turnElevation, turnElevation2;

	trac.Calc_Speed(aDt);
	trac.Calc_Direction(aDt);
	trac.Calc_Elevation(aDt);
	dir = trac.Calc_Movement(aDt);

	GetTransform(missileTransform);
	missileTransform.GetTranslation(missilePosition);
	missileTransform.GetRotation(missileRotation);

	/* First STEP MISSILE ( Climb To Initial Altitude ) */
	/* First STEP HAFO */
	float mHAFO_Range;
	if ( mStepHAFO == 1 )
	{
		trac.SetElevation(trac.GetElevation() + 2.0f);
		if ( trac.GetElevation() >= FDegreeToHAFO )
		{
			trac.SetElevTurnRate(0);
			trac.SetElevation(FDegreeToHAFO);
			
			mStepHAFO = 2;

			std::cout << "Set To Second STEP HAFO" << std::endl;
			std::cout << "Climbing Until HAFO Altitude" <<std::endl;
		}	
	}
	/* Second STEP HAFO */
	if ( mStepHAFO == 2 )
	{
		if ( missilePosition.z() > FHAFO_Altitude )
		{
			trac.SetElevation(trac.GetElevation() - 1);
			if ( trac.GetElevation() <= 0.0f )
			{
				trac.SetElevation(0);

				mStepHAFO = 3;

				missileHAFOPos = missilePosition;

				std::cout << "Set To Third STEP HAFO" << std::endl;
				std::cout << "Move Until HAFO Range" <<std::endl;
			}
		}
	}
	/* Third STEP HAFO */
	if ( mStepHAFO == 3 )
	{
		mHAFO_Range = GetDistance(missilePosition,missileHAFOPos);
		if ( mHAFO_Range > FHAFO_Range)
		{
			trac.SetElevation(trac.GetElevation() - 2.0f);
			if ( trac.GetElevation() <= -FDegreeToHAFO )
			{
				mStepHAFO = 4;

				trac.SetElevTurnRate(0);
				trac.SetElevation(-FDegreeToHAFO);

				std::cout << "Set To Fourth STEP HAFO" << std::endl;
				std::cout << "Diving To Cruise Altitude" <<std::endl;
			}
		}
	}
	/* Fourth STEP HAFO */
	if ( mStepHAFO == 4 )
	{
		if ( missilePosition.z() < FCruise_Altitude + 15) /* 10 for Calibration */
		{
			trac.SetElevation(trac.GetElevation() + 20);
			if ( trac.GetElevation() >= 0.0f )
			{
				trac.SetElevation(0);

				mStepMoving = 2;

				trac.SetSpeed(MAX_Speed/DEF_MACH_TO_METRE);

				std::cout << "Set To Second STEP Missile" << std::endl;
				std::cout << "Cruise Altitude, Ready To Search Target" << std::endl;

				
			}
		}
	}

	/* Check MAX Range */
	float mMAX_Range;
	mMAX_Range = GetDistance(missilePosition,missileFirstPos); 
	if ( mMAX_Range > MaxRange)
	{
		/* Destroy Exocet MM40 */
		FisBlast = true;
	}
	
	/* Update */
	missilePosition.x() += dir.x();
	missilePosition.y() += dir.y();
	missilePosition.z() += dir.z();

	missileRotation[0] = -trac.GetDirection();
	missileRotation[1] = trac.GetElevation();
	missileRotation[2] = 0.0f;

	SetCurrentSpeed(trac.GetSpeed() * DEF_MACH_TO_METRE);
	SetCurrentHeading(trac.GetDirection());

	missileTransform.SetTranslation(missilePosition);
	missileTransform.SetRotation(missileRotation);
	
	SetTransform(missileTransform);
}
/* ================================================================================ */

/* ================================================================================ */
/* ================= STEP 1 ========= INITIAL ALTITUDE ============================ */
/* ================= WITHOUT INITIAL ALTITUDE ===================================== */
void ExocetMM40Actor::MoveWithoutInitialAlt(double aDt)
{
	static dtCore::Transform missileTransform;
	static osg::Vec3 missilePosition, missileRotation, missileHAFOPos;
	static osg::Vec3 dir;
	static float turnElevation, turnElevation2;

	trac.Calc_Speed(aDt);
	trac.Calc_Direction(aDt);
	trac.Calc_Elevation(aDt);
	dir = trac.Calc_Movement(aDt);

	GetTransform(missileTransform);
	missileTransform.GetTranslation(missilePosition);
	missileTransform.GetRotation(missileRotation);

	/* MOVE MISSILE MM40 */
	/* First STEP MISSILE ( Climb & Dive To Cruise ) */
	/* First STEP HAFO */
	if ( mStepHAFO == 1 )
	{
		trac.SetElevation(trac.GetElevation()- 5.0f);
		if ( trac.GetElevation() <= 0 )
		{
			trac.SetElevTurnRate(0);
			trac.SetElevation(0);
			
			mStepHAFO = 2;

			std::cout << "Set To Second STEP HAFO" << std::endl;
			std::cout << "Set To Dive to Cruise Altitude" <<std::endl;
		}
	}
	else
	/* Second STEP HAFO */
	if ( mStepHAFO == 2 )
	{
		missilePosition.z() = missilePosition.z() - TurnAltitude;
		if ( missilePosition.z() < FCruise_Altitude )
		{
			mStepMoving = 2;

			trac.SetSpeed(MAX_Speed/DEF_MACH_TO_METRE);

			std::cout << "Set To Second STEP Missile" << std::endl;
			std::cout << "Cruise Altitude, Ready To Search Target" << std::endl;
		}
	}
	
	/* Check MAX Range */
	float mMAX_Range;
	mMAX_Range = GetDistance(missilePosition,missileFirstPos); 
	if ( mMAX_Range > MaxRange)
	{
		/* Destroy Exocet MM40 */
		FisBlast = true;
	}
	
	/* Update */
	missilePosition.x() += dir.x();
	missilePosition.y() += dir.y();
	missilePosition.z() += dir.z();

	missileRotation[0] = -trac.GetDirection();
	missileRotation[1] = trac.GetElevation();
	missileRotation[2] = 0.0f;

	SetCurrentSpeed(trac.GetSpeed() * DEF_MACH_TO_METRE);
	SetCurrentHeading(trac.GetDirection());

	missileTransform.SetTranslation(missilePosition);
	missileTransform.SetRotation(missileRotation);
	
	SetTransform(missileTransform);
}
/* ================================================================================ */

/* ================================================================================ */
/* ================= STEP 2 ========= CRUISE ALTITUDE ============================= */
void ExocetMM40Actor::MoveCruiseAlt(double aDt)
{
	static dtCore::Transform missileTransform;	
	static osg::Vec3 missilePosition, missileRotation, missileCruisePos;
	static osg::Vec3 dir;

	static float turnElevation, turnElevation2;

	trac.Calc_Speed(aDt);
	trac.Calc_Direction(aDt);
	trac.Calc_Elevation(aDt);
	dir = trac.Calc_Movement(aDt);

	GetTransform(missileTransform);
	missileTransform.GetTranslation(missilePosition);
	missileTransform.GetRotation(missileRotation);

	double StartAngle;
	double EndEangle;
	double BearingToTarget;

	StartAngle = -missileRotation.x() - 2;
	StartAngle = ValidateDegree(StartAngle);
	EndEangle  = -missileRotation.x() + 2;
	EndEangle  = ValidateDegree(EndEangle);

	TargetPosition = RangeBearingToCoord(missileFirstPos, TargetRange, TargetBearing);
	NewTargetBearing = ComputeBearingTo2(missilePosition.x(), missilePosition.y(), TargetPosition.x(), TargetPosition.y());
	NewTargetBearing = ValidateDegree(NewTargetBearing);
	
	//std::cout<<"modetarget : "<<mModeToTarget<<std::endl;
	/* Moving */
	if ( mModeToTarget == 1 )
	{
		if ( mStepCruise == 1 )
		{
			if (mFirstTurn == 1)
				trac.SetDirection(trac.GetDirection() + (TurnDirection*aDt));
			else
				trac.SetDirection(trac.GetDirection() - (TurnDirection*aDt)); 

			if (DegComp_IsBeetwen(NewTargetBearing, StartAngle, EndEangle) == true)
			{
				mStepCruise = 2;
				isStraight = true;

				trac.SetDirection(NewTargetBearing);

				std::cout << "Set To Second STEP Cruise" << std::endl;
				std::cout << "Ready To Search Target" << std::endl;
			}
		}
		else
		if ( mStepCruise == 2 )
		{
			float mSeekerRange;
			mSeekerRange = GetDistance(missilePosition,missileFirstPos);

			//std::cout<<"target range : "<<TargetRange<<" mSeekerRange : "<<mSeekerRange<<" FSeekerRange : "<<FSeekerRange<<std::endl;


			if ((TargetRange - mSeekerRange) <= FSeekerRange)
			{

				if (seekerOpenPosX == 0)
				{
					SeekerOpenPos = missilePosition;
					SeekerOpenRot = missileRotation;
				}
				else 
				{
					//set possisi missile ketika open seeker
					SeekerOpenPos[2] = missilePosition[2];
					SeekerOpenRot[1] = missileRotation[1];
					SeekerOpenRot[2] = missileRotation[2];
				}
				

				/*SeekerOpenPosTesting = missilePosition;
				SeekerOpenRotTesting = missileRotation;
				
				std::cout<<"X TESTING : "<<SeekerOpenPosTesting[0]<<std::endl;
				std::cout<<"Y TESTING : "<<SeekerOpenPosTesting[1]<<std::endl;
				std::cout<<"HEADING TESTING : "<<-SeekerOpenRotTesting[0]<<std::endl;*/
				//SeekerOpenRot = missileRotation;

				mStepMoving = 3;
				
				std::cout << "Set To Third STEP Missile" << std::endl;
				std::cout << "Search Target" << std::endl;
			}
		}
	}
	else
	if ( mModeToTarget == 2)
	{
		if ( mStepCruise == 1 )
		{
			if (mFirstTurn == 1)
				trac.SetDirection(trac.GetDirection() + (TurnDirection*aDt));
			else
				trac.SetDirection(trac.GetDirection() - (TurnDirection*aDt));

			if (DegComp_IsBeetwen(TargetBearing, StartAngle, EndEangle) == true)
			{
				std::cout << "Set To Second STEP Cruise" << std::endl;
				mStepCruise = 2;
			}
		}
		else
		if ( mStepCruise == 2 )
		{
			if (mFirstTurn == 1)
				trac.SetDirection(trac.GetDirection() + (TurnDirection*aDt));
			else
				trac.SetDirection(trac.GetDirection() - (TurnDirection*aDt));

			TargetPosition = RangeBearingToCoord(missileFirstPos, MaxRange, TargetBearing);
			BearingToTarget =  ComputeBearingTo2(missilePosition.x(), missilePosition.y(), TargetPosition.x(), TargetPosition.y());
			BearingToTarget = ValidateDegree(BearingToTarget); 

			if (abs(BearingToTarget-TargetBearing) <= 1.5)
			{
				std::cout << "Set To Third STEP Cruise" << std::endl;
				mStepCruise = 3;
			}
		}
		else
		if ( mStepCruise == 3)
		{
			if (mFirstTurn == 1)
				trac.SetDirection(trac.GetDirection() - (TurnDirectionBOL*aDt));
			else
			if (mFirstTurn == 2)
				trac.SetDirection(trac.GetDirection() + (TurnDirectionBOL*aDt));

			if (DegComp_IsBeetwen(TargetBearing, StartAngle, EndEangle) == true)
			{
				trac.SetDirection(TargetBearing);
				mStepCruise = 4;

				std::cout << "Set To Fourth STEP Cruise" << std::endl;
				std::cout << "Ready To Search Target" << std::endl;
			}
		}
		else
		if ( mStepCruise == 4 )
		{
			// - komen dulu [3/19/2014 EKA]
			/*float mSeekerRange;
			mSeekerRange = GetDistance(missilePosition,missileFirstPos);
			
			if ( mSeekerRange >= FSeekerRange )
			{
				mStepMoving = 3;

				std::cout << "Set To Third STEP Missile" << std::endl;
				std::cout << "Search Target" << std::endl;
			}*/

			if ( FisFindTarget == false)
			{
				// - Seeker BOL [3/19/2014 EKA]

				/*static float leftAngleSeeker = 10.0f;
				static float rightAngleSeeker = 40.0f;
				static float farDistance = 1852.0f;*/

				//search currentRange
				static float mCurrentMissileRange, mSeekerRange;
				mCurrentMissileRange = GetDistance(missilePosition,missileFirstPos);
				mSeekerRange = mCurrentMissileRange;

				//checking

				if (mSeekerRange > (5.2 * c_NauticalMiles_To_Meter))
				{
					dtCore::RefPtr<dtDAL::ActorProxy> parentProxy = GetShipActorByID(GetVehicleID());
					static dtCore::Transform objectTransform;
					static osg::Vec3 objectPosition;
					static osg::Vec3 objectRotation;

					if ( parentProxy.valid() )
					{
						dtCore::RefPtr<VehicleActor> parent = static_cast<VehicleActor*>(parentProxy->GetActor());
						mMyParent = parent;

						dtGame::GameActorProxy &pr = parent->GetGameActorProxy();

						parent->GetTransform(objectTransform);
						objectTransform.GetTranslation(objectPosition);
						objectTransform.GetRotation(objectRotation);
					}
					//seeker on

					static dtCore::Transform TargetTransform;
					static osg::Vec3 TargetPosition, TargetRotation;

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

									float missileBearing = ComputeBearingTo2(objectPosition.x(), objectPosition.y(), missilePosition.x(), missilePosition.y());
									missileBearing = ValidateDegree(missileBearing);

									osg::Vec3 LPoint, RPoint;
									/*LPoint = RangeBearingToCoord(missilePosition, farDistance+0.1, 90-leftAngleSeeker);
									RPoint = RangeBearingToCoord(missilePosition, farDistance+0.1, 90+rightAngleSeeker);*/
									LPoint = RangeBearingToCoord(missilePosition, farDistance+0.1, missileBearing-leftAngleSeeker);
									RPoint = RangeBearingToCoord(missilePosition, farDistance+0.1, missileBearing+rightAngleSeeker);

									//search variable newLeftAngleSeeker & newRightAngleSeeker
									float newLeftAngleSeeker = ComputeBearingTo2(objectPosition.x(), objectPosition.y(), LPoint.x(), LPoint.y());
									newLeftAngleSeeker = ValidateDegree(newLeftAngleSeeker);
									float newRightAngleSeeker = ComputeBearingTo2(objectPosition.x(), objectPosition.y(), RPoint.x(), RPoint.y());
									newRightAngleSeeker = ValidateDegree(newRightAngleSeeker);

									/*if (newLeftAngleSeeker > newRightAngleSeeker)
										newLeftAngleSeeker = newLeftAngleSeeker - 360;*/

									float TargetRange = GetDistance(objectPosition,TargetPosition);
									float TargetBearing = ComputeBearingTo2(objectPosition.x(), objectPosition.y(), TargetPosition.x(), TargetPosition.y());
									TargetBearing = ValidateDegree(TargetBearing);

									if ( 
										( newLeftAngleSeeker < newRightAngleSeeker )
										&&
										( DegComp_IsBeetwen(TargetBearing, newLeftAngleSeeker, newRightAngleSeeker) == true )
										&& 
										( ( 0.1*c_NauticalMiles_To_Meter+mCurrentMissileRange < TargetRange) && (mCurrentMissileRange+farDistance > TargetRange) ) 
										)
									{
										/*std::cout << SearchShipTarget->GetName() << " FOUNDED. TR " << TargetRange << " ,MR " << mCurrentMissileRange << " ,TB " << TargetBearing << " ,NLA " << newLeftAngleSeeker << 
											" ,NRA " << newRightAngleSeeker << std::endl;*/
										mShipTarget  = SearchShipTarget;

										std::cout << SearchShipTarget->GetName() << " FOUNDED. " << std::endl;
										FisFindTarget = true;
									}
									if ( 
										( newLeftAngleSeeker > newRightAngleSeeker )
										&&
										( (TargetBearing > newLeftAngleSeeker) || (TargetBearing < newRightAngleSeeker) )
										&& 
										( ( 0.1*c_NauticalMiles_To_Meter+mCurrentMissileRange < TargetRange) && (mCurrentMissileRange+farDistance > TargetRange) ) 
										)
									{
										/*std::cout << SearchShipTarget->GetName() << " FOUNDED. TR " << TargetRange << " ,MR " << mCurrentMissileRange << " ,TB " << TargetBearing << " ,NLA " << newLeftAngleSeeker << 
											" ,NRA " << newRightAngleSeeker << std::endl;*/
										mShipTarget  = SearchShipTarget;

										std::cout << SearchShipTarget->GetName() << " FOUNDED. " << std::endl;
										FisFindTarget = true;
									}

								}
							}
						}
					}
				}
			}
			else
			{
				MoveToTarget(aDt);
				MoveCheckMissingTarget(aDt);
			}
		}
	}

	/* Check MAX Range */
	float mMAX_Range;
	mMAX_Range = GetDistance(missilePosition,missileFirstPos); 
	if ( mMAX_Range > MaxRange)
	{
		/* Destroy Exocet MM40 */
		FisBlast = true;
	}
	
	/* Update */
	missilePosition.x() += dir.x();
	missilePosition.y() += dir.y();
	missilePosition.z() += dir.z();

	missileRotation[0] = -trac.GetDirection();
	missileRotation[1] = trac.GetElevation();
	missileRotation[2] = 0.0f;

	SetCurrentSpeed(trac.GetSpeed() * DEF_MACH_TO_METRE);
	SetCurrentHeading(trac.GetDirection());

	missileTransform.SetTranslation(missilePosition);
	missileTransform.SetRotation(missileRotation);
	
	SetTransform(missileTransform);
}
/* ================================================================================ */

/* ================================================================================ */
void ExocetMM40Actor::MoveCheckMissingTarget(double aDt)
{
	/* Missile Object */
	static dtCore::Transform missileTransform;
	static osg::Vec3 missilePosition, missileRotation;

	/* Target Object */
	static dtCore::Transform TargetTransform;
	static osg::Vec3 TargetPosition, TargetRotation;

	if ( mShipTarget != NULL)
	{
		dynamic_cast<VehicleActor*>(mShipTarget.get())->GetTransform(TargetTransform);
		TargetTransform.GetTranslation(TargetPosition);
		TargetTransform.GetRotation(TargetRotation);

		GetTransform(missileTransform);
		missileTransform.GetTranslation(missilePosition);
		missileTransform.GetRotation(missileRotation);

		/* If Not Inside RBL SEEKER range, Missile Will Searching New Target */ 
		if(isInRBLSeekerRange(missilePosition, TargetPosition, missileRotation) == false)
		{
			std::cout << "Target MISS, Searching New Target" << std::endl;
			
			/* Set parameter to searching again */
			mStepSearching  = 1;
			FisFindTarget	= false;
			mShipTarget		= NULL;
		}
	}
}



/* ================================================================================ */
void ExocetMM40Actor::MoveLeftTargetMode_1(double aDt)
{
	/* Missile Object */
	static dtCore::Transform missileTransform;
	static osg::Vec3 missilePosition, missileRotation;
	static osg::Vec3 tempMissilePosition, tempMissileRotation;

	/* Target Object */
	static dtCore::Transform TargetTransform;
	static osg::Vec3 TargetPosition, TargetRotation;

	float mTarget_Bearing;
	dynamic_cast<VehicleActor*>(mShipTarget.get())->GetTransform(TargetTransform);
	TargetTransform.GetTranslation(TargetPosition);
	TargetTransform.GetRotation(TargetRotation);

	GetTransform(missileTransform);
	missileTransform.GetTranslation(missilePosition);
	missileTransform.GetRotation(missileRotation);

	float halfdist = FSeekerRange/2;
	float distFirstTurnLimit = sqrt((halfdist * halfdist) + (halfdist * halfdist));

	if (flag == 0)
	{
		tempMissilePosition = missilePosition;
		tempMissileRotation = missileRotation;
		flag =  1;
	}

	float distMissile = CalculateVec3Distance(tempMissilePosition, missilePosition);
	float distMisstoTarget = CalculateVec3Distance(TargetPosition, missilePosition);

	std::cout<<"distMissile : "<<distMissile<<std::endl;

	if (distMissile <= 1000)
	{
		trac.SetDirection(trac.GetDirection() - (1.0f * aDt));
	}
	//else if (distMissile > 1000 && distMisstoTarget > 300)
	//{
	//	trac.SetDirection(trac.GetDirection() + (2.0f * aDt));
	//	//std::cout<<"dist : "<<distMisstoTarget<<std::endl;
	//}
	else
	{
		mTarget_Bearing = ComputeBearingTo2(missilePosition.x(),missilePosition.y(),TargetPosition.x(),TargetPosition.y());
		mTarget_Bearing = ValidateDegree(mTarget_Bearing);

		double startAngle, endAngle;

		startAngle = -missileRotation.x() + 0;
		startAngle = ValidateDegree(startAngle);
		endAngle   = -missileRotation.x() + 180;
		endAngle   = ValidateDegree(endAngle);

		if ( DegComp_IsBeetwen(mTarget_Bearing, startAngle, endAngle) == true)
		{
			trac.SetDirection(trac.GetDirection() + (TurnAngularDirection * aDt));
		}
		else
		{
			trac.SetDirection(trac.GetDirection() - (TurnAngularDirection * aDt));
		}

		startAngle = -missileRotation.x() - 2;
		startAngle = ValidateDegree(startAngle);
		endAngle   = -missileRotation.x() + 2;
		endAngle   = ValidateDegree(endAngle);

		if ( DegComp_IsBeetwen(mTarget_Bearing, startAngle, endAngle) == true)
		{
			FisFindTarget = true;
			trac.SetDirection(mTarget_Bearing);
		}
	}
}

void ExocetMM40Actor::MoveRightTargetMode_1(double aDt)
{
	/* Missile Object */
	static dtCore::Transform missileTransform;
	static osg::Vec3 missilePosition, missileRotation;
	static osg::Vec3 tempMissilePosition, tempMissileRotation;

	/* Target Object */
	static dtCore::Transform TargetTransform;
	static osg::Vec3 TargetPosition, TargetRotation;

	float mTarget_Bearing;
	dynamic_cast<VehicleActor*>(mShipTarget.get())->GetTransform(TargetTransform);
	TargetTransform.GetTranslation(TargetPosition);
	TargetTransform.GetRotation(TargetRotation);

	GetTransform(missileTransform);
	missileTransform.GetTranslation(missilePosition);
	missileTransform.GetRotation(missileRotation);

	float halfdist = FSeekerRange/2;
	float distFirstTurnLimit = sqrt((halfdist * halfdist) + (halfdist * halfdist));

	if (flag == 0)
	{
		tempMissilePosition = missilePosition;
		tempMissileRotation = missileRotation;
		flag =  1;
	}

	float distMissile = CalculateVec3Distance(tempMissilePosition, missilePosition);
	float distMisstoTarget = CalculateVec3Distance(TargetPosition, missilePosition);

	std::cout<<"distMissile : "<<distMissile<<std::endl;

	if (distMissile <= 1000)
	{
		trac.SetDirection(trac.GetDirection() + (1.0f * aDt));
	}
	//else if (distMissile > 1000 && distMisstoTarget > 300)
	//{
	//	trac.SetDirection(trac.GetDirection() - (2.0f * aDt));
	//	//std::cout<<"dist : "<<distMisstoTarget<<std::endl;
	//}
	else
	{
		mTarget_Bearing = ComputeBearingTo2(missilePosition.x(),missilePosition.y(),TargetPosition.x(),TargetPosition.y());
		mTarget_Bearing = ValidateDegree(mTarget_Bearing);

		double startAngle, endAngle;

		startAngle = -missileRotation.x() + 0;
		startAngle = ValidateDegree(startAngle);
		endAngle   = -missileRotation.x() + 180;
		endAngle   = ValidateDegree(endAngle);

		if ( DegComp_IsBeetwen(mTarget_Bearing, startAngle, endAngle) == true)
		{
			trac.SetDirection(trac.GetDirection() + (TurnAngularDirection * aDt));
		}
		else
		{
			trac.SetDirection(trac.GetDirection() - (TurnAngularDirection * aDt));
		}

		startAngle = -missileRotation.x() - 2;
		startAngle = ValidateDegree(startAngle);
		endAngle   = -missileRotation.x() + 2;
		endAngle   = ValidateDegree(endAngle);

		if ( DegComp_IsBeetwen(mTarget_Bearing, startAngle, endAngle) == true)
		{
			FisFindTarget = true;
			trac.SetDirection(mTarget_Bearing);
		}
	}
}

void ExocetMM40Actor::MoveLeftTargetMode_2(double aDt)
{
	/* Missile Object */
	static dtCore::Transform missileTransform;
	static osg::Vec3 missilePosition, missileRotation;
	static osg::Vec3 tempMissilePosition, tempMissileRotation;

	/* Target Object */
	static dtCore::Transform TargetTransform;
	static osg::Vec3 TargetPosition, TargetRotation;
		
	float mTarget_Bearing;
	dynamic_cast<VehicleActor*>(mShipTarget.get())->GetTransform(TargetTransform);
	TargetTransform.GetTranslation(TargetPosition);
	TargetTransform.GetRotation(TargetRotation);

	GetTransform(missileTransform);
	missileTransform.GetTranslation(missilePosition);
	missileTransform.GetRotation(missileRotation);

	float halfdist = FSeekerRange/2;
	float distFirstTurnLimit = sqrt((halfdist * halfdist) + (halfdist * halfdist));

	if (flag == 0)
	{
		tempMissilePosition = missilePosition;
		tempMissileRotation = missileRotation;
		flag =  1;
	}

	float distMissile = CalculateVec3Distance(tempMissilePosition, missilePosition);
	float distMisstoTarget = CalculateVec3Distance(TargetPosition, missilePosition);

	if (distMissile <= 3000)
	{
		trac.SetDirection(trac.GetDirection() - (1.2f * aDt));
	}
	//else if (distMissile > 3000 && distMisstoTarget > 1000)
	//{
	//	trac.SetDirection(trac.GetDirection() + (4.0f * aDt));
	//	//std::cout<<"dist : "<<distMisstoTarget<<std::endl;
	//}
	else
	{
		mTarget_Bearing = ComputeBearingTo2(missilePosition.x(),missilePosition.y(),TargetPosition.x(),TargetPosition.y());
		mTarget_Bearing = ValidateDegree(mTarget_Bearing);

		double startAngle, endAngle;

		startAngle = -missileRotation.x() + 0;
		startAngle = ValidateDegree(startAngle);
		endAngle   = -missileRotation.x() + 180;
		endAngle   = ValidateDegree(endAngle);

		if ( DegComp_IsBeetwen(mTarget_Bearing, startAngle, endAngle) == true)
		{
			trac.SetDirection(trac.GetDirection() + (TurnAngularDirection * aDt));
		}
		else
		{
			trac.SetDirection(trac.GetDirection() - (TurnAngularDirection * aDt));
		}

		startAngle = -missileRotation.x() - 2;
		startAngle = ValidateDegree(startAngle);
		endAngle   = -missileRotation.x() + 2;
		endAngle   = ValidateDegree(endAngle);

		if ( DegComp_IsBeetwen(mTarget_Bearing, startAngle, endAngle) == true)
		{
			FisFindTarget = true;
			trac.SetDirection(mTarget_Bearing);
		}
	}	
}

void ExocetMM40Actor::MoveRightTargetMode_2(double aDt)
{
	/* Missile Object */
	static dtCore::Transform missileTransform;
	static osg::Vec3 missilePosition, missileRotation;
	static osg::Vec3 tempMissilePosition, tempMissileRotation;

	/* Target Object */
	static dtCore::Transform TargetTransform;
	static osg::Vec3 TargetPosition, TargetRotation;

	float mTarget_Bearing;
	dynamic_cast<VehicleActor*>(mShipTarget.get())->GetTransform(TargetTransform);
	TargetTransform.GetTranslation(TargetPosition);
	TargetTransform.GetRotation(TargetRotation);

	GetTransform(missileTransform);
	missileTransform.GetTranslation(missilePosition);
	missileTransform.GetRotation(missileRotation);

	float halfdist = FSeekerRange/2;
	float distFirstTurnLimit = sqrt((halfdist * halfdist) + (halfdist * halfdist));

	if (flag == 0)
	{
		tempMissilePosition = missilePosition;
		tempMissileRotation = missileRotation;
		flag =  1;
	}

	float distMissile = CalculateVec3Distance(tempMissilePosition, missilePosition);
	float distMisstoTarget = CalculateVec3Distance(TargetPosition, missilePosition);

	if (distMissile <= 3000)
	{
		trac.SetDirection(trac.GetDirection() + (1.2f * aDt));
	}
	//else if (distMissile > 3000 && distMisstoTarget > 1000)
	//{
	//	trac.SetDirection(trac.GetDirection() - (4.0f * aDt));
	//	//std::cout<<"dist : "<<distMisstoTarget<<std::endl;
	//}
	else
	{
		mTarget_Bearing = ComputeBearingTo2(missilePosition.x(),missilePosition.y(),TargetPosition.x(),TargetPosition.y());
		mTarget_Bearing = ValidateDegree(mTarget_Bearing);

		double startAngle, endAngle;

		startAngle = -missileRotation.x() + 0;
		startAngle = ValidateDegree(startAngle);
		endAngle   = -missileRotation.x() + 180;
		endAngle   = ValidateDegree(endAngle);

		if ( DegComp_IsBeetwen(mTarget_Bearing, startAngle, endAngle) == true)
		{
			trac.SetDirection(trac.GetDirection() + (TurnAngularDirection * aDt));
		}
		else
		{
			trac.SetDirection(trac.GetDirection() - (TurnAngularDirection * aDt));
		}

		startAngle = -missileRotation.x() - 2;
		startAngle = ValidateDegree(startAngle);
		endAngle   = -missileRotation.x() + 2;
		endAngle   = ValidateDegree(endAngle);

		if ( DegComp_IsBeetwen(mTarget_Bearing, startAngle, endAngle) == true)
		{
			FisFindTarget = true;
			trac.SetDirection(mTarget_Bearing);
		}
	}	
}

void ExocetMM40Actor::MoveToTarget(double aDt)
{
	/* Missile Object */
	static dtCore::Transform missileTransform;
	static osg::Vec3 missilePosition, missileRotation;

	/* Target Object */
	static dtCore::Transform TargetTransform;
	static osg::Vec3 TargetPosition, TargetRotation;

	

	if ( mShipTarget != NULL)
	{
		float mTarget_Bearing;
		dynamic_cast<VehicleActor*>(mShipTarget.get())->GetTransform(TargetTransform);
		TargetTransform.GetTranslation(TargetPosition);
		TargetTransform.GetRotation(TargetRotation);

		GetTransform(missileTransform);
		missileTransform.GetTranslation(missilePosition);
		missileTransform.GetRotation(missileRotation);

		mTarget_Bearing = ComputeBearingTo2(missilePosition.x(),missilePosition.y(),TargetPosition.x(),TargetPosition.y());
		mTarget_Bearing = ValidateDegree(mTarget_Bearing);

		double StartAngle;
		double EndAngle;

		StartAngle = -missileRotation.x() + 0;
		StartAngle = ValidateDegree(StartAngle);
		EndAngle   = -missileRotation.x() + 180;
		EndAngle   = ValidateDegree(EndAngle);

		if ( DegComp_IsBeetwen(mTarget_Bearing, StartAngle, EndAngle) == true)
		{
			trac.SetDirection(trac.GetDirection() + (TurnDirectionToTarget*aDt));
		}
		else
		{
			trac.SetDirection(trac.GetDirection() - (TurnDirectionToTarget*aDt));
		}
		
		StartAngle = -missileRotation.x() - 2;
		StartAngle = ValidateDegree(StartAngle);
		EndAngle   = -missileRotation.x() + 2;
		EndAngle   = ValidateDegree(EndAngle);

		if ( DegComp_IsBeetwen(mTarget_Bearing, StartAngle, EndAngle) == true)
		{
			FisFindTarget = true;
			trac.SetDirection(mTarget_Bearing);
		}
	}
}

//================= STEP 3 ========= SEARCH ALTITUDE =============================
void ExocetMM40Actor::MoveSearchingAlt(double aDt)
{
	static dtCore::Transform missileTransform;
	static osg::Vec3 missilePosition, missileRotation;
	static osg::Vec3 dir;
	static float turnElevation, turnElevation2;

	trac.Calc_Speed(aDt);
	trac.Calc_Direction(aDt);
	trac.Calc_Elevation(aDt);
	dir = trac.Calc_Movement(aDt);

	GetTransform(missileTransform);
	missileTransform.GetTranslation(missilePosition);
	missileTransform.GetRotation(missileRotation);

	//Moving
	//First STEP Searching
	if ( mStepSearching == 1 )
	{
		missilePosition.z() = missilePosition.z() - TurnAltitude;
		if ( missilePosition.z() < FSearchAltitude )
		{
			mStepSearching = 2;
			
			//posisi awal Open Seeker di set untuk searching kapal jarak terpendek dari open seeker
			FirstSearchingPosition = SeekerOpenPos;

			std::cout << "Set To Second STEP Searching" << std::endl;
			std::cout << "Searching Target" << std::endl;
		
		}
	}
	//Second STEP Searching
	if ( mStepSearching == 2)
	{	
		if ( FisFindTarget == false)
		{
			SearchingTarget(aDt);
		}
		else
		if ( FisFindTarget == true)
		{
			//std::cout<<"modetarget : "<<mModeToTarget<<std::endl;
			//mModeTarget dihilangkan dlu
			if (mAngularTurn == 1 && mModeToTarget == 2)
			{
				MoveLeftTargetMode_2(aDt);
				//MoveCheckMissingTarget(aDt);
			}
			else if (mAngularTurn == 2 && mModeToTarget == 2)
			{
				//std::cout<<"right"<<std::endl;
				MoveRightTargetMode_2(aDt);
				//MoveCheckMissingTarget(aDt);
			}
			else if (mAngularTurn == 1 && mModeToTarget == 1)
			{
				MoveLeftTargetMode_1(aDt);
			}
			else if (mAngularTurn == 2 && mModeToTarget == 1)
			{
				MoveRightTargetMode_1(aDt);
			}
			else if (mAngularTurn == 0)
			{
				MoveToTarget(aDt);
				MoveCheckMissingTarget(aDt);
				//MoveCheckMissingTarget(aDt);
			}
			/*MoveToTarget(aDt);*/
			MoveCheckMissingTarget(aDt);
		}

		//Batas Range Exxocet (Menunggu Perhitungan dari mas nando)
		float mMAX_Range;
		mMAX_Range = GetDistance(missilePosition,SeekerOpenPos);
		//std::cout<<"Exxocet Max : "<<exxocetMax<<std::endl;
		//std::cout<<"jarak Seeker ke missile : "<<mMAX_Range<<std::endl;
		if ( mMAX_Range > exxocetMax)
		{
			//Destroy Exocet MM40
			FisBlast = true;
		}
	}
	
	//Update
	missilePosition.x() += dir.x();
	missilePosition.y() += dir.y();
	missilePosition.z() += dir.z();
	missileRotation[0] = -trac.GetDirection();
	missileRotation[1] = trac.GetElevation();
	missileRotation[2] = 0.0f;

	SetCurrentSpeed(trac.GetSpeed() * DEF_MACH_TO_METRE);
	SetCurrentHeading(trac.GetDirection());

	missileTransform.SetTranslation(missilePosition);
	missileTransform.SetRotation(missileRotation);
	
	SetTransform(missileTransform);
}

void ExocetMM40Actor::ExocetBlast(osg::Vec3 TargetPos)
{
	/*std::cout << "Hit Target" << std::endl;

	dtCore::RefPtr<VehicleActor> target = static_cast<VehicleActor*>(p->GetActor());
	dtGame::GameActorProxy &tr = target->GetGameActorProxy();

	osg::Vec3 TargetPos;
	TargetPos = tr.GetTranslation();*/
	UpdateStatusDBEffectTo3DExplode(TargetPos.x(), TargetPos.y(), TargetPos.z() ,ST_MISSILE_EXPLODE);

	//std::cout << TargetPos << std::endl;
}

void ExocetMM40Actor::DestroyExocetMM40()
{	
	isLaunch = false;
	UpdateStatusDBEffectTo2D(mMyParent.get(), ST_MISSILE_DEL);
}


//=================================================================================
//=================Proxi
void ExocetMM40ActorProxy::CreateActor()
{
	SetActor(*new ExocetMM40Actor(*this));
}

ExocetMM40ActorProxy::ExocetMM40ActorProxy()
{
   
}

void ExocetMM40ActorProxy::OnEnteredWorld()
{
	MissilesActorProxy::OnEnteredWorld();
	RegisterForMessages(SimMessageType::EXOCETMM_40_EVENT);
}

void ExocetMM40ActorProxy::OnRemovedFromWorld()
{
	ExocetMM40Actor &exo = static_cast<ExocetMM40Actor&>(GetGameActor());

	if (dtAudio::AudioManager::GetInstance().IsInitialized() && exo.missileSound != NULL)
	{
		dtAudio::AudioManager::GetInstance().FreeSound(exo.missileSound);
	}
}

void ExocetMM40ActorProxy::BuildPropertyMap()
{
	MissilesActorProxy::BuildPropertyMap();

	ExocetMM40Actor* actor = NULL;
	GetActor(actor);

	//property
	//Speed n Heading
	AddProperty(new dtDAL::FloatActorProperty(C_SET_SPEED,C_SET_SPEED,
		dtDAL::FloatActorProperty::SetFuncType(actor, &ExocetMM40Actor::SetCurrentSpeed),
		dtDAL::FloatActorProperty::GetFuncType(actor, &ExocetMM40Actor::GetCurrentSpeed), "Sets/gets speed.", C_TYPE_MISSILE));

	AddProperty(new dtDAL::FloatActorProperty(C_SET_HEADING,C_SET_HEADING,
		dtDAL::FloatActorProperty::SetFuncType(actor, &ExocetMM40Actor::SetCurrentHeading),
		dtDAL::FloatActorProperty::GetFuncType(actor, &ExocetMM40Actor::GetCurrentHeading), "Sets/gets Heading.", C_TYPE_MISSILE));

	//Moving
	AddProperty(new dtDAL::FloatActorProperty(C_SET_INIT_STEPMOVING,C_SET_INIT_STEPMOVING,
		dtDAL::FloatActorProperty::SetFuncType(actor, &ExocetMM40Actor::SetStepMoving),
		dtDAL::FloatActorProperty::GetFuncType(actor, &ExocetMM40Actor::GetStepMoving), "Sets/gets Moving.", C_TYPE_MISSILE));
	AddProperty(new dtDAL::FloatActorProperty(C_SET_INIT_STEPHAFO,C_SET_INIT_STEPHAFO,
		dtDAL::FloatActorProperty::SetFuncType(actor, &ExocetMM40Actor::SetStepHAFO),
		dtDAL::FloatActorProperty::GetFuncType(actor, &ExocetMM40Actor::GetStepHAFO), "Sets/gets HAFO.", C_TYPE_MISSILE));
	AddProperty(new dtDAL::FloatActorProperty(C_SET_INIT_STEPCRUISE,C_SET_INIT_STEPCRUISE,
		dtDAL::FloatActorProperty::SetFuncType(actor, &ExocetMM40Actor::SetStepCruise),
		dtDAL::FloatActorProperty::GetFuncType(actor, &ExocetMM40Actor::GetStepCruise), "Sets/gets Cruise.", C_TYPE_MISSILE));
	AddProperty(new dtDAL::FloatActorProperty(C_SET_INIT_STEPSEARCHING,C_SET_INIT_STEPSEARCHING,
		dtDAL::FloatActorProperty::SetFuncType(actor, &ExocetMM40Actor::SetStepSearching),
		dtDAL::FloatActorProperty::GetFuncType(actor, &ExocetMM40Actor::GetStepSearching), "Sets/gets Searching.", C_TYPE_MISSILE));
}