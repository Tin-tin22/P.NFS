// $Id: torsutactor.cpp

/**
* @file torsutactor.cpp
*
* @author nfs
*
* @date February 27th, 2012
*
* @brief The source file for torsutactor actor.
*
* torsutactor is the class for the C802 Yingji Missile.
*
*/

#include "torsutactor.h"
#include "ShipModelActor.h"
#include "submarineactor.h"
#include "didactorssources.h"
//#include "../didNetwork/SimTCPDataTypes.h"
//#include "../didUtils/simActorControl.h"

///////////////////////////////////////////////////////////////////////////////
// panjang kabel 15311+20122 yard..14000.3784 +18399.5568 meter =32400.00 meter
// low speed 18knot 
// med speed 23knot
// high speed 34knot
///////////////////////////////////////////////////////////////////////////////

//++ Constants
const float TorSutActor::CABLE_LENGTH = 32399.9352f; 

TorSutActor::TorSutActor(dtGame::GameActorProxy &proxy) : 
   MissilesActor(proxy),
	   isFind(false),
	   isFirst(true),
	   isCircle(false),
	   isHandleSpeed(false),
	   isHandleCourse(false),
	   isHandleDepth(false),
	   isFirstGetDir(true),
	   isTurnArround(false),
	   TargetIDFromCone(0),
	   firstDirection(0.0f),
	   lastDirection(0.0f),
	   TorpRange(0),
	   getPitch(0),
	   getDir(0),
	   count(0),
	   existTime(0),
	   range2d(0.0f),
	   tgtID(0),
	   jarakTarget(10000000.0f)
{}

TorSutActor::~TorSutActor()
{
	
}
///////////////////////////////////////////////////////////////////////////////
void TorSutActor::TickLocal(const dtGame::Message &tickMessage)
{
	const dtGame::TickMessage &tick = static_cast<const dtGame::TickMessage&>(tickMessage);
	float deltaSimTime = tick.GetDeltaSimTime();

	if(GetGameActorProxy().IsInGM()){
		if(isLaunch == true){
			/*dtCore::RefPtr<dtDAL::ActorProxy> hitTargetProxy= CeckCollision(trac.GetSpeedKnot()* DEF_KNOT_TO_METRE, tick.GetDeltaSimTime());
			if ( hitTargetProxy != NULL )
			{
			  std::cout<<"Torpedo "<< mMissileID <<" hit "<<hitTargetProxy->GetName()<<std::endl;
			  UpdateStatusDBEffectTo2D(hitTargetProxy->GetActor(), ST_MISSILE_HIT);
			  TorpBlast(hitTargetProxy.get());
			}*/
			if ( GetGameActorProxy().GetGameManager()->GetMachineInfo().GetName() == C_MACHINE_SERVER )
				CeckCollisionSUT();

			//Sound Effect
			if ( missileSound != NULL ){
				if ( !missileSound->IsPlaying() ) 
					missileSound->Play();
			}

			existTime+=deltaSimTime;
			//if ( existTime >= 1124 ) EndOfTorpedo(); //asumsi v 18knot & range 13,5km

			//if ( !isPauseSUT )
				Move(tick.GetDeltaSimTime());
		}
	}
}

///////////////////////////////////////////////////////////////////////////////
void TorSutActor::TickRemote(const dtGame::Message &tickMessage)
{
   const dtGame::TickMessage &tick = static_cast<const dtGame::TickMessage&>(tickMessage);
}

