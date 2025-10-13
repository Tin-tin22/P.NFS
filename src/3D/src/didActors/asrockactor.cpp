#include "AsrockActor.h"
#include "OceanActor.h"
#include "ShipModelActor.h"
#include "AsrockSpoutActor.h"
#include "didactorssources.h"


///////////////////////////////////////////////////////////////////////////////
AsrockActor::AsrockActor(dtGame::GameActorProxy &proxy) : 
	MissilesActor(proxy), 
       isBlast(false), afterBlast(false),
	   mTargetRange(0), correctRange(0.0f),
	   mBearing(0), mRange(0),
	   ExcRange(0), CorrectRange2D(0.0f),
	   elev(8.5), TimeForPlayer(0.0),
	   phase1(true), phase2(false), phase3(false), isFirst(true), isFirstInPhase2(true)
{
	missileSound = NULL ;
	missileTrail = NULL ;
}

AsrockActor::~AsrockActor()
{
	
}

///////////////////////////////////////////////////////////////////////////////
void AsrockActor::TickLocal(const dtGame::Message &tickMessage)
{
   const dtGame::TickMessage &tick = static_cast<const dtGame::TickMessage&>(tickMessage);
   float deltaSimTime = tick.GetDeltaSimTime();
   TimeForPlayer += deltaSimTime;

   if( isLaunch == true){

	   /*dtCore::RefPtr<dtDAL::ActorProxy> hitTargetProxy= CeckCollision(trac.GetSpeed() * DEF_MACH_TO_METRE, tick.GetDeltaSimTime());
	   if ( hitTargetProxy != NULL ){
		   std::cout<<"Asroc "<< mMissileID <<" collision with "<<hitTargetProxy->GetName()<<std::endl;
		   UpdateStatusDBEffectTo2D(hitTargetProxy->GetActor(), ST_MISSILE_HIT);
		   isBlast= true;
	   }*/

	   //if(TimeForPlayer >= 2.0) //delay untuk player set to the ship
	   Move(deltaSimTime);

	   if ( missileSound != NULL ){
	 	  if ( !missileSound->IsPlaying() ) 
			  missileSound->Play();
	   }

	   if ( missileTrail != NULL ){
		  if ( !missileTrail->IsEnabled() )
		      missileTrail->SetEnabled(true);
	   }
   }
   
   if( isBlast == true ) ExcBlast();
   if( afterBlast == true ) EndOfAsrock();
}

///////////////////////////////////////////////////////////////////////////////
void AsrockActor::TickRemote(const dtGame::Message &tickMessage)
{
   const dtGame::TickMessage &tick = static_cast<const dtGame::TickMessage&>(tickMessage);
}

///////////////////////////////////////////////////////////////////////////////

