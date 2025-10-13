#include "StrelaRocketActor.h"
#include "didactorssources.h"
#include "OceanActor.h"
#include "ShipModelActor.h"
#include "StrelaSpoutActor.h"
#include "helicopteractor.h"
//#include <dtCore/transformable.h>

//++ Constants
const float StrelaRocketActor::MAX_RANGE = 4200.0f;       //Maximum Range (meter)
const float StrelaRocketActor::MAX_PITCH = -15.0f;       //Maximum Elev (degree)
const float StrelaRocketActor::MIN_PITCH = 89.9f;       //Minimum Elev (degree)
//-- Constants

///////////////////////////////////////////////////////////////////////////////
StrelaRocketActor::StrelaRocketActor(dtGame::GameActorProxy &proxy) : 
MissilesActor(proxy), 
mSmoke(false), mSmokeStatus(false), isFind(false), isFirst(true),isSeekerFind(false),
ExcRange(0), jarakHelicopter(0), jarakTarget(10000000.0f), nbearing(0), npitch(0), lifeTime(0), isUnlockToFire(0), mShipTarget(NULL)
{}

StrelaRocketActor::~StrelaRocketActor()
{	
}

///////////////////////////////////////////////////////////////////////////////
void StrelaRocketActor::TickLocal(const dtGame::Message &tickMessage)
{
	const dtGame::TickMessage &tick = static_cast<const dtGame::TickMessage&>(tickMessage);
	float deltaSimTime = tick.GetDeltaSimTime();

	if( mSmokeStatus == true){
		if ( mSmoke->IsEnabled() ){}
		else mSmoke->SetEnabled(true); 
	}

	if ( isUnlockToFire == 1 )
	{
		dtCore::RefPtr<StrelaSpoutActor> Spout = static_cast<StrelaSpoutActor*>(GetParent());
		isSeekerFind = Spout->isFind;

		if ( isSeekerFind && seekerSound.valid()) 
			seekerSound->Play();
		else
		{
			if ( seekerSound.valid()) 
				seekerSound->Stop();
		}
	}
	else
	{
		if ( seekerSound.valid()) 
			seekerSound->Stop();
	}

	if( isLaunch == true){
		/*hitTargetProxy= CeckCollision(trac.GetSpeed() * DEF_MACH_TO_METRE, tick.GetDeltaSimTime());
		if ( hitTargetProxy != NULL )
		{
			std::cout<<"Strela "<< mMissileID <<" hit "<<hitTargetProxy->GetName()<<std::endl;
			UpdateStatusDBEffectTo2D(hitTargetProxy->GetActor(), ST_MISSILE_HIT);
			Blast(hitTargetProxy.get());
			EndOfStrela();
		}*/

		if ( GetGameActorProxy().GetGameManager()->GetMachineInfo().GetName() == C_MACHINE_SERVER )
			CeckCollisionRocket();

		Move(deltaSimTime);

		lifeTime += deltaSimTime;
		if (lifeTime > 30)
		{
			UpdateStatusDBEffectTo2D(mMyParent.get(), ST_MISSILE_DEL);
			std::cout << "strella Delete By Effective Time " <<std::endl;
		}

		//SetCollisionBox();

		//Sound Effect
		if ( missileSound != NULL )
		{
			if ( !missileSound->IsPlaying() ) 
				missileSound->Play();
		}
	}
}

///////////////////////////////////////////////////////////////////////////////
void StrelaRocketActor::TickRemote(const dtGame::Message &tickMessage)
{
	const dtGame::TickMessage &tick = static_cast<const dtGame::TickMessage&>(tickMessage);
}

///////////////////////////////////////////////////////////////////////////////