void TorSutActor::ProcessOrderEvent(const dtGame::Message &message)
{
	const MsgSetTorpedoSUT &Msg = static_cast<const MsgSetTorpedoSUT&>(message);
	int vhcID = (int) Msg.GetVehicleID();
	dtCore::RefPtr<dtDAL::ActorProxy> parentProxy = GetShipActorByID(vhcID);
	if ( parentProxy.valid())
	{
		dtCore::RefPtr<VehicleActor> parent = static_cast<VehicleActor*>(parentProxy->GetActor());
		if (( !GetLaunched() ) &&  
			( IsMissileValidID( Msg.GetVehicleID(),Msg.GetWeaponID(),Msg.GetLauncherID(),Msg.GetMissileID(),Msg.GetMissileNum() ) ) )
		{
			orderID = (int) Msg.GetOrderID();
			OwnShipProxy = parentProxy;
			PredictionMode = (int) Msg.GetModePrediction();

			switch ( orderID ){		
				case ORD_TORPEDOSUT_FIRED : 
				{
					if (isLaunch == false)
					{
						mMyParent = parent;

						tgtID = (int) Msg.GetTargetID();
						TargetID = tgtID;
						targetProxy = GetShipActorByID(tgtID);

						CSetTorpedoSpeed(Msg.GetTorpedoSpeed()); //  dalam knot
						CSetTorpedoDepth(-1*Msg.GetTorpedoDepth());
						SetSafeDistance(Msg.GetTorpedoSafeDistance());
						SetVehicleID(Msg.GetVehicleID());
						SetEnDis(Msg.GetTorpedoEnDis());
						SetTgtID(Msg.GetTargetID());
						
						AddToEnvironmentActor();

						InitRun();
						isLaunch = true;
						isHandleCourse = true;
						isHandleDepth = true;
						isHandleSpeed = true;

						UpdateStatusDBEffectTo2D(mMyParent.get(),ST_MISSILE_RUN);
						std::cout << GetName() << " " << mMissileID << " run. to " << tgtID << std::endl ;

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

					} else 
						std::cout << GetName() <<" "<< mMissileID <<" already launching or target not valid" << std::endl ;
				}
				break;
			} 
		}
		else
		if (( GetLaunched() ) &&  
			( IsMissileValidID( Msg.GetVehicleID(),Msg.GetWeaponID(),Msg.GetLauncherID(),Msg.GetMissileID(),Msg.GetMissileNum() ) ) )
		{
			tgtID = (int) Msg.GetTargetID();
			TargetID = tgtID;
			targetProxy = GetShipActorByID(tgtID);

			if (Msg.GetOrderID() == ORD_TORPEDOSUT_HOMING)
			{
				CSetTorpedoSpeed(44); //  high speed dalam knot
				//CSetTorpedoDepth(-1*Msg.GetTorpedoDepth());
				//CSetTorpedoCourse(Msg.GetTorpedoCourse());

				isFirstGetDir = true;
				PredictionMode = Homing;
				isHandleCourse = false;
				isHandleDepth = false;
				isHandleSpeed = true;
			}
			else if (Msg.GetOrderID() == ORD_TORPEDOSUT_TARGETSEARCH)
			{
				isFirstGetDir = true;
				PredictionMode = TargetSearchProgram;
				isHandleCourse = false;
				isHandleDepth = false;
				isHandleSpeed = false;
			}
			else if (Msg.GetOrderID() == ORD_TORPEDOSUT_HANDLE)
			{
				isFirstGetDir = true;
				PredictionMode = (int) Msg.GetModePrediction();

				isHandleCourse = true;
				isHandleDepth = true;
				isHandleSpeed = true;

				CSetTorpedoSpeed(Msg.GetTorpedoSpeed());
				CSetTorpedoCourse(Msg.GetTorpedoCourse());
				SetEnDis(Msg.GetTorpedoEnDis());
				CSetTorpedoDepth(-1*Msg.GetTorpedoDepth());
				std::cout << GetName()<<" Handled : Course " << CGetTorpedoCourse()<<" Speed "<< CGetTorpedoSpeed()<<" Depth "<< CGetTorpedoDepth()<<std::endl;
			}
			else if ( Msg.GetOrderID() == ORD_TORPEDOSUT_DELETE )
			{
				EndOfTorpedo();
			}
			else if ( Msg.GetOrderID() == ORD_TORPEDOSUT_SEARCH )
			{
				isFirstGetDir = true;
				isHandleSpeed = true;
				PredictionMode = ManualMode;
				CSetTorpedoSpeed(Msg.GetTorpedoSpeed()); // dalam knot
			}
			else if ( Msg.GetOrderID() == ORD_TORPEDOSUT_SHUTDOWN )
			{
				isFirstGetDir = true;
				isHandleSpeed = true;
				isHandleCourse = false;
				isHandleDepth = false;
				PredictionMode = ManualMode;
				CSetTorpedoSpeed(Msg.GetTorpedoSpeed()); // dalam knot
			}
		}
	}
	else
		std::cout << "ShipID or TargetID not valid" <<std::endl;
}

