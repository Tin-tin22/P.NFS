#ifndef APP_SHIP_MODEL_ACTOR
#define APP_SHIP_MODEL_ACTOR

 
#ifdef USE_VLD
#include <vld.h>
#endif

#include "shipactor.h"

class DID_ACTORS_EXPORT ShipModelActor : public ShipActor
{
public:
	//Constant
	static const float UNINITIALIZED_WAVE_VALUE;
	static const float NUMERATOR_DATA[3]; // x0 - x2
	static const float DENOMINATOR_TWO_DATA[2];
	static const float DENOMINATOR_THREE_DATA[3];

	static const float COLLISION_SND_TIMEOUT;

	/// Constructor
	ShipModelActor(dtGame::GameActorProxy &proxy);

	void LoadModelFile(const std::string &fileName);
	///////
	virtual void TickLocal(const dtGame::Message &tickMessage);
	virtual void TickRemote(const dtGame::Message &tickMessage){};
	virtual void ProcessMessage(const dtGame::Message &message);
	virtual void OnMessage(dtCore::Base::MessageData* msgData);
	virtual void PreFrame(const double deltaFrameTime){};
	virtual void OnEnteredWorld();
	virtual void OnRemovedFromWorld();

	//void SetHeading(float p){heading= p;};

	void 	SetOceanHeight( float oHeight ) {oceanHeight = oHeight; };
	float	GetOceanHeight( ) {return oceanHeight; };

	void 	SetOceanNormalX(const float val) { oceanNormalX = val; };
	float	GetOceanNormalX( ) { return oceanNormalX; };

	void 	SetOceanNormalY(const float val) { oceanNormalY = val; };
	float	GetOceanNormalY( ) { return oceanNormalY; };

	void 	SetOceanNormalZ(const float val) { oceanNormalZ = val									; };
	float	GetOceanNormalZ( ) { return oceanNormalZ; };

	void 	SetOceanDeltaTime( float oDT ) {oceanDeltaTime = oDT; };
	float	GetOceanDeltaTime( ) {return oceanDeltaTime; };

	void UpdateOceanWaveVars();
	void CalculateOceanWaveVars();
	void CalculateTrueValues(float elapsedTime);
	void ResetOceanWaveVars();
	void CalculatePolyOceanWaveVars();
	void CalculatePolyTrueValues(float elapsedTime);

	void SetCameraAttached( const bool state ) {mIsCameraAttached = state; };
	bool IsCameraAttached( ) {return mIsCameraAttached; };

	void SetNight( const bool state ) {mIsNight = state; };
	bool IsNight( ) {return mIsNight; };

	//switch property
	void SetWeaponsSwitchProperty(const std::string& sprop) ;
	std::string GetWeaponsSwitchProperty() ;

	void SetMissileTargetProperty(const std::string& sprop) ;
	std::string GetMissileTargetProperty() const;

	void SetGunTargetProperty(const std::string& sprop) ;
	std::string GetGunTargetProperty() const;

	void SetSosokProperty(const std::string& sprop) ;
	std::string GetSosokProperty() const;

	void SetLampsProperty(const std::string& sprop) ;
	std::string GetLampsProperty() const;
	//switch property

	void SetSwitchWeaponOFF(int idx, bool state);

	std::string GetMeshFile() {return meshFile;};


protected:
	std::string meshFile;
	std::string mWeaponSwitch;

	float mMinDist ;
	float mMaxDist ;
	float mRollOff;

	virtual void SetModelPosition();

	void InitLamps(); 
	void InitSosok();
	void InitWeaponSwitch();
	void InitGunSwitch();

	void SetParticlePosition(const std::string &dofName,const std::string &fileName, dtCore::ParticleSystem *tParticle , bool e );
	void UpdatePosition(float elapsedTime);
	void SetForwardStack(dtCore::ParticleSystem *tForwardStack, dtCore::Transform tForwardStackPosition);
	void SetAfterStack(dtCore::ParticleSystem *tAfterStack, dtCore::Transform tAfterStackPosition);
	void EngageForwardStack();
	void DisengageForwardStack();
	void EngageAfterStack();
	void DisengageAfterStack();

	void PlayStackSound();
	void StopStackSound();
	void SetStackSound(dtAudio::Sound *tStackSound, dtCore::Transform tStackSoundPosition);
	bool CheckStack(dtCore::ParticleSystem *stack, bool stackEngaged);

