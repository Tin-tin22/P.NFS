#include "oceanconfigactor.h"

#include "../didCommon/BaseConstant.h"

using namespace didEnviro;

// Ocean change bitmask constants
// Note: for skybox, change to enumerated skybox (SKY_FINE, SKY_CLOUD, NIGHT, etc). DONOT CHANGE THE 6 TEXTURE DIRECTLY. Read from database for the enums and skybox.

const unsigned long long OceanConfigActor::OCEAN_NO_CHANGE                 = (unsigned long long) 0x000000000000; //NO CHANGE
const unsigned long long OceanConfigActor::OCEAN_INIT                      = (unsigned long long) 0xFFFFFFFFFFFF; //USED FOR INITIALIZATION / OCEAN BUILDING. IGNORE OTHER MASK. CALLS OceanActor::Build() INSTEAD OF CHANGING ONE AT A TIME.
const unsigned long long OceanConfigActor::OCEAN_FFT_GRID_SIZE             = (unsigned long long) 0x000000000001; 
const unsigned long long OceanConfigActor::OCEAN_RESOLUTION                = (unsigned long long) 0x000000000002; 
const unsigned long long OceanConfigActor::OCEAN_NUM_TILES                 = (unsigned long long) 0x000000000004; 
const unsigned long long OceanConfigActor::OCEAN_WIND_DIRECTION            = (unsigned long long) 0x000000000008; 
const unsigned long long OceanConfigActor::OCEAN_WIND_SPEED                = (unsigned long long) 0x000000000010; 
const unsigned long long OceanConfigActor::OCEAN_DEPTH                     = (unsigned long long) 0x000000000020; 
const unsigned long long OceanConfigActor::OCEAN_WAVE_SCALE                = (unsigned long long) 0x000000000040; 
const unsigned long long OceanConfigActor::OCEAN_IS_CHOPPY                 = (unsigned long long) 0x000000000080; 
const unsigned long long OceanConfigActor::OCEAN_CHOPPY_FACTOR             = (unsigned long long) 0x000000000100; 
const unsigned long long OceanConfigActor::OCEAN_ANIM_LOOP_TIME            = (unsigned long long) 0x000000000200; 
const unsigned long long OceanConfigActor::OCEAN_NUM_FRAMES                = (unsigned long long) 0x000000000400; 
const unsigned long long OceanConfigActor::OCEAN_SKYBOX_TYPE               = (unsigned long long) 0x000000000800; //NOT IMPLEMENTED YET! USED TO CHANGE THE SKYBOX TEXTURES BASED ON THE TYPE.
const unsigned long long OceanConfigActor::OCEAN_FOAM_BOTTOM_HEIGHT        = (unsigned long long) 0x000000001000; 
const unsigned long long OceanConfigActor::OCEAN_FOAM_TOP_HEIGHT           = (unsigned long long) 0x000000002000; 
const unsigned long long OceanConfigActor::OCEAN_ENABLE_CREST_FOAM         = (unsigned long long) 0x000000004000; 
const unsigned long long OceanConfigActor::OCEAN_LIGHT_COLOR               = (unsigned long long) 0x000000008000; 
const unsigned long long OceanConfigActor::OCEAN_ENABLE_ENDLESS_OCEAN      = (unsigned long long) 0x000000010000; 
const unsigned long long OceanConfigActor::OCEAN_ENABLE_REFLECTIONS        = (unsigned long long) 0x000000020000; 
const unsigned long long OceanConfigActor::OCEAN_REFLECTION_DAMPING        = (unsigned long long) 0x000000040000; 
const unsigned long long OceanConfigActor::OCEAN_ENABLE_REFRACTIONS        = (unsigned long long) 0x000000080000; 
const unsigned long long OceanConfigActor::OCEAN_ABOVEWATER_FOG_HEIGHT     = (unsigned long long) 0x000000100000; 
const unsigned long long OceanConfigActor::OCEAN_UNDERWATER_FOG_HEIGHT     = (unsigned long long) 0x000000200000; 
const unsigned long long OceanConfigActor::OCEAN_ABOVEWATER_FOG_COLOR      = (unsigned long long) 0x000000400000; 
const unsigned long long OceanConfigActor::OCEAN_UNDERWATER_FOG_COLOR      = (unsigned long long) 0x000000800000; 
const unsigned long long OceanConfigActor::OCEAN_UNDERWATER_DIFFUSE_COLOR  = (unsigned long long) 0x000001000000; 
const unsigned long long OceanConfigActor::OCEAN_UNDERWATER_ATTENUATION    = (unsigned long long) 0x000002000000; 
const unsigned long long OceanConfigActor::OCEAN_SUN_DIRECTION             = (unsigned long long) 0x000004000000; 
const unsigned long long OceanConfigActor::OCEAN_ENABLE_GODRAYS            = (unsigned long long) 0x000008000000; 
const unsigned long long OceanConfigActor::OCEAN_ENABLE_SILT               = (unsigned long long) 0x000010000000; 
const unsigned long long OceanConfigActor::OCEAN_ENABLE_UNDERWATER_DOF     = (unsigned long long) 0x000020000000; 
const unsigned long long OceanConfigActor::OCEAN_ENABLE_GLARE              = (unsigned long long) 0x000040000000; 
const unsigned long long OceanConfigActor::OCEAN_GLARE_ATTENUATION         = (unsigned long long) 0x000080000000;
const unsigned long long OceanConfigActor::OCEAN_SKYBOX_RADIUS             = (unsigned long long) 0x000100000000; 
const unsigned long long OceanConfigActor::OCEAN_SKYBOX_LONG_STEPS         = (unsigned long long) 0x000200000000; 
const unsigned long long OceanConfigActor::OCEAN_SKYBOX_LAT_STEPS          = (unsigned long long) 0x000400000000; 
const unsigned long long OceanConfigActor::OCEAN_SUN_DIFFUSE_COLOR         = (unsigned long long) 0x000800000000; 
const unsigned long long OceanConfigActor::OCEAN_SUN_AMBIENT_COLOR         = (unsigned long long) 0x001000000000; 
const unsigned long long OceanConfigActor::OCEAN_SUN_SPECULAR_COLOR        = (unsigned long long) 0x002000000000; 
const unsigned long long OceanConfigActor::OCEAN_USE_DEFAULT_SCENE_SHADER  = (unsigned long long) 0x004000000000; 
const unsigned long long OceanConfigActor::OCEAN_OCEAN_HEIGHT              = (unsigned long long) 0x008000000000; 
const unsigned long long OceanConfigActor::OCEAN_SEA_STATE                 = (unsigned long long) 0x010000000000; 
const unsigned long long OceanConfigActor::OCEAN_ENABLE_GLOW               = (unsigned long long) 0x020000000000; 
 

