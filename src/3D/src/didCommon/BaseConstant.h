#pragma once

#ifdef USE_VLD

#include <vld.h>

#endif

#include <dtcore/refptr.h>
 

//--- weapon ID == //sesuai database
const unsigned int CT_ASROC					= 	1	;
const unsigned int CT_RBU_6000				= 	2	;
const unsigned int CT_TORPEDO_A244S			= 	3	;
const unsigned int CT_TORPEDO_SUT			= 	4	;
const unsigned int CT_TETRAL				= 	5	;
const unsigned int CT_YAKHONT				= 	6	;
const unsigned int CT_C802					= 	7	;
const unsigned int CT_MISTRAL				= 	8	;
const unsigned int CT_STRELA				= 	9	;
const unsigned int CT_EXOCET_40				=   10  ;
const unsigned int CT_EXOCET_MM38			= 	11 	;
const unsigned int CT_CANNON_40				= 	12	;
const unsigned int CT_CANNON_57				= 	13	;
const unsigned int CT_CANNON_76				= 	14	;
const unsigned int CT_CANNON_120			= 	15	;
//--- weapon ID

//--- Vehicle Type
const unsigned int CT_EXPLODE_SHIP			=   20	;
const unsigned int CT_EXPLODE_SUBMARINE		=   21	;
const unsigned int CT_EXPLODE_HELICOPTER	=   22	;
const unsigned int CT_EXPLODE_AIRCFART		=   23	;

//--constant WEAPON_TYPE
const int C_WEAPON_TYPE_BODY				=  1 ;
const int C_WEAPON_TYPE_SPOUT				=  2 ;
const int C_WEAPON_TYPE_MISSILE				=  3 ;

//////////////////////////////////////////////////////////////////////////////////////////////////////
const unsigned int START_MACHINE_OBSERVER = 10;  
const unsigned int START_MACHINE_ANJUNGAN = 20;  
const unsigned int START_MACHINE_TDS	  = 30;  
//////////////////////////////////////////////////////////////////////////

	 
// machine name
const std::string C_MACHINE_SERVER     			= "GameServer";
const std::string C_MACHINE_PLATFORM   			= "PlatformClient";
// network 
const std::string C_CLIENT_ASK_OBJECT  			= "E_NetClientAskAllObjects";
const std::string C_CLIENT_ASK_ROLE				= "E_NetClientAskRole";

//-- constant init 3D Component name
const std::string C_COMP_ACTOR_CONTROLLER		= "Actors Controller";
const std::string C_COMP_ACTOR_CANON			= "Actors Canon";
const std::string C_COMP_DB_CONNECTION			= "Database Connection";
const std::string C_COMP_SERVER_MESSAGE			= "SimServerMessage";
const std::string C_COMP_SERVER_CLIENT_CTRL		= "SimServerClientComponent";
const std::string C_COMP_ENVI_DB				= "Environment_DB";
// actor category
const std::string C_ACTOR_CAT					= "dtcore.Game.Actors.Simulations";
const std::string C_OCEAN_CAT					= "didEnviro";

// actor category name
const std::string C_CN_PLAYER					= "PLAYER ACTOR";
const std::string C_CN_SHIP						= "KRI";
const std::string C_CN_SUBMARINE				= "SUBMARINE";
const std::string C_CN_HELICOPTER				= "HELICOPTER";
const std::string C_CN_AIRCRAFT					= "AIRCRAFT";
const std::string C_CN_EFFECT					= "Effect Actor";
const std::string C_CN_MISC						= "Object Misc";
const std::string C_CN_STATIC					= "Static object";
const std::string C_CN_TREE 					= "Tree Actor"; 
const std::string C_CN_SHIP_PARENT				= "Ship Parent";

const std::string C_CN_ASROCK					= "Asrock";
const std::string C_CN_ASROCKS					= "AsrockSpout";
const std::string C_CN_ASROCKB					= "AsrockBody";
const std::string C_CN_CANNONM					= "CannonMissile";
const std::string C_CN_CANNONS					= "CannonSpout";
const std::string C_CN_CANNONB					= "CannonBody";
const std::string C_CN_RBU  					= "RBU";
const std::string C_CN_RBUS						= "RBUSpout";
const std::string C_CN_RBUB						= "RBUBody";
const std::string C_CN_EXOCET					= "Exocet";
const std::string C_CN_TORPSUT					= "TorpedoSUT";
const std::string C_CN_TORPEDO					= "Torpedo";
const std::string C_CN_OCEAN					= "OceanActor";
const std::string C_CN_OCEAN_CFG				= "OceanConfigActor";

const std::string C_CN_BASE_MISSILE     		= "BaseMissile"; 
const std::string C_CN_C802             		= "C802"; 
const std::string C_CN_YAKHONT          		= "Yakhont";  
const std::string C_CN_EXOCET_40        		= "Exocet MM 40"; 

