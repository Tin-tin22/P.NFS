#include "actorregistry.h"

#include "oceanactor.h"
#include "oceanconfigactor.h"

#include "ShipModelActor.h"
#include "submarineactor.h"
#include "helicopteractor.h"
#include "aircraftactor.h"

#include "asrockbodyactor.h"
#include "asrockspoutactor.h"
#include "asrockactor.h"
#include "cannonbodyactor.h"
#include "cannonspoutactor.h"
#include "rbubodyactor.h"
#include "rbuspoutactor.h"
#include "rbuactor.h"
#include "C802Actor.h"
#include "yakhontactor.h"
#include "torsutactor.h"
#include "torpedoA244.h"
#include "MistralRocketActor.h"
#include "MistralBodyActor.h"
#include "MistralSpoutActor.h"
#include "TetralActor.h"
#include "TetralBodyActor.h"
#include "TetralSpoutActor.h"
#include "StrelaBodyActor.h"
#include "StrelaRocketActor.h"
#include "StrelaSpoutActor.h"
#include "ExocetMM40Actor.h"

#include "ObjectActor.h"
#include "effectactor.h"
#include "playeractor.h"

#include "../didCommon/BaseConstant.h"


using namespace didEnviro;

dtCore::RefPtr<dtDAL::ActorType> DIDActorRegistry::SHIP_MODEL_ACTOR(new dtDAL::ActorType(C_CN_SHIP,C_ACTOR_CAT,C_CN_SHIP));
dtCore::RefPtr<dtDAL::ActorType> DIDActorRegistry::SUB_MARINE_ACTOR(new dtDAL::ActorType(C_CN_SUBMARINE,C_ACTOR_CAT,C_CN_SUBMARINE));
dtCore::RefPtr<dtDAL::ActorType> DIDActorRegistry::HELICOPTER_ACTOR(new dtDAL::ActorType(C_CN_HELICOPTER,C_ACTOR_CAT,C_CN_HELICOPTER));
dtCore::RefPtr<dtDAL::ActorType> DIDActorRegistry::AIRCRAFT_ACTOR(new dtDAL::ActorType(C_CN_AIRCRAFT,C_ACTOR_CAT,C_CN_AIRCRAFT));

dtCore::RefPtr<dtDAL::ActorType> DIDActorRegistry::EFFECT_ACTOR(new dtDAL::ActorType(C_CN_EFFECT,C_ACTOR_CAT,C_CN_EFFECT));
dtCore::RefPtr<dtDAL::ActorType> DIDActorRegistry::MISC_OBJECT_ACTOR(new dtDAL::ActorType(C_CN_MISC,C_ACTOR_CAT,C_CN_MISC));

dtCore::RefPtr<dtDAL::ActorType> DIDActorRegistry::OCEAN_ACTOR_TYPE(new dtDAL::ActorType(C_CN_OCEAN, C_OCEAN_CAT, C_CN_OCEAN));
dtCore::RefPtr<dtDAL::ActorType> DIDActorRegistry::OCEAN_CONFIG_ACTOR_TYPE(new dtDAL::ActorType(C_CN_OCEAN_CFG, C_OCEAN_CAT, C_CN_OCEAN_CFG));
dtCore::RefPtr<dtDAL::ActorType> DIDActorRegistry::TREE_ACTOR(new dtDAL::ActorType(C_CN_TREE, C_ACTOR_CAT, C_CN_TREE)); // BAWE-20111003: PEPOHONAN

dtCore::RefPtr<dtDAL::ActorType> DIDActorRegistry::ASROCK_BODY(new dtDAL::ActorType(C_CN_ASROCKB,C_ACTOR_CAT,C_CN_ASROCKB));
dtCore::RefPtr<dtDAL::ActorType> DIDActorRegistry::ASROCK_SPOUT(new dtDAL::ActorType(C_CN_ASROCKS,C_ACTOR_CAT,C_CN_ASROCKS));
dtCore::RefPtr<dtDAL::ActorType> DIDActorRegistry::ASROCK_ACTOR(new dtDAL::ActorType(C_CN_ASROCK,C_ACTOR_CAT,C_CN_ASROCK));
	
