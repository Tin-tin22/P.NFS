#include "playeractor.h"
#include "didactorssources.h"
#include "OceanActor.h"
#include "ShipModelActor.h"
#include "helicopteractor.h"

//Nando Added For Profil Camera Each Missile
#include "missileactor.h"
#include "yakhontactor.h"
#include "ExocetMM40Actor.h"
#include "asrockactor.h"
#include "rbuactor.h"
#include "C802Actor.h"
#include "yakhontactor.h"
#include "MistralRocketActor.h"
#include "StrelaRocketActor.h"
#include "TetralActor.h"
#include "torpedoA244.h"
#include "torsutactor.h"
#include "launcherbodyactor.h"

#include "../didUtils/utilityfunctions.h"
#include "../didUtils/SimServerClientComponent.h"

#include <dtGame/gameapplication.h>
#include <osg/Geode>
#include <osg/Geometry>
#include <osg/MatrixTransform>

#include <osgViewer/viewer>
#include <osg/Depth>
#include <osg/LineWidth>
#include <osgUtil/Tessellator>
#include <osgViewer/Viewer>
#include <osg/math>
#include <math.h>
#include <dtCore/object.h>

#include <dtCore/deltawin.h>

#include <osgWidget/Util>
#include <osgWidget/WindowManager>
#include <osgWidget/Box>
#include <osgWidget/Label>

using dtCore::RefPtr;

const float MAX_PLAYER_SPEED = 5.0f;


const unsigned int CMD_FROM_KEYBOARD     			= 1;
const unsigned int CMD_FROM_MESSAGE  			    = 2;

const dtUtil::RefString DEFAULT_FONT("arial.ttf");
const float DEFAULT_FONT_SIZE = 1.0f;
const osg::Vec4 DEFAULT_COLOR_TEXT(1.0f, 1.0f, 1.0f, 1.0f);
const osg::Vec4 DEFAULT_COLOR_BACK(0.0f, 0.0f, 0.0f, 1.0f);
const osg::Vec2 DEFAULT_BACK_SIZE(1.0f, 1.0f);

using namespace   didEnviro;

//////////////////////////////////////////////////////////////
PlayerActor::PlayerActor(dtGame::GameActorProxy& proxy)
   : dtGame::GameActor(proxy)
   //////////////////////////////////////////////////////////////////////////
   , mTextNode(new osgText::Text)
   //////////////////////////////////////////////////////////////////////////
   , mIsector(new dtCore::Isector)
   , mIsPlayerRunning(false)
   , mSpeed(0.5f)
   , mShipFocusIndex(-1)
   , mSubMarineFocusIndex(-1)
   , mHeliFocusIndex(-1)
   , isMessageMoving(false)
   , isMessageRotating(false)
   , isKeyControlled(false)
   , CameraPitch(0.0f)
   , CameraRange(0.0f)
   , CameraHeading(0.0f)
   , rangeCamExo(1000)
   , flagout(0)
   //, mPlayerSound(dtAudio::AudioManager::GetInstance().NewSound()) 
{
   //AddChild(mPlayerSound);
   //mPlayerSound->SetLooping(true);
   //////////////////////////////////////////////////////////////////////////
   
   
}

PlayerActor::~PlayerActor()
{
	
}

void PlayerActor::set_setting_base (const int set2, const int set3, const int set4, const int set5, const int set6)
{
	if ( set2 == SET_BASE_KEYBOARD ) // keyboard controller
	{    
		if ( set3 == SET_BASE_KEY_ON )
		{
			isKeyControlled = true;
			std::cout<<GetName()<<" Activate Keyboard Control..."<<std::endl;
		}
		else
		{
			isKeyControlled = false;
			std::cout<<GetName()<<" Keyboard Control Disable..."<<std::endl;
		}
	} 
	else if ( set2 == SET_BASE_UNLOCK ) // unlock
	{    
		//AddToEnvironmentActor();
	} 
}

void PlayerActor::set_setting_observer(const int set2, const int set3, const int set4, const int set5, const int set6)
{
	if ( set2 == SET_OBS_VHCFOCUS )  
	{    
		set_player_vehicle_focus(set3); // shipID
	} 
}

void PlayerActor::set_setting_view_missile ( const int set2, const int set3, const int set4, const int set5, const int set6, const int set7)
{
	int vehicleID			= set2 ;
	int weaponID			= set3 ;
	int launcherID			= set4 ;
	int missileID			= set5 ;
	int missileNum			= set6 ;
	int lockSide			= set7;

	attachedProxy			= GetMissileActors(vehicleID, weaponID, launcherID,missileID,missileNum );
	if ( attachedProxy.valid() )
	{
		// Set To Lock Left
		if ( lockSide == LOCK_SIDE_LEFT )
		{
			CameraPitch			= 0;
			CameraHeading		= -30;
			CameraRange			= 100;
		}
		else
		// Set To Lock Right
		if ( lockSide == LOCK_SIDE_RIGHT )
		{
			CameraPitch			= 0;
			CameraHeading		= 30;
			CameraRange			= 100;
		}
		else
		// Set To Lock Front
		if ( lockSide == LOCK_SIDE_FRONT )
		{
			CameraPitch			= 0;
			CameraHeading		= 170;
			CameraRange			= 100;
		}
		else
		// Set To Lock Back
		if ( lockSide == LOCK_SIDE_BACK )
		{
			CameraPitch			= 0;
			CameraHeading		= -10;
			CameraRange			= 100;
		}
		else
		// Set To Lock Top
		if ( lockSide == LOCK_SIDE_TOP )
		{
			CameraPitch			= 88;
			CameraHeading		= 0;
			CameraRange			= 100;
		}
	}
}

void PlayerActor::set_setting_view_ship (const int set2, const int set3, const int set4, const int set5, const int set6)
{
	int vehicleID		= set2;
	int vehicleType		= set3;   // ship/sub/air
	int lockSide		= set4;

	attachedProxy		= GetVehicleActorByID(vehicleID);

	if ( attachedProxy.valid() )
	{
		// Set To Lock Left
		if ( lockSide == LOCK_SIDE_LEFT )
		{
			CameraPitch			= 0;
			CameraHeading		= -30;
			CameraRange			= 200;
		}
		else
		// Set To Lock Right
		if ( lockSide == LOCK_SIDE_RIGHT )
		{
			CameraPitch			= 0;
			CameraHeading		= 30;
			CameraRange			= 200;
		}
		else
		// Set To Lock Front
		if ( lockSide == LOCK_SIDE_FRONT )
		{
			CameraPitch			= 0;
			CameraHeading		= 170;
			CameraRange			= 200;
		}
		else
		// Set To Lock Back
		if ( lockSide == LOCK_SIDE_BACK )
		{
			CameraPitch			= 0;
			CameraHeading		= -10;
			CameraRange			= 200;
		}
		else
		// Set To Lock Top
		if ( lockSide == LOCK_SIDE_TOP )
		{
			CameraPitch			= 88;
			CameraHeading		= 0;
			CameraRange			= 200;
		}
	}
}

void PlayerActor::set_setting_attach_ship(const int set2, const int set3, const int set4, const int set5, const int set6)
{	 
	int vehicleID		= set2;
	int vehicleType		= set3;   // ship/sub/air

	attachedProxy		= GetVehicleActorByID(vehicleID);

	if ( attachedProxy.valid() )
	{
		dtCore::RefPtr<VehicleActor> tgt = static_cast<VehicleActor*>(attachedProxy->GetActor()); // kl attachedProxy tdk valid bisa menyebabkan error [9/7/2012 DID RKT2]
		/*dtCore::Transform targetTransform;
		osg::Vec3 targetPosition,targetRotation;*/
		tgt->GetTransform(targetTransform);
		//tak tandai
		targetTransform.GetTranslation(targetPosition);
		targetTransform.GetRotation(targetRotation);

		if ( GetParent() != NULL )
			GetParent()->RemoveChild(this);
		attachedProxy->GetActor()->AddChild(this);

		dtCore::RefPtr<dtGame::GameActorProxy> actProxy = NULL ;
		actProxy = static_cast<dtGame::GameActorProxy *>(attachedProxy.get());
		
		if ( actProxy )
		{
			std::string mDOFName = "DOF_anjungan" ;

			osg::Node *model = actProxy->GetActor()->GetOSGNode();
			dtCore::RefPtr<dtUtil::NodeCollector> mtColector = new dtUtil::NodeCollector(model, dtUtil::NodeCollector::DOFTransformFlag);
			dtCore::RefPtr<osgSim::DOFTransform> mDOFTran = mtColector->GetDOFTransform(mDOFName);

			if (mDOFTran != NULL)
			{
				osg::Vec3 vPos = GetDOFPositionAbsolute(mDOFTran);
				dtCore::Transform CurrentPos ;
				CurrentPos.SetTranslation(vPos);
				SetTransform(CurrentPos,dtCore::Transformable::ABS_CS);
				GetTransform(CurrentPos,dtCore::Transformable::REL_CS);
				CurrentPos.SetRotation(0.0f,0.0f,0.0f);
				SetTransform(CurrentPos,dtCore::Transformable::REL_CS);
				std::cout <<GetName()<<" attach at "<<actProxy->GetName()<<" by "<<mDOFName<<std::endl;
				std::cout << "pos dof : " <<vPos <<std::endl;
					  
			} else
			{
				dtCore::Transform t;
				
				t = get_default_actor_attach((actProxy->GetActorType()).GetName());
				SetTransform(t,dtCore::Transformable::REL_CS);
				std::cout <<GetName()<<" attach at "<<actProxy->GetName()<<" by default position"<<std::endl;
			}
		} 

	} else 
	{
		std::cout<<GetName()<<", receive follow id "<<vehicleID<<" but failed."<<std::endl;
	}
 
}

void PlayerActor::SetAttachToTDS(const int mVehicleID, const int mWeaponID , const int mLauncherID)
{
	 attachedProxy	= GetLauncherActors(C_WEAPON_TYPE_SPOUT, mVehicleID, mWeaponID, mLauncherID );
	 
	 dtCore::RefPtr<dtDAL::ActorProxy> shipProxy = NULL ; 
	 shipProxy		= GetVehicleActorByID(mVehicleID);

	  if ( attachedProxy.valid() )
	  {
		 if ( shipProxy.valid() )
		 {
			/* TDS */
			if ( mWeaponID == CT_CANNON_40 || 
				 mWeaponID == CT_CANNON_57 || 
				 mWeaponID == CT_CANNON_76 ||
				 mWeaponID == CT_CANNON_120 )
			{
				/* CHECK DOF IN SHIP */ 

				if ( GetParent() != NULL )
					GetParent()->RemoveChild(this);
				shipProxy->GetActor()->AddChild(this);

				std::string mDOFName = "DOF_TDS1";

				dtCore::RefPtr<dtGame::GameActorProxy> shipActProxy = NULL ;
				shipActProxy = static_cast<dtGame::GameActorProxy *>(shipProxy.get());

				dtCore::RefPtr<dtGame::GameActorProxy> actProxy = NULL ;
				actProxy = static_cast<dtGame::GameActorProxy *>(attachedProxy.get());

				osg::Node *shipmodel = shipActProxy->GetActor()->GetOSGNode();
				dtCore::RefPtr<dtUtil::NodeCollector> mtColector = new dtUtil::NodeCollector(shipmodel, dtUtil::NodeCollector::DOFTransformFlag);
				dtCore::RefPtr<osgSim::DOFTransform> mDOFTran = mtColector->GetDOFTransform(mDOFName);

				if (mDOFTran != NULL)
				{
					std::cout << "==== FOUND DOF : " << mDOFName << " =====" <<std::endl;

					static dtCore::Transform SpoutTransform;
					float Heading ,Pitch ,Roll;
					dtCore::RefPtr<dtGame::GameActor> Spout = static_cast<dtGame::GameActor*>(actProxy->GetActor());
					Spout->GetTransform(SpoutTransform,dtCore::Transformable::REL_CS);
					SpoutTransform.GetRotation(Heading , Pitch ,Roll);
					std::cout << "First Heading TDS : " << ValidateDegree(Heading) << std::endl;

					osg::Vec3 vPos = GetDOFPositionAbsolute(mDOFTran);
					std::cout << "DOF Transform " << vPos << std::endl;

					dtCore::Transform CurrentPos ;
					CurrentPos.SetTranslation(vPos);

					SetTransform(CurrentPos,dtCore::Transformable::ABS_CS);
					GetTransform(CurrentPos,dtCore::Transformable::REL_CS);
					CurrentPos.SetRotation(Heading,0.0f,0.0f);
					SetTransform(CurrentPos,dtCore::Transformable::REL_CS);

					std::cout <<GetName()<<" attach at "<<actProxy->GetName()<<" by "<<mDOFName<<std::endl;

				} 
				else
				{
					std::cout << "==== NOT FOUND DOF : " << mDOFName << " =====" <<std::endl;

					dtCore::Transform t;
					t = get_default_actor_attach((actProxy->GetActorType()).GetName());
					SetTransform(t,dtCore::Transformable::REL_CS);

					std::cout <<"Cannot Find DOF " << mDOFName << std::endl;
					std::cout <<GetName()<<" attach at "<<actProxy->GetName()<<" by default position"<<std::endl;
				}
			}
			else
			/* MISTRAL, STRELA */
			if ( mWeaponID == CT_MISTRAL || 
				 mWeaponID == CT_STRELA)
			{
				/* CHECK DOF IN LAUNCHER */

				if ( GetParent() != NULL )
					GetParent()->RemoveChild(this);
				attachedProxy->GetActor()->AddChild(this);

				dtCore::RefPtr<dtGame::GameActorProxy> actProxy = NULL ;
				actProxy = static_cast<dtGame::GameActorProxy *>(attachedProxy.get());

				std::string mDOFName = GetCameraDOFName(mWeaponID, mLauncherID) ;

				osg::Node *model = actProxy->GetActor()->GetOSGNode();
				dtCore::RefPtr<dtUtil::NodeCollector> mtColector = new dtUtil::NodeCollector(model, dtUtil::NodeCollector::DOFTransformFlag);
				dtCore::RefPtr<osgSim::DOFTransform> mDOFTran = mtColector->GetDOFTransform(mDOFName);

				if (mDOFTran != NULL)
				{
					std::cout << "==== FOUND DOF : " << mDOFName << " =====" <<std::endl;

					osg::Vec3 vPos = GetDOFPositionAbsolute(mDOFTran);
					dtCore::Transform CurrentPos ;
					CurrentPos.SetTranslation(vPos);
					SetTransform(CurrentPos,dtCore::Transformable::ABS_CS);
					GetTransform(CurrentPos,dtCore::Transformable::REL_CS);
					CurrentPos.SetRotation(0.0f,0.0f,0.0f);
					SetTransform(CurrentPos,dtCore::Transformable::REL_CS);

					std::cout <<GetName()<<" attach at "<<actProxy->GetName()<<" by "<<mDOFName<<std::endl;

				} 
				else
				{
					std::cout << "==== NOT FOUND DOF : " << mDOFName << " =====" <<std::endl;

					dtCore::Transform t;
					t = get_default_actor_attach((actProxy->GetActorType()).GetName());
					SetTransform(t,dtCore::Transformable::REL_CS);

					std::cout <<"Cannot Find DOF " << mDOFName << std::endl;
					std::cout <<GetName()<<" attach at "<<actProxy->GetName()<<" by default position"<<std::endl;
				}
			}
		 }
	  }
	  else
		  std::cout << "Cannot Find Launcher " << mVehicleID << "." << mWeaponID << "." << mLauncherID << std::endl; 
}

void PlayerActor::set_setting_attach_launcher(const int set2, const int set3, const int set4, const int set5, const int set6)
{ 
	 int vehicleID			= set2 ;
	 int weaponID			= set3 ;
	 int launcherID			= set4 ;
	 int missileID			= set5 ;
	 int missileNum			= set6 ;

	 attachedProxy			= GetLauncherActors(C_WEAPON_TYPE_SPOUT, vehicleID, weaponID, launcherID );
	 
	 if ( attachedProxy.valid() )
	 {
		 if ( GetParent() != NULL )
			 GetParent()->RemoveChild(this);
		 attachedProxy->GetActor()->AddChild(this);

		 dtCore::RefPtr<dtGame::GameActorProxy> actProxy = NULL ;
		 actProxy = static_cast<dtGame::GameActorProxy *>(attachedProxy.get());

		 if ( actProxy )
		 {
			 std::string mDOFName = GetCameraDOFName(weaponID,launcherID) ;

			 osg::Node *model = actProxy->GetActor()->GetOSGNode();
			 dtCore::RefPtr<dtUtil::NodeCollector> mtColector = new dtUtil::NodeCollector(model, dtUtil::NodeCollector::DOFTransformFlag);
			 dtCore::RefPtr<osgSim::DOFTransform> mDOFTran = mtColector->GetDOFTransform(mDOFName);
			 
			 if (mDOFTran == NULL)
			 {
				 std::string mDOFName = GetCameraDOFName(weaponID,launcherID) ;

				 dtCore::RefPtr<dtDAL::ActorProxy> shipProxy = NULL ; 
				 shipProxy = GetVehicleActorByID(vehicleID);

				 if (shipProxy.valid() )		
				 {
					 dtCore::RefPtr<dtGame::GameActorProxy> shipActProxy = NULL ;
					 shipActProxy = static_cast<dtGame::GameActorProxy *>(shipProxy.get());

					 osg::Node *shipmodel = shipActProxy->GetActor()->GetOSGNode();
					 dtCore::RefPtr<dtUtil::NodeCollector> mtColector = new dtUtil::NodeCollector(shipmodel, dtUtil::NodeCollector::DOFTransformFlag);
					 mDOFTran = mtColector->GetDOFTransform(mDOFName);
				 }
			 }

			 if (mDOFTran != NULL)
			 {
				 osg::Vec3 vPos = GetDOFPositionAbsolute(mDOFTran);
				 dtCore::Transform CurrentPos ;
				 CurrentPos.SetTranslation(vPos);
				 SetTransform(CurrentPos,dtCore::Transformable::ABS_CS);
				 GetTransform(CurrentPos,dtCore::Transformable::REL_CS);
				 CurrentPos.SetRotation(0.0f,0.0f,0.0f);
				 SetTransform(CurrentPos,dtCore::Transformable::REL_CS);

				 std::cout <<GetName()<<" attach at "<<actProxy->GetName()<<" by "<<mDOFName<<std::endl;

			 } else
			 {
				 dtCore::Transform t;
				 t = get_default_actor_attach((actProxy->GetActorType()).GetName());
				 SetTransform(t,dtCore::Transformable::REL_CS);
				 
				 std::cout <<"Cannot Find DOF " << mDOFName << std::endl;
				 std::cout <<GetName()<<" attach at "<<actProxy->GetName()<<" by default position"<<std::endl;
			 }
		 }
	 }
}

void PlayerActor::set_setting_attach_missile(const int set2, const int set3, const int set4, const int set5, const int set6)
{
	int vehicleID			= set2 ;
	int weaponID			= set3 ;
	int launcherID			= set4 ;
	int missileID			= set5 ;
	int missileNum			= set6 ;

	attachedProxy			= GetMissileActors(vehicleID, weaponID, launcherID,missileID,missileNum );
	if ( attachedProxy.valid() )
	{
		if ( GetParent() != NULL )
			GetParent()->RemoveChild(this);
		attachedProxy->GetActor()->AddChild(this);

		dtCore::RefPtr<dtGame::GameActorProxy> actProxy = NULL ;
		actProxy = static_cast<dtGame::GameActorProxy *>(attachedProxy.get());

		if ( actProxy )
		{
			std::string mDOFName = C_DOF_NAME_MISSILE;

			osg::Node *model = actProxy->GetActor()->GetOSGNode();
			dtCore::RefPtr<dtUtil::NodeCollector> mtColector = new dtUtil::NodeCollector(model, dtUtil::NodeCollector::DOFTransformFlag);
			dtCore::RefPtr<osgSim::DOFTransform> mDOFTran = mtColector->GetDOFTransform(mDOFName);

			if (mDOFTran != NULL)
			{
				osg::Vec3 vPos = GetDOFPositionAbsolute(mDOFTran);
				dtCore::Transform CurrentPos ;
				CurrentPos.SetTranslation(vPos);
				SetTransform(CurrentPos,dtCore::Transformable::ABS_CS);
				GetTransform(CurrentPos,dtCore::Transformable::REL_CS);
				CurrentPos.SetRotation(0.0f,0.0f,0.0f);
				SetTransform(CurrentPos,dtCore::Transformable::REL_CS);
				std::cout <<GetName()<<" attach at "<<actProxy->GetName()<<" by "<<mDOFName<<std::endl;

			} else
			{
				dtCore::Transform t;
				
				t = get_default_actor_attach((actProxy->GetActorType()).GetName());
				SetTransform(t,dtCore::Transformable::REL_CS);

				std::cout <<"Cannot Find DOF " << mDOFName << " In " << attachedProxy->GetActor()->GetName() << std::endl; 
				std::cout <<GetName()<<" attach at "<<actProxy->GetName()<<" by default position"<<std::endl;
			}
		}
	}
	else
	{
		std::cout << "Cannot Find Missile Actor" << std::endl;
	}
}

void PlayerActor::processOrderAsrock(const dtGame::Message &message)
{
	const MsgSetAsrock &Msg = static_cast<const MsgSetAsrock&>(message);

	int targetRange = int(Msg.GetTargetRange());
	std::cout <<"targetRangeAsrock: "<<targetRange<<std::endl;
}

void PlayerActor::ProcessOrderEvent(const dtGame::Message &message)
{
	const MsgUtilityAndTools &Msg = static_cast<const MsgUtilityAndTools&>(message);

	int orderID		= int(Msg.GetOrderID()); 
	int playerID	= int(Msg.GetUAT0()); 
	int set1		= int(Msg.GetUAT1()); 
	int set2		= int(Msg.GetUAT2()); 
	int set3		= int(Msg.GetUAT3()); 
	int set4		= int(Msg.GetUAT4()); 
	int set5		= int(Msg.GetUAT5()); 
	int set6		= int(Msg.GetUAT6()); 

	isFirst = true;  

	/* FIRING LOCK */
	/* Obsr1 : Lock Missile, 
	   Obsr2 : Lock Ship, 
	   Obsr0 : Lock Ship */
	int setid = set1;
	if (( setid == PLAYER_SET_FIRING_LOCK ) && (orderID == TIPE_UTIL_PLAYER_SETTING))
	{
		//if (playerID == 11) || (playerID == 12) || (playerID == 13) || (playerID)
		std::cout << "Receive Mode Firing Lock" << std::endl;

		//SetPlayerType(PLAYER_SET_OBSERVER);
		//AddToEnvironmentActor();
		//set_setting_observer(set2,set3,set4,set5,set6);

		LockingStepObs0 = 0;
		LockingStepObs1 = 0;
		LockingStepObs2 = 0;
		isReadyToCircle = false;
		timeToCircle	= 0;
		tempRot			= 0;
		//waktu			= 0;
		//tempMphase		= 0;

		//setTargetBearingExo(1000);

		mLockFireShipID			= set2;
		mLockFireWeaponID		= set3;
		mLockFireLauncherID		= set4;
		mLockFireMissileID		= set5;
		mLockFireMissNumberID	= set6;
		attachedProxy = GetMissileActors(mLockFireShipID,mLockFireWeaponID,mLockFireLauncherID,mLockFireMissileID,mLockFireMissNumberID);
		SetPlayerType(PLAYER_SET_FIRING_LOCK);
	}

	/* CAMERA LOCK */
	if ( playerID == mPlayerID )
	{
		//std::cout<<GetName()<<" Received Commmad :: "<<orderID<<"."<<playerID<<"."<<set1<<"."<<set2<<"."<<set3<<"."<<set4<<"."<<set5<<"."<<set6<<std::endl;

		//////////////////////////////////////////////////////////////////////////
		if ( orderID == TIPE_UTIL_PLAYER_SETTING ) 
		{
			int typeID			= set1 ; /// player type

			switch (typeID){
				case PLAYER_SET_BASE :
					SetPlayerType(PLAYER_SET_BASE);
					{
						set_setting_base(set2,set3,set4,set5,set6);
					}
					break;

				case PLAYER_SET_OBSERVER :
					{
						SetPlayerType(PLAYER_SET_OBSERVER);
						//AddToEnvironmentActor();
						set_setting_observer(set2,set3,set4,set5,set6);
					}
					break;
	
				/* Versi 1 */
				/* =================================================== */

				case PLAYER_SET_ATTACH_SHIP :
					{
						SetPlayerType(PLAYER_SET_ATTACH_SHIP);
						set_setting_attach_ship(set2,set3,set4,set5,set6);
						fly_step = 0;
					}
					break;

				case PLAYER_SET_ATTACH_LAUNCHER :
					{
						SetPlayerType(PLAYER_SET_ATTACH_LAUNCHER);
						set_setting_attach_launcher(set2,set3,set4,set5,set6);
					}
					break;

				case PLAYER_SET_ATTACH_MISSILE :
					{
						SetPlayerType(PLAYER_SET_ATTACH_MISSILE);
						set_setting_attach_missile(set2,set3,set4,set5,set6);

						fly_step = 0;
					}
					break;

				case PLAYER_SET_LOCK_OBJECT : 
					{
						//Before This Method Called
						//Must Call PLAYER_SET_ATTACH (MISSILE/SHIP) to Set 
						//Missile/Vehicle Locked Object

						int LockType;
						int LockObject;

						LockType   = set2;		//1 Left, 2 Right, 3 Front, 4 Back, 5 Top;
						LockObject = set3;		//1 Surface, 2 Subsurface, 3 Air, 4 weapon; 

						SetPlayerType(PLAYER_SET_LOCK_OBJECT);
						SetPlayerObjectLock(LockObject);
						SetPlayerDefaultLock(LockType);
						fly_step = 0;

					}
					break;

				/* Versi 2 */
				/* =================================================== */

				case PLAYER_SET_ATTACH_SHIP2 :
					{
						SetPlayerType(PLAYER_SET_OBSERVER);
						//AddToEnvironmentActor();
						set_setting_observer(set2,set3,set4,set5,set6);

						SetPlayerType(PLAYER_SET_ATTACH_SHIP2);
						set_setting_view_ship(set2,set3,set4,set5,set6);
					}
					break;

				case PLAYER_SET_ATTACH_MISSILE2 :
					{
						SetPlayerType(PLAYER_SET_OBSERVER);
						//AddToEnvironmentActor();
						set_setting_observer(set2,set3,set4,set5,set6);

						SetPlayerType(PLAYER_SET_ATTACH_MISSILE2);
						set_setting_view_missile(set2,set3,set4,set5,set6,0);
					}
					break;

				case PLAYER_SET_LOCK_OBJECT2 :
					{
						int LockSide	 = set2;  // Left, Right, Front, Back, Top
						int ObjectLockID = set3;  // 1. Surface, 2. Subsurface, 3. Air , 4 Weapon

						if (attachedProxy.valid())
						{
							if ( ObjectLockID == OBJECT_SURFACE		|| 
								 ObjectLockID == OBJECT_SUBSURFACE  ||
								 ObjectLockID == OBJECT_AIR )
							{
								dtCore::RefPtr<VehicleActor> ObjView = static_cast<VehicleActor*>(attachedProxy->GetActor());
								set_setting_view_ship(ObjView->GetVehicleID() , ObjectLockID , LockSide, set5,set6);
							}
							else
							if ( ObjectLockID == OBJECT_WEAPON )
							{
								dtCore::RefPtr<MissilesActor> ObjView = static_cast<MissilesActor*>(attachedProxy->GetActor());
								set_setting_view_missile(ObjView->mVehicleID, ObjView->mWeaponID, ObjView->mLauncherID , ObjView->mMissileID, ObjView->mMissileNum, LockSide);
							}
						}
					}
					break;
			}
			 
		}


		//////////////////////////////////////////////////////////////////////////
		else  if ( orderID == TIPE_UTIL_PLAYER_EVENT ) 
		{
			int typeID = set1 ; // action type ( on / off )

			switch (typeID){
				case IS_PLAYER_STOP_ALL :
					{
						isMessageMoving = false; 
						isMessageRotating = false; 
					}
					break;

				case IS_PLAYER_MOVE_ON :
					{
						if ( set5 > 0 ) 
							mSpeed = set5 ;

						if ( mSpeed <= 0.1f ) 
							mSpeed = 0.1f;
						
						if ( mSpeed >= 5.0f )
							mSpeed = 5.0f;

						int move_st = set2; // move state ( forward / back / left )
						set_current_move_state(CMD_FROM_MESSAGE,move_st);
					}
					break;

				case IS_PLAYER_MOVE_OFF :
					{
						isMessageMoving = false; 
					}
					break;

				case IS_PLAYER_ROTATE_ON :
					{
						if ( set5 > 0 ) 
							mSpeed = set5 ;

						if ( mSpeed <= 0.1f ) 
							mSpeed = 0.1f;

						if ( mSpeed >= 5.0f)
							mSpeed = 5.0f;
						//mSpeed = 20.0f;

						int rotate_st = set2 ; // rotate state ( left / right / up / down )
						DesiredCameraAngle = set6;
						set_current_rotate_state(CMD_FROM_MESSAGE,rotate_st); 
					}
					break;

				case IS_PLAYER_ROTATE_OFF :
					{
						isMessageRotating = false; 
					}
					break;
			}

		}
		//////////////////////////////////////////////////////////////////////////
	} // player id 
}