///////////////////////////////////////////////////////////////////////////////
void TorSutActor::ProcessMessage(const dtGame::Message &message)
{
  if(GetGameActorProxy().IsInGM())
  {
    if(message.GetMessageType().GetName() == SimMessageType::TORPEDOSUT_EVENT.GetName())
      ProcessOrderEvent(message);
  }
}

void TorSutActor::CeckCollisionSUT() //eka - 17022012
{
	std::vector<dtGame::GameActorProxy*> vActors;
	std::vector<dtGame::GameActorProxy*>::iterator iter;
	dtCore::Transformable* actor;
	dtCore::RefPtr<dtCore::DeltaDrawable> TempTarget;
	/* Target Object */
	static dtCore::Transform TargetTransform;
	static osg::Vec3 TargetPosition, TargetRotation;

	GetGameActorProxy().GetGameManager()->GetAllGameActors(vActors);   

	for (iter = vActors.begin(); iter < vActors.end(); iter++)
	{
		if (((*iter)->GetActorType().GetName()== C_CN_SHIP ) || ((*iter)->GetActorType().GetName()== C_CN_SUBMARINE )) 
		{
			TempTarget = (*iter)->GetActor();
			if (TempTarget->GetName() == OwnShipProxy->GetActor()->GetName())
				continue;

			actor = dynamic_cast<dtCore::Transformable*> ((*iter)->GetActor());
			if (actor){
				actor->GetTransform(TargetTransform);
				TargetTransform.GetTranslation(TargetPosition);
				TargetTransform.GetRotation(TargetRotation);
				TargetTransform.SetTranslation(TargetPosition);
				TargetTransform.SetRotation(TargetRotation);
				actor->SetTransform(TargetTransform);

				if(IsInCone(missilePosition, TargetPosition, missileRotation.x(), missileRotation.y(), 10, 10)){		
					std::cout<<"Torpedo "<< mMissileID <<" hit "<<actor->GetName()<<std::endl;
					UpdateStatusDBEffectTo2D(actor, ST_MISSILE_HIT, GetMissileLethality());
					TorpBlast(TargetPosition);
				}
			}
		}
	}
}
 
