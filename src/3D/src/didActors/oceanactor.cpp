#include "oceanactor.h"
#include "oceanconfigactor.h"

#include "../didCommon/BaseConstant.h"

using namespace didEnviro;


class CameraTrackDataType : public osg::Referenced
{
private:
    osg::Vec3f _eye;
    osg::PositionAttitudeTransform& _pat;

public:
    CameraTrackDataType(osg::PositionAttitudeTransform& pat)
       :_pat(pat)
    {}

    inline void setEye(const osg::Vec3f& eye) { _eye = eye; }

    inline void update(void)
    {
       _pat.setPosition(osg::Vec3f(_eye.x(), _eye.y(), _pat.getPosition().z()));
    }
};


class CameraTrackCallback : public osg::NodeCallback
{
public:
   virtual void operator()(osg::Node* node, osg::NodeVisitor* nv)
   {
      osg::ref_ptr<CameraTrackDataType> data = dynamic_cast<CameraTrackDataType*> (node->getUserData());

      if (nv->getVisitorType() == osg::NodeVisitor::CULL_VISITOR)
      {
         osgUtil::CullVisitor* cv = static_cast<osgUtil::CullVisitor*>(nv);
         osg::Vec3f eye, centre, up;
         cv->getCurrentCamera()->getViewMatrixAsLookAt(eye, centre, up);
         data->setEye(eye);
      }
      else if (nv->getVisitorType() == osg::NodeVisitor::UPDATE_VISITOR)
      {
         data->update();
      }

      traverse(node, nv);
   }
};


OceanActor::OceanActor(dtGame::GameActorProxy& proxy)
   : BaseClass(proxy), WindowResizeCallback()
   , mEnv(new dtCore::Environment("OceanEnvironment"))
   , mOceanSurface(NULL)
   , mOceanScene(NULL)
   , mLightSource(NULL)
   , mConfig(NULL)
   , mFog(NULL)
   , mOceanVisible(true)
{
    SetName(C_CN_OCEAN);

	mEnv->SetDateTime(2010,9,17,23,0,0);

	if ( mEnv->GetParent() != NULL )
	{
		mEnv->GetParent()->RemoveChild(mEnv);
	}

	AddChild(mEnv);
}


OceanActor::~OceanActor()
{
}