//////////////////////////////////////////////////////////////////////////

void PlayerActor::TickLocal(const dtGame::Message &tickMessage)
{
	const dtGame::TickMessage &tick = static_cast<const dtGame::TickMessage&>(tickMessage);
	float deltaSimTime = tick.GetDeltaSimTime();

	if ( mPlayerType == PLAYER_SET_OBSERVER )
	{
		run_as_observer(deltaSimTime);
	}
	else

	/* Versi 1 */
	if ( mPlayerType == PLAYER_SET_ATTACH_SHIP || mPlayerType == PLAYER_SET_ATTACH_LAUNCHER )
	{
		run_as_child(deltaSimTime);
	} 
	else
	if ( mPlayerType == PLAYER_SET_ATTACH_MISSILE )
	{
		run_as_misile_obs(deltaSimTime);
	}
	else
	if ( mPlayerType == PLAYER_SET_LOCK_OBJECT )
	{
		run_as_child_toLockSide(deltaSimTime);
	}

	//else 
	//	if (mPlayerType == player)

	/* Versi 2 */
	else
	if ( mPlayerType == PLAYER_SET_FIRING_LOCK )
	{
		run_as_child_toLockfiring(deltaSimTime);
	}
	else
	if ( mPlayerType == PLAYER_SET_ATTACH_SHIP2			|| 
		 mPlayerType == PLAYER_SET_ATTACH_LAUNCHER2		||
		 mPlayerType == PLAYER_SET_ATTACH_MISSILE2      ||
		 mPlayerType == PLAYER_SET_LOCK_OBJECT2 )
	{
		run_as_ViewObject(deltaSimTime);
		//std::cout << "run_as_ViewObject" << std::endl;

		if ( attachedProxy.valid())
		{
			if ( isMessageMoving ) 
			{
				isMessageRotating = false;

				float TmpCameraRange;
				float TmpCameraPitch;

				if  ( current_state_move == MOVE_PLAYER_LEFT )			CameraHeading = ValidateDegree(CameraHeading - 10*deltaSimTime);
				else if ( current_state_move == MOVE_PLAYER_RIGHT )		CameraHeading = ValidateDegree(CameraHeading + 10*deltaSimTime);
				else 
				if ( current_state_move == MOVE_PLAYER_FORWARD) 
				{
					TmpCameraRange = CameraRange - 25*deltaSimTime;
					if ( TmpCameraRange >= 30)							CameraRange = TmpCameraRange; 
				}
				else 
				if ( current_state_move == MOVE_PLAYER_BACK )			CameraRange = CameraRange + 25*deltaSimTime;
				else
				if ( current_state_move == MOVE_PLAYER_UP )
				{
					TmpCameraPitch = CameraPitch + 5*deltaSimTime;
					if ( TmpCameraPitch <= 88 )							CameraPitch = TmpCameraPitch;
				}
				else
				if ( current_state_move == MOVE_PLAYER_DOWN )
				{
					TmpCameraPitch = CameraPitch - 5*deltaSimTime;
					if ( TmpCameraPitch >= 0 )							CameraPitch = TmpCameraPitch;
				}
			}
		}

		if ( attachedProxy.valid())
		{
			if ( isMessageRotating ) 
			{
				isMessageMoving = false;
				
				if ( current_state_rotation == ROTATE_PLAYER_LEFT ||
					 current_state_rotation == ROTATE_PLAYER_RIGHT)
				{
					if ( DegComp_IsBeetwen(DesiredCameraAngle, CameraHeading , ValidateDegree(CameraHeading + 180))) 
						CameraHeading = ValidateDegree(CameraHeading + 30*deltaSimTime);
					else
						CameraHeading = ValidateDegree(CameraHeading - 30*deltaSimTime);
		
					if (abs(CameraHeading - DesiredCameraAngle) <= 1) isMessageRotating = false;
				}
				if ( current_state_rotation == ROTATE_PLAYER_UP ||
					 current_state_rotation == ROTATE_PLAYER_DOWN)
				{
					if ( DesiredCameraAngle >= 0 &&
						 DesiredCameraAngle <= 88 )
					{
						if ( CameraPitch >= DesiredCameraAngle )
							CameraPitch = CameraPitch - 15*deltaSimTime; 
						else
							CameraPitch = CameraPitch + 15*deltaSimTime; 
							
						if (abs(CameraPitch - DesiredCameraAngle) <= 1) isMessageRotating = false;
					}
				}
			}
		}
	}

	/* Camera Transform */
	dtCore::Transform camPlayerTrans;
	osg::Vec3 camPlayerPOS, camPlayerROT; 
	GetTransform(camPlayerTrans);
	camPlayerTrans.GetTranslation(camPlayerPOS);
	camPlayerTrans.GetRotation(camPlayerROT);

	/*if ( GetParent() != NULL )
	{
		std::cout << GetParent()->GetName() << std::endl;
		std::cout << "valid" <<std::endl;
	}
	else
		std::cout << "not valid" <<std::endl;*/
}

