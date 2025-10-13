#pragma once

#ifdef USE_VLD

#include <vld.h>

#endif

#include "didactorsheaders.h"


namespace didEnviro
{

   struct DID_ACTORS_EXPORT OceanSeaState
   {
        float mWaveScale;
        float mWindSpeed;
        float mWindLength;

        OceanSeaState( float waveScale
                       , float windSpeed
                       , float windLength
                     )
        {
            mWaveScale = waveScale;
            mWindSpeed = windSpeed;
            mWindLength = windLength;
        }
   };

   //class DID_ACTORS_EXPORT OceanConfigActor : public dtGame::GameActor 
   class DID_ACTORS_EXPORT OceanConfigActor : public dtCore::DeltaDrawable
   {
   public:
   // Ocean change bitmask constants
   // Note: for skybox, change to enumerated skybox (SKY_FINE, SKY_CLOUD, NIGHT, etc). DONOT CHANGE THE 6 TEXTURE DIRECTLY. Read from database for the enums and skybox.
      
      static const unsigned long long OCEAN_NO_CHANGE; //NO CHANGE
      static const unsigned long long OCEAN_INIT; //USED FOR INITIALIZATION / OCEAN BUILDING. IGNORE OTHER MASK. CALLS OceanActor::Build() INSTEAD OF CHANGING ONE AT A TIME.
      static const unsigned long long OCEAN_FFT_GRID_SIZE; 
      static const unsigned long long OCEAN_RESOLUTION; 
      static const unsigned long long OCEAN_NUM_TILES; 
      static const unsigned long long OCEAN_WIND_DIRECTION; 
      static const unsigned long long OCEAN_WIND_SPEED; 
      static const unsigned long long OCEAN_DEPTH; 
      static const unsigned long long OCEAN_WAVE_SCALE; 
      static const unsigned long long OCEAN_IS_CHOPPY; 
      static const unsigned long long OCEAN_CHOPPY_FACTOR; 
      static const unsigned long long OCEAN_ANIM_LOOP_TIME; 
      static const unsigned long long OCEAN_NUM_FRAMES; 
      static const unsigned long long OCEAN_SKYBOX_TYPE; //NOT IMPLEMENTED YET! USED TO CHANGE THE SKYBOX TEXTURES BASED ON THE TYPE.
      static const unsigned long long OCEAN_FOAM_BOTTOM_HEIGHT; 
      static const unsigned long long OCEAN_FOAM_TOP_HEIGHT; 
      static const unsigned long long OCEAN_ENABLE_CREST_FOAM; 
      static const unsigned long long OCEAN_LIGHT_COLOR; 
      static const unsigned long long OCEAN_ENABLE_ENDLESS_OCEAN; 
      static const unsigned long long OCEAN_ENABLE_REFLECTIONS; 
      static const unsigned long long OCEAN_REFLECTION_DAMPING; 
      static const unsigned long long OCEAN_ENABLE_REFRACTIONS; 
      static const unsigned long long OCEAN_ABOVEWATER_FOG_HEIGHT; 
      static const unsigned long long OCEAN_UNDERWATER_FOG_HEIGHT; 
      static const unsigned long long OCEAN_ABOVEWATER_FOG_COLOR; 
      static const unsigned long long OCEAN_UNDERWATER_FOG_COLOR; 
      static const unsigned long long OCEAN_UNDERWATER_DIFFUSE_COLOR; 
      static const unsigned long long OCEAN_UNDERWATER_ATTENUATION; 
      static const unsigned long long OCEAN_SUN_DIRECTION; 
      static const unsigned long long OCEAN_ENABLE_GODRAYS; 
      static const unsigned long long OCEAN_ENABLE_SILT; 
      static const unsigned long long OCEAN_ENABLE_UNDERWATER_DOF; 
      static const unsigned long long OCEAN_ENABLE_GLARE; 
      static const unsigned long long OCEAN_GLARE_ATTENUATION;
      static const unsigned long long OCEAN_SKYBOX_RADIUS; 
      static const unsigned long long OCEAN_SKYBOX_LONG_STEPS; 
      static const unsigned long long OCEAN_SKYBOX_LAT_STEPS; 
      static const unsigned long long OCEAN_SUN_DIFFUSE_COLOR; 
      static const unsigned long long OCEAN_SUN_AMBIENT_COLOR; 
      static const unsigned long long OCEAN_SUN_SPECULAR_COLOR; 
      static const unsigned long long OCEAN_USE_DEFAULT_SCENE_SHADER; 
      static const unsigned long long OCEAN_OCEAN_HEIGHT; 
      static const unsigned long long OCEAN_SEA_STATE;
      static const unsigned long long OCEAN_ENABLE_GLOW;  