void TorSutActor::CalcHitPredition ( 
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
void TorSutActor::Move(double deltaSimTime)
{
	trac.Calc_SpeedTorp(deltaSimTime);
	dir = trac.Calc_MovementTorp(deltaSimTime);		

	//getting property missile
	GetTransform(missileTransform);	
	missileTransform.GetRotation(missileRotation);
	missileTransform.GetTranslation(missilePosition);

	//getting property object n missile
	if ( isFirst )
	{		
		missileFirstPos=missilePosition;
		aFirstPos=missilePosition;
		isFirst = false; 
	}

	float jarak = GetDistance(missileFirstPos, missilePosition);
	float jarakawal = GetDistance(aFirstPos, missilePosition);

	if (jarakawal >= GetSafeDistance())
	{
		//if( !isFind )
			SearchingTarget();

		if ( PredictionMode == TargetSearchProgram )
		{			
			// search pattern
			if (isFirstGetDir)
			{
				lastDirection = trac.GetDirection();
				missileFirstPos = missilePosition;
				isFirstGetDir = false;
				isCircle = true;
				isStopCircle = false;
			}

			//std::cout << "jarak : " << jarak << ", ld : " << lastDirection+360 << ", d : " << trac.GetDirection() << std::endl;
			if (isCircle)
			{
				trac.SetDirection(trac.GetDirection()+(10*deltaSimTime));
				if (trac.GetDirection()>=(360.0f+lastDirection))
				{
					isCircle = false;
					isStopCircle = true;
					missileFirstPos=missilePosition;
					trac.SetDirection(lastDirection);
					std::cout << "stop circle " << 360.0f+lastDirection << std::endl;
				}
			}

			if ( jarak >= GetSafeDistance() && isStopCircle)
				isCircle = true;

		}
		else if (PredictionMode == InterceptMode && targetProxy.valid ())
		{
			actorTarget = targetProxy->GetActor();
			//VehicleActor* TargetAct = dynamic_cast<VehicleActor*>(actorTarget.get());
			dtCore::RefPtr<VehicleActor> TargetAct = static_cast<VehicleActor*>(targetProxy->GetActor());
			if ( TargetAct != NULL )
			{
				/*float tSpeed,tCourse,tBearing ,tRange;
				float hRange,hBearing,hTime;
				int tvid;*/

				dtGame::GameActorProxy &pr = TargetAct->GetGameActorProxy();
				TargetAct->GetTransform(targetTransform);
				targetTransform.GetTranslation(targetPosition);
				dtCore::RefPtr<dtDAL::ActorProperty> speedProp(pr.GetProperty(C_SET_SPEED));
				dtCore::RefPtr<dtDAL::FloatActorProperty> vspeedProp( static_cast<dtDAL::FloatActorProperty*>( speedProp.get() ) );
				tSpeed = vspeedProp->GetValue(); 
				dtCore::RefPtr<dtDAL::ActorProperty> courseProp(pr.GetProperty(C_SET_COURSE) );
				dtCore::RefPtr<dtDAL::FloatActorProperty> vcourseProp( static_cast<dtDAL::FloatActorProperty*>( courseProp.get() ) );
				tCourse = vcourseProp->GetValue();
				dtCore::RefPtr<dtDAL::ActorProperty> tvidProp(pr.GetProperty(C_SET_VID));
				dtCore::RefPtr<dtDAL::IntActorProperty> vtvidProp( static_cast<dtDAL::IntActorProperty*>( tvidProp.get() ) );
				tvid = vtvidProp->GetValue(); 

				tBearing = ComputeBearingTo2(missilePosition.x(),missilePosition.y(),targetPosition.x(),targetPosition.y());
				tRange = ComputeDistance(missilePosition.x(),missilePosition.y(), targetPosition.x(),targetPosition.y());

				//std::cout << tRange << ", " <<tBearing << ", " <<tSpeed << ", " <<tCourse<<std::endl;
				CalcHitPredition(tRange,tBearing,tSpeed,tCourse,trac.GetSpeedKnot(),hRange,hBearing,hTime);
				hBearing = ValidateDegree(hBearing);
				//std::cout << GetName() << "-" << tvid << " pos:" << targetPosition << ", " << tRange << ", " <<tBearing << ", " <<hTime <<std::endl;
				CSetTorpedoCourse(hBearing);
				CheckUpdateCourse();
				CheckUpdateSpeedDepth();
			}
		}
		else if (PredictionMode == BearingMode && targetProxy.valid ())
		{
			dtCore::RefPtr<VehicleActor> tgt = static_cast<VehicleActor*>(targetProxy->GetActor());
			tgt->GetTransform(targetTransform);
			targetTransform.GetTranslation(targetPosition); 
			targetTransform.GetRotation(targetRotation);
			float mTarget_Bearing;
			mTarget_Bearing = ComputeBearingTo2(missilePosition.x(),missilePosition.y(),targetPosition.x(),targetPosition.y());
			mTarget_Bearing = ValidateDegree(mTarget_Bearing);
			CSetTorpedoCourse(mTarget_Bearing);
			CheckUpdateCourse();
			CheckUpdateSpeedDepth();			
		}
		else if (PredictionMode == ManualMode)
		{
			// set course, depth, endis di processorderevent
			CheckUpdateCourse();
			CheckUpdateSpeedDepth();
		}
		else if (PredictionMode == Homing && targetConeProxy.valid ())
		{
			dtCore::RefPtr<VehicleActor> tgt = static_cast<VehicleActor*>(targetConeProxy->GetActor());
			tgt->GetTransform(objectTransform);
			objectTransform.GetTranslation(objectPosition); 
			objectTransform.GetRotation(objectRotation);

			if(IsInCone(missilePosition, objectPosition, missileRotation.x(), missileRotation.y(), 1852, 1300)){
				nbearing = ComputeBearingTo2(missilePosition.x(),missilePosition.y(),objectPosition.x(),objectPosition.y());
				nbearing = ValidateDegree(nbearing);
				npitch	 = GetPitch(missilePosition,objectPosition);

				trac.SetDirection(nbearing);
				trac.SetElevation(npitch);

				//CSetTorpedoCourse(nbearing);
				//CSetTorpedoDepth(npitch);
				//CheckUpdateCourse();
				CheckUpdateSpeedDepth();
			}
			else
			{
				PredictionMode = None ;
				trac.SetAcceleration(0);
				isHandleSpeed = false;

				//Send To TOCOS
				dtCore::RefPtr<MsgUtilityAndTools> msgFindTarget;
				dtGame::GameManager* gm= GetGameActorProxy().GetGameManager();
				dtGame::MessageFactory* mf=&gm->GetMessageFactory();
				mf->CreateMessage(*(mf->GetMessageTypeByName(C_MT_UTILITY_AND_TOOLS)),msgFindTarget);
				msgFindTarget->SetOrderID(TIPE_UTIL_MISSILE_FINDTARGET);
				msgFindTarget->SetUAT0(GetVehicleID());
				msgFindTarget->SetUAT1(GetWeaponID());
				msgFindTarget->SetUAT2(GetLauncherID());
				msgFindTarget->SetUAT3(GetMissileID());
				msgFindTarget->SetUAT4(3); // Homing but Not Found Target 
				msgFindTarget->SetUAT5( TargetIDFromCone );
				GetGameActorProxy().GetGameManager()->SendNetworkMessage(*msgFindTarget.get());
				GetGameActorProxy().GetGameManager()->SendMessage(*msgFindTarget.get());

				std::cout << "3D send to TOCOS that Homing but Not Found target " << TargetIDFromCone << std::endl;
			}
		}
	}
	else
	{
		CheckUpdateSpeedDepth();
	}
	
	//impelementation
	missilePosition.x() += dir.x();
	missilePosition.y() += dir.y();
	missilePosition.z() += dir.z();

	missileRotation[0] = -trac.GetDirection();
	//missileRotation[1] = trac.GetElevation(); 
	missileRotation[2] = 0.0f;

	missileTransform.SetTranslation(missilePosition);
	missileTransform.SetRotation(missileRotation);
	SetCurrentHeading(trac.GetDirection());
	SetCurrentSpeed(trac.GetSpeedKnot()*DEF_KNOT_TO_METRE);
	SetTransform(missileTransform);	
}

void TorSutActor::CheckUpdateCourse()
{
	// implement course
	if ( (trac.GetDirection() <= CGetTorpedoCourse()) && (isHandleCourse) )
	{
		trac.SetDirection(trac.GetDirection()+1);
		if (trac.GetDirection()>=CGetTorpedoCourse()){
			trac.SetDirection(CGetTorpedoCourse());
			isHandleCourse = false;
		}
	}
	else if ( (trac.GetDirection() > CGetTorpedoCourse()) && (isHandleCourse) )
	{
		trac.SetDirection(trac.GetDirection()-1);
		if (trac.GetDirection()<=CGetTorpedoCourse()) {
			trac.SetDirection(CGetTorpedoCourse());
			isHandleCourse = false;
		}
	}
}

void TorSutActor::CheckUpdateSpeedDepth()
{
	// update depth [6/3/2013 DID RKT2]
	if( ( missilePosition.z() <= CGetTorpedoDepth() ) && (isHandleDepth) )
	{
		//trac.SetElevation(10.0);
		missilePosition.z() += 0.03;
		if(missilePosition.z() >= CGetTorpedoDepth()){
			trac.SetElevation(0.0f);
			missilePosition.z() = CGetTorpedoDepth();
			isHandleDepth = false;
		}
	}
	else if( ( missilePosition.z() > CGetTorpedoDepth() ) && (isHandleDepth) )
	{
		//trac.SetElevation(-10.0);
		missilePosition.z() -= 0.03;
		if(missilePosition.z() <= CGetTorpedoDepth()){
			trac.SetElevation(0.0f);
			missilePosition.z() = CGetTorpedoDepth();
			isHandleDepth = false;
		}
	}

	// update speed [9/4/2012 DID RKT2]
	if( (trac.GetSpeedKnot() <= CGetTorpedoSpeed()) && (isHandleSpeed) )
	{
		trac.SetAcceleration(2.0);
		if(trac.GetSpeedKnot() >= CGetTorpedoSpeed()){
			trac.SetAcceleration(0.0f);
			isHandleSpeed = false;
		}
	}
	else if( (trac.GetSpeedKnot() > CGetTorpedoSpeed()) && (isHandleSpeed) )
	{
		trac.SetAcceleration(-2.0);
		if(trac.GetSpeedKnot() <= CGetTorpedoSpeed()){
			trac.SetAcceleration(0.0f);
			isHandleSpeed = false;
		}
	}
}

void TorSutActor::SearchingTarget() //eka - 17022012
{
	/*std::vector<dtGame::GameActorProxy*> vActors;
	std::vector<dtGame::GameActorProxy*>::iterator iter;
	dtCore::Transformable* actor;
	dtCore::RefPtr<dtCore::DeltaDrawable> TempTarget;*/

	GetGameActorProxy().GetGameManager()->GetAllGameActors(vActors);   

	for (iter = vActors.begin(); iter < vActors.end(); iter++)
	{
		if (((*iter)->GetActorType().GetName()== C_CN_SHIP ) || ((*iter)->GetActorType().GetName()== C_CN_SUBMARINE )) 
		{
			TempTarget = (*iter)->GetActor();
			if (TempTarget->GetName() == OwnShipProxy->GetActor()->GetName())
				continue;

			actor = dynamic_cast<dtCore::Transformable*> ((*iter)->GetActor());
			if (actor){
				actor->GetTransform(objectTransform);
				objectTransform.GetTranslation(objectPosition);
				objectTransform.GetRotation(objectRotation);
				objectTransform.SetTranslation(objectPosition);
				objectTransform.SetRotation(objectRotation);
				actor->SetTransform(objectTransform);

				if(IsInCone(missilePosition, objectPosition, missileRotation.x(), missileRotation.y(), 1852, 1300)){		
					//jika target dalam cone jumlahnya 1, belum dicoba jika lebih dari 1
					jarakSubmarine = GetDistanceCone(missilePosition,objectPosition);
					if (jarakSubmarine<=jarakTarget)
					{
						jarakTarget=jarakSubmarine;
						mShipTarget = TempTarget;

						VehicleActor* TargetAct = dynamic_cast<VehicleActor*>(mShipTarget.get());
						if ( TargetAct != NULL )
						{
							float tVID;
							dtGame::GameActorProxy &pr = TargetAct->GetGameActorProxy();
							dtCore::RefPtr<dtDAL::ActorProperty> vidProp(pr.GetProperty(C_SET_VID));
							dtCore::RefPtr<dtDAL::IntActorProperty> vVIDProp( static_cast<dtDAL::IntActorProperty*>( vidProp.get() ) );
							tVID = vVIDProp->GetValue(); 

							if ( TargetIDFromCone != tVID ) //pengecekan agar tidak kirim berulang kali -> salah
							{
								isTurnArround = false;
								isFind = true;
 
								std::cout << "3D send to TOCOS find targetID " << tVID << std::endl;
								TargetIDFromCone = tVID ;
								targetConeProxy = GetShipActorByID(TargetIDFromCone);

								//Send To TOCOS
								dtCore::RefPtr<MsgUtilityAndTools> msgFindTarget;
								dtGame::GameManager* gm= GetGameActorProxy().GetGameManager();
								dtGame::MessageFactory* mf=&gm->GetMessageFactory();
								mf->CreateMessage(*(mf->GetMessageTypeByName(C_MT_UTILITY_AND_TOOLS)),msgFindTarget);
								msgFindTarget->SetOrderID(TIPE_UTIL_MISSILE_FINDTARGET);
								msgFindTarget->SetUAT0(GetVehicleID());
								msgFindTarget->SetUAT1(GetWeaponID());
								msgFindTarget->SetUAT2(GetLauncherID());
								msgFindTarget->SetUAT3(GetMissileID());
								msgFindTarget->SetUAT4(1); //Find
								msgFindTarget->SetUAT5( tVID );
								GetGameActorProxy().GetGameManager()->SendNetworkMessage(*msgFindTarget.get());
								GetGameActorProxy().GetGameManager()->SendMessage(*msgFindTarget.get());			
							}

							// definisikan sut di bawah target ConeProxy
							//std::cout << "mz : " << missilePosition.z() << ", oz : " << objectPosition.z() << ", r2d : " << range2d << std::endl;
							if (missilePosition.z() <= objectPosition.z() && isFind)
							{
								range2d = GetDistance(missilePosition,objectPosition);
								if (range2d < 50)
									isTurnArround = true;
							}

							if ( isTurnArround )
							{
								std::cout << "3D send to TOCOS is turn arround targetID " << tVID << std::endl;
								isFind = false;
								isTurnArround = false;

								//TargetIDFromCone = tVID ;
								//targetConeProxy = GetShipActorByID(TargetIDFromCone);

								//Send To TOCOS
								dtCore::RefPtr<MsgUtilityAndTools> msgFindTarget;
								dtGame::GameManager* gm= GetGameActorProxy().GetGameManager();
								dtGame::MessageFactory* mf=&gm->GetMessageFactory();
								mf->CreateMessage(*(mf->GetMessageTypeByName(C_MT_UTILITY_AND_TOOLS)),msgFindTarget);
								msgFindTarget->SetOrderID(TIPE_UTIL_MISSILE_FINDTARGET);
								msgFindTarget->SetUAT0(GetVehicleID());
								msgFindTarget->SetUAT1(GetWeaponID());
								msgFindTarget->SetUAT2(GetLauncherID());
								msgFindTarget->SetUAT3(GetMissileID());
								msgFindTarget->SetUAT4(2); //Turn Arround
								msgFindTarget->SetUAT5( tVID );
								GetGameActorProxy().GetGameManager()->SendNetworkMessage(*msgFindTarget.get());
								GetGameActorProxy().GetGameManager()->SendMessage(*msgFindTarget.get());			
							}
						}
					}
				}
			}
		}
	}

	// - Checking target that found is in outside cone [4/15/2014 EKA]
	if ( mShipTarget != NULL)
	{
		dynamic_cast<VehicleActor*>(mShipTarget.get())->GetTransform(objectTransform2);
		objectTransform2.GetTranslation(objectPosition2);
		objectTransform2.GetRotation(objectRotation2);

		GetTransform(missileTransform);
		missileTransform.GetTranslation(missilePosition);
		missileTransform.GetRotation(missileRotation);

		/* If Not Inside Cone Missile, Missile Will Searching New Target */ 
		if( IsInCone( missilePosition, objectPosition2, missileRotation.x(), missileRotation.y(), 1852, 1300 ) == false )
		{
			TargetIDFromCone = 0;
			jarakTarget = 10000000.0f;
			jarakSubmarine = 0;
			mShipTarget = NULL ;
		}
	}
}


void TorSutActor::InitRun()
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
	
	trac.SetDirection(180-ShipParchimHeading); 
	CSetTorpedoCourse(180-ShipParchimHeading);
	firstDirection = trac.GetDirection();
	trac.SetSpeedKnot(CGetTorpedoSpeed());

	dtCore::RefPtr<dtCore::ParticleSystem> mExplosion= new dtCore::ParticleSystem();
	mExplosion->LoadFile(C_PARTICLES_ASAP,true);
	GetGameActorProxy().GetActor()->AddChild(mExplosion.get());
	mExplosion->SetEnabled(true);
}
 
