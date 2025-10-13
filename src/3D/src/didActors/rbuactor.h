#include "didactorsheaders.h"
#include "missileactor.h"

#include "../didUtils/trajectory.h"

class DID_ACTORS_EXPORT RBUActor : 
	public MissilesActor
{
	public:

		RBUActor(dtGame::GameActorProxy &proxy);    
		virtual void TickLocal(const dtGame::Message &tickMessage);
		virtual void TickRemote(const dtGame::Message &tickMessage);
		virtual void ProcessMessage(const dtGame::Message &message);
		
		//********** ngambil dari form 2D **********
		void 	SetTargetBearing(float bearing);
		float	GetTargetBearing(){ return mBearing;}

		void 	SetTargetRange(float targetRange); // target range dalam NauticalMiles (dikonversi ke meter)
		float	GetTargetRange(){ return mTargetRange;}

		void 	SetCurrentSpeed(float newVal) {CurrentSpeed = newVal;};
		float	GetCurrentSpeed() {return CurrentSpeed ;};
		
		void 	SetCurrentHeading(float newVal) {CurrentHeading = newVal;};
		float	GetCurrentHeading() {return CurrentHeading ;};

		void 	SetDepth(float newVal) {mDepth = newVal;};
		float	GetDepth() {return mDepth ;};

		int		TargetID;
	 
   protected:		
    virtual ~RBUActor() ;

   private:

	    virtual void OnEnteredWorld();
	    virtual void OnRemovedFromWorld();

		float 	CurrentSpeed;
		float 	CurrentHeading; 
		float	mDepth;
		float 	mRange;
		float 	ExcRange;
		float 	mBearing,mTargetRange;

		bool 	isBlast;
		bool 	afterBlast;
		bool 	mSmokeStatus;
		bool	first;
		
		double 	elev ;	
		double timeAsroc,t;
		
		trajectory trac;

		dtCore::Transform missileTransform;
		osg::Vec3 missilePosition,missileRotation,missileFirstPos;
		osg::Vec3 dir;
		bool isFirst;

		osg::Vec3 tempPoint, tempPoint2;
		float selisih;

		dtCore::RefPtr<dtCore::ParticleSystem> mSmoke;

		void ProcessOrderEvent(const dtGame::Message &message);
		void Move(double aDt);
		void TrajectoryInitialization();
		void EndOfRBU();
		void ExcBlast();
};

class DID_ACTORS_EXPORT RBUActorProxy : public MissilesActorProxy
{
   public:
		RBUActorProxy();
        virtual void BuildPropertyMap();
      
   protected:
		virtual ~RBUActorProxy() { };
		virtual void CreateActor();
		virtual void OnEnteredWorld();
};