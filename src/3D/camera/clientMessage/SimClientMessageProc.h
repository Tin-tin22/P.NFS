#ifdef USE_VLD
#include <vld.h>
#endif

#include "../didNetwork/SocketClientGM.h"
#include "../didUtils/SimEnvironmentControl.h"

#include <dtGame/defaultmessageprocessor.h>
 
class SimClientMessageProc : public dtGame::DefaultMessageProcessor
{
	public:
		
		SimClientMessageProc(void);
		virtual ~SimClientMessageProc(void);
		void ProcessMessage(const dtGame::Message& msg);

		void SetLoginClientData ( const std::string& LGD, const int VID,const int WID, const int LID );

	private :
		std::string mLoginName;
		int mVehicleID;
		int mWeaponID;
		int mLauncherID;

		bool mFirstInit ;
		bool isTDSNotify;

		bool IsInvalidMessage(const dtGame::Message& msg);
		void HandleNetworkMessage(const dtGame::Message& msg);
		void HandleLocalMessage(const dtGame::Message& msg);

		void SetCameraObserver( const int shipID, const int weaponID, const int launcherID, const int missileID, const int missileNum, const int orderID);

		void ProcessUtilityAndToolObserver(const dtGame::Message& msg);
		void ProcessUpdateParentMessage(const dtGame::Message& msg);
		void ProcessApplyLoginMessage(const dtGame::Message& msg);
		void ProcessRequestTDS();
		void ProcessRequestLogin();

		void MissileExplode(int WeaponType, float PosX, float PosY, float PosZ, int Status);

		void RegisterEventOnActors(dtGame::GameActorProxy& gap, const std::string& actTypeName  );
		void ProcessCreateActor(const dtGame::ActorUpdateMessage &msg);
		dtCore::RefPtr<dtGame::GameActorProxy> ProcessRemoteCreateActor(const dtGame::ActorUpdateMessage& msg);

		dtCore::RefPtr<dtDAL::ActorProxy> GetMissileActor( const int mVehicleID, const int mWeaponID, const int mLauncherID, const int mMissileID, const int mMissileNum );
		
		//Nando Added.. (nanti Tanya Mas Sam Untuk lebih lanjut... Sikat sek sak onoke..ehehehe)
		dtCore::RefPtr<dtDAL::ActorProxy> GetLauncherActors( const int actTypeID , const int mVehicleID, const int mWeaponID, const int mLauncherID );
		dtCore::RefPtr<dtDAL::ActorProxy> GetShipActorByID(int mVehicleID );
		
		void SetCameraAppObserverMissileActorByName(const std::string& mTypeMissile, const int VID, const int LID,const int missileID );

};
