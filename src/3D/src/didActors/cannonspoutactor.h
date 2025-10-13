#ifndef CANON_SPOUT_ACTOR
#define CANON_SPOUT_ACTOR

#include "didactorsheaders.h"
#include "launcherspoutactor.h"
#include "../didUtils/trajectory.h"

namespace dtAudio
{
	class Listener;
	class Sound;
}


class DID_ACTORS_EXPORT CannonSpoutActor : public LauncherSpoutActor
{
	public :
		CannonSpoutActor(dtGame::GameActorProxy &proxy);
		virtual void TickLocal(const dtGame::Message &tickMessage);
		virtual void TickRemote(const dtGame::Message &tickMessage);
		virtual void SetMoveRate(float rate);
		virtual float GetMoveRate() const { return mRate;}
		virtual void ProcessMessage(const dtGame::Message &message);

		virtual void OnEnteredWorld();
        virtual void OnRemovedFromWorld();

		void 	SetIsUnlockToFire(bool val);
		bool	GetIsUnlockToFire(){ return isUnlockToFire;}

	protected :
		virtual ~CannonSpoutActor();
	private :
		
		/* For Tracking */
		bool isTrack;
		bool isBTK;
		bool isAirShipTrack;
		int ModeTrack;
		int TargetID;
		double BearingTarget;
		double RangeTarget;
		double LauncherElev;
		double mAbsolutStartAngle;
		double mAbsolutEndAngle;
		float mCorrElev;
		float mCorrBearing;
		float mCounterRot;
		int BalistikMode;
		bool isValid;
		bool isUnlockToFire;

		/* Target */
		dtCore::Transform TargetTransform;
		osg::Vec3 TargetPosition;
		osg::Vec3 TargetRotation;

		/* OwnShip */
		dtCore::Transform ShipTransform;
		osg::Vec3 ShipPosition;
		osg::Vec3 ShipRotation;

		trajectory trac;

		void SpoutMovement();

		float mRate;
		bool stopMove, stopMove2;

		void ProcessOrderEvent(const dtGame::Message &message);

		void ValidateElevation();
		void ValidateElevationForBTK();
		void ValidateElevationForAirTrack();
		void CannonSpoutElevation();
		void CannonSpoutElevationForBTK();
		void CannonSpoutElevationForAirTrack();

		void SendExplode(const int ExplodeID, const int ExplodeType, const float ExplodeLife, const osg::Vec3 pos);		
};

class DID_ACTORS_EXPORT CannonSpoutActorProxy : public LauncherSpoutActorProxy
{
	public :
		CannonSpoutActorProxy();
		virtual void BuildPropertyMap();
		virtual void BuildInvokables();
		virtual void CreateActor() { SetActor(*new CannonSpoutActor(*this));}
	protected:
		virtual ~CannonSpoutActorProxy();
		virtual void OnEnteredWorld();
};

#endif