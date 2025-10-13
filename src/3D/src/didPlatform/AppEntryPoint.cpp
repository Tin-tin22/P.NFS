#include "export.h"
#include "appentrypoint.h"

#include "../didNetwork/SimTCPDataTypes.h"
#include "../didCommon/BaseConstant.h"
#include "../didCommon/simMessageType.h"
#include "../didSimUnit/didJoystickComponent.h" 
#include "../didSimUnit/didJoystickTDS.h" 

#include <dtGame/gamemanager.h>
#include <dtCore/system.h>

#include <osgDB/readfile>

#include <dtUtil/datapathutils.h>

#include "../didActors/playeractor.h"

#include <dtCore/dt.h> //  [6/5/2013 DID RKT2]
#include <dtCore/transformable.h>

using namespace   dtCore;
using namespace   dtABC;
using namespace   dtAudio;
using namespace   dtUtil;

using dtCore::RefPtr;

//////////////////////////////////////////////////////////////////////////
extern "C" PLATFORM_EXPORT dtGame::GameEntryPoint* CreateGameEntryPoint()
{
   return new AppEntryPoint;
}

//////////////////////////////////////////////////////////////////////////
extern "C" PLATFORM_EXPORT void DestroyGameEntryPoint(dtGame::GameEntryPoint* entryPoint)
{
   delete entryPoint;
}


/**

* @ didPlatform --host 192.168.3.2 --port 7000 --fullscreen "true" --login "OBSERVER" --vehicle "6" --weapon "1"
*/
void AppEntryPoint::Initialize(dtGame::GameApplication& app, int argc, char **argv)
         throw(dtUtil::Exception)
{
	osg::ArgumentParser parser(&argc, argv);
	parser.getApplicationUsage()->addCommandLineOption("--host","Use localhost if not defined");
	parser.getApplicationUsage()->addCommandLineOption("--port","Use port 5555 if not defined");
	parser.getApplicationUsage()->addCommandLineOption("--fullscreen","Full Screen Mode.");
	parser.getApplicationUsage()->addCommandLineOption("--login","must be fill ( ANJUNGAN, OBSERVER, TDS");
	parser.getApplicationUsage()->addCommandLineOption("--vehicle","needed if use ANJUNGAN, OBSERVER, TDS");
	parser.getApplicationUsage()->addCommandLineOption("--weapon","weapon or observer, needed if use OBSERVER, TDS");
	parser.getApplicationUsage()->addCommandLineOption("--launcher","needed if use TDS");
	
	// serial com
	parser.getApplicationUsage()->addCommandLineOption("--useSerialCom","Use Serial Control.");
	parser.getApplicationUsage()->addCommandLineOption("--scPort","Serial Control Port.");
	parser.getApplicationUsage()->addCommandLineOption("--scBoud","Serial Boudrate.");
	parser.getApplicationUsage()->addCommandLineOption("--scData","Serial Databit.");
	parser.getApplicationUsage()->addCommandLineOption("--scFirstPitch","Kalibrasi First Pitch.");
	parser.getApplicationUsage()->addCommandLineOption("--scFirstHeading","Kalibrasi First Heading.");
	parser.getApplicationUsage()->addCommandLineOption("--scFire","Value For Fire.");
	parser.getApplicationUsage()->addCommandLineOption("--scLock","Value For Lock.");

	//Nando Added
	parser.getApplicationUsage()->addCommandLineOption("--useDB","Use Database Connection.");
	parser.getApplicationUsage()->addCommandLineOption("--DBUser", "User Database For Connection");
	parser.getApplicationUsage()->addCommandLineOption("--DBPassword", "Password Database For Connection");
	parser.getApplicationUsage()->addCommandLineOption("--DBName", "Name Database For Connection");

	// player
	parser.getApplicationUsage()->addCommandLineOption("--usePlayer","Use Player Control.");

	mHost.reserve(512);
	if(!parser.read("--host",mHost)){
		mHost = "localhost";
	}

	if(!parser.read("--port",mPort)){
		mPort = 5555;
	}

	if(!parser.read( "--fullscreen", mFullScreen )) {
		mFullScreen = false;	
	}

	mLoginName.reserve(512);
	if(!parser.read("--login",mLoginName)){
		mLoginName = "OBSERVER";
	}
	
	if(!parser.read("--vehicle",mVehicleID)){
		mVehicleID = 0;
	}

	if(!parser.read("--weapon",mWeaponID)){
		mWeaponID = 1;
	}

	if(!parser.read("--launcher",mLauncherID)){
		mLauncherID = 0;
	}

	if (!parser.read("--useSerialCom",mSC_Use)){
		mSC_Use = false;
	}

	if (!parser.read("--useDB",mUseDB)){
		mUseDB = false;
	}

	if ( mUseDB ) {
		if (!parser.read("--DBAddress",mDBAddress)){
			mDBAddress = "127.0.0.1";
		}
		if (!parser.read("--DBUser", mDBUser)){
			mDBUser = "root";
		}
		if (!parser.read("--DBPassword", mDBPassword)){
			mDBPassword = "admin";
		}
		if (!parser.read("--DBName", mDBName)){
			mDBName = "dbNSuFs";
		}
		if (!parser.read("--ScenarioID",mScenarioID)){
			mScenarioID = 0;
		}
	}

	if ( mSC_Use)
	{
		if (!parser.read("--scPort",mSC_Port)){
			mSC_Port = 16;
		}
		if (!parser.read("--scBoud",mSC_Boudrate)){
			//mSC_Boudrate = 9600;
			mSC_Boudrate = 19200;
		}

		if (!parser.read("--scData",mSC_Data)){
			mSC_Data = 12;
		}

		if (!parser.read("--scFirstPitch",mSC_InitFirstPitch)){
			mSC_InitFirstPitch = 15;
		}

		if (!parser.read("--scFirstHeading",mSC_InitFirstHeading)){
			mSC_InitFirstHeading = 0;
		}

		if (!parser.read("--scFire",mSC_Fire)){
			//mSC_Fire = 254; // - 254 = FE [5/21/2014 EKA]
			mSC_Fire = 71; // - 71 = G [6/4/2014 EKA]
		}

		if (!parser.read("--scFire",mSC_Lock)){
			//mSC_Lock = 253; // - 251 = FB , 253 = FD [5/21/2014 EKA]
			mSC_Lock = 75; // - 75 = K [6/4/2014 EKA]
		}
	}

	if (!parser.read("--usePlayer",mUsePlayer)){
		mUsePlayer = false;
	}

}