void AsrockActor::ProcessOrderEvent(const dtGame::Message &message)
{
	const MsgSetAsrock &Msg = static_cast<const MsgSetAsrock&>(message);
	dtCore::RefPtr<dtDAL::ActorProxy> parentProxy = GetShipActorByID(Msg.GetVehicleID());

	if ( parentProxy.valid() )
	{
		if (( !GetLaunched() ) &&  
			( IsMissileValidID( Msg.GetVehicleID(),Msg.GetWeaponID(),Msg.GetLauncherID(),Msg.GetMissileID(),Msg.GetMissileNum() ) ) )
		{
			dtCore::RefPtr<AsrockSpoutActor> Spout = static_cast<AsrockSpoutActor*>(GetParent());
			if ( Msg.GetOrderID() == ORD_ASROCK )
			{
				mMyParent = parentProxy->GetActor();

				if ( Spout.valid() )//&& (Spout->ndistance >= 600) && (Spout->ndistance <= 2350))
				{
					Spout->GetTransform(SpoutTransform);
					SpoutTransform.GetRotation(Heading , Pitch ,Roll);

					elev	= Pitch;
					SetTargetBearing(-Heading);

					TargetID = Msg.GetTargetID();
					CorrectRange2D = Msg.GetCorrectRange();

					SetTargetRange(Spout->ndistance);
					SetVehicleID(Msg.GetVehicleID());
					SetDepth(-Msg.GetTargetDepth());
					SetFuze(Msg.GetMissileFuze());

					TipeFire = Msg.GetMissileType();
					TipeID = TipeFire;

					std::cout << GetName() << " tipefire : " << TipeFire << " , tipeloading : " << TipeLoading << std::endl;

					if (TipeLoading == Errika2 && TipeFire == NellyLow2)
						TipeID = ErrikaLow2 ;
					if (TipeLoading == Errika2 && TipeFire == NellyHigh2)
						TipeID = ErrikaHigh2 ;
					if (TipeLoading == Nelly2 && TipeFire == ErrikaLow2)
						TipeID = NellyLow2 ;
					if (TipeLoading == Nelly2 && TipeFire == ErrikaHigh2)
						TipeID = NellyHigh2 ;				

					//trac.Initialize_Asroc(Spout->TipeID,elev);
					//trac.Initialize_Asroc(Msg.GetMissileType,elev);
					trac.Initialize_Asroc(TipeID,elev);
					t = trac.tnew;

					std::cout << GetName() << " Tipe " << TipeID << " , Elev " << elev << std::endl;

					if ((trac.v0 > 1) && (trac.v0 < 1000) && (trac.v02 > 1) && (trac.v02 < 1000) && (trac.tnew > 0) && (trac.tnew < 1000)){
						AddToEnvironmentActor();
						TrajectoryInitialization();
						SetLaunched(true);
						UpdateStatusDBEffectTo2D(mMyParent.get(),ST_MISSILE_RUN);
						std::cout << "===> Range to target : " <<GetTargetRange() << ", with asroc spout elevation " << elev <<std::endl;

						////Send To Instruktur
						//dtCore::RefPtr<MsgUtilityAndTools> msgForTrac2D;
						//dtGame::GameManager* gm= GetGameActorProxy().GetGameManager();
						//dtGame::MessageFactory* mf=&gm->GetMessageFactory();
						//mf->CreateMessage(*(mf->GetMessageTypeByName(C_MT_UTILITY_AND_TOOLS)),msgForTrac2D);
						//msgForTrac2D->SetOrderID(TIPE_UTIL_TRAC2D);
						//msgForTrac2D->SetUAT0(GetVehicleID());
						//msgForTrac2D->SetUAT1(GetWeaponID());
						//msgForTrac2D->SetUAT2(GetLauncherID());
						//msgForTrac2D->SetUAT3(GetMissileID());
						//msgForTrac2D->SetUAT4(GetMissileNum());
						//msgForTrac2D->SetUAT5(GetTargetRange());
						//GetGameActorProxy().GetGameManager()->SendNetworkMessage(*msgForTrac2D.get());
						//GetGameActorProxy().GetGameManager()->SendMessage(*msgForTrac2D.get());
						int mistrack = 2;

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
					} 
					else{
						std::cout << GetName() <<" Warning calculating" <<std::endl;
						SetLaunched(false);
						UpdateStatusDBEffectTo2D(mMyParent.get(), ST_MISSILE_DEL);
					}	
				}
				else
					std::cout << "Spout or Range not valid" << std::endl;
			}
			else if ( Msg.GetOrderID() == ORD_ASROCK_RELOAD )
			{
				TipeLoading = Msg.GetMissileType();
				std::cout << GetName() << " TipeLoading " << TipeLoading << std::endl;
			}
		}
	}
}

void AsrockActor::ProcessMessage(const dtGame::Message &message)
{
	if(GetGameActorProxy().IsInGM()){

		if(message.GetMessageType().GetName() == SimMessageType::ASROCK_EVENT.GetName())
			ProcessOrderEvent(message);
	}
}

void AsrockActor::SetTargetBearing(float bearing)
{
	mBearing = bearing;
}
void AsrockActor::SetTargetRange(float targetRange)
{
	mTargetRange = targetRange;
}

