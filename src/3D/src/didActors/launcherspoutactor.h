#ifndef LAUNCHER_SPOUT_ACTOR_H
#define LAUNCHER_SPOUT_ACTOR_H

#include "didactorsheaders.h"
#include "baseweaponactor.h"

class DID_ACTORS_EXPORT LauncherSpoutActor: public BaseWeaponActor
{
    public:
        LauncherSpoutActor(dtGame::GameActorProxy& proxy);

		virtual void OnEnteredWorld();
		virtual void OnRemovedFromWorld();
        
    protected:
		
        virtual ~LauncherSpoutActor();

		float	GetDistanceCone(osg::Vec3 point1, osg::Vec3 point2);
		float	GetDistance(osg::Vec3 point1, osg::Vec3 point2);

		bool 	IsInCone(osg::Vec3 origin, osg::Vec3 pointToTest, float heading, float pitch, float distanceToTarget, float coneRadius);
        
    public:
    
	private :
		void SetPositionOnParent(); 
};


class DID_ACTORS_EXPORT LauncherSpoutActorProxy: public BaseWeaponActorProxy
{
public:

	LauncherSpoutActorProxy();
	virtual void BuildPropertyMap();
	virtual void BuildInvokables();

	virtual void CreateActor() { SetActor(*new LauncherSpoutActor(*this)); }

protected:
	virtual ~LauncherSpoutActorProxy();
	virtual void OnEnteredWorld();

private:


};

#endif