void StrelaRocketActor::ProcessOrderEvent(const dtGame::Message &message)
{
	const MsgSetStrela &Msg = static_cast<const MsgSetStrela&>(message);
	dtCore::RefPtr<dtDAL::ActorProxy> parentProxy = GetShipActorByID(Msg.GetVehicleID());
	if ( parentProxy.valid() )
	{
		OwnShipProxy = parentProxy;
		dtCore::RefPtr<VehicleActor> parent = static_cast<VehicleActor*>(parentProxy->GetActor());
		if (( !GetLaunched() ) &&  
			( IsMissileValidID( Msg.GetVehicleID(),Msg.GetWeaponID(),Msg.GetLauncherID(),Msg.GetMissileID(),Msg.GetMissileNum() ) ) )
			switch (Msg.GetOrderID())
		{
			case ORD_STRELA_FIRE : 	
				{
					mMyParent = parentProxy->GetActor();
					static float h,p,r;

					StrelaSpoutActor* SpoutAct = dynamic_cast<StrelaSpoutActor*>(GetParent());
					if ( SpoutAct != NULL )
					{
						static dtCore::Transform spoutTransform;
						static osg::Vec3 spoutPosition,spoutRotation;
						SpoutAct->GetTransform(spoutTransform);
						spoutTransform.GetTranslation(spoutPosition);
						spoutTransform.GetRotation(h, p, r);
					}
					SetTargetBearing(-h);
					SetTargetElev(p);
					SetTargetRange(Msg.GetTargetRange());
					SetVehicleID(Msg.GetVehicleID());

					SetTrac();
					AddToEnvironmentActor();
					isLaunch = true;
					mMyParent = parentProxy->GetActor();
					mSmokeStatus = true;

					//Send To Instruktur
					dtCore::RefPtr<MsgUtilityAndTools> msgForTrac2D;
					dtGame::GameManager* gm= GetGameActorProxy().GetGameManager();
					dtGame::MessageFactory* mf=&gm->GetMessageFactory();
					mf->CreateMessage(*(mf->GetMessageTypeByName(C_MT_UTILITY_AND_TOOLS)),msgForTrac2D);
					msgForTrac2D->SetOrderID(TIPE_UTIL_TRAC2D);
					msgForTrac2D->SetUAT0(GetVehicleID());
					msgForTrac2D->SetUAT1(GetWeaponID());
					msgForTrac2D->SetUAT2(GetLauncherID());
					msgForTrac2D->SetUAT3(GetMissileID()); 
					msgForTrac2D->SetUAT4(GetMissileNum());
					msgForTrac2D->SetUAT5(GetTargetElev());
					GetGameActorProxy().GetGameManager()->SendNetworkMessage(*msgForTrac2D.get());
					GetGameActorProxy().GetGameManager()->SendMessage(*msgForTrac2D.get());
				}
			break;
			case ORD_STRELA_STATUS_UNLOCK :
				{
					isUnlockToFire = 1;					
				}
			break;
			case ORD_STRELA_STATUS_LOCK :
				{
					isUnlockToFire = 0;					
				}
			break;
		}
	}
}

void StrelaRocketActor::SetTrac(){
	trac.SetDirection(GetTargetBearing());
	trac.SetElevation(GetTargetElev());
	trac.SetSpeed(500/DEF_MACH_TO_METRE);

	std::cout << "bearing awal : " << trac.GetDirection() << std::endl;
	std::cout << "pitch awal : " << trac.GetElevation() << std::endl;
}

void StrelaRocketActor::ProcessMessage(const dtGame::Message &message)
{
	if(GetGameActorProxy().IsInGM()){

		if(message.GetMessageType().GetName() == SimMessageType::STRELA_EVENT.GetName())
			ProcessOrderEvent(message);
	}
}

void StrelaRocketActor::CeckCollisionRocket()
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
		if (((*iter)->GetActorType().GetName()== C_CN_AIRCRAFT ) || ((*iter)->GetActorType().GetName()== C_CN_HELICOPTER )
			|| ((*iter)->GetActorType().GetName()== C_CN_SHIP ) || ((*iter)->GetActorType().GetName()== C_CN_SUBMARINE) ) 
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
					std::cout<<"Strela "<< mMissileID <<" hit "<<actor->GetName()<< " with Lethality : " << GetMissileLethality() << std::endl;
					UpdateStatusDBEffectTo2D(actor, ST_MISSILE_HIT, GetMissileLethality());
					Blast(TargetPosition);
					EndOfStrela();
				}
			}
		}
	}
}

