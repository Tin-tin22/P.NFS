/*
	RBU6000
*/

#ifndef RBU_SPOUT_ACTOR
#define RBU_SPOUT_ACTOR

#include "didactorsheaders.h"
#include "launcherspoutactor.h"


namespace dtAudio
{
   class Sound;
}

class DID_ACTORS_EXPORT RBUSpoutActor : public LauncherSpoutActor
{
	public :
		RBUSpoutActor(dtGame::GameActorProxy &proxy);
		virtual void TickLocal(const dtGame::Message &tickMessage);
		virtual void TickRemote(const dtGame::Message &tickMessage);
		virtual void SetMoveRate_UD(float rate);
		virtual void ProcessMessage(const dtGame::Message &message);

		void RBUSpoutMovement();
		void MoveWeapon_UD();

		float	ndistance;
		
		virtual void OnEnteredWorld();
        virtual void OnRemovedFromWorld();

	protected :
		virtual ~RBUSpoutActor();
	private :

		bool stopMove_UD, stopMove_UD2;
		float mRate_UD;

		float	Elev,ElevLoading, tempElev;
		float	CorrectElev;
		int		TargetID, ShipID, ORDER_AUTO_OR_MANUAL;

		enum TypeOfRBU
		{
			B = 0
			, Balistik1
			, Balistik2
		};
		
		int TipeID;

		float tSpeed,tCourse,tBearing ,tRange;
		float hRange,hBearing,hTime;

		dtCore::RefPtr<dtDAL::ActorProxy> parentProxy;
		dtCore::RefPtr<dtDAL::ActorProxy> pProxy;
		void ProcessOrderEvent(const dtGame::Message &message);
		double InitElevation(double a);
		void 	CalcHitPredition (const float tRange, const float tBearing,  const float tSpeed, 
			const float tCourse, const float  pSpeed, float &hRange, float &hBearing, float &hTime );

};

class DID_ACTORS_EXPORT RBUSpoutActorProxy :  public LauncherSpoutActorProxy
{
	public :
		RBUSpoutActorProxy();
		virtual void BuildPropertyMap();
		virtual void CreateActor() { SetActor(*new RBUSpoutActor(*this));}
		virtual void BuildInvokables();
	protected:
		virtual ~RBUSpoutActorProxy();
		virtual void OnEnteredWorld();
};

#endif