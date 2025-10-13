///////////////////////////////////////////////////////////////////////////////
//
// File           : $Workfile: CanonHandle.cpp $
// Version        : $Revision: 1 $
// Description    : This class to handle fire canon (meriam 57,120,76).
// 
// 
///////////////////////////////////////////////////////////////////////////////
#include <dtgame/gmcomponent.h>
#include <dtGame/messagefactory.h>
#include <dtGame/basemessages.h>
#include <dtgame/gameactor.h>
#include <dtGame/gamemanager.h>
#include <dtCore/transform.h>
#include <dtCore/object.h>
#define _WINSOCKAPI_
#ifndef WIN32_LEAN_AND_MEAN
#define WIN32_LEAN_AND_MEAN
#endif
#include <dtUtil/mswin.h>
#pragma comment(lib, "ws2_32.lib")
#include "../didCommon/simmessagetype.h"
#include "../didCommon/BaseConstant.h"
#include "../didCommon/simmessages.h"
#include "../didUtils/utilityfunctions.h"
#include "../didUtils/trajectory.h"
#include "../didUtils/simActorControl.h"
#include "../didUtils/SimEffectControl.h"
#include "../didNetwork/SimTCPDataTypes.h"
#include "../didUtils/SimActorDefinitions.h"

class CanonData
{
public : 
	CanonData();
	~CanonData(){};

	//For Move
	bool isHitGround;
	bool isEnable;
	double LifeTime;
	osg::Vec3 dir;
	osg::Vec3 FirstLaunchPoint;
	trajectory trac;

	//For Property
	int ShipID;
	int mWeaponID; 
	int mLauncherID; 
	int mMissileID; 
	int mMissileNum;
	unsigned char OrderID; 
	int mTargetID;
	int mModeID;
	int mBalistikID;
	float shipHeading;
	float spoutBearing;
	float spoutElev;

	/* Parameter For Cannon */
	/* Save In Actor For Calculate */
	/* Cannon 40, 57, 120 */ /* --> Mr Reza Calc */
	double V0X;
	double V0Y;

	/* Cannon 76Low, 76High */ /* --> Mr Andi P Calc */
	double Gun_76_Time;
	double Gun_76_TimeMax;
	double Gun_76_HeightMax;
	double Gun_76_RangeMax; 

	float WindEnviX;
	float WindEnviY;
private :
protected :
};

class CanonHandle : public dtGame::GMComponent
{
private :
protected :
public :
	CanonHandle(void);
	~CanonHandle(void);
	void Move(double aDt);
	void CleanUpDataCannon();

	std::vector<CanonData*> mCanonData;
	std::vector<NGSPos*>mNGSpos;
	virtual void ProcessMessage(const dtGame::Message& Message);

	void AddCanonData(CanonData* canonData);
	void AddNewCanonData(const dtGame::Message& Message);
	bool isInsideCircle(const int tgtX, int tgtY, int tgtZ, int refX, int refY, int refZ, float radius);

	float GetWindDirX();
	float GetWindDirY();

	// - enable process message [7/21/2014 EKA]
	bool enableProcessMessage;
};