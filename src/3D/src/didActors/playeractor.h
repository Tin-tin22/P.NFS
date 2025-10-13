/* -*-c++-*-
 2012.05.06 Sam Create 
 */

#ifndef DID_PLAYER_ACTOR
#define DID_PLAYER_ACTOR

#include "playeractor.h"
#include "didactorsheaders.h"
#include <osgText/Text>
#include <dtCore/compass.h>

namespace dtCore
{
   class Isector;
   class ParticleSystem;
}

namespace dtAudio
{
   class Sound;
}

 
class DID_ACTORS_EXPORT PlayerActor : public dtGame::GameActor
{
   public:

	  PlayerActor(dtGame::GameActorProxy& proxy);
	  
	  unsigned int mPlayerID ;
	  unsigned int mPlayerType ;
	  unsigned int targetIDAsrock;
	  unsigned int targetIDRBU;
	  float rangeBearingExo;
	  float angularMode;

      virtual void TickLocal(const dtGame::Message &tickMessage);
	  virtual void ProcessMessage(const dtGame::Message &message);
	
	  virtual void set_camera();

	  void SetAttachToVehicleID(const int mVehicleID );
	  void SetAttachToLauncher(const int mVehicleID, const int mWeaponID , const int mLauncherID  );
	  void SetAttachToMissile(const int mVehicleID, const int mWeaponID , const int mLauncherID , const int mMissileID, const int mMissileNum );

	  void SetAttachToTDS(const int mVehicleID, const int mWeaponID , const int mLauncherID);

	  void SetPlayerType(const int tipe);
	  void SetPlayerID(const int id);
	  void SetTargetIDAsrock(const int id);
	  void SetTargetIDRBU(const int id);
	  void setTargetBearingExo(const float rangeBearing);
	  void setAngularModePlayer(const float angularMode);

	  void SetPlayerDefaultLock(const int lockID);
	  void SetPlayerObjectLock(const int ObjectID);

      void AddToEnvironmentActor();
	  void set_view_crossHair(); // create cross hair [7/31/2013 DID RKT2]

	  osg::Vec3 vPoss,vPosr,vPoss2;
	  dtCore::Transform CurrentPoss ;
	  bool isFirst;

   protected:

      virtual void OnEnteredWorld();
      
	  virtual ~PlayerActor();

   private:
	  void set_setting_base (const int set2, const int set3, const int set4, const int set5, const int set6); 
	  void set_setting_observer (const int set2, const int set3, const int set4, const int set5, const int set6); 
	  void set_setting_attach_ship (const int set2, const int set3, const int set4, const int set5, const int set6);
	  void set_setting_attach_launcher (const int set2, const int set3, const int set4, const int set5, const int set6);
	  void set_setting_attach_missile ( const int set2, const int set3, const int set4, const int set5, const int set6);

	  //////////////////////////////////////////////////////////////////////////
	  int validateRotation(const float val );

      void rotate_player();
      void move_player();

      void increase_speed();
      void decrease_speed();

	  void set_current_move_state(const int from, const int st);
	  void set_current_rotate_state(const int from, const int st);

	  void set_player_vehicle_focus(int VID );
	  void cycle_player_ship_focus();
	  void cycle_player_submarine_focus();
	  void cycle_player_heli_focus();

	  void set_info_config();
	  void set_info_text();
	  void pass_glare_shader();
	  void set_normal_shader();
	  
	  dtCore::RefPtr<dtDAL::ActorProxy> GetVehicleActorByID(int VID );
	  /**

	  * @ actTypeID = C_WEAPON_TYPE_BODY / C_WEAPON_TYPE_SPOUT / C_WEAPON_TYPE_MISSILE
	  * @ see utilityfunction.h GetActorWeaponTypeName
	  */
	  dtCore::RefPtr<dtDAL::ActorProxy> GetLauncherActors(const int actTypeID, const int mVehicleID, const int mWeaponID, const int mLauncherID  );
	  dtCore::RefPtr<dtDAL::ActorProxy> GetMissileActors(const int mVehicleID, const int mWeaponID, const int mLauncherID, const int mMissileID, const int mMissileNum );


	  void chkPassable(const dtCore::DeltaDrawable *t, const dtCore::DeltaDrawable *s, bool &bChk);
	  dtDAL::ActorProxy* ceck_intersection(float dt);
	
	  
	  void ceckKeyState(const float dt);

	  void fly_to_ship_parent(const float dt);

	  void run_with_position(const dtCore::Transform &xform, const double dt);
	  void run_as_child(float dt);
	  void run_as_observer(float dt);
	  void run_as_misile_obs(float dt);

