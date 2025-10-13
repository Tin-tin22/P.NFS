#include "SimActorDefinitions.h"


////////////////////////////////////////////////////////////////
// Constructor / Destructor
SimStaticObject::SimStaticObject()
	: mName("")
	, mMesh("")
	, mTranslationXYZ()
	, mRotationHPR()
{

}

SimStaticObject::~SimStaticObject()
{

}

SimOceanConfig::SimOceanConfig()
	: mFFTGridSize(64)
	, mResolution(256)
	, mNumTiles(17)
	, mWindDirection(osg::Vec2f(1.0f,1.0f))
	, mWindSpeed(12.f)
	, mDepth(10000)
	, mWaveScale((float)1e-8)
	, mIsChoppy(true)
	, mChoppyFactor(-2.5f)
	, mAnimLoopTime(10.0f)
	, mNumFrames(256)
	, mFoamBottomHeight(2.2f)
	, mFoamTopHeight(3.0f)
	, mEnableCrestFoam(true)
	, mEnableEndlessOcean(true)
	, mOceanHeight(0)
	, mSeaState(1)
	////////////////////////////////////////////////////////////////
	//Skybox
	, mSkyBoxRadius(1900.f)
	, mSkyBoxLongSteps(16)
	, mSkyBoxLatSteps(16)
	, mTexUp("")
	, mTexDown("")
	, mTexLeft("")
	, mTexRight("")
	, mTexFront("")
	, mTexBack("")
	////////////////////////////////////////////////////////////////
	//Lighting
	, mLightColor(osg::Vec4(0.5f, 0.5f, 0.6f, 1))
	, mSunDirection(osg::Vec3(520.f, 1900.f, 550.f))
	, mSunDiffuseColor(osg::Vec4(0.7f, 0.7f, 0.7f, 1))
	, mSunAmbientColor(osg::Vec4(0.3f, 0.3f, 0.3f, 1.0f))
	, mSunSpecularColor(osg::Vec4(0.1f, 0.1f, 0.1f, 1.0f))	  
	, mUnderWaterDiffuseColor(osg::Vec4(0.1f, 0.3f, 0.4f, 1))
	, mUnderWaterAttentuation(osg::Vec3f(0.015f, 0.0075f, 0.005f))
	, mEnableUnderwaterDOF(true)
	, mEnableReflections(true)
	, mReflectionDamping(0.35f)
	, mEnableRefractions(true)
	, mEnableGodRays(true)
	, mEnableSilt(true)  
	, mEnableGlare(true)
	, mEnableGlow(false)				///<enable_glow attribute of lighting tag //  
	, mGlareAttentuation(0.8f)
	, mUseDefaultSceneShader(true)
	, mIsNightScene(false) 
	////////////////////////////////////////////////////////////////
	//Fog
	, mAboveWaterFogHeight(0.0012f)
	, mAboveWaterFogColor(osg::Vec4(0.8f, 0.9f, 0.9f, 1))
	, mUnderWaterFogHeight(0.002f)   
	, mUnderWaterFogColor(osg::Vec4(0.1f, 0.2f, 0.4f, 1))
{

}

SimOceanConfig::~SimOceanConfig()
{

}

SimActorShipDef::SimActorShipDef()
	: mTypeActor(SHIP)
	, shipID(0)
	, Name("")
	, CategoryName("")
	, Category("")
	, MeshName("")
	, translation(osg::Vec3())
	, rotation(osg::Vec3())
	, idCount(0)
	, length(100.0f) 
	, width(5.0f)
	, height(20.0f)
	, max_ahead(24.0f) 
	, max_astern(-12.0f)
	, max_steer(45.0f)
	, speed(0.0f)
	, damage(0)
	//, control_type(didJoystickComponent::eJoystickType::RUDDER)  
	, mCompDefWeaponShip()
	, mCompDefMissile()
{
	mCameras.clear();
	mCompDefChilds.clear();

	mCompDefWeaponShip.clear();
	mCompDefMissile.clear();
};


SimActorMissileDef::SimActorMissileDef()
	: VehicleID(0)
	, WeaponID(0)
	, LauncherID(0)
	, MissileID(0)
	, POS_Heading(0)
	, POS_Pitch(0)
	, Lethality(0)
	, MissileName("")
	, MeshName("")
	, DOFName("")
	, IsHasLauncher(false)
{

};

//Nando Added
NGSPos::NGSPos()
  : id(0)
  , idTheme(0)
  , PosX(0.0f)
  , PosY(0.0f)
  , PosZ(0.0f)
{

}

PWaypoint::PWaypoint()
: x(0)
, y(0)
, z(0.0f)
{

}

SimActorWeaponDef::SimActorWeaponDef()
	: Weapon_ShipID(0)
	, Weapon_ID(0)
	, Weapon_Launcher(0)
	, Weapon_Name("")
	, CountFire(0)
	, CountRBU(0)
	, Lethality(0)
	, isFire(false)
	, launchFire(false)
	, firstLaunch(true)
	, isRelease(false)
{
	LauncherYakhont[0] = 0;
	LauncherYakhont[1] = 0;
	LauncherYakhont[2] = 0;
	LauncherYakhont[3] = 0;
};

void SimActorShipDef::SetTypeActor(TypeActor type)
{ 
	mTypeActor = type ; 
};

TypeActor SimActorShipDef::GetTypeActor()
{ 
	return mTypeActor; 
};

void SimActorShipDef::AddCompDefChild(SimActorShipDef* actDef)
{
	mCompDefChilds.push_back(actDef);
};

void SimActorShipDef::AddWeaponOnShip(SimActorWeaponDef* actDef)
{
	mCompDefWeaponShip.push_back(actDef);
};

int SimActorShipDef::GetLastMissileNum(const int mVehicleID,const int mWeaponID,const int mLauncherID,const int mMissileID)
{
	int newNum = 0 ;

	for(std::vector<SimActorMissileDef*>::iterator iter=mCompDefMissile.begin(); 
		iter!=mCompDefMissile.end(); iter++ )
	{
		if ( (*iter)->VehicleID == mVehicleID && (*iter)->WeaponID == mWeaponID ) // && 
			 // (*iter)->LauncherID == mLauncherID && (*iter)->MissileID == mMissileID ){
			 // (*iter)->LauncherID == mLauncherID ){
		{
			if ( (*iter)->MissileNum > newNum  )
				  
				newNum = (*iter)->MissileNum ;
		}
	}

	return newNum + 1;
};

void SimActorShipDef::AddMissileOnShip(SimActorMissileDef* actDef)
{
	mCompDefMissile.push_back(actDef);
};

bool SimActorShipDef::isRoot() 
{
	return true;
};