void TorSutActor::EndOfTorpedo()
{ 
	SetLaunched(false);
	std::cout<<GetName()<<" "<<mMissileID<<" End..."<<std::endl;
	UpdateStatusDBEffectTo2D(mMyParent.get(), ST_MISSILE_DEL);
}
 
void TorSutActor::TorpBlast(osg::Vec3 TargetPos)
{
	/*dtCore::Transform t x;
	GetTransform(tx,dtCore::Transformable::ABS_CS);
	dtCore::RefPtr<dtCore::ParticleSystem> mExplosion;
	mExplosion = new dtCore::ParticleSystem();
	mExplosion->LoadFile(C_PARTICLES_TORPEDO_EXPLODE,true);
	p->GetActor()->AddChild(mExplosion.get());

	mExplosion->SetTransform(tx,dtCore::Transformable::ABS_CS);
	mExplosion->SetEnabled(true);*/

	UpdateStatusDBEffectTo3DExplode(TargetPos.x(), TargetPos.y(), TargetPos.z() ,ST_MISSILE_EXPLODE);
	EndOfTorpedo();
}

void TorSutActor::CSetTorpedoDepth(float depth)// depth dalam feet, mDepth dlm meter
{
	//mDepth = depth * c_Feet_To_Meter;
	mDepth = depth;
}

