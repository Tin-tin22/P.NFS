
#ifndef MISTRAL_BODY_ACTOR
#define MISTRAL_BODY_ACTOR

#include "didactorsheaders.h"
#include "launcherbodyactor.h"

namespace dtAudio
{
	class Sound;
}

class DID_ACTORS_EXPORT MistralBodyActor : 
	public LauncherBodyActor
{
public :
	MistralBodyActor(dtGame::GameActorProxy &proxy);
	virtual void TickLocal(const dtGame::Message &tickMessage);
	virtual void ProcessMessage(const dtGame::Message &message);
	void MoveWeapon_LR();
	float mRate_LR;
	float TargetBearing,Elev,Radius;

	virtual void OnEnteredWorld();
	virtual void OnRemovedFromWorld();


protected :
	virtual ~MistralBodyActor();
private :
	std::string	mModelFile;
	bool mWeaponOn;
	bool stopMove;
	bool stopMove_LR;
	bool Assigned;

	dtCore::RefPtr<osgSim::DOFTransform> mDOFTran;

	void ProcessOrderEvent(const dtGame::Message &message);
};

class DID_ACTORS_EXPORT MistralBodyActorProxy : public LauncherBodyActorProxy
{
public :
	MistralBodyActorProxy();
	virtual void BuildPropertyMap();
	virtual void BuildInvokables();
	virtual void CreateActor() { SetActor(*new MistralBodyActor(*this));}
protected:
	virtual ~MistralBodyActorProxy();
	virtual void OnEnteredWorld();
private:

};

#endif