   public:
      static const std::string CLASS_NAME;
      typedef dtCore::DeltaDrawable BaseClass;
	  //typedef dtGame::GameActor BaseClass;

      /** CTor */
      OceanConfigActor();
	  //OceanConfigActor(dtGame::GameActorProxy& proxy);

      inline void SetDirty(bool v) { mIsDirty = v; }
      inline bool IsDirty() const { return mIsDirty; }

      inline unsigned long long GetFlags(){ return mOceanChangeFlags; } const
      inline void ClearFlags(){ mOceanChangeFlags = OCEAN_NO_CHANGE; }
      inline void SetOceanInitFlag(){ mOceanChangeFlags = OCEAN_INIT; }
      inline void AddMask( const unsigned long long mask ){ mOceanChangeFlags |= mask; }
      inline void RemoveMask( const unsigned long long mask ){ mOceanChangeFlags &= ~mask; }
      inline bool CheckMask( const unsigned long long mask ) const { return ((mOceanChangeFlags & mask) == mask) ; }
      static const struct OceanSeaState mSeaStateData[10];

      virtual osg::Node* GetOSGNode() { return NULL; }
      virtual const osg::Node* GetOSGNode() const { return NULL; }

      virtual bool IsPlaceable() const { return false; }

      void SetFFTGridSize(int v) { mFFTGridSize = v; SetDirty(true); AddMask(OCEAN_FFT_GRID_SIZE);}
      int GetFFTGridSize() const { return mFFTGridSize; }

      void SetResolution(int v) { mResolution = v; SetDirty(true); AddMask(OCEAN_RESOLUTION);}
      int GetResolution() const { return mResolution; }

      void SetNumTiles(int v) { mNumTiles = v; SetDirty(true); AddMask(OCEAN_NUM_TILES);}
      int GetNumTiles() const { return mNumTiles; }

      void SetWindDirection(const osg::Vec2& v) { mWindDirection = v; SetDirty(true); AddMask(OCEAN_WIND_DIRECTION);}
      osg::Vec2 GetWindDirection() const { return mWindDirection; }


      void SetWindOrientation(const float angle );
      float GetWindOrientation() const;

      void SetWindLength(const float length);
      float GetWindLength() const;

      void SetSeaState(const int v){ mSeaState = v; SetDirty(true); AddMask(OCEAN_SEA_STATE);}
      int GetSeaState() const { return mSeaState; }

      void SetWindSpeed(float v) { mWindSpeed = v; SetDirty(true); AddMask(OCEAN_WIND_SPEED);}
      float GetWindSpeed() const { return mWindSpeed; }

      void SetDepth(float v) { mDepth = v; SetDirty(true); AddMask(OCEAN_DEPTH);}
      float GetDepth() const { return mDepth; }

      void SetWaveScale(float v) { mWaveScale = v; SetDirty(true); AddMask(OCEAN_WAVE_SCALE);}
      float GetWaveScale() const { return mWaveScale;}

      void SetIsChoppy(bool v) { mIsChoppy = v; SetDirty(true); AddMask(OCEAN_IS_CHOPPY);}
      bool GetIsChoppy() const { return mIsChoppy; }