void AsrockActor::Move(double deltaSimTime)
{
	double PX, PY, PZ, DR, DZ, Pitch;
	PX = missilePosition.x();
	PY = missilePosition.y();
	PZ = missilePosition.z();

	//WindEnviX = WindEnviX + GetWindDirX(); 
	//WindEnviY = WindEnviY + GetWindDirY();

	GetTransform(missileTransform);
	missileTransform.GetTranslation(missilePosition);
	missileTransform.GetRotation(missileRotation);

	if (isFirst==true){		
		missileFirstPos=missilePosition;
		timeAsroc = 0.0;
		isFirst = false;
	}

	mRange =  GetTargetRange();
	ExcRange = GetDistance(missilePosition,missileFirstPos);

	timeAsroc+=deltaSimTime;

	if (timeAsroc <= trac.t2){
		dir = trac.Calc_Movement_Asroc(timeAsroc, missileFirstPos, elev);
		
		//Added Environemnt
		//dir.x() = dir.x() + WindEnviX;
		//dir.y() = dir.y() + WindEnviY;

		missilePosition.x() = dir.x();
		missilePosition.y() = dir.y();
		missilePosition.z() = dir.z();
		
		SetCurrentSpeed(trac.v0);
	}
	else
	{		
		if (missilePosition.z() >= 0.0)
		{
			if ( isFirstInPhase2 )
			{
				std::cout << "phase 2" <<std::endl;
				isFirstInPhase2 = false;
			}

			dir = trac.Calc_Movement_Asroc_2(t,missileFirstPos);

			//Added Environemnt
			//static int a = 1;
			//dir.x() = dir.x() + (WindEnviX * a);
			//dir.y() = dir.y() + (WindEnviY * a);

			missilePosition.x() = dir.x();
			missilePosition.y() = dir.y();
			missilePosition.z() = dir.z();

		}
		else
		{
			//std::cout << missilePosition.z() << std::endl;
			static double vIn= 9.2 * deltaSimTime;
			//std::cout << vIn << std::endl;
			missilePosition.z() -= vIn;
			//std::cout << missilePosition.z() << std::endl; 
		}

		t += deltaSimTime;
		SetCurrentSpeed(trac.v02);
	}

	if (missilePosition.z()<=GetDepth()) isBlast = true;

	DR = Range3D(missilePosition.x(), missilePosition.y(), 0, PX, PY, 0);
	DZ = missilePosition.z() - PZ;
	Pitch = c_RadToDeg * (atan2(DZ, DR));

	trac.SetElevation(Pitch);

	missileRotation[0] = -trac.GetDirection();
	missileRotation[1] = trac.GetElevation();
	missileRotation[2] = 0.0f;
	
	SetCurrentHeading(trac.GetDirection());
	missileTransform.SetTranslation(missilePosition);
	missileTransform.SetRotation(missileRotation);
	SetTransform(missileTransform);
}
 
void AsrockActor::TrajectoryInitialization()
{
	trac.SetDirection(GetTargetBearing());
	trac.Set_v0_Asroc(trac.v0);
}

void AsrockActor::EndOfAsrock()
{
	std::cout << "===> Asroc will end on range " << ExcRange << " from ownship, h = " << missilePosition.z() << std::endl;
	std::cout << "===> Error Range : " << fabs(ExcRange - GetTargetRange()) << ", t = " << t <<std::endl;
	UpdateStatusDBEffectTo2D(mMyParent.get(),ST_MISSILE_DEL);
	//std::cout<<GetName()<<" "<<mMissileID<<" End..."<<std::endl;
}

void AsrockActor::ExcBlast()
{
	dtCore::RefPtr<dtDAL::ActorProxy> hitTargetProxy= GetShipActorByID(TargetID);
	if ( hitTargetProxy != NULL ){
		std::cout<<"Asroc "<< mMissileID <<" detect "<<hitTargetProxy->GetName()<<std::endl;
		UpdateStatusDBEffectTo2D(hitTargetProxy->GetActor(), ST_MISSILE_HIT, GetMissileLethality());
	}

	osg::Vec3 pos = GetGameActorProxy().GetTranslation() ;
	UpdateStatusDBEffectTo3DExplode(pos.x(),pos.y(),pos.z(),ST_MISSILE_EXPLODE);
	afterBlast = true ;
}

