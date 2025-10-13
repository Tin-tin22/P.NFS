#pragma once

#include <vector>
#include <dtCore/Transform.h>
#include <dtGame/gameactor.h>

#include <iostream>

#include "../didCommon/BaseConstant.h"

class SimActorCamera{
  public :
    std::string Name ;
	  osg::Vec3 camtranslation;
};

/**
* Environment struct.
* sebelumnya oceanConfig.xml 
*/
struct SimOceanConfig
{
	////////////////////////////////////////////////////////////////////
	// VARIABLES

	////////////////////////////////////////////////////////////////
	//Ocean surface
	int mFFTGridSize;
	int mResolution;
	int mNumTiles;

	osg::Vec2f mWindDirection;
	float mWindSpeed;
	float mDepth;

	float mWaveScale;

	bool mIsChoppy;
	float mChoppyFactor;

	float mAnimLoopTime;
	int mNumFrames;

	float mFoamBottomHeight;
	float mFoamTopHeight;
	bool mEnableCrestFoam;

	bool mEnableEndlessOcean;
	float mOceanHeight;
	int mSeaState;

	////////////////////////////////////////////////////////////////
	//Skybox
	int mSkyBoxRadius;
	int mSkyBoxLongSteps;
	int mSkyBoxLatSteps;

	std::string mTexUp;
	std::string mTexDown;
	std::string mTexLeft;
	std::string mTexRight;
	std::string mTexFront;
	std::string mTexBack;

	////////////////////////////////////////////////////////////////
	//Lighting
	osg::Vec4f mLightColor;

	osg::Vec3 mSunDirection;
	osg::Vec4f mSunDiffuseColor;
	osg::Vec4f mSunAmbientColor;
	osg::Vec4f mSunSpecularColor;

	osg::Vec4f mUnderWaterDiffuseColor;
	osg::Vec3 mUnderWaterAttentuation;
	bool mEnableUnderwaterDOF;

	bool mEnableReflections;
	float mReflectionDamping;

	bool mEnableRefractions;
	bool mEnableGodRays;
	bool mEnableSilt;

	bool mEnableGlare;
	bool mEnableGlow;				///<enable_glow attribute of lighting tag // BAWE:20110809
	float mGlareAttentuation;

	bool mUseDefaultSceneShader;

	bool mIsNightScene;

	////////////////////////////////////////////////////////////////
	//Fog
	float mAboveWaterFogHeight;
	osg::Vec4f mAboveWaterFogColor;

	float mUnderWaterFogHeight;
	osg::Vec4f mUnderWaterFogColor;

	////////////////////////////////////////////////////////////////////
	// METHODS

	////////////////////////////////////////////////////////////////
	// Constructor / Destructor
	SimOceanConfig();

	~SimOceanConfig();

};

struct SimStaticObject
{
	std::string		mName;
	std::string		mMesh;
	osg::Vec3f		mTranslationXYZ;
	osg::Vec3f		mRotationHPR;

	////////////////////////////////////////////////////////////////
	SimStaticObject();
	~SimStaticObject();
};

class SimActorMissileDef{
	public : 
		SimActorMissileDef();
		~SimActorMissileDef(){};
	private : 
	protected : 
	public :
		int VehicleID;
		int WeaponID;
		int LauncherID;
		int MissileID;
		int MissileNum;

		int POS_Heading;
		int POS_Pitch;
		int Lethality;

		std::string MissileName ;
		std::string MeshName;
		std::string DOFName;

		bool IsHasLauncher ;

};


/*
	Nando Added For Database
*/
class NGSPos 
{
public :
	NGSPos();
	~NGSPos(){};
private :
protected :
public :
	int id;
	int idTheme;
	int PosX;
	int PosY;
	int PosZ;
};

// - Points of Waypoint [7/17/2014 EKA]
class PWaypoint
{
public : 
	PWaypoint();
	~PWaypoint(){};
	double x, y, z;
};

class SimActorWeaponDef{
	public : 
		SimActorWeaponDef();
		~SimActorWeaponDef(){};
	private : 
	protected : 
	public :
		int DatabaseID;
		int Weapon_ShipID;
		int Weapon_ID; /// ActTypeID
		int Weapon_Launcher;
		int Weapon_ModelID1;
		int Weapon_ModelID2;
		int Weapon_DOFID1;
		int Weapon_DOFID2;
		int Weapon_SwitchID;

		//For TimeSalvo
		float IntervalTimeSalvo;
		float IntervalSalvo;

		bool isFirst;
		int i_launcher;

		//bool isFirst;
		//int i_launcher;

		//For Gun
		//float CountFire;
		int CountFire;
		bool isFire;

		//For RBU [7/27/2012 DID RKT2]
		int CountRBU;
		int TypeRBU;
		float DepthRBU;
		float rangeRBU,bearingRBU;

		bool launchFire;
		bool firstLaunch;
		bool isRelease;

		// For Yakhont [7/30/2012 DID RKT2]
		int LauncherYakhont[4];
		double bearing, range;

		float StartAngle;
		float EndAngle;
		float StartPitch;
		float EndPitch;

		int POS_Heading;
		int POS_Pitch;
		int Lethality;

		std::string Weapon_Name ;
		std::string MeshName1;
		std::string MeshName2;
		std::string DOFName1;
		std::string DOFName2;
		std::string SwitchName;

		bool is3DActor ; // sementara pasti 3DActor
		
};

/**
	class manager component actor  
**/
 
class SimActorShipDef
{
	public :
		SimActorShipDef();
		~SimActorShipDef(){};
	private :
		TypeActor mTypeActor;
	protected :
	public :
		int shipID;
		int idCount;
		int modelID;
		int damage;
 
		std::string Name;
		std::string CategoryName;
		std::string Category;
		std::string MeshName;
		osg::Vec3 translation;
		osg::Vec3 rotation;
		 
		std::vector<SimActorCamera*> mCameras; 
		std::vector<SimActorShipDef*> mCompDefChilds; 

		//Nando Added For Weapon Container
		std::vector<SimActorWeaponDef*> mCompDefWeaponShip; 
		std::vector<SimActorMissileDef*> mCompDefMissile; 

		bool isRoot();

		float length, width, height;
		float max_ahead, max_astern, max_steer;
		float speed;
		
		bool isTargetActor ;

		//didJoystickComponent::eJoystickType control_type; 

		TypeActor GetTypeActor() ;
		void SetTypeActor(TypeActor type);

		void AddCompDefChild(SimActorShipDef* actDef);

		//Nando Added
		void AddWeaponOnShip(SimActorWeaponDef* actDef);

		void AddMissileOnShip(SimActorMissileDef* actDef);

		int GetLastMissileNum(const int mVehicleID,const int mWeaponID,const int mLauncherID,const int mMissileID);

		SimActorCamera* GetCameraFromName(std::string name)
		{
			for(std::vector<SimActorCamera*>::iterator iter=mCameras.begin(); 
				iter!=mCameras.end(); iter++ )
			if ((*iter)->Name == name){
			  return *iter;
			}

			return NULL;
		};

		
};