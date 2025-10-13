#ifdef USE_VLD
#include <vld.h>
#endif

#include "export.h"
#include "../didUtils/SimClientMessageProc.h"
#include "../didUtils/SimInputClientComponent.h"
#include "../didUtils/SimSerialControl.h"
#include "../didUtils/SimEffectControl.h"
#include "../didUtils/SimServerClientComponent.h"
#include "../didUtils/SimEnvironmentDB.h"
#include "../didUtils/simDBConnection.h"

#include <dtGame/gameentrypoint.h>
#include <dtGame/gameapplication.h>
#include <dtGame/gamemanager.h>

#include <dtCore/flymotionmodel.h>

#include <dtAudio/sound.h>
#include <dtAudio/audiomanager.h>
#include <dtAudio/soundeffectbinder.h>

namespace dtAudio
{
   class Listener;
   class Sound;
   class SoundEffectBinder;
}

class PLATFORM_EXPORT AppEntryPoint :
	public dtGame::GameEntryPoint
{
	public:
		AppEntryPoint() { };
		virtual ~AppEntryPoint();

		/* initialze application */
		virtual void Initialize(dtGame::GameApplication& app, int argc, char **argv)
				throw(dtUtil::Exception);

		/* set all game behaviour before gamemanager started */
		virtual void OnStartup(dtGame::GameApplication& app);

		/* set all game behaviour before gamemanager shutdown */
		virtual void OnShutdown(dtGame::GameApplication& app);

	private :
		dtAudio::Listener* mMic;
		dtCore::RefPtr<CSocketClientGM> mClientComp;
		dtCore::RefPtr<SimClientMessageProc> mMessageProc;
		dtCore::RefPtr<InputComponent> mSimInputClientComp;
		dtCore::RefPtr<simSerialControl> mSerialControl;
		dtCore::RefPtr<SimEffectControl> mEffectCtrl;
		dtCore::RefPtr<SimServerClientComponent> mSimServerClientComponent;
		dtCore::RefPtr<SimEnvironmentDataBase> mSimEnvironmentDB; 
		dtCore::RefPtr<SimDBConnection> mSimDatabaseConnection;
		 
		std::string mHost;
		std::string mLoginName;
		std::string mMachineName;
		int mMachineID; //observer-1,observer-2,TDS-1,TDS-2
		int mPort;
		int mVehicleID;
		int mWeaponID;
		int mLauncherID;
		bool mFullScreen;

		int				mScenarioID;
		bool			mUseDB;
		std::string		mDBAddress;
		std::string		mDBUser;
		std::string		mDBPassword;
		std::string		mDBName;

		// serial com params
		bool mSC_Use;
		int	mSC_Port;
		int	mSC_Boudrate;
		int	mSC_Data;
		int	mSC_InitFirstPitch;
		int	mSC_InitFirstHeading;
		int	mSC_Fire;
		int	mSC_Lock;
		// player var
		bool			mUsePlayer;
		void SetCamera(dtGame::GameApplication& app);
		void SetInputController(dtGame::GameManager &gameManager);
		void SetAudio(dtGame::GameApplication& app);

		/* set login */
		void SetLogin();

		void SetMachineName();

};
