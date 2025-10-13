#include "RBUActor.h"
#include "OceanActor.h"
#include "ShipModelActor.h"
#include "RBUspoutactor.h"
#include "didactorssources.h"
#include <math.h>

///////////////////////////////////////////////////////////////////////////////
RBUActor::RBUActor(dtGame::GameActorProxy &proxy) : MissilesActor(proxy),
	   isBlast(false), afterBlast(false), mSmoke(false), isFirst(true), first(true),
	   mTargetRange(0), t(0.0f), 
	   mBearing(0), mRange(0), selisih(0.0f),
	   ExcRange(0), elev (0)
{}

RBUActor::~RBUActor(){}
 
///////////////////////////////////////////////////////////////////////////////
void RBUActor::TickLocal(const dtGame::Message &tickMessage)
{
	const dtGame::TickMessage &tick = static_cast<const dtGame::TickMessage&>(tickMessage);
	float deltaSimTime = tick.GetDeltaSimTime();
   
	if( mSmokeStatus == true){
	   if ( mSmoke->IsEnabled() ){}
	   else mSmoke->SetEnabled(true);
	}

	if( isLaunch == true)
	{
		/*if ( GetGameActorProxy().GetGameManager()->GetMachineInfo().GetName() == C_MACHINE_SERVER )
		{
			dtCore::RefPtr<dtDAL::ActorProxy> hitTargetProxy= CeckCollision(trac.GetSpeed() * DEF_MACH_TO_METRE, tick.GetDeltaSimTime());
			if ( hitTargetProxy != NULL ){
				std::cout<<"RBU "<< mMissileID <<" collision with "<<hitTargetProxy->GetName()<<std::endl;
				UpdateStatusDBEffectTo2D(hitTargetProxy->GetActor(), ST_MISSILE_HIT);
				isBlast= true;
			}
		}*/

		Move(deltaSimTime);
		
		//Sound Effect
		if ( missileSound != NULL ){
			if ( !missileSound->IsPlaying() ) 
				missileSound->Play();
		}
	}
   
	if( isBlast == true )ExcBlast();
	if( afterBlast == true ) EndOfRBU();
}

///////////////////////////////////////////////////////////////////////////////
void RBUActor::TickRemote(const dtGame::Message &tickMessage)
{
   const dtGame::TickMessage &tick = static_cast<const dtGame::TickMessage&>(tickMessage);
}

///////////////////////////////////////////////////////////////////////////////

void RBUActor::ProcessOrderEvent(const dtGame::Message &message)
{
	const MsgSetRBU &Msg = static_cast<const MsgSetRBU&>(message);
	dtCore::RefPtr<dtDAL::ActorProxy> parentProxy = GetShipActorByID(Msg.GetVehicleID());
	
	if (( !GetLaunched() ) &&  
		( IsMissileValidID( Msg.GetVehicleID(),Msg.GetWeaponID(),Msg.GetLauncherID(),Msg.GetMissileID(),Msg.GetMissileNum() ) ) )
	{
		if  (Msg.GetOrderID() == ORD_RBU_FIRE)
		{
			mMyParent = parentProxy->GetActor();

			dtCore::RefPtr<RBUSpoutActor> Spout = static_cast<RBUSpoutActor*>(GetParent());
			if ( Spout.valid() )//&& (Spout->ndistance >= 500) && (Spout->ndistance <= 5500))
			{
				static dtCore::Transform SpoutTransform;
				Spout->GetTransform(SpoutTransform);

				float Heading ,Pitch ,Roll;
				SpoutTransform.GetRotation(Heading , Pitch ,Roll);

				elev	= Pitch + Msg.GetCorrectElev();
				//SetTargetBearing(-Heading + Msg.GetCorrectBearing());
				SetTargetBearing(Msg.GetTargetBearing() + Msg.GetCorrectBearing());

				TargetID = Msg.GetTargetID();
				SetTargetRange(Msg.GetTargetRange());

				std::cout << "ndistance : " << GetTargetRange() << std::endl;
				std::cout << "Pitch : " << Pitch << ", Bearing : " << Msg.GetTargetBearing() << ", Heading : " << -Heading << std::endl;
				SetVehicleID(Msg.GetVehicleID());
				SetDepth(-Msg.GetTargetDepth());

				mSmoke->SetEnabled(true);

				trac.Initialize_RBU(Msg.GetMissileType(),elev,GetTargetRange());
				t = trac.tnew;

				/*AddToEnvironmentActor();
				TrajectoryInitialization();
				isLaunch = true;*/

				if ((trac.v0 > 1) && (trac.v0 < 1000)){
					AddToEnvironmentActor();
					TrajectoryInitialization();
					isLaunch = true;
					
					int mistrack = 6;
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
					isLaunch = false;
					std::cout << GetName() <<" Warning calculating, missile must del" <<std::endl;
					UpdateStatusDBEffectTo2D(mMyParent.get(), ST_MISSILE_DEL);
				}
								
				//UpdateStatusDBEffectTo2D(mMyParent.get(),ST_MISSILE_RUN);
			}
			
			else
				std::cout << "RBU Spout Not Found" << std::endl;
		}
	}	
}

void RBUActor::ProcessMessage(const dtGame::Message &message)
{
	if(GetGameActorProxy().IsInGM()){

		if(message.GetMessageType().GetName() == SimMessageType::RBU_EVENT.GetName())
			ProcessOrderEvent(message);
	}
}


