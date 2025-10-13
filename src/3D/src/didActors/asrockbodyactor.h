
#ifndef ASROCK_BODY_ACTOR
#define ASROCK_BODY_ACTOR

#include "didactorsheaders.h"
#include "BaseWeaponActor.h"
#include "launcherbodyactor.h"

namespace dtAudio
{
   class Sound;
}

class DID_ACTORS_EXPORT AsrockBodyActor : public LauncherBodyActor 
{
	public :
		AsrockBodyActor(dtGame::GameActorProxy &proxy);
		virtual void TickLocal(const dtGame::Message &tickMessage);
		virtual void SetMoveRate(float rate);
		virtual float GetMoveRate() const { return mRate;}
		virtual void ProcessMessage(const dtGame::Message &message);
		void MoveWeapon_LR();//float deltaSimTime
	    float mRate_LR;
    	float TargetBearing,TargetRange, Elev,Radius;
		int TargetID, OwnShipId;

		virtual void OnEnteredWorld();
        virtual void OnRemovedFromWorld();


	protected :
		virtual ~AsrockBodyActor();
	private :
		bool stopMove,stopMove2;
		bool stopMove_LR;
		bool isTrack;
		float mRate, tempMRate;

		float tSpeed,tCourse,tBearing ,tRange, tSpeed2;
		float hRange,hBearing,hTime;
		
		dtCore::RefPtr<dtDAL::ActorProxy> parentProxy ;
		dtCore::RefPtr<dtDAL::ActorProxy> pProxy ;

		void ProcessOrderEvent(const dtGame::Message &message);

		void 	CalcHitPredition (const float tRange, const float tBearing,  const float tSpeed, 
			const float tCourse, const float  pSpeed, float &hRange, float &hBearing, float &hTime );
};

class DID_ACTORS_EXPORT AsrockBodyActorProxy : public LauncherBodyActorProxy
{
	public :
		AsrockBodyActorProxy();
		virtual void BuildPropertyMap();
		virtual void BuildInvokables();
		virtual void CreateActor() { SetActor(*new AsrockBodyActor(*this));}
	protected:
		virtual ~AsrockBodyActorProxy();
		virtual void OnEnteredWorld();
	private:
		
};

#endif