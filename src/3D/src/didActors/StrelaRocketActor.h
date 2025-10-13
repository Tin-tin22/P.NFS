#include "didactorsheaders.h"
#include "missileactor.h"

#include "../didUtils/trajectory.h"

class DID_ACTORS_EXPORT StrelaRocketActor : public MissilesActor
{
	public:

		StrelaRocketActor(dtGame::GameActorProxy &proxy);    
		virtual void TickLocal(const dtGame::Message &tickMessage);
		virtual void TickRemote(const dtGame::Message &tickMessage);
		virtual void ProcessMessage(const dtGame::Message &message);

		//********** ngambil dari form 2D **********
		void 	SetTargetBearing(float bearing);
		float	GetTargetBearing(){ return mBearing;}

		void 	SetTargetRange(float targetRange); // target range dalam NauticalMiles (dikonversi ke meter)
		float	GetTargetRange(){ return mTargetRange;}

		void 	SetTargetElev(float elev); // target range dalam NauticalMiles (dikonversi ke meter)
		float	GetTargetElev(){ return mElev;}

		void 	SetCurrentSpeed(float newVal) {CurrentSpeed = newVal;};
		float	GetCurrentSpeed() {return CurrentSpeed ;};

		void 	SetCurrentHeading(float newVal) {CurrentHeading = newVal;};
		float	GetCurrentHeading() {return CurrentHeading ;};

		virtual void OnEnteredWorld();
		virtual void OnRemovedFromWorld();

		void 	SetIsUnlockToFire(int val);
		int		GetIsUnlockToFire(){ return isUnlockToFire;}

   protected:
	    virtual ~StrelaRocketActor() ;

   private:
	   //Constants
	   static const float MAX_RANGE;
	   static const float MAX_PITCH;
	   static const float MIN_PITCH;

		bool 	mSmokeStatus;
		bool	isFind;
		bool	isSeekerFind;

		int		isUnlockToFire;

		float	CurrentSpeed;
		float	CurrentHeading;
		float	ExcRange;
		float	mBearing,mTargetRange,mElev;
		float	jarakHelicopter, jarakTarget;
		float   lifeTime;

		trajectory trac;

		dtCore::RefPtr<dtDAL::ActorProxy> hitTargetProxy;
		dtCore::RefPtr<dtCore::ParticleSystem> mSmoke;
		dtCore::Transform missileTransform;
		osg::Vec3 missilePosition,missileRotation,missileFirstPos;

		dtCore::RefPtr<dtCore::DeltaDrawable> mShipTarget;
		dtCore::RefPtr<dtDAL::ActorProxy> OwnShipProxy;

		dtCore::RefPtr<dtAudio::Sound> seekerSound;

		float nbearing, npitch;
		dtCore::Transform objectTransform;
		osg::Vec3 objectPosition;
		osg::Vec3 objectRotation;
		bool isFirst;

		void 	SetTrac();
		void 	ProcessOrderEvent(const dtGame::Message &message);
		void 	Move(double aDt);
		void 	EndOfStrela();
		void 	Blast(osg::Vec3 TargetPos);
		void 	SearchingTarget();
		void	CeckCollisionRocket();

		//nando added
		void	MovetoTarget(double aDt);
		void	MoveCheckMissingTarget();		
};


class DID_ACTORS_EXPORT StrelaRocketActorProxy : public MissilesActorProxy
{
   public:
		StrelaRocketActorProxy();
        virtual void BuildPropertyMap();
      
   protected:
		virtual ~StrelaRocketActorProxy() { };
		virtual void CreateActor();
		virtual void OnEnteredWorld();
};

