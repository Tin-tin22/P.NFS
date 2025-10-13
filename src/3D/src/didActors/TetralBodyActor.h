
#ifndef TETRAL_BODY_ACTOR
#define TETRAL_BODY_ACTOR

#include "didactorsheaders.h"
#include "launcherbodyactor.h"

namespace dtAudio
{
	class Sound;
}

class DID_ACTORS_EXPORT TetralBodyActor : public LauncherBodyActor
{
public :
	TetralBodyActor(dtGame::GameActorProxy &proxy);
	virtual void TickLocal(const dtGame::Message &tickMessage);
	virtual void ProcessMessage(const dtGame::Message &message);
	
	void TetralRotation();
	void MoveWeapon_LR();
	float mRate_LR;
	float TargetBearing,Elev,Radius;

	virtual void OnEnteredWorld();
	virtual void OnRemovedFromWorld();


protected :
	virtual ~TetralBodyActor();
private :
	bool mWeaponOn;
	bool stopMove;
	bool stopMove_LR;
	bool Assigned;
	float mRate;

	void ProcessOrderEvent(const dtGame::Message &message);
};

class DID_ACTORS_EXPORT TetralBodyActorProxy : public LauncherBodyActorProxy
{
public :
	TetralBodyActorProxy();
	virtual void BuildPropertyMap();
	virtual void BuildInvokables();
	virtual void CreateActor() { SetActor(*new TetralBodyActor(*this));}
protected:
	virtual ~TetralBodyActorProxy();
	virtual void OnEnteredWorld();
private:

};

#endif