void AppEntryPoint::OnShutdown(dtGame::GameApplication& app)
{
	//dtNetGM::ClientNetworkComponent* netGM = 
	//		static_cast<dtNetGM::ClientNetworkComponent*>(GetGameManager()->GetComponentByName("ClientNetworkComponent"));	
	CSocketClientGM* netGM = static_cast<CSocketClientGM*>(app.GetGameManager()->GetComponentByName("ClientNetworkComponent"));	

	LOG_INFO("shutdown");
	if (netGM)
	{

		if(netGM->IsConnectedClient()) //netGM is used for checking if Client connected
		{
			dtCore::RefPtr<dtGame::Message> msg;

			msg = app.GetGameManager()->GetMessageFactory().CreateMessage(dtGame::MessageType::NETCLIENT_NOTIFY_DISCONNECT);	
			msg->SetDestination(netGM->GetServer()); //netGM is used for getting Server machineinfo

			app.GetGameManager()->SendNetworkMessage(*msg);
			LOG_INFO("Requesting disconnection.");
		}
		else 
		{
			LOG_ERROR("Error setting up client connection");
			return;
		}
	}
	if (mClientComp)
		mClientComp->ShutdownNetwork();
}

/* set login */
void AppEntryPoint::SetLogin()
{
   /*
   mMessageProc->mLoginName		= mLoginName;
   mMessageProc->mVehicleID		= mVehicleID;
   mMessageProc->mWeaponID		= mWeaponID;
   mMessageProc->mLauncherID	= mLauncherID;
   */
}

void AppEntryPoint::SetMachineName() 
{
	if ( mLoginName == C_LOGIN_OBSERVER )
	{
		std::ostringstream sID ;
		sID << mWeaponID ;
		mMachineID = START_MACHINE_OBSERVER + mWeaponID ;     
		mMachineName = mLoginName +"-"+sID.str();
	} else if ( mLoginName == C_LOGIN_ANJUNGAN )
	{
		std::ostringstream sVehicle ;
		sVehicle << mVehicleID ;
		mMachineID = START_MACHINE_ANJUNGAN + mLauncherID ;   
		mMachineName = mLoginName +"-"+sVehicle.str();
	} else if ( mLoginName == C_LOGIN_TDS )
	{
		std::ostringstream sLauncher ;
		sLauncher << mLauncherID ;
		mMachineID = START_MACHINE_TDS + mVehicleID + mWeaponID + mLauncherID ;  
		mMachineName = mLoginName +"-"+sLauncher.str();
	} 
}

