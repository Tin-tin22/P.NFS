/*
PELUNCUR ANTI SUBMARINE ROCKET (SPOUT)
*/

#ifndef MISTRAL_SPOUT_ACTOR
#define MISTRAL_SPOUT_ACTOR

#include "didactorsheaders.h"
#include "launcherspoutactor.h"


namespace dtAudio
{
	class Sound;
}

class DID_ACTORS_EXPORT MistralSpoutActor : 
	public LauncherSpoutActor
{
public :
	MistralSpoutActor(dtGame::GameActorProxy &proxy);
	virtual void TickLocal(const dtGame::Message &tickMessage);
	virtual void TickRemote(const dtGame::Message &tickMessage);
	virtual void SetMoveRate_UD(float rate);
	virtual void ProcessMessage(const dtGame::Message &message);

	void MistralSpoutMovement();
	void MoveWeapon_UD();
	float TargetBearing,Elev,Radius;
	bool isFind;

	virtual void OnEnteredWorld();
	virtual void OnRemovedFromWorld();

protected :
	virtual ~MistralSpoutActor();
private :
	std::string	mModelFile;

	bool stopMove_UD;
	bool Assigned;
	float mRate_UD;

	void ProcessOrderEvent(const dtGame::Message &message);
	dtCore::RefPtr<osgSim::DOFTransform> mDOFTran;

	
	void SearchingTarget();

	dtCore::Transform objectTransform;
	osg::Vec3 objectPosition;
	osg::Vec3 objectRotation;

	dtCore::Transform missileTransform;
	osg::Vec3 missilePosition,missileRotation;
	float	jarakHelicopter, jarakTarget;

	dtCore::RefPtr<dtAudio::Sound> missileSound;

};

class DID_ACTORS_EXPORT MistralSpoutActorProxy : 
	public LauncherSpoutActorProxy
{
public :
	MistralSpoutActorProxy();
	virtual void BuildPropertyMap();
	virtual void CreateActor() { SetActor(*new MistralSpoutActor(*this));}
	virtual void BuildInvokables();
protected:
	virtual ~MistralSpoutActorProxy();
	virtual void OnEnteredWorld();
};

#endif