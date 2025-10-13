#ifndef SIM_MESSAGE
#define SIM_MESSAGE

#pragma once

#ifdef USE_VLD
#include <vld.h>
#endif

#include "../didNetwork/simlogin.h"
#include <dtGame/Message.h>
#include <dtCore/UniqueID.h>
#include <dtDAL/ActorType.h>
#include <dtCore/Transform.h>
#include "../didUtils/SimActorDefinitions.h"

class MsgApplyLogin : public dtGame::Message
{
	public :
		/**
		* Constructor.
		* 
		*/
		MsgApplyLogin();

		void SetLoginName(const std::string &mName);
		const std::string GetLoginName() const;

		/**
		
		* @ ANJUNGAN   = ( params1 = vehicleID	)
		* @ OBSERVER   = ( params1 = vehicleID , params2 = observerID )
		* @ TDS        = ( params1 = vehicleID , params2 = weaponID, params3 = launcherID )
		*/
		void SetParams1(const int val);
		/**
		
		* @ ANJUNGAN   = ( params1 = vehicleID	)
		* @ OBSERVER   = ( params1 = vehicleID , params2 = observerID )
		* @ TDS        = ( params1 = vehicleID , params2 = weaponID, params3 = launcherID )
		*/
		const int GetParams1() const;

		/**
		
		* @ ANJUNGAN   = ( params1 = vehicleID	)
		* @ OBSERVER   = ( params1 = vehicleID , params2 = observerID )
		* @ TDS        = ( params1 = vehicleID , params2 = weaponID, params3 = launcherID )
		*/
		void SetParams2(const int val);
		/**
		
		* @ ANJUNGAN   = ( params1 = vehicleID	)
		* @ OBSERVER   = ( params1 = vehicleID , params2 = observerID )
		* @ TDS        = ( params1 = vehicleID , params2 = weaponID, params3 = launcherID )
		*/
		const int GetParams2() const;

		/**
		
		* @ ANJUNGAN   = ( params1 = vehicleID	)
		* @ OBSERVER   = ( params1 = vehicleID , params2 = observerID )
		* @ TDS        = ( params1 = vehicleID , params2 = weaponID, params3 = launcherID )
		*/
		void SetParams3(const int val);
		/**
		
		* @ ANJUNGAN   = ( params1 = vehicleID	)
		* @ OBSERVER   = ( params1 = vehicleID , params2 = observerID )
		* @ TDS        = ( params1 = vehicleID , params2 = weaponID, params3 = launcherID )
		*/
		const int GetParams3() const;

		void SetObjectIDToBeHandled(const dtCore::UniqueId& uniqueId);
		const dtCore::UniqueId GetObjectIDToBeHandled() const;

		//void SetObjectNameToBeHandled(const std::string &mName);
		//const std::string GetObjectNameToBeHandled() const;

		//void SetReasonIfReject(const std::string& mReason);
		//const std::string GetReasonIfReject() const;

	protected :
		virtual ~MsgApplyLogin();
};

/*
*	Class update game actor Message child parent
*
*/
class MsgParentActor : public dtGame::Message
{
	public :
		MsgParentActor();

		void SetParentId(dtCore::UniqueId UId);
		const dtCore::UniqueId GetParentId() const;

	protected :
		/**
		* Destructor.
		* 
		*/
		virtual ~MsgParentActor(){};
};

class MsgPosition : public dtGame::Message
{
	public :
		MsgPosition();

		void SetVehicleID(int VID);
		const int GetVehicleID() const;

		void SetOrderID(int orderID);
		const int GetOrderID() const;

		void SetPosXValue(float val);
		const float GetPosXValue() const;

		void SetPosYValue(float val);
		const float GetPosYValue() const;

		void SetPosZValue(float val);
		const float GetPosZValue() const;

		void SetPosHValue(float val);
		const float GetPosHValue() const;

		void SetSpeedValue(float val);
		const float GetSpeedValue() const;

