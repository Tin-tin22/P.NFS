#ifndef LAUNCHER_BODY_ACTOR_H
#define LAUNCHER_BODY_ACTOR_H

#include "didactorsheaders.h"
#include "baseweaponactor.h"


class DID_ACTORS_EXPORT LauncherBodyActor: public BaseWeaponActor
{
    public:
        LauncherBodyActor(dtGame::GameActorProxy& proxy);

		void SetSwitchName ( const std::string &name);
		std::string GetSwitchName() const ;
		int GetIndexSwitchWeaponParents() ; // dipindah public untuk keperluan on/off launcher [5/1/2013 DID RKT2]

		virtual void OnEnteredWorld();
		virtual void OnRemovedFromWorld();
        
    protected:
		
        virtual ~LauncherBodyActor();
        
    public:

	private :
		std::string		mSwitchName;
		//int GetIndexSwitchWeaponParents() ;
		void SetPositionOnParent();

};


class DID_ACTORS_EXPORT LauncherBodyActorProxy: public BaseWeaponActorProxy
{
public:

	LauncherBodyActorProxy();
	virtual void BuildPropertyMap();
	virtual void BuildInvokables();

	virtual void CreateActor() { SetActor(*new LauncherBodyActor(*this)); }

protected:
	virtual ~LauncherBodyActorProxy();
	virtual void OnEnteredWorld();
	virtual void OnRemovedFromWorld();

private:


};


#endif