//++++++++++++++++++++++ ON_THE_FLY_OCEAN_CONTROL_2: SEA_STATE
const struct OceanSeaState OceanConfigActor::mSeaStateData[10] = 
{
    OceanSeaState( 1e-009,   1.5f,  0.5f ),
    OceanSeaState( 1e-009,   5.0f,  1.5f ),
    OceanSeaState( 1e-009,   8.0f,  3.0f ),
    OceanSeaState( 2e-009,   9.0f,  3.0f ),
    OceanSeaState( 3e-009,   10.5f,  3.0f ),
    OceanSeaState( 5e-009,   12.0f,  3.0f ),
    OceanSeaState( 5e-009,   14.5f,  3.0f ),
    OceanSeaState( 5e-009,   18.0f,  3.5f ),
    OceanSeaState( 5e-009,   20.5f,  4.0f ),
    OceanSeaState( 5e-009,   23.5f,  5.0f )
    
    //OceanSeaState( 1e-009,   0.5f,  0.5f ),
    //OceanSeaState( 1e-009,   1.5f,  1.5f ),
    //OceanSeaState( 5e-009,   2.5f,  1.5f ),
    //OceanSeaState( 5e-009,   4.0f,  2.5f ),
    //OceanSeaState( 5e-009,   5.0f,  2.5f ),
    //OceanSeaState( 5e-009,   6.0f,  3.0f ),
    //OceanSeaState( 5e-009,   7.0f,  3.0f ),
    //OceanSeaState( 5e-009,   8.0f,  3.5f ),
    //OceanSeaState( 1e-008,   9.5f,  4.0f ),
    //OceanSeaState( 5e-008,   11.0f,  5.0f )
};