void StrelaRocketActor::SetTargetBearing(float bearing)
{
	mBearing = bearing;
}
void StrelaRocketActor::SetTargetRange(float targetRange)
{
	mTargetRange = targetRange;
}
void StrelaRocketActor::SetTargetElev(float elev)
{
	mElev = elev;
}
void StrelaRocketActor::SetIsUnlockToFire(int val)
{
	isUnlockToFire = val;
}

void StrelaRocketActor::Move(double deltaSimTime)
{
	static osg::Vec3 dir;

	trac.Calc_Speed(deltaSimTime);
	trac.Calc_Direction(deltaSimTime);
	dir = trac.Calc_Movement(deltaSimTime);

	GetTransform(missileTransform);
	missileTransform.GetTranslation(missilePosition);
	missileTransform.GetRotation(missileRotation);

	missilePosition.x() += dir.x();
	missilePosition.y() += dir.y();
	missilePosition.z() += dir.z();

	missileRotation[0] = -trac.GetDirection();
	missileRotation[1] = trac.GetElevation();
	missileRotation[2] = 0.0f;

	if (isFirst==true){		
		missileFirstPos=missilePosition;
		SetTrac();
		isFirst = false;
	}

	ExcRange = GetDistance(missilePosition,missileFirstPos);

	if (ExcRange >= MAX_RANGE) {
		UpdateStatusDBEffectTo2D(mMyParent.get(), ST_MISSILE_DEL);
		std::cout << "Strela Delete By Effective Range " <<std::endl;
	}

	if (isFind == false)
		SearchingTarget();
	else
	{
		MovetoTarget(deltaSimTime);
		MoveCheckMissingTarget();
	}

	SetCurrentSpeed(trac.GetSpeed());
	SetCurrentHeading(trac.GetDirection());
	missileTransform.SetTranslation(missilePosition);
	missileTransform.SetRotation(missileRotation);
	SetTransform(missileTransform);
}

void  StrelaRocketActor::MovetoTarget(double deltaSimTime)
{
	if ( mShipTarget != NULL)
	{
		static osg::Vec3 dir;
		dir = trac.Calc_Movement(deltaSimTime);

		GetTransform(missileTransform);
		missileTransform.GetTranslation(missilePosition);
		missileTransform.GetRotation(missileRotation);

		missilePosition.x() += dir.x();
		missilePosition.y() += dir.y();
		missilePosition.z() += dir.z();

		missileRotation[0] = -trac.GetDirection();
		missileRotation[1] = trac.GetElevation();
		missileRotation[2] = 0.0f;

		dynamic_cast<dtCore::Transformable*>(mShipTarget.get())->GetTransform(objectTransform);
		objectTransform.GetTranslation(objectPosition);
		objectTransform.GetRotation(objectRotation);

		nbearing = ComputeBearingTo2(missilePosition.x(),missilePosition.y(),objectPosition.x(),objectPosition.y());
		nbearing = ValidateDegree(nbearing);
		npitch= GetPitch(missilePosition,objectPosition);

		/*trac.SetDirection(nbearing);
		trac.SetElevation(npitch);*/
	
		static const double RATE = 40 * deltaSimTime;

		/*if (GetTargetBearing()<nbearing){
		trac.SetDirection(trac.GetDirection()+RATE);
		if(trac.GetDirection()>=nbearing)
		trac.SetDirection(nbearing);
		}
		else if (GetTargetBearing()>nbearing){
		trac.SetDirection(trac.GetDirection()-RATE);
		if(trac.GetDirection()<=nbearing)
		trac.SetDirection(nbearing);
		}*/

		trac.SetDirection(nbearing);

		if (GetTargetElev()>npitch){
		trac.SetElevation(trac.GetElevation()-RATE);
		if(trac.GetElevation()<=npitch)
		trac.SetElevation(npitch);
		}
		else if (GetTargetElev()<npitch){
		trac.SetElevation(trac.GetElevation()+RATE);
		if(trac.GetElevation()>=npitch)
		trac.SetElevation(npitch);
		}
		

		SetCurrentSpeed(trac.GetSpeed()*DEF_MACH_TO_METRE);
		SetCurrentHeading(trac.GetDirection());
		missileTransform.SetTranslation(missilePosition);
		missileTransform.SetRotation(missileRotation);
		SetTransform(missileTransform);
	}
	else
	{
		//Send Explode
		dtCore::RefPtr<MsgUtilityAndTools> msgExplode;
		dtGame::GameManager* gm= GetGameActorProxy().GetGameManager();
		dtGame::MessageFactory* mf=&gm->GetMessageFactory();
		mf->CreateMessage(*(mf->GetMessageTypeByName(C_MT_UTILITY_AND_TOOLS)),msgExplode);

		msgExplode->SetOrderID(TIPE_UTIL_EVENT_EXPLODE);
		msgExplode->SetUAT0(CT_STRELA);
		msgExplode->SetUAT1(missilePosition.x());    
		msgExplode->SetUAT2(missilePosition.y());   
		msgExplode->SetUAT3(missilePosition.z()); 

		GetGameActorProxy().GetGameManager()->SendNetworkMessage(*msgExplode.get());
		GetGameActorProxy().GetGameManager()->SendMessage(*msgExplode.get());

		std::cout << "Strella Delete By Miss Target " <<std::endl;	
		UpdateStatusDBEffectTo2D(mMyParent.get(), ST_MISSILE_DEL);

	}
}

