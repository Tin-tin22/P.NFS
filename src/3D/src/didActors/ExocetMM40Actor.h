/*
	Ecoxet MM40 
*/
#ifndef VEXOCET_ACTOR_MM40
#define VEXOCET_ACTOR_MM40

#include "export.h"
#include "MissileActor.h"

#include "../didUtils/trajectory.h"

//===============================================================
class DID_ACTORS_EXPORT ExocetMM40Actor : public MissilesActor
{
public : 
	/* Construc */
	ExocetMM40Actor(dtGame::GameActorProxy &proxy);  

	virtual void TickLocal(const dtGame::Message &tickMessage);
	virtual void TickRemote(const dtGame::Message &tickMessage);
	virtual void ProcessMessage(const dtGame::Message &message);

	/* Sync Property */
	/* Speed n Heading */
	void SetCurrentSpeed(float newVal) {CurrentSpeed = newVal;};
	float GetCurrentSpeed() {return CurrentSpeed ;};

	void SetCurrentHeading(float newVal) {CurrentHeading = newVal;};
	float GetCurrentHeading() {return CurrentHeading;};

	/* Moving */
	void SetStepMoving(int newVal) {mStepMoving = newVal;};
	int GetStepMoving() {return mStepMoving;};
	void SetStepHAFO(int newVal) {mStepHAFO = newVal;};
	int GetStepHAFO() {return mStepHAFO;};
	void SetStepCruise(int newVal) {mStepCruise = newVal;};
	int GetStepCruise() {return mStepCruise;};
	void SetStepSearching(int newVal) {mStepSearching = newVal;};
	int GetStepSearching() {return mStepSearching;};

	bool isStraight;

	int GetFirstTurn();

private :
	void CeckCollisionExocet(float pDeltaTime);

	bool FisDestroy;
	bool FisBlast;
	bool isCeckCollisionFinish;
	int sizeHits;

	/* Moving */
	void Move(double aDt);
	void MoveWithInitialAlt(double aDt);		/* Fly With High Altitude */
	void MoveWithoutInitialAlt(double aDt);		/* Fly Without High Altitude */		
	void MoveCruiseAlt(double aDt);				/* Fly to Cruise Altitude (Wait Seeker On) */
	void MoveSearchingAlt(double aDt);			/* Fly And Searching Target */
	void MoveToTarget(double aDt);				/* Move To Target */
	void MoveCheckMissingTarget(double aDt);    /* Check Target InCone or Not */
	void MoveLeftTargetMode_2(double aDt);		/* move to left of Target Mode Target 2 (Bearing only)*/
	void MoveRightTargetMode_2(double aDt);		/* move to right of Target Mode Target 2 (Bearing only)*/
	void MoveLeftTargetMode_1(double aDt);		/* move to left of Target Mode Target 1 (Bearing only)*/
	void MoveRightTargetMode_1(double aDt);		/* move to right of Target Mode Target 1 (Bearing only)*/

	/* Sync Property */
	/* Step Movin //1 For HAFO, 2 For Cruise , 3 For Searching, 4 For Angular, 5 For Agility */
	int mStepMoving;
	int mStepHAFO;			/* Step1 */
	int mStepCruise;		/* Step2 */
	int mStepSearching;		/* Step3 */

	int mModeToTarget;		/* 1: RBL, 2 : BOL, 3 : RBL-AngleRight, 4 : RBL-AngleLeft */
	int mFirstTurn;			/* 1: Turn Right, 2: Turn Left */
	int mAngularTurn;		/* 1 : angular left, 2 : angular right*/

	int flag;				/*flag to track missile position when seeker on*/
	double rateDistAngular; // untuk angular step
	double farRange, nearRange, rightAngle, leftAngle;
	float  exxocetMax;

	/* Heading n Speed */
	float CurrentHeading;
	float CurrentSpeed;

	/* For HAFO (Initial Step) */
	float FDegreeToHAFO;

