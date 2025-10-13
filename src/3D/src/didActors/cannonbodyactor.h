#ifndef CANON_BODY_ACTOR
#define CANON_BODY_ACTOR

#include "didactorsheaders.h"
#include "launcherbodyactor.h"
#include "../didUtils/trajectory.h"

namespace dtAudio
{
   class Sound;
}

class DID_ACTORS_EXPORT CannonBodyActor :  public LauncherBodyActor
{
	public :
		CannonBodyActor(dtGame::GameActorProxy &proxy);
		virtual void TickLocal(const dtGame::Message &tickMessage);
		virtual void ProcessMessage(const dtGame::Message &message);
		
		virtual void SetMoveRate(float rate);
		virtual float GetMoveRate() const { return mRate;}

		void SetXTarget(float val) { xTargetPos = val;}
		float GetXTarget(){ return xTargetPos;}

		virtual void OnEnteredWorld();
        virtual void OnRemovedFromWorld();

	protected :
		virtual ~CannonBodyActor();
	private :
		
		float mRate;
		bool stopMove;
		float xTargetPos;
		
		float mMaxRotation;

		//For Tracking
		bool isTrack;
		bool isBTK;
		bool isAirShipTrack;
		int ModeTrack;
		int TargetID;
		double BearingTarget;
		double RangeTarget;
		double mAbsolutStartAngle;
		double mAbsolutEndAngle;
		float mCorrElev;
		float mCorrBearing;
		float mCounterRot;
		int BalistikMode;
		bool isValid;

		trajectory trac;

		//Target
		dtCore::Transform TargetTransform;
		osg::Vec3 TargetPosition;
		osg::Vec3 TargetRotation;
		//OwnShip
		dtCore::Transform ShipTransform;
		osg::Vec3 ShipPosition;
		osg::Vec3 ShipRotation;

		void CannonRotation();
		void ProcessOrderEvent(const dtGame::Message &message);

		void ValidateRotation();
		void ValidateRotationForBTK();
		void ValidateRotationForAirTrack();
		void CannonBodyRotation();
		void CannonBodyRotationForBTK();
		void CannonBodyRotationForAirTrack();


};

class DID_ACTORS_EXPORT CannonBodyActorProxy : public LauncherBodyActorProxy
{
	public :
		CannonBodyActorProxy();
		virtual void BuildPropertyMap();
		virtual void BuildInvokables();
		virtual void CreateActor() { SetActor(*new CannonBodyActor(*this));} 
	protected:
		virtual ~CannonBodyActorProxy();
		virtual void OnEnteredWorld();
	private:
};

#endif