void RBUActor::SetTargetBearing(float bearing)
{
	mBearing = bearing;
}
void RBUActor::SetTargetRange(float targetRange)
{
	mTargetRange = targetRange;
}

void RBUActor::Move(double deltaSimTime)
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
		dir = trac.Calc_Movement_RBU(timeAsroc, missileFirstPos, elev);

		//Added Environemnt
		//dir.x() = dir.x() + WindEnviX;
		//dir.y() = dir.y() + WindEnviY;

		missilePosition.x() = dir.x();
		missilePosition.y() = dir.y();
		missilePosition.z() = dir.z();
		SetCurrentSpeed(trac.v0);

		tempPoint = missilePosition;
	}
	else{
		if (first == true)
		{
			tempPoint2.x() = missileFirstPos.x() + (trac.v02 * cos (trac.elev2 * c_DegToRad) * t * sin(trac.GetDirection() * c_DegToRad));
			tempPoint2.y() = missileFirstPos.y() + (trac.v02 * cos (trac.elev2 * c_DegToRad) * t * cos(trac.GetDirection() * c_DegToRad));
			tempPoint2.z() = 0;

			selisih= abs(GetDistance(tempPoint, tempPoint2));
			std::cout << "konstanta selisih : " << selisih << std::endl;

			first=false;
		}

		if (missilePosition.z() >= 0.0){
			dir = trac.Calc_Movement_RBU_2(t,missileFirstPos,selisih);

			//Added Environemnt
			//dir.x() = dir.x() + WindEnviX;
			//dir.y() = dir.y() + WindEnviY;

			missilePosition.x() = dir.x();
			missilePosition.y() = dir.y();
			missilePosition.z() = dir.z();
		}
		else
		{
			static double vIn= 11.6 * deltaSimTime;
			missilePosition.z() -= vIn;
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
 
void RBUActor::TrajectoryInitialization()
{
	trac.SetDirection(GetTargetBearing());
	trac.Set_v0_RBU(trac.v0);
}

void RBUActor::EndOfRBU()
{
	//std::cout << "===> RBU will end on range " << ExcRange << " from ownship, h = " << missilePosition.z() << std::endl;
	std::cout << "===> Error Range : " << fabs(ExcRange - GetTargetRange()) << ", t = " << t << "Range : " <<ExcRange << std::endl;
	std::cout << missilePosition << std::endl;
	UpdateStatusDBEffectTo2D(mMyParent.get(), ST_MISSILE_DEL);
}

void RBUActor::ExcBlast()
{
	dtCore::RefPtr<dtDAL::ActorProxy> hitTargetProxy= GetShipActorByID(TargetID);
	if ( hitTargetProxy != NULL ){
		std::cout<<"RBU "<< mMissileID <<" detect "<<hitTargetProxy->GetName()<<std::endl;
		UpdateStatusDBEffectTo2D(hitTargetProxy->GetActor(), ST_MISSILE_HIT, GetMissileLethality());
	}

	osg::Vec3 pos = GetGameActorProxy().GetTranslation() ;
	UpdateStatusDBEffectTo3DExplode(pos.x(),pos.y(),pos.z(),ST_MISSILE_EXPLODE);
	afterBlast = true ;
}

void RBUActor::OnEnteredWorld()
{
	mSmoke = new dtCore::ParticleSystem();
	mSmoke->LoadFile("trailrbu.osg",true);
	mSmoke->SetEnabled(false);
	AddChild(mSmoke.get());

	missileSound = dtAudio::AudioManager::GetInstance().NewSound();
	missileSound->LoadFile("Sounds/Missile.wav");
	assert(missileSound);
	missileSound->SetMaxDistance(1000.0f);
	missileSound->SetLooping(true);
	AddChild(missileSound.get());

	MissilesActor::OnEnteredWorld();
}

void RBUActor::OnRemovedFromWorld()
{
	MissilesActor::OnRemovedFromWorld();
}

RBUActorProxy::RBUActorProxy()
{

}

///////////////////////////////////////////////////////////////////////////////
void RBUActorProxy::BuildPropertyMap()
{
	const std::string GROUP = C_TYPE_MISSILE;
	MissilesActorProxy::BuildPropertyMap();

   RBUActor* actor = NULL;
   GetActor(actor);

   //property model
   AddProperty(new dtDAL::FloatActorProperty(C_SET_SPEED,C_SET_SPEED,
		dtDAL::FloatActorProperty::SetFuncType(actor, &RBUActor::SetCurrentSpeed),
		dtDAL::FloatActorProperty::GetFuncType(actor, &RBUActor::GetCurrentSpeed), "Sets/gets speed.", GROUP));

   AddProperty(new dtDAL::FloatActorProperty(C_SET_HEADING,C_SET_HEADING,
		dtDAL::FloatActorProperty::SetFuncType(actor, &RBUActor::SetCurrentHeading),
		dtDAL::FloatActorProperty::GetFuncType(actor, &RBUActor::GetCurrentHeading), "Sets/gets Heading.", GROUP));

}

///////////////////////////////////////////////////////////////////////////////
void RBUActorProxy::CreateActor()
{
   SetActor(*new RBUActor(*this));
}

///////////////////////////////////////////////////////////////////////////////
void RBUActorProxy::OnEnteredWorld()
{
	MissilesActorProxy::OnEnteredWorld();
	RegisterForMessages(SimMessageType::RBU_EVENT);
}

