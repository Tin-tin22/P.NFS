#ifndef VEXOCET_ACTOR
#define VEXOCET_ACTOR
 
#include "didactorsheaders.h"
#include "missileactor.h"


#include "../didUtils/trajectory.h"

class DID_ACTORS_EXPORT ExocetActor : public MissilesActor
{
	public:
		//static const std::string EVENT_HANDLER_NAME;

		ExocetActor(dtGame::GameActorProxy &proxy);    
		
		virtual void TickLocal(const dtGame::Message &tickMessage);
		virtual void TickRemote(const dtGame::Message &tickMessage);
		virtual void ProcessMessage(const dtGame::Message &message);

		//********** ngambil dari form 2D **********
		void SetProximityFuze(int pf);
		int GetProximityFuze(){ return mPF;} 

		void SetAltitude(int alt);
		float GetAltitude() { return mAlt;} 

		void SetSearchArea(int sa);
		int GetSearchArea(){ return mSA;}

		void SetTargetBearing(float bearing);
		float GetTargetBearing(){ return mBearing;}

		void SetTargetRange(float targetRange); // target range dalam NauticalMiles (dikonversi ke meter)
		float GetTargetRange(){ return mTargetRange;}

		void SetRangeToGo(int rtg);
		float GetRangeToGo(){ return mRTG;}

		void SetManualWidth(int mw);
		int GetManualWidth(){ return mMW;}

		void SetSelectionDepth(int sd);
		int GetSelectionDepth(){ return mSD;}

		void SetSoundEngine(bool val);
		bool GetSoundEngine() {return isSoundEngineEnabled;};


		void SetCurrentSpeed(float newVal);// {CurrentSpeed = newVal;};
		float GetCurrentSpeed() {return CurrentSpeed ;};


		void SetCurrentHeading(float newVal) {CurrentHeading = newVal;};
		float GetCurrentHeading() {return CurrentHeading ;};

		void SetTargetFired(bool newVal) {TargetFired = newVal;};
		bool GetTargetFired() {return TargetFired;};

		void SetMBlast(bool newVal) {mBlast = newVal;};
		bool GetMBlast() {return mBlast;};

		void SetAfterBlast(bool newVal) {afterBlast = newVal;};
		bool GetAfterBlast() {return afterBlast;};

		void SetFlat(bool newVal) {flat = newVal;};
		bool GetFlat() {return flat;};

		void SetElevation(float newVal) {elevation = newVal;};
		float GetElevation() {return elevation ;};

		void SetTempTime(float newVal) {tempTime = newVal;};
		float GetTempTime() {return tempTime ;};

		void SetExcRange(float newVal) {ExcRange = newVal;};
		float GetExcRange() {return ExcRange ;};

		void SetTimeDel(float newVal) {timeDel = newVal;};
		float GetTimeDel() {return timeDel ;};

		void SettRange(float newVal) {tRange = newVal;};
		float GettRange() {return tRange ;};

		void SetShipHeading(float newVal) {shipHeading = newVal;};
		float GetShipHeading() {return shipHeading ;};

		void SetSmokeStatus(bool newVal) {mSmokeStatus = newVal;};
		bool GetSmokeStatus() {return mSmokeStatus;};

		void SetHasTarget(bool val) {findTarget = val;};
		bool GetHasTarget() {return findTarget;};

		void SetCurrentTargetId(const dtCore::UniqueId& id) { mCurrentTargetId = id; }
		const dtCore::UniqueId& GetCurrentTargetId() const { return mCurrentTargetId; }

		void CSetRotation(const osg::Vec3& v3);
		osg::Vec3 CGetRotation();
		void CSetTranslation(const osg::Vec3& v3);
		osg::Vec3 CGetTranslation();

	protected:
		float mTimeToBlow;
		virtual ~ExocetActor();

		virtual void OnEnteredWorld();
		virtual void OnRemovedFromWorld();

	private:  

		bool TargetFired;
		bool mBlast;
		bool afterBlast;
		bool flat;
		bool mSmokeStatus ;
		bool isFirst;

		float elevation;
		float tempTime;	 
		float ExcRange;
		float timeDel;
		float tRange;
		float shipHeading;
		float CurrentSpeed;
		float CurrentHeading;

		float e_bearing;

		trajectory trac;

		// ***** 2D *********
		int mPF;
		float mBearing,mTargetRange;
		float mAlt,mSA,mRTG,mMW,mSD;
		bool isSoundEngineEnabled;

		dtCore::UniqueId mNoTargetId;
		dtCore::UniqueId myID;

		std::string	mModelFile;
		dtCore::RefPtr<dtCore::ParticleSystem> mSmoke;

		std::queue<dtAudio::Sound*> mQueued;
		dtAudio::Sound* engineSound;

		dtCore::Transform mTrans;
		osg::Vec3 targetPos;

		void ProcessOrderEvent(const dtGame::Message &message);
		float GetDistance(osg::Vec3 point1, osg::Vec3 point2);
		void Move(double aDt);
		float SelBearing(float b1, float b2);

		void Step1();
		void Step2();
		void EndOfExocet();
		void ExcBlast(dtDAL::ActorProxy* p);
		void SetSoundEngineFile(const char* fname);


		dtCore::Transform trans;
		osg::Vec3 exoPos, dir, rot, missileFirstPos;
		float turnElevation,turnElevation2,turnRate1,turnRate2;
		bool stop;
		float temp_bearing;

		dtCore::UniqueId mCurrentTargetId;
		bool findTarget;

};


class DID_ACTORS_EXPORT ExocetActorProxy : public MissilesActorProxy
{
	public:
		  ExocetActorProxy();
		  virtual void BuildPropertyMap();
	      
	protected:
		  virtual ~ExocetActorProxy() { };
		  virtual void CreateActor();
		  virtual void OnEnteredWorld();
};

#endif