	protected :
		virtual ~MsgPosition(){};
};
/*
*	Class message handle order id from 2D
*
*/
class MsgOrder : public dtGame::Message
{
	public :
		MsgOrder();

		void SetOrderID(int orderID);
		const int GetOrderID() const;

		void SetFloatValue(float orderValue);
		const float GetFloatValue() const;

		void SetFloatValue1(float orderValue);
		const float GetFloatValue1() const;

		void SetFloatValue2(float orderValue);
		const float GetFloatValue2() const;

		void SetFloatValue3(float orderValue);
		const float GetFloatValue3() const;

		void SetStringValue(std::string strValue);
		const std::string GetStringValue() const;

		void SetVehicleID(int VID);
		const int GetVehicleID() const;

		void SetModeGuidance(int g);
		const int GetModeGuidance() const;

		void SetModeAltitude(int g);
		const int GetModeAltitude() const;

		void SetLethality(int g);
		const int GetLethality() const;

	protected :
		/**
		* Destructor.
		* 
		*/
		virtual ~MsgOrder(){};
};


//Armand
class MsgEnvironmentControl: public dtGame::Message
{
	public :
		MsgEnvironmentControl();
		
		void SetLatitude(double pLatitude);
		const double GetLatitude() const ;
		void SetLongitude(double pLongitude) ;
		const double GetLongitude() const ;

	protected :
		virtual ~MsgEnvironmentControl(){};
};

//sam
class MsgActorsControl: public dtGame::Message
{
	public :
		MsgActorsControl();
		 
		void SetVehicleID(int VID);
		const int GetVehicleID() const;

		/**
		
		* @ set TIPE_AR_SHIP / TIPE_AR_SUBMARINE / TIPE_AR_HELICOPTER  / TIPE_AR_AIRCRAFT     
		* @		TIPE_AR_LAUNCHER / TIPE_AR_MISSILE
		*/
		void SetTipeID(int TipeID);
		const int GetTipeID() const;

		/**
		
		* @ untuk vehicle ActorRuntimeID1 = ?        , ActorRuntimeID2 = ?			, ActorRuntimeID3 = ?         
		* @ untuk weapons ActorRuntimeID1 = Weapon ID, ActorRuntimeID2 = Launcher ID, ActorRuntimeID3 = Missile ID
		*/
		void SetActorRuntimeID1(int VID);
		const int GetActorRuntimeID1() const;

		/**
		
		* @ untuk vehicle ActorRuntimeID1 = ?        , ActorRuntimeID2 = ?			, ActorRuntimeID3 = ?         
		* @ untuk weapons ActorRuntimeID1 = Weapon ID, ActorRuntimeID2 = Launcher ID, ActorRuntimeID3 = Missile ID
		*/
		void SetActorRuntimeID2(int VID);
		const int GetActorRuntimeID2() const;

		/**
		
		* @ untuk vehicle ActorRuntimeID1 = ?        , ActorRuntimeID2 = ?			, ActorRuntimeID3 = ?         
		* @ untuk weapons ActorRuntimeID1 = Weapon ID, ActorRuntimeID2 = Launcher ID, ActorRuntimeID3 = Missile ID
		*/
		void SetActorRuntimeID3(int VID);
		const int GetActorRuntimeID3() const;

		/**
		
		* @ untuk vehicle ActorRuntimeID1 = ?        , ActorRuntimeID2 = ?			, ActorRuntimeID3 = ?         
		* @ untuk weapons ActorRuntimeID1 = Weapon ID, ActorRuntimeID2 = Launcher ID, ActorRuntimeID3 = Missile ID, ActorRuntimeID4 = Missile Number
		*/
		void SetActorRuntimeID4(int VID);
		const int GetActorRuntimeID4() const;

		void SetOrderID(int TipeID);
		const int GetOrderID() const;

		void SetPosXValue(float val);
		const float GetPosXValue() const;

		void SetPosYValue(float val);
		const float GetPosYValue() const;

		void SetPosZValue(float val);
		const float GetPosZValue() const;