void PlayerActor::fly_to_LockFiring(const float dt)
{
	/* Camera Rule */
	   
	/* Missile Transform */
	dtCore::Transform ObjectTrans ;
	osg::Vec3 ObjectPOS, ObjectROT;

	/* Camera Transform */
	dtCore::Transform camPlayerTrans;
	osg::Vec3 camPlayerPOS, camPlayerROT; 
	GetTransform(camPlayerTrans);
	camPlayerTrans.GetTranslation(camPlayerPOS);
	camPlayerTrans.GetRotation(camPlayerROT);

	double RateMovingCamera;
	RateMovingCamera = 20.0f;

	/* Observer 1 */
	if ( mPlayerID == 11 )
	{
		attachedProxy = GetMissileActors(mLockFireShipID,mLockFireWeaponID,mLockFireLauncherID,mLockFireMissileID,mLockFireMissNumberID);
		if (attachedProxy.valid())
		{
			dtCore::RefPtr<MissilesActor> Missile = static_cast<MissilesActor*>(attachedProxy->GetActor());
			
			/* RBU */
			if (Missile->mWeaponID == CT_RBU_6000)
			{
				// attach to target [8/29/2012 DID RKT2]
				/*dtCore::RefPtr<RBUActor> RBUMissile = static_cast<RBUActor*>(attachedProxy->GetActor());
				dtCore::RefPtr<dtDAL::ActorProxy> targetProxy;
				targetProxy = GetVehicleActorByID(RBUMissile->TargetID);

				if (targetProxy.valid())
				{
					SetPlayerType(PLAYER_SET_OBSERVER);
					AddToEnvironmentActor();
					set_player_vehicle_focus(RBUMissile->TargetID);
				}*/
			}
			else
			/* ASROC */
			if (Missile->mWeaponID == CT_ASROC)
			{
				
			}
			else
			/* YAKHONT */
			if (Missile->mWeaponID == CT_YAKHONT)
			{
				
			}
			else
			/* C802 */
			if (Missile->mWeaponID == CT_C802)
			{
				/*
				attachedProxy = GetMissileActors(mLockFireShipID,mLockFireWeaponID,mLockFireLauncherID,mLockFireMissileID,mLockFireMissNumberID);
				dtCore::RefPtr<C802MissileActor> C802Missile = static_cast<C802MissileActor*>(attachedProxy->GetActor());

				if ( C802Missile->mShipTarget != NULL)
				{
					VehicleActor* TargetAct = dynamic_cast<VehicleActor*>(C802Missile->mShipTarget.get());
					dtGame::GameActorProxy &pr = TargetAct->GetGameActorProxy();
					dtCore::RefPtr<dtDAL::ActorProperty> shipID(pr.GetProperty(C_SET_VID));
					dtCore::RefPtr<dtDAL::IntActorProperty> vshipID( static_cast<dtDAL::IntActorProperty*>( shipID.get() ) );
					int VID = vshipID->GetValue();
					dtCore::RefPtr<dtDAL::ActorProxy> targetProxy;
					targetProxy = GetVehicleActorByID(VID);

					if (targetProxy.valid())
					{
						SetPlayerType(PLAYER_SET_OBSERVER);
						AddToEnvironmentActor();
						set_player_vehicle_focus(VID);
					}
				}*/
			}
			else
			/* EXOCETMM40 */
			if (Missile->mWeaponID == CT_EXOCET_40)
			{
				dtCore::RefPtr<ExocetMM40Actor> ExocetMissile = static_cast<ExocetMM40Actor*>(attachedProxy->GetActor());

				/* Step0 */
				if (LockingStepObs1 == 0)
				{
					///* Attach To Missile */
					//set_setting_attach_ship(mLockFireShipID, OBJECT_SURFACE, 0,0,0);

					//fly_step = 0;
					//LockingStepObs1 = 1;
				}
				else
				/* Step 1 */
				if (LockingStepObs1 == 1)
				{	
					//static_cast<dtGame::GameActor*>(GetParent())->GetTransform(ObjectTrans);
					//ObjectTrans.GetTranslation(ObjectPOS);
					//ObjectTrans.GetRotation(ObjectROT);

					//osg::Vec3 lookAtPosition(ObjectPOS);
					//osg::Vec3 upVec(0.f, 0.f, 1.f);

					//int InitializeBearing;
					//InitializeBearing = -ObjectROT.x();

					//if (ExocetMissile->mLauncherID == 1 || ExocetMissile->mLauncherID == 3)
					//{
					//	/* Right Launcher */
					//	if (ExocetMissile->GetFirstTurn() == 1)
					//		InitializeBearing	= ValidateDegree(InitializeBearing + 180);
					//	else
					//		InitializeBearing	= ValidateDegree(InitializeBearing);

					//	camPlayerPOS		= RangeBearingToCoord(ObjectPOS, 200, InitializeBearing);
					//	camPlayerPOS.z()	= 50.0f;

					//	camPlayerTrans.Set(camPlayerPOS, lookAtPosition, upVec);
					//	SetTransform(camPlayerTrans);

					//	LockingStepObs1 = 2;
					//	fly_step		= 0;
					//}
					//else
					//if (ExocetMissile->mLauncherID == 2 || ExocetMissile->mLauncherID == 4)
					//{
					//	/* Left Launcher */

					//	if (ExocetMissile->GetFirstTurn() == 1)
					//		InitializeBearing	= ValidateDegree(InitializeBearing);
					//	else
					//		InitializeBearing	= ValidateDegree(InitializeBearing + 180);

					//	camPlayerPOS		= RangeBearingToCoord(ObjectPOS, 200, InitializeBearing);
					//	camPlayerPOS.z()	= 50.0f;

					//	camPlayerTrans.Set(camPlayerPOS, lookAtPosition, upVec);
					//	SetTransform(camPlayerTrans);

					//	LockingStepObs1 = 2;
					//	fly_step		= 0;
					//}
					
				}
				/* STEP 2 */
				/*if (LockingStepObs1 == 2)
				{

				}*/
			}
			else
			/* TORPEDO A244 */
			if (Missile->mWeaponID == CT_TORPEDO_A244S)
			{
				
			}
			else
			/* TORPEDO SUT */
			if (Missile->mWeaponID == CT_TORPEDO_SUT)
			{
				//// attach to target [8/29/2012 DID RKT2]
				//dtCore::RefPtr<TorSutActor> SUTMissile = static_cast<TorSutActor*>(attachedProxy->GetActor());
				//dtCore::RefPtr<dtDAL::ActorProxy> targetProxy;
				//targetProxy = GetVehicleActorByID(SUTMissile->TargetID);

				//if (targetProxy.valid())
				//{
				//	SetPlayerType(PLAYER_SET_OBSERVER);
				//	AddToEnvironmentActor();
				//	set_player_vehicle_focus(SUTMissile->TargetID);
				//}
			}
		}
	}

	/* Observer 2 */
	if ( mPlayerID == 12)
	{
		attachedProxy = GetMissileActors(mLockFireShipID,mLockFireWeaponID,mLockFireLauncherID,mLockFireMissileID,mLockFireMissNumberID);
		if (attachedProxy.valid())
		{
			dtCore::RefPtr<MissilesActor> Missile = static_cast<MissilesActor*>(attachedProxy->GetActor());

			/* RBU */
			if (Missile->mWeaponID == CT_RBU_6000)
			{
				/*if (isFirst==true){
					set_setting_attach_ship(mLockFireShipID, OBJECT_SURFACE, 0,0,0);
					camPlayerPOS[0] += 160.8;
					camPlayerPOS[1] -= 54.6;
					camPlayerPOS[2] += 3.7483;
					camPlayerROT.x() = 70.8181;
					camPlayerROT.y() = -5.18325;
					camPlayerROT.z() = 0.4325;
					camPlayerTrans.SetRotation(camPlayerROT);
					camPlayerTrans.SetTranslation(camPlayerPOS);
					SetTransform(camPlayerTrans);
					isFirst=false;
				}*/
			}
			else
			/* ASROC */
			if (Missile->mWeaponID == CT_ASROC)
			{
				
			}
			else
			/* YAKHONT */
			if (Missile->mWeaponID == CT_YAKHONT)
			{
				
			}
			else
			/* C802 */
			if (Missile->mWeaponID == CT_C802)
			{
				//// kodingan ndeso, ini hanya berlaku c802 pada kapal ahmad yani [8/30/2012 DID RKT2]
				//// cari cara lain agar player dinamis, cara lookat to the ship pd posisi tertentu [8/30/2012 DID RKT2]
				//if (isFirst==true){
				//	set_setting_attach_ship(mLockFireShipID, OBJECT_SURFACE, 0,0,0);
				//	camPlayerPOS[0] -= 207.3;
				//	camPlayerPOS[1] += 143.4;
				//	camPlayerPOS[2] += 222.4883;
				//	camPlayerROT.x() = -128.186;
				//	camPlayerROT.y() = -47.8571;
				//	camPlayerROT.z() = 1.6773;
				//	camPlayerTrans.SetRotation(camPlayerROT);
				//	camPlayerTrans.SetTranslation(camPlayerPOS);
				//	SetTransform(camPlayerTrans);
				//	isFirst=false;
				//}				
			}
			else
			/* EXOCETMM40 */
			if (Missile->mWeaponID == CT_EXOCET_40)
			{
				
			}
			else
			/* TORPEDO A244 */
			if (Missile->mWeaponID == CT_TORPEDO_A244S)
			{
				
			}
			else
			/* TORPEDO SUT */
			if (Missile->mWeaponID == CT_TORPEDO_SUT)
			{
				
			}
		}
	}

	/* Main Observer */
	if ( mPlayerID == 0)
	{
		attachedProxy = GetMissileActors(mLockFireShipID,mLockFireWeaponID,mLockFireLauncherID,mLockFireMissileID,mLockFireMissNumberID);
		if (attachedProxy.valid())
		{
			dtCore::RefPtr<MissilesActor> Missile = static_cast<MissilesActor*>(attachedProxy->GetActor());

			/* RBU */
			if (Missile->mWeaponID == CT_RBU_6000)
			{
				dtCore::Transform lbaRBUTransform;
				osg::Vec3 lbaPos, lbaRot;

				dtCore::Transform missileTransform;
				osg::Vec3 missPos, missRot;

				Missile->GetTransform(missileTransform);
				missileTransform.GetTranslation(missPos);
				missileTransform.GetRotation(missRot);

				attachedProxy2 = GetLauncherActors(C_WEAPON_TYPE_BODY, mLockFireShipID, mLockFireWeaponID, mLockFireLauncherID);
				attachedProxy3 = GetVehicleActorByID(targetIDRBU);

				if (attachedProxy2.valid() && attachedProxy3.valid())
				{
					dtCore::RefPtr<LauncherBodyActor> tgt = static_cast<LauncherBodyActor*>(attachedProxy2->GetActor());
					tgt->GetTransform(lbaRBUTransform);
					lbaRBUTransform.GetTranslation(lbaPos); 
					lbaRBUTransform.GetRotation(lbaRot);
					//std::cout<<"Launcer Degree: "<<lbaRot[0]<<std::endl;=
					dtCore::Transform RBUTgtTransform;
					osg::Vec3 tgtPos;
					dtCore::RefPtr<VehicleActor> tgt2 = static_cast<VehicleActor*>(attachedProxy3->GetActor());
					tgt2->GetTransform(RBUTgtTransform);
					RBUTgtTransform.GetTranslation(tgtPos); 
					float dist = CalculateVec3Distance(lbaPos, tgtPos);
					//std::cout<<"Target Range: "<<dist<<std::endl;

					//panjang titik tengah range Asroc
					float midRBUPos = dist/2;
					float headinglauncher;
					headinglauncher = -lbaRot[0];

					//Step 1
					if (LockingStepObs0 == 0)
					{
						camPlayerPOS = RangeBearingToCoord(lbaPos, midRBUPos, ValidateDegree(headinglauncher));
						camPlayerPOS = RangeBearingToCoord(camPlayerPOS, midRBUPos/1.5, ValidateDegree(headinglauncher +90));
						camPlayerPOS[2] = 20;

						camPlayerROT[0] = -(ValidateDegree(headinglauncher + 225));

						camPlayerTrans.SetTranslation(camPlayerPOS);
						camPlayerTrans.SetRotation(camPlayerROT);
						SetTransform(camPlayerTrans);

						LockingStepObs0 = 1;
					}
					//Step 2
					else if (LockingStepObs0 == 1)
					{
						float bearingCamtoMiss = ComputeBearingTo2(camPlayerPOS[0], camPlayerPOS[1], missPos[0], missPos[1]);
						float distCamtoMiss = RangeVec3(missPos, camPlayerPOS);

						float camDegtoMiss;

						if ((missPos[2]/distCamtoMiss) > 1)
						{
							float aSinCalc = 2 - (missPos[2]/distCamtoMiss);
							camDegtoMiss = osg::RadiansToDegrees(asin(aSinCalc));
						}
						else
						{
							camDegtoMiss = osg::RadiansToDegrees(asin(missPos[2]/distCamtoMiss));
						}

						//std::cout<<"sudut rotasi: "<<testing<<std::endl;

						camPlayerROT[0] = (-bearingCamtoMiss);
						camPlayerROT[1] = camDegtoMiss;
						camPlayerTrans.SetRotation(camPlayerROT);
						SetTransform(camPlayerTrans);

						float dist2 = CalculateVec3Distance(lbaPos, missPos);

						if (dist2 >= midRBUPos) 
						{
							LockingStepObs0 = 2;
						}
					}

					//Step 3
					else if (LockingStepObs0 == 2)
					{
						float bearingCamtoTarget = ValidateDegree(ComputeBearingTo2(camPlayerPOS[0], camPlayerPOS[1], tgtPos[0], tgtPos[1]));
						float bearingCamtoMiss = ComputeBearingTo2(camPlayerPOS[0], camPlayerPOS[1], missPos[0], missPos[1]);
						float distCamtoMiss = RangeVec3(missPos, camPlayerPOS);
						float camDegtoMiss = osg::RadiansToDegrees(asin(missPos[2]/distCamtoMiss));
						float distCamtoTarget = CalculateVec3Distance(camPlayerPOS, tgtPos);

						float moveRate = 100.0f;
						camPlayerPOS = RangeBearingToCoord(camPlayerPOS, moveRate*dt, ValidateDegree(bearingCamtoTarget));
						
						if (camDegtoMiss >= 5)
						{
							camPlayerROT[0] = (-bearingCamtoMiss);
							camPlayerROT[1] = camDegtoMiss;
						}
						
						//std::cout<<"deg : "<<distCamtoTarget<<std::endl;
						if (distCamtoTarget <= 800)
						{
							LockingStepObs0 = 3;
						}

						camPlayerTrans.SetTranslation(camPlayerPOS);
						camPlayerTrans.SetRotation(camPlayerROT);
						SetTransform(camPlayerTrans);	
					}
					//Step 4
					else if (LockingStepObs0 == 3)
					{
						float bearingCamtoMiss = ComputeBearingTo2(camPlayerPOS[0], camPlayerPOS[1], missPos[0], missPos[1]);
						float distCamtoMiss = RangeVec3(missPos, camPlayerPOS);
						float camDegtoMiss = osg::RadiansToDegrees(asin(missPos[2]/distCamtoMiss));

						camPlayerROT[0] = (-bearingCamtoMiss);
						camPlayerROT[1] = camDegtoMiss;

						if(missPos[2] <= 0)
						{
							camPlayerPOS[2] = 0;
							LockingStepObs0 = 4;
						}
						
						camPlayerTrans.SetRotation(camPlayerROT);
						camPlayerTrans.SetTranslation(camPlayerPOS);
						SetTransform(camPlayerTrans);
					}

					else if (LockingStepObs0 == 4)
					{
						float bearingCamtoMiss = ComputeBearingTo2(camPlayerPOS[0], camPlayerPOS[1], missPos[0], missPos[1]);
						float distCamtoMiss = RangeVec3(missPos, camPlayerPOS);
						float camDegtoMiss = osg::RadiansToDegrees(asin(missPos[2]/distCamtoMiss));

						camPlayerPOS[2] = camPlayerPOS[2] - (0.5f*dt);
						camPlayerROT[0] = (-bearingCamtoMiss);
						camPlayerROT[1] = camDegtoMiss;

						camPlayerTrans.SetRotation(camPlayerROT);
						camPlayerTrans.SetTranslation(camPlayerPOS);
						SetTransform(camPlayerTrans);
					}
				}
			}
			else
			/* ASROC */
			if (Missile->mWeaponID == CT_ASROC)
			{
				dtCore::Transform lbaAsrTransform;
				osg::Vec3 lbaPos, lbaRot;

				dtCore::Transform missileTransform;
				osg::Vec3 missPos, missRot;
				
				Missile->GetTransform(missileTransform);
				missileTransform.GetTranslation(missPos);
				missileTransform.GetRotation(missRot);
				
				attachedProxy2 = GetLauncherActors(C_WEAPON_TYPE_BODY, mLockFireShipID, mLockFireWeaponID, mLockFireLauncherID);
				attachedProxy3 = GetVehicleActorByID(targetIDAsrock);

				if (attachedProxy2.valid() && attachedProxy3.valid())
				{
					dtCore::RefPtr<LauncherBodyActor> tgt = static_cast<LauncherBodyActor*>(attachedProxy2->GetActor());
					tgt->GetTransform(lbaAsrTransform);
					lbaAsrTransform.GetTranslation(lbaPos); 
					lbaAsrTransform.GetRotation(lbaRot);
					//std::cout<<"Launcer Degree: "<<lbaRot[0]<<std::endl;=
					dtCore::Transform asrTgtTransform;
					osg::Vec3 tgtPos;
					dtCore::RefPtr<VehicleActor> tgt2 = static_cast<VehicleActor*>(attachedProxy3->GetActor());
					tgt2->GetTransform(asrTgtTransform);
					asrTgtTransform.GetTranslation(tgtPos); 
					float dist = CalculateVec3Distance(lbaPos, tgtPos);
					//std::cout<<"Target Range: "<<dist<<std::endl;

					//panjang titik tengah range Asroc
					float midAsrPos = dist/2;
					float headinglauncher;
					headinglauncher = -lbaRot[0];

					//Step 1
					if (LockingStepObs0 == 0)
					{
						camPlayerPOS = RangeBearingToCoord(lbaPos, midAsrPos, ValidateDegree(headinglauncher));
						camPlayerPOS = RangeBearingToCoord(camPlayerPOS, midAsrPos/1.5, ValidateDegree(headinglauncher +90));
						camPlayerPOS[2] = 20;

						camPlayerROT[0] = -(ValidateDegree(headinglauncher + 225));

						camPlayerTrans.SetTranslation(camPlayerPOS);
						camPlayerTrans.SetRotation(camPlayerROT);
						SetTransform(camPlayerTrans);

						LockingStepObs0 = 1;
					}
					//Step 2
					else if (LockingStepObs0 == 1)
					{
						float bearingCamtoMiss = ComputeBearingTo2(camPlayerPOS[0], camPlayerPOS[1], missPos[0], missPos[1]);
						float distCamtoMiss = RangeVec3(missPos, camPlayerPOS);

						float camDegtoMiss;

						if ((missPos[2]/distCamtoMiss) > 1)
						{
							float aSinCalc = 2 - (missPos[2]/distCamtoMiss);
							camDegtoMiss = osg::RadiansToDegrees(asin(aSinCalc));
						}
						else
						{
							camDegtoMiss = osg::RadiansToDegrees(asin(missPos[2]/distCamtoMiss));
						}

						//std::cout<<"sudut rotasi: "<<testing<<std::endl;

						camPlayerROT[0] = (-bearingCamtoMiss);
						camPlayerROT[1] = camDegtoMiss;

						float dist2 = CalculateVec3Distance(lbaPos, missPos);

						if (dist2 >= midAsrPos) 
						{
							LockingStepObs0 = 2;
						}

						camPlayerTrans.SetRotation(camPlayerROT);
						SetTransform(camPlayerTrans);
					}

					//Step 3
					else if (LockingStepObs0 == 2)
					{
						float bearingCamtoTarget = ComputeBearingTo2(camPlayerPOS[0], camPlayerPOS[1], tgtPos[0], tgtPos[1]);
						float bearingCamtoMiss = ComputeBearingTo2(camPlayerPOS[0], camPlayerPOS[1], missPos[0], missPos[1]);
						float distCamtoMiss = RangeVec3(missPos, camPlayerPOS);
						float camDegtoMiss = osg::RadiansToDegrees(asin(missPos[2]/distCamtoMiss));
						float distCamtoTarget = CalculateVec3Distance(camPlayerPOS, tgtPos);

						float moveRate = 300.0f;
						camPlayerPOS = RangeBearingToCoord(camPlayerPOS, moveRate*dt, ValidateDegree(bearingCamtoTarget));
						
						if (camDegtoMiss >= 5)
						{
							camPlayerROT[0] = (-bearingCamtoMiss);
							camPlayerROT[1] = camDegtoMiss;
						}
						//std::cout<<"dist : "<<distCamtoTarget<<std::endl;
						//std::cout<<"deg : "<<ValidateDegree(bearingCamtoTarget)<<std::endl;
						if (distCamtoTarget <= 400)
						{
							LockingStepObs0 = 3;
						}

						camPlayerTrans.SetTranslation(camPlayerPOS);
						camPlayerTrans.SetRotation(camPlayerROT);
						SetTransform(camPlayerTrans);	
					}
					//Step 4
					else if (LockingStepObs0 == 3)
					{
						float bearingCamtoMiss = ComputeBearingTo2(camPlayerPOS[0], camPlayerPOS[1], missPos[0], missPos[1]);
						float distCamtoMiss = RangeVec3(missPos, camPlayerPOS);
						float camDegtoMiss = osg::RadiansToDegrees(asin(missPos[2]/distCamtoMiss));


						camPlayerROT[0] = (-bearingCamtoMiss);
						camPlayerROT[1] = camDegtoMiss;

						if(missPos[2] <= 0)
						{
							camPlayerPOS[2] = 0;
							LockingStepObs0 = 4;
						}
						
						//std::cout<<"misspos z: "<<missPos[2]<<std::endl;
						//std::cout<<"z: "<<camPlayerPOS[2]<<std::endl;
						camPlayerTrans.SetRotation(camPlayerROT);
						camPlayerTrans.SetTranslation(camPlayerPOS);
						SetTransform(camPlayerTrans);
					}

					else if (LockingStepObs0 == 4)
					{
						float bearingCamtoMiss = ComputeBearingTo2(camPlayerPOS[0], camPlayerPOS[1], missPos[0], missPos[1]);
						float distCamtoMiss = RangeVec3(missPos, camPlayerPOS);
						float camDegtoMiss = osg::RadiansToDegrees(asin(missPos[2]/distCamtoMiss));

						camPlayerPOS[2] = camPlayerPOS[2] - (0.5f*dt);
						camPlayerROT[0] = (-bearingCamtoMiss);
						camPlayerROT[1] = camDegtoMiss;

						camPlayerTrans.SetRotation(camPlayerROT);
						camPlayerTrans.SetTranslation(camPlayerPOS);
						SetTransform(camPlayerTrans);
					}
				}

			}
			else
			/* YAKHONT */
			if (Missile->mWeaponID == CT_YAKHONT)
			{
				/*CameraHeading	= 0;
				CameraRange		= 100;
				CameraPitch		= 5;
				run_as_ViewObject(dt);*/

				//attachedProxy = GetMissileActors(mLockFireShipID, mLockFireWeaponID, mLockFireLauncherID, mLockFireMissileID, mLockFireMissNumberID);
				dtCore::RefPtr<YakhontMissileActor> YakhontMissile = static_cast<YakhontMissileActor*>(attachedProxy->GetActor());
				int mPhase = YakhontMissile->mPhase;
				int mTrack = YakhontMissile->mMissileTrack;
				
				//std::cout << "mTrack = " << mTrack << std::endl;

				if (mTrack == 1)
				{
					yakhontFirstMode(mPhase, mLockFireShipID, mLockFireWeaponID, mLockFireLauncherID, mLockFireMissileID, mLockFireMissNumberID, dt);
				}
				else if (mTrack == 2)
				{
					yakhontSecondMode(mPhase, mLockFireShipID, mLockFireWeaponID, mLockFireLauncherID, mLockFireMissileID, mLockFireMissNumberID, dt);
				}
				else if (mTrack == 3)
				{
					yakhontThirdMode(mPhase, mLockFireShipID, mLockFireWeaponID, mLockFireLauncherID, mLockFireMissileID, mLockFireMissNumberID, dt);
				}
				else if (mTrack == 4)
				{
					yakhontFourthMode(mPhase, mLockFireShipID, mLockFireWeaponID, mLockFireLauncherID, mLockFireMissileID, mLockFireMissNumberID, dt);
				}
				else if (mTrack == 0)
				{
					yakhontRelease(mLockFireShipID, mLockFireWeaponID, mLockFireLauncherID, mLockFireMissileID, mLockFireMissNumberID, dt);
				}

			}
			else
			/* C802 */
			if (Missile->mWeaponID == CT_C802)
			{
				dtCore::Transform shipTransform;
				osg::Vec3 shipPos, shipRot;

				attachedProxy2 = GetVehicleActorByID(mLockFireShipID);

				if (attachedProxy2.valid())
				{
					dtCore::RefPtr<C802MissileActor> c802Missile = static_cast<C802MissileActor*>(attachedProxy->GetActor());

					dtCore::RefPtr<VehicleActor> ship = static_cast<VehicleActor*>(attachedProxy2->GetActor());
					ship->GetTransform(shipTransform);
					shipTransform.GetTranslation(shipPos);
					shipTransform.GetRotation(shipRot);

					dtCore::Transform missileTransform;
					osg::Vec3 missPos, missRot;
					Missile->GetTransform(missileTransform);
					missileTransform.GetTranslation(missPos);
					missileTransform.GetRotation(missRot);

					float degreeCam(0.0f); 
					float degreeTurnMis(0.0f);
					//float acceleration;
					
					if (LockingStepObs0 == 0)
					{
						if (mLockFireLauncherID == 1 || mLockFireLauncherID == 3)
						{
							degreeCam = 90;
							degreeTurnMis = 45;
						}
						else if (mLockFireLauncherID == 2 || mLockFireLauncherID == 4)
						{
							degreeCam = -90;
							degreeTurnMis = -45;
						}
		
						camPlayerPOS = RangeBearingToCoord(shipPos, 300, (-shipRot[0]) + degreeCam);
						camPlayerPOS = RangeBearingToCoord(camPlayerPOS, 650, ((-shipRot[0]) + 180));
						camPlayerPOS[2] = 30;
						//std::cout<<"tes : "<<camPlayerPOS[2]<<std::endl;	

						float bearingCamtoMiss = ComputeBearingTo2(camPlayerPOS[0], camPlayerPOS[1], missPos[0], missPos[1]);
						float distCamtoMiss = RangeVec3(missPos, camPlayerPOS);
						float camDegtoMiss;

						if ((missPos[2]/distCamtoMiss) > 1)
						{
							float aSinCalc = 2 - (missPos[2]/distCamtoMiss);
							camDegtoMiss = osg::RadiansToDegrees(asin(aSinCalc));
						}
						else
						{
							camDegtoMiss = osg::RadiansToDegrees(asin(missPos[2]/distCamtoMiss));
						}

						camPlayerROT[0] = (-bearingCamtoMiss);
						camPlayerROT[1] = camDegtoMiss;

						float dist = CalculateVec3Distance(shipPos, missPos);
						if (dist >= 1500)
						{
							LockingStepObs0 = 1;
						}

						camPlayerTrans.SetTranslation(camPlayerPOS);
						camPlayerTrans.SetRotation(camPlayerROT);
						SetTransform(camPlayerTrans);

						
						//float dist = CalculateVec3Distance(shipPos, missPos);
					}
					else if (LockingStepObs0 == 1)
					{
						float bearingCamtoMiss = ComputeBearingTo2(camPlayerPOS[0], camPlayerPOS[1], missPos[0], missPos[1]);
		
						camPlayerPOS = RangeBearingToCoord(camPlayerPOS, 400.0f*dt, ValidateDegree(bearingCamtoMiss));
						//camPlayerPOS[2] = missPos[2] + 10;
						
						if (camPlayerPOS[2] <= (camPlayerPOS[2] + 10))
						{
							camPlayerPOS[2] = camPlayerPOS[2] + (1.5* dt);
						}

						if (camPlayerROT[1] >= -10)
						{
							camPlayerROT[1] = camPlayerROT[1] - (1.5f * dt);
						}
						
						camPlayerROT[0] = (-bearingCamtoMiss);
						//camPlayerROT[1] = -10;

						//std::cout<<"tes2 : "<<camPlayerPOS.z()<<std::endl;
						
						float dist = CalculateVec3Distance(camPlayerPOS, missPos);

						if (dist <= 100)
						{
							CameraHeading = 0;
							LockingStepObs0 = 2;
						}

						camPlayerTrans.SetTranslation(camPlayerPOS);
						camPlayerTrans.SetRotation(camPlayerROT);
						SetTransform(camPlayerTrans);

					}
					else if (LockingStepObs0 == 2)
					{
						if (isReadyToCircle)
						{
							CameraHeading	= CameraHeading + (30.0f * dt);
							CameraRange		= 100;
							CameraPitch		= 10;
							run_as_ViewObject(dt);

							if (CameraHeading >= 360)
							{
								isReadyToCircle = false;
								CameraHeading = 0;
							}
						}
						else
						{
							timeToCircle = timeToCircle + (10 * dt);

							CameraHeading	= 0;
							CameraRange		= 100;
							CameraPitch		= 10;
							run_as_ViewObject(dt);

							if (timeToCircle > 30)
							{
								isReadyToCircle = false;
								timeToCircle = 0;
							}
						}

						if (c802Missile->mShipTarget != NULL)
							{
								LockingStepObs0 = 3;
								//isReadyToCircle = false;
							}
					}

					else if (LockingStepObs0 == 3)
					{
						dtCore::Transform TargetTrans ;
						osg::Vec3 TargetPOS, TargetROT;
						
						if (c802Missile->mShipTarget == NULL)
						{
							LockingStepObs0 = 2;
						}
						else 
						{
							dynamic_cast<VehicleActor*>(c802Missile->mShipTarget.get())->GetTransform(TargetTrans);
							TargetTrans.GetTranslation(TargetPOS);
							TargetTrans.GetRotation(TargetROT);
							//std::cout<<"tes : "<<dist<<std::endl;
							float dist = CalculateVec3Distance(missPos, TargetPOS);

							if (isReadyToCircle)
							{
								CameraHeading	= CameraHeading + (30.0f * dt);
								CameraRange		= 100;
								CameraPitch		= 10;
								run_as_ViewObject(dt);

								if (CameraHeading >= 360)
								{
									isReadyToCircle = false;
									CameraHeading = 0;
								}
							}
							else
							{
								timeToCircle = timeToCircle + (10 * dt);

								CameraHeading	= 0;
								CameraRange		= 100;
								CameraPitch		= 10;
								run_as_ViewObject(dt);

								if (timeToCircle > 30)
								{
									isReadyToCircle = false;
									timeToCircle = 0;
								}

							}

							if (dist >= 500 && dist <= 2000)
							{
								LockingStepObs0 = 4;	
							}

						}
					}
					else if (LockingStepObs0 == 4)
					{
						dtCore::Transform TargetTrans ;
						osg::Vec3 TargetPOS, TargetROT;
						
						if (c802Missile->mShipTarget == NULL)
						{
							LockingStepObs0 = 2;
						}
						else
						{
							dynamic_cast<VehicleActor*>(c802Missile->mShipTarget.get())->GetTransform(TargetTrans);
							TargetTrans.GetTranslation(TargetPOS);
							TargetTrans.GetRotation(TargetROT);

							CameraHeading	= 0;
							CameraRange		= 100;
							CameraPitch		= 10;
							run_as_ViewObject(dt);

							float dist = CalculateVec3Distance(missPos, TargetPOS);

							if (dist <= 500)
							{
								LockingStepObs0 = 5;
							}
						}
					}
					else if (LockingStepObs0 == 5)
					{
						camPlayerPOS = RangeBearingToCoord(camPlayerPOS, 50.0f*dt, missRot[0] + degreeTurnMis);
						float bearingCamtoMiss = ComputeBearingTo2(camPlayerPOS[0], camPlayerPOS[1], missPos[0], missPos[1]);

						camPlayerROT[0] = (-bearingCamtoMiss);

						camPlayerTrans.SetTranslation(camPlayerPOS);
						camPlayerTrans.SetRotation(camPlayerROT);
						SetTransform(camPlayerTrans);
					}				
				}
			}
			else
			/* EXOCETMM40 */
			if (Missile->mWeaponID == CT_EXOCET_40)
			{
				dtCore::Transform shipTransform;
				osg::Vec3 shipPos, shipRot;

				attachedProxy2 = GetVehicleActorByID(mLockFireShipID);

				if (attachedProxy2.valid())
				{
					dtCore::RefPtr<ExocetMM40Actor> exxocetMissile = static_cast<ExocetMM40Actor*>(attachedProxy->GetActor());
					dtCore::RefPtr<VehicleActor> ship = static_cast<VehicleActor*>(attachedProxy2->GetActor());
					ship->GetTransform(shipTransform);
					shipTransform.GetTranslation(shipPos);
					shipTransform.GetRotation(shipRot);

					dtCore::Transform missileTransform;
					osg::Vec3 missPos, missRot;
					Missile->GetTransform(missileTransform);
					missileTransform.GetTranslation(missPos);
					missileTransform.GetRotation(missRot);

					float degreeCam(0.0f), degreeTurnMis(0.0f);

					if (LockingStepObs0 == 0)
					{
						int cameraStyle;

						if (mLockFireLauncherID == 1)
						{
							degreeCam = 90;
							degreeTurnMis = 45;
							
							if (rangeBearingExo <= ((-shipRot[0]) + 90))
							{
								cameraStyle = 1;
							}
							else if (rangeBearingExo > ((-shipRot[0]) + 90))
							{
								cameraStyle = 2;
							}
						}
						else if (mLockFireLauncherID == 2)
						{
							degreeCam = -90;
							degreeTurnMis = -45;

							if (rangeBearingExo > ((-shipRot[0]) + 270))
							{
								cameraStyle = 1;
							}
							else if (rangeBearingExo <= ((-shipRot[0]) + 270))
							{
								cameraStyle = 2;
							}
						}

						float dist = CalculateVec3Distance(shipPos, missPos);
						camPlayerPOS = RangeBearingToCoord(shipPos, rangeCamExo,(-shipRot[0]) + degreeCam);
						
						if (cameraStyle == 1)
						{
							camPlayerPOS = RangeBearingToCoord(camPlayerPOS, 400, ((-shipRot[0]) + 180));
						}
						else if (cameraStyle == 2)
						{
							camPlayerPOS = RangeBearingToCoord(camPlayerPOS, -400, ((-shipRot[0]) + 180));	
						}
			
						camPlayerPOS[2] = camPlayerPOS[2] + 5 ;
							
						float bearingCamtoMiss = ComputeBearingTo2(camPlayerPOS[0], camPlayerPOS[1], missPos[0], missPos[1]);
						float distCamtoMiss = RangeVec3(missPos, camPlayerPOS);
						float camDegtoMiss;

						if ((missPos[2]/distCamtoMiss) > 1)
						{
							float aSinCalc = 2 - (missPos[2]/distCamtoMiss);
							camDegtoMiss = osg::RadiansToDegrees(asin(aSinCalc));
						}
						else
						{
							camDegtoMiss = osg::RadiansToDegrees(asin(missPos[2]/distCamtoMiss));
						}

						camPlayerROT[0] = (-bearingCamtoMiss);
						camPlayerROT[1] = camDegtoMiss;
						
						//std::cout<<"dist : "<<dist<<std::endl;
						if (dist >= 2000)
						{
							LockingStepObs0 = 1;
						}

						camPlayerTrans.SetTranslation(camPlayerPOS);
						camPlayerTrans.SetRotation(camPlayerROT);
						SetTransform(camPlayerTrans);
					}

					else if (LockingStepObs0 == 1)
					{
						float bearingCamtoMiss = ComputeBearingTo2(camPlayerPOS[0], camPlayerPOS[1], missPos[0], missPos[1]);
		
						camPlayerPOS = RangeBearingToCoord(camPlayerPOS, 400.0f*dt, ValidateDegree(bearingCamtoMiss));
						
						if (camPlayerPOS[2] <= (missPos[2] + 10))
						{
							camPlayerPOS[2] = camPlayerPOS[2] + (2.5* dt);
						}

						if (camPlayerROT[1] >= -10)
						{
							camPlayerROT[1] = camPlayerROT[1] - (1.5f * dt);
						}
						
						camPlayerROT[0] = (-bearingCamtoMiss);
				
						float dist = CalculateVec3Distance(camPlayerPOS, missPos);

						if (dist <= 100)
						{
							LockingStepObs0 = 2;
							CameraHeading	= 0;
						}

						camPlayerTrans.SetTranslation(camPlayerPOS);
						camPlayerTrans.SetRotation(camPlayerROT);
						SetTransform(camPlayerTrans);
					}
					else if (LockingStepObs0 == 2)
					{
						//std::cout<<"circle :"<<isReadyToCircle<<std::endl;
						if (isReadyToCircle)
						{
							CameraHeading	= CameraHeading + (30.0f * dt);
							CameraRange		= 100;
							CameraPitch		= 10;
							run_as_ViewObject(dt);

							if (CameraHeading >= 360)
							{
								isReadyToCircle = false;
								CameraHeading = 0;
							}
						}
						else
						{
							timeToCircle = timeToCircle + (10 * dt);

							CameraHeading	= 0;
							CameraRange		= 100;
							CameraPitch		= 10;
							run_as_ViewObject(dt);

							if (timeToCircle > 30)
							{
								isReadyToCircle = false;
								timeToCircle = 0;
							}
						}

						if (exxocetMissile->mShipTarget != NULL)
							{
								if (angularMode == 0)
								{
									LockingStepObs0 = 3;
								}
								else
								{
									LockingStepObs0 = 6;
								}
							}

					}
					else if (LockingStepObs0 == 3)
					{
						dtCore::Transform TargetTrans ;
						osg::Vec3 TargetPOS, TargetROT;
						
						if (exxocetMissile->mShipTarget == NULL)
						{
							LockingStepObs0 = 2;
						}
						else
						{
							dynamic_cast<VehicleActor*>(exxocetMissile->mShipTarget.get())->GetTransform(TargetTrans);
							TargetTrans.GetTranslation(TargetPOS);
							TargetTrans.GetRotation(TargetROT);

							float dist = CalculateVec3Distance(missPos, TargetPOS);

							if (isReadyToCircle)
							{
								CameraHeading	= CameraHeading + (30.0f * dt);
								CameraRange		= 100;
								CameraPitch		= 10;
								run_as_ViewObject(dt);

								if (CameraHeading >= 360)
								{
									isReadyToCircle = false;
									CameraHeading = 0;
								}
							}
							else
							{
								timeToCircle = timeToCircle + (10 * dt);

								CameraHeading	= 0;
								CameraRange		= 100;
								CameraPitch		= 10;
								run_as_ViewObject(dt);

								if (timeToCircle > 30)
								{
									isReadyToCircle = false;
									timeToCircle = 0;
								}

							}

							if (dist >= 500 && dist <= 2000)
							{
								LockingStepObs0 = 4;	
							}

						}
					}

					else if (LockingStepObs0 == 4)
					{
						dtCore::Transform TargetTrans ;
						osg::Vec3 TargetPOS, TargetROT;
						
						if (exxocetMissile->mShipTarget == NULL)
						{
							LockingStepObs0 = 2;
						}
						else
						{
							dynamic_cast<VehicleActor*>(exxocetMissile->mShipTarget.get())->GetTransform(TargetTrans);
							TargetTrans.GetTranslation(TargetPOS);
							TargetTrans.GetRotation(TargetROT);

							CameraHeading	= 0;
							CameraRange		= 100;
							CameraPitch		= 10;
							run_as_ViewObject(dt);

							float dist = CalculateVec3Distance(missPos, TargetPOS);

							if (dist <= 500)
							{
								LockingStepObs0 = 5;
							}
						}
					}

					else if (LockingStepObs0 == 5)
					{	
						float dist = CalculateVec3Distance(missPos, camPlayerPOS);

						if (dist > 500)
						{
							LockingStepObs0 = 1;
						}
						else
						{
							camPlayerPOS = RangeBearingToCoord(camPlayerPOS, 50.0f*dt, missRot[0] + degreeTurnMis);
							float bearingCamtoMiss = ComputeBearingTo2(camPlayerPOS[0], camPlayerPOS[1], missPos[0], missPos[1]);

							camPlayerROT[0] = (-bearingCamtoMiss);

							camPlayerTrans.SetTranslation(camPlayerPOS);
							camPlayerTrans.SetRotation(camPlayerROT);
							SetTransform(camPlayerTrans);
						}
					}

					else if (LockingStepObs0 == 6)
					{
						dtCore::Transform TargetTrans ;
						osg::Vec3 TargetPOS, TargetROT;

						if (exxocetMissile->mShipTarget != NULL)
						{
							dynamic_cast<VehicleActor*>(exxocetMissile->mShipTarget.get())->GetTransform(TargetTrans);
							TargetTrans.GetTranslation(TargetPOS);
							TargetTrans.GetRotation(TargetROT);
						}
						else
						{
							LockingStepObs0 = 1;
						}

						float bearingCamtoMiss = ComputeBearingTo2(camPlayerPOS[0], camPlayerPOS[1], missPos[0], missPos[1]);
						float bearingCamtoTarget =ComputeBearingTo2(camPlayerPOS[0], camPlayerPOS[1], TargetPOS[0], TargetPOS[1]);

						camPlayerPOS = RangeBearingToCoord(camPlayerPOS, 250.0f*dt, ValidateDegree(bearingCamtoTarget));
						camPlayerROT[0] = -bearingCamtoMiss;
						
						camPlayerTrans.SetTranslation(camPlayerPOS);
						camPlayerTrans.SetRotation(camPlayerROT);
						SetTransform(camPlayerTrans);
					}
				}
	
			}
			else
			/* TORPEDO A244 */
			if (Missile->mWeaponID == CT_TORPEDO_A244S)
			{
				dtCore::Transform shipTransform;
				osg::Vec3 shipPos, shipRot;

				attachedProxy2	= GetVehicleActorByID(mLockFireShipID);

				if (attachedProxy2.valid())
				{
					dtCore::RefPtr<VehicleActor> ship = static_cast<VehicleActor*>(attachedProxy2->GetActor());
					ship->GetTransform(shipTransform);
					shipTransform.GetTranslation(shipPos);
					shipTransform.GetRotation(shipRot);

					dtCore::Transform missileTransform;
					osg::Vec3 missPos, missRot;
					Missile->GetTransform(missileTransform);
					missileTransform.GetTranslation(missPos);
					missileTransform.GetRotation(missRot);
					float launcherDegree;

					if (mLockFireLauncherID == 1)
					{
						launcherDegree = 90;
					}
					else if (mLockFireLauncherID == 2)
					{
						launcherDegree = -90;
					}
					
					if (LockingStepObs0 == 0)
					{		
						camPlayerPOS = RangeBearingToCoord(shipPos, 50, (shipRot[0] + launcherDegree));
						camPlayerPOS = RangeBearingToCoord(camPlayerPOS, 100, (shipRot[0] + 180));
						
						//camPlayerPOS = RangeBearingToCoord(missPos, 50, (missRot[0] - 90));
						float bearingCamtoMiss = ComputeBearingTo2(camPlayerPOS[0], camPlayerPOS[1], missPos[0], missPos[1]);
						
						camPlayerPOS[2] = missPos[2];
						camPlayerROT[0] = (-bearingCamtoMiss);
						
						float distshiptoMiss = CalculateVec3Distance(shipPos, missPos);
						if (distshiptoMiss >= 200)
						{
							LockingStepObs0 = 1;
						}
						//std::cout<<"tes : "<<distCamtoMiss<<std::endl;
						camPlayerTrans.SetTranslation(camPlayerPOS);
						camPlayerTrans.SetRotation(camPlayerROT);
						SetTransform(camPlayerTrans);
					}
					else if (LockingStepObs0 == 1)
					{
						/*camPlayerPOS = RangeBearingToCoord(missPos, 50, (missRot[0] - launcherDegree));
						camPlayerPOS[2] = missPos[2];

						camPlayerTrans.SetTranslation(camPlayerPOS);
						camPlayerTrans.SetRotation(camPlayerROT);
						SetTransform(camPlayerTrans);

						LockingStepObs0 = 2;*/

						float bearingCamtoMiss = ComputeBearingTo2(camPlayerPOS[0], camPlayerPOS[1], missPos[0], missPos[1]);
						camPlayerPOS = RangeBearingToCoord(camPlayerPOS, 50.0f*dt, ValidateDegree(bearingCamtoMiss));

						camPlayerROT[0] = (-bearingCamtoMiss);

						float dist = CalculateVec3Distance(missPos, camPlayerPOS);

						if (dist <= 100)
						{
							LockingStepObs0 = 2;
						}

						camPlayerTrans.SetTranslation(camPlayerPOS);
						camPlayerTrans.SetRotation(camPlayerROT);
						SetTransform(camPlayerTrans);

					}

					else if (LockingStepObs0 == 2)
					{
						/*
						float bearingCamtoMiss = ComputeBearingTo2(camPlayerPOS[0], camPlayerPOS[1], missPos[0], missPos[1]);
						float distcamtoMiss = CalculateVec3Distance(camPlayerPOS, missPos);

						if (distcamtoMiss >= 200)
						{
							LockingStepObs0 = 1;
						}

						camPlayerTrans.SetRotation(camPlayerROT);
						SetTransform(camPlayerTrans);*/

						float bearingCamtoMiss = ComputeBearingTo2(camPlayerPOS[0], camPlayerPOS[1], missPos[0], missPos[1]);

						camPlayerPOS = RangeBearingToCoord(camPlayerPOS, 18.0f*dt, ValidateDegree(bearingCamtoMiss));

						if (camPlayerPOS[2] >= (camPlayerPOS[2] - 3))
						{
							camPlayerPOS[2] = camPlayerPOS[2] - (0.5 * dt);
						}

						if (camPlayerROT[1] <= 3)
						{
							camPlayerROT[1] = camPlayerROT[1] + (10.0f * dt);
						}

						//float distCamtoMiss = RangeVec3(missPos, camPlayerPOS);
						//float camDegtoMiss = osg::RadiansToDegrees(asin(missPos[2]/distCamtoMiss));

						camPlayerROT[0] = (-bearingCamtoMiss);
						//camPlayerROT[1] = camDegtoMiss;
						//std::cout<<"s : "<<camPlayerROT[1]<<std::endl;

						float dist = CalculateVec3Distance(missPos, camPlayerPOS);
						//std::cout<<"s : "<<dist<<std::endl;

						if (dist <= 70)
						{
							//CameraHeading = bearingCamtoMiss;
							LockingStepObs0 = 3;
						}

						camPlayerTrans.SetTranslation(camPlayerPOS);
						camPlayerTrans.SetRotation(camPlayerROT);
						SetTransform(camPlayerTrans);
					}

					else if (LockingStepObs0 == 3)
					{

						CameraHeading	= 0;
						CameraRange		= 70;
						CameraPitch		= -3;

						
						float Mx, My;
						float newRange, newAlt;
						float SinX, CosX;

						dtCore::RefPtr<dtGame::GameActor> ObjView = static_cast<dtGame::GameActor*>(attachedProxy->GetActor());	

						// Object Transform
						ObjView->GetTransform(targetTransform);
						targetTransform.GetTranslation(targetPosition);
						targetTransform.GetRotation(targetRotation);

						// Camera Transform
						dtCore::Transform camPlayerTrans;
						osg::Vec3 camPlayerPOS, camPlayerROT; 
						GetTransform(camPlayerTrans);
						camPlayerTrans.GetTranslation(camPlayerPOS);
						camPlayerTrans.GetRotation(camPlayerROT);

						camPlayerROT[0] =  targetRotation[0] + CameraHeading; 
						camPlayerROT[1] = -CameraPitch;
						camPlayerROT[2] = 0;

						newRange = cos(osg::DegreesToRadians(CameraPitch)) * -CameraRange;
						newAlt	 = sin(osg::DegreesToRadians(CameraPitch)) * CameraRange;
						SinX	 = sin(osg::DegreesToRadians(ConvCompass_To_Cartesian(ValidateDegree( -camPlayerROT[0] ))));
						CosX	 = cos(osg::DegreesToRadians(ConvCompass_To_Cartesian(ValidateDegree( -camPlayerROT[0] ))));
						Mx		 = newRange * CosX;
						My		 = newRange * SinX;

						camPlayerPOS.x() = targetPosition.x() + Mx;
						camPlayerPOS.y() = targetPosition.y() + My;
						camPlayerPOS.z() = targetPosition.z() + newAlt - 3;

						//std::cout<<"s : "<<camPlayerROT[1]<<std::endl;
						camPlayerTrans.SetTranslation(camPlayerPOS);
						camPlayerTrans.SetRotation(camPlayerROT);
						SetTransform(camPlayerTrans);
					}
				}				
			}
			else
			/* TORPEDO SUT */
			if (Missile->mWeaponID == CT_TORPEDO_SUT)
			{
				dtCore::Transform shipTransform;
				osg::Vec3 shipPos, shipRot;

				attachedProxy2	= GetVehicleActorByID(mLockFireShipID);

				if (attachedProxy2.valid())
				{
					dtCore::RefPtr<VehicleActor> ship = static_cast<VehicleActor*>(attachedProxy2->GetActor());
					ship->GetTransform(shipTransform);
					shipTransform.GetTranslation(shipPos);
					shipTransform.GetRotation(shipRot);

					dtCore::Transform missileTransform;
					osg::Vec3 missPos, missRot;
					Missile->GetTransform(missileTransform);
					missileTransform.GetTranslation(missPos);
					missileTransform.GetRotation(missRot);
					
					if (LockingStepObs0 == 0)
					{		
						camPlayerPOS = RangeBearingToCoord(shipPos, 100, (-shipRot[0]) + 180);
						camPlayerPOS = RangeBearingToCoord(camPlayerPOS, 50, (-shipRot[0] + 90));
						
						//camPlayerPOS = RangeBearingToCoord(missPos, 50, (missRot[0] - 90));
						float bearingCamtoMiss = ComputeBearingTo2(camPlayerPOS[0], camPlayerPOS[1], missPos[0], missPos[1]);

						camPlayerPOS[2] = missPos[2];
						camPlayerROT[0] = (-bearingCamtoMiss);
						
						float distshiptoMiss = CalculateVec3Distance(shipPos, missPos);
						//std::cout<<"jarak ship to missile : "<<distshiptoMiss<<std::endl;
						
						if (distshiptoMiss >= 100)
						{
							LockingStepObs0 = 1;
						}
						//std::cout<<"tes : "<<distCamtoMiss<<std::endl;
						camPlayerTrans.SetTranslation(camPlayerPOS);
						camPlayerTrans.SetRotation(camPlayerROT);
						SetTransform(camPlayerTrans);
					}
					else if (LockingStepObs0 == 1)
					{
						/*camPlayerPOS = RangeBearingToCoord(missPos, 50, (missRot[0] - 90));
						camPlayerPOS[2] = missPos[2];

						camPlayerTrans.SetTranslation(camPlayerPOS);
						camPlayerTrans.SetRotation(camPlayerROT);
						SetTransform(camPlayerTrans);

						LockingStepObs0 = 2;*/
						

						float bearingCamtoMiss = ComputeBearingTo2(camPlayerPOS[0], camPlayerPOS[1], missPos[0], missPos[1]);
						//camPlayerPOS = RangeBearingToCoord(camPlayerPOS, 50.0f*dt, ValidateDegree(bearingCamtoMiss));
						camPlayerPOS = RangeBearingToCoord(camPlayerPOS, 10.0f*dt, ValidateDegree(bearingCamtoMiss));

						camPlayerPOS[2] = missPos[2];

						camPlayerROT[0] = (-bearingCamtoMiss);
						
						float dist = CalculateVec3Distance(missPos, camPlayerPOS);

						if (dist <= 100)
						{
							LockingStepObs0 = 2;
						}

						camPlayerTrans.SetTranslation(camPlayerPOS);
						camPlayerTrans.SetRotation(camPlayerROT);
						SetTransform(camPlayerTrans);
					}

					else if (LockingStepObs0 == 2)
					{
						//std::cout<<"jarak cam to missile : "<<CalculateVec3Distance(camPlayerPOS, missPos)<<std::endl;
						float bearingCamtoMiss = ComputeBearingTo2(camPlayerPOS[0], camPlayerPOS[1], missPos[0], missPos[1]);
						
						if (CalculateVec3Distance(camPlayerPOS, missPos) <= 30)
						{
							camPlayerPOS = RangeBearingToCoord(camPlayerPOS, 5.0f*dt, -shipRot[0] + 90);
						}
						else
						{
							camPlayerPOS = RangeBearingToCoord(camPlayerPOS, 5.0f*dt, ValidateDegree(bearingCamtoMiss));
						}
						

						/*if (camPlayerPOS[2] >= (camPlayerPOS[2]))
						{
							camPlayerPOS[2] = camPlayerPOS[2] - (1.5* dt);
						}*/

						/*if (camPlayerROT[1] <= 10)
						{
							camPlayerROT[1] = camPlayerROT[1] + (10.0f * dt);
						}
				*/
						//float distCamtoMiss = RangeVec3(missPos, camPlayerPOS);
						//float camDegtoMiss = osg::RadiansToDegrees(asin(missPos[2]/distCamtoMiss));

						camPlayerROT[0] = (-bearingCamtoMiss);
						camPlayerPOS[2] = missPos[2];
						//camPlayerROT[1] = camDegtoMiss;
						//std::cout<<"s : "<<camPlayerROT[1]<<std::endl;

						float dist = CalculateVec3Distance(missPos, camPlayerPOS);
						//std::cout<<"s : "<<dist<<std::endl;

						if (dist >= 60)
						{
							LockingStepObs0 = 3;
						}

						camPlayerTrans.SetTranslation(camPlayerPOS);
						camPlayerTrans.SetRotation(camPlayerROT);
						SetTransform(camPlayerTrans);
					}

					else if (LockingStepObs0 == 3)
					{
						/*
						float bearingCamtoMiss = ComputeBearingTo2(camPlayerPOS[0], camPlayerPOS[1], missPos[0], missPos[1]);
						camPlayerROT[0] = (-bearingCamtoMiss);
						
						float distcamtoMiss = CalculateVec3Distance(camPlayerPOS, missPos);

						if (distcamtoMiss >= 200)
						{
							LockingStepObs0 = 1;
						}

						camPlayerTrans.SetRotation(camPlayerROT);
						SetTransform(camPlayerTrans);*/

						CameraHeading	= 0;
						CameraRange		= 59;
						CameraPitch		= 0;
						
						float Mx, My;
						float newRange, newAlt;
						float SinX, CosX;

						dtCore::RefPtr<dtGame::GameActor> ObjView = static_cast<dtGame::GameActor*>(attachedProxy->GetActor());	

						// Object Transform
						ObjView->GetTransform(targetTransform);
						targetTransform.GetTranslation(targetPosition);
						targetTransform.GetRotation(targetRotation);

						// Camera Transform
						dtCore::Transform camPlayerTrans;
						osg::Vec3 camPlayerPOS, camPlayerROT; 
						GetTransform(camPlayerTrans);
						camPlayerTrans.GetTranslation(camPlayerPOS);
						camPlayerTrans.GetRotation(camPlayerROT);

						camPlayerROT[0] = targetRotation[0] + CameraHeading; 
						camPlayerROT[1] = -CameraPitch;
						camPlayerROT[2] = 0;

						newRange = cos(osg::DegreesToRadians(CameraPitch)) * -CameraRange;
						newAlt	 = sin(osg::DegreesToRadians(CameraPitch)) * CameraRange;
						SinX	 = sin(osg::DegreesToRadians(ConvCompass_To_Cartesian(ValidateDegree( -camPlayerROT[0] ))));
						CosX	 = cos(osg::DegreesToRadians(ConvCompass_To_Cartesian(ValidateDegree( -camPlayerROT[0] ))));
						Mx		 = newRange * CosX;
						My		 = newRange * SinX;

						camPlayerPOS.x() = targetPosition.x() + Mx;
						camPlayerPOS.y() = targetPosition.y() + My;
						camPlayerPOS.z() = targetPosition.z() + newAlt;
						
						//std::cout<<"s : "<<camPlayerROT[1]<<std::endl;
						camPlayerTrans.SetTranslation(camPlayerPOS);
						camPlayerTrans.SetRotation(camPlayerROT);
						SetTransform(camPlayerTrans);

					}
				}
			}
			/* STRELLA*/
			else if (Missile->mWeaponID == CT_STRELA)
			{
				dtCore::Transform lbaSTRTransform;
				osg::Vec3 lbaPos, lbaRot;

				attachedProxy2	= GetLauncherActors(C_WEAPON_TYPE_BODY, mLockFireShipID, mLockFireWeaponID, mLockFireLauncherID);
				if (attachedProxy2.valid())
				{
					dtCore::RefPtr<LauncherBodyActor> launcher = static_cast<LauncherBodyActor*>(attachedProxy2->GetActor());
					launcher->GetTransform(lbaSTRTransform);
					lbaSTRTransform.GetTranslation(lbaPos);
					lbaSTRTransform.GetRotation(lbaRot);
					
					dtCore::Transform missileTransform;
					osg::Vec3 missPos, missRot;
					Missile->GetTransform(missileTransform);
					missileTransform.GetTranslation(missPos);
					missileTransform.GetRotation(missRot);

					float headingLauncher;
					headingLauncher = -lbaRot[0];

					//std::cout<<"degree : "<<ValidateDegree(headingLauncher)<<std::endl;

					//Step 1
					if (LockingStepObs0 == 0)
					{
						float turnDegree;
						if ((ValidateDegree(headingLauncher) > 0 && ValidateDegree(headingLauncher) <= 90) 
							|| (ValidateDegree(headingLauncher) > 180 && ValidateDegree(headingLauncher) <= 270))
						{
							turnDegree = -90;
						}
						else
						{
							turnDegree = 90;
						}

						//float bearingCamtoShip = ValidateDegree(ComputeBearingTo2(camPlayerPOS[0], camPlayerPOS[1], lbaPos[0], lbaPos[1]));
						camPlayerPOS = RangeBearingToCoord(lbaPos, 200,ValidateDegree(headingLauncher + turnDegree));
						camPlayerPOS[2] = 30;
						//camPlayerROT[0] = -(ValidateDegree(bearingCamtoShip));
						float bearingCamtoMiss = ComputeBearingTo2(camPlayerPOS[0], camPlayerPOS[1], missPos[0], missPos[1]);
						float distCamtoMiss = RangeVec3(missPos, camPlayerPOS);
						float camDegtoMiss;

						if ((missPos[2]/distCamtoMiss) > 1)
						{
							float aSinCalc = 2 - (missPos[2]/distCamtoMiss);
							camDegtoMiss = osg::RadiansToDegrees(asin(aSinCalc));
						}
						else
						{
							camDegtoMiss = osg::RadiansToDegrees(asin(missPos[2]/distCamtoMiss));
						}
						
						camPlayerROT[0] = -(ValidateDegree(bearingCamtoMiss));
						camPlayerROT[1] = camDegtoMiss;

						float distShiptoMiss = CalculateVec3Distance(lbaPos, missPos);
						
						if (distShiptoMiss >= 500)
						{
							LockingStepObs0 = 1;
						}

						camPlayerTrans.SetTranslation(camPlayerPOS);
						camPlayerTrans.SetRotation(camPlayerROT);
						SetTransform(camPlayerTrans); 
					}
					else if (LockingStepObs0 == 1)
					{
						float bearingCamtoMiss = ComputeBearingTo2(camPlayerPOS[0], camPlayerPOS[1], missPos[0], missPos[1]);
						camPlayerPOS = RangeBearingToCoord(camPlayerPOS, 300.0f*dt, ValidateDegree(bearingCamtoMiss));
						float distCamtoMiss = RangeVec3(missPos, camPlayerPOS);
						float camDegtoMiss;

						if ((missPos[2]/distCamtoMiss) > 1)
						{
							float aSinCalc = 2 - (missPos[2]/distCamtoMiss);
							camDegtoMiss = osg::RadiansToDegrees(asin(aSinCalc));
						}
						else
						{
							camDegtoMiss = osg::RadiansToDegrees(asin(missPos[2]/distCamtoMiss));
						}
						
						camPlayerROT[0] = -(bearingCamtoMiss);
						camPlayerROT[1] = camDegtoMiss;

						camPlayerPOS[2] = camPlayerPOS[2] + (30.0f * dt);

						if (camPlayerPOS[2] < missPos[2])
						{
							//LockingStepObs0 = 2;
							camPlayerPOS[2] = camPlayerPOS[2] - (30.0f * dt);
						}

						camPlayerTrans.SetTranslation(camPlayerPOS);
						camPlayerTrans.SetRotation(camPlayerROT);
						SetTransform(camPlayerTrans);
					}
					else if (LockingStepObs0 == 2)
					{
						CameraHeading	= 0;
						CameraRange		= 50;
						CameraPitch		= 5;
						run_as_ViewObject(dt);
					}
				}
			}

			/* Tetral*/
			else if (Missile->mWeaponID == CT_TETRAL)
			{
				dtCore::Transform lbaTETTransform;
				osg::Vec3 lbaPos, lbaRot;

				attachedProxy2	= GetLauncherActors(C_WEAPON_TYPE_BODY, mLockFireShipID, mLockFireWeaponID, mLockFireLauncherID);
				if (attachedProxy2.valid())
				{
					dtCore::RefPtr<LauncherBodyActor> launcher = static_cast<LauncherBodyActor*>(attachedProxy2->GetActor());
					launcher->GetTransform(lbaTETTransform);
					lbaTETTransform.GetTranslation(lbaPos);
					lbaTETTransform.GetRotation(lbaRot);
					
					dtCore::Transform missileTransform;
					osg::Vec3 missPos, missRot;
					Missile->GetTransform(missileTransform);
					missileTransform.GetTranslation(missPos);
					missileTransform.GetRotation(missRot);

					float headingLauncher;
					headingLauncher = -lbaRot[0];

					//std::cout<<"degree : "<<ValidateDegree(headingLauncher)<<std::endl;

					//Step 1
					if (LockingStepObs0 == 0)
					{
						float turnDegree;
						if ((ValidateDegree(headingLauncher) > 0 && ValidateDegree(headingLauncher) <= 90) 
							|| (ValidateDegree(headingLauncher) > 180 && ValidateDegree(headingLauncher) <= 270))
						{
							turnDegree = -90;
						}
						else
						{
							turnDegree = 90;
						}

						//float bearingCamtoShip = ValidateDegree(ComputeBearingTo2(camPlayerPOS[0], camPlayerPOS[1], lbaPos[0], lbaPos[1]));
						camPlayerPOS = RangeBearingToCoord(lbaPos, 200,ValidateDegree(headingLauncher + turnDegree));
						camPlayerPOS[2] = 30;
						//camPlayerROT[0] = -(ValidateDegree(bearingCamtoShip));
						float bearingCamtoMiss = ComputeBearingTo2(camPlayerPOS[0], camPlayerPOS[1], missPos[0], missPos[1]);
						float distCamtoMiss = RangeVec3(missPos, camPlayerPOS);
						float camDegtoMiss;

						if ((missPos[2]/distCamtoMiss) > 1)
						{
							float aSinCalc = 2 - (missPos[2]/distCamtoMiss);
							camDegtoMiss = osg::RadiansToDegrees(asin(aSinCalc));
						}
						else
						{
							camDegtoMiss = osg::RadiansToDegrees(asin(missPos[2]/distCamtoMiss));
						}
						
						camPlayerROT[0] = -(ValidateDegree(bearingCamtoMiss));
						camPlayerROT[1] = camDegtoMiss;

						float distShiptoMiss = CalculateVec3Distance(lbaPos, missPos);
						
						//std::cout<<"jarak: "<<distShiptoMiss<<std::endl;
						if (distShiptoMiss >= 500)
						{
							LockingStepObs0 = 1;
						}

						camPlayerTrans.SetTranslation(camPlayerPOS);
						camPlayerTrans.SetRotation(camPlayerROT);
						SetTransform(camPlayerTrans); 
					}
					else if (LockingStepObs0 == 1)
					{
						float bearingCamtoMiss = ComputeBearingTo2(camPlayerPOS[0], camPlayerPOS[1], missPos[0], missPos[1]);
						camPlayerPOS = RangeBearingToCoord(camPlayerPOS, 300.0f*dt, ValidateDegree(bearingCamtoMiss));
						float distCamtoMiss = RangeVec3(missPos, camPlayerPOS);
						float camDegtoMiss;

						if ((missPos[2]/distCamtoMiss) > 1)
						{
							float aSinCalc = 2 - (missPos[2]/distCamtoMiss);
							camDegtoMiss = osg::RadiansToDegrees(asin(aSinCalc));
						}
						else
						{
							camDegtoMiss = osg::RadiansToDegrees(asin(missPos[2]/distCamtoMiss));
						}

						camPlayerROT[0] = -(bearingCamtoMiss);
						camPlayerROT[1] = camDegtoMiss;

						camPlayerPOS[2] = camPlayerPOS[2] + (30.0f * dt);

						if (camPlayerPOS[2] < missPos[2])
						{
							//LockingStepObs0 = 2;
							camPlayerPOS[2] = camPlayerPOS[2] - (30.0f * dt);
						}
						camPlayerTrans.SetTranslation(camPlayerPOS);
						camPlayerTrans.SetRotation(camPlayerROT);
						SetTransform(camPlayerTrans);
					}
				}
			}

			/* Mistral */
			else if (Missile->mWeaponID == CT_MISTRAL)
			{
				dtCore::Transform lbaMisTransform;
				osg::Vec3 lbaPos, lbaRot;

				attachedProxy2	= GetLauncherActors(C_WEAPON_TYPE_BODY, mLockFireShipID, mLockFireWeaponID, mLockFireLauncherID);
				if (attachedProxy2.valid())
				{
					dtCore::RefPtr<LauncherBodyActor> launcher = static_cast<LauncherBodyActor*>(attachedProxy2->GetActor());
					launcher->GetTransform(lbaMisTransform);
					lbaMisTransform.GetTranslation(lbaPos);
					lbaMisTransform.GetRotation(lbaRot);
					
					dtCore::Transform missileTransform;
					osg::Vec3 missPos, missRot;
					Missile->GetTransform(missileTransform);
					missileTransform.GetTranslation(missPos);
					missileTransform.GetRotation(missRot);

					float headingLauncher;
					headingLauncher = -lbaRot[0];

					//std::cout<<"degree : "<<ValidateDegree(headingLauncher)<<std::endl;

					//Step 1
					if (LockingStepObs0 == 0)
					{
						float turnDegree;
						if ((ValidateDegree(headingLauncher) > 0 && ValidateDegree(headingLauncher) <= 90) 
							|| (ValidateDegree(headingLauncher) > 180 && ValidateDegree(headingLauncher) <= 270))
						{
							turnDegree = -90;
						}
						else
						{
							turnDegree = 90;
						}

						//float bearingCamtoShip = ValidateDegree(ComputeBearingTo2(camPlayerPOS[0], camPlayerPOS[1], lbaPos[0], lbaPos[1]));
						camPlayerPOS = RangeBearingToCoord(lbaPos, 200,ValidateDegree(headingLauncher + turnDegree));
						camPlayerPOS[2] = 30;
						//camPlayerROT[0] = -(ValidateDegree(bearingCamtoShip));
						float bearingCamtoMiss = ComputeBearingTo2(camPlayerPOS[0], camPlayerPOS[1], missPos[0], missPos[1]);
						float distCamtoMiss = RangeVec3(missPos, camPlayerPOS);
						float camDegtoMiss;

						if ((missPos[2]/distCamtoMiss) > 1)
						{
							float aSinCalc = 2 - (missPos[2]/distCamtoMiss);
							camDegtoMiss = osg::RadiansToDegrees(asin(aSinCalc));
						}
						else
						{
							camDegtoMiss = osg::RadiansToDegrees(asin(missPos[2]/distCamtoMiss));
						}
						
						camPlayerROT[0] = -(ValidateDegree(bearingCamtoMiss));
						camPlayerROT[1] = camDegtoMiss;

						float distShiptoMiss = CalculateVec3Distance(lbaPos, missPos);
						
						//std::cout<<"jarak: "<<distShiptoMiss<<std::endl;
						if (distShiptoMiss >= 500)
						{
							LockingStepObs0 = 1;
						}

						camPlayerTrans.SetTranslation(camPlayerPOS);
						camPlayerTrans.SetRotation(camPlayerROT);
						SetTransform(camPlayerTrans); 
					}
					else if (LockingStepObs0 == 1)
					{
						float bearingCamtoMiss = ComputeBearingTo2(camPlayerPOS[0], camPlayerPOS[1], missPos[0], missPos[1]);
						camPlayerPOS = RangeBearingToCoord(camPlayerPOS, 300.0f*dt, ValidateDegree(bearingCamtoMiss));
						float distCamtoMiss = RangeVec3(missPos, camPlayerPOS);
						float camDegtoMiss;

						if ((missPos[2]/distCamtoMiss) > 1)
						{
							float aSinCalc = 2 - (missPos[2]/distCamtoMiss);
							camDegtoMiss = osg::RadiansToDegrees(asin(aSinCalc));
						}
						else
						{
							camDegtoMiss = osg::RadiansToDegrees(asin(missPos[2]/distCamtoMiss));
						}

						camPlayerROT[0] = -(bearingCamtoMiss);
						camPlayerROT[1] = camDegtoMiss;

						camPlayerPOS[2] = camPlayerPOS[2] + (30.0f * dt);

						if (camPlayerPOS[2] < missPos[2])
						{
							//LockingStepObs0 = 2;
							camPlayerPOS[2] = camPlayerPOS[2] - (30.0f * dt);
						}

						camPlayerTrans.SetTranslation(camPlayerPOS);
						camPlayerTrans.SetRotation(camPlayerROT);
						SetTransform(camPlayerTrans);
					}
					else if (LockingStepObs0 == 2)
					{
						CameraHeading	= 0;
						CameraRange		= 50;
						CameraPitch		= 5;
						run_as_ViewObject(dt);
					}
				}

			}
		}
	}
}

