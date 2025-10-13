#ifndef APP_UTILITY_FUNCTIONS
#define APP_UTILITY_FUNCTIONS

#ifdef USE_VLD
#include <vld.h>
#endif

#include <dtCore/transform.h>
#include <osg/Math>
#include <osg/MatrixTransform>
#include <osgSim/DOFTransform>
#include <iostream>
#include "../didCommon/BaseConstant.h"

const float GRAVITY							= 9.8f;	 //meters per second^2
const float yardsPerNM						= 2000.0f;
const float secsPerHour						= 3600.0f;
const float metersPerKnotPerSecond			= 0.51283f;

const double c_Degree_To_NauticalMile		= 60.0;
const double c_NauticalMile_To_Degree		= 1.0/60.0;

const double c_NauticalMiles_To_Meter		= 1852.0;
const double c_Meter_To_NauticalMiles		= 1.0/1852.0;

const double c_NauticalMile_To_Feet			= 6076.131;

const double c_MilliSecondToHour			= 0.001 / 3600.0;
const double c_HourToMilliSecond			= 3600000.0;

const double c_MilliSecondToSecond			= 0.001;
const double c_SecondToMilliSecond			= 1000.0;

const double c_Meter_To_Feet				= 3.2808399;
const double c_Feet_To_Meter				= 1.0/ c_Meter_To_Feet;

const double c_NauticalMiles_To_Yard		= 2025.0;
const double c_Yard_To_NauticalMiles		= 1.0f/2025.0;

const double c_NauticalMile_To_Fathom		=  1012.68591;
const double c_Fathom_To_NauticalMile		=  1.0/1012.68591;

const double c_Kiloyards_To_Meter			= 914.4;

const double Pi   = osg::PI;
const double c_2_Pi = 2.0 * Pi;
const double c_180_per_Pi					= 180.0 / Pi;
const double Pi_per_180						= Pi / 180.0;

const double c_RadToDeg						= c_180_per_Pi;
const double c_DegToRad						= Pi_per_180;

const double MinZero						= 0.000000001f;       // lebih kecil dari  ini dianggap 0.0;

const double SPEED_OF_LIGHT					= 299792460.0f  ;  // m per s
const double SPEED_OF_SOUND_IN_SEA			= 1500.0f;  // (approx) m per s


//--constant DOF Name

//////////////////////////////////////////////////////////////////////////
const unsigned int IDX_STGT_Normal 				= 0;
const unsigned int IDX_STGT_HitHeavy			= 1;
const unsigned int IDX_STGT_HitDpn_1			= 2;
const unsigned int IDX_STGT_HitDpn_2			= 3;
const unsigned int IDX_STGT_HitTgh_1			= 4;
const unsigned int IDX_STGT_HitTgh_2			= 5;
const unsigned int IDX_STGT_HitBlk_1			= 6;
const unsigned int IDX_STGT_HitBlk_2			= 7;
const unsigned int IDX_STGT_HitAts_1			= 8;
const unsigned int IDX_STGT_HitAts_2			= 9;
const unsigned int IDX_STGT_HitAts_3			= 10;
const unsigned int IDX_STGT_HitAts_4			= 11;
const unsigned int IDX_STGT_HitBlkg_1			= 12;

const unsigned int IDX_STGT_HitKr_7				= 13;
const unsigned int IDX_STGT_HitKnn_1			= 14;
const unsigned int IDX_STGT_HitKnn_2			= 15;
const unsigned int IDX_STGT_HitKnn_3			= 16;
const unsigned int IDX_STGT_HitKnn_4			= 17;
const unsigned int IDX_STGT_HitKnn_5			= 18;
const unsigned int IDX_STGT_HitKnn_6			= 19;
const unsigned int IDX_STGT_HitKnn_7			= 20;
const unsigned int IDX_STGT_HitDpn_0			= 21;

const unsigned int IDX_SGUN_HitKiri_1			= 22;
const unsigned int IDX_SGUN_HitKiri_2			= 23;
const unsigned int IDX_SGUN_HitKiri_3			= 24;
const unsigned int IDX_SGUN_HitKiri_4			= 25;
const unsigned int IDX_SGUN_HitKiri_5			= 26;
const unsigned int IDX_SGUN_HitKiri_6			= 27;
const unsigned int IDX_SGUN_HitKiri_7			= 28;
const unsigned int IDX_SGUN_HitKiri_8			= 29;
const unsigned int IDX_SGUN_HitKiri_9			= 30;
const unsigned int IDX_SGUN_HitKiri_10			= 31;
const unsigned int IDX_SGUN_HitKiri_11			= 32;
const unsigned int IDX_SGUN_HitKiri_12			= 33;
const unsigned int IDX_SGUN_HitKiri_13			= 34;
const unsigned int IDX_SGUN_HitKiri_14			= 35;
const unsigned int IDX_SGUN_HitKiri_15			= 36;
const unsigned int IDX_SGUN_HitKiri_16			= 37;
const unsigned int IDX_SGUN_HitKiri_17			= 38;
const unsigned int IDX_SGUN_HitKiri_18			= 39;
const unsigned int IDX_SGUN_HitKiri_19			= 40;
const unsigned int IDX_SGUN_HitKiri_20			= 41;
const unsigned int IDX_SGUN_HitKnn_1			= 42;
const unsigned int IDX_SGUN_HitKnn_2			= 43;
const unsigned int IDX_SGUN_HitKnn_3			= 44;
const unsigned int IDX_SGUN_HitKnn_4			= 45;
const unsigned int IDX_SGUN_HitKnn_5			= 46;
const unsigned int IDX_SGUN_HitKnn_6			= 47;
const unsigned int IDX_SGUN_HitKnn_7			= 48;
const unsigned int IDX_SGUN_HitKnn_8			= 49;
const unsigned int IDX_SGUN_HitKnn_9			= 50;
const unsigned int IDX_SGUN_HitKnn_10			= 51;
const unsigned int IDX_SGUN_HitKnn_11			= 52;
const unsigned int IDX_SGUN_HitKnn_12			= 53;
const unsigned int IDX_SGUN_HitKnn_13			= 54;
const unsigned int IDX_SGUN_HitKnn_14			= 55;
const unsigned int IDX_SGUN_HitKnn_15			= 56;
const unsigned int IDX_SGUN_HitKnn_16			= 57;
const unsigned int IDX_SGUN_HitKnn_17			= 58;
const unsigned int IDX_SGUN_HitKnn_18			= 59;
const unsigned int IDX_SGUN_HitKnn_19			= 60;
const unsigned int IDX_SGUN_HitKnn_20			= 61;
const unsigned int IDX_SGUN_HitAts_1			= 62;
const unsigned int IDX_SGUN_HitAts_2			= 63;
const unsigned int IDX_SGUN_HitAts_3			= 64;
const unsigned int IDX_SGUN_HitAts_4			= 65;
const unsigned int IDX_SGUN_HitAts_5			= 66;
const unsigned int IDX_SGUN_HitAts_6			= 67;
const unsigned int IDX_SGUN_HitAts_7			= 68;
const unsigned int IDX_SGUN_HitAts_8			= 69;
const unsigned int IDX_SGUN_HitAts_9			= 70;
const unsigned int IDX_SGUN_HitAts_10			= 71;
const unsigned int IDX_SGUN_HitAts_11			= 72;
const unsigned int IDX_SGUN_HitAts_12			= 73;
const unsigned int IDX_SGUN_HitAts_13			= 74;
const unsigned int IDX_SGUN_HitAts_14			= 75;
const unsigned int IDX_SGUN_HitAts_15			= 76;
const unsigned int IDX_SGUN_HitAts_16			= 77;
const unsigned int IDX_SGUN_HitAts_17			= 78;
const unsigned int IDX_SGUN_HitAts_18			= 79;
const unsigned int IDX_SGUN_HitAts_19			= 80;
const unsigned int IDX_SGUN_HitAts_20			= 81;
const unsigned int IDX_SGUN_HitAts_21			= 82;
const unsigned int IDX_SGUN_HitAts_22			= 83;
//////////////////////////////////////////////////////////////////////////

