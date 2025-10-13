#pragma once

/* -*-c++-*-
2012.06.11 Sam Create 
*/


#ifdef USE_VLD
#include <vld.h>
#endif

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

#include "../didActors/playeractor.h"


#include <vector>

 
class SimServerClientComponent :
	public dtGame::DefaultMessageProcessor
{
public:
	SimServerClientComponent();
	virtual ~SimServerClientComponent();

	bool IsInvalidMessage(const dtGame::Message& msg);
	void ProcessMessage(const dtGame::Message& msg);
	
	void SetPlayerAttachToVehicle( const int mVehicleID );
	void SetPlayerAttachToLauncher( const int mVehicleID, const int mWeaponID, const int mLauncherID);
	void SetObserverFocusByUID( const dtCore::UniqueId uid);
	/**
	* @shipID			= int(sp.c0); 
	@weaponID			= int(sp.c1);   /// objectTypeID ( ship, submarine, missile , misc )
	@launcherID		= int(sp.c2); 
	@missileID		= int(sp.c3); 
	@missileNum		= int(sp.c4); 
	@observerID		= int(sp.c5);   /// observerID   ( observer-1, observer-2, observer-3 , observer-4 )
	@eventID			= int(sp.c6);
	*/
	void SetObserverFocus( const int shipID, const int weaponID, const int launcherID, const int missileID, const int missileNum,  const int eventID) ;

	dtCore::RefPtr<dtDAL::ActorProxy> GetShipActorByID(int mVehicleID );
	/**

	* @ actTypeID = C_WEAPON_TYPE_BODY / C_WEAPON_TYPE_SPOUT / C_WEAPON_TYPE_MISSILE
	* @ see utilityfunction.h GetActorWeaponTypeName
	*/
	dtCore::RefPtr<dtDAL::ActorProxy> GetLauncherActors(const int actTypeID, const int mVehicleID, const int mWeaponID, const int mLauncherID  );
	dtCore::RefPtr<dtDAL::ActorProxy> GetMissileActors(const int mVehicleID, const int mWeaponID, const int mLauncherID, const int mMissileID, const int mMissileNum );
	dtCore::RefPtr<dtDAL::ActorProxy> GetMissileByLauncher(const int mVehicleID, const int mWeaponID, const int mLauncherID); // For Status OFF [5/14/2013 DID RKT2]

	dtCore::RefPtr<dtDAL::ActorProxy> GetMiscActorByID(int mMiscID );

	void CreatePlayer(const int mid, const bool IsViewCrossHair);

	bool GetIsUsePlayer();
	int GetPlayerMachineID() const;
	dtCore::UniqueId GetPlayerUniqueID() const;
	void SetPlayerUniqueID(const dtCore::UniqueId& uid, const int mid);

	void SetUnlockCamera(dtCore::UniqueId mCurrentTargetId) ;
	void SetUnlockPlayer(dtCore::UniqueId mCurrentTargetId);
	void VerifyPlayerBeforeDeleteParent(dtCore::UniqueId mCurrentTargetId);

	dtCore::Transform get_player_or_camera_transform ();
    void set_player_or_camera_transform (dtCore::Transform t);
private : 
    
	PlayerActor* player ;

	bool mUsePlayer ;
	int mPlayerMachineID ;
	dtCore::UniqueId mPlayerUniqueID ;

	dtCore::Transform get_default_actor_attach (std::string actName );
	dtCore::Transform get_default_vehicle_focus (std::string actName, dtCore::Transform vhcPos);

	void HandleNetworkMessage(const dtGame::Message& msg);
	void HandleLocalMessage(const dtGame::Message& msg);

private : 

};