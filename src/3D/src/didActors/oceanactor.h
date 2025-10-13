#pragma once

#ifdef USE_VLD

#include <vld.h>

#endif

#include "didactorsheaders.h"
 

enum DrawMask
{
	CAST_SHADOW             = (0x1<<30),
	RECEIVE_SHADOW          = (0x1<<29),
};


namespace dtCore
{
   class Environment;
   class DeltaWin;
}

#include <dtCore/windowresizecallback.h>

namespace osgOcean
{
   class OceanScene;
   class FFTOceanSurface;
}

namespace didEnviro
{

   class OceanConfigActor;
   //class SkyDome;
   //class SphereSegment;

   class DID_ACTORS_EXPORT OceanActor : public dtGame::IEnvGameActor, 
	   public dtCore::WindowResizeCallback
   {
   public:
      typedef dtGame::IEnvGameActor BaseClass;

      /** CTor */
      OceanActor(dtGame::GameActorProxy& proxy);
      ~OceanActor();

      void OnEnteredWorld();
      void ProcessMessage(const dtGame::Message& msg);

      void SetConfig(OceanConfigActor*);

      virtual bool IsPlaceable() const { return false; }

      /**
       * Adds an actor to the internal hierarchy of the environment
       * @param dd The DeltaDrawable to add as a child
       */
      virtual void AddActor(dtCore::DeltaDrawable& dd);

      /**
       * Removes a DeltaDrawable from the internal hierarchy
       * @param dd The DeltaDrawable to remove
       */
      virtual void RemoveActor(dtCore::DeltaDrawable& dd);

      /**
       * Removes all actors associated with this environment
       */
      virtual void RemoveAllActors();

      /**
       * Called to see if this environment has the specified proxy
       * @param proxy The proxy to look for
       * @return True if it contains it, false if not
       */
      virtual bool ContainsActor(dtCore::DeltaDrawable& dd) const;

      /**
       * Gets all the actors associated with this environment
       * @param vec The vector to fill
       */
      virtual void GetAllActors(std::vector<dtCore::DeltaDrawable*>& vec);

      /**
       * Gets the number of children of this environment
       */
      virtual unsigned int GetNumEnvironmentChildren() const;

      osg::Group* GetNode() const;

      void SetSkyRotation(const osg::Quat& rot);
      osg::Quat GetSkyRotation() const;

      osg::Vec3f GetSunDirection();
      void SetSunDirection(const osg::Vec3f& v);

      float GetOceanHeight() const;
      void SetOceanHeight(float v);

	  osg::Vec2 GetWindDirection() const; 
	  void SetWindDirection(osg::Vec2& v);
	  float GetWindSpeed() const;
	  void SetWindSpeed(float v);

      OceanConfigActor* GetOceanConfig(){ return mConfig.get(); };
      osgOcean::FFTOceanSurface* GetOceanSurface() { return mOceanSurface; };
      osgOcean::OceanScene* GetOceanScene() { return mOceanScene; };

      /**
      * This method is an invokable for when a local object receives a tick.
      * @param tickMessage A message containing tick related information.
      */
      virtual void TickLocal(const dtGame::Message &tickMessage);

      //-- BAWE-20110405: ON_THE_FLY_OCEAN_CONTROL


      /** Get the height of the ocean surface at the supplied (x,y).
       * @param x : the X location
       * @param y : the Y location
       * @param normal : the Vec3 normal at x,y (optional)
       * @return The height of the surface
       */
      float GetOceanSurfaceHeightAt(float x, float y, osg::Vec3* normal = NULL) const;

      // show or hide the ocean geometry
      void Show(bool showit);

      /** Set the window dimensions.  Call this whenever the window gets
        * resized to keep osgOcean in sync.
        * @param size The window (width, height)
        */
      void SetWindowSize(const osg::Vec2s size);
	  virtual void operator () (const dtCore::DeltaWin& win, int x, int y, int width, int height);

   private:
	  double mLong, mLat;

      dtCore::RefPtr<dtCore::Environment> mEnv;
      dtCore::RefPtr<osg::LightSource> mLightSource;
      dtCore::RefPtr<OceanConfigActor> mConfig;
	  dtCore::RefPtr<osgOcean::FFTOceanSurface> mOceanSurface;
      dtCore::RefPtr<osgOcean::OceanScene> mOceanScene;
//      dtCore::RefPtr<Cylinder> mOceanCylinder;
      dtCore::RefPtr<osgOcean::Cylinder> mOceanCylinder;
      dtCore::RefPtr<osg::Fog> mFog;
      dtCore::RefPtr<SkyDome> mSkyDome;
      dtCore::RefPtr<osg::PositionAttitudeTransform> mSkyTransform;
      void OnMapLoaded();
      void Build();

      bool mOceanVisible;
   };

   // -----------------------------------------------

   class DID_ACTORS_EXPORT OceanActorProxy : public dtGame::IEnvGameActorProxy
   {
      typedef dtGame::IEnvGameActorProxy BaseClass;

   public:
      OceanActorProxy();
      virtual void CreateActor();
      virtual void BuildPropertyMap();

   protected:
      virtual ~OceanActorProxy();
   };

} // namespace didEnviro