//--constant DOF Name
const std::string C_DOF_NAME_CANNON_BASE_120	    = "DOF_Meriam120Base";
const std::string C_DOF_NAME_CANNON_BASE_76  	    = "DOF_Meriam76Base";
const std::string C_DOF_NAME_CANNON_BASE_57  	    = "DOF_Meriam57Base";
const std::string C_DOF_NAME_CANNON_BASE_40_1	    = "DOF_Meriam40Base1";
const std::string C_DOF_NAME_CANNON_BASE_40_2       = "DOF_Meriam40Base2";
const std::string C_DOF_NAME_CANNON_BASE_40_3       = "DOF_Meriam40Base3";

const std::string C_DOF_NAME_CANNON_LAUNCHER_120	= "DOF_Meriam120Launcher";
const std::string C_DOF_NAME_CANNON_LAUNCHER_76 	= "DOF_Meriam76Launcher";
const std::string C_DOF_NAME_CANNON_LAUNCHER_57		= "DOF_Meriam57Launcher";
const std::string C_DOF_NAME_CANNON_LAUNCHER_40_1	= "DOF_Meriam40Launcher1";
const std::string C_DOF_NAME_CANNON_LAUNCHER_40_2	= "DOF_Meriam40Launcher2";
const std::string C_DOF_NAME_CANNON_LAUNCHER_40_3	= "DOF_Meriam40Launcher3";

const std::string C_DOF_NAME_ASROC_LAUNCHER_BASE	= "DOF_AsrocBase";
const std::string C_DOF_NAME_ASROC_LAUNCHER_SPOUT	= "DOF_AsrocLauncher";
const std::string C_DOF_NAME_ASROC_MISSILE_L		= "DOF_AsrocMissileL";
const std::string C_DOF_NAME_ASROC_MISSILE_R		= "DOF_AsrocMissileR";

const std::string C_DOF_NAME_A244_MISSILE_L1		= "DOF_TorpedoL1";
const std::string C_DOF_NAME_A244_MISSILE_L2		= "DOF_TorpedoL2";
const std::string C_DOF_NAME_A244_MISSILE_R1		= "DOF_TorpedoR1";
const std::string C_DOF_NAME_A244_MISSILE_R2		= "DOF_TorpedoR2";
const std::string C_DOF_NAME_A244_MISSILE_L3		= "DOF_TorpedoL3";
const std::string C_DOF_NAME_A244_MISSILE_R3		= "DOF_TorpedoR3";

const std::string C_DOF_NAME_TSUT_MISSILE_L			= "DOF_TorpedoL";
const std::string C_DOF_NAME_TSUT_MISSILE_R			= "DOF_TorpedoR";

const std::string C_DOF_NAME_EXOCET_MISSILE_1		= "DOF_Exocet1";//"DOF_ExocetMissile1";
const std::string C_DOF_NAME_EXOCET_MISSILE_2		= "DOF_Exocet2";//"DOF_ExocetMissile2";
const std::string C_DOF_NAME_EXOCET_MISSILE_3		= "DOF_Exocet3";//"DOF_ExocetMissile3";
const std::string C_DOF_NAME_EXOCET_MISSILE_4		= "DOF_Exocet4";//"DOF_ExocetMissile4";

const std::string C_DOF_NAME_EXOCET_40_MISSILE_1	= "DOF_Exocet1";//"DOF_ExocetMissile1";
const std::string C_DOF_NAME_EXOCET_40_MISSILE_2	= "DOF_Exocet2";//"DOF_ExocetMissile2";
const std::string C_DOF_NAME_EXOCET_40_MISSILE_3	= "DOF_Exocet3";//"DOF_ExocetMissile3";
const std::string C_DOF_NAME_EXOCET_40_MISSILE_4	= "DOF_Exocet4";//"DOF_ExocetMissile4";

//++ BAWE-20120301: C802_MISSILE_ACTOR
const std::string C_DOF_NAME_C802_MISSILE_1			= C_DOF_NAME_EXOCET_MISSILE_1;
const std::string C_DOF_NAME_C802_MISSILE_2			= C_DOF_NAME_EXOCET_MISSILE_2;
const std::string C_DOF_NAME_C802_MISSILE_3			= C_DOF_NAME_EXOCET_MISSILE_3;
const std::string C_DOF_NAME_C802_MISSILE_4			= C_DOF_NAME_EXOCET_MISSILE_4;
//-- BAWE-20120301: C802_MISSILE_ACTOR

//EKA 060312

const std::string C_DOF_NAME_TETRAL_LAUNCHER_BASE_1	= "DOF_TetralBase_1";  
const std::string C_DOF_NAME_TETRAL_LAUNCHER_BASE_2 = "DOF_TetralBase_2"; 
const std::string C_DOF_NAME_TETRAL_LAUNCHER_SPOUT	= "DOF_TetralLauncher";
const std::string C_DOF_NAME_TETRAL_SPOUT			= "DOF_MistralLauncher"; 
const std::string C_DOF_NAME_TETRAL_MISSILE_1		= "DOF_TetralMissile1";  
const std::string C_DOF_NAME_TETRAL_MISSILE_2		= "DOF_TetralMissile2";  
const std::string C_DOF_NAME_TETRAL_MISSILE_3		= "DOF_TetralMissile3";
const std::string C_DOF_NAME_TETRAL_MISSILE_4		= "DOF_TetralMissile4";

