///////////////////////////////////////////////////////////////////////////////
//
// File           : $Workfile: simActorControl.h $
// Version        : $Revision: 1.7 $
// Function       :  
// Sam
// 
///////////////////////////////////////////////////////////////////////////////

#pragma once

#ifdef USE_VLD

#include <vld.h>

#endif

#include <cppunit/Portability.h>
#include <cppunit/Exception.h>
#include <cppunit/Asserter.h>
#include <cppunit/portability/Stream.h>
#include <stdio.h>

#include "../didUtils/SimActorDefinitions.h"

#include <dtgame/gmcomponent.h>
#include <dtGame/basemessages.h>
#include <dtGame/gamemanager.h>
#include <dtGame/ActorUpdateMessage.h>
#include <dtGame/gameactor.h>
#include <dtGame/messagefactory.h>
#include <dtCore/transform.h>
#include <dtCore/object.h>
#include <dtUtil/nodecollector.h>
#include <osgSim/DOFTransform>

//#include <dtUtil/mswin.h>  // untuk error+C2039



struct ConfigLauncherActor
{
	int mDatabaseID;
	int mVehicleID;
	int mWeaponID; 
	int mLauncherID;
	int mModelID1;
	int mModelID2;
	int mDOFID1;
	int mDOFID2;
	int mSwitchID;

	int mPOS_Heading;
	int mPOS_Pitch;

	std::string mName ;
	std::string mModelName1;
	std::string mModelName2;
	std::string mDOFName1;
	std::string mDOFName2;
	std::string mSwitchName;

	float mStartAngle;
	float mEndAngle;
	float mStartPitch;
	float mEndPitch;

};

struct ConfigMissileActor {

	int VehicleID;
	int WeaponID;
	int LauncherID;
	int MissileID;
	int MissileNum;

	int mPOS_Heading;
	int mPOS_Pitch;
	int Lethality;

	std::string MissileName ;
	std::string MeshName;
	std::string DOFName;

	bool IsHasLauncher ;

};

class SimActorControl : public dtGame::GMComponent
{

private:

	// RBU Ship + Target [7/26/2012 DID RKT2]
	dtCore::Transform objectTransform;
	osg::Vec3 objectPosition;
	osg::Vec3 objectRotation;
	dtCore::Transform ownShipTransform;
	osg::Vec3 ownShipPosition;
	osg::Vec3 ownShipRotation;
	float nbearing,ndistance,nElev;
	double konstan;

	osg::Vec3 WayPoint, NewPoint;
	double NewTargetBearing; 
	double NewElevation;
	float rangeWS;

	void ProcessSetActorController(const dtGame::Message &message);
	void ProcessSetShipPosition(const dtGame::Message &message);

	void CreateDefaultShipActor( const int mVehicleID, const double x, const double y,const double z,const double h );
	void CreateSubMarineActor( const int mVehicleID, const double x, const double y,const double z,const double h );
	void CreateHelicopterActor( const int mVehicleID, const double x, const double y,const double z,const double h ); //eka-26012012
	void CreateAircraftActor( const int mVehicleID, const double x, const double y,const double z,const double h ); // eka [6/18/2012 DID RKT2]
	void CreateActorMisc( const int mObjectID, const int mTipeID, const int mModelID , double x, const double y,const double z ,const double h);

	//void SendRequestSetCameraOnMissile(const int VID, const int WID, const int LID,const int MID, const int MNum);
	//void SendRequestSetCameraOnMissile(const int VID, const int WID, const int LID,const int MID, const int MNum, const dtCore::Transform pos );

	void Confirm_DeleteShipActor( const int vehicleID );
	// For status  [5/1/2013 DID RKT2]
	void Confirm_MissileActorLoaded(const int VID, const int WID, const int LID,const int MID, const int MNum);

public:
	SimActorControl(void);
	~SimActorControl(void);

	bool isStartFire;
	bool isFirst;
	int i_launcher;

	bool isSalvoRBU;
	bool isSalvoYakhont;
	bool isSalvoCannon;
	bool isReleaseYakhont;

	//yoga added for camera
	bool count_1, count_4, count_8, count_12;

	// - enable process message [7/21/2014 EKA]
	bool enableProcessMessage;

	void ProcessMessage(const dtGame::Message& Message);

	void RegisterEventOnActors(dtGame::GameActorProxy& gap, const int mWeaponID );

	void SetConfigLauncherActors ( const int mVehicleID, const int mWeaponID, const int mLauncherID ); 
	void SetConfigMissileActors ( const int mVehicleID, const int mWeaponID, const int mLauncherID, const int mMissileID, const int mMissileNum ); 