//const float OceanConfigActor::mSeaStateData[1].mWaveScale = 1e-009;
//const float OceanConfigActor::mSeaStateData[2].mWaveScale = 5e-009;
//const float OceanConfigActor::mSeaStateData[3].mWaveScale = 5e-009;
//const float OceanConfigActor::mSeaStateData[4].mWaveScale = 1e-008;
//const float OceanConfigActor::mSeaStateData[5].mWaveScale = 1e-008;
//const float OceanConfigActor::mSeaStateData[6].mWaveScale = 5e-008;
//const float OceanConfigActor::mSeaStateData[7].mWaveScale = 5e-008;
//const float OceanConfigActor::mSeaStateData[8].mWaveScale = 1e-007;
//const float OceanConfigActor::mSeaStateData[9].mWaveScale = 1e-007;
//
//const float OceanConfigActor::mSeaStateData[0].mWindSpeed = 1.0f;
//const float OceanConfigActor::mSeaStateData[1].mWindSpeed = 2.0f;
//const float OceanConfigActor::mSeaStateData[2].mWindSpeed = 2.0f;
//const float OceanConfigActor::mSeaStateData[3].mWindSpeed = 2.0f;
//const float OceanConfigActor::mSeaStateData[4].mWindSpeed = 3.0f;
//const float OceanConfigActor::mSeaStateData[5].mWindSpeed = 3.0f;
//const float OceanConfigActor::mSeaStateData[6].mWindSpeed = 3.0f;
//const float OceanConfigActor::mSeaStateData[7].mWindSpeed = 5.0f;
//const float OceanConfigActor::mSeaStateData[8].mWindSpeed = 5.0f;
//const float OceanConfigActor::mSeaStateData[9].mWindSpeed = 5.0f;
//
//const float OceanConfigActor::mSeaStateData[0].mWindLength = 1.0f;
//const float OceanConfigActor::mSeaStateData[1].mWindLength = 2.0f;
//const float OceanConfigActor::mSeaStateData[2].mWindLength = 3.0f;
//const float OceanConfigActor::mSeaStateData[3].mWindLength = 4.0f;
//const float OceanConfigActor::mSeaStateData[4].mWindLength = 5.0f;
//const float OceanConfigActor::mSeaStateData[5].mWindLength = 6.0f;
//const float OceanConfigActor::mSeaStateData[6].mWindLength = 7.0f;
//const float OceanConfigActor::mSeaStateData[7].mWindLength = 8.0f;
//const float OceanConfigActor::mSeaStateData[8].mWindLength = 9.0f;
//const float OceanConfigActor::mSeaStateData[9].mWindLength = 10.0f;

//-- BAWE-20110502: ON_THE_FLY_OCEAN_CONTROL_2: SEA_STATE

const std::string OceanConfigActor::CLASS_NAME("didEnviro::OceanConfigActor");

OceanConfigActor::OceanConfigActor()
   : BaseClass()
//OceanConfigActor::OceanConfigActor(dtGame::GameActorProxy& proxy)
//   : BaseClass(proxy)
   , mFFTGridSize(64)
   , mResolution(256)
   , mNumTiles(17)
   , mWindDirection(osg::Vec2f(1.0f,1.0f))
   //, mWindSpeed(12.f)
   , mWindSpeed(6.0f)
   , mDepth(10000)
   , mWaveScale((float)1e-8)
   //, mWaveScale((float)1e-9)
   , mIsChoppy(true)
   , mChoppyFactor(-2.5f)
   , mAnimLoopTime(10.0f)
   , mNumFrames(256)
   , mFoamBottomHeight(2.2f)
   , mFoamTopHeight(3.0f)
   , mEnableCrestFoam(true)
   , mLightColor(osg::Vec4(0.5f, 0.5f, 0.6f, 1)) //default
   , mEnableEndlessOcean(true)
   , mEnableReflections(true)
   , mEnableRefractions(true)
   , mAboveWaterFogHeight(0.0012f)//default
   , mUnderWaterFogHeight(0.002f)
   , mAboveWaterFogColor(osg::Vec4(0.8f, 0.9f, 0.9f, 1)) //default
   , mUnderWaterFogColor(osg::Vec4(0.1f, 0.2f, 0.4f, 1))
   , mUnderWaterDiffuseColor(osg::Vec4(0.1f, 0.3f, 0.4f, 1))
   , mUnderWaterAttentuation(osg::Vec3f(0.015f, 0.0075f, 0.005f))
   , mSunDirection(osg::Vec3(520.f, 1900.f, 500.f)) 
   , mEnableGodRays(true)
   , mEnableSilt(true)
   , mEnableUnderwaterDOF(true)
   , mEnableGlare(true)
   , mEnableGlow(false) // BAWE-20110809: GLOW_SHADER
   , mGlareAttentuation(0.8f)
   //, mSkyBoxRadius(1900.f) //default
   , mSkyBoxRadius(2500.f)
   , mSkyBoxLongSteps(16)
   , mSunDiffuseColor(osg::Vec4(0.7f, 0.7f, 0.7f, 1))//default
   , mSunAmbientColor(osg::Vec4(0.3f, 0.3f, 0.3f, 1.0f))
   , mSunSpecularColor(osg::Vec4(0.1f, 0.1f, 0.1f, 1.0f))	  
   , mSkyBoxLatSteps(16)
   , mUseDefaultSceneShader(true)
   , mReflectionDamping(0.35f)
   , mOceanHeight(0)
   , mTexUp("../data/textures/sky_def/up.png")
   , mTexDown("../data/textures/sky_def/down.png")
   , mTexLeft("../data/textures/sky_def/west.png")
   , mTexRight("../data/textures/sky_def/east.png")
   , mTexFront("../data/textures/sky_def/north.png")
   , mTexBack("../data/textures/sky_def/south.png")
   , mIsDirty(true)
   , mOceanChangeFlags(OCEAN_NO_CHANGE)
   , mSeaState(0)
{
   SetName(C_CN_OCEAN_CFG);
}