//EKA 080312
const std::string C_DOF_NAME_MISTRAL_LAUNCHER_BASE_1		= "DOF_MistralBase_1";
const std::string C_DOF_NAME_MISTRAL_LAUNCHER_BASE_2		= "DOF_MistralBase_2";
const std::string C_DOF_NAME_MISTRAL_LAUNCHER_SPOUT   		= "DOF_MistralLauncher";

const std::string C_DOF_NAME_MISTRAL_MISSILE_1				= "DOF_MistralMissile1";
const std::string C_DOF_NAME_MISTRAL_MISSILE_2				= "DOF_MistralMissile2";

//EKA 080312
const std::string C_DOF_NAME_STRELA_LAUNCHER_BASE_1			= "DOF_StrelaBase_1";
const std::string C_DOF_NAME_STRELA_LAUNCHER_BASE_2			= "DOF_StrelaBase_2";
const std::string C_DOF_NAME_STRELA_LAUNCHER_SPOUT   		= "DOF_StrelaLauncher";
const std::string C_DOF_NAME_STRELA_MISSILE_1				= "DOF_StrelaMissile1";
const std::string C_DOF_NAME_STRELA_MISSILE_2				= "DOF_StrelaMissile2";

//--constant model Name
const std::string C_MODEL_CANNON_120B						= "../data/mesh/Missile/Meriam120Base.IVE";
const std::string C_MODEL_CANNON_120S						= "../data/mesh/Missile/Meriam120Launcher.IVE";
const std::string C_MODEL_CANNON_76B						= "../data/mesh/Missile/Meriam76Base.IVE";
const std::string C_MODEL_CANNON_76S						= "../data/mesh/Missile/Meriam76Launcher.IVE";
const std::string C_MODEL_CANNON_57B						= "../data/mesh/Missile/Meriam57Base.IVE";
const std::string C_MODEL_CANNON_57S						= "../data/mesh/Missile/Meriam57Launcher.IVE";
const std::string C_MODEL_CANNON_40B						= "../data/mesh/Missile/Meriam40Base.IVE";
const std::string C_MODEL_CANNON_40S						= "../data/mesh/Missile/Meriam40Launcher.IVE";
const std::string C_MODEL_MISSILE_TORP_SUT  				= "../data/mesh/Missile/torpedoSUT.ive";
const std::string C_MODEL_MISSILE_ASROCB    				= "../data/mesh/Missile/AsrocBase.ive";
const std::string C_MODEL_MISSILE_ASROCS    				= "../data/mesh/Missile/AsrocLauncher.ive";
const std::string C_MODEL_MISSILE_ASROCM    				= "../data/mesh/Missile/Asroc.ive";
const std::string C_MODEL_MISSILE_RBUB      				= "../data/mesh/Missile/RBUBase.ive";
const std::string C_MODEL_MISSILE_RBUS      				= "../data/mesh/Missile/RBULauncher.ive";
const std::string C_MODEL_MISSILE_RBUM      				= "../data/mesh/Missile/RBUMissile.ive";
const std::string C_MODEL_MISSILE_EXOCET    				= "../data/mesh/Missile/Exocet.ive";
const std::string C_MODEL_MISSILE_TORPEDO   				= "../data/mesh/Missile/A244S.ive"; //EKA-031111

const std::string C_MODEL_MISSILE_C802      				= C_MODEL_MISSILE_EXOCET;
const std::string C_MODEL_MISSILE_TETRAL    				= C_MODEL_MISSILE_ASROCM;
const std::string C_MODEL_MISSILE_TETRALB   				= C_MODEL_MISSILE_ASROCB;
const std::string C_MODEL_MISSILE_TETRALS   				= C_MODEL_MISSILE_ASROCS;
const std::string C_MODEL_MISSILE_MISTRAL   				= C_MODEL_MISSILE_EXOCET;
const std::string C_MODEL_MISSILE_MISTRALB  				= "../data/mesh/Missile/OWAMistralBase.ive"; //EKA-080312
const std::string C_MODEL_MISSILE_MISTRALS  				= "../data/mesh/Missile/OWAMistralLauncher.ive"; //EKA-080312
const std::string C_MODEL_MISSILE_STRELA    				= "../data/mesh/Missile/OWAMistralLauncher.ive";
const std::string C_MODEL_MISSILE_STRELAB   				= "../data/mesh/Missile/OWAMistralLauncher.ive";
const std::string C_MODEL_MISSILE_STRELAS   				= "../data/mesh/Missile/OWAMistralLauncher.ive";

const std::string C_MODEL_MISSILE_YAKHONT   				= C_MODEL_MISSILE_EXOCET;
const std::string C_MODEL_MISSILE_SPS115    				= C_MODEL_MISSILE_EXOCET;

const std::string C_DOF_NAME_CAMERA_CANNON120_1     		= "DOF_Meriam120Camera1";
const std::string C_DOF_NAME_CAMERA_CANNON120_2     		= "DOF_Meriam120Camera2";
const std::string C_DOF_NAME_CAMERA_CANNON76_1      		= "DOF_Camera1";
const std::string C_DOF_NAME_CAMERA_CANNON76_2      		= "DOF_Camera2";
const std::string C_DOF_NAME_CAMERA_CANNON57_1      		= "DOF_Meriam57Camera1";
const std::string C_DOF_NAME_CAMERA_CANNON57_2      		= "DOF_Meriam57Camera2";
const std::string C_DOF_NAME_CAMERA_CANNON40_1      		= "DOF_Meriam40Camera1";
const std::string C_DOF_NAME_CAMERA_CANNON40_2      		= "DOF_Meriam40Camera2";



enum Task { NONE, ATTACK_TARGET };

struct UFWaypoint
{
	float x;
	float y;
	float altitude;
	float speed;
	float desiredArrivalTime;
	Task task;

	UFWaypoint()
	{
		x = 0.0f;
		y = 0.0f;
		altitude = 0.0f;
		speed = 0.0f;
		desiredArrivalTime = 0.0f;
		task = NONE;
	}

	UFWaypoint(float tX, float tY, float tAltitude, float tSpeed, 
			 float tDesiredArrivalTime = 0.0f, Task tTask = NONE)
	{
		x = tX;
		y = tY;
		altitude = tAltitude;
		speed = tSpeed;
		desiredArrivalTime = tDesiredArrivalTime;
		task = tTask;
	}
};

inline std::string vec3dToString(const osg::Vec3d &pt)
{
	std::ostringstream ost;
	ost << "Vec3d("<< pt.x()<< ", " << pt.y()<< ", " << pt.z()<< " )";
	return ost.str();
}

inline std::string vec3ToString(const osg::Vec3 &pt)
{
	std::ostringstream ost;
	ost << "Vec3 ("<< pt.x()<< ", " << pt.y()<< ", " << pt.z()<< " )";
	return ost.str();
}

