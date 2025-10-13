#pragma once


//==================== =========================== =========================//  

struct spCheck
{
	unsigned char ID;
	char pass[3];
};

/**
* -- structPositionID			= 1;
*/
struct spPosition	
{
	spCheck pc;
	unsigned short int ShipID;
	double x, y, z;
	float heading;
	float speed;
	float pitch;
	float roll;
	float rudder;
};

/**
* -- structOrderID				= 3;
*/
struct spOrder	// 
{
	spCheck pc;
	unsigned short int ShipID;
	unsigned char OrderID;
	float value;
	unsigned char modeGuidance;
	//unsigned char modeAltitude;
	float x, y, z; //waypoint
};

/**
* -- structSetDatabaseEvent			= 58
*/
struct spDatabaseEvent
{
	spCheck pc;
	unsigned short int TypeID;
	unsigned short int OrderID;
	unsigned short int DetailID;
};

/**
* -- structCreateAR				= 51;
*/
struct spActorsController
{
	spCheck pc;
	unsigned short int VehicleID;
	unsigned short int TipeID;
	unsigned short int ActorRuntimeID1; /// example use Weapon ID
	unsigned short int ActorRuntimeID2; /// example use Launcher ID 
	unsigned short int ActorRuntimeID3; /// example use Missile ID 
	unsigned short int ActorRuntimeID4; /// example use Missile ID 
	unsigned short int OrderID;
	double x, y, z, h, p, r;
};

/**
* -- structUtilityAndTools		= 53
*/
struct spUtilityTools
{
	spCheck pc;
	unsigned short int OrderID;
	unsigned short int c0,c1,c2,c3,c4;
	double c5,c6;
};

/**
* -- structMissilePos			= 50
*/
struct spMissilePos
{
	spCheck pc;
	unsigned short int ShipID;
	unsigned short int WeaponID; 
	unsigned short int LauncherID;
	unsigned short int MissileID;
	unsigned short int MissileNum;
	//unsigned char TipeID;
	unsigned char Status;
	double x, y, z;
	float heading;
	float speed;
};

/**
* -- structSetTorpedoSUT 		= 9;
*/
struct spSetTorpedoSUT
{
	spCheck pc;
	unsigned short int ShipID;
	unsigned short int mWeaponID; 
	unsigned short int mLauncherID;
	unsigned short int mMissileID;
	unsigned short int mMissileNum;
	unsigned short int mTgtID;
	unsigned char OrderID;
	float mTorpedoCourse;
	float mTorpedoSpeed;
	float mTorpedoDepth;
	float mTorpedoSafeDistance;
	float mTorpedoEnDis ;
	unsigned short int predm;
	unsigned char mTargetType;	
};

/**
* -- structSetTorpedo			= 57
*/
struct spSetTorpedoA244
{
	spCheck pc;
	unsigned short int ShipID;
	unsigned short int mWeaponID; 
	unsigned short int mLauncherID; 
	unsigned short int mMissileID; 
	unsigned short int mMissileNum;
	unsigned char OrderID;
	float ISC;

	unsigned short int ISR; // Initial Straight Run
	unsigned short int WTR; // 1 shallow, 2 deep
	unsigned short int CEI; // CEIling; Minimum depth limit
	unsigned short int PRG; // 1 Helix, 2 Spiral
	unsigned short int DOP; // 1 FM, 2 CW
	unsigned short int ACE; // ACoustic Enabling distance
	unsigned short int FLO; // FLOor; Maximum depth limit;
	unsigned short int ISD; // Initial Search Depth	
	unsigned short int ACM; // 1 act, 2 pas, 3 mix


};

/**
* -- structSetCannon				= 7;
*/
struct spSetCannon		
{
	spCheck pc;
	unsigned short int ShipID;
	unsigned short int mWeaponID; 
	unsigned short int mLauncherID; 
	unsigned short int mMissileID; 
	unsigned short int mMissileNum;
	unsigned char OrderID; 

	unsigned short int mTargetID;
	unsigned short int mModeID;
	float mUpDown;
	float mAutoCorrectElev;
	float mAutoCorrectBearing;

	unsigned short int mBalistikID;
	unsigned short int mRateSalvoPerMinutes;
};

/**
* -- structSetAsrock				= 6;
*/
struct spSetAsrock		
{
	spCheck pc;
	unsigned short int ShipID;
	unsigned short int mWeaponID; 
	unsigned short int mLauncherID;
	unsigned short int mMissileID;
	unsigned short int mMissileNum;
	unsigned short int mMissileType;
	unsigned short int TargetShipID;
	unsigned char OrderID;
	float mTargetBearing;
	float mTargetRange;
	float mTargetDepth;
	unsigned short int fuze; //time=0, proximity=1
	float mCorrectRange;
};

/**
* -- structSetRBU				= 19;
*/
struct spSetRBU
{
	spCheck pc;
	unsigned short int ShipID;
	unsigned short int mWeaponID; 
	unsigned short int mLauncherID;
	unsigned short int mMissileID;
	unsigned short int mMissileNum;
	unsigned short int CountRBU;
	unsigned short int mMissileType;
	unsigned short int TargetShipID;
	unsigned char OrderID;
	float mTargetBearing;
	float mTargetRange;
	float mTargetDepth;
	float correctBearing;
	float correctElevation;
};

/**
* -- structSetExocet				= 4;
*/
struct spSetExocet	 
{
	spCheck pc;
	unsigned short int ShipID;
	unsigned short int mWeaponID; 
	unsigned short int mLauncherID;
	unsigned short int mMissileID;
	unsigned short int mMissileNum;
	unsigned char OrderID;
	float mProxFuze;
	float mAltitude;
	float mSearchArea;
	float mRTG;
	float mManualWidth;
	float mSelecDepth;
	float mTBearing;
	float mTRange;
};

/**
* -- structSetC802				= 20;
*/
struct spSetC802
{
	spCheck pc;
	unsigned short int ShipID;
	unsigned short int mWeaponID;
	unsigned short int mLauncherID;
	unsigned short int mMissileID;
	unsigned short int mMissileNum;
	unsigned char OrderID;
	float mBearing;
	float mRange;
};

/**
* -- structSetC802				= 20;
*/
struct spSetYakhont{
	spCheck pc;
	unsigned short int ShipID;
	unsigned short int mWeaponID;
	unsigned short int mLauncherID;
	unsigned short int mMissileID;
	unsigned short int mMissileNum;
	unsigned char launcher1;
	unsigned char launcher2;
	unsigned char launcher3;
	unsigned char launcher4;
	unsigned char OrderID;
	float mBearing;
	float mRange;
};

