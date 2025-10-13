/*
PELUNCUR ANTI SUBMARINE ROCKET (SPOUT)
*/

#ifndef STRELA_SPOUT_ACTOR
#define STRELA_SPOUT_ACTOR

#include "didactorsheaders.h"
#include "launcherspoutactor.h"

namespace dtAudio
{
	class Sound;
}

class DID_ACTORS_EXPORT StrelaSpoutActor : 
	public LauncherSpoutActor
{
public :
	StrelaSpoutActor(dtGame::GameActorProxy &proxy);
	virtual void TickLocal(const dtGame::Message &tickMessage);
	virtual void TickRemote(const dtGame::Message &tickMessage);
	virtual void SetMoveRate_UD(float rate);
	virtual void ProcessMessage(const dtGame::Message &message);

	void StrelaSpoutMovement();
	void MoveWeapon_UD();
	float TargetBearing,Elev,Radius;
	bool isFind;

	virtual void OnEnteredWorld();
	virtual void OnRemovedFromWorld();

protected :
	virtual ~StrelaSpoutActor();
private :
	std::string	mModelFile;

	bool stopMove_UD;
	bool Assigned;
	float mRate_UD;

	void ProcessOrderEvent(const dtGame::Message &message);
	void SearchingTarget();

	dtCore::Transform objectTransform;
	osg::Vec3 objectPosition;
	osg::Vec3 objectRotation;

	dtCore::Transform missileTransform;
	osg::Vec3 missilePosition,missileRotation;
	float	jarakHelicopter, jarakTarget;
	
	dtCore::RefPtr<dtAudio::Sound> missileSound;
};

class DID_ACTORS_EXPORT StrelaSpoutActorProxy : 
	public LauncherSpoutActorProxy
{
public :
	StrelaSpoutActorProxy();
	virtual void BuildPropertyMap();
	virtual void CreateActor() { SetActor(*new StrelaSpoutActor(*this));}
	virtual void BuildInvokables();
protected:
	virtual ~StrelaSpoutActorProxy();
	virtual void OnEnteredWorld();
};

#endif