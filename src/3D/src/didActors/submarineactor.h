#ifndef APP_SUBMARINE_ACTOR
#define APP_SUBMARINE_ACTOR
 
#include "shipactor.h"

class DID_ACTORS_EXPORT SubMarineActor : public VehicleActor
{
public:
	static const float COLLISION_SND_TIMEOUT;
		
	SubMarineActor(dtGame::GameActorProxy &proxy);

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
	float mCollisionSoundTime;

	bool bIsCollisionSound;
	bool mFirstInitSwitchTarget;

	dtCore::RefPtr<dtCore::ParticleSystem> mParticleEffectHalu;
	dtCore::RefPtr<dtCore::ParticleSystem> mParticleEffectLambung;
	dtCore::RefPtr<dtCore::ParticleSystem> mParticleEffectBuritan;
	dtCore::RefPtr<dtCore::ParticleSystem> mParticleSubWake;  

	/// Destructor

	void SetParticleFile();
	void SetParticlePosition(const std::string &dofName,const std::string &fileName, dtCore::ParticleSystem *tParticle );

	virtual void UpdatePosition(float elapsedTime);

    virtual ~SubMarineActor();

private:
	float altitudeVal,verudderVal,p2,tempPitch;
	bool isVerudder,isAltitude, firstGetPos;
  
	void GetShipChild(){};
	float GetDynamicPitch(osg::Vec3 point1, osg::Vec3 point2);
	void SetShipSmokeSubMarine(const int OrderValue);
	void ProcessOrderEvent(const dtGame::Message &message);

	// Sound
	dtCore::RefPtr<dtAudio::Sound> collisionSound;
	dtCore::RefPtr<dtAudio::Sound> collisionSound2;
};

class DID_ACTORS_EXPORT SubMarineActorProxy : public VehicleActorProxy
{
   public:
		/// Constructor
		SubMarineActorProxy();
		virtual void BuildPropertyMap();
		virtual void BuildInvokables();
		virtual void CreateActor() { SetActor(*new SubMarineActor(*this)); }
	protected:
		/// Destructor
		virtual ~SubMarineActorProxy();
		virtual void OnEnteredWorld();
   private:
};

#endif