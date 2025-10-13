#include "CannonMissileactor.h"
#include "didactorssources.h"
#include "ShipModelActor.h"
#include "cannonspoutactor.h"
#include "../didUtils/utilityfunctions.h"

//============================================================================================
CannonMissileActor::CannonMissileActor(dtGame::GameActorProxy &proxy)
	: MissilesActor(proxy),
	FisBlast(false),
	isValid(false),
	LifeTime(0),
	BalistikMode(0),
	Gun_76_TimeMax(0),
	Gun_76_HeightMax(0),
	Gun_76_RangeMax(0),
	Gun_76_Time(0),
	V0X(0),
	V0Y(0)
{

}

void CannonMissileActor::CheckMissileUnderWater()
{
	static dtCore::Transform missileTransform;
	static osg::Vec3 missilePosition;

	GetTransform(missileTransform);
	missileTransform.GetTranslation(missilePosition);

	if ( missilePosition.z() < 0 )
	{
		DestroyCannonMissile();
	}

}

void CannonMissileActor::TickLocal(const dtGame::Message &tickMessage)
{
	const dtGame::TickMessage &tick = static_cast<const dtGame::TickMessage&>(tickMessage);
	float deltaSimTime = tick.GetDeltaSimTime();

	if(GetGameActorProxy().IsInGM())
	{	
		if( isLaunch == true )
		{
			//Moving
			Move(tick.GetDeltaSimTime());

			//Detect Collision
			/*if ( GetGameActorProxy().GetGameManager()->GetMachineInfo().GetName() == C_MACHINE_SERVER )
			{
				dtCore::RefPtr<dtDAL::ActorProxy> hitTargetProxy= CeckCollision(trac.GetSpeed() * DEF_MACH_TO_METRE, tick.GetDeltaSimTime());
				if ( hitTargetProxy != NULL )
				{
					std::cout << GetName() << " hit " << hitTargetProxy->GetName() <<std::endl; 
					UpdateStatusDBEffectTo2D(hitTargetProxy->GetActor(),ST_MISSILE_HIT);
					CannonBlast(hitTargetProxy.get());
					FisBlast= true;
				}
			}*/

			LifeTime += tick.GetDeltaSimTime();
			if (LifeTime >= 120.0f)
			{
				FisBlast= true;
			}

			if ( GetGameActorProxy().GetGameManager()->GetMachineInfo().GetName() == C_MACHINE_SERVER )
			{
				if( FisBlast == true)
				{
					DestroyCannonMissile();
				}
			}
		}
	}
}

void CannonMissileActor::Move(double aDt)
{
	static dtCore::Transform missileTransform;
	static osg::Vec3 missilePosition, missileRotation;

	//Get
	GetTransform(missileTransform);
	missileTransform.GetTranslation(missilePosition);
	missileTransform.GetRotation(missileRotation);	

	/* Calc PITCH */
	double PX, PY, PZ, DR, DZ, Pitch;
	PX = dir.x();
	PY = dir.y();
	PZ = dir.z();

	if ( mWeaponID == CT_CANNON_76 )
	{ 
		if ( BalistikMode == 0 )
		{
			//Low balistik
			dir = trac.Calc_Movement_CannonProjectile_76Low_byElev(LifeTime, FirstLaunchPoint, LauncherElev, Gun_76_HeightMax, Gun_76_TimeMax );
		}
		else
		{
			//High balistik
			dir = trac.Calc_Movement_CannonProjectile_76High_byElev(LifeTime, FirstLaunchPoint, LauncherElev, Gun_76_RangeMax, Gun_76_HeightMax, Gun_76_TimeMax, Gun_76_Time);
		}
	}
	else
	if (( mWeaponID == CT_CANNON_40 ) ||
		( mWeaponID == CT_CANNON_57 ))
	{
		dir = trac.Calc_Movement_CannonProjectile_40_byElev(LifeTime, FirstLaunchPoint, LauncherElev, V0X, V0Y);
	}
	else
	if ( mWeaponID == CT_CANNON_120 )
	{
		dir = trac.Calc_Movement_CannonProjectile_120_byElev(LifeTime, FirstLaunchPoint, LauncherElev, V0X, V0Y);
	}

	if ( missilePosition.z() < 0 )
	{
		FisBlast = true;
		std::cout << "Destroy By Hit Ocean" << std::endl;
		UpdateStatusDBEffectTo3DExplode(missilePosition.x(), missilePosition.y(), 4 ,ST_MISSILE_EXPLODE);
	}

	missilePosition.x() = dir.x();
	missilePosition.y() = dir.y();
	missilePosition.z() = dir.z();

	missileRotation[0] = -trac.GetDirection();
	missileRotation[1] = trac.GetElevation();
	missileRotation[2] = 0.0f;

	/* Calc PITCH */
	DR = Range3D(dir.x(), dir.y(), 0, PX, PY, 0);
	DZ = dir.z() - PZ;
	Pitch = c_RadToDeg * (atan2(DZ, DR));
	trac.SetElevation(Pitch);

	SetCurrentSpeed(trac.GetSpeed() * DEF_MACH_TO_METRE);
	SetCurrentHeading(trac.GetDirection());

	missileTransform.SetTranslation(missilePosition);
	missileTransform.SetRotation(missileRotation);

	SetTransform(missileTransform);
}