/**
* -- structSetTetral				= 21
*/
struct spSetTetral
{
	spCheck pc;
	unsigned short int ShipID;
	unsigned short int mWeaponID; 
	unsigned short int mLauncherID;
	unsigned short int mMissileID;
	unsigned short int mMissileNum;
	unsigned char OrderID;
	float mTargetBearing;
	float mTargetRange;
	float mTargetElev;
};

/**
* -- structSetMistral			= 22
*/
struct spSetMistral
{
	spCheck pc;
	unsigned short int ShipID;
	unsigned short int mWeaponID; 
	unsigned short int mLauncherID;
	unsigned short int mMissileID;
	unsigned short int mMissileNum;
	unsigned char OrderID;
	float mTargetBearing;
	float mTargetRange;
	float mTargetElev;
};

/**
* -- structSetStrela				= 23
*/
struct spSetStrela
{
	spCheck pc;
	unsigned short int ShipID;
	unsigned short int mWeaponID; 
	unsigned short int mLauncherID;
	unsigned short int mMissileID;
	unsigned short int mMissileNum;
	unsigned char OrderID;
	float mTargetBearing;
	float mTargetRange;
	float mTargetElev;
};

struct spSetExocetMM40	 
{
	spCheck pc;
	unsigned short int ShipID;
	unsigned short int mWeaponID; 
	unsigned short int mLauncherID;
	unsigned short int mMissileID;
	unsigned short int mMissileNum;
	unsigned char OrderID;
	
	float mTRange;
	float mTBearing;
	
	unsigned char mAngular_Mode;
	unsigned char mAgility_Mode;
	unsigned char mInitialStep_Mode;

	float mObstacle_Alt;
	float mObstacle_Range;
	float mApproach_Range;
	float mTerminal_Range;

	float mLAngle;
	float mRAngle;
	float mFRange;
	float mNRange;

	unsigned char mMasking_1;
	unsigned char mMasking_2;
	unsigned char mMasking_3;
	unsigned char mMasking_4;
	unsigned char mMasking_5;
	unsigned char mMasking_6;
	unsigned char mMasking_7;
	unsigned char mMasking_8;
	unsigned char mMasking_9;
	unsigned char mMasking_10;
	unsigned char mMasking_11;
	unsigned char mMasking_12;
	unsigned char mMasking_13;
	unsigned char mMasking_14;
	unsigned char mMasking_15;
	unsigned char mMasking_16;
	
	double mSeekerOpenPosX;
	double mSeekerOpenPosY;
	float mSeekerOpenHeading;
};

/**
* -- structCannonSplash		= 64
*/
struct spCannonSplash
{
	spCheck pc;
	unsigned short int mVehicleID;
	unsigned short int mWeaponID;
	unsigned short int mLauncherID;
	double PosX, PosY, PosZ;
};

struct spMessageHandle
{
	spCheck pc;
	unsigned short int MessageID;
	double Cmd1;
	double Cmd2;
	double Cmd3;
	double Cmd4;
};

struct spFindTarget
{
	spCheck pc;
	unsigned short int mVehicleID;
	unsigned short int mWeaponID;
	unsigned short int mLauncherID;
	unsigned short int mMissileID;
	unsigned char isFind;
	unsigned short int mTargetID;
};

//==================== =========================== =========================//  

 
//==================== spPosition =========================// 
const unsigned char structPositionID			= 1;  //  
/**/const unsigned int ORD_SETPOS				= 12; // ...
//==================== spPosition =========================// 

//==================== spOrder =========================//
const unsigned char structOrderID				= 3;  // 
	// const order 