void OceanConfigActor::SetWindOrientation(const float angle)
{
    osg::Vec2 wind = GetWindDirection();
    float windLength = wind.normalize();
    float x = cos(osg::DegreesToRadians(angle)) * 1.0f * windLength;
    float y = sin(osg::DegreesToRadians(angle)) * 1.0f * windLength;
    osg::Vec2 newWind(x, y);
    SetWindDirection(newWind);
}

float OceanConfigActor::GetWindOrientation() const
{
    osg::Vec2 wind = GetWindDirection();
    wind.normalize();
    return (osg::RadiansToDegrees(atan(wind.y() / wind.x())));
}

void OceanConfigActor::SetSunDirection(const osg::Vec3& c) 
{ 
	mSunDirection = c; 
	SetDirty(true); 
	AddMask(OCEAN_SUN_DIRECTION);
}

void OceanConfigActor::SetWindLength(const float length)
{
    osg::Vec2 wind = GetWindDirection();
    float windLength = wind.normalize();
    wind.set(wind.x() * length, wind.y() * length);
    SetWindDirection(wind);
}

float OceanConfigActor::GetWindLength() const
{
    osg::Vec2 wind = GetWindDirection();
    return (wind.normalize());    
}
// --------------------------------------------

OceanConfigActorProxy::OceanConfigActorProxy()
   : BaseClass()
{
   SetClassName("didEnviro::OceanConfigActor");
}


OceanConfigActorProxy::~OceanConfigActorProxy()
{
}


void OceanConfigActorProxy::CreateActor()
{
   SetActor(*new OceanConfigActor());
   //OceanConfigActor* actor = new OceanConfigActor(*this);
   //SetActor(*actor);
}