void CannonMissileActor::TickRemote(const dtGame::Message &tickMessage)
{
	const dtGame::TickMessage &tick = static_cast<const dtGame::TickMessage&>(tickMessage);
}
void CannonMissileActor::ProcessMessage(const dtGame::Message &message)
{
	if(GetGameActorProxy().IsInGM())
	{
		if(message.GetMessageType().GetName() == SimMessageType::CANNON_EVENT.GetName())
		{
			ProcessOrderEvent(message);
		}
	}
}

void CannonMissileActor::OnEnteredWorld()
{
	//Smoke Effect
	mSmoke = new dtCore::ParticleSystem();
	mSmoke->LoadFile(C_PARTICLES_MISSILE,true);
	mSmoke->SetEnabled(false);
	AddChild(mSmoke.get());

	MissilesActor::OnEnteredWorld();
}

void CannonMissileActor::OnRemovedFromWorld()
{
	std::cout<<GetName()<<" Remove from the world"<<std::endl;
	RemoveSender(&(GetGameActorProxy().GetGameManager()->GetScene()));
}

void CannonMissileActor::ProcessOrderEvent(const dtGame::Message &message)
{
	const MsgSetCannon &Msg = static_cast<const MsgSetCannon&>(message);
	int vhcID = (int) Msg.GetVehicleID();
	dtCore::RefPtr<dtDAL::ActorProxy> parentProxy = GetShipActorByID(vhcID);
	isValid = false;

	dtCore::RefPtr<VehicleActor> parent = static_cast<VehicleActor*>(parentProxy->GetActor());

	if (( !GetLaunched() ) &&  
		( IsMissileValidID( Msg.GetVehicleID(),Msg.GetWeaponID(),Msg.GetLauncherID(),Msg.GetMissileID(),Msg.GetMissileNum() ) ) )
	{
	    if (Msg.GetOrderID() == ORD_CANNON_F)
		{
			dtCore::RefPtr<dtGame::GameActor> Spout = static_cast<dtGame::GameActor*>(GetParent());
			if ( Spout.valid() )
			{
				static dtCore::Transform CannonSpoutTransform;
				static osg::Vec3 CannonSpoutPosition;

				Spout->GetTransform(CannonSpoutTransform);
				CannonSpoutTransform.GetTranslation(CannonSpoutPosition); 

				float Heading ,Pitch ,Roll;
				CannonSpoutTransform.GetRotation(Heading , Pitch ,Roll);

				LauncherElev	= Pitch;
				TargetBearing	= -Heading;
				ModeID			= Msg.GetModeID();

				std::cout << "Launcher Elev : " << LauncherElev << std::endl;

				if (( mWeaponID == CT_CANNON_57 ) ||
					( mWeaponID == CT_CANNON_76 ))
				{
					if (( LauncherElev < 35.9 ) && ( LauncherElev > 1 ))
					{
						//Low Balistik
						BalistikMode = 0;
						isValid		 = true;
					}
					else
					if (( LauncherElev < 79.9 ) && ( LauncherElev > 41 ))
					{
						//High Balistik
						BalistikMode = 1;
						isValid		 = true;
					}
					else
					{
						isValid = false;
					}
				}
				else
				if ( mWeaponID == CT_CANNON_40 )
				{
					if (( LauncherElev < 37 ) && ( LauncherElev > 1 ))
					{
						isValid = true;
					}
				}
				else
				if ( mWeaponID == CT_CANNON_120 )
				{
					if (( LauncherElev < 40 ) && ( LauncherElev > 1 ))
					{
						isValid = true;
					}
				}
					
				if ( isValid == true)
				{

					mMyParent = parent;

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

					FirstLaunchPoint = CannonSpoutPosition;

					Initialize();
					isLaunch = true;  // Parent
					SetLaunched(true);
				}
				else
					std::cout << "Elev Too High or Too Low or Not valid Balistik" << std::endl;
				
			}
			else
			{
				std::cout<<"Can't Find Spout" <<std::endl;
			}
		}
	}
}

