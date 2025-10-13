#include "MistralRocketActor.h"
#include "didactorssources.h"
#include "OceanActor.h"
#include "ShipModelActor.h"
#include "MistralSpoutActor.h"
#include "helicopteractor.h"
#include "aircraftactor.h"
#include <dtGame/gamemanager.h>
#include <dtGame/gmcomponent.h>

//++ Constants
const float MistralRocketActor::MAX_RANGE = 5300.0f;       //Maximum Range (meter)
const float MistralRocketActor::MAX_PITCH = -15.0f;       //Maximum Elev (degree)
const float MistralRocketActor::MIN_PITCH = 89.9f;       //Minimum Elev (degree)
//-- Constants

///////////////////////////////////////////////////////////////////////////////
MistralRocketActor::MistralRocketActor(dtGame::GameActorProxy &proxy) : 
	MissilesActor(proxy), 
       mSmoke(false), mSmokeStatus(false), isFind(false), isFirst(true),isSeekerFind(false), 
	   ExcRange(0), jarakHelicopter(0), jarakTarget(10000000.0f), isUnlockToFire(0),
	   nbearing(0), npitch(0), lifeTime(0.f), mShipTarget(NULL)
{}

MistralRocketActor::~MistralRocketActor()
{	
}

///////////////////////////////////////////////////////////////////////////////
void MistralRocketActor::TickLocal(const dtGame::Message &tickMessage)
{
   const dtGame::TickMessage &tick = static_cast<const dtGame::TickMessage&>(tickMessage);
   float deltaSimTime = tick.GetDeltaSimTime();
   
   if( mSmokeStatus == true){
	   if ( mSmoke->IsEnabled() ){}
	   else mSmoke->SetEnabled(true);
   }

   if ( isUnlockToFire == 1 )
   {
	   dtCore::RefPtr<MistralSpoutActor> Spout = static_cast<MistralSpoutActor*>(GetParent());
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

   if( isLaunch == true)
   {
	   if ( GetGameActorProxy().GetGameManager()->GetMachineInfo().GetName() == C_MACHINE_SERVER )
		   CeckCollisionRocket();

	   Move(deltaSimTime);
	   
	   lifeTime += deltaSimTime;
	   if (lifeTime > 30)
	   {
		   UpdateStatusDBEffectTo2D(mMyParent.get(), ST_MISSILE_DEL);
		   std::cout << "Mistral Delete By Effective Time " <<std::endl;
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
void MistralRocketActor::TickRemote(const dtGame::Message &tickMessage)
{
   const dtGame::TickMessage &tick = static_cast<const dtGame::TickMessage&>(tickMessage);
}

///////////////////////////////////////////////////////////////////////////////

void MistralRocketActor::ProcessOrderEvent(const dtGame::Message &message)
{
	const MsgSetMistral &Msg = static_cast<const MsgSetMistral&>(message);
	dtCore::RefPtr<dtDAL::ActorProxy> parentProxy = GetShipActorByID(Msg.GetVehicleID());
	if ( parentProxy.valid() )
	{
		OwnShipProxy = parentProxy;
		dtCore::RefPtr<VehicleActor> parent = static_cast<VehicleActor*>(parentProxy->GetActor());
		if (( !GetLaunched() ) &&  
			( IsMissileValidID( Msg.GetVehicleID(),Msg.GetWeaponID(),Msg.GetLauncherID(),Msg.GetMissileID(),Msg.GetMissileNum() ) ) )
			switch (Msg.GetOrderID()){
			case ORD_MISTRAL_FIRE : 
				{
					mMyParent = parentProxy->GetActor();
					static float h,p,r;

					MistralSpoutActor* SpoutAct = dynamic_cast<MistralSpoutActor*>(GetParent());
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
				
					break;
				}
			case ORD_MISTRAL_STATUS_UNLOCK :
				{
					isUnlockToFire = 1;
					break;
				}
			case ORD_MISTRAL_STATUS_LOCK :
				{
					isUnlockToFire = 0;
					break;
				}
		}
	}
}

void MistralRocketActor::SetTrac(){
	trac.SetDirection(GetTargetBearing());
	trac.SetElevation(GetTargetElev());
	trac.SetSpeed(500/DEF_MACH_TO_METRE);

	std::cout << "bearing awal : " << trac.GetDirection() << std::endl;
	std::cout << "pitch awal : " << trac.GetElevation() << std::endl;
}

void MistralRocketActor::ProcessMessage(const dtGame::Message &message)
{
	if(GetGameActorProxy().IsInGM()){

		if(message.GetMessageType().GetName() == SimMessageType::MISTRAL_EVENT.GetName())
			ProcessOrderEvent(message);
	}
}

void MistralRocketActor::CeckCollisionRocket()
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
			|| ((*iter)->GetActorType().GetName()== C_CN_SHIP ) || ((*iter)->GetActorType().GetName()== C_CN_SUBMARINE ) )
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
					std::cout<<"Tetral "<< mMissileID <<" hit "<<actor->GetName()<<std::endl;
					UpdateStatusDBEffectTo2D(actor, ST_MISSILE_HIT, GetMissileLethality());
					Blast(TargetPosition);
					EndOfMistral();
				}
			}
		}
	}
}

