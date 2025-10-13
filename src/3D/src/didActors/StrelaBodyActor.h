
#ifndef STRELA_BODY_ACTOR
#define STRELA_BODY_ACTOR

#include "didactorsheaders.h"
#include "launcherbodyactor.h"

namespace dtAudio
{
	class Sound;
}

class DID_ACTORS_EXPORT StrelaBodyActor : 
	public LauncherBodyActor
{
public :
	StrelaBodyActor(dtGame::GameActorProxy &proxy);
	virtual void TickLocal(const dtGame::Message &tickMessage);
	virtual void ProcessMessage(const dtGame::Message &message);
	void MoveWeapon_LR();
	float mRate_LR;
	float TargetBearing,Elev,Radius;

	virtual void OnEnteredWorld();
	virtual void OnRemovedFromWorld();


protected :
	virtual ~StrelaBodyActor();
private :
	std::string	mModelFile;
	bool mWeaponOn;
	bool stopMove;
	bool stopMove_LR;
	bool Assigned;

	dtCore::RefPtr<osgSim::DOFTransform> mDOFTran;

	void ProcessOrderEvent(const dtGame::Message &message);
};

class DID_ACTORS_EXPORT StrelaBodyActorProxy : public LauncherBodyActorProxy
{
public :
	StrelaBodyActorProxy();
	virtual void BuildPropertyMap();
	virtual void BuildInvokables();
	virtual void CreateActor() { SetActor(*new StrelaBodyActor(*this));}
protected:
	virtual ~StrelaBodyActorProxy();
	virtual void OnEnteredWorld();
private:

};

#endif