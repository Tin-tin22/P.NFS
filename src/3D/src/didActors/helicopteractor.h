#ifndef APP_HELICOPTER_ACTOR
#define APP_HELICOPTER_ACTOR

#include "didactorsheaders.h"
#include "shipactor.h"

class DID_ACTORS_EXPORT HelicopterActor : public VehicleActor
{
public:
	HelicopterActor(dtGame::GameActorProxy &proxy);

	virtual void TickLocal(const dtGame::Message &tickMessage);
	virtual void TickRemote(const dtGame::Message &tickMessage);
	virtual void ProcessMessage(const dtGame::Message &message);
	virtual void OnEnteredWorld();
	virtual void OnRemovedFromWorld();
 
	void LoadModelFile(const std::string &fileName);
	void CeckInitialSwitchTarget();

	std::string GetMeshFile() {return meshFile;};

protected:
	std::string meshFile;

	float mMinDist ;
	float mMaxDist ;
	float mRollOff;

	bool mFirstInitSwitchTarget;

	dtCore::RefPtr<dtCore::ParticleSystem> mParticleEffectHalu;
	dtCore::RefPtr<dtCore::ParticleSystem> mParticleEffectLambung;
	dtCore::RefPtr<dtCore::ParticleSystem> mParticleEffectBuritan;
	dtCore::RefPtr<dtCore::ParticleSystem> mParticleSubWake;

	/// Destructor

	void SetParticleFile();
	void SetParticlePosition(const std::string &dofName,const std::string &fileName, dtCore::ParticleSystem *tParticle );

	virtual void UpdatePosition(float elapsedTime);	

	virtual ~HelicopterActor();

private:
	bool isFall;
	dtCore::Transform heliTransform;

	float h1,p1,p2;

	osg::Vec3 heliPosition;
	osg::Vec3 heliRotation;

	void SetShipSmokeHelicopter(const int OrderValue);
	void SetSoundFile();   
	void GetShipChild(){};
	void ProcessOrderEvent(const dtGame::Message &message);

};

class DID_ACTORS_EXPORT HelicopterActorProxy : public VehicleActorProxy
{
public:
	/// Constructor
	HelicopterActorProxy();
	virtual void BuildPropertyMap();
	virtual void BuildInvokables();
	virtual void CreateActor() { SetActor(*new HelicopterActor(*this)); }
protected:
	/// Destructor
	virtual ~HelicopterActorProxy();
	virtual void OnEnteredWorld();
private:
};

#endif