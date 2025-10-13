#include "didactorsheaders.h"
#include "missileactor.h"

#include "../didUtils/trajectory.h"

class DID_ACTORS_EXPORT TetralRocketActor : public MissilesActor
{
	public:

		TetralRocketActor(dtGame::GameActorProxy &proxy);    
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

   protected:
	    virtual ~TetralRocketActor() ;

   private:
	   //Constants
	   static const float MAX_RANGE;
	   static const float MAX_PITCH;
	   static const float MIN_PITCH;

		bool 	mSmokeStatus;
		bool	isFind;
		float	CurrentSpeed;
		float	CurrentHeading;
		float	ExcRange;
		float	mBearing,mTargetRange,mElev;
		float	jarakHelicopter, jarakTarget;
		float   lifeTime;

		trajectory trac;

		dtCore::RefPtr<dtCore::ParticleSystem> mSmoke;
		dtCore::Transform missileTransform;
		osg::Vec3 missilePosition,missileRotation,missileFirstPos;

		float nbearing, npitch;
		dtCore::Transform objectTransform;
		osg::Vec3 objectPosition;
		osg::Vec3 objectRotation;
		bool isFirst;
		dtCore::RefPtr<dtCore::DeltaDrawable> mShipTarget;
		dtCore::RefPtr<dtDAL::ActorProxy> OwnShipProxy;

		void 	SetTrac();
		void 	ProcessOrderEvent(const dtGame::Message &message);
		void 	Move(double aDt);
		void 	EndOfTetral();
		void 	Blast(osg::Vec3 TargetPos);
		void 	SearchingTarget();
		void	CeckCollisionRocket();

		//nando added
		void	MovetoTarget(double aDt);
		void	MoveCheckMissingTarget();		
};


class DID_ACTORS_EXPORT TetralRocketActorProxy : public MissilesActorProxy
{
   public:
		TetralRocketActorProxy();
        virtual void BuildPropertyMap();
      
   protected:
		virtual ~TetralRocketActorProxy() { };
		virtual void CreateActor();
		virtual void OnEnteredWorld();
};

