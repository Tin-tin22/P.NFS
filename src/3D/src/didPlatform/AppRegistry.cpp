#include "AppRegistry.h"

namespace simPlatform{

	///////////////////////////////////////////////////////////////////////////////
	extern "C" PLATFORM_EXPORT dtDAL::ActorPluginRegistry* CreatePluginRegistry()
	{
		return new AppRegistry();
	}

	///////////////////////////////////////////////////////////////////////////////
	extern "C" PLATFORM_EXPORT void DestroyPluginRegistry(dtDAL::ActorPluginRegistry *registry)
	{
		if (registry != NULL)
			delete registry;
	}

	//////////////////////////////////////////////////////////////////////////
	AppRegistry::AppRegistry() :
		dtDAL::ActorPluginRegistry("simPlatform")
	{
		SetDescription("This is platform for simulation");
	}

	//////////////////////////////////////////////////////////////////////////
	void AppRegistry::RegisterActorTypes()
	{
	}
}