//EKA-060312
const std::string C_CN_TETRALB					= "TetralBody";
const std::string C_CN_TETRALS					= "TetralSpout";
const std::string C_CN_TETRAL           		= "Tetral";
const std::string C_CN_MISTRALB					= "MistralBody";
const std::string C_CN_MISTRALS					= "MistralSpout";
const std::string C_CN_MISTRAL          		= "Mistral";
const std::string C_CN_STRELAB					= "StrelaBody";
const std::string C_CN_STRELAS					= "StrelaSpout";
const std::string C_CN_STRELA           		= "Strela";

// actor type
const std::string C_TYPE_SHIP					= "ship";
const std::string C_TYPE_MISSILE    			= "missile";
const std::string C_TYPE_MISC       			= "misc";

/// -- actors property sett
const std::string C_SET_MODEL			= "Model";
const std::string C_SET_VID				= "VehicleID";
const std::string C_SET_TGTID			= "TargetID";
const std::string C_SET_AID1            = "ActorRuntimeID1"; 
const std::string C_SET_AID2            = "ActorRuntimeID2"; 
const std::string C_SET_AID3            = "ActorRuntimeID3"; 
const std::string C_SET_AID4            = "ActorRuntimeID4"; 
const std::string C_SET_OID				= "OrderID";
const std::string C_SET_TID				= "TipeID";
const std::string C_SET_DID				= "DetailID";
const std::string C_SET_WID				= "WeaponID";
const std::string C_SET_MID				= "MissileID";
const std::string C_SET_LID				= "LauncherID";
const std::string C_SET_MNUM			= "MissileNum";
const std::string C_SET_COUNT_YAKHONT	= "CountYakhont";
const std::string C_SET_SPEED			= "Speed";
const std::string C_SET_HEADING  		= "Heading";
const std::string C_SET_COURSE  		= "Course";
const std::string C_SET_PITCH    		= "Pitch";
const std::string C_SET_HEEL	  		= "Heel";
const std::string C_SET_LAUNCHED  		= "Launched";
const std::string C_SET_HAS_LAUNCHER    = "HasLauncher";
const std::string C_SET_LAUNCHER_TYPE   = "LauncherTypeName";
const std::string C_SET_INIT_HEADING	= "Init Heading";
const std::string C_SET_INIT_PITCH		= "Init Pitch";
const std::string C_SET_INIT_SWITCHNAME	= "Init SwitchName";
const std::string C_SET_IS_SENSOR_ACTIVE= "IsSensorActive";
const std::string C_SET_DAMAGE			= "Damage";
const std::string C_SET_LETHALITY		= "Lethality";

//Nando Added
const std::string C_SET_INIT_STEPMOVING		= "Step Moving";
const std::string C_SET_INIT_STEPHAFO		= "Step HAFO";
const std::string C_SET_INIT_STEPCRUISE		= "Step Cruise";
const std::string C_SET_INIT_STEPSEARCHING	= "Step Searching";
const std::string C_SET_INIT_STEPANGULAR	= "Step Angular";
const std::string C_SET_INIT_STEPAGILITY	= "Step Agility";

const std::string C_SET_INIT_STARTANGLE		= "Start Angle";
const std::string C_SET_INIT_ENDANGLE		= "End Angle";
const std::string C_SET_INIT_STARTPITCH		= "Start Pitch";
const std::string C_SET_INIT_ENDPITCH		= "End Pitch";

const std::string C_SET_ATTACH_DOF_NAME         = "AttachDOFName"; //Nama DOF tempat di-attach
const std::string C_SET_ALTITUDE  		        = "Altitude"; //Ketinggian object dari permukaan air laut
const std::string C_SET_ROLL                    = "Roll"; //Rotasi terhadap sumbu Y. Sama seperti Heel. Dibedakan karena istilah heel hanya berlaku pada kapal sedangkan roll pada semua benda.
const std::string C_SET_MAX_SPEED               = "Max Speed"; //Max speed
const std::string C_SET_ACCELERATION            = "Acceleration"; //Acceleration
const std::string C_SET_HEADING_SPEED           = "Heading Angular Speed"; //Angular speed
const std::string C_SET_MAX_HEADING_SPEED       = "Max Heading Angular Speed"; //Max angular speed
const std::string C_SET_HEADING_ACCELERATION    = "Heading Angular Acceleration"; //Angular acceleration 
const std::string C_SET_PITCH_SPEED             = "Pitch Angular Speed"; //Angular speed
const std::string C_SET_MAX_PITCH_SPEED         = "Max Pitch Angular Speed"; //Max angular speed
const std::string C_SET_PITCH_ACCELERATION      = "Pitch Angular Acceleration"; //Angular acceleration 
const std::string C_SET_ROLL_SPEED              = "Roll Angular Speed"; //Angular speed
const std::string C_SET_MAX_ROLL_SPEED          = "Max Roll Angular Speed"; //Max angular speed
const std::string C_SET_ROLL_ACCELERATION       = "Roll Angular Acceleration"; //Angular acceleration 
const std::string C_SET_INTENDED_PITCH          = "Intended Pitch"; //Intended pitch. For intended heading (course), we use "C_SET_COURSE"
const std::string C_SET_INTENDED_ROLL           = "Intended Roll"; //Intended roll. For intended heading (course), we use "C_SET_COURSE"
const std::string C_SET_MAX_LIFE_TYPE           = "Max Life Param Type"; //Life max param type
const std::string C_SET_MAX_LIFE_VALUE          = "Max Life Param Value"; //Life max value before expired
const std::string C_SET_TIME_LAUNCH             = "Time Since Launch"; //Time since the missile is launched
const std::string C_SET_DISTANCE_LAUNCH         = "Distance Since Launch"; //Distance covered since the missile is launched