void PlayerActor::fly_to_LockSide(const float dt)
{
	//Missile Transform
	dtCore::Transform ObjectTrans ;
	osg::Vec3 ObjectPOS, ObjectROT;

	if (( mPlayerObjectLock == OBJECT_SURFACE ) || 
		( mPlayerObjectLock == OBJECT_SUBSURFACE ) ||
		( mPlayerObjectLock == OBJECT_AIR))
			static_cast<VehicleActor*>(GetParent())->GetTransform(ObjectTrans);
	else
	if ( mPlayerObjectLock == OBJECT_WEAPON)
		static_cast<MissilesActor*>(GetParent())->GetTransform(ObjectTrans);
	
	ObjectTrans.GetTranslation(ObjectPOS);
	ObjectTrans.GetRotation(ObjectROT);

	//Camera Transform
	dtCore::Transform camPlayerTrans;
	osg::Vec3 camPlayerPOS, camPlayerROT; 
	GetTransform(camPlayerTrans);
	camPlayerTrans.GetTranslation(camPlayerPOS);
	camPlayerTrans.GetRotation(camPlayerROT);

	osg::Vec3 lookAtPosition(ObjectPOS);
	osg::Vec3 upVec(0.f, 0.f, 1.0f);

	double RateMovingCamera;
	RateMovingCamera = 20.0f;

	//Flying STEP
	if (( mPlayerObjectLock == OBJECT_SURFACE )    ||
		( mPlayerObjectLock == OBJECT_SUBSURFACE ) ||
		( mPlayerObjectLock == OBJECT_AIR ))
	{
		if ( fly_step >= 0)
		{
			//=========== Fly To Left Side ============
			if ( mPlayerDefaultLock == LOCK_SIDE_LEFT )
			{
				if ( fly_step == 0 )
				{
					camPlayerPOS[0] += ( 0.5f * dt ) * 360.0f;
					camPlayerPOS[1] += ( 0.5f * dt ) * 360.0f;
					//camPlayerPOS[2] += ( 0.5f * dt ) * 360.0f;
					camPlayerTrans.Set(camPlayerPOS, lookAtPosition, upVec);

					float dist = CalculateVec3Distance(camPlayerPOS , ObjectPOS);
					if ( dist >= 200 ) 
						fly_step = 1 ;

					SetTransform(camPlayerTrans);
				}
				else 
				if ( fly_step == 1 )
				{
					camPlayerROT[0] += 1.0f * dt;
					if (camPlayerROT[0]  > 360.0f) 
						camPlayerROT[0] -= 360.0f;

					camPlayerPOS[0] = 1.5 * cos(osg::DegreesToRadians(camPlayerROT[0])) + camPlayerPOS[0];
					camPlayerPOS[1] = 1.5 * sin(osg::DegreesToRadians(camPlayerROT[0])) + camPlayerPOS[1];
					camPlayerTrans.Set(camPlayerPOS, lookAtPosition, upVec);

					if ( abs( int( ValidateDegree(camPlayerROT[0]) ) - int( ValidateDegree(ObjectROT[0]-30)) ) <= 2 ) 
					//if ( int(camPlayerROT[0]) == int(ObjectROT[0])-30 ) 
						fly_step = 2 ;
					SetTransform(camPlayerTrans);

				}
			}
			else
			//=========  FLy To Right Side ============
			if ( mPlayerDefaultLock == LOCK_SIDE_RIGHT )
			{
				if ( fly_step == 0 )
				{
					camPlayerPOS[0] += ( -0.5f * dt ) * 360.0f;
					camPlayerPOS[1] += ( -0.5f * dt ) * 360.0f;
					camPlayerTrans.Set(camPlayerPOS, lookAtPosition, upVec);

					float dist = CalculateVec3Distance(camPlayerPOS , ObjectPOS);
					if ( dist >= 200 ) 
						fly_step = 1 ;

					SetTransform(camPlayerTrans);
				}
				else 
				if ( fly_step == 1 )
				{
					camPlayerROT[0] -= 1.0f * dt;
					if (camPlayerROT[0]  > 360.0f) 
						camPlayerROT[0] -= 360.0f;

					camPlayerPOS[0] = 1.5 * cos(osg::DegreesToRadians(camPlayerROT[0])) + camPlayerPOS[0];
					camPlayerPOS[1] = 1.5 * sin(osg::DegreesToRadians(camPlayerROT[0])) + camPlayerPOS[1];
					camPlayerTrans.Set(camPlayerPOS, lookAtPosition, upVec);

					if ( abs( int( ValidateDegree(camPlayerROT[0]) ) - int( ValidateDegree(ObjectROT[0] + 130)) ) <= 2 ) 
					//if ( int(camPlayerROT[0]) == int(ObjectROT[0])+130 ) 
						fly_step = 2 ;
					SetTransform(camPlayerTrans);

				}
			}
			else
			//=========== Fly To Front Side ===========
			if ( mPlayerDefaultLock == LOCK_SIDE_FRONT )
			{
				if ( fly_step == 0 )
				{
					camPlayerPOS[0] += ( -0.5f * dt ) * 360.0f;
					camPlayerPOS[1] += ( -0.5f * dt ) * 360.0f;
					camPlayerTrans.Set(camPlayerPOS, lookAtPosition, upVec);

					float dist = CalculateVec3Distance(camPlayerPOS , ObjectPOS);
					if ( dist >= 200 ) 
						fly_step = 1 ;

					SetTransform(camPlayerTrans);
				}
				else 
				if ( fly_step == 1 )
				{
					camPlayerROT[0] += 1.0f * dt;
					if (camPlayerROT[0]  > 360.0f) 
						camPlayerROT[0] -= 360.0f;

					camPlayerPOS[0] = 1.5 * cos(osg::DegreesToRadians(camPlayerROT[0])) + camPlayerPOS[0];
					camPlayerPOS[1] = 1.5 * sin(osg::DegreesToRadians(camPlayerROT[0])) + camPlayerPOS[1];
					camPlayerTrans.Set(camPlayerPOS, lookAtPosition, upVec);

					if ( abs( int( ValidateDegree(camPlayerROT[0]) ) - int( ValidateDegree(ObjectROT[0] + 195)) ) <= 2 ) 
					//if ( int(camPlayerROT[0]) == int(ObjectROT[0])+195 ) 
						fly_step = 2 ;
					SetTransform(camPlayerTrans);

				}
			}
			else
			//========== Fly To Back Side =============
			if ( mPlayerDefaultLock == LOCK_SIDE_BACK )
			{
				if ( fly_step == 0 )
				{
					camPlayerPOS[0] += ( 0.5f * dt ) * 360.0f;
					camPlayerPOS[1] += ( 0.5f * dt ) * 360.0f;
					camPlayerTrans.Set(camPlayerPOS, lookAtPosition, upVec);

					float dist = CalculateVec3Distance(camPlayerPOS , ObjectPOS);
					if ( dist >= 200 ) 
						fly_step = 1 ;

					SetTransform(camPlayerTrans);
				}
				else 
				if ( fly_step == 1 )
				{
					camPlayerROT[0] += 1.0f * dt;
					if (camPlayerROT[0]  > 360.0f) 
						camPlayerROT[0] -= 360.0f;

					camPlayerPOS[0] = 1.5 * cos(osg::DegreesToRadians(camPlayerROT[0])) + camPlayerPOS[0];
					camPlayerPOS[1] = 1.5 * sin(osg::DegreesToRadians(camPlayerROT[0])) + camPlayerPOS[1];
					camPlayerTrans.Set(camPlayerPOS, lookAtPosition, upVec);

					if ( abs( int( ValidateDegree(camPlayerROT[0]) ) - int( ValidateDegree(ObjectROT[0])) ) <= 2 ) 
					//if ( int(camPlayerROT[0]) == int(ObjectROT[0]) ) 
						fly_step = 2 ;
					SetTransform(camPlayerTrans);

				}
			}
			else
			//========== Fly To Top Side ============
			if ( mPlayerDefaultLock == LOCK_SIDE_TOP)
			{
				if ( fly_step == 0 )
				{
					camPlayerPOS[0] += ( 0.5f * dt ) * 360.0f;
					camPlayerPOS[1] += ( 0.5f * dt ) * 360.0f;
					camPlayerTrans.Set(camPlayerPOS, lookAtPosition, upVec);

					float dist = CalculateVec3Distance(camPlayerPOS , ObjectPOS);
					if ( dist >= 200 ) 
						fly_step = 1 ;

					SetTransform(camPlayerTrans);
				}
				else 
				if ( fly_step == 1 )
				{
					if ( int(camPlayerROT[0]) != int(ObjectROT[0])) 
					{
						camPlayerROT[0] += 1.0f * dt;
						if (camPlayerROT[0]  > 360.0f) 
							camPlayerROT[0] -= 360.0f;

						camPlayerPOS[0] = 1.5 * cos(osg::DegreesToRadians(camPlayerROT[0])) + camPlayerPOS[0];
						camPlayerPOS[1] = 1.5 * sin(osg::DegreesToRadians(camPlayerROT[0])) + camPlayerPOS[1];
						camPlayerPOS[2] = (50.f * dt) + camPlayerPOS[2];
						camPlayerTrans.Set(camPlayerPOS, lookAtPosition, upVec);
					}
					else
					{
						camPlayerPOS[2] = (50.f * dt) + camPlayerPOS[2];
						camPlayerTrans.Set(camPlayerPOS, lookAtPosition, upVec);

						if ( camPlayerPOS[2] >= 300 ) 
							fly_step = 2 ;
					}

					SetTransform(camPlayerTrans);

				}
			}
		}
	}
	else
	if ( mPlayerObjectLock == OBJECT_WEAPON )
	{
		if ( fly_step >= 0)
		{
			//=========== Fly To Left Side ============
			if ( mPlayerDefaultLock == LOCK_SIDE_LEFT )
			{
				if ( fly_step == 0 )
				{
					camPlayerPOS[0] += ( 0.5f * dt ) * 360.0f;
					camPlayerPOS[1] += ( 0.5f * dt ) * 360.0f;
					camPlayerTrans.Set(camPlayerPOS, lookAtPosition, upVec);

					float dist = CalculateVec3Distance(camPlayerPOS , ObjectPOS);
					if ( dist >= 100 ) 
						fly_step = 1 ;

					SetTransform(camPlayerTrans);
				}
				else 
				if ( fly_step == 1 )
				{
					camPlayerROT[0] += 1.0f * dt;
					if (camPlayerROT[0]  > 360.0f) 
						camPlayerROT[0] -= 360.0f;

					camPlayerPOS[0] = 1.5 * cos(osg::DegreesToRadians(camPlayerROT[0])) + camPlayerPOS[0];
					camPlayerPOS[1] = 1.5 * sin(osg::DegreesToRadians(camPlayerROT[0])) + camPlayerPOS[1];
					camPlayerTrans.Set(camPlayerPOS, lookAtPosition, upVec);

					if ( abs( int( ValidateDegree(camPlayerROT[0]) ) - int( ValidateDegree(ObjectROT[0]-60)) ) <= 2 ) 
						fly_step = 2 ;
					SetTransform(camPlayerTrans);

				}
			}
			else
			//=========  FLy To Right Side ============
			if ( mPlayerDefaultLock == LOCK_SIDE_RIGHT )
			{
				if ( fly_step == 0 )
				{
					camPlayerPOS[0] += ( -0.5f * dt ) * 360.0f;
					camPlayerPOS[1] += ( -0.5f * dt ) * 360.0f;
					camPlayerTrans.Set(camPlayerPOS, lookAtPosition, upVec);

					float dist = CalculateVec3Distance(camPlayerPOS , ObjectPOS);
					if ( dist >= 100 ) 
						fly_step = 1 ;

					SetTransform(camPlayerTrans);
				}
				else 
				if ( fly_step == 1 )
				{
					camPlayerROT[0] += 1.0f * dt;
					if (camPlayerROT[0]  > 360.0f) 
						camPlayerROT[0] -= 360.0f;

					camPlayerPOS[0] = -1.5 * cos(osg::DegreesToRadians(camPlayerROT[0])) + camPlayerPOS[0];
					camPlayerPOS[1] = -1.5 * sin(osg::DegreesToRadians(camPlayerROT[0])) + camPlayerPOS[1];
					camPlayerTrans.Set(camPlayerPOS, lookAtPosition, upVec);

					if ( abs( int( ValidateDegree(camPlayerROT[0]) ) - int( ValidateDegree(ObjectROT[0]+60)) ) <= 2 ) 
						fly_step = 2 ;
					SetTransform(camPlayerTrans);

				}
			}
			else
			//=========== Fly To Front Side ===========
			if ( mPlayerDefaultLock == LOCK_SIDE_FRONT )
			{
				if ( fly_step == 0 )
				{
					camPlayerPOS[0] += ( -0.5f * dt ) * 360.0f;
					camPlayerPOS[1] += ( -0.5f * dt ) * 360.0f;
					camPlayerTrans.Set(camPlayerPOS, lookAtPosition, upVec);

					float dist = CalculateVec3Distance(camPlayerPOS , ObjectPOS);
					if ( dist >= 100 ) 
						fly_step = 1 ;

					SetTransform(camPlayerTrans);
				}
				else 
				if ( fly_step == 1 )
				{
					camPlayerROT[0] += 1.0f * dt;
					if (camPlayerROT[0]  > 360.0f) 
						camPlayerROT[0] -= 360.0f;

					camPlayerPOS[0] = -1.5 * cos(osg::DegreesToRadians(camPlayerROT[0])) + camPlayerPOS[0];
					camPlayerPOS[1] = -1.5 * sin(osg::DegreesToRadians(camPlayerROT[0])) + camPlayerPOS[1];
					camPlayerTrans.Set(camPlayerPOS, lookAtPosition, upVec);

					if ( abs( int( ValidateDegree(camPlayerROT[0]) ) - int( ValidateDegree(ObjectROT[0]+195)) ) <= 2 ) 
						fly_step = 2 ;
					SetTransform(camPlayerTrans);

				}
			}
			else
			//========== Fly To Back Side =============
			if ( mPlayerDefaultLock == LOCK_SIDE_BACK )
			{
				if ( fly_step == 0 )
				{
					camPlayerPOS[0] += ( 0.5f * dt ) * 360.0f;
					camPlayerPOS[1] += ( 0.5f * dt ) * 360.0f;
					camPlayerTrans.Set(camPlayerPOS, lookAtPosition, upVec);

					float dist = CalculateVec3Distance(camPlayerPOS , ObjectPOS);
					if ( dist >= 100 ) 
						fly_step = 1 ;

					SetTransform(camPlayerTrans);
				}
				else 
				if ( fly_step == 1 )
				{
					camPlayerROT[0] += 1.0f * dt;
					if (camPlayerROT[0]  > 360.0f) 
						camPlayerROT[0] -= 360.0f;

					camPlayerPOS[0] = 1.5 * cos(osg::DegreesToRadians(camPlayerROT[0])) + camPlayerPOS[0];
					camPlayerPOS[1] = 1.5 * sin(osg::DegreesToRadians(camPlayerROT[0])) + camPlayerPOS[1];
					camPlayerTrans.Set(camPlayerPOS, lookAtPosition, upVec);

					if ( abs( int( ValidateDegree(camPlayerROT[0]) ) - int( ValidateDegree(ObjectROT[0])) ) <= 2 ) 
						fly_step = 2 ;
					SetTransform(camPlayerTrans);

				}
			}
			else
			//========== Fly To Top Side ============
			if ( mPlayerDefaultLock == LOCK_SIDE_TOP)
			{
				if ( fly_step == 0 )
				{
					camPlayerPOS[0] += ( 0.5f * dt ) * 360.0f;
					camPlayerPOS[1] += ( 0.5f * dt ) * 360.0f;
					camPlayerTrans.Set(camPlayerPOS, lookAtPosition, upVec);

					float dist = CalculateVec3Distance(camPlayerPOS , ObjectPOS);
					if ( dist >= 100 ) 
						fly_step = 1 ;

					SetTransform(camPlayerTrans);
				}
				else 
				if ( fly_step == 1 )
				{
					camPlayerROT[0] += 1.0f * dt;
					if (camPlayerROT[0]  > 360.0f) 
						camPlayerROT[0] -= 360.0f;

					camPlayerPOS[0] = 1.5 * cos(osg::DegreesToRadians(camPlayerROT[0])) + camPlayerPOS[0];
					camPlayerPOS[1] = 1.5 * sin(osg::DegreesToRadians(camPlayerROT[0])) + camPlayerPOS[1];
					camPlayerPOS[2] = (50.f * dt) + camPlayerPOS[2];
					camPlayerTrans.Set(camPlayerPOS, lookAtPosition, upVec);
					
					if ( abs( int( ValidateDegree(camPlayerROT[0]) ) - int( ValidateDegree(ObjectROT[0])) ) <= 2 ) 
						fly_step = 2 ;
					SetTransform(camPlayerTrans);

				}
			}
		}
	}
}