inline osg::Vec3 GetDOFPositionAbsolute( osgSim::DOFTransform* dof )
{
	osg::Vec3 vPos(0.0f,0.0f,0.0f);
	osg::MatrixList worldMatrices = dof->getWorldMatrices();
	for(osg::MatrixList::iterator itr = worldMatrices.begin();
		itr != worldMatrices.end();
		++itr)
	{
		osg::Matrix& matrix = *itr;
		osg::Vec3 center = dof->getBound().center() * matrix;
		vPos = center ;
	}

	return vPos;
};


inline osg::Vec3 GetNodePositionAbsolute( osg::Node* nd )
{
	osg::Vec3 vPos(0.0f,0.0f,0.0f);
	osg::MatrixList worldMatrices = nd->getWorldMatrices();
	for(osg::MatrixList::iterator itr = worldMatrices.begin();
		itr != worldMatrices.end();
		++itr)
	{
		osg::Matrix& matrix = *itr;
		osg::Vec3 center = nd->getBound().center() * matrix;
		vPos = center ;
	}

	return vPos;
};
 

inline std::string GetActorWeaponTypeName ( int WID , const int Tipe )  
{
	std::string sname = "" ;

	if ( Tipe == C_WEAPON_TYPE_BODY  )
	{
		if ( WID == CT_ASROC)				sname = C_CN_ASROCKB; 
		else if ( WID == CT_C802)			sname = C_CN_C802;
		else if ( WID == CT_CANNON_120)		sname = C_CN_CANNONB;
		else if ( WID == CT_CANNON_76)		sname = C_CN_CANNONB;
		else if ( WID == CT_CANNON_57)		sname = C_CN_CANNONB;
		else if ( WID == CT_CANNON_40)		sname = C_CN_CANNONB;
		else if ( WID == CT_EXOCET_40)		sname = C_CN_EXOCET_40; 
		else if ( WID == CT_MISTRAL)		sname = C_CN_MISTRALB;
		else if ( WID == CT_RBU_6000)		sname = C_CN_RBUB;
		else if ( WID == CT_STRELA)			sname = C_CN_STRELAB;
		else if ( WID == CT_TETRAL)			sname = C_CN_TETRALB;
		else if ( WID == CT_TORPEDO_SUT)	sname = C_CN_TORPSUT;
		else if ( WID == CT_TORPEDO_A244S)	sname = C_CN_TORPEDO;
		else if ( WID == CT_YAKHONT)		sname = C_CN_YAKHONT;
		else 
			std::cout<<" !!! WARNING !!! Unknown Actor Launcher Base, Weapon ID : "<<WID<<", see [GetActorWeaponTypeName]"<<std::endl;

	} else if ( Tipe == C_WEAPON_TYPE_SPOUT  )
	{
		if ( WID == CT_ASROC)				sname = C_CN_ASROCKS; 
		else if ( WID == CT_C802)			sname = C_CN_C802;
		else if ( WID == CT_CANNON_120)		sname = C_CN_CANNONS;
		else if ( WID == CT_CANNON_76)		sname = C_CN_CANNONS;
		else if ( WID == CT_CANNON_57)		sname = C_CN_CANNONS;
		else if ( WID == CT_CANNON_40)		sname = C_CN_CANNONS;
		else if ( WID == CT_EXOCET_40)		sname = C_CN_EXOCET_40;
		else if ( WID == CT_MISTRAL)		sname = C_CN_MISTRALS;
		else if ( WID == CT_RBU_6000)		sname = C_CN_RBUS;
		else if ( WID == CT_STRELA)			sname = C_CN_STRELAS;
		else if ( WID == CT_TETRAL)			sname = C_CN_TETRALS;
		else if ( WID == CT_TORPEDO_SUT)	sname = C_CN_TORPSUT;
		else if ( WID == CT_TORPEDO_A244S)	sname = C_CN_TORPEDO;
		else if ( WID == CT_YAKHONT)		sname = C_CN_YAKHONT;
		else 
			std::cout<<" !!! WARNING !!! Unknown Actor Launcher Spout, Weapon ID : "<<WID<<", see [GetActorWeaponTypeName]"<<std::endl;
	} else if ( Tipe == C_WEAPON_TYPE_MISSILE )
	{
		if ( WID == CT_ASROC)				sname = C_CN_ASROCK; 
		else if ( WID == CT_C802)			sname = C_CN_C802;
		else if ( WID == CT_CANNON_120)		sname = C_CN_CANNONM;
		else if ( WID == CT_CANNON_76)		sname = C_CN_CANNONM;
		else if ( WID == CT_CANNON_57)		sname = C_CN_CANNONM;
		else if ( WID == CT_CANNON_40)		sname = C_CN_CANNONM;
		else if ( WID == CT_EXOCET_40)		sname = C_CN_EXOCET_40; 
		else if ( WID == CT_MISTRAL)		sname = C_CN_MISTRAL;
		else if ( WID == CT_RBU_6000)		sname = C_CN_RBU;
		else if ( WID == CT_STRELA)			sname = C_CN_STRELA;
		else if ( WID == CT_TETRAL)			sname = C_CN_TETRAL;
		else if ( WID == CT_TORPEDO_SUT)	sname = C_CN_TORPSUT;
		else if ( WID == CT_TORPEDO_A244S)	sname = C_CN_TORPEDO;
		else if ( WID == CT_YAKHONT)		sname = C_CN_YAKHONT;
		else 
			std::cout<<" !!! WARNING !!! Unknown Actor Missile Name, Weapon ID : "<<WID<<", see [GetActorWeaponTypeName]"<<std::endl;
		
	}

	return sname;
}

/************************************************************************/
/* Sesuai Database                                                      */
/************************************************************************/
inline std::string GetWeaponSwitchName( const int WID, const int LID  )  
{
	const std::string C_SwitchNULL = "weapon ini tidak ada switch di ship model" ;

	std::string sname = "" ;

	switch ( WID )
	{
	case CT_ASROC :
		sname = C_SwitchAsroc ;
		break;
	case CT_C802 :
		sname = C_SwitchNULL;
		break;
	case CT_CANNON_40 :
		{
			if ( LID == 1 )
				sname = C_SwitchMeriam40_1 ;
			else if ( LID == 2 )
				sname = C_SwitchMeriam40_2 ;
			else if ( LID == 3 )
				sname = C_SwitchMeriam40_3 ;
		}
		break;

	case CT_CANNON_57 :
		sname = C_SwitchMeriam57 ;
		break;
	case CT_CANNON_76  :
		sname = C_SwitchMeriam76 ;
		break;
	case CT_CANNON_120 :
		sname = C_SwitchMeriam120 ;
		break;
	case CT_EXOCET_MM38 :
		sname = C_SwitchNULL;
		break;
	case CT_EXOCET_40 :
		sname = C_SwitchNULL;
		break;		
	case CT_MISTRAL :
		{
			if ( LID == 1 )
				sname = C_SwitchMistral_1 ;
			else if ( LID == 2 )
				sname = C_SwitchMistral_2 ;
		}
		break;
	case CT_RBU_6000 :
		{
			if ( LID == 1 )
				sname = C_SwitchRBU6000_1 ;
			else if ( LID == 2 )
				sname = C_SwitchRBU6000_2 ;
		}
		break;
	case CT_STRELA :
		{
			if ( LID == 1 )
				sname = C_SwitchStrela_1 ;
			else if ( LID == 2 )
				sname = C_SwitchStrela_2 ;
		}
		break;	
	case CT_TETRAL :
		{
			if ( LID == 1 )
				sname = C_SwitchTetral_1 ;
			else if ( LID == 2 )
				sname = C_SwitchTetral_2 ;
		}
		break;	
	case CT_TORPEDO_A244S :
		sname = C_SwitchNULL;
		break;	
	case CT_TORPEDO_SUT :
		sname = C_SwitchNULL;
		break;	
	case CT_YAKHONT :
		sname = C_SwitchNULL;
		break;	
	} 

	return sname;

}