      void SetChoppyFactor(float v) { mChoppyFactor = v; SetDirty(true); AddMask(OCEAN_CHOPPY_FACTOR);}
      float GetChoppyFactor() const { return mChoppyFactor; }

      void SetAnimLoopTime(float v) { mAnimLoopTime = v; SetDirty(true); AddMask(OCEAN_ANIM_LOOP_TIME);}
      float GetAnimLoopTime() const { return mAnimLoopTime; }

      void SetNumFrames(int v) { mNumFrames = v; SetDirty(true); AddMask(OCEAN_NUM_FRAMES);}
      int GetNumFrames() const { return mNumFrames; }

      void SetSkyBoxUp(const std::string& f)    { mTexUp = f; SetDirty(true); }
      std::string GetSkyBoxUp()    const { return mTexUp;    }

      void SetSkyBoxDown(const std::string& f)  { mTexDown = f; SetDirty(true); }
      std::string GetSkyBoxDown()  const { return mTexDown;  }

      void SetSkyBoxLeft(const std::string& f)  { mTexLeft = f; SetDirty(true); }
      std::string GetSkyBoxLeft()  const { return mTexLeft;  }

      void SetSkyBoxRight(const std::string& f) { mTexRight = f; SetDirty(true); }
      std::string GetSkyBoxRight() const { return mTexRight; }

      void SetSkyBoxFront(const std::string& f) { mTexFront = f; SetDirty(true); }
      std::string GetSkyBoxFront() const { return mTexFront; }

      void SetSkyBoxBack(const std::string& f)  { mTexBack = f; SetDirty(true);  }
      std::string GetSkyBoxBack()  const { return mTexBack;  }

      void SetFoamBottomHeight(float v) { mFoamBottomHeight = v; SetDirty(true); AddMask(OCEAN_FOAM_BOTTOM_HEIGHT);}
      float GetFoamBottomHeight() const { return mFoamBottomHeight; }

      void SetFoamTopHeight(float v) { mFoamTopHeight = v; SetDirty(true); AddMask(OCEAN_FOAM_TOP_HEIGHT);}
      float GetFoamTopHeight() const { return mFoamTopHeight; }

      void SetEnableCrestFoam(bool v) { mEnableCrestFoam = v; SetDirty(true); AddMask(OCEAN_ENABLE_CREST_FOAM);}
      bool GetEnableCrestFoam() const { return mEnableCrestFoam; }

      void SetLightColor(const osg::Vec4& c) { mLightColor = c; SetDirty(true); AddMask(OCEAN_LIGHT_COLOR);}
      osg::Vec4 GetLightColor() const { return mLightColor; }

      void SetEnableEndlessOcean(bool v) { mEnableEndlessOcean = v; SetDirty(true); AddMask(OCEAN_ENABLE_ENDLESS_OCEAN);}
      bool GetEnableEndlessOcean() const { return mEnableEndlessOcean; }

      void SetEnableReflections(bool v) { mEnableReflections = v; SetDirty(true); AddMask(OCEAN_ENABLE_REFLECTIONS);}
      bool GetEnableReflections() const { return mEnableReflections; }

      void SetReflectionDamping(float v) { mReflectionDamping = v; SetDirty(true); AddMask(OCEAN_REFLECTION_DAMPING);}
      float GetReflectionDamping() const { return mReflectionDamping; }

      void SetEnableRefractions(bool v) { mEnableRefractions = v; SetDirty(true); AddMask(OCEAN_ENABLE_REFLECTIONS);}
      bool GetEnableRefractions() const { return mEnableRefractions; }

      void SetAboveWaterFogHeight(float v) { mAboveWaterFogHeight = v; SetDirty(true); AddMask(OCEAN_ABOVEWATER_FOG_HEIGHT);}
      float GetAboveWaterFogHeight() const { return mAboveWaterFogHeight; }