dtCore::RefPtr<dtDAL::ActorType> DIDActorRegistry::CANNON_BODY(new dtDAL::ActorType(C_CN_CANNONB,C_ACTOR_CAT,C_CN_CANNONB));
dtCore::RefPtr<dtDAL::ActorType> DIDActorRegistry::CANNON_SPOUT(new dtDAL::ActorType(C_CN_CANNONS,C_ACTOR_CAT,C_CN_CANNONS));

dtCore::RefPtr<dtDAL::ActorType> DIDActorRegistry::RBU_BODY(new dtDAL::ActorType(C_CN_RBUB,C_ACTOR_CAT,C_CN_RBUB));
dtCore::RefPtr<dtDAL::ActorType> DIDActorRegistry::RBU_SPOUT(new dtDAL::ActorType(C_CN_RBUS,C_ACTOR_CAT,C_CN_RBUS));
dtCore::RefPtr<dtDAL::ActorType> DIDActorRegistry::RBU_ACTOR(new dtDAL::ActorType(C_CN_RBU,C_ACTOR_CAT,C_CN_RBU));
dtCore::RefPtr<dtDAL::ActorType> DIDActorRegistry::TORPEDOSUT_ACTOR(new dtDAL::ActorType(C_CN_TORPSUT,C_ACTOR_CAT,C_CN_TORPSUT));
dtCore::RefPtr<dtDAL::ActorType> DIDActorRegistry::TORPEDO_ACTOR(new dtDAL::ActorType(C_CN_TORPEDO,C_ACTOR_CAT,C_CN_TORPEDO)); //EKA-101111

dtCore::RefPtr<dtDAL::ActorType> DIDActorRegistry::MISTRAL_BODY(new dtDAL::ActorType(C_CN_MISTRALB,C_ACTOR_CAT,C_CN_MISTRALB)); //EKA
dtCore::RefPtr<dtDAL::ActorType> DIDActorRegistry::MISTRAL_SPOUT(new dtDAL::ActorType(C_CN_MISTRALS,C_ACTOR_CAT,C_CN_MISTRALS)); //EKA
dtCore::RefPtr<dtDAL::ActorType> DIDActorRegistry::MISTRAL_ACTOR(new dtDAL::ActorType(C_CN_MISTRAL,C_ACTOR_CAT,C_CN_MISTRAL)); //EKA

dtCore::RefPtr<dtDAL::ActorType> DIDActorRegistry::TETRAL_BODY(new dtDAL::ActorType(C_CN_TETRALB,C_ACTOR_CAT,C_CN_TETRALB)); //EKA
dtCore::RefPtr<dtDAL::ActorType> DIDActorRegistry::TETRAL_SPOUT(new dtDAL::ActorType(C_CN_TETRALS,C_ACTOR_CAT,C_CN_TETRALS)); //EKA
dtCore::RefPtr<dtDAL::ActorType> DIDActorRegistry::TETRAL_ACTOR(new dtDAL::ActorType(C_CN_TETRAL,C_ACTOR_CAT,C_CN_TETRAL)); //EKA

dtCore::RefPtr<dtDAL::ActorType> DIDActorRegistry::STRELA_BODY(new dtDAL::ActorType(C_CN_STRELAB,C_ACTOR_CAT,C_CN_STRELAB)); //EKA
dtCore::RefPtr<dtDAL::ActorType> DIDActorRegistry::STRELA_SPOUT(new dtDAL::ActorType(C_CN_STRELAS,C_ACTOR_CAT,C_CN_STRELAS)); //EKA
dtCore::RefPtr<dtDAL::ActorType> DIDActorRegistry::STRELA_ACTOR(new dtDAL::ActorType(C_CN_STRELA,C_ACTOR_CAT,C_CN_STRELA)); //EKA

dtCore::RefPtr<dtDAL::ActorType> DIDActorRegistry::EXOCETMM40_ACTOR(new dtDAL::ActorType(C_CN_EXOCET_40,C_ACTOR_CAT,C_CN_EXOCET_40)); //NANDO

dtCore::RefPtr<dtDAL::ActorType> DIDActorRegistry::C802_ACTOR(new dtDAL::ActorType(C_CN_C802,C_ACTOR_CAT,C_CN_C802));  
dtCore::RefPtr<dtDAL::ActorType> DIDActorRegistry::YAKHONT_ACTOR(new dtDAL::ActorType(C_CN_YAKHONT,C_ACTOR_CAT,C_CN_YAKHONT));