inline std::string GetWeaponDOFName ( const int WID, const int LID , const int Tipe )  
{
	const std::string C_DOFWeaponNULL = "weapon ini tidak ada memiliki launcher" ;

	std::string sname = "" ;

	if ( Tipe == C_WEAPON_TYPE_BODY  )
	{
		switch ( WID )
		{
		case CT_YAKHONT :
			sname = C_DOFWeaponNULL ;
			break;

		case CT_TORPEDO_SUT :
			sname = C_DOFWeaponNULL ;
			break;

		case CT_TORPEDO_A244S :
			sname = C_DOFWeaponNULL ;
			break;

		case CT_TETRAL :
			{
				if ( LID == 1 )
					sname = C_DOF_NAME_TETRAL_LAUNCHER_BASE_1 ;
				else if ( LID == 2 )
					sname = C_DOF_NAME_TETRAL_LAUNCHER_BASE_2 ;
			}
			break;

		case CT_STRELA :
			{
				if ( LID == 1 )
					sname = C_DOF_NAME_STRELA_LAUNCHER_BASE_1 ;
				else if ( LID == 2 )
					sname = C_DOF_NAME_STRELA_LAUNCHER_BASE_2 ;
			}
			break;

		case CT_RBU_6000 :
			{
				if ( LID == 1 )
					sname = C_DOF_NAME_RBU_LAUNCHER_BASE_L ;
				else
					sname = C_DOF_NAME_RBU_LAUNCHER_BASE_R ;
			}
			break;

		case CT_MISTRAL :
			{
				if ( LID == 1 )
					sname = C_DOF_NAME_MISTRAL_LAUNCHER_BASE_1;
				else
					sname = C_DOF_NAME_MISTRAL_LAUNCHER_BASE_2 ;
			}
			break;

		case CT_EXOCET_MM38 :
			sname = C_DOFWeaponNULL ;
			break;

		case CT_EXOCET_40 :
			{
				if (LID == 1 )
					sname = C_DOF_NAME_EXOCET_40_MISSILE_1;
				else
				if (LID == 2)
					sname = C_DOF_NAME_EXOCET_40_MISSILE_2;
				else
				if (LID == 3)
					sname = C_DOF_NAME_EXOCET_40_MISSILE_3;
				else
				if (LID == 4)
					sname = C_DOF_NAME_EXOCET_40_MISSILE_4;
			}
			break;
		
		case CT_CANNON_40 :
			{
				if ( LID == 1 )
					sname = C_DOF_NAME_CANNON_BASE_40_1 ;
				else if ( LID == 2 )
					sname = C_DOF_NAME_CANNON_BASE_40_2 ;
				else if ( LID == 3 )
					sname = C_DOF_NAME_CANNON_BASE_40_3 ;
			}
			break;
		case CT_CANNON_57 :
			sname = C_DOF_NAME_CANNON_BASE_57 ;
			break;
		case CT_CANNON_76  :
			sname = C_DOF_NAME_CANNON_BASE_76 ;
			break;
		case CT_CANNON_120 :
			sname = C_DOF_NAME_CANNON_BASE_120 ;
			break;
		case CT_C802 :
			sname = C_DOFWeaponNULL ;
			break;
		case CT_ASROC :
			sname = C_DOF_NAME_ASROC_LAUNCHER_BASE ;
			break;

		} 
	} else if ( Tipe == C_WEAPON_TYPE_SPOUT  )
	{
		switch ( WID )
		{
		case CT_YAKHONT :
			sname = C_DOFWeaponNULL ;
			break;

		case CT_TORPEDO_SUT :
			sname = C_DOFWeaponNULL ;
			break;

		case CT_TORPEDO_A244S :
			sname = C_DOFWeaponNULL ;
			break;

		case CT_TETRAL :
			sname = C_DOF_NAME_TETRAL_LAUNCHER_SPOUT ;
			break;

		case CT_STRELA :
			sname = C_DOF_NAME_STRELA_LAUNCHER_SPOUT ;
			break;

		case CT_RBU_6000 :
			sname = C_DOF_NAME_RBU_LAUNCHER_SPOUT ;
			 
			break;

		case CT_MISTRAL :
			sname = C_DOF_NAME_MISTRAL_LAUNCHER_SPOUT ;
			break;

		case CT_EXOCET_MM38 :
			sname = C_DOFWeaponNULL ;
			break;

		case CT_EXOCET_40 :
			sname = C_DOFWeaponNULL ;
			break;

		case CT_CANNON_40 :
			{
				if ( LID == 1 )
					sname = C_DOF_NAME_CANNON_LAUNCHER_40_1 ;
				else if ( LID == 2 )
					sname = C_DOF_NAME_CANNON_LAUNCHER_40_2 ;
				else if ( LID == 3 )
					sname = C_DOF_NAME_CANNON_LAUNCHER_40_3 ;
			}
			break;
		case CT_CANNON_57 :
			sname = C_DOF_NAME_CANNON_LAUNCHER_57 ;
			break;
		case CT_CANNON_76  :
			sname = C_DOF_NAME_CANNON_LAUNCHER_76 ;
			break;
		case CT_CANNON_120 :
			sname = C_DOF_NAME_CANNON_LAUNCHER_120 ;
			break;
		case CT_C802 :
			sname = C_DOFWeaponNULL ;
			break;
		case CT_ASROC :
			sname = C_DOF_NAME_ASROC_LAUNCHER_SPOUT ;
			break;

		} 
	} 
	return sname;
}