		void SetPosHValue(float val);
		const float GetPosHValue() const;

		void SetPosPValue(float val);
		const float GetPosPValue() const;

		void SetPosRValue(float val);
		const float GetPosRValue() const;

	protected :
		virtual ~MsgActorsControl(){};
};


class MsgSetExocet : public dtGame::Message
{
	public :
		MsgSetExocet();

		void SetVehicleID(int VID);
		const int GetVehicleID() const;

		void SetWeaponID(int val);
		const int GetWeaponID() const;

		void SetLauncherID(int val);
		const int GetLauncherID() const;

		void SetMissileID(int MissileID);
		const int GetMissileID() const;

		void SetMissileNum(int val);
		const int GetMissileNum() const;

		void SetOrderID(int orderID);
		const int GetOrderID() const;

		void SetProxFuze(float val);
		const float GetProxFuze() const;

		void SetAltitude(float val);
		const float GetAltitude() const;

		void SetSearchArea(float val);
		const float GetSearchArea() const;

		void SetTargetBearing(float val);
		const float GetTargetBearing() const;

		void SetTargetRange(float val);
		const float GetTargetRange() const;

		void SetRangeToGo(float val);
		const float GetRangeToGo() const;

		void SetManualWidth(float val);
		const float GetManualWidth() const;

		void SetSelecDepth(float val);
		const float GetSelecDepth() const;


	protected :
		virtual ~MsgSetExocet(){};
};


class MsgSetTorpedoSUT : public dtGame::Message
{
public :
	MsgSetTorpedoSUT();

	void SetVehicleID(int VID);
	const int GetVehicleID() const;

	void SetWeaponID(int val);
	const int GetWeaponID() const;

	void SetLauncherID(int CountID);
	const int GetLauncherID() const;

	void SetMissileID(int MissileID);
	const int GetMissileID() const;

	void SetMissileNum(int val);
	const int GetMissileNum() const;

	void SetTargetID(int TGTID);
	const int GetTargetID() const;

	void SetOrderID(int orderID);
	const int GetOrderID() const;

	void SetTorpedoCourse(float TorpedoCourse);
	const float GetTorpedoCourse() const;

	void SetTorpedoSpeed(float TorpedoSpeed);
	const float GetTorpedoSpeed() const;

	void SetTorpedoDepth(float TorpedoDepth);
	const float GetTorpedoDepth() const;

	void SetModePrediction(int predm);
	const int GetModePrediction() const;

	void SetTargetType(int targetType);
	const int GetTargetType() const;

	void SetTorpedoSafeDistance(float TorpedoSafeDistance);
	const float GetTorpedoSafeDistance() const;

	void SetTorpedoEnDis(float TorpedoSafeDistance);
	const float GetTorpedoEnDis() const;


protected :
	virtual ~MsgSetTorpedoSUT(){};
};


class MsgSetTorpedo : public dtGame::Message //EKA-031111
{
public :
	MsgSetTorpedo();

	void SetVehicleID(int VID);
	const int GetVehicleID() const;

	void SetWeaponID(int val);
	const int GetWeaponID() const;

	void SetLauncherID(int CountID);
	const int GetLauncherID() const;

	void SetMissileID(int MissileID);
	const int GetMissileID() const;

	void SetMissileNum(int val);
	const int GetMissileNum() const;

	void SetTargetID(int TGTID);
	const int GetTargetID() const;

	void SetOrderID(int orderID);
	const int GetOrderID() const;
	
	void SetTorpedoISC(float TorpedoCourse);
	const float GetTorpedoISC() const;

	void SetTorpedoSpeed(float TorpedoSpeed);
	const float GetTorpedoSpeed() const;

	void SetTorpedoDepth(float TorpedoDepth);
	const float GetTorpedoDepth() const;

	void SetTorpedoISD(int TorpedoISD);
	const int GetTorpedoISD() const;

	void SetTorpedoITA(int TorpedoITA);
	const int GetTorpedoITA() const;