void OceanConfigActorProxy::BuildPropertyMap()
{
   //BaseClass::BuildPropertyMap();
   static const std::string GROUPNAME = C_OCEAN_CAT;
   static const std::string GROUPNAME_SKY = "SkyBox";

   using namespace dtDAL;

   OceanConfigActor* actor;
   GetActor(actor);

   //AddProperty(new dtDAL::BooleanActorProperty("Ocean Config Dirty Bool", "Ocean Config Dirty Bool",
   //    dtDAL::BooleanActorProperty::SetFuncType(actor, &OceanConfigActor::SetOceanHeight),
   //    dtDAL::BooleanActorProperty::GetFuncType(actor, &OceanConfigActor::GetOceanHeight),
   //    "Height of the ocean's surface",
   //    GROUPNAME));

   //AddProperty(new dtDAL::DoubleActorProperty("Ocean Height", "Ocean Height",
   //   dtDAL::DoubleActorProperty::SetFuncType(actor, &OceanConfigActor::SetOceanHeight),
   //   dtDAL::DoubleActorProperty::GetFuncType(actor, &OceanConfigActor::GetOceanHeight),
   //   "Height of the ocean's surface",
   //   GROUPNAME));

   AddProperty(new dtDAL::FloatActorProperty("Ocean Height", "Ocean Height",
      dtDAL::FloatActorProperty::SetFuncType(actor, &OceanConfigActor::SetOceanHeight),
      dtDAL::FloatActorProperty::GetFuncType(actor, &OceanConfigActor::GetOceanHeight),
      "Height of the ocean's surface",
      GROUPNAME));

   AddProperty(new dtDAL::BooleanActorProperty("Use Default Scene Shader", "Use Default Scene Shader",
      dtDAL::BooleanActorProperty::SetFuncType(actor, &OceanConfigActor::SetUseDefaultSceneShader),
      dtDAL::BooleanActorProperty::GetFuncType(actor, &OceanConfigActor::GetUseDefaultSceneShader),
      "",
      GROUPNAME));

   AddProperty(new dtDAL::BooleanActorProperty("Enable Crest Foam", "Enable Crest Foam",
      dtDAL::BooleanActorProperty::SetFuncType(actor, &OceanConfigActor::SetEnableCrestFoam),
      dtDAL::BooleanActorProperty::GetFuncType(actor, &OceanConfigActor::GetEnableCrestFoam),
      "Render foam on the crests",
      GROUPNAME));

   AddProperty(new dtDAL::BooleanActorProperty("Enable Endless Ocean", "Enable Endless Ocean",
      dtDAL::BooleanActorProperty::SetFuncType(actor, &OceanConfigActor::SetEnableEndlessOcean),
      dtDAL::BooleanActorProperty::GetFuncType(actor, &OceanConfigActor::GetEnableEndlessOcean),
      "",
      GROUPNAME));

   AddProperty(new dtDAL::BooleanActorProperty("Enable Reflections", "Enable Reflections",
      dtDAL::BooleanActorProperty::SetFuncType(actor, &OceanConfigActor::SetEnableReflections),
      dtDAL::BooleanActorProperty::GetFuncType(actor, &OceanConfigActor::GetEnableReflections),
      "",
      GROUPNAME));

    AddProperty(new dtDAL::FloatActorProperty("Reflection Damping", "Reflection Damping",
      dtDAL::FloatActorProperty::SetFuncType(actor, &OceanConfigActor::SetReflectionDamping),
      dtDAL::FloatActorProperty::GetFuncType(actor, &OceanConfigActor::GetReflectionDamping),
      "",
      GROUPNAME));

   AddProperty(new dtDAL::BooleanActorProperty("Enable Refractions", "Enable Refractions",
      dtDAL::BooleanActorProperty::SetFuncType(actor, &OceanConfigActor::SetEnableRefractions),
      dtDAL::BooleanActorProperty::GetFuncType(actor, &OceanConfigActor::GetEnableRefractions),
      "",
      GROUPNAME));

   AddProperty(new dtDAL::BooleanActorProperty("Enable God Rays", "Enable God Rays",
      dtDAL::BooleanActorProperty::SetFuncType(actor, &OceanConfigActor::SetEnableGodRays),
      dtDAL::BooleanActorProperty::GetFuncType(actor, &OceanConfigActor::GetEnableGodRays),
      "",
      GROUPNAME));

   AddProperty(new dtDAL::BooleanActorProperty("Enable Silt", "Enable Silt",
      dtDAL::BooleanActorProperty::SetFuncType(actor, &OceanConfigActor::SetEnableSilt),
      dtDAL::BooleanActorProperty::GetFuncType(actor, &OceanConfigActor::GetEnableSilt),
      "",
      GROUPNAME));

   AddProperty(new dtDAL::BooleanActorProperty("Enable Underwater DOF", "Enable Underwater DOF",
      dtDAL::BooleanActorProperty::SetFuncType(actor, &OceanConfigActor::SetEnableUnderwaterDOF),
      dtDAL::BooleanActorProperty::GetFuncType(actor, &OceanConfigActor::GetEnableUnderwaterDOF),
      "Enable underwater depth of field",
      GROUPNAME));

   AddProperty(new dtDAL::BooleanActorProperty("Enable Glare", "Enable Glare",
      dtDAL::BooleanActorProperty::SetFuncType(actor, &OceanConfigActor::SetEnableGlare),
      dtDAL::BooleanActorProperty::GetFuncType(actor, &OceanConfigActor::GetEnableGlare),
      "Enable cross hatch glare.",
      GROUPNAME));

   //++++++++ GLOW_SHADER
   AddProperty(new dtDAL::BooleanActorProperty("Enable Glow", "Enable Glow",
       dtDAL::BooleanActorProperty::SetFuncType(actor, &OceanConfigActor::SetEnableGlow),
       dtDAL::BooleanActorProperty::GetFuncType(actor, &OceanConfigActor::GetEnableGlow),
       "Enable glow effect.",
       GROUPNAME));
   //++++++++ GLOW_SHADER

   AddProperty(new dtDAL::IntActorProperty("FFT Grid Size", "FFT Grid Size",
      dtDAL::IntActorProperty::SetFuncType(actor, &OceanConfigActor::SetFFTGridSize),
      dtDAL::IntActorProperty::GetFuncType(actor, &OceanConfigActor::GetFFTGridSize),
      "",
      GROUPNAME));

   AddProperty(new dtDAL::IntActorProperty("Resolution", "Resolution",
      dtDAL::IntActorProperty::SetFuncType(actor, &OceanConfigActor::SetResolution),
      dtDAL::IntActorProperty::GetFuncType(actor, &OceanConfigActor::GetResolution),
      "",
      GROUPNAME));

   AddProperty(new dtDAL::IntActorProperty("Number of Tiles", "Number of Tiles",
      dtDAL::IntActorProperty::SetFuncType(actor, &OceanConfigActor::SetNumTiles),
      dtDAL::IntActorProperty::GetFuncType(actor, &OceanConfigActor::GetNumTiles),
      "",
      GROUPNAME));

   AddProperty(new dtDAL::Vec2ActorProperty("Wind Direction", "Wind Direction",
      dtDAL::Vec2ActorProperty::SetFuncType(actor, &OceanConfigActor::SetWindDirection),
      dtDAL::Vec2ActorProperty::GetFuncType(actor, &OceanConfigActor::GetWindDirection),
      "Change the wind's direction",
      GROUPNAME));

   AddProperty(new dtDAL::FloatActorProperty("Wind Speed", "Wind Speed",
      dtDAL::FloatActorProperty::SetFuncType(actor, &OceanConfigActor::SetWindSpeed),
      dtDAL::FloatActorProperty::GetFuncType(actor, &OceanConfigActor::GetWindSpeed),
      "Change the wind speed, makes bigger waves",
      GROUPNAME));

   AddProperty(new dtDAL::FloatActorProperty("Depth", "Depth",
      dtDAL::FloatActorProperty::SetFuncType(actor, &OceanConfigActor::SetDepth),
      dtDAL::FloatActorProperty::GetFuncType(actor, &OceanConfigActor::GetDepth),
      "",
      GROUPNAME));

   AddProperty(new dtDAL::FloatActorProperty("Wave Scale", "Wave Scale",
      dtDAL::FloatActorProperty::SetFuncType(actor, &OceanConfigActor::SetWaveScale),
      dtDAL::FloatActorProperty::GetFuncType(actor, &OceanConfigActor::GetWaveScale),
      "Wave scale factor (typically very small ~1e-8)",
      GROUPNAME));

   AddProperty(new dtDAL::BooleanActorProperty("Is Choppy", "Is Choppy",
      dtDAL::BooleanActorProperty::SetFuncType(actor, &OceanConfigActor::SetIsChoppy),
      dtDAL::BooleanActorProperty::GetFuncType(actor, &OceanConfigActor::GetIsChoppy),
      "Enable/Disable choppy wave geometry",
      GROUPNAME));

   AddProperty(new dtDAL::FloatActorProperty("Choppy Factor", "Choppy Factor",
      dtDAL::FloatActorProperty::SetFuncType(actor, &OceanConfigActor::SetChoppyFactor),
      dtDAL::FloatActorProperty::GetFuncType(actor, &OceanConfigActor::GetChoppyFactor),
      "Change the choppy wave factor",
      GROUPNAME));

   AddProperty(new dtDAL::FloatActorProperty("Anim Loop Time", "Anim Loop Time",
      dtDAL::FloatActorProperty::SetFuncType(actor, &OceanConfigActor::SetAnimLoopTime),
      dtDAL::FloatActorProperty::GetFuncType(actor, &OceanConfigActor::GetAnimLoopTime),
      "",
      GROUPNAME));

   AddProperty(new dtDAL::IntActorProperty("Number of Frames", "Number of Frames",
      dtDAL::IntActorProperty::SetFuncType(actor, &OceanConfigActor::SetNumFrames),
      dtDAL::IntActorProperty::GetFuncType(actor, &OceanConfigActor::GetNumFrames),
      "",
      GROUPNAME));

   AddProperty(new dtDAL::FloatActorProperty("SkyBox Radius", "SkyBox Radius",      
      dtDAL::FloatActorProperty::SetFuncType(actor, &OceanConfigActor::SetSkyBoxRadius),
      dtDAL::FloatActorProperty::GetFuncType(actor, &OceanConfigActor::GetSkyBoxRadius),
      "Sets the sky box radius",
      GROUPNAME_SKY));

   AddProperty(new dtDAL::ResourceActorProperty(*this, dtDAL::DataType::TEXTURE,
      "Skybox Up", "Skybox Up",
      dtDAL::ResourceActorProperty::SetFuncType(actor, &OceanConfigActor::SetSkyBoxUp),
      "Sets the sky box texture",
      GROUPNAME_SKY));

   AddProperty(new dtDAL::ResourceActorProperty(*this, dtDAL::DataType::TEXTURE,
      "Skybox Down", "Skybox Down",
      dtDAL::ResourceActorProperty::SetFuncType(actor, &OceanConfigActor::SetSkyBoxDown),
      "Sets the sky box texture",
      GROUPNAME_SKY));

   AddProperty(new dtDAL::ResourceActorProperty(*this, dtDAL::DataType::TEXTURE,
      "Skybox Left", "Skybox Left",
      dtDAL::ResourceActorProperty::SetFuncType(actor, &OceanConfigActor::SetSkyBoxLeft),
      "Sets the sky box texture",
      GROUPNAME_SKY));

   AddProperty(new dtDAL::ResourceActorProperty(*this, dtDAL::DataType::TEXTURE,
      "Skybox Right", "Skybox Right",
      dtDAL::ResourceActorProperty::SetFuncType(actor, &OceanConfigActor::SetSkyBoxRight),
      "Sets the sky box texture",
      GROUPNAME_SKY));

   AddProperty(new dtDAL::ResourceActorProperty(*this, dtDAL::DataType::TEXTURE,
      "Skybox Front", "Skybox Front",
      dtDAL::ResourceActorProperty::SetFuncType(actor, &OceanConfigActor::SetSkyBoxFront),
      "Sets the sky box texture",
      GROUPNAME_SKY));

   AddProperty(new dtDAL::ResourceActorProperty(*this, dtDAL::DataType::TEXTURE,
      "Skybox Back", "Skybox Back",
      dtDAL::ResourceActorProperty::SetFuncType(actor, &OceanConfigActor::SetSkyBoxBack),
      "Sets the sky box texture",
      GROUPNAME_SKY));

   AddProperty(new dtDAL::FloatActorProperty("Foam Bottom Height", "Foam Bottom Height",
      dtDAL::FloatActorProperty::SetFuncType(actor, &OceanConfigActor::SetFoamBottomHeight),
      dtDAL::FloatActorProperty::GetFuncType(actor, &OceanConfigActor::GetFoamBottomHeight),
      "",
      GROUPNAME));

   AddProperty(new dtDAL::FloatActorProperty("Foam Top Height", "Foam Top Height",
      dtDAL::FloatActorProperty::SetFuncType(actor, &OceanConfigActor::SetFoamTopHeight),
      dtDAL::FloatActorProperty::GetFuncType(actor, &OceanConfigActor::GetFoamTopHeight),
      "",
      GROUPNAME));

   AddProperty(new dtDAL::ColorRgbaActorProperty("Light Color", "Light Color",
      dtDAL::ColorRgbaActorProperty::SetFuncType(actor, &OceanConfigActor::SetLightColor),
      dtDAL::ColorRgbaActorProperty::GetFuncType(actor, &OceanConfigActor::GetLightColor),
      "color of sun",
      GROUPNAME));

   AddProperty(new dtDAL::FloatActorProperty("Above Water Fog Height", "Above Water Fog Height",
      dtDAL::FloatActorProperty::SetFuncType(actor, &OceanConfigActor::SetAboveWaterFogHeight),
      dtDAL::FloatActorProperty::GetFuncType(actor, &OceanConfigActor::GetAboveWaterFogHeight),
      "Above water fog density (EXP fog)",
      GROUPNAME));

   AddProperty(new dtDAL::FloatActorProperty("Under Water Fog Height", "Under Water Fog Height",
      dtDAL::FloatActorProperty::SetFuncType(actor, &OceanConfigActor::SetUnderWaterFogHeight),
      dtDAL::FloatActorProperty::GetFuncType(actor, &OceanConfigActor::GetUnderWaterFogHeight),
      "Under water fog density (EXP fog)",
      GROUPNAME));

   AddProperty(new dtDAL::ColorRgbaActorProperty("Above Water Fog Color", "Above Water Fog Color",
      dtDAL::ColorRgbaActorProperty::SetFuncType(actor, &OceanConfigActor::SetAboveWaterFogColor),
      dtDAL::ColorRgbaActorProperty::GetFuncType(actor, &OceanConfigActor::GetAboveWaterFogColor),
      "color of fog",
      GROUPNAME));

   AddProperty(new dtDAL::ColorRgbaActorProperty("Under Water Fog Color", "Under Water Fog Color",
      dtDAL::ColorRgbaActorProperty::SetFuncType(actor, &OceanConfigActor::SetUnderWaterFogColor),
      dtDAL::ColorRgbaActorProperty::GetFuncType(actor, &OceanConfigActor::GetUnderWaterFogColor),
      "color of fog under water",
      GROUPNAME));

   AddProperty(new dtDAL::ColorRgbaActorProperty("Under Water Diffuse Color", "Under Water Diffuse Color",
      dtDAL::ColorRgbaActorProperty::SetFuncType(actor, &OceanConfigActor::SetUnderWaterDiffuseColor),
      dtDAL::ColorRgbaActorProperty::GetFuncType(actor, &OceanConfigActor::GetUnderWaterDiffuseColor),
      "color of fog under water",
      GROUPNAME));

   AddProperty(new dtDAL::Vec3ActorProperty("Under Water Attentuation", "Under Water Attentuation",
      dtDAL::Vec3ActorProperty::SetFuncType(actor, &OceanConfigActor::SetUnderWaterAttentuation),
      dtDAL::Vec3ActorProperty::GetFuncType(actor, &OceanConfigActor::GetUnderWaterAttentuation),
      "Attentuation",
      GROUPNAME));

   AddProperty(new dtDAL::FloatActorProperty("Glare Attentuation", "Glare Attentuation",
      dtDAL::FloatActorProperty::SetFuncType(actor, &OceanConfigActor::SetGlareAttentuation),
      dtDAL::FloatActorProperty::GetFuncType(actor, &OceanConfigActor::GetGlareAttentuation),
      "Controls the rate at which the glare drops off (typically 0.75..0.95)",
      GROUPNAME));

   AddProperty(new dtDAL::ColorRgbaActorProperty("Sun Diffuse Color", "Sun Diffuse Color",
      dtDAL::ColorRgbaActorProperty::SetFuncType(actor, &OceanConfigActor::SetSunDiffuseColor),
      dtDAL::ColorRgbaActorProperty::GetFuncType(actor, &OceanConfigActor::GetSunDiffuseColor),
      "color of sun",
      GROUPNAME));

   AddProperty(new dtDAL::ColorRgbaActorProperty("Sun Ambient Color", "Sun Ambient Color",
      dtDAL::ColorRgbaActorProperty::SetFuncType(actor, &OceanConfigActor::SetSunAmbientColor),
      dtDAL::ColorRgbaActorProperty::GetFuncType(actor, &OceanConfigActor::GetSunAmbientColor),
      "ambient color",
      GROUPNAME));

   AddProperty(new dtDAL::ColorRgbaActorProperty("Sun Specular Color", "Sun Specular Color",
      dtDAL::ColorRgbaActorProperty::SetFuncType(actor, &OceanConfigActor::SetSunSpecularColor),
      dtDAL::ColorRgbaActorProperty::GetFuncType(actor, &OceanConfigActor::GetSunSpecularColor),
      "specular color",
      GROUPNAME));

   AddProperty(new dtDAL::Vec3ActorProperty("Sun Direction", "Sun Direction",
      dtDAL::Vec3ActorProperty::SetFuncType(actor, &OceanConfigActor::SetSunDirection),
      dtDAL::Vec3ActorProperty::GetFuncType(actor, &OceanConfigActor::GetSunDirection),
      "Attentuation",
      GROUPNAME));
}