void PlayerActor::run_as_child_toLockfiring(const float dt)
{
	if ( attachedProxy.valid())
	{	
		fly_to_LockFiring(dt);

		if ( isKeyControlled )	 ceckKeyState(dt);
		if ( isMessageMoving )	 move_player();
		if ( isMessageRotating ) rotate_player();
		//set_info_text();
	}
}

void PlayerActor::run_as_child_toLockSide(const float dt)
{
	if ( attachedProxy.valid())
	{	
		if ( fly_step < 2 )		 fly_to_LockSide(dt);

		if ( isKeyControlled )	 ceckKeyState(dt);
		if ( isMessageMoving )	 move_player();
		if ( isMessageRotating ) rotate_player();
	}
}

void PlayerActor::run_as_misile_obs(float dt)
{
	if ( attachedProxy.valid())
	{
		fly_to_missile(dt);

		if ( isKeyControlled )	 ceckKeyState(dt);
		if ( isMessageMoving )	 move_player();
		if ( isMessageRotating ) rotate_player();

		//set_info_text();
	}
}

void PlayerActor::run_as_child(float dt)
{
	if ( attachedProxy.valid())
	{
		if ( fly_step < 2 ) fly_to_ship_parent(dt);
		if ( isKeyControlled ) ceckKeyState(dt);
		if ( isMessageMoving ) move_player();
		if ( isMessageRotating ) rotate_player();

		//set_info_text();
	}
}

void PlayerActor::run_as_observer(float dt)
{
	dtCore::Transform tmpTrans;
	GetTransform(tmpTrans);

	if ( isKeyControlled ) {
		ceckKeyState(dt);
		dtCore::RefPtr<dtDAL::ActorProxy> crouchProxy= ceck_intersection(dt);
		if ( crouchProxy != NULL )
		{
			SetTransform(tmpTrans);
		}
	}
	if ( isMessageMoving ) move_player();
	if ( isMessageRotating ) rotate_player();
	if ( isMessageMoving || isMessageRotating )
	{
		dtCore::RefPtr<dtDAL::ActorProxy> crouchProxy= ceck_intersection(dt);
		if ( crouchProxy != NULL) 
		{
			SetTransform(tmpTrans);
		}
	}

	//set_info_text();
	
}

void PlayerActor::run_as_ViewShip(float dt)
{

}

void PlayerActor::run_as_ViewMissile(float dt)
{

}

void PlayerActor::run_as_ViewObject(float dt)
{
	
	if ( attachedProxy.valid())
	{
		float Mx, My;
		float newRange, newAlt;
		float SinX, CosX;

		dtCore::RefPtr<dtGame::GameActor> ObjView = static_cast<dtGame::GameActor*>(attachedProxy->GetActor());	

		// Object Transform
		ObjView->GetTransform(targetTransform);
		targetTransform.GetTranslation(targetPosition);
		targetTransform.GetRotation(targetRotation);

		// Camera Transform
		dtCore::Transform camPlayerTrans;
		osg::Vec3 camPlayerPOS, camPlayerROT; 
		GetTransform(camPlayerTrans);
		camPlayerTrans.GetTranslation(camPlayerPOS);
		camPlayerTrans.GetRotation(camPlayerROT);

		camPlayerROT[0] = targetRotation[0] + CameraHeading; 
		camPlayerROT[1] = -CameraPitch;
		camPlayerROT[2] = 0;

		newRange = cos(osg::DegreesToRadians(CameraPitch)) * -CameraRange;
		newAlt	 = sin(osg::DegreesToRadians(CameraPitch)) * CameraRange;
		SinX	 = sin(osg::DegreesToRadians(ConvCompass_To_Cartesian(ValidateDegree( -camPlayerROT[0] ))));
		CosX	 = cos(osg::DegreesToRadians(ConvCompass_To_Cartesian(ValidateDegree( -camPlayerROT[0] ))));
		Mx		 = newRange * CosX;
		My		 = newRange * SinX;

		camPlayerPOS.x() = targetPosition.x() + Mx;
		camPlayerPOS.y() = targetPosition.y() + My;
		camPlayerPOS.z() = targetPosition.z() + newAlt + 10;

		camPlayerTrans.SetTranslation(camPlayerPOS);
		camPlayerTrans.SetRotation(camPlayerROT);
		SetTransform(camPlayerTrans);


		if ( isKeyControlled ) ceckKeyState(dt);
		if ( isMessageMoving ) move_player();
		if ( isMessageRotating ) rotate_player();

		//set_info_text();
	}
}

//
void PlayerActor::CalibrateHeadPitchWhenLock()
{
	
}

void PlayerActor::fly_to_missile(const float dt)
{
	

}

void PlayerActor::fly_to_ship_parent(const float dt)
{
	dtCore::Transform shipTrans ;

	static_cast<VehicleActor*>(GetParent())->GetTransform(shipTrans);

	osg::Vec3 shipPOS, shipROT;
	shipTrans.GetTranslation(shipPOS);
	shipTrans.GetRotation(shipROT);

	dtCore::Transform thisTrans;
	GetTransform(thisTrans);

	osg::Vec3 thisXYZ, thisROT; 
	thisTrans.GetTranslation(thisXYZ);
	thisTrans.GetRotation(thisROT);

	osg::Vec3 lookAtXYZ(shipPOS);
	osg::Vec3 upVec(0.f, 0.f, 1.f);

	if ( fly_step == 0 )
	{
		thisXYZ[0] += ( 0.5f * dt ) * 360.0f;
		thisXYZ[1] += ( 0.5f * dt ) * 360.0f;
		thisTrans.Set(thisXYZ, lookAtXYZ, upVec);

		float dist = CalculateVec3Distance(thisXYZ,shipPOS);
		if ( dist >= 200 ) 
			fly_step = 1 ;
		SetTransform(thisTrans);
		
	}
	else if ( fly_step == 1 )
	{
		thisROT[0] += 50.0f * dt;
		if (thisROT[0]  > 360.0f) 
			thisROT[0] -= 360.0f;

		thisXYZ[0] = 1.5 * cos(osg::DegreesToRadians(thisROT[0])) + thisXYZ[0];
		thisXYZ[1] = 1.5 * sin(osg::DegreesToRadians(thisROT[0])) + thisXYZ[1];
		thisTrans.Set(thisXYZ, lookAtXYZ, upVec);
		
		if ( int(thisROT[0]) == int(shipROT[0])-15 ) 
			fly_step = 2 ;
		SetTransform(thisTrans);
		
	}
	  
}
//////////////////////////////////////////////////////////////////////////

void PlayerActor::run_with_position(const dtCore::Transform &xform, const double dt)
{
	osg::Matrix targetMat;
	xform.Get(targetMat); //get the boat's matrix

	//calc the heading of the boat (angle = arctan(y/x))
	osg::Vec3 hpr;
	hpr[0] = osg::RadiansToDegrees(-atan2(targetMat(1,0), targetMat(1,1)));

	//create a rotation matrix using the heading and the boat's translation
	osg::Matrix headingMat;
	dtUtil::MatrixUtil::PositionAndHprToMatrix(headingMat,
		dtUtil::MatrixUtil::GetRow3(targetMat, 3),
		hpr);

	const float kDistanceOffset = -40.f;
	const float kHeightOffset = 10.f;

	const osg::Vec3 offset(5.0f, kDistanceOffset, kHeightOffset);// offset

	const float scale = 0.9f; //scale to slow the movement down

	dtCore::Transform transThis;
	GetTransform(transThis);
	osg::Matrix camMat;
	transThis.Get(camMat);
	const osg::Vec3 currXYZ = transThis.GetTranslation();
	const osg::Vec3 newXYZ = offset*headingMat;//calc new xyx

	osg::Vec3 diff(newXYZ-currXYZ);
	diff *= (scale);

	transThis.SetTranslation(currXYZ + diff);
	transThis.SetRotation(hpr[0], -10.f, 0.f);
	SetTransform(transThis);
}

void PlayerActor::ceckKeyState(const float dt)
{
	dtCore::Keyboard* keyboard = GetGameActorProxy().GetGameManager()->GetApplication().GetKeyboard();


	if ( keyboard->GetKeyState(osgGA::GUIEventAdapter::KEY_Tab))
		increase_speed();
	else if ( keyboard->GetKeyState(osgGA::GUIEventAdapter::KEY_BackSpace))
		decrease_speed();

	if ( 
		keyboard->GetKeyState('a') ||
		keyboard->GetKeyState('s') ||
		keyboard->GetKeyState('d') ||
		keyboard->GetKeyState('w') ||
		keyboard->GetKeyState('q') ||
		keyboard->GetKeyState('e') 
		)
	{
		if (keyboard->GetKeyState('w'))
			set_current_move_state(CMD_FROM_KEYBOARD,MOVE_PLAYER_FORWARD);
		else if (keyboard->GetKeyState('s'))
			set_current_move_state(CMD_FROM_KEYBOARD,MOVE_PLAYER_BACK);
		else if (keyboard->GetKeyState('a'))
			set_current_move_state(CMD_FROM_KEYBOARD,MOVE_PLAYER_LEFT);
		else if (keyboard->GetKeyState('d'))
			set_current_move_state(CMD_FROM_KEYBOARD,MOVE_PLAYER_RIGHT); 
		else if (keyboard->GetKeyState('q'))
			set_current_move_state(CMD_FROM_KEYBOARD,MOVE_PLAYER_UP); 
		else if (keyboard->GetKeyState('e'))
			set_current_move_state(CMD_FROM_KEYBOARD,MOVE_PLAYER_DOWN);
		
		move_player();
	} 

	if	(
		keyboard->GetKeyState(osgGA::GUIEventAdapter::KEY_Left)	||
		keyboard->GetKeyState(osgGA::GUIEventAdapter::KEY_Right)||
		keyboard->GetKeyState(osgGA::GUIEventAdapter::KEY_Up)	||
		keyboard->GetKeyState(osgGA::GUIEventAdapter::KEY_Down)	 
		)
	{
		if (keyboard->GetKeyState(osgGA::GUIEventAdapter::KEY_Left))
			set_current_rotate_state(CMD_FROM_KEYBOARD,ROTATE_PLAYER_LEFT); 
		else if (keyboard->GetKeyState(osgGA::GUIEventAdapter::KEY_Right))
			set_current_rotate_state(CMD_FROM_KEYBOARD,ROTATE_PLAYER_RIGHT);
		else if (keyboard->GetKeyState(osgGA::GUIEventAdapter::KEY_Up))
			set_current_rotate_state(CMD_FROM_KEYBOARD,ROTATE_PLAYER_UP);
		else if (keyboard->GetKeyState(osgGA::GUIEventAdapter::KEY_Down))
			set_current_rotate_state(CMD_FROM_KEYBOARD,ROTATE_PLAYER_DOWN);

		rotate_player();
	}  



}

