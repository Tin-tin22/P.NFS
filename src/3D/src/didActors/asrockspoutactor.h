/*
	PELUNCUR ANTI SUBMARINE ROCKET (SPOUT)
*/

#ifndef ASROCK_SPOUT_ACTOR
#define ASROCK_SPOUT_ACTOR

#include "didactorsheaders.h"
#include "launcherspoutactor.h"

namespace dtAudio
{
   class Sound;
}

class DID_ACTORS_EXPORT AsrockSpoutActor : public LauncherSpoutActor
{
	public :
		AsrockSpoutActor(dtGame::GameActorProxy &proxy);
		virtual void TickLocal(const dtGame::Message &tickMessage);
		virtual void TickRemote(const dtGame::Message &tickMessage);
		virtual void SetMoveRate_UD(float rate);
		virtual void ProcessMessage(const dtGame::Message &message);

		float Elev, tempElev;
		float nbearing,ndistance; 
		int TipeID ;

		/*void 	SetTipeID(int newVal) {TipeID = newVal;};
		int		GetTipeID() {return TipeID ;};*/

		void AsrockSpoutMovement();
		void MoveWeapon_UD();

		virtual void OnEnteredWorld();
        virtual void OnRemovedFromWorld();

	protected :
		virtual ~AsrockSpoutActor();
	private :

		bool stopMove_UD,stopMove_UD2,isMatch;
		float mRate_UD;

		int		TargetID, ShipID, TipeLoading, TipeAssigned;
		float	CorrectRange;

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
		
		dtCore::RefPtr<dtAudio::Sound> engineSound;

		dtCore::Transform objectTransform;
		osg::Vec3 objectPosition;
		osg::Vec3 objectRotation;
		dtCore::Transform ownShipTransform;
		osg::Vec3 ownShipPosition;
		osg::Vec3 ownShipRotation;

		float tSpeed,tCourse,tBearing ,tRange;
		float hRange,hBearing,hTime;

		dtCore::RefPtr<dtDAL::ActorProxy> parentProxy ;
		dtCore::RefPtr<dtDAL::ActorProxy> pProxy ;

		void ProcessOrderEvent(const dtGame::Message &message);
		double InitElevation(double a);
		void 	CalcHitPredition (const float tRange, const float tBearing,  const float tSpeed, 
			const float tCourse, const float  pSpeed, float &hRange, float &hBearing, float &hTime );
};

class DID_ACTORS_EXPORT AsrockSpoutActorProxy : public LauncherSpoutActorProxy
{
	public :
		AsrockSpoutActorProxy();
		virtual void BuildPropertyMap();
		virtual void CreateActor() { SetActor(*new AsrockSpoutActor(*this));}
		virtual void BuildInvokables();
	protected:
		virtual ~AsrockSpoutActorProxy();
		virtual void OnEnteredWorld();
};

#endif