inline std::string GetWeaponModelName ( const int WID, const int Tipe )  
{
	const std::string C_ModelWeaponNULL = "weapon ini tidak ada memiliki launcher" ;

	std::string sname = "" ;

	if ( Tipe == C_WEAPON_TYPE_BODY  )
	{
		switch ( WID )
		{
		case CT_YAKHONT :
			sname = C_ModelWeaponNULL ;
			break;

		case CT_TORPEDO_SUT :
			sname = C_ModelWeaponNULL ;
			break;

		case CT_TORPEDO_A244S :
			sname = C_ModelWeaponNULL ;
			break;

		case CT_TETRAL :
			sname = C_MODEL_MISSILE_TETRALB ;
			break;

		case CT_STRELA :
			sname = C_MODEL_MISSILE_STRELAB ;
			break;

		case CT_RBU_6000 :
			sname = C_MODEL_MISSILE_RBUB ;
			break;

		case CT_MISTRAL :
			sname = C_MODEL_MISSILE_MISTRALB ;
			break;

		case CT_EXOCET_MM38 :
			sname = C_ModelWeaponNULL ;
			break;

		case CT_EXOCET_40 :
			sname = C_ModelWeaponNULL ;
			break;

		case CT_CANNON_40 :
			sname = C_MODEL_CANNON_40B ;
			break;

		case CT_CANNON_57 :
			sname = C_MODEL_CANNON_57B ;
			break;

		case CT_CANNON_76  :
			sname = C_MODEL_CANNON_76B ;
			break;

		case CT_CANNON_120 :
			sname = C_MODEL_CANNON_120B ;
			break;

		case CT_C802 :
			sname = C_ModelWeaponNULL ;
			break;

		case CT_ASROC :
			sname = C_MODEL_MISSILE_ASROCB ;
			break;

		} 
	} else if ( Tipe == C_WEAPON_TYPE_SPOUT  )
	{
		switch ( WID )
		{
		case CT_YAKHONT :
			sname = C_ModelWeaponNULL ;
			break;

		case CT_TORPEDO_SUT :
			sname = C_ModelWeaponNULL ;
			break;

		case CT_TORPEDO_A244S :
			sname = C_ModelWeaponNULL ;
			break;

		case CT_TETRAL :
			sname = C_MODEL_MISSILE_TETRALS ;
			break;

		case CT_STRELA :
			sname = C_MODEL_MISSILE_STRELAS ;
			break;

		case CT_RBU_6000 :
			sname = C_MODEL_MISSILE_RBUS ;

			break;

		case CT_MISTRAL :
			sname = C_MODEL_MISSILE_MISTRALS ;
			break;

		case CT_EXOCET_MM38 :
			sname = C_ModelWeaponNULL ;
			break;

		case CT_EXOCET_40 :
			sname = C_ModelWeaponNULL ;
			break;

		case CT_CANNON_40 :
			sname = C_MODEL_CANNON_40S ;
			break;
		case CT_CANNON_57 :
			sname = C_MODEL_CANNON_57S ;
			break;
		case CT_CANNON_76  :
			sname = C_MODEL_CANNON_76S ;
			break;
		case CT_CANNON_120 :
			sname = C_MODEL_CANNON_120S ;
			break;
		case CT_C802 :
			sname = C_ModelWeaponNULL ;
			break;
		case CT_ASROC :
			sname = C_MODEL_MISSILE_ASROCS ;
			break;

		} 
	}
	else if ( Tipe == C_WEAPON_TYPE_MISSILE  )
	{
		switch ( WID )
		{
		case CT_YAKHONT :
			sname = C_MODEL_MISSILE_YAKHONT ;
			break;

		case CT_TORPEDO_SUT :
			sname = C_MODEL_MISSILE_TORP_SUT ;
			break;

		case CT_TORPEDO_A244S :
			sname = C_MODEL_MISSILE_TORPEDO ;
			break;

		case CT_TETRAL :
			sname = C_MODEL_MISSILE_TETRALS ;
			break;

		case CT_STRELA :
			sname = C_MODEL_MISSILE_STRELA ;
			break;

		case CT_RBU_6000 :
			sname = C_MODEL_MISSILE_RBUM ;
			break;

		case CT_MISTRAL :
			sname = C_MODEL_MISSILE_MISTRAL ;
			break;

		case CT_EXOCET_MM38 :
			sname = C_MODEL_MISSILE_EXOCET ;
			break;

		case CT_EXOCET_40 :
			sname = C_MODEL_MISSILE_EXOCET ;
			break;

		case CT_CANNON_40 :
			sname = C_ModelWeaponNULL ;
			break;
		case CT_CANNON_57 :
			sname = C_ModelWeaponNULL ;
			break;
		case CT_CANNON_76  :
			sname = C_ModelWeaponNULL ;
			break;
		case CT_CANNON_120 :
			sname = C_ModelWeaponNULL ;
			break;
		case CT_C802 :
			sname = C_MODEL_MISSILE_C802 ;
			break;
		case CT_ASROC :
			sname = C_MODEL_MISSILE_ASROCM ;
			break;

		} 
	}
	return sname;
}

inline std::string GetCameraDOFName( const int WID , const int LID )  
{
	std::string sname = "" ;
	//if ( WID == CT_ASROC)				sname = C_CN_ASROCKB; 
	//else if ( WID == CT_C802)			sname = C_CN_C802;
	//else 
	if ( WID == CT_CANNON_120)			sname =	C_DOF_NAME_CAMERA_CANNON120_1;
	else if ( WID == CT_CANNON_76)		sname =	C_DOF_NAME_CAMERA_CANNON76_1;
	else if ( WID == CT_CANNON_57)		sname =	C_DOF_NAME_CAMERA_CANNON57_1;
	else if ( WID == CT_CANNON_40)		sname =	C_DOF_NAME_CAMERA_CANNON40_1;
	//else if ( WID == CT_EXOCET_40)	sname = C_CN_EXOCET;
	//else if ( WID == CT_EXOCET_MM38)	sname = C_CN_EXOCET; 
	else if ( WID == CT_MISTRAL)		sname = "DOF_MistralCamera1";
	//else if ( WID == CT_RBU_6000)		sname = C_CN_RBUB;
	else if ( WID == CT_STRELA)			sname = "DOF_StrelaCamera1";
	else if ( WID == CT_TETRAL)			sname = "DOF_TetralCamera1";
	//else if ( WID == CT_TORPEDO_SUT)	sname = C_CN_TORPSUT;
	//else if ( WID == CT_TORPEDO_A244S)sname = C_CN_TORPEDO;
	//else if ( WID == CT_YAKHONT)		sname = C_CN_YAKHONT;

	return sname;
}
inline void AdjustX(dtCore::Transform* startPos, float newX, bool relative = false)
{
	float x1, y1, z1, h1, p1, r1;
	
	startPos->Get(x1, y1, z1, h1, p1, r1);

	if(relative)
		newX += x1;

	startPos->Set(newX, y1, z1, h1, p1, r1);
}

inline void AdjustY(dtCore::Transform* startPos, float newY, bool relative = false)
{
	float x1, y1, z1, h1, p1, r1;
	
	startPos->Get(x1, y1, z1, h1, p1, r1);

	if(relative)
		newY += y1;

	startPos->Set(x1, newY, z1, h1, p1, r1);
}