      void SetUnderWaterFogHeight(float v) { mUnderWaterFogHeight = v; SetDirty(true); AddMask(OCEAN_UNDERWATER_FOG_HEIGHT);}
      float GetUnderWaterFogHeight() const { return mUnderWaterFogHeight; }

      void SetAboveWaterFogColor(const osg::Vec4& c) { mAboveWaterFogColor = c; SetDirty(true); AddMask(OCEAN_ABOVEWATER_FOG_COLOR);}
      osg::Vec4 GetAboveWaterFogColor() const { return mAboveWaterFogColor; }

      void SetUnderWaterFogColor(const osg::Vec4& c) { mUnderWaterFogColor = c; SetDirty(true); AddMask(OCEAN_UNDERWATER_FOG_COLOR);}
      osg::Vec4 GetUnderWaterFogColor() const { return mUnderWaterFogColor; }

      void SetUnderWaterDiffuseColor(const osg::Vec4& c) { mUnderWaterDiffuseColor = c; SetDirty(true); AddMask(OCEAN_UNDERWATER_DIFFUSE_COLOR);}
      osg::Vec4 GetUnderWaterDiffuseColor() const { return mUnderWaterDiffuseColor; }

      void SetUnderWaterAttentuation(const osg::Vec3& c) { mUnderWaterAttentuation = c; SetDirty(true); AddMask(OCEAN_UNDERWATER_ATTENUATION);}
      osg::Vec3 GetUnderWaterAttentuation() const { return mUnderWaterAttentuation; }

      void SetSunDirection(const osg::Vec3& c);
      osg::Vec3 GetSunDirection() const { return mSunDirection; }

      void SetEnableGodRays(bool v) { mEnableGodRays = v; SetDirty(true); AddMask(OCEAN_ENABLE_GODRAYS);}
      bool GetEnableGodRays() const { return mEnableGodRays; }

      void SetEnableSilt(bool v) { mEnableSilt = v; SetDirty(true); AddMask(OCEAN_ENABLE_SILT);}
      bool GetEnableSilt() const { return mEnableSilt; }

      void SetEnableUnderwaterDOF(bool v) { mEnableUnderwaterDOF = v; SetDirty(true); AddMask(OCEAN_ENABLE_UNDERWATER_DOF);}
      bool GetEnableUnderwaterDOF() const { return mEnableUnderwaterDOF; }

      void SetEnableGlare(bool v) { mEnableGlare = v; SetDirty(true); AddMask(OCEAN_ENABLE_GLARE);}
      bool GetEnableGlare() const { return mEnableGlare; }

      void SetEnableGlow(bool v) { mEnableGlow = v; SetDirty(true); AddMask(OCEAN_ENABLE_GLOW);}
      bool GetEnableGlow() const { return mEnableGlow; }

      void SetGlareAttentuation(float v) { mGlareAttentuation = v; SetDirty(true); AddMask(OCEAN_GLARE_ATTENUATION);}
      float GetGlareAttentuation() const { return mGlareAttentuation; }

      void SetSkyBoxRadius(float v) { mSkyBoxRadius = v; SetDirty(true); AddMask(OCEAN_SKYBOX_RADIUS);}
      float GetSkyBoxRadius() const { return mSkyBoxRadius; }

      void SetSkyBoxLongSteps(int v) { mSkyBoxLongSteps = v; SetDirty(true); AddMask(OCEAN_SKYBOX_LONG_STEPS);}
      int GetSkyBoxLongSteps() const { return mSkyBoxLongSteps; }

      void SetSkyBoxLatSteps(int v) { mSkyBoxLatSteps = v; SetDirty(true); AddMask(OCEAN_SKYBOX_LAT_STEPS);}
      int GetSkyBoxLatSteps() const { return mSkyBoxLatSteps; }