/**/const unsigned int ORD_SHIP_DEL				= 1; // ...
/**/const unsigned int ORD_SHIP_DOWN			= 2; // ...
/**/const unsigned int ORD_ENGINE				= 10; // ...
/**/const unsigned int ORD_NETWORK				= 11;
/**/const unsigned int ORD_THROTTLE				= 21; // ...
/**/const unsigned int ORD_RUDDER  				= 22;
/**/const unsigned int ORD_STOP  				= 23;
/**/const unsigned int ORD_VERRUDDER  			= 24;
/**/const unsigned int ORD_SOUND_MINDIST		= 25;
/**/const unsigned int ORD_SOUND_MAXDIST		= 26;
/**/const unsigned int ORD_SOUND_ROLLOFF		= 27;
/**/const unsigned int ORD_ALTITUDE 			= 29;
/**/const unsigned int ORD_ADDANGLE				= 69;  
/**/const unsigned int ORD_ADDFORCE				= 70;  
/**/const unsigned int ORD_RESETOCEANWAVE		= 71;  
/**/const unsigned int ORD_SET_TARGET_COURSE    = 72;  
	
	///
	const unsigned int ORD_BELL 				= 28;
	    const unsigned int ORD_BELL0			= 0;
		const unsigned int ORD_BELL1			= 1;
		const unsigned int ORD_BELL2 			= 2;
		const unsigned int ORD_BELL3 			= 3;
		const unsigned int ORD_BELL4 			= 4;
		const unsigned int ORD_BELL5 			= 5;
		const unsigned int ORD_BELL6 			= 6;
		const unsigned int ORD_BELL7 			= 7;
		const unsigned int ORD_BELL8 			= 8;
		const unsigned int ORD_BELL9 			= 9;
		const unsigned int ORD_BELL10			= 10;
	///
	const unsigned int ORD_LAMP 				= 30;
		const unsigned int ORD_AnchorLight			= 1;
		const unsigned int ORD_AnchorLightOff		= 2;
		const unsigned int ORD_SternLight			= 3;
		const unsigned int ORD_SternLightOff		= 4;
		const unsigned int ORD_MastheadLight		= 5;
		const unsigned int ORD_MastheadLightOff		= 6;
		const unsigned int ORD_MastheadLight2		= 7;
		const unsigned int ORD_MastheadLight2Off	= 8;
		
		const unsigned int ORD_SpecialLightTop0		= 9;
		const unsigned int ORD_SpecialLightTop1		= 10;
		const unsigned int ORD_SpecialLightTop2		= 11;

		const unsigned int ORD_SpecialLightMid0		= 12;
		const unsigned int ORD_SpecialLightMid1		= 13;
		const unsigned int ORD_SpecialLightMid2		= 14;

		const unsigned int ORD_SpecialLightBot0		= 15;	
		const unsigned int ORD_SpecialLightBot1		= 16;
		const unsigned int ORD_SpecialLightBot2		= 17;

		const unsigned int ORD_OpsDangerLightPair0	= 18;
		const unsigned int ORD_OpsDangerLightPair1	= 19;
		const unsigned int ORD_OpsDangerLightPair2	= 20;

		const unsigned int ORD_SpecialCBD0			= 21;
		const unsigned int ORD_SpecialCBD1			= 22;

		const unsigned int ORD_SpecialRAM0			= 23;
		const unsigned int ORD_SpecialRAM1			= 24;

		const unsigned int ORD_SpecialNUC0			= 25;
		const unsigned int ORD_SpecialNUC1			= 26;

		const unsigned int ORD_PortLight			= 27;
		const unsigned int ORD_PortLightOff			= 28;
		const unsigned int ORD_StarboardLight		= 29;
		const unsigned int ORD_StarboardLightOff	= 30;
	
	//
	const unsigned int ORD_SND_COLLISION			= 31;
		const unsigned int ORD_SND_COLLISION_ON		= 1;
		const unsigned int ORD_SND_COLLISION_OFF	= 2;

	const unsigned int ORD_CAM_BLK 					= 32;

	const unsigned int ORD_SOSOK 					= 33;
		const unsigned int ORD_Sosok_BallL1			= 0;
		const unsigned int ORD_Sosok_BallL2			= 1;
		const unsigned int ORD_Sosok_BallL3			= 2;
		const unsigned int ORD_Sosok_BallR1			= 3;
		const unsigned int ORD_Sosok_BallR2			= 4;
		const unsigned int ORD_Sosok_BallR3			= 5;
		const unsigned int ORD_Sosok_BallC1			= 6;
		const unsigned int ORD_Sosok_BallC3			= 7;
		const unsigned int ORD_Sosok_DiaL1			= 8;
		const unsigned int ORD_Sosok_DiaL2			= 9;
		const unsigned int ORD_Sosok_DiaR1			= 10;
		const unsigned int ORD_Sosok_DiaR2			= 11;
		const unsigned int ORD_Sosok_DiaC2			= 12;
		const unsigned int ORD_Sosok_ConeL			= 13;
		const unsigned int ORD_Sosok_ConeR			= 14;
		const unsigned int ORD_Sosok_DConeL			= 15;
		const unsigned int ORD_Sosok_DConeR			= 16;
		const unsigned int ORD_Sosok_CylL			= 17;
		const unsigned int ORD_Sosok_CylR			= 18;

		const unsigned int ORD_Sosok_BallL1_Off			= 50;
		const unsigned int ORD_Sosok_BallL2_Off			= 51;
		const unsigned int ORD_Sosok_BallL3_Off			= 52;
		const unsigned int ORD_Sosok_BallR1_Off			= 53;
		const unsigned int ORD_Sosok_BallR2_Off			= 54;
		const unsigned int ORD_Sosok_BallR3_Off			= 55;
		const unsigned int ORD_Sosok_BallC1_Off			= 56;
		const unsigned int ORD_Sosok_BallC3_Off			= 57;
		const unsigned int ORD_Sosok_DiaL1_Off			= 58;
		const unsigned int ORD_Sosok_DiaL2_Off			= 59;
		const unsigned int ORD_Sosok_DiaR1_Off			= 60;
		const unsigned int ORD_Sosok_DiaR2_Off			= 61;
		const unsigned int ORD_Sosok_DiaC2_Off			= 62;
		const unsigned int ORD_Sosok_ConeL_Off			= 63;
		const unsigned int ORD_Sosok_ConeR_Off			= 64;
		const unsigned int ORD_Sosok_DConeL_Off			= 65;
		const unsigned int ORD_Sosok_DConeR_Off			= 66;
		const unsigned int ORD_Sosok_CylL_Off			= 67;
		const unsigned int ORD_Sosok_CylR_Off			= 68;

	const unsigned int ORD_SOSOK_ALL_OFF				= 34;

	const unsigned int ORD_SHIPESMOKE    				= 35;
		const unsigned int ORD_SHIPESMOKE_ON			= 1;
		const unsigned int ORD_SHIPESMOKE_OFF			= 2;
		const unsigned int ORD_SUBSMOKE_HALU_ON			= 3;
		const unsigned int ORD_SUBSMOKE_HALU_OFF		= 4;
		const unsigned int ORD_SUBSMOKE_LAMBUNG_ON		= 5;
		const unsigned int ORD_SUBSMOKE_LAMBUNG_OFF		= 6;
		const unsigned int ORD_SUBSMOKE_BURITAN_ON		= 7;
		const unsigned int ORD_SUBSMOKE_BURITAN_OFF		= 8;

 	const unsigned int ORD_SWITCH_WEAPON				= 36;
	    //// on value
		const unsigned int ORD_SWW_Meriam120			= 0;
		const unsigned int ORD_SWW_Meriam76				= 1;
		const unsigned int ORD_SWW_Meriam57				= 2;
		const unsigned int ORD_SWW_Meriam40_1			= 3;
		const unsigned int ORD_SWW_Meriam40_2			= 4;
		const unsigned int ORD_SWW_Meriam40_3			= 5;
		const unsigned int ORD_SWW_Asroc				= 6;
		const unsigned int ORD_SWW_RBU6000L				= 7;
		const unsigned int ORD_SWW_RBU6000R				= 8;
		const unsigned int ORD_SWW_StrelaL				= 9;
		const unsigned int ORD_SWW_StrelaR				= 10;
		const unsigned int ORD_SWW_TetralF				= 11;
		const unsigned int ORD_SWW_TetralB				= 12;
		const unsigned int ORD_SWW_MistralL				= 13;
		const unsigned int ORD_SWW_MistralR  			= 14;
		//// off value
		const unsigned int ORD_SWW_Meriam120_Off		= 50;
		const unsigned int ORD_SWW_Meriam76_Off			= 51;
		const unsigned int ORD_SWW_Meriam57_Off			= 52;
		const unsigned int ORD_SWW_Meriam40_1_Off		= 53;
		const unsigned int ORD_SWW_Meriam40_2_Off		= 54;
		const unsigned int ORD_SWW_Meriam40_3_Off		= 55;
		const unsigned int ORD_SWW_Asroc_Off			= 56;
		const unsigned int ORD_SWW_RBU6000L_Off			= 57;
		const unsigned int ORD_SWW_RBU6000R_Off			= 58;
		const unsigned int ORD_SWW_StrelaL_Off			= 59;
		const unsigned int ORD_SWW_StrelaR_Off			= 60;
		const unsigned int ORD_SWW_TetralF_Off			= 61;
		const unsigned int ORD_SWW_TetralB_Off			= 62;
		const unsigned int ORD_SWW_MistralL_Off			= 63;
		const unsigned int ORD_SWW_MistralR_Off  		= 64;

	const unsigned int ORD_SWITCH_TARGET				= 37;
		//// on value
		const unsigned int ORD_STGT_Normal				= 0;
		const unsigned int ORD_STGT_HitHeavy			= 1;
		const unsigned int ORD_STGT_HitDpn_1			= 2;
		const unsigned int ORD_STGT_HitDpn_2			= 3;
		const unsigned int ORD_STGT_HitTgh_1			= 4;
		const unsigned int ORD_STGT_HitTgh_2			= 5;
		const unsigned int ORD_STGT_HitBlk_1			= 6;
		const unsigned int ORD_STGT_HitBlk_2			= 7;
		const unsigned int ORD_STGT_HitAts_1			= 8;
		const unsigned int ORD_STGT_HitAts_2			= 9;
		const unsigned int ORD_STGT_HitAts_3			= 10;
		const unsigned int ORD_STGT_HitAts_4			= 11;
		const unsigned int ORD_STGT_HitBlkg_1			= 12;

		const unsigned int ORD_STGT_HitKr_7			= 13;
		const unsigned int ORD_STGT_HitKnn_1		= 14;
		const unsigned int ORD_STGT_HitKnn_2		= 15;
		const unsigned int ORD_STGT_HitKnn_3		= 16;
		const unsigned int ORD_STGT_HitKnn_4		= 17;
		const unsigned int ORD_STGT_HitKnn_5		= 18;
		const unsigned int ORD_STGT_HitKnn_6		= 19;
		const unsigned int ORD_STGT_HitKnn_7		= 20;
		const unsigned int ORD_STGT_HitDpn_0		= 21;

		const unsigned int ORD_SGUN_HitKr_1			= 22;
		const unsigned int ORD_SGUN_HitKr_2			= 23;
		const unsigned int ORD_SGUN_HitKr_3			= 24;
		const unsigned int ORD_SGUN_HitKr_4			= 25;
		const unsigned int ORD_SGUN_HitKr_5			= 26;
		const unsigned int ORD_SGUN_HitKr_6			= 27;
		const unsigned int ORD_SGUN_HitKr_7			= 28;
		const unsigned int ORD_SGUN_HitKr_8			= 29;
		const unsigned int ORD_SGUN_HitKr_9			= 30;
		const unsigned int ORD_SGUN_HitKr_10		= 31;
		const unsigned int ORD_SGUN_HitKr_11		= 32;
		const unsigned int ORD_SGUN_HitKr_12		= 33;
		const unsigned int ORD_SGUN_HitKr_13		= 34;
		const unsigned int ORD_SGUN_HitKr_14		= 35;
		const unsigned int ORD_SGUN_HitKr_15		= 36;
		const unsigned int ORD_SGUN_HitKr_16		= 37;
		const unsigned int ORD_SGUN_HitKr_17		= 38;
		const unsigned int ORD_SGUN_HitKr_18		= 39;
		const unsigned int ORD_SGUN_HitKr_19		= 40;
		const unsigned int ORD_SGUN_HitKr_20		= 41;
		const unsigned int ORD_SGUN_HitKnn_1		= 42;
		const unsigned int ORD_SGUN_HitKnn_2		= 43;
		const unsigned int ORD_SGUN_HitKnn_3		= 44;
		const unsigned int ORD_SGUN_HitKnn_4		= 45;
		const unsigned int ORD_SGUN_HitKnn_5		= 46;
		const unsigned int ORD_SGUN_HitKnn_6		= 47;
		const unsigned int ORD_SGUN_HitKnn_7		= 48;
		const unsigned int ORD_SGUN_HitKnn_8		= 49;
		const unsigned int ORD_SGUN_HitKnn_9		= 50;
		const unsigned int ORD_SGUN_HitKnn_10		= 51;
		const unsigned int ORD_SGUN_HitKnn_11		= 52;
		const unsigned int ORD_SGUN_HitKnn_12		= 53;
		const unsigned int ORD_SGUN_HitKnn_13		= 54;
		const unsigned int ORD_SGUN_HitKnn_14		= 55;
		const unsigned int ORD_SGUN_HitKnn_15		= 56;
		const unsigned int ORD_SGUN_HitKnn_16		= 57;
		const unsigned int ORD_SGUN_HitKnn_17		= 58;
		const unsigned int ORD_SGUN_HitKnn_18		= 59;
		const unsigned int ORD_SGUN_HitKnn_19		= 60;
		const unsigned int ORD_SGUN_HitKnn_20		= 61;
		const unsigned int ORD_SGUN_HitAts_1		= 62;
		const unsigned int ORD_SGUN_HitAts_2		= 63;
		const unsigned int ORD_SGUN_HitAts_3		= 64;
		const unsigned int ORD_SGUN_HitAts_4		= 65;
		const unsigned int ORD_SGUN_HitAts_5		= 66;
		const unsigned int ORD_SGUN_HitAts_6		= 67;
		const unsigned int ORD_SGUN_HitAts_7		= 68;
		const unsigned int ORD_SGUN_HitAts_8		= 69;
		const unsigned int ORD_SGUN_HitAts_9		= 70;
		const unsigned int ORD_SGUN_HitAts_10		= 71;
		const unsigned int ORD_SGUN_HitAts_11		= 72;
		const unsigned int ORD_SGUN_HitAts_12		= 73;
		const unsigned int ORD_SGUN_HitAts_13		= 74;
		const unsigned int ORD_SGUN_HitAts_14		= 75;
		const unsigned int ORD_SGUN_HitAts_15		= 76;
		const unsigned int ORD_SGUN_HitAts_16		= 77;
		const unsigned int ORD_SGUN_HitAts_17		= 78;
		const unsigned int ORD_SGUN_HitAts_18		= 79;
		const unsigned int ORD_SGUN_HitAts_19		= 80;
		const unsigned int ORD_SGUN_HitAts_20		= 81;
		const unsigned int ORD_SGUN_HitAts_21		= 82;
		const unsigned int ORD_SGUN_HitAts_22		= 83;		


	const unsigned int ORD_ENVI 						= 54;
		const unsigned int ORD_OCEAN_ABOVE_FOG_HEIGHT_INC	 = 1;    //Increase fog height
		const unsigned int ORD_OCEAN_ABOVE_FOG_HEIGHT_DEC	 = 2;    //Decrease fog height
		const unsigned int ORD_OCEAN_ABOVE_FOG_HEIGHT_CHANGE = 3;    //Change fog height
		const unsigned int ORD_OCEAN_ABOVE_FOG_COLOR         = 4;    //Change fog color
	const unsigned int ORD_UPDATE_OCEAN 				= 55;
    const unsigned int ORD_SEA_STATE                	= 56;  
		const unsigned int ORD_OCEAN_WAVE_SCALE_INC	         = 5;    //Increase wave scale
		const unsigned int ORD_OCEAN_WAVE_SCALE_DEC	         = 6;    //Decrease wave scale
		const unsigned int ORD_OCEAN_WAVE_SCALE_CHANGE       = 7;    //Change wave scale
		const unsigned int ORD_OCEAN_WIND_SPEED_INC	         = 8;    //Increase wind speed
		const unsigned int ORD_OCEAN_WIND_SPEED_DEC	         = 9;    //Decrease wind speed
		const unsigned int ORD_OCEAN_WIND_SPEED_CHANGE       = 10;   //Change wind speed
		const unsigned int ORD_OCEAN_WIND_LENGTH_INC         = 11;   //Increase wind length (scalar length of mWindDirection)
		const unsigned int ORD_OCEAN_WIND_LENGTH_DEC         = 12;   //Decrease wind length (scalar length of mWindDirection)
		const unsigned int ORD_OCEAN_WIND_LENGTH_CHANGE      = 13;   //Change wind length (scalar length of mWindDirection)
		const unsigned int ORD_OCEAN_SEA_STATE_INC           = 14;   //Increase the sea state
		const unsigned int ORD_OCEAN_SEA_STATE_DEC           = 15;   //Decrease the sea state
		const unsigned int ORD_OCEAN_SEA_STATE_CHANGE        = 16;   //Change the sea state
	const unsigned int ORD_HUMIDITY                    = 57;
	const unsigned int ORD_BAROPRESSURE                = 58;
	const unsigned int ORD_TEMPERATURE                 = 59;
	const unsigned int ORD_CURSPEED                    = 60;
	const unsigned int ORD_WINDSPEED                   = 61;
	const unsigned int ORD_WINDDIRECTION               = 62;
	const unsigned int ORD_CURDIRECTION                = 63;

	

