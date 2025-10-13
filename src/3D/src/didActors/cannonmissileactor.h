#ifndef VCANNON_ACTOR
#define VCANNON_ACTOR

#include "didactorsheaders.h"
#include "missileactor.h"
#include "../didUtils/trajectory.h"


class DID_ACTORS_EXPORT CannonMissileActor : public MissilesActor
{
  public:
		CannonMissileActor(dtGame::GameActorProxy &proxy);    

		virtual void TickLocal(const dtGame::Message &tickMessage);
		virtual void TickRemote(const dtGame::Message &tickMessage);
		virtual void ProcessMessage(const dtGame::Message &message);

		//Moving
		void Move(double aDt);

		void SetCurrentSpeed(float newVal) {CurrentSpeed = newVal;};
		float GetCurrentSpeed() {return CurrentSpeed ;};

		void SetCurrentHeading(float newVal) {CurrentHeading = newVal;};
		float GetCurrentHeading() {return CurrentHeading ;};
  protected:
		virtual ~CannonMissileActor() ;
		virtual void OnEnteredWorld();
		virtual void OnRemovedFromWorld();
  private:
		osg::Vec3 FirstLaunchPoint;
		double LifeTime;

		float CurrentHeading;
		float CurrentSpeed;

		float TargetBearing;
		float TargetRange;
		float LauncherElev;
		int BalistikMode;

		int ModeID;
		int TargetID;

		bool isValid;
		bool FisBlast;
		trajectory trac;

		dtCore::Transform ParentTransform;
		osg::Vec3 ParentPositon;

		osg::Vec3 dir;

		/* Parameter For Cannon */
		/* Save In Actor For Calculate */
		/* Cannon 40, 57, 120 */ /* --> Mr Reza Calc */
		double V0X;
		double V0Y;

		/* Cannon 76Low, 76High */ /* --> Mr Andi P Calc */
		double Gun_76_Time;
		double Gun_76_TimeMax;
		double Gun_76_HeightMax;
		double Gun_76_RangeMax; 

		dtCore::RefPtr<dtCore::ParticleSystem> mSmoke;
		void ProcessOrderEvent(const dtGame::Message &message);
		void CannonBlast(dtDAL::ActorProxy* p);
		void DestroyCannonMissile();
		void Initialize();
		void CheckMissileUnderWater();
};


class DID_ACTORS_EXPORT CannonMissileActorProxy : public MissilesActorProxy
{
   public:
	  CannonMissileActorProxy();	

      virtual void BuildPropertyMap();
      virtual void CreateActor() { SetActor(*new CannonMissileActor(*this));}
   protected:
      virtual ~CannonMissileActorProxy() { };
      virtual void OnEnteredWorld();
};

#endif