int PlayerActor::validateRotation(const float val )
{
	float rot ;

	rot =  ValidateDegree(val) ;

	rot =  ( 360 - fabs(rot));

	if ( rot == 360 ) rot = 0 ;

	return rot ;

}
void PlayerActor::rotate_player()
{
	float x,y,z,h,p,r ;
	dtCore::Transform tmpTrans;
	GetTransform(tmpTrans,dtCore::Transformable::ABS_CS);
	tmpTrans.Get(x,y,z,h,p,r);
	//std::cout<<"Rotate Left Get "<<h<<","<<p<<","<<r<<std::endl;

	if ( current_state_rotation == ROTATE_PLAYER_LEFT )
	{
		h += mSpeed ; 
		//h = validateRotation(h);
	}
	else if ( current_state_rotation == ROTATE_PLAYER_RIGHT)
	{
		h -= mSpeed ; 
		//h = validateRotation(h);
	}
	else if ( current_state_rotation == ROTATE_PLAYER_UP)
	{
		p += mSpeed ;
		//p = validateRotation(p);
	}
	else if (current_state_rotation == ROTATE_PLAYER_DOWN)
	{
		p -= mSpeed ;
		//p = validateRotation(p);
	}

	tmpTrans.Set(x,y,z,h,p,r);
	SetTransform(tmpTrans,dtCore::Transformable::ABS_CS);

	//std::cout<<"Rotate Left Set "<<h<<","<<p<<","<<r<<". Speed "<<mSpeed<<std::endl;
}


void PlayerActor::move_player()
{
	 
	osg::Matrix mat;
	osg::Quat q;
	osg::Vec3 viewDir;
	osg::Vec3 pos;

	dtCore::Transform tmpTrans;
	GetTransform(tmpTrans,dtCore::Transformable::ABS_CS);
	tmpTrans.GetRotation(mat);
	mat.get(q);

	if ( current_state_move == MOVE_PLAYER_FORWARD)
		viewDir = q * osg::Vec3(0,1*mSpeed,0);
	else if (current_state_move == MOVE_PLAYER_BACK)
		viewDir = q * osg::Vec3(0,-1*mSpeed,0);
	else if (current_state_move == MOVE_PLAYER_LEFT)
		viewDir = q * osg::Vec3(-1*mSpeed,0,0);
	else if (current_state_move == MOVE_PLAYER_RIGHT)
		viewDir = q * osg::Vec3(1*mSpeed,0,0); 
	else if (current_state_move == MOVE_PLAYER_UP)
		viewDir = q * osg::Vec3(0,0,1*mSpeed); 
	else if (current_state_move == MOVE_PLAYER_DOWN)
		viewDir = q * osg::Vec3(0,0,-1*mSpeed); 

	tmpTrans.GetTranslation(pos);
	pos = pos + viewDir;
	tmpTrans.SetTranslation(pos);

	SetTransform(tmpTrans,dtCore::Transformable::ABS_CS);
	//std::cout<<"Move Forward speed "<< mSpeed<<"  pos " <<pos<<" "<<current_state_move<<std::endl;
}

void PlayerActor::increase_speed()
{
	mSpeed += 0.1f ;

	if ( mSpeed >= MAX_PLAYER_SPEED ) mSpeed = MAX_PLAYER_SPEED ;

	std::cout<<"Set Player Speed : "<<mSpeed<<std::endl;
}

void PlayerActor::decrease_speed()
{
	mSpeed -= 0.1f ;

	if ( mSpeed < 0.1 ) mSpeed = 0.1f ;

	std::cout<<"Set Player Speed : "<<mSpeed<<std::endl;
}

void PlayerActor::set_current_move_state(const int from, const int st)
{
	current_state_move = st ;
	if ( from == CMD_FROM_MESSAGE )
		isMessageMoving = true ;
}

void PlayerActor::set_current_rotate_state(const int from, const int st)
{
	current_state_rotation = st ;
	if ( from == CMD_FROM_MESSAGE )
		isMessageRotating = true ;
}

dtCore::Transform PlayerActor::get_default_actor_attach (std::string actName )
{
	dtCore::Transform offsetPos;
	osg::Vec3 pos, rot;

	if ( actName == C_CN_SHIP )
	{
		pos[0] = 0.0f;       
		pos[1] = -100.0f;      
		pos[2] = 40.0f;       
		rot[0] = 0.0f;   
		rot[1] = -10.0f;   
		rot[2] = 0.0f;   
	}
	else if ( actName == C_CN_SUBMARINE )
	{
		pos[0] = -10.0f;      
		pos[1] = -50.0f;      
		pos[2] = 10.0f;       
		rot[0] = 0.0f;   
		rot[1] = -15.0f;   
		rot[2] = 0.0f;    
	}
	else if ( actName == C_CN_HELICOPTER )
	{
		pos[0] = -10.0f;      
		pos[1] = -50.0f;      
		pos[2] = 10.0f;       
		rot[0] = 0.0f;   
		rot[1] = -15.0f;   
		rot[2] = 0.0f;      
	}
	else if ( actName == C_TYPE_MISSILE )
	{
		pos[0] = 0.0f;       
		pos[1] = -50.0f;      
		pos[2] = 10.0f;       
		rot[0] = 0.0f;   
		rot[1] = -15.0f;   
		rot[2] = 0.0f;   
	} else
		std::cout<<"Warning :: "<<GetName()<<" unknown ("<<actName<<") set default attach position. "<<std::endl;

	offsetPos.SetTranslation(pos);
	offsetPos.SetRotation(rot);

	return offsetPos ;
}

dtCore::Transform PlayerActor::get_default_vehicle_focus (std::string actName, dtCore::Transform vhcPos)
{
	dtCore::Transform offsetPos;
	osg::Vec3 pos, rot;

	vhcPos.GetTranslation(pos);

	if ( actName == C_CN_SHIP )
	{
		// set player on back upper
		pos[2]+= 200;     // z  
		rot[1] = -85.0;  // p
	}
	else if ( actName == C_CN_SUBMARINE )
	{
		// set player on side left
		pos[1] -= 100;        // x 
		rot[0] += 90.0f ;   // h
	}
	else if ( actName == C_CN_HELICOPTER )
	{
		// set player on side left
		pos[1] -= 200;        // x 
		rot[0] += 90.0f ;   // h
	} else
		std::cout<<"Warning :: unknown set default focus position. "<<std::endl;

	offsetPos.SetTranslation(pos);
	offsetPos.SetRotation(rot);

	return offsetPos ;
}

void PlayerActor::set_player_vehicle_focus(int VID )
{
	dtCore::RefPtr<dtDAL::ActorProxy> vhc  = GetVehicleActorByID(VID);
	if ( vhc.valid())
	{
		dtCore::RefPtr<dtGame::GameActorProxy> actProxy = NULL ;
		actProxy = static_cast<dtGame::GameActorProxy *>(vhc.get());
		dtCore::Transform t;
		if ( actProxy )
		{
			(actProxy->GetGameActor()).GetTransform(t);
			t = get_default_vehicle_focus((actProxy->GetActorType()).GetName(),t);
			SetTransform(t);
		} 

	}  
}

void PlayerActor::cycle_player_ship_focus()
{
	std::vector<dtDAL::ActorProxy*> gaps;
	GetGameActorProxy().GetGameManager()->FindActorsByType(*(GetGameActorProxy().GetGameManager()->FindActorType(C_ACTOR_CAT, C_CN_SHIP)), gaps);
	if (gaps.size() > 0)
	{
		mShipFocusIndex++;
		if ( mShipFocusIndex >= gaps.size() )  mShipFocusIndex= 0;

		dtCore::Transform t;
		dtCore::RefPtr<dtGame::GameActorProxy> gap= static_cast<dtGame::GameActorProxy*>(gaps[mShipFocusIndex]);
		if ( gap!= NULL ) {
			(gap->GetGameActor()).GetTransform(t);
			t = get_default_vehicle_focus((gap->GetActorType()).GetName(),t);
			SetTransform(t);
			std::cout<<"Set player focus to "<<gap->GetName()<<std::endl;
		}
	} else
		std::cout<<GetName()<<" can not find any ship.."<<std::endl;
}

void PlayerActor::cycle_player_submarine_focus()
{
	std::vector<dtDAL::ActorProxy*> gaps;
	GetGameActorProxy().GetGameManager()->FindActorsByType(*(GetGameActorProxy().GetGameManager()->FindActorType(C_ACTOR_CAT, C_CN_SUBMARINE)), gaps);
	if (gaps.size() > 0)
	{
		mSubMarineFocusIndex++;
		if( mSubMarineFocusIndex >= gaps.size())  mSubMarineFocusIndex= 0;

		dtCore::Transform t;
		dtCore::RefPtr<dtGame::GameActorProxy> gap= static_cast<dtGame::GameActorProxy*>(gaps[mSubMarineFocusIndex]);
		if ( gap!= NULL ) {

			(gap->GetGameActor()).GetTransform(t);
			t = get_default_vehicle_focus((gap->GetActorType()).GetName(),t);
			SetTransform(t);

			std::cout<<"Set player focus to "<<gap->GetName()<<std::endl;
		}
	} else
		std::cout<<GetName()<<" can not find any submarine.."<<std::endl;
}

void PlayerActor::cycle_player_heli_focus()
{
	std::vector<dtDAL::ActorProxy*> gaps;
	GetGameActorProxy().GetGameManager()->FindActorsByType(*(GetGameActorProxy().GetGameManager()->FindActorType(C_ACTOR_CAT, C_CN_HELICOPTER)), gaps);

	if (gaps.size() > 0)
	{
		mHeliFocusIndex++;
		if( mHeliFocusIndex >= gaps.size())  mHeliFocusIndex = 0;

		dtCore::Transform t;
		dtCore::RefPtr<dtGame::GameActorProxy> gap= static_cast<dtGame::GameActorProxy*>(gaps[mSubMarineFocusIndex]);
		if ( gap!= NULL ) {
			osg::Vec3 v3= gap->GetTranslation();
			v3[1]-= 50;
			v3[2]+= 500;
			t.SetTranslation(v3);
			osg::Vec3 rot(0.0f, -85.0f, 0.0f);
			t.SetRotation(rot);

			SetTransform(t);

			std::cout<<"Set player focus to "<<gap->GetName()<<std::endl;
		}
	} else
		std::cout<<GetName()<<" can not find any helicopter.."<<std::endl;
}

osg::Vec3Array* circleVerts( int plane, int approx, float radius )
{
	const double angle( osg::PI * 2. / (double) approx );
	osg::Vec3Array* v = new osg::Vec3Array;
	int idx, count;
	double x(0.), y(0.), z(0.);
	double height;
	double original_radius = radius;

	for(count = 0; count <= approx/4; count++)
	{
		height = original_radius*sin(count*angle);
		radius = cos(count*angle)*radius;


		switch(plane)
		{
		case 0: // X
			x = height;
			break;
		case 1: //Y
			y = height;
			break;
		case 2: //Z
			z = height;
			break;
		}

		for( idx=0; idx<approx; idx++)
		{
			double cosAngle = cos(idx*angle);
			double sinAngle = sin(idx*angle);
			switch (plane) {
		case 0: // X
			y = radius*cosAngle;
			z = radius*sinAngle;
			break;
		case 1: // Y
			x = radius*cosAngle;
			z = radius*sinAngle;
			break;
		case 2: // Z
			x = radius*cosAngle;
			y = radius*sinAngle;
			break;
			}
			v->push_back( osg::Vec3( x, y, z ) );
		}
	}
	return v;
}

osg::Geode* circles( int plane, int approx, float radius )
{
	osg::Geode* geode = new osg::Geode;
	osg::LineWidth* lw = new osg::LineWidth( 6. );
	geode->getOrCreateStateSet()->setAttributeAndModes( lw,
		osg::StateAttribute::ON );


	osg::Geometry* geom = new osg::Geometry;
	osg::Vec3Array* v = circleVerts( plane, approx, radius );
	geom->setVertexArray( v );

	osg::Vec4Array* c = new osg::Vec4Array;
	c->push_back( osg::Vec4( 1., 1., 1., 1. ) );
	geom->setColorArray( c );
	geom->setColorBinding( osg::Geometry::BIND_OVERALL );
	geom->addPrimitiveSet( new osg::DrawArrays( GL_LINE_LOOP, 0, approx ) );

	geode->addDrawable( geom );

	return geode;
}

osg::Geode* linesOut()
{
	osg::Geode* geode = new osg::Geode;
	osg::LineWidth* lw = new osg::LineWidth( 6. );
	geode->getOrCreateStateSet()->setAttributeAndModes( lw,
		osg::StateAttribute::ON );

	osg::Geometry* linesGeom = new osg::Geometry();
	osg::Vec3Array* vertices = new osg::Vec3Array(8);

	(*vertices)[0].set(2.6, 0, 0);
	(*vertices)[1].set(6.4, 0, 0);
	(*vertices)[2].set(0, 0, 2.6);
	(*vertices)[3].set(0, 0, 6.4);
	(*vertices)[4].set(0, 0, -2.6);
	(*vertices)[5].set(0, 0, -6.4);
	(*vertices)[6].set(-2.6, 0, 0);
	(*vertices)[7].set(-6.4, 0, 0);

	linesGeom->setVertexArray(vertices);
	linesGeom->addPrimitiveSet(new osg::DrawArrays(osg::PrimitiveSet::LINES,0,8));

	geode->addDrawable(linesGeom);

	return geode ;
}

osg::Geode* linesIn()
{
	osg::Geode* geode = new osg::Geode;
	osg::LineWidth* lw = new osg::LineWidth( 3. );
	geode->getOrCreateStateSet()->setAttributeAndModes( lw,
		osg::StateAttribute::ON );

	osg::Geometry* linesGeom = new osg::Geometry();
	osg::Vec3Array* vertices = new osg::Vec3Array(8);

	(*vertices)[0].set(0.4, 0, 0);
	(*vertices)[1].set(2.2, 0, 0);
	(*vertices)[2].set(0, 0, 0.4);
	(*vertices)[3].set(0, 0, 2.2);
	(*vertices)[4].set(0, 0, -0.4);
	(*vertices)[5].set(0, 0, -2.2);
	(*vertices)[6].set(-0.4, 0, 0);
	(*vertices)[7].set(-2.2, 0, 0);

	linesGeom->setVertexArray(vertices);
	linesGeom->addPrimitiveSet(new osg::DrawArrays(osg::PrimitiveSet::LINES,0,8));

	geode->addDrawable(linesGeom);

	return geode ;
}

void PlayerActor::set_view_crossHair()
{
	/*dtABC::Application& app = GetGameActorProxy().GetGameManager()->GetApplication();
	dtCore::Camera& camera = *app.GetCamera();
	app.GetView()->GetOsgViewerView()->setLightingMode(osg::View::NO_LIGHT);
	osg::StateSet* globalState = camera.GetOSGCamera()->getOrCreateStateSet();
	globalState->setMode(GL_LIGHTING, osg::StateAttribute::OFF);

	dtCore::Camera* cam =  GetGameActorProxy().GetGameManager()->GetApplication().GetCamera();
	dtCore::DeltaWin::PositionSize size = cam->GetWindow()->GetPosition();*/	

	//////////////////////////////////////////////////////////////////////////

	dtCore::RefPtr<osg::MatrixTransform> matrixNode = new osg::MatrixTransform; 
	
	osg::Matrix mtx;
	osg::Vec3 offset(0.0f, 50.0f,0.0f );
	mtx.setTrans(offset);
	matrixNode->setMatrix(mtx);

	matrixNode->addChild(circles(1, 200, 3.0));
	matrixNode->addChild(circles(1, 200, 6.0));
	matrixNode->addChild(linesIn());
	matrixNode->addChild(linesOut());

	osg::ref_ptr<osg::Group> root = static_cast<osg::Group*>(GetOSGNode()) ;
	root->addChild(matrixNode.get());

	//////////////////////////////////////////////////////////////////////////

	/*dtCore::RefPtr<dtCore::Object> mObject = new dtCore::Object();
	osg::MatrixTransform *sceneRoot  = (osg::MatrixTransform *) mObject->GetOSGNode();
	osg::ref_ptr<osg::ShapeDrawable> aShape = new osg::ShapeDrawable;
	aShape->setShape( new osg::Sphere(osg::Vec3(0.0f, 0.0f, 0.0f),1.0f) );
	aShape->setColor( osg::Vec4(1.0f, 1.0f, 1.0f, 1.0f) );
	osg::ref_ptr<osg::Geode> root = new osg::Geode;
	root->addDrawable( aShape.get() );

	sceneRoot->addChild(root);
	GetGameActorProxy().GetGameManager()->GetScene().AddDrawable(mObject.get());*/

	//////////////////////////////////////////////////////////////////////////
	 
	/*dtCore::RefPtr<dtCore::Object> anObject = new dtCore::Object();
	osg::MatrixTransform *sceneRoot = (osg::MatrixTransform *) anObject->GetOSGNode();
	osg::Matrix mtx;
	osg::Vec3 offset(0.0f, 50.0f,0.0f );
	mtx.setTrans(offset);
	sceneRoot->setMatrix(mtx);

	sceneRoot->addChild(linesIn());
	GetGameActorProxy().GetGameManager()->GetScene().AddDrawable(anObject);	*/
}

void PlayerActor::set_info_config()
{
	if ( mTextNode !=NULL )
	{
		osg::Group* root = static_cast<osg::Group*>(GetOSGNode());
		dtCore::RefPtr<osg::MatrixTransform> matrixNode = new osg::MatrixTransform;
		osg::Matrix mtx;
		osg::Vec3 offset(0.0f, 50.0f,12.5f ); //(-16.5f,50.0f,12.01f);
		mtx.setTrans(offset);
		matrixNode->setMatrix(mtx);

		dtCore::RefPtr<osg::Geode> geode = new osg::Geode;
		geode->addDrawable(mTextNode.get());
		matrixNode->addChild(geode.get()); 
		root->addChild(matrixNode.get());
		
		//////////////////////////////////////////////////////////////////////////
		mTextNode->setFont("arial.ttf");
		mTextNode->setDrawMode(osgText::Text::TEXT);
		mTextNode->setAlignment(osgText::TextBase::CENTER_CENTER);
		//mTextNode->setCharacterSize(3.0f); 
		mTextNode->setCharacterSizeMode(osgText::TextBase::SCREEN_COORDS);
		mTextNode->setAxisAlignment(osgText::TextBase::SCREEN);
		mTextNode->setLayout(osgText::Text::LEFT_TO_RIGHT);
		mTextNode->setColor(osg::Vec4(1.0f, 1.0f, 1.0f, 1.0f)) ; //(a, r, g, b));
	}
	else
		std::cout<<"Warning :: Setting label but failed"<<std::endl;

}

osgWidget::Label* createLabel(const std::string& l, unsigned int size=13) {
    osgWidget::Label* label = new osgWidget::Label("", "");

    label->setFont("Arial.ttf");
    label->setFontSize(size);
    label->setFontColor(1.0f, 1.0f, 1.0f, 1.0f);
    label->setLabel(l);

    /*
    text->setBackdropType(osgText::Text::DROP_SHADOW_BOTTOM_RIGHT);
    text->setBackdropImplementation(osgText::Text::NO_DEPTH_BUFFER);
    text->setBackdropOffset(0.2f);
    */

    return label;
}

void PlayerActor::set_info_text()
{
	dtCore::Transform t;
	float h,p,r;
	GetTransform(t);

	//if (( mPlayerType == PLAYER_SET_ATTACH_SHIP )   ||
	//	( mPlayerType == PLAYER_SET_ATTACH_MISSILE) || 
	//	( mPlayerType == PLAYER_SET_ATTACH_SHIP2 ))
	//{
		if ( attachedProxy.valid())
		{
			dtCore::RefPtr<dtGame::GameActorProxy> actProxy = NULL ;
			actProxy = static_cast<dtGame::GameActorProxy *>(attachedProxy.get());
			if ( actProxy )
				(actProxy->GetGameActor()).GetTransform(t);
		} 
	//}  

	t.GetRotation(h,p,r);
	h =  ValidateDegree(h) ;
	h =  ( 360 - osg::round(h));
	if ( h == 360 ) h = 0 ;

	std::ostringstream oss ;
	oss.clear();
	oss << h <<"°";

	mTextNode->setText(oss.str());

	const unsigned int MASK_2D = 0xF0000000;
   osgWidget::WindowManager* wm = new osgWidget::WindowManager(
	   GetGameActorProxy().GetGameManager()->GetApplication().GetView()->GetOsgViewerView(),
	   GetGameActorProxy().GetGameManager()->GetApplication().GetWindow()->GetResolutions()[0].width,
	   GetGameActorProxy().GetGameManager()->GetApplication().GetWindow()->GetResolutions()[0].height,
	   MASK_2D,
	   // osgWidget::WindowManager::WM_USE_RENDERBINS |
	   osgWidget::WindowManager::WM_PICK_DEBUG
	   );

   osgWidget::Box*   vbox   = new osgWidget::Box("vbox", osgWidget::Box::VERTICAL);
   osgWidget::Label* label3 = createLabel("Label 3", 80);
   label3->setPadding(3.0f);
   label3->setColor(0.0f, 0.0f, 0.5f, 0.5f);
   vbox->addWidget(label3);
   vbox->attachMoveCallback();
   vbox->attachScaleCallback();
   vbox->resize();
   osgWidget::Box* clonedBox = osg::clone(vbox, "HBOX-new", osg::CopyOp::DEEP_COPY_ALL);
   clonedBox->getBackground()->setColor(0.0f, 1.0f, 0.0f, 0.5f);
   wm->addChild(vbox);

   //osg::Camera* camera = wm->createParentOrthoCamera();

   osg::Group* pInputBox = new osg::Group;
   pInputBox->addChild(vbox);
   GetGameActorProxy().GetGameManager()->GetApplication().GetScene()->GetSceneNode()->addChild(wm);
}



void PlayerActor::chkPassable(const dtCore::DeltaDrawable *t, const dtCore::DeltaDrawable *s, bool &bChk)
{
	bChk= false;
	if (t->GetUniqueId()== s->GetUniqueId())
		bChk= true;

	if (!bChk)
	{
		for(unsigned int i= 0; i< s->GetNumChildren(); i++)
		{
			chkPassable(t, s->GetChild(i), bChk);
			if (bChk) 
				break;
		}

	}
}


dtDAL::ActorProxy* PlayerActor::ceck_intersection(float pDeltaTime)
{
	float distance = 10.0f;
	if (distance<= 0.0f)
	{
		//std::cout<<"Warning: speed is zero, no need to check collision"<<std::endl;
		return NULL;
	}
	dtCore::Transform t;
	GetTransform(t);

	if (mIsector->GetScene()== NULL)
	{
		mIsector->SetScene(&(GetGameActorProxy().GetGameManager()->GetScene()));
	}

	mIsector->Reset();
	osg::Vec3 pos= t.GetTranslation();
	osg::Matrix matrix;
	t.GetRotation(matrix);
	mIsector->SetStartPosition(pos);
	osg::Vec3 at(matrix(1, 0), matrix(1, 1), matrix(1, 2));
	at *= 5;
	mIsector->SetEndPosition(pos + at);

	osg::Vec3 rot;
	t.GetRotation(rot);
	float h= rot[0];
	float p= rot[1];

	float x, y, z;
	z= sin(osg::DegreesToRadians(p));
	x= cos(osg::DegreesToRadians(p)) * sin(osg::DegreesToRadians(h));
	y= cos(osg::DegreesToRadians(p)) * cos(osg::DegreesToRadians(h));

	osg::Vec3 dir(x, y, z);

	mIsector->SetDirection(dir);
	mIsector->SetLength(distance);
	if (mIsector->Update())
	{
		dtCore::DeltaDrawable* dd = mIsector->GetClosestDeltaDrawable();
		if (dd == NULL)
		{
			return NULL;
		}

		if ( dd == this )
		{
			return NULL ;
		}

		if ( GetParent()->GetUniqueId() == dd->GetUniqueId() )
		{
			/// warning ocean bisa jadi parentnya, do something
			return NULL ;
		}

		dtCore::RefPtr<dtDAL::ActorProxy> proxy= GetGameActorProxy().GetGameManager()->FindGameActorById(dd->GetUniqueId());
		if (proxy!= NULL)
		{    
			if ( proxy->GetName()==C_CN_OCEAN )  
			{
				std::cout<<GetName()<<" hit ocean "<<std::endl;
			} 
			else
			{ 
				std::cout<<GetName()<<" hit "<<proxy->GetName()<<std::endl;
				return proxy.get();
			}
		}
		else
		{
			proxy = GetGameActorProxy().GetGameManager()->FindActorById(dd->GetUniqueId());

			if (proxy!= NULL)
			{
				std::cout<<GetName()<<" hit "<<proxy->GetName()<<std::endl;
				return proxy.get();
			}
		}
	}
	return NULL;
}

dtCore::RefPtr<dtDAL::ActorProxy> PlayerActor::GetVehicleActorByID(int VID )
{
	SimServerClientComponent* simSC = static_cast<SimServerClientComponent*> (GetGameActorProxy().GetGameManager()->GetComponentByName(C_COMP_SERVER_CLIENT_CTRL));
	if ( simSC != NULL )
	{
		return simSC->GetShipActorByID(VID);
	} else
		return NULL;
}

dtCore::RefPtr<dtDAL::ActorProxy> PlayerActor::GetLauncherActors(const int actTypeID, const int mVehicleID, const int mWeaponID, const int mLauncherID  )
{
	SimServerClientComponent* simSC = static_cast<SimServerClientComponent*> (GetGameActorProxy().GetGameManager()->GetComponentByName(C_COMP_SERVER_CLIENT_CTRL));
	if ( simSC != NULL )
	{
		return simSC->GetLauncherActors(actTypeID,mVehicleID,mWeaponID,mLauncherID);
	} else
		return NULL;
}
dtCore::RefPtr<dtDAL::ActorProxy> PlayerActor::GetMissileActors(const int mVehicleID, const int mWeaponID, const int mLauncherID, const int mMissileID, const int mMissileNum )
{
	SimServerClientComponent* simSC = static_cast<SimServerClientComponent*> (GetGameActorProxy().GetGameManager()->GetComponentByName(C_COMP_SERVER_CLIENT_CTRL));
	if ( simSC != NULL )
	{
		return simSC->GetMissileActors(mVehicleID,mWeaponID,mLauncherID,mMissileID,mMissileNum);
	} else
		return NULL;
}

void PlayerActor::SetAttachToVehicleID(const int mVehicleID )
{
	set_setting_attach_ship(mVehicleID,0,0,0,0);
	SetPlayerType(PLAYER_SET_ATTACH_SHIP);
}

void PlayerActor::SetAttachToLauncher(const int mVehicleID, const int mWeaponID , const int mLauncherID )
{
	set_setting_attach_launcher(mVehicleID,mWeaponID,mLauncherID,0,0);
	SetPlayerType(PLAYER_SET_ATTACH_LAUNCHER);
}