void  StrelaRocketActor::MoveCheckMissingTarget()
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
			msgExplode->SetUAT0(CT_STRELA);
			msgExplode->SetUAT1(missilePosition.x());    
			msgExplode->SetUAT2(missilePosition.y());   
			msgExplode->SetUAT3(missilePosition.z()); 

			GetGameActorProxy().GetGameManager()->SendNetworkMessage(*msgExplode.get());
			GetGameActorProxy().GetGameManager()->SendMessage(*msgExplode.get());

			std::cout << "Strella Delete By Miss Target " <<std::endl;	
			UpdateStatusDBEffectTo2D(mMyParent.get(), ST_MISSILE_DEL);

		}
	}
}

void StrelaRocketActor::SearchingTarget()
{	
	std::vector<dtGame::GameActorProxy*> vActors;
	std::vector<dtGame::GameActorProxy*>::iterator iter;
	dtCore::Transformable* actor;
	dtCore::RefPtr<dtCore::DeltaDrawable> TempTarget;

	GetGameActorProxy().GetGameManager()->GetAllGameActors(vActors);   

	for (iter = vActors.begin(); iter < vActors.end(); iter++)
	{
		if (((*iter)->GetActorType().GetName()== C_CN_HELICOPTER ) || ((*iter)->GetActorType().GetName()== C_CN_AIRCRAFT )
			|| ((*iter)->GetActorType().GetName()== C_CN_SHIP ) || ((*iter)->GetActorType().GetName()== C_CN_SUBMARINE)) 
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

				if(IsInCone(missilePosition, objectPosition, missileRotation.x(), missileRotation.y(), 1852, 446)){		
					std::cout<< GetName() << " find target " << actor->GetName() << std::endl;
					jarakHelicopter = GetDistanceCone(missilePosition,objectPosition);
					if (jarakHelicopter<=jarakTarget){
						jarakTarget=jarakHelicopter;
						isFind=true;
						mShipTarget = TempTarget;
					}
				}
			}
		}

	}
}

void StrelaRocketActor::EndOfStrela()
{
	std::cout<<GetName()<<" "<<mMissileID<<" End..."<<std::endl;
	UpdateStatusDBEffectTo2D(mMyParent.get(), ST_MISSILE_DEL);
	SetLaunched(false);
}

void StrelaRocketActor::Blast(osg::Vec3 TargetPos)
{
	mSmoke ->SetEnabled(false);
	UpdateStatusDBEffectTo3DExplode(TargetPos.x(), TargetPos.y(), TargetPos.z() ,ST_MISSILE_EXPLODE);
}

