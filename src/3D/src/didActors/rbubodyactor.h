
#ifndef RBU_BODY_ACTOR
#define RBU_BODY_ACTOR

#include "didactorsheaders.h"
#include "launcherbodyactor.h"

namespace dtAudio
{
   class Sound;
}

class DID_ACTORS_EXPORT RBUBodyActor : public LauncherBodyActor
{
	public :
		RBUBodyActor(dtGame::GameActorProxy &proxy);
		virtual void TickLocal(const dtGame::Message &tickMessage);
		virtual void ProcessMessage(const dtGame::Message &message);
		virtual void SetMoveRate(float rate);
		void MoveWeapon_LR();//float deltaSimTime
	    float mRate_LR;
    	float TargetBearing,Elev,Radius,CorrectBearing;
		 
		virtual void OnEnteredWorld();
        virtual void OnRemovedFromWorld();


	protected :
		virtual ~RBUBodyActor();
	private :

		bool stopMove_LR,stopMove_LR2;
		float mRate, tempMRate;
		
		int TargetID, OwnShipId, ORDER_MANUAL_OR_AUTO;

		dtCore::RefPtr<dtDAL::ActorProxy> parentProxy;
		dtCore::RefPtr<dtDAL::ActorProxy> pProxy;

		void ProcessOrderEvent(const dtGame::Message &message);
};

class DID_ACTORS_EXPORT RBUBodyActorProxy : public LauncherBodyActorProxy
{
	public :
		RBUBodyActorProxy();
		virtual void BuildPropertyMap();
		virtual void BuildInvokables();
		virtual void CreateActor() { SetActor(*new RBUBodyActor(*this));}
	protected:
		virtual ~RBUBodyActorProxy();
		virtual void OnEnteredWorld();
		virtual void OnRemovedFromWorld();
	private:
		
};

#endif