	/* For Cruise */
	float FDegreeToCruise;
	float FCruise_Altitude;
	float FCruise_Range;

	/* For Searching */
	float FSearchAltitude;

	bool FisFindTarget;							/* Find Target or Not */

	/* ============================== */
	/* Receive From Socket (Setting From 2D) */
	int FShipID; 
	int	FWeaponID;
	int FLauncherID;
	int FMissileID;
	int FMissileNumber;
	int FOrderID;
	float TargetBearing;
	float TargetRange;
	int WithInitialAlt;
	int WithAgilityStep;
	int WithAngularStep;
	float FHAFO_Altitude;
	float FHAFO_Range;
	float FSeekerRange;
	float FTerminalRange;
	float leftAngleSeeker;
	float rightAngleSeeker;
	float farDistance;
	int masking_1, masking_2, masking_3, masking_4,
		masking_5, masking_6, masking_7, masking_8,
		masking_9,masking_10, masking_11, masking_12,
		masking_13, masking_14, masking_15, masking_16;
	double seekerOpenPosX;
	double seekerOpenPosY;
	float seekerOpenPosHeading;
	/* =============================== */

	/* Profile Exocet MM40 */
	/* Turn Rate */
	float TurnElev;
	float TurnAltitude;
	float TurnDirection;
	float TurnDirectionBOL;
	float TurnDirectionToTarget;
	float TurnAngularDirection;

	/* speed */
	float MAX_Speed; 
	float MIN_Speed;
	float Cruise_Speed;
	float Dive_Speed;
	float MinRange, MaxRange;

	/* Seeker Property */
	float SeekLength_Height;
	float SeekLength_Width;

	trajectory trac;
	float ExcRange;

	float GetDistance(osg::Vec3 point1, osg::Vec3 point2);
	float GetHeading(osg::Vec3 point1, osg::Vec3 point2);

	dtCore::RefPtr<dtDAL::ActorProxy> proxy;

	float NewTargetBearing;
	osg::Vec3 TargetPosition;
	osg::Vec3 SeekerOpenPos;
	osg::Vec3 SeekerOpenRot;
	osg::Vec3 SeekerOpenPosTesting;
	osg::Vec3 SeekerOpenRotTesting;

	osg::Vec3 FirstSearchingPosition;
	osg::Vec3 missileFirstPos;

	void ExocetBlast(osg::Vec3 TargetPos);
	
	dtCore::RefPtr<dtCore::ParticleSystem> missileTrail;

	bool CheckValidBearingForLauncher(const int LauncherID, float Bearing);

	void ProcessOrderEvent(const dtGame::Message &message);
	bool IsInCone(osg::Vec3 origin, osg::Vec3 pointToTest, float heading, float pitch, float distanceToTarget, float coneRadius);

	//membuat new cone untuk masking , cone = seeker range
	bool isInRBLSeekerRange(osg::Vec3 missPosSeek, osg::Vec3 targetPosSeek, osg::Vec3 missRotSeek);
	
	void SearchingTarget(double aDt);

	/* Delete EcoxetMM40 */
	void DestroyExocetMM40();

	/* First Initialize To Running */
	void InitializeExocet();

	// tes [2/13/2013 DID RKT2]
	dtCore::RefPtr<dtDAL::ActorProxy> hitTargetProxy;
	float collisionDelay;

public :
	int LockTargetID;
	dtCore::RefPtr<dtCore::DeltaDrawable> mShipTarget;
protected :
	virtual ~ExocetMM40Actor();			

	virtual void OnEnteredWorld();
	virtual void OnRemovedFromWorld();

};


//===============================================================
class DID_ACTORS_EXPORT ExocetMM40ActorProxy : public MissilesActorProxy
{
public:
	ExocetMM40ActorProxy();
	virtual void BuildPropertyMap();
	
protected:
	virtual ~ExocetMM40ActorProxy() { };
	
	virtual void OnEnteredWorld();
	virtual void OnRemovedFromWorld();
	virtual void CreateActor();
};

#endif


