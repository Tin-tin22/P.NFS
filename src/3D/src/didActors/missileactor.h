#ifndef MISSILE_ACTOR_H
#define MISSILE_ACTOR_H

#include "didactorsheaders.h"
#include "baseweaponactor.h"

class DID_ACTORS_EXPORT MissilesActor: public BaseWeaponActor
{
    public:
        MissilesActor(dtGame::GameActorProxy& proxy);

		void chkPassable(const dtCore::DeltaDrawable *t, const dtCore::DeltaDrawable *s, bool &bChk);

		void AddToEnvironmentActor();

		void SetMissileID(int val);
		int GetMissileID();

		void SetMissileNum(int val);
		int GetMissileNum();

		void SetMissileLethality(int val);
		int GetMissileLethality();

		void SetLaunched(bool val);
		bool GetLaunched();

		void SetHasLauncher(bool val);
		bool GetHasLauncher();
		 
		bool IsMissileValidID ( const int VID, const int WID, const int LID, const int MID, const int MNum );
		void SendMessageToServer( const int mVehicleID, int OrderID);
		void UpdateStatusDBEffectTo2D( const dtCore::DeltaDrawable *mVehicle, int OrderID );
		//void UpdateStatusDBEffectTo2D( const dtCore::UniqueId& uniqueId, int OrderID );
		void UpdateStatusDBEffectTo2D( const dtCore::DeltaDrawable *mVehicle, int OrderID, int Lethality );

		void SendExplode(const int ExplodeID, const int ExplodeType, const float ExplodeLife, const osg::Vec3 pos);

		virtual void OnEnteredWorld();
		virtual void OnRemovedFromWorld();

		bool 	IsInCone(osg::Vec3 origin, osg::Vec3 pointToTest, float heading, float pitch, float distanceToTarget, float coneRadius);
		float	GetDistanceCone(osg::Vec3 point1, osg::Vec3 point2);
		float	GetDistance(osg::Vec3 point1, osg::Vec3 point2);
		float	GetPitch(osg::Vec3 point1, osg::Vec3 point2);

		void FreeSound(dtAudio::Sound *tmpSound);
       
    protected:
		
        virtual ~MissilesActor();
		dtDAL::ActorProxy* CeckCollision(float pSpeed, float pDeltaTime);
        
    public:
    
		int				mMissileID;
		int				mMissileNum;
		int				Lethality;
		bool			isLaunch;
		bool			isHasLauncher;
		
		osg::Vec3		mHitPointCollision;

		dtCore::RefPtr<dtCore::DeltaDrawable> mMyParent;
		dtCore::RefPtr<dtAudio::Sound> missileSound;

	private :
		
		//dtCore::RefPtr<dtCore::Isector> mIsector;

		void	SetPositionOnParent();

		float distance;
};

class DID_ACTORS_EXPORT MissilesActorProxy: public BaseWeaponActorProxy
{
public:

	MissilesActorProxy();
	virtual void BuildPropertyMap();
	virtual void BuildInvokables();

	virtual void CreateActor() { SetActor(*new MissilesActor(*this)); }

protected:
	virtual ~MissilesActorProxy();
	virtual void OnEnteredWorld();
	virtual void OnRemovedFromWorld();

private:
};

#endif