void AppEntryPoint::OnStartup(dtGame::GameApplication& app)
{
	

	//////////
	dtUtil::SetDataFilePathList(dtUtil::GetDeltaDataPathList() + 
		":../data" +
		":../data/model" +
		":../data/particles" +
		":../data/sounds" +
		":../data/mesh");  

	dtGame::GameManager& gameManager = *app.GetGameManager();

	SetMachineName();

	app.GetGameManager()->GetMachineInfo().SetName(mMachineName);
	
	app.GetWindow()->SetWindowTitle("Client3D");

	//load actor library
	app.GetGameManager()->LoadActorRegistry("didActors");

	// register user message
	SimMessageType::RegisterMessageTypes(app.GetGameManager()->GetMessageFactory() );

	std::cout << "Creating Server Client Component ...";
	mSimServerClientComponent = new SimServerClientComponent();
	gameManager.AddComponent(*mSimServerClientComponent, dtGame::GameManager::ComponentPriority::NORMAL);
	std::cout << "done.\n";

	bool dbConnected = false ;
	if ( mUseDB ) {
		std::cout << "Creating database connection ...";
		mSimDatabaseConnection= new SimDBConnection;
		gameManager.AddComponent(*mSimDatabaseConnection, dtGame::GameManager::ComponentPriority::NORMAL);
		dbConnected = mSimDatabaseConnection->ConnectDatabase(mDBAddress,mDBUser,mDBPassword,mDBName);
	}

	if ( dbConnected )
	{
		std::cout << "Create Environment From Database Scenario " << mScenarioID << std::endl;
		mSimDatabaseConnection->CreateOceanConfigFromDatabase(mScenarioID);
	    mSimDatabaseConnection->CreateEnvironmentFromDatabase(gameManager, mScenarioID);

		//Environment Database
		mSimEnvironmentDB = new SimEnvironmentDataBase;
		gameManager.AddComponent(*mSimEnvironmentDB, dtGame::GameManager::ComponentPriority::NORMAL);
		mSimEnvironmentDB->loadEnvironmentFromDatabase(mScenarioID);
	}

	std::cout << "Set login data ...";
	// message component
	mMessageProc = new SimClientMessageProc();
	//SetLogin();
	mMessageProc->SetLoginClientData(mMachineID,mLoginName,mVehicleID,mWeaponID,mLauncherID);
	LOG_INFO("Message Processor Created");
	std::cout <<" done.\n";

	// set server net manager
	//JetByteTools::Win32::CSharedCriticalSection lockFactory(47);
	unsigned long iAddress = inet_addr(mHost.data()); 
	mClientComp = new CSocketClientGM("WarShipGame", 1, "client.log",/*lockFactory,*/ntohl(iAddress)/*INADDR_ANY*/,mPort);
	LOG_INFO("Client Network Component Created");
 
	SetAudio(app);
	 
	if ( mLoginName == C_LOGIN_OBSERVER)
	{
		std::cout << "Creating input handler for observer...";
		mSimInputClientComp  = new InputComponent("SimClientInputComponent", false);
		gameManager.AddComponent(*mSimInputClientComp, dtGame::GameManager::ComponentPriority::NORMAL);
		std::cout << "done.\n";

		SetCamera (app);
	}
	else
	if ( mLoginName == C_LOGIN_ANJUNGAN)
	{
		std::cout << "Creating JOYSTICK controler component...";

		didJoystickComponent *joycomp = new didJoystickComponent("didJoystickComponent");
		gameManager.AddComponent(*joycomp,dtGame::GameManager::ComponentPriority::NORMAL);

		joycomp->Init(mLoginName);

		std::cout << "done." << std::endl;
		 
	}
	else
	if ( mLoginName == C_LOGIN_TDS)
	{
		 SetInputController(gameManager);
	}
	 
	app.GetWindow()->SetWindowTitle("Client3D ( "+app.GetGameManager()->GetMachineInfo().GetName()+" )");
    app.GetWindow()->SetFullScreenMode(mFullScreen);
	app.GetWindow()->ShowCursor(false);

  	// add component to GM
	std::cout << "Adding components...";
	///////////////////////////////////-----------------------///////////////////////////////////////
	gameManager.AddComponent(*mMessageProc, dtGame::GameManager::ComponentPriority::HIGHEST);
	gameManager.AddComponent(*mClientComp, dtGame::GameManager::ComponentPriority::HIGHER);
	///////////////////////////////////-----------------------///////////////////////////////////////
	/// mEnvControl->CreateOceanActor(gameManager);
	std::cout << " done.\n";

	std::cout << "Loading Effect Controller ...";
	mEffectCtrl = new SimEffectControl();
	gameManager.AddComponent(*mEffectCtrl, dtGame::GameManager::ComponentPriority::LOWER);
	std::cout << "done.\n";

	// prepare connection
	std::cout << "Connecting to: " << mHost <<" port: "<< mPort << "...";
	bool bConnected = mClientComp->SetupClient(iAddress, mPort);
	if (!bConnected)
	{
		std::cout << " failed.\n";
		app.GetGameManager()->GetApplication().Quit();
		exit(1); // -  [7/10/2014 EKA]
	}
	else 
	{
		std::cout << " done.\n";
	}

	std::string thisUpper(""); 
	thisUpper = mMachineName;
	std::transform(thisUpper.begin(), thisUpper.end(),thisUpper.begin(), ::toupper);

	if ( (mLoginName == C_LOGIN_TDS) && ( (mWeaponID == CT_MISTRAL) || (mWeaponID == CT_STRELA)) )
	{
		dtCore::DeltaWin::PositionSize size = app.GetWindow()->GetPosition();
		//std::cout << size.mWidth << " - " << size.mHeight << std::endl;
		app.GetWindow()->SetPosition(0,0,size.mWidth, size.mHeight-150);
	}

	std::cout << "................"<< std::endl; 
	std::cout << "3D "<<thisUpper<<" READY"<< std::endl;  
	std::cout << "......... ......."<< std::endl;
}