//==================== spOrder =========================//

//==================== spSetExocet =========================//
//const unsigned char structSetExocet				= 4;	// paket id
//	const unsigned int ORD_EXOCET_FIRE     		= 1;
//	const unsigned int ORD_HARPOON        		= 2;
//==================== spSetExocet =========================//

//==================== spSetExocet =========================//

//==================== spSetAsrock =========================//
const unsigned char structSetAsrock				= 6;	// paket id
	const unsigned int ORD_ASROCK_ASSIGNED    	= 1; // ...
	const unsigned int ORD_ASROCK_DEASSIGNED   	= 2;
	const unsigned int ORD_ASROCK				= 3; // Asrock Fire
	const unsigned int ORD_ASROCK_RELOAD		= 4;
	const unsigned int ORD_ASROCK_STATUS_ON		= 5;
	const unsigned int ORD_ASROCK_STATUS_OFF	= 6;
//==================== spSetAsrock =========================//

//==================== spSetCannon =========================//
const unsigned char structSetCannon				= 7;	// paket id
/**/const unsigned int ORD_CANNON_LR   			= 1; // left-right with move rate
/**/const unsigned int ORD_CANNON_UD   	    	= 2; // up-down with move rate
/**/const unsigned int ORD_CANNON_F   			= 3; // fire
/**/const unsigned int ORD_CANNON_DIRECT_LR     = 4; // from Joystick
/**/const unsigned int ORD_CANNON_DIRECT_UD     = 5; // from Joystick
/**/const unsigned int ORD_CANNON_DIRECT_F      = 6; // fire from TDS
/**/
/**///Nando Added
/**/const unsigned int ORD_CANNON_START_F		= 7; // Start Fire
/**/const unsigned int ORD_CANNON_STOP_F		= 8; // Stop Fire
/**/const unsigned int ORD_CANNON_ASSIGNED		= 9; // Assign Target
/**/const unsigned int ORD_CANNON_DEASSIGNED	= 10; // Deassign Target;
/**/const unsigned int ORD_CANNON_AUTOCORREC	= 11; // Correction Elev n Bearing
/**/const unsigned int ORD_CANNON_ADD_DATA      = 12;