void AsrockActor::OnEnteredWorld()
{
	missileTrail = new dtCore::ParticleSystem();
	missileTrail->LoadFile("trailasroc.osg",true);
	//missileTrail->LoadFile("missile.osg",true);
	missileTrail->SetEnabled(false);
	AddChild(missileTrail.get());	 

	missileSound = dtAudio::AudioManager::GetInstance().NewSound();
	missileSound->LoadFile("Sounds/Missile.wav");
	assert(missileSound);
	missileSound->SetMaxDistance(1000.0f);
	missileSound->SetLooping(true);
	AddChild(missileSound.get());

	MissilesActor::OnEnteredWorld();
}

void AsrockActor::OnRemovedFromWorld()
{
	MissilesActor::OnRemovedFromWorld();
}

 
AsrockActorProxy::AsrockActorProxy()
{

}

///////////////////////////////////////////////////////////////////////////////
void AsrockActorProxy::BuildPropertyMap()
{
	MissilesActorProxy::BuildPropertyMap();

	AsrockActor* actor = NULL;
	GetActor(actor);

	AddProperty(new dtDAL::FloatActorProperty(C_SET_SPEED,C_SET_SPEED,
		dtDAL::FloatActorProperty::SetFuncType(actor, &AsrockActor::SetCurrentSpeed),
		dtDAL::FloatActorProperty::GetFuncType(actor, &AsrockActor::GetCurrentSpeed), "Sets/gets speed.", C_TYPE_MISSILE));

	AddProperty(new dtDAL::FloatActorProperty(C_SET_HEADING,C_SET_HEADING,
		dtDAL::FloatActorProperty::SetFuncType(actor, &AsrockActor::SetCurrentHeading),
		dtDAL::FloatActorProperty::GetFuncType(actor, &AsrockActor::GetCurrentHeading), "Sets/gets Heading.", C_TYPE_MISSILE));

	AddProperty(new dtDAL::FloatActorProperty("Bearing","Bearing",
		dtDAL::FloatActorProperty::SetFuncType(actor,&AsrockActor::SetTargetBearing),
		dtDAL::FloatActorProperty::GetFuncType(actor,&AsrockActor::GetTargetBearing),
		"Target Bearing", C_TYPE_MISSILE));

	AddProperty(new dtDAL::FloatActorProperty("Range","Range",
		dtDAL::FloatActorProperty::SetFuncType(actor,&AsrockActor::SetTargetRange),
		dtDAL::FloatActorProperty::GetFuncType(actor,&AsrockActor::GetTargetRange),
		"Range", C_TYPE_MISSILE));

	AddProperty(new dtDAL::FloatActorProperty("ExcRange","ExcRange",
		dtDAL::FloatActorProperty::SetFuncType(actor,&AsrockActor::SetExcRange),
		dtDAL::FloatActorProperty::GetFuncType(actor,&AsrockActor::GetExcRange),
		"ExcRange", C_TYPE_MISSILE));

	AddProperty(new dtDAL::DoubleActorProperty("Elev","Elev",
		dtDAL::DoubleActorProperty::SetFuncType(actor,&AsrockActor::SetElev),
		dtDAL::DoubleActorProperty::GetFuncType(actor,&AsrockActor::GetElev),
		"Elev", C_TYPE_MISSILE));

	AddProperty(new dtDAL::BooleanActorProperty("IsBlast","IsBlast",
		dtDAL::BooleanActorProperty::SetFuncType(actor,&AsrockActor::SetisBlast),
		dtDAL::BooleanActorProperty::GetFuncType(actor,&AsrockActor::GetisBlast),
		"IsBlast", C_TYPE_MISSILE));

	AddProperty(new dtDAL::BooleanActorProperty("afterBlast","afterBlast",
		dtDAL::BooleanActorProperty::SetFuncType(actor,&AsrockActor::SetafterBlast),
		dtDAL::BooleanActorProperty::GetFuncType(actor,&AsrockActor::GetafterBlast),
		"afterBlast", C_TYPE_MISSILE));
}

///////////////////////////////////////////////////////////////////////// //////
void AsrockActorProxy::CreateActor()
{
   SetActor(*new AsrockActor(*this));
}

///////////////////////////////////////////////////////////////////////////////
void AsrockActorProxy::OnEnteredWorld()
{
	MissilesActorProxy::OnEnteredWorld();
	RegisterForMessages(SimMessageType::ASROCK_EVENT);
}