void MistralRocketActor::SetTargetBearing(float bearing)
{
	mBearing = bearing;
}
void MistralRocketActor::SetTargetRange(float targetRange)
{
	mTargetRange = targetRange;
}
void MistralRocketActor::SetTargetElev(float elev)
{
	mElev = elev;
}
void MistralRocketActor::SetIsUnlockToFire(int val)
{
	isUnlockToFire = val;
}

void MistralRocketActor::Move(double deltaSimTime)
{
	static osg::Vec3 dir;

	/*trac.Calc_Speed(deltaSimTime);
	trac.Calc_Direction(deltaSimTime);
	trac.Calc_Elevation(deltaSimTime);*/
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
		isFirst = false;
	}

	ExcRange = GetDistance(missilePosition,missileFirstPos);
	if (ExcRange >= MAX_RANGE) {
		UpdateStatusDBEffectTo2D(mMyParent.get(), ST_MISSILE_DEL);
		std::cout << "Mistral Delete By Effective Range " <<std::endl;
	}

	if (isFind == false)
		SearchingTarget();
	else
	{
		MovetoTarget(deltaSimTime);
		MoveCheckMissingTarget();
	}

	SetCurrentSpeed(trac.GetSpeed()*DEF_MACH_TO_METRE);
	SetCurrentHeading(trac.GetDirection());
	missileTransform.SetTranslation(missilePosition);
	missileTransform.SetRotation(missileRotation);
	SetTransform(missileTransform);
}

void MistralRocketActor::MovetoTarget(double deltaSimTime)
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
		msgExplode->SetUAT0(CT_MISTRAL);
		msgExplode->SetUAT1(missilePosition.x());    
		msgExplode->SetUAT2(missilePosition.y());   
		msgExplode->SetUAT3(missilePosition.z()); 

		GetGameActorProxy().GetGameManager()->SendNetworkMessage(*msgExplode.get());
		GetGameActorProxy().GetGameManager()->SendMessage(*msgExplode.get());

		std::cout << "Mistral Delete By Miss Target " <<std::endl;	
		UpdateStatusDBEffectTo2D(mMyParent.get(), ST_MISSILE_DEL);

	}
}

void MistralRocketActor::MoveCheckMissingTarget()
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
			msgExplode->SetUAT0(CT_MISTRAL);
			msgExplode->SetUAT1(missilePosition.x());    
			msgExplode->SetUAT2(missilePosition.y());   
			msgExplode->SetUAT3(missilePosition.z()); 

			GetGameActorProxy().GetGameManager()->SendNetworkMessage(*msgExplode.get());
			GetGameActorProxy().GetGameManager()->SendMessage(*msgExplode.get());

			std::cout << "Mistral Delete By Missed Target " <<std::endl;	
			UpdateStatusDBEffectTo2D(mMyParent.get(), ST_MISSILE_DEL);
			
		}
	}
}