//  [5/24/2013 DID RKT2]
/**/const unsigned int ORD_CANNON_ON		    = 13;
/**/const unsigned int ORD_CANNON_OFF		    = 14;
/**/const unsigned int ORD_CANNON_UNLOCK	    = 15;
/**/const unsigned int ORD_CANNON_LOCK		    = 16;
//==================== spSetCannon =========================//
//==================== spSetCannon =========================//

//====================         =========================//
//const unsigned char structSetTorpedoMK46		= 8;	// paket id
//	const unsigned int ORD_TORPEDOMK46_FIRED	= 1 ;
//====================         =========================//

//==================== spSetTorpedoSUT=========================//
const unsigned char structSetTorpedoSUT 			= 9;	// paket id
	const unsigned int ORD_TORPEDOSUT_FIRED			= 1 ;	
	const unsigned int ORD_TORPEDOSUT_HANDLE		= 2 ;
	const unsigned int ORD_TORPEDOSUT_HOMING		= 3 ;
	const unsigned int ORD_TORPEDOSUT_SEARCH		= 4 ;
	const unsigned int ORD_TORPEDOSUT_MANUAL		= 5 ;
	const unsigned int ORD_TORPEDOSUT_SHUTDOWN		= 6 ;
	const unsigned int ORD_TORPEDOSUT_RELOAD		= 7 ;
	const unsigned int ORD_TORPEDOSUT_STATUS_ON		= 8 ;
	const unsigned int ORD_TORPEDOSUT_STATUS_OFF	= 9 ;
	const unsigned int ORD_TORPEDOSUT_DELETE		= 10 ;
	const unsigned int ORD_TORPEDOSUT_TARGETSEARCH	= 11 ;
