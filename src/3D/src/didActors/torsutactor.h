#ifndef VTORPEDOSUT_ACTOR
#define VTORPEDOSUT_ACTOR

#include "didactorsheaders.h"
#include "missileactor.h"
#include "../didUtils/trajectory.h"

class DID_ACTORS_EXPORT TorSutActor : 
	public MissilesActor
{
	public:

	TorSutActor(dtGame::GameActorProxy &proxy);    
	virtual void TickLocal(const dtGame::Message &tickMessage);
	virtual void TickRemote(const dtGame::Message &tickMessage);
	virtual void ProcessMessage(const dtGame::Message &message);

	void 	CSetTorpedoSpeed(float newVal) {mSpeed = newVal;};
	float	CGetTorpedoSpeed() {return mSpeed ;};

	void 	CSetTorpedoCourse(float course){mCourse = course;};
	float	CGetTorpedoCourse(){ return mCourse;}

	void 	CSetTorpedoDepth(float depth);
	float	CGetTorpedoDepth(){ return mDepth;}

	void 	SetSafeDistance(float newVal) {safeDistance = newVal;};
	float	GetSafeDistance() {return safeDistance ;};
	
	void 	SetCurrentSpeed(float newVal) {CurrentSpeed = newVal;};
	float	GetCurrentSpeed() {return CurrentSpeed ;};

	void 	SetCurrentHeading(float newVal) {CurrentHeading = newVal;};
	float	GetCurrentHeading() {return CurrentHeading ;};

	void 	SetEnDis(float newVal) {EnDis = newVal;};
	float	GetEnDis() {return EnDis ;};

	void 	SetTgtID(int newVal) {tgtID = newVal;};
	int	GetTgtID() {return tgtID ;};

	int TargetID, TargetIDFromCone;

  protected:
    virtual ~TorSutActor() ;
	virtual void OnEnteredWorld();
    virtual void OnRemovedFromWorld();

  private:
	int 	orderID, tgtID;
	bool	isFind;
	bool	isHandleSpeed, isHandleCourse, isHandleDepth;
	bool	isCircle, isStopCircle;
	bool	isFirst;
	bool	isFirstGetDir;

	float tSpeed,tCourse,tBearing ,tRange;
	float hRange,hBearing,hTime;
	int tvid;

    float 	TorpRange;
	float 	existTime;
	float 	mCourse,mDepth,mSpeed;;
	float 	CurrentHeading;
	float 	CurrentSpeed;
	float 	safeDistance, EnDis;
	float 	timeToGoISC;
	float 	firstDirection;
	float 	lastDirection;
	float 	nbearing,npitch;
	float 	getDir,getPitch;
	float 	jarakTarget;
	float 	jarakSubmarine;
	float	range2d;
	bool	isTurnArround;

	int 	PredictionMode;
	int 	count;
		
	//getting shipTarget
	dtCore::Transform objectTransform,objectTransform2;
	dtCore::Transform missileTransform;
	dtCore::Transform targetTransform;
	osg::Vec3 objectPosition,objectPosition2;
	osg::Vec3 objectRotation,objectRotation2;
	osg::Vec3 missilePosition;
	osg::Vec3 missileRotation;
	osg::Vec3 targetPosition;
	osg::Vec3 targetRotation;
	osg::Vec3 missileFirstPos;
	osg::Vec3 aFirstPos;
	osg::Vec3 dir ;
  
	trajectory trac;

	void	CeckCollisionSUT();
	void 	SearchingTarget(); //  [2/17/2012 DID RKT2]
	void	CheckUpdateSpeedDepth(); //  [6/4/2013 DID RKT2]
	void	CheckUpdateCourse(); //  [6/4/2013 DID RKT2]
	void 	Move(double aDt);
    void 	InitRun();
    void 	EndOfTorpedo();
	void	TorpBlast(osg::Vec3 TargetPos);
    void	ProcessOrderEvent(const dtGame::Message &message);
    void 	CalcHitPredition (const float tRange, const float tBearing,  const float tSpeed, 
		const float tCourse, const float  pSpeed, float &hRange, float &hBearing, float &hTime );

	dtCore::RefPtr<dtCore::DeltaDrawable> mShipTarget;
	dtCore::RefPtr<dtCore::DeltaDrawable> actorTarget;
	dtCore::RefPtr<dtDAL::ActorProxy> proxy;
	dtCore::RefPtr<dtDAL::ActorProxy> OwnShipProxy;
	dtCore::RefPtr<dtDAL::ActorProxy> targetProxy;
	dtCore::RefPtr<dtDAL::ActorProxy> targetConeProxy;

	std::vector<dtGame::GameActorProxy*> vActors;
	std::vector<dtGame::GameActorProxy*>::iterator iter;
	dtCore::Transformable* actor;
	dtCore::RefPtr<dtCore::DeltaDrawable> TempTarget;

	static const float CABLE_LENGTH;

	enum PredicMode
	{
		None = 0
		, InterceptMode
		, BearingMode
		, ManualMode
		, TargetSearchProgram
		, Homing
	};
    
};


class DID_ACTORS_EXPORT TorSutActorProxy : public MissilesActorProxy
{
   public:
      virtual void BuildPropertyMap();
      virtual void CreateActor() { SetActor(*new TorSutActor(*this));}
	  TorSutActorProxy();
   protected:
      virtual ~TorSutActorProxy() { };
      virtual void OnEnteredWorld();
};

#endif