const std::string C_MSG_YAKHONT_BEARING     	= "Yakhont_BearingToTarget";
const std::string C_MSG_YAKHONT_DISTANCE    	= "Yakhont_DistanceToTarget";
const std::string C_MSG_YAKHONT_MODE        	= "Yakhont_Mode";

const std::string C_MSG_C802_BEARING     	= "C802_BearingToTarget";
const std::string C_MSG_C802_DISTANCE    	= "C802_DistanceToTarget";

const std::string C_LOGIN_ANJUNGAN		= "ANJUNGAN";
const std::string C_LOGIN_OBSERVER  	= "OBSERVER";
const std::string C_LOGIN_TDS			= "TDS";

/////////////////////////////////////////////////////////////////////////////////////////////////////
//-- constant init folder
const std::string C_FOLDER_SHIP  			= "../data/mesh/KRI/";
const std::string C_FOLDER_WEAPON  			= "../data/mesh/Missile/";

//////////////////////////////////////////////////////////////////////////////////////////////////////
//-- constant init particles
const std::string C_PARTICLES_WAKE				= "wake.osg" ;
const std::string C_PARTICLES_MISSILE			= "missile.osg" ;  
const std::string C_PARTICLES_EXPLODE			= "splash.osg" ; 
const std::string C_PARTICLES_ASAP   			= "asap.osg" ; 
const std::string C_PARTICLES_SHIP_ESMOKE		= "shipesmoke.osg" ;

//eka
const std::string C_PARTICLES_RBU_EXPLODE	    = "RBUexplode.osg" ; 
const std::string C_PARTICLES_TORPEDO_EXPLODE	= "torpedoExplode.osg" ; 
const std::string C_PARTICLES_CANNON40_EXPLODE	= "40mmexplode.osg";
const std::string C_PARTICLES_WATER_EXPLODE		= "waterexplode.osg";

//nando
const std::string C_PARTICLES_CANNONSPOUTSMOKE  = "asapMeriamFire.osg";

const std::string C_PARTICLES_SUB_WAKE  		= "subbubble.osg" ; 
const std::string C_PARTICLES_SUB_DOWN  		= "subdown.osg" ; 

//////////////////////////////////////////////////////////////////////////////////////////////////////
//-- constant init dof transform
const std::string C_DOF_NAME_SHIP_BURITAN_KANAN		= "DOF_buritan_kanan";
const std::string C_DOF_NAME_SHIP_BURITAN_KIRI		= "DOF_buritan_kiri";
const std::string C_DOF_NAME_SHIP_LAMBUNG_KANAN		= "DOF_lambung_kanan";
const std::string C_DOF_NAME_SHIP_LAMBUNG_KIRI		= "DOF_lambung_kiri";
const std::string C_DOF_NAME_SHIP_HALU_KANAN		= "DOF_halu_kanan";
const std::string C_DOF_NAME_SHIP_HALU_KIRI			= "DOF_halu_kiri";

const std::string C_DOF_NAME_RBU_LAUNCHER_BASE_L	= "DOF_RBUBase_L";
const std::string C_DOF_NAME_RBU_LAUNCHER_BASE_R	= "DOF_RBUBase_R";
const std::string C_DOF_NAME_RBU_LAUNCHER_SPOUT		= "DOF_RBULauncher";