void TorSutActor::OnEnteredWorld()
{
	MissilesActor::OnEnteredWorld();

	/*missileSound = dtAudio::AudioManager::GetInstance().NewSound();
	missileSound->LoadFile("Sounds/Missile.wav");
	assert(missileSound);
	missileSound->SetMaxDistance(1000.0f);
	missileSound->SetLooping(true);
	AddChild(missileSound.get());*/
}

void TorSutActor::OnRemovedFromWorld()
{
	MissilesActor::OnRemovedFromWorld();
}
 

///////////////////////////////////////////////////////////////////////////////

TorSutActorProxy::TorSutActorProxy()
{
   //SetClassName(C_CN_TORPSUT);
}

///////////////////////////////////////////////////////////////////////////////
void TorSutActorProxy::BuildPropertyMap()
{
   MissilesActorProxy::BuildPropertyMap();
   
   const std::string GROUP = C_TYPE_MISSILE;

   TorSutActor* actor = NULL;
   
   GetActor(actor);

   //property

   AddProperty(new dtDAL::FloatActorProperty(C_SET_SPEED,C_SET_SPEED,
	dtDAL::FloatActorProperty::SetFuncType(actor, &TorSutActor::SetCurrentSpeed),
	dtDAL::FloatActorProperty::GetFuncType(actor, &TorSutActor::GetCurrentSpeed), "Sets/gets speed.", GROUP));

   AddProperty(new dtDAL::FloatActorProperty(C_SET_HEADING,C_SET_HEADING,
	dtDAL::FloatActorProperty::SetFuncType(actor, &TorSutActor::SetCurrentHeading),
	dtDAL::FloatActorProperty::GetFuncType(actor, &TorSutActor::GetCurrentHeading), "Sets/gets Heading.", GROUP));

   AddProperty(new dtDAL::IntActorProperty(C_SET_HEADING,C_SET_HEADING,
	   dtDAL::IntActorProperty::SetFuncType(actor, &TorSutActor::SetTgtID),
	   dtDAL::IntActorProperty::GetFuncType(actor, &TorSutActor::GetTgtID), "Sets/gets tgtID.", GROUP));

}

 
///////////////////////////////////////////////////////////////////////////////
void TorSutActorProxy::OnEnteredWorld()
{
	MissilesActorProxy::OnEnteredWorld();
	RegisterForMessages(SimMessageType::TORPEDOSUT_EVENT);
}