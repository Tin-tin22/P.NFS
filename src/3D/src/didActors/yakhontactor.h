#ifndef VYAKHONT_ACTOR
#define VYAKHONT_ACTOR
 
#include "didactorsheaders.h"
#include "missileactor.h"
#include "../didUtils/trajectory.h"

class DID_ACTORS_EXPORT YakhontMissileActor : public MissilesActor
{
	public:
		//static const std::string EVENT_HANDLER_NAME;

		YakhontMissileActor(dtGame::GameActorProxy &proxy);    
		
		virtual void TickLocal(const dtGame::Message &tickMessage);
		virtual void TickRemote(const dtGame::Message &tickMessage);
		virtual void ProcessMessage(const dtGame::Message &message);

		int  	mPhase;             ///< The phase of the missile. Taken from ePhaseEnum.
		int		mMissileTrack;		///< The kind of Missile Flight trajectories
		//bool	releaseOn;			/// penanda release untuk kamera

		void 	SetCurrentSpeed(float newVal){CurrentSpeed = newVal;};
		float	GetCurrentSpeed() {return CurrentSpeed ;};
		void 	SetCurrentHeading(float newVal) {CurrentHeading = newVal;};
		float	GetCurrentHeading() {return CurrentHeading ;}

		dtCore::RefPtr<dtCore::DeltaDrawable> mShipTarget;

	protected:
		virtual ~YakhontMissileActor();

		virtual void OnEnteredWorld();
		virtual void OnRemovedFromWorld();

	private:
		//Constants
		static const float EFECTIVE_RANGE;					// Max range (meter)
		static const float MAX_SPEED;						// Max speed (mach)
		static const float HEIGHT_LOW_TRAJECTORY;			// Low height before dip
		static const float HEIGHT_HIGH_TRAJECTORY;			// High height before dip

		bool 	mSmokeStatus ;
		bool 	isFirst;
		bool	isFind;
		bool	afterBlast;
		bool	firstSeeker;
		bool	isFire;

		float 	ExcRange;
		float	Direction2D;
		float	Range2D;
		float 	CurrentSpeed;
		float 	CurrentHeading;
		float	DistanceToTarget, jarakTarget;

		enum ePhaseEnum 
		{
			PHASE_NONE = 0
			, PHASE_1
			, PHASE_2
			, PHASE_3
			, PHASE_4
			, PHASE_5
			, PHASE_6 
			, PHASE_7
			, PHASE_8
			, PHASE_9
			, PHASE_10
		};

		enum missileTrack
		{
			B = 0
			, B1	// low trajectory
			, B1n	// low tarjectory with popup
			, B2	// high trajectory
			, B2n	// high trajectory with popup
		};

		//int  	mPhase;             ///< The phase of the missile. Taken from ePhaseEnum.
		//int		mMissileTrack;		///< The kind of Missile Flight trajectories
		int		mState;

		trajectory trac;
		dtCore::RefPtr<dtCore::ParticleSystem> mSmoke;

		//for moving
		dtCore::Transform missileTransform;
		osg::Vec3 missilePosition, missileRotation, missileFirstPos, track;
		osg::Vec3 objectPosition,tempObjectPosition;

		

		dtCore::Transform objectTransform;
		osg::Vec3 objectRotation;
		float nbearing, npitch;

		void 	ProcessOrderEvent(const dtGame::Message &message);
		void 	Move(double aDt);
		void 	MoveRelease(double aDt);
		void	SetFirstTrack();
		void 	YakhontBlast(osg::Vec3 TargetPos);
		void 	SearchingTarget();
		void	Climb_Up(float rateElev, float maxElev, int phase);
		void	Climb_Down(float rateElev, float maxElev, int phase);
		void	Move_B1();
		void	Move_B1n();
		void	Move_B2();
		void	Move_B2n();
		void	Move_B1_new();
		void	GetCurrentLocation();
		void	SetCurrentLocation(double deltaSimTime);
		void	CeckCollisionYakhont(float pDeltaTime);
};

class DID_ACTORS_EXPORT YakhontMissileActorProxy : public MissilesActorProxy
{
	public:
		  YakhontMissileActorProxy();
		  virtual void BuildPropertyMap();
	      
	protected:
		  virtual ~YakhontMissileActorProxy() { };
		  virtual void CreateActor();
		  virtual void OnEnteredWorld();
};

#endif