const std::string C_DOF_NAME_RBU_MISSILE_01  		= "DOF_RBUMissile1";
const std::string C_DOF_NAME_RBU_MISSILE_02  		= "DOF_RBUMissile2";
const std::string C_DOF_NAME_RBU_MISSILE_03  		= "DOF_RBUMissile3";
const std::string C_DOF_NAME_RBU_MISSILE_04  		= "DOF_RBUMissile4";
const std::string C_DOF_NAME_RBU_MISSILE_05  		= "DOF_RBUMissile5";
const std::string C_DOF_NAME_RBU_MISSILE_06  		= "DOF_RBUMissile6";
const std::string C_DOF_NAME_RBU_MISSILE_07  		= "DOF_RBUMissile7";
const std::string C_DOF_NAME_RBU_MISSILE_08  		= "DOF_RBUMissile8";
const std::string C_DOF_NAME_RBU_MISSILE_09  		= "DOF_RBUMissile9";
const std::string C_DOF_NAME_RBU_MISSILE_10  		= "DOF_RBUMissile10";
const std::string C_DOF_NAME_RBU_MISSILE_11  		= "DOF_RBUMissile11";
const std::string C_DOF_NAME_RBU_MISSILE_12  		= "DOF_RBUMissile12";


const std::string C_DOF_NAME_SUB_EFFECT_HALU		= "DOF_EfekHalu";// 
const std::string C_DOF_NAME_SUB_EFFECT_LAMBUNG		= "DOF_EfekLambung";// 
const std::string C_DOF_NAME_SUB_EFFECT_BURITAN		= "DOF_EfekBuritan";// 

const std::string C_DOF_NAME_MISSILE				= "DOF_MissileBelakang";// 

//-- constant init dof transform
//////////////////////////////////////////////////////////////////////////
//-- constant init switch model
//-- sayangnya ini juga di samakan dengan database untuk shipmodel actor init model switch
const std::string C_SwitchMeriam120		= "SwitchMeriam120";
const std::string C_SwitchMeriam76		= "SwitchMeriam76";
const std::string C_SwitchMeriam57		= "SwitchMeriam57";
const std::string C_SwitchMeriam40_1	= "SwitchMeriam40_1";
const std::string C_SwitchMeriam40_2	= "SwitchMeriam40_2";
const std::string C_SwitchMeriam40_3	= "SwitchMeriam40_3";
const std::string C_SwitchAsroc			= "SwitchAsroc";
const std::string C_SwitchRBU6000_1		= "SwitchRBU6000_1";
const std::string C_SwitchRBU6000_2		= "SwitchRBU6000_2";
const std::string C_SwitchStrela_1		= "SwitchStrela_1";
const std::string C_SwitchStrela_2		= "SwitchStrela_2";
const std::string C_SwitchTetral_1		= "SwitchTetral_1";
const std::string C_SwitchTetral_2		= "SwitchTetral_2";
const std::string C_SwitchMistral_1		= "SwitchMistral_1";
const std::string C_SwitchMistral_2		= "SwitchMistral_2";
//-- constant init switch model


//////////////////////////////////////////////////////////////////////////////////////////////////////

enum ModelType {MODE_SHIP,MODE_AIRCRAFT,MODE_TANK};
enum TypeActor {SHIP, ASROCKBODY, ASROCKSPOUT };
 

#define P(t) dtCore::RefPtr<t>

//const coordinat 0,0 di delta3D sama dengan berapa degree di peta / disable anggap 0,0 untuk 3D, set di lakukan 2D
//extern double C_RELATIVE_X;//= 118.5;  
//extern double C_RELATIVE_Y;//= -9.2;

//define konversi satuan
#define DEF_METRE_TO_DEGREE 1.0f/1852.0f/60.0f
#define DEF_DEGREE_TO_METRE 111000.0f

#define DEF_METER_TO_FEET 3.2808399f
#define DEF_FEET_TO_METER 0.3048f

#define DEF_MACH_TO_METRE 340.3f
#define DEF_MACH_TO_KNOT 666.0f
#define DEF_KNOT_TO_METRE 0.5144f 

#define DEF_DM_TO_METRE 1828.80f
#define DEF_KM_TO_METRE 1000.0f
//const float C_METRE_TO_DEGREE= 1/1852 * 1/60;

//jeda looping antara pengiriman posisi (berapa banyak looping yang diperlukan sebelum mengirimkan posisi)
//const unsigned int C_UPDATEALLOBJECT_CYCLE_TIME= 60;
//const unsigned int C_UPDATEALLOBJECT_CYCLE_TIME_3D = 180;
const unsigned int C_UPDATEALLOBJECT_CYCLE_TIME= 60; //BAWE
const float C_UPDATEALLOBJECT_CYCLE_TIME_3D = 2.0f; //BAWE = 2.0 sec

const unsigned int C_UPDATEALLOBJECT_CYCLE_TIME_SHIP	= 3;
const unsigned int C_UPDATEALLOBJECT_CYCLE_TIME_MISSILE = 2;