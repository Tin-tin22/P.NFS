#include <dtDAL/actorpluginregistry.h>
#include "export.h"

class DID_ACTORS_EXPORT DIDActorRegistry : public dtDAL::ActorPluginRegistry
{
public:
   static dtCore::RefPtr<dtDAL::ActorType> OCEAN_ACTOR_TYPE; 
   static dtCore::RefPtr<dtDAL::ActorType> OCEAN_CONFIG_ACTOR_TYPE; 
   static dtCore::RefPtr<dtDAL::ActorType> TREE_ACTOR;  
   static dtCore::RefPtr<dtDAL::ActorType> SHIP_MODEL_ACTOR; 
   static dtCore::RefPtr<dtDAL::ActorType> SUB_MARINE_ACTOR; 
   static dtCore::RefPtr<dtDAL::ActorType> HELICOPTER_ACTOR;
   static dtCore::RefPtr<dtDAL::ActorType> AIRCRAFT_ACTOR;
   static dtCore::RefPtr<dtDAL::ActorType> MISC_OBJECT_ACTOR; 
   static dtCore::RefPtr<dtDAL::ActorType> EFFECT_ACTOR; 
   static dtCore::RefPtr<dtDAL::ActorType> ASROCK_BODY;
   static dtCore::RefPtr<dtDAL::ActorType> ASROCK_SPOUT;
   static dtCore::RefPtr<dtDAL::ActorType> ASROCK_ACTOR;
   static dtCore::RefPtr<dtDAL::ActorType> RBU_BODY;
   static dtCore::RefPtr<dtDAL::ActorType> RBU_SPOUT;
   static dtCore::RefPtr<dtDAL::ActorType> RBU_ACTOR;
   static dtCore::RefPtr<dtDAL::ActorType> CANNON_BODY;
   static dtCore::RefPtr<dtDAL::ActorType> CANNON_SPOUT;
   static dtCore::RefPtr<dtDAL::ActorType> TORPEDOSUT_ACTOR;
   static dtCore::RefPtr<dtDAL::ActorType> TORPEDO_ACTOR; //EKA-101111
   static dtCore::RefPtr<dtDAL::ActorType> MISTRAL_BODY; //EKA
   static dtCore::RefPtr<dtDAL::ActorType> MISTRAL_SPOUT; //EKA
   static dtCore::RefPtr<dtDAL::ActorType> MISTRAL_ACTOR; //EKA
   static dtCore::RefPtr<dtDAL::ActorType> TETRAL_BODY; //EKA
   static dtCore::RefPtr<dtDAL::ActorType> TETRAL_SPOUT; //EKA
   static dtCore::RefPtr<dtDAL::ActorType> TETRAL_ACTOR; //EKA
   static dtCore::RefPtr<dtDAL::ActorType> STRELA_BODY; //EKA
   static dtCore::RefPtr<dtDAL::ActorType> STRELA_SPOUT; //EKA
   static dtCore::RefPtr<dtDAL::ActorType> STRELA_ACTOR; //EKA
   static dtCore::RefPtr<dtDAL::ActorType> EXOCETMM40_ACTOR; //NANDO
   static dtCore::RefPtr<dtDAL::ActorType> C802_ACTOR;   
   static dtCore::RefPtr<dtDAL::ActorType> YAKHONT_ACTOR;  

   static dtCore::RefPtr<dtDAL::ActorType> PLAYER_ACTOR;  

   DIDActorRegistry();

   void RegisterActorTypes();
};