inline void AdjustZ(dtCore::Transform* startPos, float newZ, bool relative = false)
{
	float x1, y1, z1, h1, p1, r1;
	
	startPos->Get(x1, y1, z1, h1, p1, r1);

	if(relative)
		newZ += z1;

	startPos->Set(x1, y1, newZ, h1, p1, r1);
}

inline void AdjustH(dtCore::Transform* startPos, float newH, bool relative = false)
{
	float x1, y1, z1, h1, p1, r1;
	
	startPos->Get(x1, y1, z1, h1, p1, r1);

	if(relative)
		newH += h1;

	startPos->Set(x1, y1, z1, newH, p1, r1);
}

inline void AdjustP(dtCore::Transform* startPos, float newP, bool relative = false)
{
	float x1, y1, z1, h1, p1, r1;
	
	startPos->Get(x1, y1, z1, h1, p1, r1);

	if(relative)
		newP += p1;

	startPos->Set(x1, y1, z1, h1, newP, r1);
}

inline void AdjustR(dtCore::Transform* startPos, float newR, bool relative = false)
{
	float x1, y1, z1, h1, p1, r1;
	
	startPos->Get(x1, y1, z1, h1, p1, r1);

	if(relative)
		newR += r1;

	startPos->Set(x1, y1, z1, h1, p1, newR);
}

inline float ComputeDistance(float x1, float y1, float x2, float y2)
{
   return sqrtf(osg::square(x2 - x1) + osg::square(y2 - y1));
}

/*
 *  Bearing from x1,y1 to x2,y2...
 */
inline float ComputeBearingTo(float x1, float y1, float x2, float y2)
{
   return 180.0f - osg::RadiansToDegrees(atan2f(x2 - x1, y2 - y1));
}

inline float ComputeBearingTo2(float x1, float y1, float x2, float y2)
{
   return osg::RadiansToDegrees(atan2f(x2 - x1, y2 - y1));
}

inline void ComputeNewCoordinates(float x1, float y1, float distance, float angle, float &x2, float &y2)
{
   x2 = x1 + distance * sinf(osg::DegreesToRadians(angle));
	y2 = y1 - distance * cosf(osg::DegreesToRadians(angle));
}

inline float ConvertTodtCoreBearing(float bearing)
{
	return 360.0f - bearing;
}

inline float ConvertFromdtCoreBearing(float bearing)
{
	return 360.0f - bearing;
}

inline void VerifyBearingWithinBounds(float& bearing)
{
	while(bearing >= 360.0f)
		bearing -= 360.0f;

	while(bearing < .0f)
		bearing += 360.0f;
}

/// sam.add
inline void VerifyTrimWithinBounds(float& trim)
{
	while(trim >= 45.0f)
		trim -= 45.0f;

	while(trim < .0f)
		trim += 45.0f;
}


inline float CalculateVec3Distance (osg::Vec3 point1, osg::Vec3 point2)
{
	return sqrtf(osg::square(point1.x()-point2.x())+osg::square(point1.y()-point2.y()));
}

inline dtCore::Transform Offset2DPosition(dtCore::Transform* startPos, dtCore::Transform* offsetPos)
{
	dtCore::Transform tempPos;
	float x1, y1, z1, h1, p1, r1;
	float x2, y2, z2, h2, p2, r2;
	
	startPos->Get(x1, y1, z1, h1, p1, r1);
	offsetPos->Get(x2, y2, z2, h2, p2, r2);

    float newX2 = x2 * cosf(osg::DegreesToRadians(h1)) - y2 * sinf(osg::DegreesToRadians(h1));
    float newY2 = x2 * sinf(osg::DegreesToRadians(h1)) + y2 * cosf(osg::DegreesToRadians(h1));

	tempPos.Set(x1 + newX2, y1 + newY2, z2, h1 + h2, p2, r2, 1.0f, 1.0f, 1.0f);

	return tempPos;
}

inline dtCore::Transform Difference2DPosition(dtCore::Transform* startPos, dtCore::Transform* offsetPos)
{
	dtCore::Transform tempPos;
   float x1, y1, z1, h1, p1, r1;
   float x2, y2, z2, h2, p2, r2;
	
   startPos->Get(x1, y1, z1, h1, p1, r1);
   offsetPos->Get(x2, y2, z2, h2, p2, r2);

	float bearing = 0.0f - h1;

	float newX2 = (x2 - x1) * cosf(osg::DegreesToRadians(bearing)) - (y2 - y1) * sinf(osg::DegreesToRadians(bearing));
	float newY2 = (x2 - x1) * sinf(osg::DegreesToRadians(bearing)) + (y2 - y1) * cosf(osg::DegreesToRadians(bearing));
	
	tempPos.Set(newX2, newY2, z2, h2 - h1, p2, r2, 1.0f, 1.0f, 1.0f);
	return tempPos;
}

// ==coordinate conversion==
inline osg::Vec2d ConvCoordPolar_To_Cartesian(const double aAngleRadian, const double aRadius)
{
	osg::Vec2d result;
	result.x() = aRadius * cos(aAngleRadian);
	result.y() = aRadius * sin(aAngleRadian);

	return result;
}

// ==distance conversion==
inline double ConvMeter_To_Feet(const double aMeter)
{
	return aMeter * 0.3048;
}

inline double ConvFeet_To_Meter(const double aMeter)
{
	return aMeter * 3.28083;
}

// ==direction conversion==
inline double ConvCartesian_To_Compass(const double degree)
{
	// input : derajat (0..360) dari sumbu X, CCW, cartesian
	// output: derajat (0..360) dari utara,   CW, kompas
	double result;
	result = 90.0 - degree;
	if(result < 0.0) 
		result = result + 360.0;
	return result;
}

inline double ConvCompass_To_Cartesian(const double degree)
{
	// input : derajat (0..360) dari utara,   CW, kompas
	// output: derajat (0..360) dari sumbu X, CCW, cartesian
	double result;
	result = 90.0 - degree;
	if (result < 0.0)
		result = result + 360.0;
	return result;
}

// ==speed conversion==
inline double ConvMeterPerSecond_To_KiloMeterPerHour(const double aMps)
{
	return aMps * 3.600;
}
inline double ConvKiloMeterPerHour_To_MeterPerSecond(const double aKmpH)
{
	return aKmpH * 10.0 / 36.0;
}
inline double ConvMeterPerSecond_To_FeetPerMinute(const double aMps)
{
	return aMps *  3.28 * 60.0;
}
inline double ConvMeterPerSecond_To_Knots(const double aMps)
{
	return (aMps / 1852.0) * 3600.0;
}
inline double ConvKnots_To_MeterPerSecond(const double aKts)
{
	return (aKts * 1852.0) / 3600.0;
}