//==================== spSetTorpedoSUT=========================//

//==================== spSetRBU=========================//
const unsigned char structSetRBU				= 19;	// paket id
	const unsigned int ORD_RBU_ASSIGNED    	    = 1; // ...
	const unsigned int ORD_RBU_DEASSIGNED   	= 2;
	const unsigned int ORD_RBU_FIRE 			= 3; // RBU Fire
	const unsigned int ORD_RBU_LOADING			= 4; // RBU Loading
	const unsigned int ORD_RBU_AUTO				= 5; // RBU Auto
	const unsigned int ORD_RBU_STARTF			= 6; // RBU Start F
	const unsigned int ORD_RBU_STOPF			= 7; // RBU Stop F
	const unsigned int ORD_RBU_STATUS_ON		= 8;
	const unsigned int ORD_RBU_STATUS_OFF		= 9;
//==================== spSetRBU=========================//

//==================== spSetTorpedoA244=========================//
const unsigned char structSetTorpedo			= 57;	// paket id
	const unsigned int ORD_TORPEDO_FIRED 		= 1; // Torpedo Fire
	const unsigned int ORD_TORPEDO_HANDLE		= 2 ;
	const unsigned int ORD_TORPEDO_RELOAD		= 3 ;
	const unsigned int ORD_TORPEDO_STATUS_ON	= 4 ;
	const unsigned int ORD_TORPEDO_STATUS_OFF	= 5 ;
//==================== spSetTorpedoA244=========================//

//==================== spSetC802=========================/
const unsigned char structSetC802				= 20;
	const unsigned int ORD_C802_FIRE    	    = 1; // ...
	const unsigned int ORD_C802_RELEASE 	    = 2; // ...
	const unsigned int ORD_C802_RELOAD			= 3; // ...
	const unsigned int ORD_C802_STATUS_ON		= 4; // ...
	const unsigned int ORD_C802_STATUS_OFF		= 5; // ...
//==================== spSetC802=========================/

//==================== spSetTetral=========================/
const unsigned char structSetTetral				= 21;
	const unsigned int ORD_TETRAL_FIRE    	    = 1; // ...
	const unsigned int ORD_TETRAL_ASSIGNED    	= 2;
	const unsigned int ORD_TETRAL_DEASSIGNED    = 3;
	const unsigned int ORD_TETRAL		   	    = 4;
	const unsigned int ORD_TETRAL_DIRECT_LR     = 5; // from Joystick
	const unsigned int ORD_TETRAL_DIRECT_UD     = 6; // from Joystick
	const unsigned int ORD_TETRAL_DIRECT_F      = 7; // fire from TDS
	const unsigned int ORD_TETRAL_RELOAD        = 8; //  [4/16/2013 DID RKT2]
	const unsigned int ORD_TETRAL_STATUS_ON     = 9;
	const unsigned int ORD_TETRAL_STATUS_OFF    = 10;
//==================== spSetTetral=========================/

//==================== spSetMistral=========================/
const unsigned char structSetMistral			 = 22;
	const unsigned int ORD_MISTRAL_FIRE    	     = 1; // ...
	const unsigned int ORD_MISTRAL_ASSIGNED    	 = 2;
	const unsigned int ORD_MISTRAL_DEASSIGNED    = 3;
	const unsigned int ORD_MISTRAL		   	     = 4;
	const unsigned int ORD_MISTRAL_DIRECT_LR     = 5; // from Joystick
	const unsigned int ORD_MISTRAL_DIRECT_UD     = 6; // from Joystick
	const unsigned int ORD_MISTRAL_DIRECT_F      = 7; // fire from TDS
	const unsigned int ORD_MISTRAL_RELOAD		 = 8; //  [4/16/2013 DID RKT2]
	const unsigned int ORD_MISTRAL_STATUS_ON	 = 9;
	const unsigned int ORD_MISTRAL_STATUS_OFF	 = 10;
	const unsigned int ORD_MISTRAL_STATUS_UNLOCK = 11;
	const unsigned int ORD_MISTRAL_STATUS_LOCK	 = 12;
//==================== spSetMistral=========================/

//==================== spSetStrela=========================/
const unsigned char structSetStrela				= 23;
	const unsigned int ORD_STRELA_FIRE    	    = 1; // ...
	const unsigned int ORD_STRELA_ASSIGNED    	= 2;
	const unsigned int ORD_STRELA_DEASSIGNED    = 3;
	const unsigned int ORD_STRELA		   	    = 4;
	const unsigned int ORD_STRELA_DIRECT_LR     = 5; // from Joystick
	const unsigned int ORD_STRELA_DIRECT_UD     = 6; // from Joystick
	const unsigned int ORD_STRELA_DIRECT_F      = 7; // fire from TDS
	const unsigned int ORD_STRELA_RELOAD		= 8; //  [4/16/2013 DID RKT2]
	const unsigned int ORD_STRELA_STATUS_ON		= 9;
	const unsigned int ORD_STRELA_STATUS_OFF	= 10;
	const unsigned int ORD_STRELA_STATUS_UNLOCK	= 11;
	const unsigned int ORD_STRELA_STATUS_LOCK	= 12;
//==================== spSetStrela=========================/

//==================== spSetYakhont=========================/
const unsigned char structSetYakhont			= 24;
	const unsigned int ORD_YAKHONT_FIRE    	    = 1; // ...
	const unsigned int ORD_YAKHONT_RELEASE 	    = 2; // ...
	const unsigned int ORD_YAKHONT_RELOAD 	    = 3; // ...
	const unsigned int ORD_YAKHONT_STATUS_ON    = 4; // ...
	const unsigned int ORD_YAKHONT_STATUS_OFF   = 5; // ...
//==================== spSetYakhont=========================/

//==================== spSetExocetMM40=========================/
const unsigned char structSetExocetMM40			= 27;
	const unsigned int ORD_MM40_FIRE    	    = 1; // ...
	const unsigned int ORD_MM40_RELOAD    	    = 2; // ...
	const unsigned int ORD_MM40_STATUS_ON  	    = 3; // ...
	const unsigned int ORD_MM40_STATUS_OFF 	    = 4; // ...
//==================== spSetExocetMM40=========================/