	 // float waktu;
	  //int tempMphase;

	  void yakhontFirstMode(const int mPhase, const int mLockFireShipID, const int mLockFireWeaponID, const int mLockFireLauncherID, const int mLockFireMissileID, const int mLockFireMissNumberID, const float dt);
	  void yakhontSecondMode(const int mPhase, const int mLockFireShipID, const int mLockFireWeaponID, const int mLockFireLauncherID, const int mLockFireMissileID, const int mLockFireMissNumberID, const float dt);	
	  void yakhontThirdMode(const int mPhase, const int mLockFireShipID, const int mLockFireWeaponID, const int mLockFireLauncherID, const int mLockFireMissileID, const int mLockFireMissNumberID, const float dt);
      void yakhontFourthMode(const int mPhase, const int mLockFireShipID, const int mLockFireWeaponID, const int mLockFireLauncherID, const int mLockFireMissileID, const int mLockFireMissNumberID, const float dt);
	  void yakhontRelease(const int mLockFireShipID, const int mLockFireWeaponID, const int mLockFireLauncherID, const int mLockFireMissileID, const int mLockFireMissNumberID, const float dt);
	  //Nando Added
	  void set_setting_view_ship (const int set2, const int set3, const int set4, const int set5, const int set6);
	  void set_setting_view_missile ( const int set2, const int set3, const int set4, const int set5, const int set6, const int set7);

	  void fly_to_missile(const float dt);
	  void fly_to_LockSide(const float dt);
	  void fly_to_LockFiring(const float dt);
	  void run_as_child_toLockSide(const float dt);
	  void run_as_child_toLockfiring(const float dt);	

	  void run_as_ViewObject(float dt);
	  void run_as_ViewShip(float dt);
	  void run_as_ViewMissile(float dt);

	  void CalibrateHeadPitchWhenLock();

	  dtCore::Transform get_default_actor_attach (std::string actName);
	  dtCore::Transform get_default_vehicle_focus (std::string actName, dtCore::Transform vhcPos);

	  void ProcessOrderEvent(const dtGame::Message &message);
	  void processOrderAsrock(const dtGame::Message &message);
		

	  float timeToCircle;
	  bool  isReadyToCircle;
	  int	rangeCamExo;
	  float tempRot;
	  
	  //Nando Added
	  unsigned int mPlayerDefaultLock;
	  unsigned int mPlayerObjectLock;

	  unsigned int mSubMarineFocusIndex ;
	  unsigned int mShipFocusIndex ;
	  unsigned int mHeliFocusIndex ;

	  /* For Locking When Firing */
	  int LockingStepObs0;
	  int LockingStepObs1;
	  int LockingStepObs2;

	  int flagout;

	  int mLockFireShipID;
	  int mLockFireWeaponID;
	  int mLockFireLauncherID;
	  int mLockFireMissileID;
	  int mLockFireMissNumberID;

	  //for following object
	  float CameraPitch;
	  float CameraHeading;
	  float CameraRange;
	  float DesiredCameraAngle;
	
	  int fly_step;

	  float mSpeed;
	  bool  mIsPlayerRunning;

	  bool isMessageRotating ;
	  int current_state_rotation ;

	  bool isMessageMoving ;
	  int current_state_move ;

	  bool isKeyControlled;

	  //Nando Added For Profil Camera Missile

      friend class PlayerActorProxy;
      //dtAudio::Sound *mPlayerSound;

	  //dtCore::RefPtr<dtCore::Compass> mCompass;
	  dtCore::RefPtr<dtCore::Isector> mIsector;
	  dtCore::RefPtr<osgText::Text> mTextNode ;

	  dtCore::RefPtr<dtDAL::ActorProxy> attachedProxy;
	  dtCore::RefPtr<dtDAL::ActorProxy> attachedProxy2;
	  dtCore::RefPtr<dtDAL::ActorProxy> attachedProxy3;
		

	  dtCore::Transform targetTransform;
	  osg::Vec3 targetPosition,targetRotation;

};

class DID_ACTORS_EXPORT PlayerActorProxy : public dtGame::GameActorProxy
{
   public:

      PlayerActorProxy();

      virtual void BuildPropertyMap();

      virtual void BuildInvokables();

      virtual void CreateActor() { SetActor(*new PlayerActor(*this)); }
		
	  virtual void OnEnteredWorld();

	  virtual void OnRemovedFromWorld();
	  

   protected:

      /// Destructor
      virtual ~PlayerActorProxy();

   private:

};

#endif