      void SetSunDiffuseColor(const osg::Vec4& c) { mSunDiffuseColor = c; SetDirty(true); AddMask(OCEAN_SUN_DIFFUSE_COLOR);}
      osg::Vec4 GetSunDiffuseColor() const { return mSunDiffuseColor; }

      void SetSunAmbientColor(const osg::Vec4& c) { mSunAmbientColor = c; SetDirty(true); AddMask(OCEAN_SUN_AMBIENT_COLOR);}
      osg::Vec4 GetSunAmbientColor() const { return mSunAmbientColor; }

      void SetSunSpecularColor(const osg::Vec4& c) { mSunSpecularColor = c; SetDirty(true); AddMask(OCEAN_SUN_SPECULAR_COLOR);}
      osg::Vec4 GetSunSpecularColor() const { return mSunSpecularColor; }

      void SetUseDefaultSceneShader(bool v) { mUseDefaultSceneShader = v; SetDirty(true); AddMask(OCEAN_USE_DEFAULT_SCENE_SHADER);}
      bool GetUseDefaultSceneShader() const { return mUseDefaultSceneShader; }

      //void SetOceanHeight(double v) { mOceanHeight = v; SetDirty(true); AddMask(OCEAN_OCEAN_HEIGHT);}
      //double GetOceanHeight() const { return mOceanHeight; }

      void SetOceanHeight(float v) { mOceanHeight = v; SetDirty(true); AddMask(OCEAN_OCEAN_HEIGHT);}
      float GetOceanHeight() const { return mOceanHeight; }

   private:
      bool mIsDirty;
      unsigned long long mOceanChangeFlags; //The flags for ocean change bitmasking
      unsigned int mSeaState;

      /** skybox params */
      float mSkyBoxRadius;
      int mSkyBoxLongSteps;
      int mSkyBoxLatSteps;

      int mFFTGridSize;
      int mResolution;
      int mNumTiles;

      osg::Vec2f mWindDirection;
      float mWindSpeed;
      float mDepth;

      float mWaveScale;

      float mReflectionDamping;

      bool mIsChoppy;
      float mChoppyFactor;

      float mAnimLoopTime;

      int mNumFrames;

      std::string mTexUp;
      std::string mTexDown;
      std::string mTexLeft;
      std::string mTexRight;
      std::string mTexFront;
      std::string mTexBack;

      float mFoamBottomHeight;
      float mFoamTopHeight;

      bool mEnableCrestFoam;

      osg::Vec4f mLightColor;

      bool mEnableEndlessOcean;

      bool mEnableReflections;
      bool mEnableRefractions;

      float mAboveWaterFogHeight;
      float mUnderWaterFogHeight;

      osg::Vec4f mAboveWaterFogColor;
      osg::Vec4f mUnderWaterFogColor;
      osg::Vec4f mUnderWaterDiffuseColor;

      osg::Vec3 mUnderWaterAttentuation;

      osg::Vec3 mSunDirection;

      bool mEnableGodRays;
      bool mEnableSilt;

      bool mEnableUnderwaterDOF;
      bool mEnableGlare;
      bool mEnableGlow;  

      float mGlareAttentuation;

      osg::Vec4f mSunDiffuseColor;
	  osg::Vec4f mSunAmbientColor;
	  osg::Vec4f mSunSpecularColor;	  

      bool mUseDefaultSceneShader;

      float mOceanHeight;

   };

   // -----------------------------------------------

   class DID_ACTORS_EXPORT OceanConfigActorProxy : public dtDAL::ActorProxy
   //class DID_ACTORS_EXPORT OceanConfigActorProxy : public dtGame::GameActorProxy
   {
      typedef dtDAL::ActorProxy BaseClass;
      //typedef dtGame::GameActorProxy BaseClass;

   public:
      OceanConfigActorProxy();
      virtual void CreateActor();
      virtual void BuildPropertyMap();

      virtual bool IsPlaceable() const { return false; }

   protected:
      virtual ~OceanConfigActorProxy();
   };

} // namespace didEnviro