//yoga check
dtCore::RefPtr<dtDAL::ActorType> DIDActorRegistry::PLAYER_ACTOR(new dtDAL::ActorType(C_CN_PLAYER,C_ACTOR_CAT,C_CN_PLAYER));


//////////////////////////////////////////////////////////////////////////
extern "C" DID_ACTORS_EXPORT dtDAL::ActorPluginRegistry* CreatePluginRegistry()
{
   return new DIDActorRegistry;
}

extern "C" DID_ACTORS_EXPORT void DestroyPluginRegistry(dtDAL::ActorPluginRegistry* registry)
{
   if (registry)
   {
      delete registry;
   }
}

DIDActorRegistry::DIDActorRegistry() : dtDAL::ActorPluginRegistry("didEnviro Library")
{
   mDescription = "All game actors for didEnviro";
}

void DIDActorRegistry::RegisterActorTypes()
{   
   mActorFactory->RegisterType<didEnviro::OceanActorProxy>(OCEAN_ACTOR_TYPE.get());
   mActorFactory->RegisterType<didEnviro::OceanConfigActorProxy>(OCEAN_CONFIG_ACTOR_TYPE.get());

   mActorFactory->RegisterType<ShipModelActorProxy>(SHIP_MODEL_ACTOR.get());
   mActorFactory->RegisterType<SubMarineActorProxy>(SUB_MARINE_ACTOR.get());
   mActorFactory->RegisterType<HelicopterActorProxy>(HELICOPTER_ACTOR.get());
   mActorFactory->RegisterType<AircraftActorProxy>(AIRCRAFT_ACTOR.get());

   mActorFactory->RegisterType<EffectActorProxy>(EFFECT_ACTOR.get());
   mActorFactory->RegisterType<ObjectActorProxy>(MISC_OBJECT_ACTOR.get());

   mActorFactory->RegisterType<AsrockBodyActorProxy>(ASROCK_BODY.get());
   mActorFactory->RegisterType<AsrockSpoutActorProxy>(ASROCK_SPOUT.get());
   mActorFactory->RegisterType<AsrockActorProxy>(ASROCK_ACTOR.get());
   
   mActorFactory->RegisterType<RBUBodyActorProxy>(RBU_BODY.get());
   mActorFactory->RegisterType<RBUSpoutActorProxy>(RBU_SPOUT.get());
   mActorFactory->RegisterType<RBUActorProxy>(RBU_ACTOR.get());

   mActorFactory->RegisterType<CannonBodyActorProxy>(CANNON_BODY.get());
   mActorFactory->RegisterType<CannonSpoutActorProxy>(CANNON_SPOUT.get());
   
   mActorFactory->RegisterType<TorSutActorProxy>(TORPEDOSUT_ACTOR.get());
   mActorFactory->RegisterType<TorA244ActorProxy>(TORPEDO_ACTOR.get()); //EKA-101111

   mActorFactory->RegisterType<MistralRocketActorProxy>(MISTRAL_ACTOR.get()); //EKA
   mActorFactory->RegisterType<MistralBodyActorProxy>(MISTRAL_BODY.get()); //EKA
   mActorFactory->RegisterType<MistralSpoutActorProxy>(MISTRAL_SPOUT.get()); //EKA

   mActorFactory->RegisterType<TetralBodyActorProxy>(TETRAL_BODY.get()); //EKA
   mActorFactory->RegisterType<TetralSpoutActorProxy>(TETRAL_SPOUT.get()); //EKA
   mActorFactory->RegisterType<TetralRocketActorProxy>(TETRAL_ACTOR.get()); //EKA

   mActorFactory->RegisterType<StrelaRocketActorProxy>(STRELA_ACTOR.get()); //EKA
   mActorFactory->RegisterType<StrelaSpoutActorProxy>(STRELA_SPOUT.get()); //EKA
   mActorFactory->RegisterType<StrelaBodyActorProxy>(STRELA_BODY.get()); //EKA

   mActorFactory->RegisterType<C802MissileActorProxy>(C802_ACTOR.get()); 
   mActorFactory->RegisterType<YakhontMissileActorProxy>(YAKHONT_ACTOR.get());  

   mActorFactory->RegisterType<ExocetMM40ActorProxy>(EXOCETMM40_ACTOR.get());  //NANDO

  mActorFactory->RegisterType<PlayerActorProxy>(PLAYER_ACTOR.get());
}
