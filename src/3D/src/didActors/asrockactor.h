//$Id: asrocactor.h

/**
* @file asrocactor.h
* @brief The source file for asroc actor.
*/

/*
 *	@brief jhjkgjgjhgjhgjg
 */

#include "didactorsheaders.h"
#include "missileactor.h"

#include "../didUtils/trajectory.h"

class DID_ACTORS_EXPORT AsrockActor : public MissilesActor
{
	public:

		AsrockActor(dtGame::GameActorProxy &proxy);    
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
	 
		void 	SetafterBlast(bool newVal) {afterBlast = newVal;};
		bool 	GetafterBlast() {return afterBlast;};

		void 	SetisBlast(bool newVal) {isBlast = newVal;};
		bool 	GetisBlast() {return isBlast;};

		void 	SetRange(float newVal) {mRange = newVal;};
		float	GetRange() {return mRange ;};

		void 	SetExcRange(float newVal) {ExcRange = newVal;};
		float	GetExcRange() {return ExcRange ;};

		void 	SetElev(double newVal) {elev = newVal;};
		double  GetElev() {return elev ;};

		void 	SetDepth(float newVal) {mDepth = newVal;};
		float	GetDepth() {return mDepth ;};

		void 	SetFuze(int newVal) {mFuze = newVal;};
		int		GetFuze() {return mFuze ;};

		virtual void OnEnteredWorld();
		virtual void OnRemovedFromWorld();

		int		TargetID;

   protected:
	    virtual ~AsrockActor() ;

   private:
	   enum TypeOfAsroc
	   {
		   B = 0
		   , ErrikaLow	// low trajectory
		   , ErrikaHigh	// low tarjectory with popup
		   , NellyLow	// high trajectory
		   , NellyHigh	// high trajectory with popup
		   , Errika
		   , Nelly
	   };

		int 	mFuze, TipeLoading, TipeFire, TipeID;
		bool 	isBlast;
		bool 	afterBlast;
		bool	phase1, phase2, phase3;

		float 	CurrentSpeed;
		float 	CurrentHeading;
		float 	mDepth;	 
		float 	mRange;
		float 	tRange;
		float 	ExcRange;
		float 	mBearing,mTargetRange,mSpeed;
		float 	shipHeading;
		float	CorrectRange2D;
		
		double 	elev;	
		double	correctRange;
		double timeAsroc,t,TimeForPlayer;

		//  [7/11/2012 DID RKT2]
		dtCore::Transform SpoutTransform;
		float Heading ,Pitch ,Roll;

		enum TypeOfAsroc2
		{
			B2 = 0
			, ErrikaLow2	// low trajectory
			, ErrikaHigh2	// low tarjectory with popup
			, NellyLow2	// high trajectory
			, NellyHigh2	// high trajectory with popup
			, Errika2
			, Nelly2
		};

		trajectory trac;

		dtCore::RefPtr<dtCore::ParticleSystem> missileTrail;

		dtCore::Transform missileTransform;
		osg::Vec3 missilePosition,missileRotation,missileFirstPos;
		osg::Vec3 dir;
		bool isFirst, isFirstInPhase2;

		void ProcessOrderEvent(const dtGame::Message &message);
		void Move(double aDt);
		void TrajectoryInitialization();
		void EndOfAsrock();
		void ExcBlast();

};


class DID_ACTORS_EXPORT AsrockActorProxy : public MissilesActorProxy
{
   public:
		AsrockActorProxy();
        virtual void BuildPropertyMap();
      
   protected:
		virtual ~AsrockActorProxy() { };
		virtual void CreateActor();
		virtual void OnEnteredWorld();
};

