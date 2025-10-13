#ifdef USE_VLD

#include <vld.h>

#endif

#include "export.h"
#include "../didNetwork/socketserver.h"
#include "../didCommon/SimServerMessage.h"
#include "../didUtils/siminputservercomponent.h"
#include "../didUtils/SimSerialControl.h"
#include "../didUtils/SimActorControl.h"
#include "../didUtils/simDBConnection.h"
#include "../didUtils/SimEffectControl.h"
#include "../didUtils/SimServerClientComponent.h"
#include "../didUtils/CanonHandle.h" //  [5/6/2013 DID RKT2]
#include "../didUtils/SimEnvironmentDB.h"

#include <dtCore/refptr.h>
#include <dtCore/infinitelight.h>
#include <dtCore/infiniteterrain.h>
#include <dtCore/camera.h>
#include <dtCore/flymotionmodel.h>
//#include <dtCore/transformable.h>

#include <dtGame/gameentrypoint.h>
#include <dtGame/gamemanager.h>

#include <dtTerrain/terrain.h>
#include <dtTerrain/dtedterrainreader.h>
#include <dtTerrain/soarxterrainrenderer.h>
#include <dtTerrain/vegetationdecorator.h>
#include <dtTerrain/colormapdecorator.h>
#include <dtTerrain/geocoordinates.h> 

#include <dtAudio/sound.h>
#include <dtAudio/audiomanager.h>
#include <dtAudio/soundeffectbinder.h>


namespace dtGame
{
   class GameManager;
}

namespace dtAudio
{
   class Listener;
   class Sound;
   class SoundEffectBinder;
}


class GAME_SERVER_EXPORT AppEntryPoint :
	public dtGame::GameEntryPoint
{
	public:
		AppEntryPoint();
		virtual ~AppEntryPoint();

		/* initialze application */
		virtual void Initialize(dtGame::GameApplication& app, int argc, char **argv)
				throw(dtUtil::Exception);

		/* set all game behaviour before gamemanager started */
		virtual void OnStartup(dtGame::GameApplication& app);

		/* set all game behaviour before gamemanager shutdown */
		virtual void OnShutdown(dtGame::GameApplication& app);


	private :
		dtAudio::Listener *mMic;
		dtCore::RefPtr<dtCore::FlyMotionModel> fmm;


		dtCore::RefPtr<SimServerClientComponent> mSimServerClientComponent;

		/* server message processor component */
		dtCore::RefPtr<SimServerMessage> mSimServerMessageComp;

		/* server input component */
		dtCore::RefPtr<InputComponent> mSimInputServerComp;


		/* socket cross communication component */
		dtCore::RefPtr<CSocketServer> mSocketComponent;
		dtCore::RefPtr<CSocketServerGM> mSimServerNetworkComp;
        dtCore::RefPtr<SimActorControl> mSimActorControl;
		dtCore::RefPtr<SimDBConnection> mSimDatabaseConnection;
		dtCore::RefPtr<simSerialControl> mSerialControl;
		dtCore::RefPtr<SimEffectControl> mEffectCtrl;
		dtCore::RefPtr<CanonHandle> mCanonHandle;
		dtCore::RefPtr<SimEnvironmentDataBase> mSimEnvironmentDB; 

		int				mPort;
		int				mScenarioID;
		bool			mFullScreen;
		bool			mUseDB;
		std::string		mDBAddress;
		//Nando Added
		std::string		mDBUser;
		std::string		mDBPassword;
		std::string		mDBName;
		//standalone params
		bool			mIsStandAlone;
		int				mVehicleID;
		int				mWeaponID;
		int				mLauncherID;
		// serial com params
		bool			mSC_Use;
		int				mSC_Port;
		int				mSC_Boudrate;
		int				mSC_Data;
		int				mSC_InitFirstPitch;
		int				mSC_InitFirstHeading;
		int				mSC_Fire;
		int				mSC_Lock;
		// player var
		bool			mUsePlayer;
		/* set login for client, must be load from scenario */
		void SetupLogins();

		/* set custom actor, must be load from scenario */
		void InitializeCustomActors(dtGame::GameManager &gameManager, const bool useDB);

		void SetStandAloneApp(dtGame::GameManager &gameManager);

		/* set camera function */
		void SetCamera(dtGame::GameApplication& app);

		/* set Audio */
		void SetAudio(dtGame::GameApplication& app);

		/* register user typed message */
		void RegisterUserMessagesToGameActor(dtGame::GameManager &gameManager);

};
