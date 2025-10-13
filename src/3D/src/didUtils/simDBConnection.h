///////////////////////////////////////////////////////////////////////////////
//
// File           : $Workfile: simDBConnection.h $
// Version        : $Revision: 1 $
// Function       :  
// Sam
// 
///////////////////////////////////////////////////////////////////////////////
#pragma once

#include "../didCommon/BaseConstant.h"
#include "../didCommon/simmessages.h"
#include "../didCommon/simmessagetype.h"

#include "../didUtils/SimActorDefinitions.h"
#include "../didActors/oceanconfigactor.h"

#include <driver/mysql_public_iface.h>

#include <dtgame/gmcomponent.h>
#include <dtGame/basemessages.h>
#include <dtGame/gamemanager.h>
#include <dtGame/ActorUpdateMessage.h>
#include <dtGame/gameactor.h>
#include <dtGame/messagefactory.h>

class SimDBConnection :
  public dtGame::GMComponent
{
private:
	bool IsActorFound;
	int CurrentScenarioID ;

	std::string mConnHost ;
	std::string mConnUser ;
	std::string mConnPass;
	std::string mConnDBName ;

	SimOceanConfig   mOceanCFG ;
	SimStaticObject  mStaticObject ;

	void ShowError( sql::SQLException &e );
	void ShowErrorGet( const std::string& err);
	
	bool GetStringValue( const std::string& attribName , float& result );
	bool GetStringValue( const std::string& attribName , bool& result );
	bool GetStringValue( const std::string& attribName , osg::Vec2f& result );
	bool GetStringValue( const std::string& attribName , osg::Vec3f& result );
	bool GetStringValue( const std::string& attribName , osg::Vec4f& result );

	int GetThemeIDFromScenarioID (const int scenarioID); 
	int GetPortIDFromScenarioID(const int scenarioID);

	
	bool isNightScenario( const int scenarioID );

	void ProcessSetDBEvents(const dtGame::Message &message);
	
	std::string SetLauncherName(const int mVehicleID, const int mWeaponID , const int mLauncherID);
	std::string GetSwitchNameFromIDSwitch(const int ID_SWITCH );
	std::string GetWeaponNameFromIDWeapon(const int IDWEAPON ) ;
	
	std::string GetDOFNameFromIDDOF(const int ID_DOF );
	
	void CreateActorWeapon(SimActorShipDef* actDef );
	void CreateActorMissile(SimActorShipDef* actDef );
	dtCore::RefPtr<dtGame::GameActorProxy> CreateComponent(SimActorShipDef* actDef,  std::string name, bool isChild = false );
	SimActorShipDef* FindActorCompDefByName(std::string name);
	SimActorShipDef* FindActorCompDef(SimActorShipDef* actComp, std::string type);
	SimActorShipDef* GetActorCompDef(std::string actName);
	SimActorShipDef* FindVehicleActorCompDef(const int mVehicleID);

	void GetListActorWeaponDatabase( SimActorShipDef* mCompDef , const int scenarioID);
	void GetListActorMissileDatabase( SimActorShipDef* mCompDef );
	
	void SetOceanConfig(didEnviro::OceanConfigActor* configActor);
	bool LoadOceanConfigFromDatabase(const int themeID, const int scenarioID );
	bool CreateOceanConfigActor();

	bool LoadStaticObjectFromDatabase(const std::string& tblName , const int themeID );
	void CreateStaticObject(dtGame::GameManager &gameManager, const bool setCollision);

	void ShowShipList();

protected:
	sql::Driver		*mysql_driver;
	sql::Connection	*mysql_connection;
public :
	std::vector<SimActorShipDef*> mVehicleActors;

	// - enable process message [7/21/2014 EKA]
	bool enableProcessMessage;
public:
	SimDBConnection(void);
	~SimDBConnection(void);

	std::string GetModelNameFromIDModel( const int modelID ) ;
	int GetModelIDFromShipID( const int ShipID );

	double GetxOffSetFromScenarioID(const int scenarioID);
	double GetyOffSetFromScenarioID(const int scenarioID);


	SimActorMissileDef* FindActorMissileDef( const int mVehicleID, const int mWeaponID, const int mLauncherID, const int mMissileID, const int mMissileNum );
	SimActorWeaponDef* FindActorWeaponDef( const int mVehicleID, const int mWeaponID, const int mLauncherID );

	bool isDatabaseConnected();
	bool ConnectDatabase( const std::string& mHost, const std::string& mUser, const std::string& mPass, const std::string& mDBN );
	std::string GetShipNameByID ( const int shipID ); 
	double GetShipMaxSpeedByID ( const int shipID ); 
	double GetShipDamageByID ( const int shipID ); 
	int GetWeaponLethalityFromIDWeapon(const int IDWEAPON ) ;

	dtCore::RefPtr<dtGame::GameActorProxy> CreateActor( std::string name);
	bool CreateOceanConfigFromDatabase(const int scenarioID);
	bool CreateEnvironmentFromDatabase(dtGame::GameManager &gameManager, const int scenarioID);
	void GetListActorDefDatabase(const int scenarioID);
	void CreateOceanActor(dtGame::GameManager &gameManager);
	
	void GetEnvironmentValue(const int ScenarioID, 
							  float& mEnvi_SeaState,
							  float& mEnvi_WindSpeed,
							  float& mEnvi_CurrentSpeed,
							  float& mEnvi_Temperature,
							  float& mEnvi_BarometerPressure,
							  float& mEnvi_Humidity,
							  float& mEnvi_WindDirection,
							  float& mEnvi_CurrentDirection,
							  float& mFog_Height);

	std::vector<NGSPos*> GetNGSpos(const int ScenarioID);

	SimActorWeaponDef* GetNewDatabaseActorWeaponDef( const int mVehicleID, const int mWeaponID, const int mLauncherID );
	SimActorMissileDef* GetNewDatabaseActorMissileDef( const int mVehicleID, const int mWeaponID, const int mLauncherID, const int mMissileID, const int mMissileNum );

	void DeleteActorMissileDef( const int mVehicleID, const int mWeaponID, const int mLauncherID, const int mMissileID, const int mMissileNum ) ;
	void ProcessMessage(const dtGame::Message& Message);

};