//==================== spMissilePos=========================/
const unsigned char structMissilePos			= 50;	// paket id
	const unsigned int ST_MISSILE_RUN			= 1; // ...
	const unsigned int ST_MISSILE_HIT			= 2; // ...
	const unsigned int ST_MISSILE_DEL			= 3; // ...
	const unsigned int ST_MISSILE_EXPLODE    	= 4; // ...
	const unsigned int ST_MISSILE_LOADED   		= 5; // missile loaded but hasn't fire [5/1/2013 DID RKT2]
	const unsigned int ST_MISSILE_UNLOCK		= 6; //  [7/2/2013 DID RKT2]
	const unsigned int ST_MISSILE_LOCK			= 7; //  [7/2/2013 DID RKT2]
//==================== spMissilePos=========================/
	
//==================== spActorsController=========================/
const unsigned char structCreateAR				= 51; // create actor runtime // paket id

	const unsigned int STATE_AR_CLEAR			= 1;
	const unsigned int STATE_AR_DEL  			= 2;
	const unsigned int STATE_AR_CREATE			= 3;

	const unsigned int TIPE_AR_SHIP 			= 1;
	const unsigned int TIPE_AR_SUBMARINE		= 2;
	const unsigned int TIPE_AR_HELICOPTER		= 3; //eka-26012012
	const unsigned int TIPE_AR_AIRCRAFT			= 4; // eka [6/18/2012 DID RKT2]
	
	const unsigned int TIPE_AR_LAUNCHER 		= 11;

	const unsigned int TIPE_AR_MISSILE 			= 12;
	/*
	const unsigned int TIPE_AR_LAUNCHER_ASROCK	= 11;
	const unsigned int TIPE_AR_LAUNCHER_RBU 	= 12;
	const unsigned int TIPE_AR_LAUNCHER_EXOCET	= 13; //eka-251111
	const unsigned int TIPE_AR_LAUNCHER_SUT 	= 14; //eka-251111
	const unsigned int TIPE_AR_LAUNCHER_A244	= 15; //eka-251111
	const unsigned int TIPE_AR_LAUNCHER_CANNON 	= 16;

	const unsigned int TIPE_AR_MISSILE_TORP_SUT	= 21;
	const unsigned int TIPE_AR_MISSILE_EXOCET  	= 22;
	const unsigned int TIPE_AR_MISSILE_ASROCK  	= 23;
	const unsigned int TIPE_AR_MISSILE_RBU  	= 24;
	const unsigned int TIPE_AR_MISSILE_TORPEDO 	= 25; //EKA-031111
	const unsigned int TIPE_AR_MISSILE_C802 	= 26;  
	const unsigned int TIPE_AR_MISSILE_TETRAL 	= 27; //EKA-060312
	const unsigned int TIPE_AR_MISSILE_MISTRAL	= 28; //EKA-060312
	const unsigned int TIPE_AR_MISSILE_STRELA 	= 29; //EKA-060312
	*/

	const unsigned int TIPE_MISC_OJK			= 50;
		const unsigned int ORD_MISC_MODEL_1		= 1;
		const unsigned int ORD_MISC_MODEL_2		= 2;
		const unsigned int ORD_MISC_MODEL_3		= 3;
	const unsigned int TIPE_MISC_OLL			= 51;
		const unsigned int ORD_MISC_MODEL_4		= 4;
		const unsigned int ORD_MISC_MODEL_5		= 5;
		const unsigned int ORD_MISC_MODEL_6		= 6;
		const unsigned int ORD_MISC_CLEAR		= 1;
		const unsigned int ORD_MISC_DEL			= 2;
		const unsigned int ORD_MISC_CREATE		= 3;
	const unsigned int TIPE_MISC_RANJAU			= 52;
		const unsigned int ORD_RANJAU_CLEAR		= 1;
		const unsigned int ORD_RANJAU_DEL		= 2;
		const unsigned int ORD_RANJAU_CREATE	= 3;
//==================== spActorsController=========================/

