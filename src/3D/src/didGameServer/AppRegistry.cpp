#include "AppRegistry.h"
#include "../didCommon/BaseConstant.h"

 

///////////////////////////////////////////////////////////////////////////////
extern "C" GAME_SERVER_EXPORT dtDAL::ActorPluginRegistry* CreatePluginRegistry()
{
	return new AppRegistry();
}

///////////////////////////////////////////////////////////////////////////////
extern "C" GAME_SERVER_EXPORT void DestroyPluginRegistry(dtDAL::ActorPluginRegistry *registry)
{
	if (registry != NULL)
		delete registry;
}

//////////////////////////////////////////////////////////////////////////
AppRegistry::AppRegistry() :
	dtDAL::ActorPluginRegistry("simGameServer")
{
	SetDescription("This is server for simulation");
}

//////////////////////////////////////////////////////////////////////////
void AppRegistry::RegisterActorTypes()
{
 
}

