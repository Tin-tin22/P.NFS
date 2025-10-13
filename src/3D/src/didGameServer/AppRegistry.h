#ifdef USE_VLD
#include <vld.h>
#endif

#include "export.h"
#include <dtDAL/actorpluginregistry.h>

class GAME_SERVER_EXPORT AppRegistry : public dtDAL::ActorPluginRegistry
{
	public:
		
		// Static types

		// Constructs our registry.  Creates the actor types easy access when needed.
		AppRegistry();

		// Registers actor types with the actor factory in the super class.
		virtual void RegisterActorTypes();
};
