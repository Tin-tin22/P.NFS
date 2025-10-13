#include "didactorsheaders.h"


#include <dtActors/gamemeshactor.h>

///////////////////////////////////////////////////////////////////////////////
class DID_ACTORS_EXPORT TreeActor : public dtActors::GameMeshActor
{
    public:
        // Constructs the tree actor.
        TreeActor(dtGame::GameActorProxy& proxy);

        /**
        * Called when the actor has been added to the game manager.
        */
        virtual void AddedToScene(dtCore::Scene* scene);

    protected:
        virtual ~TreeActor() {}
};

///////////////////////////////////////////////////////////////////////////////
class DID_ACTORS_EXPORT TreeActorProxy : public dtActors::GameMeshActorProxy
    {
    public :
        virtual void CreateActor() { SetActor(*new TreeActor(*this));}
        TreeActorProxy();
    protected:
        virtual ~TreeActorProxy() {}
    private:
    };

//-- BAWE-20111003: PEPOHONAN