#ifndef VC802_ACTOR
#define VC802_ACTOR
 
#include "didactorsheaders.h"
#include "missileactor.h"
#include "../didUtils/trajectory.h"

class DID_ACTORS_EXPORT C802MissileActor : public MissilesActor
{
	public:
		C802MissileActor(dtGame::GameActorProxy &proxy);    
		
		virtual void TickLocal(const dtGame::Message &tickMessage);
		virtual void TickRemote(const dtGame::Message &tickMessage);
		virtual void ProcessMessage(const dtGame::Message &message);

		void 	SetCurrentSpeed(float newVal){CurrentSpeed = newVal;};
		float	GetCurrentSpeed() {return CurrentSpeed ;};
		void 	SetCurrentHeading(float newVal) {CurrentHeading = newVal;};
		float	GetCurrentHeading() {return CurrentHeading ;};

		dtCore::RefPtr<dtCore::DeltaDrawable> mShipTarget;

	protected:
		virtual ~C802MissileActor();

		virtual void OnEnteredWorld();
		virtual void OnRemovedFromWorld();

		void OnPhaseBoost();

	private:
		//Constants
		static const int GATE_NEAR;                              // Near Gate setting. 10km <= R <= 15km.
		static const int GATE_FAR1;                              // Far 1 Gate setting. 15km < R <= 25km. 
		static const int GATE_FAR2;                              // Far 2 Gate setting. R > 25km. Default. If gate > Far1 Gate, then gate = Far gate.
		static const float K0_TIME;       
		static const float K1_TIME;
		static const float K2_TIME;
		static const float SELF_CONTROL_FLIGHT_TIME_MIN;    // Minimum mSelfControlFlightTime (K3_TIME). K5 = K3 + 2.5s
		static const float SELF_CONTROL_FLIGHT_TIME_MAX;    // Maximum mSelfControlFlightTime (K3_TIME). K5 = K3 + 2.5s
		static const float ALTITUDE_MAX;                    // Maximum altitude of the missile at HALF phase (+- 130-140 meters)
		static const float ALTITUDE_G;                      // The altitude to send G command (dive to cruise altitude)
		static const float ALTITUDE_CRUISE_START;           // The altitude to start Level Flight Phase (E-F). 49 meters so the missile can pitch to 0 degree at ALTITUDE_CRUISE_LEVEL, hopefully.
		static const float ALTITUDE_CRUISE_LEVEL;           // Cruise altitude at Level Flight Phase (E-F). 
		static const float DISTANCE_CLIMB_PHASE;            // Distance from ship before detaching booster (+- 500 meters)
		static const float HIGH_SEA_STATE_ALT;              // Diving altitude if the sea state is high (>=4)
		static const float LOW_SEA_STATE_ALT;               // Diving altitude if the sea state is low (<4)
		static const float DIVING_COMMAND_RANGE;            // Max range to locked target to send the diving command in Diving Phase
		static const float EFECTIVE_RANGE;					// Max range (meter)
		static const float MAX_SPEED;						// Max speed (mach)

		enum ePhaseEnum 
		{
			PHASE_NONE = 0
			, PHASE_BOOST           //A-B
			, PHASE_CLIMB           //B-C
			, PHASE_HALF            //C-D. High Altitude Level Flight Phase.
			, PHASE_GLIDING         //D-E
			, PHASE_LEVEL_FLIGHT    //E-F
			, PHASE_SAD             //F-G-H. Secondary Altitude Descending Phase.
			, PHASE_DIVING          //H-I        
		};

		int  	mPhase;             ///< The phase of the missile. Taken from ePhaseEnum.
		int 	idLauncher;

		bool 	mSmokeStatus ;
		bool 	isFirst;
		bool	isFind;
		bool	firstSeeker;
		bool	isFire;
 
		float 	firstDirection;
		float 	ExcRange;
		float 	CurrentSpeed;
		float 	CurrentHeading;
		float	DistanceToTarget, jarakTarget;
		float	Direction2D, Range2D, SeekerOn;
		float	NewTargetBearing;

		trajectory trac;
		dtCore::RefPtr<dtCore::ParticleSystem> mSmoke;

		//for moving
		dtCore::Transform missileTransform;
		osg::Vec3 missilePosition, missileRotation, missileFirstPos, track;
		osg::Vec3 TargetPosition;

		dtCore::Transform objectTransform;
		osg::Vec3 objectPosition,tempObjectPosition;
		osg::Vec3 objectRotation;
		float nbearing, npitch;

		void 	ProcessOrderEvent(const dtGame::Message &message);
		void 	Move(double aDt);
		void	C802Blast(osg::Vec3 TargetPos);
		void 	SearchingTarget();
		void	CeckCollisionC802(float pDeltaTime);
};


class DID_ACTORS_EXPORT C802MissileActorProxy : public MissilesActorProxy
{
	public:
		  C802MissileActorProxy();
		  virtual void BuildPropertyMap();
	      
	protected:
		  virtual ~C802MissileActorProxy() { };
		  virtual void CreateActor();
		  virtual void OnEnteredWorld();
};

#endif