void AppEntryPoint::SetInputController(dtGame::GameManager &gameManager)
{	
	if ( mUsePlayer )
		mSimServerClientComponent->CreatePlayer(mMachineID, true);

	if ( mSC_Use )
	{
		std::cout << "Setting Port Control ... ";
		mSerialControl= new simSerialControl;
		gameManager.AddComponent(*mSerialControl, dtGame::GameManager::ComponentPriority::NORMAL);
		mSerialControl->Init(mVehicleID,mWeaponID,mLauncherID,mSC_Port,mSC_Boudrate,mSC_Data, mSC_InitFirstPitch, mSC_InitFirstHeading ,mSC_Fire,mSC_Lock,true);
		mSerialControl->SetIsRunning(true);
		std::cout << "done.\n";

	} else
	{
		std::cout << "Creating JOYSTICK controler component for TDS...";
		didJoystickTDS *joytds = new didJoystickTDS("didJoystickTDS");
		gameManager.AddComponent(*joytds,dtGame::GameManager::ComponentPriority::NORMAL);
		joytds->Init(mVehicleID,mWeaponID,mLauncherID);
		//gameManager.GetApplication().GetCamera()->SetNearFarCullingMode(dtCore::Camera::NO_AUTO_NEAR_FAR);
		std::cout << "done.\n";
	}
}


void AppEntryPoint::SetAudio(dtGame::GameApplication& app)
{
	app.AddSender(&dtCore::System::GetInstance() );
	dtAudio::AudioManager::Instantiate();
	dtAudio::AudioManager::GetInstance().SetDistanceModel(AL_LINEAR_DISTANCE);

	mMic = dtAudio::AudioManager::GetListener();
	mMic->SetName("Server Audio Listener");
	mMic->SetGain(0.9f);
	assert( mMic );
	dtCore::Camera* cam = app.GetCamera();
	assert( cam );
	cam->AddChild( mMic );
	dtCore::Transform transform( 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f );
	mMic->SetTransform( transform, Transformable::REL_CS );

}

void AppEntryPoint::SetCamera(dtGame::GameApplication& app)
{
	if ( mUsePlayer )
	    mSimServerClientComponent->CreatePlayer(mMachineID, false);
}

AppEntryPoint::~AppEntryPoint(void)
{
	dtAudio::AudioManager::Destroy();
}