	void SetTorpedoISR(int TorpedoISR);
	const int GetTorpedoISR() const;

	void SetTorpedoCEI(int TorpedoCEI);
	const int GetTorpedoCEI() const;

	void SetTorpedoFLO(int TorpedoFLO);
	const int GetTorpedoFLO() const;

	void SetTorpedoACE(int TorpedoACE);
	const int GetTorpedoACE() const;

	void SetTorpedoWTR(int TorpedoWTR);
	const int GetTorpedoWTR() const;

	void SetTorpedoPRG(int TorpedoPGR);
	const int GetTorpedoPRG() const;

	void SetTorpedoACM(int TorpedoACM);
	const int GetTorpedoACM() const;

	void SetTorpedoDOP(int TorpedoDOP);
	const int GetTorpedoDOP() const;

	void SetTorpedoBarrel(int TorpedoBarrel);
	const int GetTorpedoBarrel() const;

	void SetTorpedoType(int TorpedoType);
	const int GetTorpedoType() const;

	void SetScenario(int TorpedoType);
	const int GetScenario() const;


protected :
	virtual ~MsgSetTorpedo(){};
};

class MsgSetAsrock : public dtGame::Message
{
	public:
		MsgSetAsrock();

		void SetVehicleID(int VID);
		const int GetVehicleID() const;

		void SetWeaponID(int val);
		const int GetWeaponID() const;

		void SetLauncherID(int lcrID);
		const int GetLauncherID() const;
		
		void SetMissileID(int CountID);
		const int GetMissileID() const;

		void SetMissileNum(int val);
		const int GetMissileNum() const;

		void SetOrderID(int orderID);
		const int GetOrderID() const;

		void SetTargetBearing(float val);
		const float GetTargetBearing() const;

		void SetTargetRange(float val); // sebenarnya Distance 
		const float GetTargetRange() const;

		void SetMissileType(int val); //E012012
		const int GetMissileType() const; //E012012

		void SetMissileFuze(int val); //E012012
		const int GetMissileFuze() const; //E012012

		void SetTargetDepth(float val); // sebenarnya Distance 
		const float GetTargetDepth() const;

		void SetTargetID(int val);
		const int GetTargetID() const;

		void SetCorrectRange(float val); // sebenarnya Distance 
		const float GetCorrectRange() const;
		 
	protected :
		virtual ~MsgSetAsrock(){};
};

class MsgSetRBU : public dtGame::Message
{
	public:
		MsgSetRBU();

		void SetVehicleID(int VID);
		const int GetVehicleID() const;
		
		void SetWeaponID(int val);
		const int GetWeaponID() const;

		void SetLauncherID(int CountID);
		const int GetLauncherID() const;

		void SetMissileID(int CountID);
		const int GetMissileID() const;

		void SetMissileNum(int val);
		const int GetMissileNum() const;

		void SetOrderID(int orderID);
		const int GetOrderID() const;
		
		void SetTargetBearing(float val);
		const float GetTargetBearing() const;

		void SetTargetRange(float val); // sebenarnya Distance 
		const float GetTargetRange() const;

		void SetMissileType(int val); //E012012
		const int GetMissileType() const; //E012012

		void SetTargetDepth(float val); // sebenarnya Distance 
		const float GetTargetDepth() const;

		void SetTargetID(int val);
		const int GetTargetID() const;

		void SetCountRBU(int val);
		const int GetCountRBU() const;		

		void SetCorrectBearing(float val);
		const float GetCorrectBearing() const;

		void SetCorrectElev(float val);
		const float GetCorrectElev() const;

	protected :
		virtual ~MsgSetRBU(){};
};

class MsgSetMistral : public dtGame::Message
{
public:
	MsgSetMistral();

	void SetVehicleID(int VID);
	const int GetVehicleID() const;

	void SetWeaponID(int val);
	const int GetWeaponID() const;

	void SetLauncherID(int lcrID);
	const int GetLauncherID() const;

