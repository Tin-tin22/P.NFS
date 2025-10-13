#pragma once

#ifdef USE_VLD
#include <vld.h>
#endif

#include "../didNetwork/SocketServerGM.h"
#include "../didCommon/simMessages.h"
#include "../didCommon/simMessageType.h"
#include <dtGame\GMComponent.h>
#include <dtGame\gameactor.h>
#include <dtGame\actorupdatemessage.h>
#include <dtGame\basemessages.h>
#include <dtGame\defaultmessageprocessor.h>
#include <dtGame\environmentactor.h>
#include <dtGame\gameactor.h>
#include <dtGame\gamemanager.h>
#include <dtGame\gmcomponent.h>
#include <dtGame\invokable.h>
#include <dtGame\machineinfo.h>
#include <dtGame\messagefactory.h>
#include <dtGame\messageparameter.h>
#include <dtGame\messagetype.h>

#include <dtActors\gamemeshactor.h>


#include <vector>


class EffectControlDef
{
public:
	int					mSetID;
	int					mTypeEffect;
	float				mLifeTime;

	dtCore::UniqueId	mUniqueId;
	 
	EffectControlDef( int cSetID =1, int cTypeEffect = 1 ,float cLifeTime=1.0f );

	~EffectControlDef() { } ;

	void SetUIDObjectHandled(dtCore::UniqueId& UID) 
	{mUniqueId = UID;}

	const dtCore::UniqueId GetUIDObjectHandled() 
	{return mUniqueId;}

private :

};

class SimEffectControl :
	public dtGame::DefaultMessageProcessor
{
public:
	SimEffectControl();
	virtual ~SimEffectControl();

	bool IsInvalidMessage(const dtGame::Message& msg);
	void ProcessMessage(const dtGame::Message& msg);
	 
	EffectControlDef* AddEffect( const int mSetID, const int mTypeEffect, const int mLifeTime );
	
	bool AddEffectAndExplode( const int mSetID, const int mVehicleID, const int mTypeEffect, const int mLauncherEffect, const float mLifeTime, const osg::Vec3 xyz );
	bool AddEffectAndExplodeSpout( const int mSetID, const int mVehicleID, const int mTypeEffect, const int mLauncherEffect, const float mLifeTime, const osg::Vec3 xyz );
	
	std::vector<EffectControlDef> mEffects;

private : 
	int GetLifeTimeFromWeaponID ( int WID ) ;
	int GetLastEffectID();

	void CleanUpActorEffect();

	void HandleNetworkMessage(const dtGame::Message& msg);
	void HandleLocalMessage(const dtGame::Message& msg);
	void ProcessEffectControl(const dtGame::Message& msg);

private : 
	float mCycleUpdate;
};