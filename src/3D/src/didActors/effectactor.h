#ifndef APP_EFFECT_ACTOR
#define APP_EFFECT_ACTOR

#ifdef USE_VLD

#include <vld.h>

#endif

#include "didactorsheaders.h"

 
 
class DID_ACTORS_EXPORT EffectActor : public dtGame::GameActor
{
   public:

      EffectActor(dtGame::GameActorProxy &proxy);

	  virtual void TickLocal(const dtGame::Message &tickMessage);
	  virtual void ProcessMessage(const dtGame::Message &message);
	 
	  void SwitchOnEffect();
	  void SwitchOFFEffect();

	  void OnExplode(const osg::Vec3 pos);

	  bool GetEffectState() ;
	  void SetEffectState( const bool isRun );
	  
	  void SetTimeOut(const float tm );

	  int GetWeaponID();
	  void SetWeaponID(const int WID );
		
	  int GetExplodeLauncher();
	  void SetLauncherExplode(const int WID );

   protected:
      
	  virtual ~EffectActor();

	  void OnEnteredWorld();
	  void OnRemovedFromWorld();

   private:
      int mEffectID;
	  int mWeaponID;
	  int mLaucherExplode;

	  bool mEffectIsRunning;
	  float mCycleLifeTime;
	  float M_TIME_OUT ;

	  std::string soundfile ;
	  std::string particlefile ;

	  void SetExplosionFile(const int WID );
	  void SetExplotionSpoutFile(const int WID);
	  void pass_glare_shader();
	  
	  
   public :
	  dtCore::RefPtr<dtAudio::Sound> ExplodeSound;
	  dtCore::RefPtr<dtCore::ParticleSystem> ExplodeParticle;

};

class DID_ACTORS_EXPORT EffectActorProxy : public dtGame::GameActorProxy
{
   public:

      EffectActorProxy();

      virtual void BuildPropertyMap();

      virtual void BuildInvokables();

      virtual void CreateActor() { SetActor(*new EffectActor(*this)); }

   protected:

      virtual ~EffectActorProxy();
      virtual void OnEnteredWorld();
	  virtual void OnRemovedFromWorld();

   private:
	  
};

#endif