void MistralRocketActor::SearchingTarget()
{	
	std::vector<dtGame::GameActorProxy*> vActors;
	std::vector<dtGame::GameActorProxy*>::iterator iter;
	dtCore::Transformable* actor;
	dtCore::RefPtr<dtCore::DeltaDrawable> TempTarget;

	GetGameActorProxy().GetGameManager()->GetAllGameActors(vActors);   

	for (iter = vActors.begin(); iter < vActors.end(); iter++)
	{
		if (((*iter)->GetActorType().GetName()== C_CN_HELICOPTER ) || ((*iter)->GetActorType().GetName()== C_CN_AIRCRAFT ) 
			|| ((*iter)->GetActorType().GetName()== C_CN_SHIP ) || ((*iter)->GetActorType().GetName()== C_CN_SUBMARINE) ) 
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

void MistralRocketActor::EndOfMistral()
{
	std::cout<<GetName()<<" "<<mMissileID<<" End..."<<std::endl;
	UpdateStatusDBEffectTo2D(mMyParent.get(), ST_MISSILE_DEL);
	SetLaunched(false);
}

void MistralRocketActor::Blast(osg::Vec3 TargetPos)
{
	mSmoke ->SetEnabled(false);
	UpdateStatusDBEffectTo3DExplode(TargetPos.x(), TargetPos.y(), TargetPos.z() ,ST_MISSILE_EXPLODE);
}

void MistralRocketActor::OnEnteredWorld()
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

void MistralRocketActor::OnRemovedFromWorld()
{
	MissilesActor::OnRemovedFromWorld();
}

 
MistralRocketActorProxy::MistralRocketActorProxy()
{

}

///////////////////////////////////////////////////////////////////////////////
void MistralRocketActorProxy::BuildPropertyMap()
{
	MissilesActorProxy::BuildPropertyMap();

	MistralRocketActor* actor = NULL;
	GetActor(actor);

	AddProperty(new dtDAL::FloatActorProperty(C_SET_SPEED,C_SET_SPEED,
		dtDAL::FloatActorProperty::SetFuncType(actor, &MistralRocketActor::SetCurrentSpeed),
		dtDAL::FloatActorProperty::GetFuncType(actor, &MistralRocketActor::GetCurrentSpeed), "Sets/gets speed.", C_TYPE_MISSILE));

	AddProperty(new dtDAL::FloatActorProperty(C_SET_HEADING,C_SET_HEADING,
		dtDAL::FloatActorProperty::SetFuncType(actor, &MistralRocketActor::SetCurrentHeading),
		dtDAL::FloatActorProperty::GetFuncType(actor, &MistralRocketActor::GetCurrentHeading), "Sets/gets Heading.", C_TYPE_MISSILE));

	AddProperty(new dtDAL::FloatActorProperty("Bearing","Bearing",
		dtDAL::FloatActorProperty::SetFuncType(actor,&MistralRocketActor::SetTargetBearing),
		dtDAL::FloatActorProperty::GetFuncType(actor,&MistralRocketActor::GetTargetBearing),
		"Target Bearing", C_TYPE_MISSILE));

	AddProperty(new dtDAL::FloatActorProperty("Range","Range",
		dtDAL::FloatActorProperty::SetFuncType(actor,&MistralRocketActor::SetTargetRange),
		dtDAL::FloatActorProperty::GetFuncType(actor,&MistralRocketActor::GetTargetRange),
		"Range", C_TYPE_MISSILE));

	AddProperty(new dtDAL::FloatActorProperty("Elev","Elev",
		dtDAL::FloatActorProperty::SetFuncType(actor,&MistralRocketActor::SetTargetElev),
		dtDAL::FloatActorProperty::GetFuncType(actor,&MistralRocketActor::GetTargetElev),
		"ExcRange", C_TYPE_MISSILE));

	AddProperty(new dtDAL::IntActorProperty("IsUnlockToFire","IsUnlockToFire",
		dtDAL::IntActorProperty::SetFuncType(actor, &MistralRocketActor::SetIsUnlockToFire),
		dtDAL::IntActorProperty::GetFuncType(actor, &MistralRocketActor::GetIsUnlockToFire), 
		"Sets/gets isUnlockToFire."));
}

///////////////////////////////////////////////////////////////////////////////
void MistralRocketActorProxy::CreateActor()
{
   SetActor(*new MistralRocketActor(*this));
}

///////////////////////////////////////////////////////////////////////////////
void MistralRocketActorProxy::OnEnteredWorld()
{
	MissilesActorProxy::OnEnteredWorld();
	RegisterForMessages(SimMessageType::MISTRAL_EVENT);
}