	void SetMissileID(int CountID);
	const int GetMissileID() const;

	void SetMissileNum(int val);
	const int GetMissileNum() const;

	void SetOrderID(int orderID);
	const int GetOrderID() const;

	void SetTargetBearing(float val);
	const float GetTargetBearing() const;

	void SetTargetRange(float val); // sebenarnya Distance 
	const float GetTargetRange() const;

	void SetTargetElev(float val); // sebenarnya Distance 
	const float GetTargetElev() const;

protected :
	virtual ~MsgSetMistral(){};
};

class MsgSetTetral : public dtGame::Message
{
public:
	MsgSetTetral();

	void SetVehicleID(int VID);
	const int GetVehicleID() const;

	void SetWeaponID(int val);
	const int GetWeaponID() const;

	void SetLauncherID(int lcrID);
	const int GetLauncherID() const;

	void SetMissileID(int CountID);
	const int GetMissileID() const;

	void SetMissileNum(int val);
	const int GetMissileNum() const;

	void SetOrderID(int orderID);
	const int GetOrderID() const;

	void SetTargetBearing(float val);
	const float GetTargetBearing() const;

	void SetTargetRange(float val);  
	const float GetTargetRange() const;

	void SetTargetElev(float val); // sebenarnya Distance 
	const float GetTargetElev() const;

protected :
	virtual ~MsgSetTetral(){};
};

class MsgSetStrela : public dtGame::Message
{
public:
	MsgSetStrela();

	void SetVehicleID(int VID);
	const int GetVehicleID() const;

	void SetWeaponID(int val);
	const int GetWeaponID() const;

	void SetLauncherID(int lcrID);
	const int GetLauncherID() const;

	void SetMissileID(int CountID);
	const int GetMissileID() const;

	void SetMissileNum(int val);
	const int GetMissileNum() const;

	void SetOrderID(int orderID);
	const int GetOrderID() const;

	void SetTargetBearing(float val);
	const float GetTargetBearing() const;

	void SetTargetRange(float val); // sebenarnya Distance 
	const float GetTargetRange() const;

	void SetTargetElev(float val); // sebenarnya Distance 
	const float GetTargetElev() const;

protected :
	virtual ~MsgSetStrela(){};
};

class MsgUtilityAndTools : public dtGame::Message
{
	public :
		MsgUtilityAndTools();
		void SetOrderID(int OrderID);
		const int GetOrderID() const;
		void SetUAT0(int val);
		const int GetUAT0() const;
		void SetUAT1(int val);
		const int GetUAT1() const;
		void SetUAT2(int val);
		const int GetUAT2() const;
		void SetUAT3(int val);
		const int GetUAT3() const;
		void SetUAT4(int val);
		const int GetUAT4() const;
		void SetUAT5(double val);
		const double GetUAT5() const;
		void SetUAT6(double val);
		const double GetUAT6() const;

	protected :
		virtual ~MsgUtilityAndTools(){};
};

class MsgOceanControl : public dtGame::Message
{
	public :
		MsgOceanControl();

		void SetOrderID(int OrderID);
		const int GetOrderID() const;

		void SetBoolValue(bool val);
		const bool GetBoolValue() const;

		void SetIntValue(int val);
		const int GetIntValue() const;

		void SetFloatValue(float val);
		const float GetFloatValue() const;

		void SetVec2Value(osg::Vec2& val);
		const osg::Vec2& GetVec2Value() const;

		void SetVec3Value(osg::Vec3& val);
		const osg::Vec3& GetVec3Value() const;

		void SetVec4Value(osg::Vec4& val);
		const osg::Vec4& GetVec4Value() const;

	protected :
		virtual ~MsgOceanControl(){};
};


class MsgSetHandleMessage : public dtGame::Message
{
	public :
		MsgSetHandleMessage();

		void SetMsgID(int val);
		const int GetMsgID() const;

		void SetCmd1(double val);
		const double GetCmd1() const;

		void SetCmd2(double val);
		const double GetCmd2() const;

