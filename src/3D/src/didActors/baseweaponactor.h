#ifndef BASE_WEAPON_H
#define BASE_WEAPON_H

//Environment
#include "../didUtils/SimEnvironmentDB.h"

#include "didactorsheaders.h"

class DID_ACTORS_EXPORT BaseWeaponActor: public dtGame::GameActor
{
    public:
        BaseWeaponActor(dtGame::GameActorProxy& proxy);
		
        void SetVehicleID(const int val);
        int GetVehicleID()const;

		void SetWeaponID(const int val) ;
		int GetWeaponID() const;
		
        void SetLauncherID(const int val);
        int GetLauncherID() const;

		//Nando Added
		void SetStartAngle(const float val) ;
		int GetStartAngle() const;

		void SetEndAngle(const float val);
		int GetEndAngle() const;

		void SetStartPitch(const float val) ;
		int GetStartPitch() const;

		void SetEndPitch(const float val);
		int GetEndPitch() const;

		/**
		* @ val input = C_WEAPON_TYPE_BODY / C_WEAPON_TYPE_SPOUT / C_WEAPON_TYPE_MISSILE
		*/
		void SetWeaponTypeID ( const int val);
		/**
		* @ return = C_WEAPON_TYPE_BODY / C_WEAPON_TYPE_SPOUT / C_WEAPON_TYPE_MISSILE
		*/
		int GetWeaponTypeID() const ;

		void SetModel(const std::string &fileName);
		std::string GetModel() const;

		void SetAttachDOFName ( const std::string &name);
		std::string GetAttachDOFName()const ;
		
		void SetInitHeading(int val) ;
		float GetInitHeading();

		void SetInitPitch(int val) ;
		float GetInitPitch();

		void UpdateStatusDBEffectTo3DExplode( const float x, const float y, const float z, const int sts);
		void UpdateStatusPlayer( const int sts);

		void SendStatusMessageTo2D(const int MsgID, const double cmd1,const double cmd2, const double cmd3, const double cmd4);

		/**
		* @ actTypeID = C_WEAPON_TYPE_BODY / C_WEAPON_TYPE_SPOUT / C_WEAPON_TYPE_MISSILE
		* @ see utilityfunction.h GetActorWeaponTypeName
		*/
		dtCore::RefPtr<dtDAL::ActorProxy> GetLauncherActors( const int actTypeID, const int mVehicleID, const int mWeaponID, const int mLauncherID );
		dtCore::RefPtr<dtDAL::ActorProxy> GetShipActorByID(const int VID );

		//Get Environment
		float GetEnvi_SeaState();
		float GetEnvi_WindSpeed();
		float GetEnvi_CurrrentSpeed();
		float GetEnvi_Temperature();
		float GetEnvi_BarometerPressure();
		float GetEnvi_Humidity();
		float GetEnvi_WindDirection();
		float GetEnvi_CurrentDirection();
		float GetFog_Height();

		//Envi Calc
		//Ocean
		float GetOceanDirX();
		float GetOceanDirY();
		float OceanEnviX;
		float OceanEnviY;
		//Wind
		float GetWindDirX();
		float GetWindDirY();
		float WindEnviX;
		float WindEnviY;

		virtual void OnEnteredWorld();
		virtual void OnRemovedFromWorld();
        
    protected:
 
        virtual ~BaseWeaponActor();
        
    public:
		int             mVehicleID;
		int             mWeaponID;
		int             mLauncherID;
		int				mWeaponTypeID;
		int				mPosInitHeading;
		int				mPosInitPitch;

		float			mStartAngle;
		float			mEndAngle;
		float			mStartPitch;
		float			mEndPitch;

		std::string		mDofName;

	private :
		
		std::string		mModelFile;
		

};


class DID_ACTORS_EXPORT BaseWeaponActorProxy: public dtGame::GameActorProxy
{
public:

	BaseWeaponActorProxy();
	virtual void BuildPropertyMap();
	virtual void BuildInvokables();

	virtual void CreateActor() { SetActor(*new BaseWeaponActor(*this)); }

protected:
	virtual ~BaseWeaponActorProxy();
	virtual void OnEnteredWorld();
	virtual void OnRemovedFromWorld();


private:


};


#endif