void PlayerActor::SetAttachToMissile(const int mVehicleID, const int mWeaponID , const int mLauncherID, const int mMissileID, const int mMissileNum )
{
	set_setting_attach_missile(mVehicleID,mWeaponID,mLauncherID,mMissileID,mMissileNum);
	SetPlayerType(PLAYER_SET_ATTACH_MISSILE);
}

void PlayerActor::SetPlayerType(const int tipe)
{
	mPlayerType = tipe ;	
}

void PlayerActor::SetTargetIDAsrock(const int tipe)
{
	targetIDAsrock = tipe ;	
}

void PlayerActor::setTargetBearingExo(const float tipe)
{
	rangeBearingExo = tipe;	
}

void PlayerActor::setAngularModePlayer(const float tipe)
{
	angularMode = tipe;	
}

void PlayerActor::SetTargetIDRBU(const int tipe)
{
	targetIDRBU = tipe ;	
}

void PlayerActor::SetPlayerID(const int id )
{
	mPlayerID   = id ;
}

void PlayerActor::SetPlayerDefaultLock(const int lockID)
{
	mPlayerDefaultLock = lockID;
}

void PlayerActor::SetPlayerObjectLock(const int ObjectID)
{
	// 1 : Ship
	// 2 : Submarine
	// 3 : Heli/Aircraft
	// 4 : Weapon
	mPlayerObjectLock = ObjectID;
}

void PlayerActor::AddToEnvironmentActor()
{
	if ( GetParent() != NULL ) 
	{

		dtGame::IEnvGameActorProxy* envActorProxy = GetGameActorProxy().GetGameManager()->GetEnvironmentActor();
		OceanActor* actor = NULL;
		if (envActorProxy) actor = dynamic_cast<OceanActor*> (envActorProxy->GetActor());
		if (actor != NULL)
		{
			dtCore::Transform t;
			GetTransform(t);

			if ( GetParent()->GetName() != actor->GetName() )
			{
				GetParent()->RemoveChild(this);
				actor->AddChild(this);
				/*
				std::vector<dtDAL::ActorProxy *> ap;
				GetGameActorProxy().GetGameManager()->FindActorsByName(C_CN_OCEAN, ap);
				if (ap[0]!= NULL)  
				{
					static_cast<dtGame::IEnvGameActor*>( ap[0]->GetActor() )->AddActor( *(this) );
				}
				else
					std::cout<<"Environment actor is missing!"<<std::endl;
				*/
				SetTransform(t);
			}

		}
	}

}

void PlayerActor::set_camera()
{	
	dtCore::RefPtr<dtCore::Camera> mCam = GetGameActorProxy().GetGameManager()->GetApplication().GetCamera();
	mCam->SetParent(NULL);

	/*dtCore::DeltaWin* mainWindow = GetGameActorProxy().GetGameManager()->GetApplication().GetWindow();
	dtCore::DeltaWin::Resolution currentRes = mainWindow->GetCurrentResolution();

	int width = currentRes.width;
	int height = currentRes.height;

	double vfov, aspectRatio, nearClip, farClip;
	mCam->GetPerspectiveParams(vfov, aspectRatio, nearClip, farClip);
	vfov = 80 ;
	aspectRatio = width /(float) height ; 
	mCam->SetPerspectiveParams( vfov, aspectRatio, 0.01f, farClip );
	mCam->SetClearColor(0.0f, 0.0f, 1.0f, 1.f);*/

	/*dtCore::DeltaWin* mainWindow = GetGameActorProxy().GetGameManager()->GetApplication().GetWindow();
	dtCore::DeltaWin::Resolution currentRes = mainWindow->GetCurrentResolution();

	int width = currentRes.width;
	int height = currentRes.height;

	double vfov, aspectRatio, nearClip, farClip;
	mCam->GetPerspectiveParams(vfov, aspectRatio, nearClip, farClip);
	vfov = 80 ;
	aspectRatio = width /(float) height ; 
	mCam->SetPerspectiveParams( vfov, aspectRatio, 0.01f, farClip );
	mCam->SetClearColor(0.0f, 0.0f, 1.0f, 1.f);*/


	AddChild(mCam.get());
}

//////////////////////////////////////////////////////////////////////////

void PlayerActor::pass_glare_shader()
{
	//osg::Group* root = static_cast<osg::Group*>(GetOSGNode());
	osg::StateSet* ss = GetOSGNode()->getOrCreateStateSet();

	ss->addUniform( new osg::Uniform( "uPassParticleGlare", 0 ) );
	ss->setTextureAttribute(0,new osg::TexEnv(osg::TexEnv::BLEND),osg::StateAttribute::ON);
	//ss->setMode()
	//Set Programs
	osg::ref_ptr<osg::Program> program = new osg::Program;

	char vertexSource[]=
		"void main(void)\n"
		"{\n"
		"    gl_TexCoord[0].st = gl_MultiTexCoord0.st;\n"
		"    gl_Position = ftransform();\n"
		"}\n";

	char fragmentSource[]=
		"uniform sampler2D uPassParticleGlare;\n"
		"\n"
		"void main(void)\n"
		"{\n"
		"   gl_FragData[0] = texture2D( uPassParticleGlare, gl_TexCoord[0].st );\n"
		"	gl_FragData[1] = vec4(0.0);\n"
		//"   vec4 color = texture2D( uPassParticleGlare, gl_TexCoord[0].st );\n"
		//"   gl_FragColor = color;\n"
		"}\n";

	program->setName( "partice_material" );
	program->addShader(new osg::Shader(osg::Shader::VERTEX,   vertexSource));
	program->addShader(new osg::Shader(osg::Shader::FRAGMENT, fragmentSource));
	ss->setAttributeAndModes( program, osg::StateAttribute::ON );
	ss->setMode( GL_DEPTH_TEST , osg::StateAttribute::OFF ) ;
	ss->setRenderBinDetails( 99, "RenderBin" ) ;
}


void PlayerActor::set_normal_shader()
{
	//osg::Group* root = static_cast<osg::Group*>(GetOSGNode());
	osg::StateSet* ss = GetOSGNode()->getOrCreateStateSet();

	ss->addUniform( new osg::Uniform( "baseTexture", 0 ) );
	ss->setTextureAttribute(0,new osg::TexEnv(osg::TexEnv::BLEND),osg::StateAttribute::ON);
	//ss->setMode()
	//Set Programs
	osg::ref_ptr<osg::Program> program = new osg::Program;

	char vertexSource[]=
		"void main(void)\n"
		"{\n"
		"    gl_Position = ftransform();\n"
		"    gl_TexCoord[0] = gl_MultiTexCoord0;\n"
		"}\n";

	char fragmentSource[]=
		"uniform sampler2D baseTexture;\n"
		"\n"
		"void main(void)\n"
		"{\n"
		"   vec4 color = texture2D( baseTexture, gl_TexCoord[0].st );\n"
		"   gl_FragColor = color;\n"
		"}\n";

	program->setName( "base_material" );
	program->addShader(new osg::Shader(osg::Shader::VERTEX,   vertexSource));
	program->addShader(new osg::Shader(osg::Shader::FRAGMENT, fragmentSource));
	ss->setMode(GL_CULL_FACE, osg::StateAttribute::OFF);
	ss->setAttributeAndModes( program, osg::StateAttribute::ON );
}
//////////////////////////////////////////////////////////////////////////
void PlayerActor::ProcessMessage(const dtGame::Message &message)
{
	if(GetGameActorProxy().IsInGM()){

		if(message.GetMessageType().GetName() == SimMessageType::UTILITY_AND_TOOLS.GetName())
		{
			ProcessOrderEvent(message);
		}
		
		//if (message.GetMessageType().GetName() == SimMessageType::ASROCK_EVENT.GetName())
	//	{
	//		processOrderAsrock(message);
	//	}

	}
}
void PlayerActor::OnEnteredWorld() 
{
	dtGame::GameActor::OnEnteredWorld();
	AddSender(&(GetGameActorProxy().GetGameManager()->GetScene()));
	GetGameActorProxy().GetGameManager()->GetScene().AddDrawable(this);

	//set_view_crossHair();

	mIsector->SetScene(&GetGameActorProxy().GetGameManager()->GetScene());

	set_info_config();
	set_info_text();
	//set_normal_shader();
	//pass_glare_shader();
	set_camera();	
}

void PlayerActor::yakhontFirstMode(const int mPhase, const int mLockFireShipID, const int mLockFireWeaponID, const int mLockFireLauncherID, const int mLockFireMissileID, const int mLockFireMissNumberID, const float dt)
{
	dtCore::Transform shipTransform;
	osg::Vec3 shipPos, shipRot;

	dtCore::Transform missileTransform;
	osg::Vec3 missPos, missRot;

	dtCore::Transform camPlayerTrans;
	osg::Vec3 camPlayerPOS, camPlayerROT; 

	attachedProxy2 = GetVehicleActorByID(mLockFireShipID);
	attachedProxy = GetMissileActors(mLockFireShipID, mLockFireWeaponID, mLockFireLauncherID, mLockFireMissileID, mLockFireMissNumberID);

	dtCore::RefPtr<YakhontMissileActor> YakhontMissile = static_cast<YakhontMissileActor*>(attachedProxy->GetActor());
	dtCore::RefPtr<VehicleActor> ship = static_cast<VehicleActor*>(attachedProxy2->GetActor());

	//waktu = waktu + dt;
	//std::cout<<"waktu : "<<waktu<<std::endl;
	
	ship->GetTransform(shipTransform);
	shipTransform.GetTranslation(shipPos);
	shipTransform.GetRotation(shipRot);

	YakhontMissile->GetTransform(missileTransform);
	missileTransform.GetTranslation(missPos);
	missileTransform.GetRotation(missRot);

	GetTransform(camPlayerTrans);
	camPlayerTrans.GetTranslation(camPlayerPOS);
	camPlayerTrans.GetRotation(camPlayerROT);

	if (attachedProxy.valid() && attachedProxy2.valid())
	{
		if (LockingStepObs0 == 0)
		{
			camPlayerPOS = RangeBearingToCoord(shipPos, 300, shipRot[0] + 90);
			camPlayerPOS = RangeBearingToCoord(camPlayerPOS, 650, (shipRot[0] + 180));
			camPlayerPOS[2] = 30;
			//std::cout<<"tes : "<<camPlayerPOS[2]<<std::endl;	

			float bearingCamtoMiss = ComputeBearingTo2(camPlayerPOS[0], camPlayerPOS[1], missPos[0], missPos[1]);
			float distCamtoMiss = RangeVec3(missPos, camPlayerPOS);

			float camDegtoMiss;
			if ((missPos[2]/distCamtoMiss) > 1)
			{
				float aSinCalc = 2 - (missPos[2]/distCamtoMiss);
				camDegtoMiss = osg::RadiansToDegrees(asin(aSinCalc));
			}
			else
			{
				camDegtoMiss = osg::RadiansToDegrees(asin(missPos[2]/distCamtoMiss));
			}

			//float tesmiss = osg::RadiansToDegrees(asin(missPos[2]/distCamtoMiss));
			//float tessmiss2 = missPos[2]/distCamtoMiss;

			camPlayerROT[0] = (-bearingCamtoMiss);
			camPlayerROT[1] = camDegtoMiss;

			float dist = CalculateVec3Distance(shipPos, missPos);
			//std::cout<<"distance : "<<dist<<std::endl;

			//std::cout<<"mphase : "<<mPhase<<std::endl;
			/*waktu = dt + waktu;

			if (mPhase > tempMphase)
			{
				std::cout<<"mphase : "<<mPhase<<std::endl;
				std::cout<<"mphase : "<<mPhase<<std::endl;
				std::cout<<"waktu : "<<waktu<<std::endl;
				tempMphase = mPhase;
			}
			*/
			/*if (tessmiss2 > 0.9)
			{
				std::cout<<"hitungan : "<<tessmiss2<<std::endl;
				std::cout<<"camdegtomiss : "<<tesmiss<<std::endl;
			}*/
		
			if (dist >= 3000)
			{
				LockingStepObs0 = 1;
			}

			camPlayerTrans.SetTranslation(camPlayerPOS);
			camPlayerTrans.SetRotation(camPlayerROT);
			SetTransform(camPlayerTrans);
		}

		else if (LockingStepObs0 == 1)
		{
			float bearingCamtoMiss = ComputeBearingTo2(camPlayerPOS[0], camPlayerPOS[1], missPos[0], missPos[1]);
		
			camPlayerPOS = RangeBearingToCoord(camPlayerPOS, 1000.0f*dt, ValidateDegree(bearingCamtoMiss));
			//camPlayerPOS[2] = missPos[2] + 10;
			
			if (camPlayerPOS[2] <= (camPlayerPOS[2] + 10))
			{
				camPlayerPOS[2] = camPlayerPOS[2] + (1.5* dt);
			}

			if (camPlayerROT[1] >= -10)
			{
				camPlayerROT[1] = camPlayerROT[1] - (1.5f * dt);
			}
			
			camPlayerROT[0] = (-bearingCamtoMiss);
			
			float dist = CalculateVec3Distance(camPlayerPOS, missPos);
			
	
			if (dist <= 100)
			{
				CameraHeading = 0;
				LockingStepObs0 = 2;
			}

			camPlayerTrans.SetTranslation(camPlayerPOS);
			camPlayerTrans.SetRotation(camPlayerROT);
			SetTransform(camPlayerTrans);
		}
		
		else if (LockingStepObs0 == 2)
		{
			if (isReadyToCircle)
			{
				CameraHeading	= CameraHeading + (30.0f * dt);
				CameraRange		= 100;
				CameraPitch		= 10;
				run_as_ViewObject(dt);

				if (CameraHeading >= 360)
				{
					isReadyToCircle = false;
					CameraHeading = 0;
				}
			}
			else
			{
				timeToCircle = timeToCircle + (10 * dt);

				CameraHeading	= 0;
				CameraRange		= 100;
				CameraPitch		= 10;
				run_as_ViewObject(dt);

				if (timeToCircle > 30)
				{
					isReadyToCircle = false;
					timeToCircle = 0;
				}
			}

			if (YakhontMissile->mShipTarget != NULL)
				{
					LockingStepObs0 = 3;
					//isReadyToCircle = false;
				}
		}

		else if (LockingStepObs0 == 3)
		{
			dtCore::Transform TargetTrans ;
			osg::Vec3 TargetPOS, TargetROT;

			if (YakhontMissile->mShipTarget == NULL)
			{
				LockingStepObs0 = 2;
			}
			else
			{
				dynamic_cast<VehicleActor*>(YakhontMissile->mShipTarget.get())->GetTransform(TargetTrans);
				TargetTrans.GetTranslation(TargetPOS);
				TargetTrans.GetRotation(TargetROT);
				//std::cout<<"tes : "<<dist<<std::endl;
				float dist = CalculateVec3Distance(missPos, TargetPOS);

				if (isReadyToCircle)
				{
					CameraHeading	= CameraHeading + (30.0f * dt);
					CameraRange		= 100;
					CameraPitch		= 10;
					run_as_ViewObject(dt);

					if (CameraHeading >= 360)
					{
						isReadyToCircle = false;
						CameraHeading = 0;
					}
				}
				else
				{
					timeToCircle = timeToCircle + (10 * dt);

					CameraHeading	= 0;
					CameraRange		= 100;
					CameraPitch		= 10;
					run_as_ViewObject(dt);

					if (timeToCircle > 30)
					{
						isReadyToCircle = false;
						timeToCircle = 0;
					}

				}
					
				if (dist >= 500 && dist <= 2000)
				{
					LockingStepObs0 = 4;	
				}
			}
		}

		else if (LockingStepObs0 == 4)
		{
			dtCore::Transform TargetTrans ;
			osg::Vec3 TargetPOS, TargetROT;
			
			if (YakhontMissile->mShipTarget == NULL)
			{
				LockingStepObs0 = 2;
			}
			else
			{
				dynamic_cast<VehicleActor*>(YakhontMissile->mShipTarget.get())->GetTransform(TargetTrans);
				TargetTrans.GetTranslation(TargetPOS);
				TargetTrans.GetRotation(TargetROT);
			
				CameraHeading	= 0;
				CameraRange		= 100;
				CameraPitch		= 10;
				run_as_ViewObject(dt);

				float dist = CalculateVec3Distance(missPos, TargetPOS);

				if (dist <= 500)
				{
					LockingStepObs0 = 5;
				}
			}
		}

		else if (LockingStepObs0 == 5)
		{
			camPlayerPOS = RangeBearingToCoord(camPlayerPOS, 50.0f*dt, missRot[0] + 45);
			float bearingCamtoMiss = ComputeBearingTo2(camPlayerPOS[0], camPlayerPOS[1], missPos[0], missPos[1]);
			camPlayerROT[0] = (-bearingCamtoMiss);

			camPlayerTrans.SetTranslation(camPlayerPOS);
			camPlayerTrans.SetRotation(camPlayerROT);
			SetTransform(camPlayerTrans);
		}
	}
}

void PlayerActor::yakhontSecondMode(const int mPhase, const int mLockFireShipID, const int mLockFireWeaponID, const int mLockFireLauncherID, const int mLockFireMissileID, const int mLockFireMissNumberID, const float dt)
{
	dtCore::Transform shipTransform;
	osg::Vec3 shipPos, shipRot;

	dtCore::Transform missileTransform;
	osg::Vec3 missPos, missRot;

	dtCore::Transform camPlayerTrans;
	osg::Vec3 camPlayerPOS, camPlayerROT; 

	//waktu = waktu + dt;
	//std::cout<<"waktu : "<<waktu<<std::endl;

	attachedProxy2 = GetVehicleActorByID(mLockFireShipID);
	attachedProxy = GetMissileActors(mLockFireShipID, mLockFireWeaponID, mLockFireLauncherID, mLockFireMissileID, mLockFireMissNumberID);

	dtCore::RefPtr<YakhontMissileActor> YakhontMissile = static_cast<YakhontMissileActor*>(attachedProxy->GetActor());
	dtCore::RefPtr<VehicleActor> ship = static_cast<VehicleActor*>(attachedProxy2->GetActor());
	
	ship->GetTransform(shipTransform);
	shipTransform.GetTranslation(shipPos);
	shipTransform.GetRotation(shipRot);

	YakhontMissile->GetTransform(missileTransform);
	missileTransform.GetTranslation(missPos);
	missileTransform.GetRotation(missRot);

	GetTransform(camPlayerTrans);
	camPlayerTrans.GetTranslation(camPlayerPOS);
	camPlayerTrans.GetRotation(camPlayerROT);

	if (attachedProxy.valid() && attachedProxy2.valid())
	{
		//std::cout<<"phase : "<<mPhase<<std::endl;
		if (LockingStepObs0 == 0)
		{
			camPlayerPOS = RangeBearingToCoord(shipPos, 300, shipRot[0] + 90);
			camPlayerPOS = RangeBearingToCoord(camPlayerPOS, 650, (shipRot[0] + 180));
			camPlayerPOS[2] = 30;
			//std::cout<<"tes : "<<camPlayerPOS[2]<<std::endl;	

			float bearingCamtoMiss = ComputeBearingTo2(camPlayerPOS[0], camPlayerPOS[1], missPos[0], missPos[1]);
			float distCamtoMiss = RangeVec3(missPos, camPlayerPOS);
			float camDegtoMiss;

			if ((missPos[2]/distCamtoMiss) > 1)
			{
				float aSinCalc = 2 - (missPos[2]/distCamtoMiss);
				camDegtoMiss = osg::RadiansToDegrees(asin(aSinCalc));
			}
			else
			{
				camDegtoMiss = osg::RadiansToDegrees(asin(missPos[2]/distCamtoMiss));
			}

			camPlayerROT[0] = (-bearingCamtoMiss);
			camPlayerROT[1] = camDegtoMiss;

			float dist = CalculateVec3Distance(shipPos, missPos);
			//std::cout<<"distance : "<<dist<<std::endl;

			if (dist >= 3000)
			{
				LockingStepObs0 = 1;
			}

			camPlayerTrans.SetTranslation(camPlayerPOS);
			camPlayerTrans.SetRotation(camPlayerROT);
			SetTransform(camPlayerTrans);
		}

		else if (LockingStepObs0 == 1)
		{
			float bearingCamtoMiss = ComputeBearingTo2(camPlayerPOS[0], camPlayerPOS[1], missPos[0], missPos[1]);
		
			camPlayerPOS = RangeBearingToCoord(camPlayerPOS, 1000.0f*dt, ValidateDegree(bearingCamtoMiss));
			//camPlayerPOS[2] = missPos[2] + 10;
			
			if (camPlayerPOS[2] <= (camPlayerPOS[2] + 10))
			{
				camPlayerPOS[2] = camPlayerPOS[2] + (1.5* dt);
			}

			if (camPlayerROT[1] >= -10)
			{
				camPlayerROT[1] = camPlayerROT[1] - (1.5f * dt);
			}
			
			camPlayerROT[0] = (-bearingCamtoMiss);
			
			float dist = CalculateVec3Distance(camPlayerPOS, missPos);

			if (dist <= 100)
			{
				CameraHeading = 0;
				LockingStepObs0 = 2;
			}

			camPlayerTrans.SetTranslation(camPlayerPOS);
			camPlayerTrans.SetRotation(camPlayerROT);
			SetTransform(camPlayerTrans);
		}
		
		else if (LockingStepObs0 == 2)
		{
			if (isReadyToCircle)
			{
				CameraHeading	= CameraHeading + (30.0f * dt);
				CameraRange		= 100;
				CameraPitch		= 10;
				run_as_ViewObject(dt);

				if (CameraHeading >= 360)
				{
					isReadyToCircle = false;
					CameraHeading = 0;
				}
			}
			else
			{
				timeToCircle = timeToCircle + (10 * dt);

				CameraHeading	= 0;
				CameraRange		= 100;
				CameraPitch		= 10;
				run_as_ViewObject(dt);

				if (timeToCircle > 30)
				{
					isReadyToCircle = false;
					timeToCircle = 0;
				}
			}

			if (mPhase > 4 && mPhase < 7)
			{
				isReadyToCircle = false;

				camPlayerPOS = RangeBearingToCoord(missPos, 300, missRot[0] + 45);
				camPlayerPOS[2] = 30;
				
				float bearingCamtoMiss = ComputeBearingTo2(camPlayerPOS[0], camPlayerPOS[1], missPos[0], missPos[1]);
				float distCamtoMiss = RangeVec3(missPos, camPlayerPOS);
				float camDegtoMiss = osg::RadiansToDegrees(asin(missPos[2]/distCamtoMiss));

				camPlayerROT[0] = (-bearingCamtoMiss);
				camPlayerROT[1] = camDegtoMiss;

				camPlayerTrans.SetTranslation(camPlayerPOS);
				camPlayerTrans.SetRotation(camPlayerROT);
				SetTransform(camPlayerTrans);
			}

			if (YakhontMissile->mShipTarget != NULL)
				{
					LockingStepObs0 = 3;
					//isReadyToCircle = false;
				}
		}

		else if (LockingStepObs0 == 3)
		{
			dtCore::Transform TargetTrans ;
			osg::Vec3 TargetPOS, TargetROT;

			if (YakhontMissile->mShipTarget == NULL)
			{
				LockingStepObs0 = 2;
			}
			else
			{
				dynamic_cast<VehicleActor*>(YakhontMissile->mShipTarget.get())->GetTransform(TargetTrans);
				TargetTrans.GetTranslation(TargetPOS);
				TargetTrans.GetRotation(TargetROT);
				//std::cout<<"tes : "<<dist<<std::endl;
				float dist = CalculateVec3Distance(missPos, TargetPOS);

				if (isReadyToCircle)
				{
					CameraHeading	= CameraHeading + (30.0f * dt);
					CameraRange		= 100;
					CameraPitch		= 10;
					run_as_ViewObject(dt);

					if (CameraHeading >= 360)
					{
						isReadyToCircle = false;
						CameraHeading = 0;
					}
				}
				else
				{
					timeToCircle = timeToCircle + (10 * dt);

					CameraHeading	= 0;
					CameraRange		= 100;
					CameraPitch		= 10;
					run_as_ViewObject(dt);

					if (timeToCircle > 30)
					{
						isReadyToCircle = false;
						timeToCircle = 0;
					}

				}

				if (dist >= 500 && dist <= 2000)
				{
					LockingStepObs0 = 4;	
				}
			}
		}

		else if (LockingStepObs0 == 4)
		{
			dtCore::Transform TargetTrans ;
			osg::Vec3 TargetPOS, TargetROT;

			if (YakhontMissile->mShipTarget == NULL)
			{
				LockingStepObs0 = 2;
			}
			else 
			{
				dynamic_cast<VehicleActor*>(YakhontMissile->mShipTarget.get())->GetTransform(TargetTrans);
				TargetTrans.GetTranslation(TargetPOS);
				TargetTrans.GetRotation(TargetROT);

				CameraHeading	= 0;
				CameraRange		= 100;
				CameraPitch		= 10;
				run_as_ViewObject(dt);

				float dist = CalculateVec3Distance(missPos, TargetPOS);

				if (dist <= 500)
				{
					LockingStepObs0 = 5;
				}
			}
		}

		else if (LockingStepObs0 == 5)
		{
			camPlayerPOS = RangeBearingToCoord(camPlayerPOS, 50.0f*dt, missRot[0] + 45);
			float bearingCamtoMiss = ComputeBearingTo2(camPlayerPOS[0], camPlayerPOS[1], missPos[0], missPos[1]);

			camPlayerROT[0] = (-bearingCamtoMiss);

			camPlayerTrans.SetTranslation(camPlayerPOS);
			camPlayerTrans.SetRotation(camPlayerROT);
			SetTransform(camPlayerTrans);
		}
	}

}