//==================== spUtilityTools=========================/
const unsigned char structUtilityAndTools		= 53;	// paket id
    const unsigned int TIPE_UTIL_CAM_OBSERVER	= 1;
	const unsigned int TIPE_UTIL_CAM_REQUEST	= 2;
	const unsigned int TIPE_UTIL_RUN_PROCESS_MESSAGE	= 3; // - enable all process message [7/21/2014 EKA]
		const unsigned int ORD_UTIL_CAMOBS_UP	= 1;  // up
		const unsigned int ORD_UTIL_CAMOBS_FR	= 2;  // front
		const unsigned int ORD_UTIL_CAMOBS_BK	= 3;  // back 
		const unsigned int ORD_UTIL_CAMOBS_LF	= 4;  // left
		const unsigned int ORD_UTIL_CAMOBS_RG	= 5;  // right

		const unsigned int ORD_UTIL_CAMOBS_MOVE_UP	= 11 ;
		const unsigned int ORD_UTIL_CAMOBS_MOVE_DW	= 12 ;
		const unsigned int ORD_UTIL_CAMOBS_MOVE_FR	= 13 ;
		const unsigned int ORD_UTIL_CAMOBS_MOVE_BK	= 14 ;
		const unsigned int ORD_UTIL_CAMOBS_MOVE_LF	= 15 ;
		const unsigned int ORD_UTIL_CAMOBS_MOVE_RG	= 16 ;

		const unsigned int ORD_UTIL_CAMOBS_ROT_UP	= 21 ;
		const unsigned int ORD_UTIL_CAMOBS_ROT_DW	= 22 ;
		const unsigned int ORD_UTIL_CAMOBS_ROT_LF	= 23 ;
		const unsigned int ORD_UTIL_CAMOBS_ROT_RG	= 24 ;

		const unsigned int ORD_UTIL_CAMOBS_LOCK		= 31;  // lock
		const unsigned int ORD_UTIL_CAMOBS_ULOCK	= 32;  // unlock
		
        //Off Move
        const unsigned int ORD_UTIL_CAMOBS_MOVE_UP_OFF = 41 ;
        const unsigned int ORD_UTIL_CAMOBS_MOVE_DW_OFF = 42 ;
        const unsigned int ORD_UTIL_CAMOBS_MOVE_FR_OFF = 43 ;
        const unsigned int ORD_UTIL_CAMOBS_MOVE_BK_OFF = 44 ;
        const unsigned int ORD_UTIL_CAMOBS_MOVE_LF_OFF = 45 ;
        const unsigned int ORD_UTIL_CAMOBS_MOVE_RG_OFF = 46 ;

        const unsigned int ORD_UTIL_CAMOBS_ROT_UP_OFF = 51 ;
        const unsigned int ORD_UTIL_CAMOBS_ROT_DW_OFF = 52 ;
        const unsigned int ORD_UTIL_CAMOBS_ROT_LF_OFF = 53 ;
        const unsigned int ORD_UTIL_CAMOBS_ROT_RG_OFF = 54 ;


    const unsigned int TIPE_UTIL_PAUSE_GAME			= 2; //  
    
    const unsigned int TIPE_UTIL_CAMERA_INPUTS		= 3; //  

	const unsigned int TIPE_UTIL_SHIP_STATUS   		= 10; 
	const unsigned int TIPE_UTIL_MISSILE_STATUS   	= 20;  
	const unsigned int TIPE_UTIL_MISSILE_EXPLODE	= 21;
	const unsigned int TIPE_UTIL_SPOUT_EXPLODE		= 22;
	const unsigned int TIPE_UTIL_MISSILE_FINDTARGET	= 23;
	const unsigned int TIPE_UTIL_TRAC2D				= 24;

	const unsigned int TIPE_UTIL_APP_OBSERVER     	= 31;  
	    const unsigned int ORD_UTIL_APP_OBSERVER_REQUEST	= 1; // ...
		const unsigned int ORD_UTIL_APP_OBSERVER_CONFIRM	= 2; // ...
		const unsigned int ORD_UTIL_APP_OBSERVER_APPLY   	= 3; // ...
			const unsigned int ORD_UTIL_APP_OBSERVER_1		= 1; // ...
			const unsigned int ORD_UTIL_APP_OBSERVER_2		= 2; // ...
			const unsigned int ORD_UTIL_APP_OBSERVER_3		= 3; // ...
			const unsigned int ORD_UTIL_APP_OBSERVER_4		= 4; // ...
	const unsigned int TIPE_UTIL_EVENT_EXPLODE   	= 41;  

	///---- utility player 
	const unsigned int TIPE_UTIL_PLAYER_SETTING   		= 51;

	/**/const unsigned int PLAYER_SET_BASE     			= 0;
	/*----*/const unsigned int SET_BASE_KEYBOARD    	= 1;
	/*--------*/const unsigned int SET_BASE_KEY_ON      = 1;
	/*----*/const unsigned int SET_BASE_UNLOCK  		= 2;

	/**/const unsigned int PLAYER_SET_OBSERVER     		= 1;
	/*----*/const unsigned int SET_OBS_VHCFOCUS   		= 1;

	/* Versi 1*/
	/**/const unsigned int PLAYER_SET_ATTACH_SHIP  		= 2;
	/**/const unsigned int PLAYER_SET_ATTACH_LAUNCHER	= 3;
	/**/const unsigned int PLAYER_SET_ATTACH_MISSILE	= 4;
	/**/const unsigned int PLAYER_SET_LOCK_OBJECT		= 5;
	/**/const unsigned int PLAYER_SET_FIRING_LOCK		= 6;

	/* Versi 2*/
	/**/const unsigned int PLAYER_SET_ATTACH_SHIP2  	= 10;
	/**/const unsigned int PLAYER_SET_ATTACH_LAUNCHER2	= 11;
	/**/const unsigned int PLAYER_SET_ATTACH_MISSILE2	= 12;
	/**/const unsigned int PLAYER_SET_LOCK_OBJECT2		= 13;
	/**/const unsigned int PLAYER_SET_FIRING_LOCK2		= 14;

	/*----*/const unsigned int OBJECT_SURFACE		= 1;
	/*----*/const unsigned int OBJECT_SUBSURFACE	= 2;
	/*----*/const unsigned int OBJECT_AIR			= 3;
	/*----*/const unsigned int OBJECT_WEAPON		= 4;

	/*----*/const unsigned int LOCK_SIDE_DEFAULT	= 0;
	/*----*/const unsigned int LOCK_SIDE_LEFT		= 1;
	/*----*/const unsigned int LOCK_SIDE_RIGHT		= 2;
	/*----*/const unsigned int LOCK_SIDE_FRONT		= 3;
	/*----*/const unsigned int LOCK_SIDE_BACK		= 4;
	/*----*/const unsigned int LOCK_SIDE_TOP		= 5;
	const unsigned int TIPE_UTIL_PLAYER_EVENT  			= 52;
	/**/const unsigned int IS_PLAYER_STOP_ALL    		= 0;
	/**/const unsigned int IS_PLAYER_MOVE_OFF     		= 1;
	/**/const unsigned int IS_PLAYER_MOVE_ON     		= 2;
	/*----*/const unsigned int MOVE_PLAYER_FORWARD  = 1;
	/*----*/const unsigned int MOVE_PLAYER_BACK		= 2;
	/*----*/const unsigned int MOVE_PLAYER_LEFT		= 3;
	/*----*/const unsigned int MOVE_PLAYER_RIGHT	= 4;
	/*----*/const unsigned int MOVE_PLAYER_UP		= 5;
	/*----*/const unsigned int MOVE_PLAYER_DOWN 	= 6;
	/**/const unsigned int IS_PLAYER_ROTATE_OFF    		= 3; 
	/**/const unsigned int IS_PLAYER_ROTATE_ON     		= 4;
	/*----*/const unsigned int ROTATE_PLAYER_UP		= 1;
	/*----*/const unsigned int ROTATE_PLAYER_DOWN	= 2;
	/*----*/const unsigned int ROTATE_PLAYER_LEFT	= 3;
	/*----*/const unsigned int ROTATE_PLAYER_RIGHT	= 4;

	///---- utility player 
	
//==================== spUtilityTools=========================/

//==================== spDatabaseEvent=========================/
const unsigned char structSetDatabaseEvent			= 58;	// paket id
    const unsigned int ORD_DBE_TEST					= 1; //  
		const unsigned int ORD_DBE_TEST_SHIP_LIST	= 1; //  
		const unsigned int ORD_DBE_TEST_WEAPON_LIST	= 2 ;
	const unsigned int ORD_DBE_ADMIN				= 2; // 
		const unsigned int ORD_DBE_ADMIN_CONNECT	= 1; //  
		const unsigned int ORD_DBE_ADMIN_DISCONNECT	= 2 ;
//==================== spDatabaseEvent=========================/

//==================== spCannonSplash=========================/
const unsigned char structSetCannonSplash			= 64;
//==================== spCannonSplash=========================/

//==================== spFindTarget =========================/
const unsigned char structSetFindTarget				= 82;
//==================== spFindTarget=========================/
const unsigned char structSetMessageHandling        = 87;