	dtCore::RefPtr<dtCore::ParticleSystem> forwardStack;
	dtCore::RefPtr<dtCore::ParticleSystem> afterStack;
	dtCore::RefPtr<dtCore::ParticleSystem> portWake;
	dtCore::RefPtr<dtCore::ParticleSystem> starboardWake;
	dtCore::RefPtr<dtCore::ParticleSystem> portBowWake;
	dtCore::RefPtr<dtCore::ParticleSystem> stbdBowWake;
	dtCore::RefPtr<dtCore::ParticleSystem> portRooster;
	dtCore::RefPtr<dtCore::ParticleSystem> stbdRooster;
	dtCore::RefPtr<dtCore::ParticleSystem> fwdStack;
	dtCore::RefPtr<dtCore::ParticleSystem> aftStack;
	//
	dtCore::Transform forwardStackPosition;
	dtCore::Transform afterStackPosition;
	bool forwardStackEngaged;
	bool afterStackEngaged;

	float oceanHeight;
	//osg::Vec3 oceanNormal;
	float oceanNormalX;
	float oceanNormalY;
	float oceanNormalZ;
	float oceanDeltaTime;

	float oceanHeightLast;
	osg::Vec3 oceanNormalLast;

	float oceanHeightSpeed;
	osg::Vec3 oceanNormalSpeed;


	float oceanLastDeltaTime;
	float trueHeight;
	osg::Vec3 trueNormal;

	dtUtil::Log& mLogger;

	// 3 latest data for calculating Lagrange Interpolating Polynomial.
	float polyOceanHeight[3];

	float polyOceanNormalX[3];
	float polyOceanNormalY[3];
	float polyOceanNormalZ[3];
	 
	bool mIsCameraAttached;
	bool mIsNight;
	bool bContSound;
	bool bIsCollisionSound;
	float mCollisionSoundTime;

	dtCore::RefPtr<dtAudio::Sound> SndBell0;
	dtCore::RefPtr<dtAudio::Sound> SndBell1;
	dtCore::RefPtr<dtAudio::Sound> SndBell2;
	dtCore::RefPtr<dtAudio::Sound> SndBell3;
	dtCore::RefPtr<dtAudio::Sound> SndBell4;
	dtCore::RefPtr<dtAudio::Sound> SndBell5;
	dtCore::RefPtr<dtAudio::Sound> SndBell6;
	dtCore::RefPtr<dtAudio::Sound> SndBell7;
	dtCore::RefPtr<dtAudio::Sound> SndBell8;
	dtCore::RefPtr<dtAudio::Sound> SndBell9;
	dtCore::Transform stackSoundPosition;

	dtCore::RefPtr <osg::Switch> sosokswitches;  
	dtCore::RefPtr <osg::Switch> lampswitches; 
	dtCore::RefPtr <osg::Switch> weaponswitches; 
	dtCore::RefPtr <osg::Switch> gunswitches;

	/// Destructor
	virtual ~ShipModelActor();

public :
	dtCore::RefPtr<dtAudio::Sound> stackSound;
	dtCore::RefPtr<dtAudio::Sound> collisionSound;
	dtCore::RefPtr<dtAudio::Sound> collisionSound2;

private:
	void SetSoundMaxxRoll();
	void SetBellSoundConfig(dtAudio::Sound *tmpSound , dtCore::Transform tmpSoundPos );
	void SetSoundFile();
	void SetParticleFile();	
	void GetShipChild(){};
	void PlayBellSound(int nValue);
	void SetLampStatus(ShipActor::LampTypes &type, short status );
	void SetShipLamp(int nValue);
	void SetSwitchWeaponStatus(int orderID);
	void SetSwitchSosokStatus(int i ); 
	void ProcessOrderEvent(const dtGame::Message &message);
	
	bool IsValidNode(dtCore::RefPtr <osg::Switch> swIN, const int idx); 

	short GetLampStatus(ShipActor::LampTypes &type);
	
	float p1,p2;

	//std::vector<dtCore::Scene::CollisionData> mCollisionData;	

	// Test My Own Collision [6/12/2013 DID RKT2]
	struct Box 
	{
		int x,y,w,h;
	};

	Box boxShip;
	Box boxShip2;
	bool 	IsInBox(const Box& boxship, const Box& boxship2);
	dtCore::RefPtr<dtDAL::ActorProxy> GetShipActorByID(int mVehicleID );
	void TestOwnCollision ();
};

class DID_ACTORS_EXPORT ShipModelActorProxy : public ShipActorProxy
{
public:
	/// Constructor
	ShipModelActorProxy();
	virtual void BuildPropertyMap();
	virtual void BuildInvokables();
	virtual void CreateActor() { SetActor(*new ShipModelActor(*this)); }

protected:
	/// Destructor
	virtual ~ShipModelActorProxy();
	virtual void OnEnteredWorld();
	virtual void OnRemovedFromWorld();

private:
};

#endif