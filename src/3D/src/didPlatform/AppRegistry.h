//++ BAWE-20101025: LEAK DETECTION
#ifdef USE_VLD

#include <vld.h>

#endif
//++ BAWE-20101025: LEAK DETECTION

#include "export.h"
#include <dtDAL/actorpluginregistry.h>

namespace simPlatform{
	class PLATFORM_EXPORT AppRegistry : public dtDAL::ActorPluginRegistry
	{
		public:

		// Constructs our registry.  Creates the actor types easy access when needed.
		AppRegistry();

		// Registers actor types with the actor factory in the super class.
		virtual void RegisterActorTypes();
	};
}