		void SetCmd3(double val);
		const double GetCmd3() const;

		void SetCmd4(double val);
		const double GetCmd4() const;
	protected : 
		virtual ~MsgSetHandleMessage(){};
};

class MsgSetCannon : public dtGame::Message
{
	public:
		MsgSetCannon();

		void SetVehicleID(int VID);
		const int GetVehicleID() const;

		void SetWeaponID(int val);
		const int GetWeaponID() const;

		void SetLauncherID(int val);
		const int GetLauncherID() const;

		void SetMissileID(int val);
		const int GetMissileID() const;

		void SetMissileNum(int val);
		const int GetMissileNum() const;

		void SetOrderID(int orderID);
		const int GetOrderID() const;

		void SetTargetID(int val);
		const int GetTargetID() const;

		void SetModeID(int val);
		const int GetModeID() const;

		void SetUpDown(float val);
		const float GetUpDown() const;  

		void SetAutoCorrectElev(float val);
		const float GetAutoCorrectElev() const;

		void SetAutoCorrectBearing(float val);
		const float GetAutoCorrectBearing() const;

		void SetBalistikID(int val);
		const int GetBalistikID() const;

		void SetPosXValue(float val);
		const float GetPosXValue() const;

		void SetPosYValue(float val);
		const float GetPosYValue() const;

		void SetPosZValue(float val);
		const float GetPosZValue() const;
	protected :
		virtual ~MsgSetCannon(){};

};

class MsgSetC802 : public dtGame::Message
{
	public:
		MsgSetC802();

		void SetVehicleID(int VID);
		const int GetVehicleID() const;

		void SetWeaponID(int val);
		const int GetWeaponID() const;

		void SetLauncherID(int lcrID);
		const int GetLauncherID() const;
        			
		void SetMissileID(int CountID);
		const int GetMissileID() const;

		void SetMissileNum(int val);
		const int GetMissileNum() const;

		void SetOrderID(int orderID);
		const int GetOrderID() const;

		void SetBearingToTarget(float val);
		const float GetBearingToTarget() const;

		void SetDistanceToTarget(float val);
		const float GetDistanceToTarget() const;

	protected :
		virtual ~MsgSetC802(){};
};

class MsgSetYakhont : public dtGame::Message
{
	public:
		MsgSetYakhont();

		void SetVehicleID(int VID);
		const int GetVehicleID() const;

		void SetWeaponID(int val);
		const int GetWeaponID() const;

		void SetLauncherID(int lcrID);
		const int GetLauncherID() const;
        			
		void SetMissileID(int CountID);
		const int GetMissileID() const;

		void SetMissileNum(int val);
		const int GetMissileNum() const;

		void SetOrderID(int orderID);
		const int GetOrderID() const;

		void SetCountYakhont(int countYakhont);
		const int GetCountYakhont() const;
        
		void SetBearingToTarget(float val);
		const float GetBearingToTarget() const;

		void SetDistanceToTarget(float val);
		const float GetDistanceToTarget() const;

		/*void SetMode(int val);
		const int GetMode() const; */       

	protected :
		virtual ~MsgSetYakhont(){};
};

class MsgSetExocet40 : public dtGame::Message
{
	public:
		MsgSetExocet40();

		void SetVehicleID(int VID);
		const int GetVehicleID() const;

		void SetWeaponID(int val);
		const int GetWeaponID() const;

		void SetLauncherID(int lcrID);
		const int GetLauncherID() const;
        			
		void SetMissileID(int CountID);
		const int GetMissileID() const;

		void SetMissileNum(int val);
		const int GetMissileNum() const;

		void SetOrderID(int orderID);
		const int GetOrderID() const;

		void SetCourse(float val);
		const float GetCourse() const;

		void SetDistance(float val);
		const float GetDistance() const;
        

	protected :
		virtual ~MsgSetExocet40(){};
};

class MsgSetExocetMM40 : public dtGame::Message
{
	public	:
		MsgSetExocetMM40();