	void CreateLaunchersBodyActors();
	void CreateLaunchersSpoutActors();
	void CreateLaunchersActors( const int mVehicleID, const int mWeaponID, const int mLauncherID );
	void CreateMissileActors( const int mVehicleID, const int mWeaponID, const int mLauncherID , const int mMissileID, const int mMissileNum);
	void CreateMissileActorsForStandAlone( const int mVehicleID, const int mWeaponID, const int mLauncherID , const int mMissileID, const int mMissileNum);

	// Check Salvo [7/30/2012 DID RKT2]
	void CheckForSalvo(float aDt);
	// Check Launch RBU [4/15/2013 DID RKT2]
	void CheckLaunchSalvo(float aDt);

	//Cannon
	void SetFireCannon(const int mVehicleID, const int mWeaponID, const int mLauncherID , const bool StartFire, const int mRateSalvoPerMinutes);
	void CreateCannonMissileAndLaunch(const int mVehicleID, const int mWeaponID, const int mLauncherID , const int mMissileID, const int mMissileNum );
	
	//RBU
	void SetFireRBU(const int mVehicleID, const int mTargetID, const int mWeaponID, const int mLauncherID , const bool StartFire, const int countRBU, const float depth, const int mTypeRBU,  const float mRange,  const float mBearing, const bool LaunchFire);
	void CreateRBUMissile(const int mVehicleID, const int mWeaponID, const int mLauncherID , const int mMissileID, const int mMissileNum, 
		const float depth, const int mTypeRBU, const float mRange,  const float mBearing );
	void LaunchRBUMissile(const int mVehicleID, const int mWeaponID, const int mLauncherID , const int mMissileID, const int mMissileNum, 
		const float depth, const int mTypeRBU, const float mRange,  const float mBearing );

	// yakhont [7/30/2012 DID RKT2]
	void SetFireYakhont(const int mVehicleID, const int mWeaponID, const int mLauncherID , const bool StartFire, const int countYakhont
		,const int l1, const int l2, const int l3, const int l4, const double bearing, const double range, const bool LaunchFire, const bool isRelease);
	void CreateYakhontMissile(const int mVehicleID, const int mWeaponID, const int mLauncherID , const int mMissileID, const int mMissileNum
		, const double bearing, const double range);
	// launch yakhont [4/16/2013 DID RKT2]
	void LaunchYakhontMissile(const int mVehicleID, const int mWeaponID, const int mLauncherID , const int mMissileID, const int mMissileNum
		, const double bearing, const double range, const int OrderID);

	dtCore::RefPtr<dtDAL::ActorProxy> CreateConstantMandauCannon40( const int cVehicleID, const int cWeaponID, const int cLauncherID );
	dtCore::RefPtr<dtDAL::ActorProxy> CreateConstantDiponegoroCannon76( const int cVehicleID, const int cWeaponID, const int cLauncherID );

	dtCore::RefPtr<dtDAL::ActorProxy> GetShipActorByID(int mVehicleID );
	/**

	* @ actTypeID = C_WEAPON_TYPE_BODY / C_WEAPON_TYPE_SPOUT / C_WEAPON_TYPE_MISSILE
	* @ see utilityfunction.h GetActorWeaponTypeName
	*/
	dtCore::RefPtr<dtDAL::ActorProxy> GetLauncherActors(const int actTypeID, const int mVehicleID, const int mWeaponID, const int mLauncherID  );
	dtCore::RefPtr<dtDAL::ActorProxy> GetMissileActors(const int mVehicleID, const int mWeaponID, const int mLauncherID, const int mMissileID, const int mMissileNum );
	dtCore::RefPtr<dtDAL::ActorProxy> GetMissileByLauncher(const int mVehicleID, const int mWeaponID, const int mLauncherID);
    
	dtCore::RefPtr<dtDAL::ActorProxy> GetMiscActorByID(int mMiscID );

	void DeleteMissileActors( const int VID, const int weaponID, const int LID, const int missileID, const int missileNum );
	void DeleteLauncherActors( const int actTypeID, const int VID, const int weaponID, const int LID);
	void DeleteShipActor( int opt, int SetID  );
	void DeleteObjectMisc( int TipeID , int opt, int SetID  );

private :
	ConfigLauncherActor cfgLauncher  ;
	ConfigMissileActor cfgMissile  ;
	
	//void trans_func( unsigned int, EXCEPTION_POINTERS* );

};

/*class SE_Exception
{
private:
	unsigned int nSE;
public:
	SE_Exception() {}
	SE_Exception( unsigned int n ) : nSE( n ) {}
	~SE_Exception() {}
	unsigned int getSeNumber() { return nSE; }
};*/