inline double ConvMach_To_Knot(const double aSpdMach)
{
	return aSpdMach * 661.47;
}
inline double ConvKnot_To_Mach(const double aSpdKnot)
{
	return aSpdKnot * 0.0015118;
}
/*inline double GetMachLevel(const double atLevel)
{
	if(atLevel <  1005.0) return 661.7;
	else if (atLevel <  2005.0) return 659.2;
	else if (atLevel <  3005.0) return 657.2;
	else if (atLevel <  4005.0) return 654.9;
	else if (atLevel <  5005.0) return 652.6;
	else if (atLevel <  6005.0) return 650.3;
	else if (atLevel <  7005.0) return 647.9;
	else if (atLevel <  8005.0) return 645.6;
	else if (atLevel <  9005.0) return 643.3;
	else if (atLevel < 10005.0) return 640.9;
	else if (atLevel < 15005.0) return 638.6;
	else if (atLevel < 20005.0) return 626.7;
	else if (atLevel < 25005.0) return 614.6;
	else if (atLevel < 30005.0) return 602.2;
	else if (atLevel < 35005.0) return 589.5;
	else if (atLevel < 36089.0) return 576.6;
	else return 573.8;
}

inline double ConvMach_To_Knot(const double aSpdMach, const double atLevel)
{
	return aSpdMach * GetMachLevel(atLevel);
}
inline double ConvKnot_To_Mach(const double aSpdKnot, const double atLevel)
{
	return aSpdKnot / GetMachLevel(atLevel);
}*/

// ==direction==
// degree unit
inline double ValidateDegree(const double aDeg)
{
	double result;
	result = aDeg;
	while (result > 360.0)
	{
		result = result - 360.0;
	}
	while (result < 0.0)
	{
		result = result + 360.0;
	}
	return result;
}
// radian unit
inline double ValidateRadiant(const double aRad)
{
	double result;
	result = aRad;
	while (result > c_2_Pi)
	{
		result = result - c_2_Pi;
	}
	while (result < 0.0)
	{
		result = result + c_2_Pi;
	}
	return result;
}
inline double AddRadianClockWise(const double aRad, const double goCW)
{
	double result;
	result = aRad - goCW;
	while (result < 0.0)
	{
		result = result + c_2_Pi;
	}
	return result;
}
inline double AddRadianCounterClockWise(const double aRad, const double goCCW)
{
	double result;
	result = aRad + goCCW;
	while (result > c_2_Pi)
	{
		result = result - c_2_Pi;
	}
	return result;
}
inline double RadiantBack(const double aRad)
{
	double result;
	result = aRad + Pi;
	while (result > c_2_Pi) 
	{
		result = result - c_2_Pi;
	}
	return result;
}
inline bool IsRadiantDestAtLeft(const double src, const double dest)
{
	//return true jika dest dikiri src, cartesian, east = 0
	double back;
	back = ValidateRadiant(dest - src);
	return (back - Pi) < 0.0;
}

// ==Compas direction==
inline bool DegComp_IsBeetwen(const double aDegTes, const double aDeg1, const double  aDeg2)
{
	double d1, d2;
	d1 = (aDegTes-aDeg1);
	if (d1 < 0.0) d1 = d1+ 360.0;

	d2 = (aDeg2-aDeg1);
	if (d2 < 0.0) d2 = d2+ 360.0;

	return d1 < d2;
}

inline double Range3D(double x1, double y1, double z1, double x2, double y2, double z2)
{
	//X,Y dalam Degree, Z Dalam Ft
	return sqrtf(osg::square(x2-x1) + osg::square(y2-y1) + osg::square((z2-z1)/c_NauticalMile_To_Feet));
}

inline double RangeVec3(osg::Vec3 v1, osg::Vec3 v2)
{
	return sqrtf(osg::square(v2[0]-v1[0]) + osg::square(v2[1]-v1[1]) + osg::square(v2[2]-v1[2]));
}

inline osg::Vec2 NextPost2D(osg::Vec2 PrePost, int speed,double Heading, double deltaT)
{
	//DeltaT dalam Jam, speed dalam knot
	double speed_x,speed_y;
    double dx,dy;
	osg::Vec2 result;
	
	speed_x = speed * cos(osg::DegreesToRadians(Heading));
	speed_y = speed * sin(osg::DegreesToRadians(Heading));

	dx = speed_x * deltaT;
	dy = speed_y * deltaT;

	result.x() = PrePost.x() + c_NauticalMile_To_Degree * dx;
	result.y() = PrePost.y() + c_NauticalMile_To_Degree * dy;

	return result;
}

inline float NorthToEast(float degree)
{
	float frac;
	int degInt;

	//input: derajat (0..360) dari utara, CW, kompas}
	//ouput: derajat (0..360) dari sumbu X, CCW, cartesian }
	frac = degree - floor(degree);
	degInt =  static_cast<int>((359 - osg::round(degree) )+90 ) % 360;
	return degInt + (1-frac);
}

inline double InitDir(int iCount, double sh)
{
	double dir;
	if ((iCount % 2) == 0)	//kiri
		dir =  sh - 60.0;
	else					// kanan
		dir = sh + 60.0;

	ValidateDegree(dir);
	return dir;

}

inline osg::Vec3 RangeBearingToCoord(osg::Vec3 CenterPos, float TRange, float Tbearing)
{
	float Mx, My;
	float SinX, CosX;
	osg::Vec3 ResultPost;

	SinX = sin(osg::DegreesToRadians(ConvCompass_To_Cartesian(Tbearing)));
	CosX = cos(osg::DegreesToRadians(ConvCompass_To_Cartesian(Tbearing)));

	Mx	 = TRange * CosX;
	My	 = TRange * SinX;

	ResultPost.x() = CenterPos.x() + Mx;
	ResultPost.y() = CenterPos.y() + My;
	ResultPost.z() = CenterPos.z();

	return ResultPost;
}

inline osg::Vec3 RangeBearingElevToCoord(osg::Vec3 CenterPos, float TRange, float TBearing, float TElev)
{
	float Mx, My;
	float newRange, newAlt;
	float SinX, CosX;
	osg::Vec3 ResultPost;

	newRange = cos(osg::DegreesToRadians(ConvCompass_To_Cartesian(TElev))) * TRange;
	newAlt	 = sin(osg::DegreesToRadians(ConvCompass_To_Cartesian(TElev))) * TRange;
	SinX	 = sin(osg::DegreesToRadians(ConvCompass_To_Cartesian(TBearing)));
	CosX	 = cos(osg::DegreesToRadians(ConvCompass_To_Cartesian(TBearing)));

	Mx	 = newRange * CosX;
	My	 = newRange * SinX;

	ResultPost.x() = CenterPos.x() + Mx;
	ResultPost.y() = CenterPos.y() + My;
	ResultPost.z() = CenterPos.z() + newAlt;

	return ResultPost;
}


#endif 
