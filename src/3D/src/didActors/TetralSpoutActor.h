/*
PELUNCUR ANTI SUBMARINE ROCKET (SPOUT)
*/

#ifndef TETRAL_SPOUT_ACTOR
#define TETRAL_SPOUT_ACTOR

#include "export.h"
#include "launcherspoutactor.h"
#include "missileactor.h"

namespace dtAudio
{
	class Sound;
}

class DID_ACTORS_EXPORT TetralSpoutActor : public LauncherSpoutActor
{
public :
	TetralSpoutActor(dtGame::GameActorProxy &proxy);
	virtual void TickLocal(const dtGame::Message &tickMessage);
	virtual void TickRemote(const dtGame::Message &tickMessage);
	virtual void SetMoveRate_UD(float rate);
	virtual void ProcessMessage(const dtGame::Message &message);

	void TetralSpoutMovement();
	void MoveWeapon_UD();
	float TargetBearing,Elev,Radius;

	virtual void OnEnteredWorld();
	virtual void OnRemovedFromWorld();

protected :
	virtual ~TetralSpoutActor();
private :
	bool stopMove_UD;
	bool Assigned;
	float mRate_UD;
	void ProcessOrderEvent(const dtGame::Message &message);
};

class DID_ACTORS_EXPORT TetralSpoutActorProxy : public LauncherSpoutActorProxy
{
public :
	TetralSpoutActorProxy();
	virtual void BuildPropertyMap();
	virtual void CreateActor() { SetActor(*new TetralSpoutActor(*this));}
	virtual void BuildInvokables();
protected:
	virtual ~TetralSpoutActorProxy();
	virtual void OnEnteredWorld();
};

#endif