void PlayerActor::yakhontThirdMode(const int mPhase, const int mLockFireShipID, const int mLockFireWeaponID, const int mLockFireLauncherID, const int mLockFireMissileID, const int mLockFireMissNumberID, const float dt)
{
	dtCore::Transform shipTransform;
	osg::Vec3 shipPos, shipRot;

	dtCore::Transform missileTransform;
	osg::Vec3 missPos, missRot;

	dtCore::Transform camPlayerTrans;
	osg::Vec3 camPlayerPOS, camPlayerROT; 

	attachedProxy2 = GetVehicleActorByID(mLockFireShipID);
	attachedProxy = GetMissileActors(mLockFireShipID, mLockFireWeaponID, mLockFireLauncherID, mLockFireMissileID, mLockFireMissNumberID);

	dtCore::RefPtr<YakhontMissileActor> YakhontMissile = static_cast<YakhontMissileActor*>(attachedProxy->GetActor());
	dtCore::RefPtr<VehicleActor> ship = static_cast<VehicleActor*>(attachedProxy2->GetActor());
	
	ship->GetTransform(shipTransform);
	shipTransform.GetTranslation(shipPos);
	shipTransform.GetRotation(shipRot);

	YakhontMissile->GetTransform(missileTransform);
	missileTransform.GetTranslation(missPos);
	missileTransform.GetRotation(missRot);

	GetTransform(camPlayerTrans);
	camPlayerTrans.GetTranslation(camPlayerPOS);
	camPlayerTrans.GetRotation(camPlayerROT);

	if (attachedProxy.valid() && attachedProxy2.valid())
	{
		/*CameraHeading	= 0;
		CameraRange		= 300;
		CameraPitch		= 10;
		run_as_ViewObject(dt);*/

		if (LockingStepObs0 == 0)
		{
			camPlayerPOS = RangeBearingToCoord(shipPos, 300, shipRot[0] + 90);
			camPlayerPOS = RangeBearingToCoord(camPlayerPOS, 650, (shipRot[0] + 180));
			camPlayerPOS[2] = 30;
			//std::cout<<"tes : "<<camPlayerPOS[2]<<std::endl;	

			float bearingCamtoMiss = ComputeBearingTo2(camPlayerPOS[0], camPlayerPOS[1], missPos[0], missPos[1]);
			float distCamtoMiss = RangeVec3(missPos, camPlayerPOS);
			float camDegtoMiss;

			if ((missPos[2]/distCamtoMiss) > 1)
			{
				float aSinCalc = 2 - (missPos[2]/distCamtoMiss);
				camDegtoMiss = osg::RadiansToDegrees(asin(aSinCalc));
			}
			else
			{
				camDegtoMiss = osg::RadiansToDegrees(asin(missPos[2]/distCamtoMiss));
			}
			camPlayerROT[0] = (-bearingCamtoMiss);
			camPlayerROT[1] = camDegtoMiss;

			float dist = CalculateVec3Distance(shipPos, missPos);
			//std::cout<<"distance : "<<dist<<std::endl;

			if (dist >= 5500)
			{
				LockingStepObs0 = 1;
			}

			camPlayerTrans.SetTranslation(camPlayerPOS);
			camPlayerTrans.SetRotation(camPlayerROT);
			SetTransform(camPlayerTrans);
		}

		else if (LockingStepObs0 == 1)
		{
			
			CameraHeading	= 0;
			CameraRange		= 300;
			CameraPitch		= 10;

			//std::cout<<"fase : "<<mPhase<<std::endl;

			float Mx, My;
			float newRange;
			float SinX, CosX;

			dtCore::RefPtr<dtGame::GameActor> ObjView = static_cast<dtGame::GameActor*>(attachedProxy->GetActor());	

			// Object Transform
			ObjView->GetTransform(targetTransform);
			targetTransform.GetTranslation(targetPosition);
			targetTransform.GetRotation(targetRotation);

			// Camera Transform
			dtCore::Transform camPlayerTrans;
			osg::Vec3 camPlayerPOS, camPlayerROT; 
			GetTransform(camPlayerTrans);
			camPlayerTrans.GetTranslation(camPlayerPOS);
			camPlayerTrans.GetRotation(camPlayerROT);

			camPlayerROT[0] = targetRotation[0] + CameraHeading; 
			camPlayerROT[1] = -CameraPitch;
			camPlayerROT[2] = 0;

			newRange = cos(osg::DegreesToRadians(CameraPitch)) * -CameraRange;
			SinX	 = sin(osg::DegreesToRadians(ConvCompass_To_Cartesian(ValidateDegree( -camPlayerROT[0] ))));
			CosX	 = cos(osg::DegreesToRadians(ConvCompass_To_Cartesian(ValidateDegree( -camPlayerROT[0] ))));
			Mx		 = newRange * CosX;
			My		 = newRange * SinX;

			camPlayerPOS.x() = targetPosition.x() + Mx;
			camPlayerPOS.y() = targetPosition.y() + My;
			camPlayerPOS.z() = 100;
			
			if (mPhase == 4)
			{
				tempRot = missRot[0];
			}

			else if (mPhase == 5)
			{
				LockingStepObs0 = 2;
			}

			camPlayerTrans.SetTranslation(camPlayerPOS);
			camPlayerTrans.SetRotation(camPlayerROT);
			SetTransform(camPlayerTrans);
		
		}

		else if (LockingStepObs0 == 2)
		{
			if (camPlayerPOS[2] > 30)
			{
				camPlayerPOS[2] = camPlayerPOS[2] - (100.0f * dt);
			}

			if (missPos[2] > 5000)
			{
				camPlayerROT[1] = 80;
			}
			else if (missPos[2] <= 5000)
			{
			
				float distCamtoMiss = RangeVec3(missPos, camPlayerPOS);
				float camDegtoMiss = osg::RadiansToDegrees(asin(missPos[2]/distCamtoMiss));

				camPlayerROT[1] = camDegtoMiss;

				if (mPhase == 6)
				{
					LockingStepObs0 = 3;
				}
			}
			
			camPlayerTrans.SetTranslation(camPlayerPOS);
			camPlayerTrans.SetRotation(camPlayerROT);
			SetTransform(camPlayerTrans);
		}
		
		else if (LockingStepObs0 == 3)
		{
			float bearingCamtoMiss = ComputeBearingTo2(camPlayerPOS[0], camPlayerPOS[1], missPos[0], missPos[1]);

			camPlayerPOS = RangeBearingToCoord(camPlayerPOS, 1000.0f*dt, ValidateDegree(bearingCamtoMiss));

			if (camPlayerPOS[2] <= (camPlayerPOS[2] + 10))
			{
				camPlayerPOS[2] = camPlayerPOS[2] + (1.5* dt);
			}

			if (camPlayerROT[1] >= -10)
			{
				camPlayerROT[1] = camPlayerROT[1] - (1.5f * dt);
			}

			camPlayerROT[0] = (-bearingCamtoMiss);

			float dist = CalculateVec3Distance(camPlayerPOS, missPos);

			if (dist <= 100)
			{
				CameraHeading = 0;
				LockingStepObs0 = 4;
			}

			camPlayerTrans.SetTranslation(camPlayerPOS);
			camPlayerTrans.SetRotation(camPlayerROT);
			SetTransform(camPlayerTrans);
		}

		else if (LockingStepObs0 == 4)
		{
			if (isReadyToCircle)
			{
				CameraHeading	= CameraHeading + (30.0f * dt);
				CameraRange		= 100;
				CameraPitch		= 10;
				run_as_ViewObject(dt);

				if (CameraHeading >= 360)
				{
					isReadyToCircle = false;
					CameraHeading = 0;
				}
			}
			else
			{
				timeToCircle = timeToCircle + (10 * dt);

				CameraHeading	= 0;
				CameraRange		= 100;
				CameraPitch		= 10;
				run_as_ViewObject(dt);

				if (timeToCircle > 30)
				{
					isReadyToCircle = false;
					timeToCircle = 0;
				}
			}

			if (YakhontMissile->mShipTarget != NULL)
				{
					LockingStepObs0 = 5;
					//isReadyToCircle = false;
				}

		}

		else if (LockingStepObs0 == 5)
		{
			dtCore::Transform TargetTrans ;
			osg::Vec3 TargetPOS, TargetROT;
			
			if (YakhontMissile->mShipTarget == NULL)
			{
				LockingStepObs0 = 4;
			}
			else
			{
				dynamic_cast<VehicleActor*>(YakhontMissile->mShipTarget.get())->GetTransform(TargetTrans);
				TargetTrans.GetTranslation(TargetPOS);
				TargetTrans.GetRotation(TargetROT);
				//std::cout<<"tes : "<<dist<<std::endl;
				float dist = CalculateVec3Distance(missPos, TargetPOS);

				if (isReadyToCircle)
				{
					CameraHeading	= CameraHeading + (30.0f * dt);
					CameraRange		= 100;
					CameraPitch		= 10;
					run_as_ViewObject(dt);

					if (CameraHeading >= 360)
					{
						isReadyToCircle = false;
						CameraHeading = 0;
					}
				}
				else
				{
					timeToCircle = timeToCircle + (10 * dt);

					CameraHeading	= 0;
					CameraRange		= 100;
					CameraPitch		= 10;
					run_as_ViewObject(dt);

					if (timeToCircle > 30)
					{
						isReadyToCircle = false;
						timeToCircle = 0;
					}

				}

				if (dist >= 500 && dist <= 2000)
				{
					LockingStepObs0 = 6;	
				}
			}
		}

		else if (LockingStepObs0 == 6)
		{
			dtCore::Transform TargetTrans ;
			osg::Vec3 TargetPOS, TargetROT;

			if (YakhontMissile->mShipTarget == NULL)
			{
				LockingStepObs0 = 4;
			}
			else
			{
				dynamic_cast<VehicleActor*>(YakhontMissile->mShipTarget.get())->GetTransform(TargetTrans);
				TargetTrans.GetTranslation(TargetPOS);
				TargetTrans.GetRotation(TargetROT);

				CameraHeading	= 0;
				CameraRange		= 100;
				CameraPitch		= 10;
				run_as_ViewObject(dt);

				float dist = CalculateVec3Distance(missPos, TargetPOS);

				if (dist <= 500)
				{
					LockingStepObs0 = 7;
				}
			}
		}

		else if (LockingStepObs0 == 7)
		{
			camPlayerPOS = RangeBearingToCoord(camPlayerPOS, 50.0f*dt, missRot[0] + 45);
			float bearingCamtoMiss = ComputeBearingTo2(camPlayerPOS[0], camPlayerPOS[1], missPos[0], missPos[1]);

			camPlayerROT[0] = (-bearingCamtoMiss);

			camPlayerTrans.SetTranslation(camPlayerPOS);
			camPlayerTrans.SetRotation(camPlayerROT);
			SetTransform(camPlayerTrans);
		}
	}
}

void PlayerActor::yakhontFourthMode(const int mPhase, const int mLockFireShipID, const int mLockFireWeaponID, const int mLockFireLauncherID, const int mLockFireMissileID, const int mLockFireMissNumberID, const float dt)
{
	/*CameraHeading	= 0;
	CameraRange		= 100;
	CameraPitch		= 10; 
	run_as_ViewObject(dt);

	std::cout<<"phase : "<<mPhase<<std::endl;*/
	
	//waktu = waktu + dt;
	//std::cout<<"waktu : "<<waktu<<std::endl;

	dtCore::Transform shipTransform;
	osg::Vec3 shipPos, shipRot;

	dtCore::Transform missileTransform;
	osg::Vec3 missPos, missRot;

	dtCore::Transform camPlayerTrans;
	osg::Vec3 camPlayerPOS, camPlayerROT; 

	attachedProxy2 = GetVehicleActorByID(mLockFireShipID);
	attachedProxy = GetMissileActors(mLockFireShipID, mLockFireWeaponID, mLockFireLauncherID, mLockFireMissileID, mLockFireMissNumberID);

	dtCore::RefPtr<YakhontMissileActor> YakhontMissile = static_cast<YakhontMissileActor*>(attachedProxy->GetActor());
	dtCore::RefPtr<VehicleActor> ship = static_cast<VehicleActor*>(attachedProxy2->GetActor());

	ship->GetTransform(shipTransform);
	shipTransform.GetTranslation(shipPos);
	shipTransform.GetRotation(shipRot);

	YakhontMissile->GetTransform(missileTransform);
	missileTransform.GetTranslation(missPos);
	missileTransform.GetRotation(missRot);

	GetTransform(camPlayerTrans);
	camPlayerTrans.GetTranslation(camPlayerPOS);
	camPlayerTrans.GetRotation(camPlayerROT);

	if (attachedProxy.valid() && attachedProxy2.valid())
	{
		if (LockingStepObs0 == 0)
		{
			camPlayerPOS = RangeBearingToCoord(shipPos, 300, shipRot[0] + 90);
			camPlayerPOS = RangeBearingToCoord(camPlayerPOS, 650, (shipRot[0] + 180));
			camPlayerPOS[2] = 30;
			//std::cout<<"tes : "<<camPlayerPOS[2]<<std::endl;	

			float bearingCamtoMiss = ComputeBearingTo2(camPlayerPOS[0], camPlayerPOS[1], missPos[0], missPos[1]);
			float distCamtoMiss = RangeVec3(missPos, camPlayerPOS);
			float camDegtoMiss;

			if ((missPos[2]/distCamtoMiss) > 1)
			{
				float aSinCalc = 2 - (missPos[2]/distCamtoMiss);
				camDegtoMiss = osg::RadiansToDegrees(asin(aSinCalc));
			}
			else
			{
				camDegtoMiss = osg::RadiansToDegrees(asin(missPos[2]/distCamtoMiss));
			}

			camPlayerROT[0] = (-bearingCamtoMiss);
			camPlayerROT[1] = camDegtoMiss;

			float dist = CalculateVec3Distance(shipPos, missPos);
			//std::cout<<"distance : "<<dist<<std::endl;

			if (dist >= 5500)
			{
				LockingStepObs0 = 1;
			}

			camPlayerTrans.SetTranslation(camPlayerPOS);
			camPlayerTrans.SetRotation(camPlayerROT);
			SetTransform(camPlayerTrans);
		}

		else if (LockingStepObs0 == 1)
		{

			CameraHeading	= 0;
			CameraRange		= 300;
			CameraPitch		= 10;

			//std::cout<<"fase : "<<mPhase<<std::endl;

			float Mx, My;
			float newRange;
			float SinX, CosX;

			dtCore::RefPtr<dtGame::GameActor> ObjView = static_cast<dtGame::GameActor*>(attachedProxy->GetActor());	

			// Object Transform
			ObjView->GetTransform(targetTransform);
			targetTransform.GetTranslation(targetPosition);
			targetTransform.GetRotation(targetRotation);

			// Camera Transform
			dtCore::Transform camPlayerTrans;
			osg::Vec3 camPlayerPOS, camPlayerROT; 
			GetTransform(camPlayerTrans);
			camPlayerTrans.GetTranslation(camPlayerPOS);
			camPlayerTrans.GetRotation(camPlayerROT);

			camPlayerROT[0] = targetRotation[0] + CameraHeading; 
			camPlayerROT[1] = -CameraPitch;
			camPlayerROT[2] = 0;

			newRange = cos(osg::DegreesToRadians(CameraPitch)) * -CameraRange;
			SinX	 = sin(osg::DegreesToRadians(ConvCompass_To_Cartesian(ValidateDegree( -camPlayerROT[0] ))));
			CosX	 = cos(osg::DegreesToRadians(ConvCompass_To_Cartesian(ValidateDegree( -camPlayerROT[0] ))));
			Mx		 = newRange * CosX;
			My		 = newRange * SinX;

			camPlayerPOS.x() = targetPosition.x() + Mx;
			camPlayerPOS.y() = targetPosition.y() + My;
			camPlayerPOS.z() = 100;
	
			if (mPhase == 5)
			{
				LockingStepObs0 = 2;
			}

			camPlayerTrans.SetTranslation(camPlayerPOS);
			camPlayerTrans.SetRotation(camPlayerROT);
			SetTransform(camPlayerTrans);

		}

		else if (LockingStepObs0 == 2)
		{
			if (camPlayerPOS[2] > 30)
			{
				camPlayerPOS[2] = camPlayerPOS[2] - (100.0f * dt);
			}

			if (missPos[2] > 5000)
			{
				camPlayerROT[1] = 80;
			}
			else if (missPos[2] <= 5000)
			{

				float distCamtoMiss = RangeVec3(missPos, camPlayerPOS);
				float camDegtoMiss = osg::RadiansToDegrees(asin(missPos[2]/distCamtoMiss));

				camPlayerROT[1] = camDegtoMiss;
	
				if (mPhase == 6)
				{
					LockingStepObs0 = 3;
				}
			}

			camPlayerTrans.SetTranslation(camPlayerPOS);
			camPlayerTrans.SetRotation(camPlayerROT);
			SetTransform(camPlayerTrans);
		}

		else if (LockingStepObs0 == 3)
		{
			float bearingCamtoMiss = ComputeBearingTo2(camPlayerPOS[0], camPlayerPOS[1], missPos[0], missPos[1]);

			camPlayerPOS = RangeBearingToCoord(camPlayerPOS, 1000.0f*dt, ValidateDegree(bearingCamtoMiss));

			if (camPlayerPOS[2] <= (camPlayerPOS[2] + 10))
			{
				camPlayerPOS[2] = camPlayerPOS[2] + (1.5* dt);
			}

			if (camPlayerROT[1] >= -10)
			{
				camPlayerROT[1] = camPlayerROT[1] - (1.5f * dt);
			}

			camPlayerROT[0] = (-bearingCamtoMiss);

			float dist = CalculateVec3Distance(camPlayerPOS, missPos);
	
			if (dist <= 100)
			{
				CameraHeading = 0;
				LockingStepObs0 = 4;
			}

			camPlayerTrans.SetTranslation(camPlayerPOS);
			camPlayerTrans.SetRotation(camPlayerROT);
			SetTransform(camPlayerTrans);
		}

		else if (LockingStepObs0 == 4)
		{
			if (isReadyToCircle)
			{
				CameraHeading	= CameraHeading + (30.0f * dt);
				CameraRange		= 100;
				CameraPitch		= 10;
				run_as_ViewObject(dt);

				if (CameraHeading >= 360)
				{
					isReadyToCircle = false;
					CameraHeading = 0;
				}
			}
			else
			{
				timeToCircle = timeToCircle + (10 * dt);

				CameraHeading	= 0;
				CameraRange		= 100;
				CameraPitch		= 10;
				run_as_ViewObject(dt);

				if (timeToCircle > 30)
				{
					isReadyToCircle = false;
					timeToCircle = 0;
				}
			}

			//std::cout<<"misspos[2] : "<<missPos[2]<<std::endl;

			if (mPhase == 6 && missPos[2] > 44)
			{
				//std::cout<<"rot : "<<missRot[0]<<std::endl;
				CameraRange = 200;
				run_as_ViewObject(dt);
				LockingStepObs0 = 5;
			}
		}	

		else if (LockingStepObs0 == 5)
		{
			camPlayerPOS[2] = 30;
			float distCamtoMiss = RangeVec3(missPos, camPlayerPOS);
			float camDegtoMiss = osg::RadiansToDegrees(asin(missPos[2]/distCamtoMiss));

			//camPlayerROT[0] = (-bearingCamtoMiss);
			camPlayerROT[1] = camDegtoMiss;

			//std::cout<<"camdeg : "<<camDegtoMiss<<std::endl;

			float dist = CalculateVec3Distance(camPlayerPOS, missPos);
			//std::cout<<"dist : "<<dist<<std::endl;

			if (dist >= 2600)
			{
				//std::cout<<"masuk bos "<<std::endl;
				LockingStepObs0 = 6;
			}

			camPlayerTrans.SetTranslation(camPlayerPOS);
			camPlayerTrans.SetRotation(camPlayerROT);
			SetTransform(camPlayerTrans);
			
		}

		else if (LockingStepObs0 == 6)
		{
			float bearingCamtoMiss = ComputeBearingTo2(camPlayerPOS[0], camPlayerPOS[1], missPos[0], missPos[1]);
			camPlayerPOS = RangeBearingToCoord(camPlayerPOS, 700.0f*dt, ValidateDegree(bearingCamtoMiss));

			float distCamtoMiss = RangeVec3(missPos, camPlayerPOS);
			float camDegtoMiss = osg::RadiansToDegrees(asin(missPos[2]/distCamtoMiss));
			camPlayerROT[1] = camDegtoMiss;
	
			if (mPhase == 10)
			{
				LockingStepObs0 = 7;
			}
			camPlayerTrans.SetTranslation(camPlayerPOS);
			camPlayerTrans.SetRotation(camPlayerROT);
			SetTransform(camPlayerTrans);
		}

		else if (LockingStepObs0 == 7)
		{
			//std::cout<<"7"<<std::endl;
			float bearingCamtoMiss = ComputeBearingTo2(camPlayerPOS[0], camPlayerPOS[1], missPos[0], missPos[1]);

			camPlayerPOS = RangeBearingToCoord(camPlayerPOS, 1000.0f*dt, ValidateDegree(bearingCamtoMiss));

			if (camPlayerPOS[2] <= (camPlayerPOS[2] + 10))
			{
				camPlayerPOS[2] = camPlayerPOS[2] + (1.5* dt);
			}

			if (camPlayerROT[1] >= -10)
			{
				camPlayerROT[1] = camPlayerROT[1] - (1.5f * dt);
			}

			camPlayerROT[0] = (-bearingCamtoMiss);

			float dist = CalculateVec3Distance(camPlayerPOS, missPos);
		
			if (dist <= 100)
			{
				LockingStepObs0 = 8;
			}

			camPlayerTrans.SetTranslation(camPlayerPOS);
			camPlayerTrans.SetRotation(camPlayerROT);
			SetTransform(camPlayerTrans);
		}

		else if (LockingStepObs0 == 8)
		{
			//std::cout<<"8"<<std::endl;
			CameraHeading = 0;
			CameraPitch = 10;
			CameraRange = 100;
			run_as_ViewObject(dt);
	
			if (YakhontMissile->mShipTarget != NULL)
			{
				LockingStepObs0 = 9;
			}
		}

		else if (LockingStepObs0 == 9)
		{
			dtCore::Transform TargetTrans ;
			osg::Vec3 TargetPOS, TargetROT;
			
			if (YakhontMissile->mShipTarget == NULL)
			{
				LockingStepObs0 = 8;
			}
			else
			{
				dynamic_cast<VehicleActor*>(YakhontMissile->mShipTarget.get())->GetTransform(TargetTrans);
				TargetTrans.GetTranslation(TargetPOS);
				TargetTrans.GetRotation(TargetROT);
				//std::cout<<"tes : "<<dist<<std::endl;
				float dist = CalculateVec3Distance(missPos, TargetPOS);
		
				if (dist <= 500)
				{
					LockingStepObs0 = 10;
				}
			}
		}

		else if (LockingStepObs0 == 10)
		{
			camPlayerPOS = RangeBearingToCoord(camPlayerPOS, 50.0f*dt, missRot[0] + 45);
			float bearingCamtoMiss = ComputeBearingTo2(camPlayerPOS[0], camPlayerPOS[1], missPos[0], missPos[1]);

			camPlayerROT[0] = (-bearingCamtoMiss);

			camPlayerTrans.SetTranslation(camPlayerPOS);
			camPlayerTrans.SetRotation(camPlayerROT);
			SetTransform(camPlayerTrans);
		}
	}
}

void PlayerActor::yakhontRelease(const int mLockFireShipID, const int mLockFireWeaponID, const int mLockFireLauncherID, const int mLockFireMissileID, const int mLockFireMissNumberID, const float dt)
{
	dtCore::Transform shipTransform;
	osg::Vec3 shipPos, shipRot;

	dtCore::Transform missileTransform;
	osg::Vec3 missPos, missRot;

	dtCore::Transform camPlayerTrans;
	osg::Vec3 camPlayerPOS, camPlayerROT; 

	attachedProxy2 = GetVehicleActorByID(mLockFireShipID);
	attachedProxy = GetMissileActors(mLockFireShipID, mLockFireWeaponID, mLockFireLauncherID, mLockFireMissileID, mLockFireMissNumberID);

	dtCore::RefPtr<YakhontMissileActor> YakhontMissile = static_cast<YakhontMissileActor*>(attachedProxy->GetActor());
	dtCore::RefPtr<VehicleActor> ship = static_cast<VehicleActor*>(attachedProxy2->GetActor());

	ship->GetTransform(shipTransform);
	shipTransform.GetTranslation(shipPos);
	shipTransform.GetRotation(shipRot);

	YakhontMissile->GetTransform(missileTransform);
	missileTransform.GetTranslation(missPos);
	missileTransform.GetRotation(missRot);

	GetTransform(camPlayerTrans);
	camPlayerTrans.GetTranslation(camPlayerPOS);
	camPlayerTrans.GetRotation(camPlayerROT);

	if (attachedProxy.valid() && attachedProxy2.valid())
	{
		camPlayerPOS = RangeBearingToCoord(shipPos, 300, shipRot[0] + 90);
		camPlayerPOS = RangeBearingToCoord(camPlayerPOS, 650, (shipRot[0] + 180));
		camPlayerPOS[2] = 30;	

		float bearingCamtoMiss = ComputeBearingTo2(camPlayerPOS[0], camPlayerPOS[1], missPos[0], missPos[1]);
		float distCamtoMiss = RangeVec3(missPos, camPlayerPOS);
		float camDegtoMiss;

		if ((missPos[2]/distCamtoMiss) > 1)
		{
			float aSinCalc = 2 - (missPos[2]/distCamtoMiss);
			camDegtoMiss = osg::RadiansToDegrees(asin(aSinCalc));
		}
		else
		{
			camDegtoMiss = osg::RadiansToDegrees(asin(missPos[2]/distCamtoMiss));
		}

		camPlayerROT[0] = (-bearingCamtoMiss);
		camPlayerROT[1] = camDegtoMiss;

		camPlayerTrans.SetTranslation(camPlayerPOS);
		camPlayerTrans.SetRotation(camPlayerROT);
		SetTransform(camPlayerTrans);
	}
	
}
//////////////////////////////////////////////////////////////////////////

PlayerActorProxy::PlayerActorProxy()
{

}


PlayerActorProxy::~PlayerActorProxy()
{

}

void PlayerActorProxy::BuildPropertyMap()
{
	dtGame::GameActorProxy::BuildPropertyMap();

}

void PlayerActorProxy::BuildInvokables()
{
	dtGame::GameActorProxy::BuildInvokables();
}

//////////////////////////////////////////////////////////////////////////
 

void PlayerActorProxy::OnEnteredWorld()
{
	dtGame::GameActorProxy::OnEnteredWorld();
	RegisterForMessages(dtGame::MessageType::TICK_LOCAL, dtGame::GameActorProxy::TICK_LOCAL_INVOKABLE);
	RegisterForMessages(SimMessageType::UTILITY_AND_TOOLS);
	GetActor()->AddSender(&(GetGameManager()->GetScene()));
}

void PlayerActorProxy::OnRemovedFromWorld()
{
	/*PlayerActor &pa = static_cast<PlayerActor&>(GetGameActor());

	if (dtAudio::AudioManager::GetInstance().IsInitialized() && pa.mPlayerSound != NULL)
	{
		dtAudio::AudioManager::GetInstance().FreeSound(pa.mPlayerSound);
	}*/
}

//////////////////////////////////////////////////////////////////////////