void CannonMissileActor::CannonBlast(dtDAL::ActorProxy* p)
{
	std::cout << "Hit Target" << std::endl;

	dtCore::RefPtr<VehicleActor> target = static_cast<VehicleActor*>(p->GetActor());
	dtGame::GameActorProxy &tr = target->GetGameActorProxy();

	osg::Vec3 TargetPos;
	TargetPos = tr.GetTranslation();
	UpdateStatusDBEffectTo3DExplode(TargetPos.x(), TargetPos.y(), TargetPos.z() ,ST_MISSILE_EXPLODE);

	std::cout << TargetPos << std::endl;
}

void CannonMissileActor::DestroyCannonMissile()
{
	isLaunch = false;
	UpdateStatusDBEffectTo2D(mMyParent.get(), ST_MISSILE_DEL); 
}

void CannonMissileActor::Initialize()
{
	LifeTime = 0;
	Gun_76_TimeMax   = 0;
	Gun_76_HeightMax = 0;
	Gun_76_RangeMax  = 0;
	Gun_76_Time      = 0;
	V0X = 0;
	V0Y = 0;

	trac.SetDirection(TargetBearing);
	trac.SetElevation(LauncherElev);

	/* Mr Reza Calc */
	/* Cannon 40 */
	if ((mWeaponID == CT_CANNON_40) ||
		(mWeaponID == CT_CANNON_57))
	{
		V0X = trac.Gun_40_GetV0X_ByElev(LauncherElev);
		V0Y = trac.Gun_40_GetV0Y_ByElev(LauncherElev);
	}
	else
	/* Cannon 120 */
	if (mWeaponID == CT_CANNON_120)
	{
		V0X = trac.Gun_120_GetV0X_ByElev(LauncherElev);
		V0Y = trac.Gun_120_GetV0Y_ByElev(LauncherElev);
	}
	else
	/* Mr Andi P Calc
	/* Cannon 76 */
	if ( mWeaponID == CT_CANNON_76 )
	{
		/* Low Balistik */
		if (BalistikMode == 0)
		{
			Gun_76_RangeMax		= trac.Gun_76Low_ElevToRange(LauncherElev); 
			Gun_76_HeightMax	= trac.Gun_76Low_ElevToHeight(LauncherElev); 
			Gun_76_TimeMax		= trac.Gun_76Low_RangeToTOF(Gun_76_RangeMax);
		}
		/* High Balistik */
		else
		{		
			Gun_76_RangeMax		= trac.Gun_76High_ElevToRange(LauncherElev); 
			Gun_76_HeightMax	= trac.Gun_76High_ElevToHeight(LauncherElev); 
			Gun_76_TimeMax		= trac.Gun_76High_ElevToTOF(LauncherElev);
			Gun_76_Time		    = trac.Gun_76Low_RangeToTOF( Gun_76_RangeMax );
		}
	}
}

CannonMissileActor::~CannonMissileActor()
{

}

//============================================================================================

//============================================================================================
CannonMissileActorProxy::CannonMissileActorProxy()
{

}

void CannonMissileActorProxy::OnEnteredWorld()
{
	MissilesActorProxy::OnEnteredWorld();
	RegisterForMessages(SimMessageType::CANNON_EVENT);
}

void CannonMissileActorProxy::BuildPropertyMap()
{
	MissilesActorProxy::BuildPropertyMap();
	const std::string GROUP = C_TYPE_MISSILE;

	CannonMissileActor* actor = NULL;
	GetActor(actor);

	//property
	AddProperty(new dtDAL::FloatActorProperty(C_SET_SPEED,C_SET_SPEED,
		dtDAL::FloatActorProperty::SetFuncType(actor, &CannonMissileActor::SetCurrentSpeed),
		dtDAL::FloatActorProperty::GetFuncType(actor, &CannonMissileActor::GetCurrentSpeed), "Sets/gets speed.", GROUP));

	AddProperty(new dtDAL::FloatActorProperty(C_SET_HEADING,C_SET_HEADING,
		dtDAL::FloatActorProperty::SetFuncType(actor, &CannonMissileActor::SetCurrentHeading),
		dtDAL::FloatActorProperty::GetFuncType(actor, &CannonMissileActor::GetCurrentHeading), "Sets/gets Heading.", GROUP));
}