void OceanActor::OnEnteredWorld()
{
   // get informed about enabled debug drawing
   // GetGameActorProxy().RegisterForMessages(dtGame::MessageType::INFO_MAP_LOADED,
   // dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
	
	GetGameActorProxy().RegisterForMessages(dtGame::MessageType::TICK_LOCAL,dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
	OnMapLoaded();
	//CreateShipActor();
}


void OceanActor::ProcessMessage(const dtGame::Message& msg)
{
	if (msg.GetMessageType() == dtGame::MessageType::INFO_MAP_LOADED)
	{
		OnMapLoaded();
	} else if(msg.GetMessageType() == dtGame::MessageType::TICK_LOCAL)
	{
		TickLocal(msg);
	}
}


void OceanActor::OnMapLoaded()
{
   if (mConfig == NULL && !IsRemote())
   {
      dtGame::GameManager* gm = GetGameActorProxy().GetGameManager();
      const dtDAL::ActorType* type = gm->FindActorType(C_OCEAN_CAT, C_CN_OCEAN_CFG);
      //dtDAL::ActorProxy* proxy = NULL;
	  OceanConfigActorProxy* proxy = NULL;
      //gm->FindActorByType(*type, proxy);
	  gm->FindActorByName(C_CN_OCEAN_CFG, proxy);

      OceanConfigActor* configActor = proxy
         ? static_cast<OceanConfigActor*>(proxy->GetActor())
         : new OceanConfigActor();

	  //OceanConfigActor* configActor;
	  //if (proxy)
	  //{
			//configActor = dynamic_cast<OceanConfigActor*>(proxy->GetActor());
	  //}
	  //else
	  //{
			//dtCore::RefPtr<dtDAL::ActorProxy> ap= gm->CreateActor(C_OCEAN_CAT, C_CN_OCEAN_CFG);
			//dtCore::RefPtr<OceanConfigActorProxy> gap= static_cast<OceanConfigActorProxy*>(ap.get());
			//dtCore::RefPtr<OceanConfigActor> ga= static_cast<OceanConfigActor*>(gap->GetActor());
			//configActor = ga.get();
			//gm->AddActor(*gap, false, false);
	  //}

      SetConfig(configActor);

	  //const dtDAL::ActorType* type2 = gm->FindActorType(C_OCEAN_CAT, C_CN_OCEAN_CFG);
   //   dtDAL::ActorProxy* proxy2 = NULL;
   //   gm->FindActorByType(*type2, proxy2);
 
   }
   else
	   std::cout << "mconfig not null" << std::endl;
}

void OceanActor::AddActor(dtCore::DeltaDrawable& dd)
{
   mEnv->AddChild(&dd);
}


void OceanActor::RemoveActor(dtCore::DeltaDrawable& dd)
{
   mEnv->RemoveChild(&dd);
}


void OceanActor::RemoveAllActors()
{
   while (mEnv->GetNumChildren() > 0)
   {
      mEnv->RemoveChild(mEnv->GetChild(0));
   }
}


void OceanActor::GetAllActors(std::vector<dtCore::DeltaDrawable*>& vec)
{
   vec.clear();

   for(unsigned int i = 0; i < mEnv->GetNumChildren(); i++)
      vec.push_back(mEnv->GetChild(i));
}


bool OceanActor::ContainsActor(dtCore::DeltaDrawable& dd) const
{
   return (mEnv->GetChildIndex(&dd) == mEnv->GetNumChildren());
}


unsigned int OceanActor::GetNumEnvironmentChildren() const
{
   return mEnv->GetNumChildren();
}


void OceanActor::SetConfig(OceanConfigActor* config)
{
   mConfig = config;
   
   if (&GetGameActorProxy() != NULL)
   {
      Build();
   }
   else
	   std::cout << "ocean GetGameActorProxy NULL" << std::endl;
}

void OceanActor::Build()
{
   if (mLightSource != NULL)
   {
      GetOSGNode()->asGroup()->removeChild(mLightSource);
   }
   if (mOceanScene != NULL)
   {
      GetOSGNode()->asGroup()->removeChild(mOceanScene.get());
   }

   mOceanSurface = new osgOcean::FFTOceanSurface(
      mConfig->GetFFTGridSize(),
      mConfig->GetResolution(),
      mConfig->GetNumTiles() ,
      mConfig->GetWindDirection(),
      mConfig->GetWindSpeed(),
      mConfig->GetDepth(),
      mConfig->GetReflectionDamping(),
      mConfig->GetWaveScale(),
      mConfig->GetIsChoppy(),
      mConfig->GetChoppyFactor(),
      mConfig->GetAnimLoopTime(),
      mConfig->GetNumFrames());

   /*std::cout << mConfig->GetFFTGridSize() << "-" <<
	   mConfig->GetResolution() << "-" <<
	   mConfig->GetNumTiles() << "-" <<
	   mConfig->GetWindDirection() << "-" <<
	   mConfig->GetWindSpeed() << "-" <<
	   mConfig->GetDepth() << "-" <<
	   mConfig->GetReflectionDamping() << "-" <<
	   mConfig->GetWaveScale() << "-" <<
	   mConfig->GetIsChoppy() << "-" <<
	   mConfig->GetChoppyFactor() << "-" <<
	   mConfig->GetAnimLoopTime() << "-" <<
	   mConfig->GetNumFrames() << std::endl;*/


   osg::ref_ptr<osg::TextureCubeMap> cubeMap = new osg::TextureCubeMap;
   cubeMap->setInternalFormat(GL_RGBA);

   cubeMap->setFilter(osg::Texture::MIN_FILTER, osg::Texture::LINEAR_MIPMAP_LINEAR);
   cubeMap->setFilter(osg::Texture::MAG_FILTER, osg::Texture::LINEAR);
   cubeMap->setWrap  (osg::Texture::WRAP_S,     osg::Texture::CLAMP_TO_EDGE);
   cubeMap->setWrap  (osg::Texture::WRAP_T,     osg::Texture::CLAMP_TO_EDGE);
  
   cubeMap->setImage(osg::TextureCubeMap::NEGATIVE_X, osgDB::readImageFile(mConfig->GetSkyBoxLeft()));
   cubeMap->setImage(osg::TextureCubeMap::POSITIVE_X, osgDB::readImageFile(mConfig->GetSkyBoxRight()));
   cubeMap->setImage(osg::TextureCubeMap::NEGATIVE_Z, osgDB::readImageFile(mConfig->GetSkyBoxBack()));
   cubeMap->setImage(osg::TextureCubeMap::POSITIVE_Z, osgDB::readImageFile(mConfig->GetSkyBoxFront()));
   cubeMap->setImage(osg::TextureCubeMap::POSITIVE_Y, osgDB::readImageFile(mConfig->GetSkyBoxDown()));
   cubeMap->setImage(osg::TextureCubeMap::NEGATIVE_Y, osgDB::readImageFile(mConfig->GetSkyBoxUp()));
   
   //cubeMap->setImage(osg::TextureCubeMap::NEGATIVE_X, osgDB::readImageFile("../data/textures/sky_def/west.png"));
   //cubeMap->setImage(osg::TextureCubeMap::POSITIVE_X, osgDB::readImageFile("../data/textures/sky_def/east.png"));
   //cubeMap->setImage(osg::TextureCubeMap::NEGATIVE_Z, osgDB::readImageFile("../data/textures/sky_def/south.png"));
   //cubeMap->setImage(osg::TextureCubeMap::POSITIVE_Z, osgDB::readImageFile("../data/textures/sky_def/north.png"));
   //cubeMap->setImage(osg::TextureCubeMap::POSITIVE_Y, osgDB::readImageFile("../data/textures/sky_def/down.png"));
   //cubeMap->setImage(osg::TextureCubeMap::NEGATIVE_Y, osgDB::readImageFile("../data/textures/sky_def/up.png"));

   mOceanSurface->setEnvironmentMap(cubeMap.get());

   mOceanSurface->setFoamBottomHeight(mConfig->GetFoamBottomHeight());
   mOceanSurface->setFoamTopHeight(mConfig->GetFoamTopHeight());
   mOceanSurface->enableCrestFoam(mConfig->GetEnableCrestFoam());
   mOceanSurface->setLightColor(mConfig->GetLightColor());
   mOceanSurface->enableEndlessOcean(mConfig->GetEnableEndlessOcean());

   mOceanScene = new osgOcean::OceanScene(mOceanSurface.get());
   mOceanScene->setUseDefaultSceneShader(mConfig->GetUseDefaultSceneShader());
   // set scene size to window size
   dtCore::Camera* cam =  GetGameActorProxy().GetGameManager()->GetApplication().GetCamera();
   dtCore::DeltaWin::PositionSize size = cam->GetWindow()->GetPosition();
   
   mOceanScene->setScreenDims(osg::Vec2s(size.mWidth, size.mHeight));

   mOceanScene->setLightID(0);
   mOceanScene->enableReflections(mConfig->GetEnableReflections());
   mOceanScene->enableRefractions(mConfig->GetEnableRefractions());

   mOceanScene->setAboveWaterFog(mConfig->GetAboveWaterFogHeight(), mConfig->GetAboveWaterFogColor());
   mOceanScene->setUnderwaterFog(mConfig->GetUnderWaterFogHeight(),  mConfig->GetUnderWaterFogColor());
   mOceanScene->setUnderwaterDiffuse(mConfig->GetUnderWaterDiffuseColor());
   mOceanScene->setUnderwaterAttenuation(mConfig->GetUnderWaterAttentuation());


   mOceanScene->setSunDirection(-mConfig->GetSunDirection());
   mOceanScene->enableGodRays(mConfig->GetEnableGodRays());
   mOceanScene->enableSilt(mConfig->GetEnableSilt());
   mOceanScene->enableUnderwaterDOF(mConfig->GetEnableUnderwaterDOF());
   mOceanScene->enableGlow(mConfig->GetEnableGlow());     //++++++ ADDITIONAL GLOW_SHADER
   mOceanScene->enableGlare(mConfig->GetEnableGlare());
   // NOTE: Glare and Glow can't be enabled at the same time.
   //       Recheck again here to make sure they are both not enabled.
   //       Shouldn't be necessary actually because in the enableGlare and enableGlow itself it has been checked.
   //       Glare takes precedence before glow.
   if ( mOceanScene->isGlareEnabled() && mOceanScene->isGlowEnabled() )
   {
       mOceanScene->enableGlare(true);
       mOceanScene->enableGlow(false);  // BAWE-20110809        
   }
   mOceanScene->setGlareAttenuation(mConfig->GetGlareAttentuation());

   // - Try to disableshader to load skenario [4/7/2014 EKA]
   bool disableShaders(false);
   if (disableShaders)
   {
	   // Disable all special effects that depend on shaders.

	   // These depend on fullscreen RTT passes and shaders to do their effects.
	   mOceanScene->enableDistortion(false);
	   mOceanScene->enableGlare(false);
	   mOceanScene->enableUnderwaterDOF(false);

	   // These are only implemented in the shader, with no fixed-pipeline equivalent
	   mOceanScene->enableUnderwaterScattering(false);
	   // For these two, we might be able to use projective texturing so it would
	   // work on the fixed pipeline?
	   mOceanScene->enableReflections(false);
	   mOceanScene->enableRefractions(false);
	   mOceanScene->enableGodRays(false);  // Could be done in fixed pipeline?
	   mOceanScene->enableSilt(false);     // Could be done in fixed pipeline?

	   std::cout << "disable shader" << std::endl;
   }

   mSkyDome = new SkyDome(
      mConfig->GetSkyBoxRadius(),
      mConfig->GetSkyBoxLongSteps(),
      mConfig->GetSkyBoxLatSteps(),
      cubeMap.get()
   );

   //osg::StateSet* ss = mSkyDome->getOrCreateStateSet();
   //ss->setMode  (GL_FOG, osg::StateAttribute::ON| osg::StateAttribute::OVERRIDE); 

   mSkyDome->setNodeMask(mOceanScene->getReflectedSceneMask() | mOceanScene->getNormalSceneMask());

   //mOceanCylinder = new Cylinder(mConfig->GetSkyBoxRadius(), 999.8f, 16, false, true);
   mOceanCylinder = new osgOcean::Cylinder(mConfig->GetSkyBoxRadius(), 999.8f, 16, false, true);
   mOceanCylinder->setColor(mConfig->GetUnderWaterFogColor());
   mOceanCylinder->getOrCreateStateSet()->setMode(GL_LIGHTING, osg::StateAttribute::OFF);
   mOceanCylinder->getOrCreateStateSet()->setMode(GL_FOG, osg::StateAttribute::OFF);
   //mOceanCylinder->getOrCreateStateSet()->setMode(GL_LIGHTING, osg::StateAttribute::ON);
   //mOceanCylinder->getOrCreateStateSet()->setMode(GL_FOG, osg::StateAttribute::ON);


   osg::Geode* oceanCylinderGeode = new osg::Geode;
   oceanCylinderGeode->addDrawable(mOceanCylinder.get());
   oceanCylinderGeode->setNodeMask(mOceanScene->getNormalSceneMask());

   osg::PositionAttitudeTransform* cylinderPat = new osg::PositionAttitudeTransform;
   cylinderPat->setPosition(osg::Vec3f(0.f, 0.f, -1000.f));
   cylinderPat->addChild(oceanCylinderGeode);

   // add a pat to track the camera
   mSkyTransform = new osg::PositionAttitudeTransform;
   mSkyTransform->setDataVariance(osg::Object::DYNAMIC);
   mSkyTransform->setPosition(osg::Vec3f(0.f, 0.f, 0.f));
   mSkyTransform->setUserData(new CameraTrackDataType(*mSkyTransform));
   mSkyTransform->setUpdateCallback(new CameraTrackCallback);
   mSkyTransform->setCullCallback(new CameraTrackCallback);

   mSkyTransform->addChild(mSkyDome.get());
   mSkyTransform->addChild(cylinderPat);

   mOceanScene->addChild(mSkyTransform);

   {
      // Create and add fake texture for use with nodes without any texture
      // since the OceanScene default scene shader assumes that texture unit
      // 0 is used as a base texture map.
      osg::Image* image = new osg::Image;
      image->allocateImage(1, 1, 1, GL_RGBA, GL_UNSIGNED_BYTE);
      *(osg::Vec4ub*)image->data() = osg::Vec4ub(0xFF, 0xFF, 0xFF, 0xFF);

      osg::Texture2D* fakeTex = new osg::Texture2D(image);
      fakeTex->setWrap(osg::Texture2D::WRAP_S,osg::Texture2D::REPEAT);
      fakeTex->setWrap(osg::Texture2D::WRAP_T,osg::Texture2D::REPEAT);
      fakeTex->setFilter(osg::Texture2D::MIN_FILTER,osg::Texture2D::NEAREST);
      fakeTex->setFilter(osg::Texture2D::MAG_FILTER,osg::Texture2D::NEAREST);

      osg::StateSet* stateset = mOceanScene->getOrCreateStateSet();
      stateset->setTextureAttribute(0,fakeTex,osg::StateAttribute::ON);
      stateset->setTextureMode(0,GL_TEXTURE_1D,osg::StateAttribute::OFF);
      stateset->setTextureMode(0,GL_TEXTURE_2D,osg::StateAttribute::ON);
      stateset->setTextureMode(0,GL_TEXTURE_3D,osg::StateAttribute::OFF);
   }

   mLightSource = new osg::LightSource;
   mLightSource->setLocalStateSetModes();

   osg::Light* light = mLightSource->getLight();
   light->setLightNum(0);
   light->setAmbient(mConfig->GetSunAmbientColor()); 
   //light->setAmbient(osg::Vec4d(0.3f, 0.3f, 0.3f, 1.0f)); // original
   //light->setAmbient(osg::Vec4d(0.1f, 0.1f, 0.1f, 1.0f));
   light->setDiffuse(mConfig->GetSunDiffuseColor());
   light->setSpecular(mConfig->GetSunSpecularColor());
   //light->setSpecular(osg::Vec4d(0.1f, 0.1f, 0.1f, 1.0f));
   light->setPosition(osg::Vec4f(mConfig->GetSunDirection(), 1.f)); // point light

   mOceanScene->setOceanSurfaceHeight(mConfig->GetOceanHeight());

   GetOSGNode()->asGroup()->addChild(mLightSource);

   GetOSGNode()->asGroup()->addChild(mOceanScene.get());

   mOceanScene->addChild(mEnv->GetOSGNode());

   GetGameActorProxy().GetGameManager()->GetApplication().GetWindow()->AddResizeCallback(*this);


   if (!mOceanScene.valid())
	   std::cout << "ocean scene not valid" << std::endl;
   else
	   std::cout << "ocean scene valid" << std::endl;
}


float OceanActor::GetOceanHeight() const
{
   return mOceanScene->getOceanSurfaceHeight();
}


void OceanActor::SetOceanHeight(float v)
{
   return mOceanScene->setOceanSurfaceHeight(v);
}


osg::Vec3f OceanActor::GetSunDirection()
{
   return mOceanScene->getSunDirection();
}


void OceanActor::SetSunDirection(const osg::Vec3f& v)
{
   mOceanScene->setSunDirection(v);
   mLightSource->getLight()->setPosition(osg::Vec4f(v, 1.0f));
}

void OceanActor::SetSkyRotation(const osg::Quat& q)
{
   mSkyTransform->setAttitude(q);
}

osg::Quat OceanActor::GetSkyRotation() const
{
   return mSkyTransform->getAttitude();
}

osg::Vec2 OceanActor::GetWindDirection() const
{
   return mConfig->GetWindDirection();
}
void OceanActor::SetWindDirection(osg::Vec2& v)
{
   mConfig->SetWindDirection(v);
}
float OceanActor::GetWindSpeed() const
{
	return mConfig->GetWindSpeed();
}
void OceanActor::SetWindSpeed(float v)
{
	mConfig->SetWindSpeed(v);
}

osg::Group* OceanActor::GetNode() const
{
   return mEnv->GetDrawableNode();
}

void OceanActor::Show(bool showit)
{
   if (showit == mOceanVisible)
   {
      return;
   }

   mOceanVisible = showit;

   if (mOceanVisible)
   {
      GetOSGNode()->asGroup()->addChild(mOceanScene.get());
   }
   else
   {
      GetOSGNode()->asGroup()->removeChild(mOceanScene.get());
   }
}

///////////////////////////////////////////////////////////////////////////////
void OceanActor::operator () (const dtCore::DeltaWin& win, int x, int y, 
							  int width, int height)
{
	SetWindowSize(osg::Vec2s(width, height));
}


// --------------------------------------------

OceanActorProxy::OceanActorProxy()
   : BaseClass()
{
   SetClassName("didEnviro::OceanActor");
}


OceanActorProxy::~OceanActorProxy()
{
}


void OceanActorProxy::CreateActor()
{
   OceanActor* actor = new OceanActor(*this);
   SetActor(*actor);
}


void OceanActorProxy::BuildPropertyMap()
{
   BaseClass::BuildPropertyMap();
   static const std::string GROUPNAME = C_OCEAN_CAT;
   
   using namespace dtDAL;

   OceanActor* actor;
   GetActor(actor);
}

////////////////////////////////////////////////////////////////////////////////
float didEnviro::OceanActor::GetOceanSurfaceHeightAt(float x, float y, osg::Vec3* normal) const
{
   return mOceanScene->getOceanSurfaceHeightAt(x, y, normal);
}

////////////////////////////////////////////////////////////////////////////////
void didEnviro::OceanActor::SetWindowSize(const osg::Vec2s size)
{
   if (mOceanScene.valid())
   {
      mOceanScene->setScreenDims(size);
   }
}

void didEnviro::OceanActor::TickLocal(const dtGame::Message &tickMessage)
{
    if (mConfig)
    {       
        unsigned long flags = mConfig->GetFlags();
        unsigned long seaStateMask = OceanConfigActor::OCEAN_SEA_STATE;
        bool isDirty = mConfig->IsDirty();
        if (isDirty)
        {
            mConfig->SetDirty(false);
            if (mConfig->CheckMask(OceanConfigActor::OCEAN_INIT)) // Rebuild / reinitialize all the ocean.
            {         
                if (&GetGameActorProxy() != NULL)
                {
                    Build();
                }

                mConfig->RemoveMask(OceanConfigActor::OCEAN_INIT);
            }
            else //Set the ocean one by one
            {
                //OCEAN_ABOVEWATER_FOG_HEIGHT
                if (mConfig->CheckMask(OceanConfigActor::OCEAN_ABOVEWATER_FOG_HEIGHT))
                {
                    std::cout<< "Change Fog Height to "<< mConfig->GetAboveWaterFogHeight() <<" !" <<std::endl;
                    mOceanScene->setAboveWaterFog(mConfig->GetAboveWaterFogHeight(), mConfig->GetAboveWaterFogColor());

                    mConfig->RemoveMask(OceanConfigActor::OCEAN_ABOVEWATER_FOG_HEIGHT); 
                }

                // This is for changes that will also change other masks so we should reset the flags and dirty state.
                // Eg. OCEAN_SEA_STATE in return will change OCEAN_WAVE_SCALE, OCEAN_WIND_SPEED and OCEAN_WIND_DIRECTION
                // If we clear the flags, it won't trigger the changes.
                //OCEAN_SEA_STATE
                if (mConfig->CheckMask(OceanConfigActor::OCEAN_SEA_STATE))
                {
                    mConfig->ClearFlags();

                    mConfig->SetWaveScale(OceanConfigActor::mSeaStateData[mConfig->GetSeaState()].mWaveScale);
                    mConfig->SetWindSpeed(OceanConfigActor::mSeaStateData[mConfig->GetSeaState()].mWindSpeed);
                    mConfig->SetWindLength(OceanConfigActor::mSeaStateData[mConfig->GetSeaState()].mWindLength);

                    mOceanSurface->setWaveScaleFactor(mConfig->GetWaveScale(), false);
                    mConfig->RemoveMask(OceanConfigActor::OCEAN_WAVE_SCALE); 

                    mOceanSurface->setWindSpeed(mConfig->GetWindSpeed(), false);
                    mConfig->RemoveMask(OceanConfigActor::OCEAN_WIND_SPEED); 

                    mOceanSurface->setWindDirection(mConfig->GetWindDirection());
                    mConfig->RemoveMask(OceanConfigActor::OCEAN_WIND_DIRECTION);  

                    mConfig->SetDirty(false);

                    std::cout<< "Sea State Change  !" <<std::endl;
                    std::cout<< "Sea State:  "<< mConfig->GetSeaState() <<"." <<std::endl;
                    std::cout<< "Wave Scale:  "<< mConfig->GetWaveScale() <<"." <<std::endl;
                    std::cout<< "Wind Speed:  "<< mConfig->GetWindSpeed() <<"." <<std::endl;
                    std::cout<< "Wind Length:  "<< mConfig->GetWindLength() <<"." <<std::endl;
                    std::cout<< "Wind Orientation:  "<< mConfig->GetWindOrientation() <<" degree." <<std::endl;

                }
                

                //OCEAN_WAVE_SCALE
                if (mConfig->CheckMask(OceanConfigActor::OCEAN_WAVE_SCALE))
                {
                    std::cout<< "Sea State Change  !" <<std::endl;
                    std::cout<< "Wave Scale:  "<< mConfig->GetWaveScale() <<"." <<std::endl;
                    std::cout<< "Wind Speed:  "<< mConfig->GetWindSpeed() <<"." <<std::endl;
                    std::cout<< "Wind Length:  "<< mConfig->GetWindLength() <<"." <<std::endl;
                    std::cout<< "Wind Orientation:  "<< mConfig->GetWindOrientation() <<" degree." <<std::endl;
                    mOceanSurface->setWaveScaleFactor(mConfig->GetWaveScale());

                    mConfig->RemoveMask(OceanConfigActor::OCEAN_WAVE_SCALE); 
                    mConfig->RemoveMask(OceanConfigActor::OCEAN_SEA_STATE);

                }

                //OCEAN_WIND_SPEED
                if (mConfig->CheckMask(OceanConfigActor::OCEAN_WIND_SPEED))
                {
                    std::cout<< "Sea State Change  !" <<std::endl;
                    std::cout<< "Wave Scale:  "<< mConfig->GetWaveScale() <<"." <<std::endl;
                    std::cout<< "Wind Speed:  "<< mConfig->GetWindSpeed() <<"." <<std::endl;
                    std::cout<< "Wind Length:  "<< mConfig->GetWindLength() <<"." <<std::endl;
                    std::cout<< "Wind Orientation:  "<< mConfig->GetWindOrientation() <<" degree." <<std::endl;
                    mOceanSurface->setWindSpeed(mConfig->GetWindSpeed());

                    mConfig->RemoveMask(OceanConfigActor::OCEAN_WIND_SPEED); 
                    mConfig->RemoveMask(OceanConfigActor::OCEAN_SEA_STATE);

                }

                //OCEAN_WIND_DIRECTION
                if (mConfig->CheckMask(OceanConfigActor::OCEAN_WIND_DIRECTION))
                {
                    std::cout<< "Sea State Change  !" <<std::endl;
                    std::cout<< "Wave Scale:  "<< mConfig->GetWaveScale() <<"." <<std::endl;
                    std::cout<< "Wind Speed:  "<< mConfig->GetWindSpeed() <<"." <<std::endl;
                    std::cout<< "Wind Length:  "<< mConfig->GetWindLength() <<"." <<std::endl;
                    std::cout<< "Wind Orientation:  "<< mConfig->GetWindOrientation() <<" degree." <<std::endl;
                    mOceanSurface->setWindDirection(mConfig->GetWindDirection());
                    
                    mConfig->RemoveMask(OceanConfigActor::OCEAN_WIND_DIRECTION);      
                    mConfig->RemoveMask(OceanConfigActor::OCEAN_SEA_STATE);

                }

                //-- BAWE-20110426: ON_THE_FLY_OCEAN_CONTROL_2: SEA_STATE
                
            }
            

        }
    }

}

//{
//	dtGame::GameManager &gm= *GetGameActorProxy().GetGameManager();
//	//dtABC::Application& app = gm.GetApplication();
//	dtABC::Application& app = GetGameActorProxy().GetGameManager()->GetApplication();
//
//	const MsgOrder &orderMsg = static_cast<const MsgOrder&>(message);
//	if (orderMsg.GetVehicleID() == GetVehicleID())
//		switch (orderMsg.GetOrderID()){
//			case ORD_THROTTLE : 
//				PlayStackSound();
//				SetDesiredThrottlePosition(orderMsg.GetFloatValue());
//				std::cout<<"ORDER = THROTTLE. VAL = "<<orderMsg.GetFloatValue()<<std::endl;
//				break;
//
//
//	}
//}