void StrelaRocketActor::OnEnteredWorld()
{
	mSmoke = new dtCore::ParticleSystem();
	mSmoke->LoadFile("missile.osg",true);
	mSmoke->SetEnabled(false);
	GetGameActorProxy().GetActor()->GetOSGNode()->asGroup()->addChild(mSmoke->GetOSGNode());
	GetGameActorProxy().GetActor()->AddChild(mSmoke.get());	 

	missileSound = dtAudio::AudioManager::GetInstance().NewSound();
	missileSound->LoadFile("Sounds/Missile.wav");
	assert(missileSound);
	missileSound->SetMaxDistance(1000.0f);
	missileSound->SetLooping(true);
	AddChild(missileSound.get());

	seekerSound = dtAudio::AudioManager::GetInstance().NewSound();
	seekerSound->LoadFile("Sounds/beep.wav");
	assert(seekerSound);
	seekerSound->SetMaxDistance(1000.0f);
	seekerSound->SetLooping(true);
	AddChild(seekerSound.get());

	MissilesActor::OnEnteredWorld();
}

void StrelaRocketActor::OnRemovedFromWorld()
{
	MissilesActor::OnRemovedFromWorld();
}


StrelaRocketActorProxy::StrelaRocketActorProxy()
{

}

///////////////////////////////////////////////////////////////////////////////
void StrelaRocketActorProxy::BuildPropertyMap()
{
	MissilesActorProxy::BuildPropertyMap();

	StrelaRocketActor* actor = NULL;
	GetActor(actor);

	AddProperty(new dtDAL::FloatActorProperty(C_SET_SPEED,C_SET_SPEED,
		dtDAL::FloatActorProperty::SetFuncType(actor, &StrelaRocketActor::SetCurrentSpeed),
		dtDAL::FloatActorProperty::GetFuncType(actor, &StrelaRocketActor::GetCurrentSpeed), "Sets/gets speed.", C_TYPE_MISSILE));

	AddProperty(new dtDAL::FloatActorProperty(C_SET_HEADING,C_SET_HEADING,
		dtDAL::FloatActorProperty::SetFuncType(actor, &StrelaRocketActor::SetCurrentHeading),
		dtDAL::FloatActorProperty::GetFuncType(actor, &StrelaRocketActor::GetCurrentHeading), "Sets/gets Heading.", C_TYPE_MISSILE));

	AddProperty(new dtDAL::FloatActorProperty("Bearing","Bearing",
		dtDAL::FloatActorProperty::SetFuncType(actor,&StrelaRocketActor::SetTargetBearing),
		dtDAL::FloatActorProperty::GetFuncType(actor,&StrelaRocketActor::GetTargetBearing),
		"Target Bearing", C_TYPE_MISSILE));

	AddProperty(new dtDAL::FloatActorProperty("Range","Range",
		dtDAL::FloatActorProperty::SetFuncType(actor,&StrelaRocketActor::SetTargetRange),
		dtDAL::FloatActorProperty::GetFuncType(actor,&StrelaRocketActor::GetTargetRange),
		"Range", C_TYPE_MISSILE));

	AddProperty(new dtDAL::FloatActorProperty("Elev","Elev",
		dtDAL::FloatActorProperty::SetFuncType(actor,&StrelaRocketActor::SetTargetElev),
		dtDAL::FloatActorProperty::GetFuncType(actor,&StrelaRocketActor::GetTargetElev),
		"ExcRange", C_TYPE_MISSILE));

	AddProperty(new dtDAL::IntActorProperty("IsUnlockToFire","IsUnlockToFire",
		dtDAL::IntActorProperty::SetFuncType(actor, &StrelaRocketActor::SetIsUnlockToFire),
		dtDAL::IntActorProperty::GetFuncType(actor, &StrelaRocketActor::GetIsUnlockToFire), 
		"Sets/gets isUnlockToFire."));
}

///////////////////////////////////////////////////////////////////////////////
void StrelaRocketActorProxy::CreateActor()
{
	SetActor(*new StrelaRocketActor(*this));
}

///////////////////////////////////////////////////////////////////////////////
void StrelaRocketActorProxy::OnEnteredWorld()
{
	MissilesActorProxy::OnEnteredWorld();
	RegisterForMessages(SimMessageType::STRELA_EVENT);
}