		void SetVehicleID(int aVehicleID);
		const int GetVehicleID() const;

		void SetWeaponID(int aWeaponID);
		const int GetWeaponID() const;

		void SetLauncherID(int alauncherID);
		const int GetLauncherID() const;
        			
		void SetMissileID(int aMissileID);
		const int GetMissileID() const;

		void SetMissileNum(int aMissileNum);
		const int GetMissileNum() const;

		void SetOrderID(int aOrderID);
		const int GetOrderID() const;

		void SetTargetRange(float aTgtRange);
		const int GetTargetRange() const;

		void SetTargetBearing(float aTgtBearing);
		const int GetTargetBearing() const;

		void SetAngularMode(float aAngularMode);
		const int GetAngularMode() const;

		void SetAgilityMode(float aAgilityMode);
		const int GetAgilityMode() const;
		
		void SetInitialStepMode(float aInitialStepMode);
		const int GetInitialStepMode() const;

		void SetObstacle_Alt(float aObstacle_Alt);
		const int GetObstacle_Alt() const;

		void SetObstacle_Range(float aObstacle_Range);
		const int GetObstacle_Range() const;

		void SetApproach_Range(float aApproach_Range);
		const int GetApproach_Range() const;

		void SetTerminal_Range(float aTerminal_Range);
		const int GetTerminal_Range() const;
		
		void SetLeft_Angle(float aLeft_Angle);
		const int GetLeft_Angle() const;

		void SetRight_Angle(float aRight_Angle);
		const int GetRight_Angle() const;

		void SetFar_Range(float aFar_Range);
		const int GetFar_Range() const;

		void SetNear_Range(float aNear_Range);
		const int GetNear_Range() const;

		void SetMasking_1(float aMasking_1);
		const int GetMasking_1() const;

		void SetMasking_2(float aMasking_2);
		const int GetMasking_2() const;

		void SetMasking_3(float aMasking_3);
		const int GetMasking_3() const;

		void SetMasking_4(float aMasking_4);
		const int GetMasking_4() const;

		void SetMasking_5(float aMasking_5);
		const int GetMasking_5() const;

		void SetMasking_6(float aMasking_6);
		const int GetMasking_6() const;

		void SetMasking_7(float aMasking_7);
		const int GetMasking_7() const;

		void SetMasking_8(float aMasking_8);
		const int GetMasking_8() const;

		void SetMasking_9(float aMasking_9);
		const int GetMasking_9() const;

		void SetMasking_10(float aMasking_10);
		const int GetMasking_10() const;

		void SetMasking_11(float aMasking_11);
		const int GetMasking_11() const;

		void SetMasking_12(float aMasking_12);
		const int GetMasking_12() const;

		void SetMasking_13(float aMasking_13);
		const int GetMasking_13() const;

		void SetMasking_14(float aMasking_14);
		const int GetMasking_14() const;

		void SetMasking_15(float aMasking_15);
		const int GetMasking_15() const;

		void SetMasking_16(float aMasking_16);
		const int GetMasking_16() const;

		void SetSeekerOpenPosX(double aSeekerOpenPosX);
		const double GetSeekerOpenPosX() const;

		void SetSeekerOpenPosY(double aSeekerOpenPosY);
		const double GetSeekerOpenPosY() const;

		void SetSeekerOpenHeading(float aSeekerOpenHeading);
		const int GetSeekerOpenHeading() const;



		/*
		void SetMasking(int Masking[16]);
		const int GetMasking() const;
		*/

		private	:
		virtual ~MsgSetExocetMM40(){};
};

class MsgDatabaseEvent: public dtGame::Message
{
	public :
		MsgDatabaseEvent();

		void SetTypeID(int val);
		const int GetTypeID() const;

		void SetOrderID(int val);
		const int GetOrderID() const;

		void SetDetailID(int val);
		const int GetDetailID() const;

	protected :
		virtual ~MsgDatabaseEvent(){};
};

#endif