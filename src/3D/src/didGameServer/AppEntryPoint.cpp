#include <vld.h>

#include "export.h"
#include "appentrypoint.h"
#include "AppRegistry.h"
#include <assert.h>
 
#include <dtGame/gamemanager.h>
#include <dtGame/defaultmessageprocessor.h>
#include <dtGame/gameapplication.h>
#include <dtGame/exceptionenum.h>

#include <dtCore/refptr.h>
#include <dtCore/system.h>

#include <dtABC/application.h>

#include <osg/ArgumentParser>
#include <osg/ApplicationUsage>

#include <dtDAL/actortype.h>
#include <dtDAL/Actorproperty.h>
#include <dtDal/enginepropertytypes.h>

#include <osgDB/readfile>

#include <dtUtil/fileutils.h>
#include "../didUtils/simActorControl.h"
#include "../didUtils/utilityfunctions.h"
#include "../didActors/launcherspoutactor.h"
#include "../didActors/shipmodelactor.h"

#include "../didSimUnit/didJoystickComponent.h" 
#include "../didSimUnit/didJoystickTDS.h" 

#include "../didUtils/SimSerialControl.h" 

#include "../didActors/playeractor.h"
#include "../didNetwork/SimTCPDataTypes.h" 

#include <dtCore/dt.h> //  [6/5/2013 DID RKT2]

using namespace   dtCore;
using namespace   dtABC;
using namespace   dtAudio;
using namespace   dtUtil;

//////////////////////////////////////////////////////////////////////////
extern "C" GAME_SERVER_EXPORT dtGame::GameEntryPoint* CreateGameEntryPoint()
{
   return new AppEntryPoint;
}

//////////////////////////////////////////////////////////////////////////
extern "C" GAME_SERVER_EXPORT void DestroyGameEntryPoint(dtGame::GameEntryPoint* entryPoint)
{
   delete entryPoint;
}
 
void AppEntryPoint::SetupLogins()
{
}

void AppEntryPoint::RegisterUserMessagesToGameActor(dtGame::GameManager &gameManager)
{
  // definisikan tipe message pada masing2 aktor disin

	std::vector<dtGame::GameActorProxy*> toFill;
	gameManager.GetAllGameActors(toFill);

	for(std::vector<dtGame::GameActorProxy*>::iterator iter = toFill.begin(); 
		iter!=toFill.end(); iter++ ){
			gameManager.RegisterForMessages(dtGame::MessageType::TICK_LOCAL,*(*iter),dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);

			std::string actTypeName = (*iter)->GetActorType().GetName();
			/// hanya event yang sesuai per actor di register

			if (( actTypeName == C_CN_OCEAN ) || ( actTypeName == C_CN_OCEAN_CFG ) )
			{
				// do nothing
				continue;
			} else
			if (( actTypeName == C_CN_SHIP ) || ( actTypeName == C_CN_SUBMARINE )||( actTypeName == C_CN_HELICOPTER )||( actTypeName == C_CN_AIRCRAFT ))
			{
				gameManager.RegisterForMessages(SimMessageType::ORDER_EVENT,*(*iter),dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
			} else
			{
				if (( actTypeName == C_CN_ASROCK )||( actTypeName == C_CN_ASROCKB )||( actTypeName == C_CN_ASROCKS))		
					gameManager.RegisterForMessages(SimMessageType::ASROCK_EVENT,*(*iter),dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
				else if ( actTypeName == C_CN_C802 )			
					gameManager.RegisterForMessages(SimMessageType::C802_EVENT,*(*iter),dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
				else if (( actTypeName == C_CN_CANNONM )|| ( actTypeName == C_CN_CANNONB )||( actTypeName == C_CN_CANNONS ))	
					gameManager.RegisterForMessages(SimMessageType::CANNON_EVENT,*(*iter),dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
				else if ( actTypeName == C_CN_EXOCET_40)	
					gameManager.RegisterForMessages(SimMessageType::EXOCETMM_40_EVENT,*(*iter),dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
				else if (( actTypeName == C_CN_MISTRAL)	|| ( actTypeName == C_CN_MISTRALB) || ( actTypeName == C_CN_MISTRALS ) )	
					gameManager.RegisterForMessages(SimMessageType::MISTRAL_EVENT,*(*iter),dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
				else if (( actTypeName == C_CN_RBU ) || ( actTypeName == C_CN_RBUB ) || ( actTypeName == C_CN_RBUS ))		
					gameManager.RegisterForMessages(SimMessageType::RBU_EVENT,*(*iter),dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
				else if (( actTypeName == C_CN_STRELA) || ( actTypeName == C_CN_STRELAB) || ( actTypeName == C_CN_STRELAS) )			
					gameManager.RegisterForMessages(SimMessageType::STRELA_EVENT,*(*iter),dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
				else if (( actTypeName == C_CN_TETRAL) || ( actTypeName == C_CN_TETRALB) || ( actTypeName == C_CN_TETRALS) )			
					gameManager.RegisterForMessages(SimMessageType::TETRAL_EVENT,*(*iter),dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
				else if ( actTypeName == C_CN_TORPSUT )	
					gameManager.RegisterForMessages(SimMessageType::TORPEDOSUT_EVENT,*(*iter),dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
				else if ( actTypeName == C_CN_TORPEDO )		
					gameManager.RegisterForMessages(SimMessageType::TORPEDO_EVENT,*(*iter),dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
				else if ( actTypeName == C_CN_YAKHONT)		
					gameManager.RegisterForMessages(SimMessageType::YAKHONT_EVENT,*(*iter),dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
				else if ( actTypeName == C_CN_EXOCET_40)
					gameManager.RegisterForMessages(SimMessageType::EXOCETMM_40_EVENT,*(*iter),dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
				else
					std::cout<<" !!!! WARNING !!!! :: ENTRY POINT Unregistered event on  :: "<<actTypeName<<" see [RegisterUserMessagesToGameActor] procedure.."<<std::endl;
			}
	}
}

void AppEntryPoint::InitializeCustomActors(dtGame::GameManager &gameManager, const bool useDB)
{
	std::string name;
	float range = 250.0f;

	dtCore::RefPtr<dtGame::GameActorProxy> gap;
	dtCore::RefPtr<dtGame::GameActor> ga;
	
	if ( useDB )
	{
		for(std::vector<SimActorShipDef*>::iterator iter= mSimDatabaseConnection->mVehicleActors.begin(); 
			iter!=mSimDatabaseConnection->mVehicleActors.end(); iter++ )
		{
			std::ostringstream ost;
			ost <<(*iter)->shipID;
			gap = mSimDatabaseConnection->CreateActor((*iter)->Name);
			gap->GetProperty(C_SET_VID)->FromString( ost.str() );
			ga  = dynamic_cast<dtGame::GameActor*>(gap->GetActor());

			osg::Vec3 trans((*iter)->translation);
			gap->SetTranslation(trans);
			osg::Vec3 rota((*iter)->rotation);
			dtCore::RefPtr<dtDAL::ActorProperty> headProp( gap->GetProperty(C_SET_COURSE) );
			dtCore::RefPtr<dtDAL::ActorProperty> speedProp( gap->GetProperty(C_SET_SPEED) );
			dtCore::RefPtr<dtDAL::ActorProperty> damageProp( gap->GetProperty(C_SET_DAMAGE) );
			if ( headProp!= NULL && speedProp != NULL && damageProp != NULL )
			{
				dtCore::RefPtr<dtDAL::FloatActorProperty> floatprop( static_cast<dtDAL::FloatActorProperty*>( headProp.get() ) );
				floatprop->SetValue((*iter)->rotation.x());
				dtCore::RefPtr<dtDAL::FloatActorProperty> floatSpeedprop( static_cast<dtDAL::FloatActorProperty*>( speedProp.get() ) );
				floatSpeedprop->SetValue((*iter)->speed);
				dtCore::RefPtr<dtDAL::IntActorProperty> intDamageprop( static_cast<dtDAL::IntActorProperty*>( damageProp.get() ) );
				intDamageprop->SetValue((*iter)->damage);
			}
		}
	} 
}

void AppEntryPoint::Initialize(dtGame::GameApplication& app, int argc, char **argv)
         throw(dtUtil::Exception)
{
	osg::ArgumentParser parser(&argc, argv);
	parser.getApplicationUsage()->addCommandLineOption("--port","Use port 5555 if not defined");
	parser.getApplicationUsage()->addCommandLineOption("--fullscreen","Full Screen Mode.");
	parser.getApplicationUsage()->addCommandLineOption("--useDB","Use Database Connection.");
	parser.getApplicationUsage()->addCommandLineOption("--DBAddress","Use Database Address for Connection.");
	parser.getApplicationUsage()->addCommandLineOption("--ScenarioID","Use Database With Init Scenario ID.");
	//Nando Added
	parser.getApplicationUsage()->addCommandLineOption("--DBUser", "User Database For Connection");
	parser.getApplicationUsage()->addCommandLineOption("--DBPassword", "Password Database For Connection");
	parser.getApplicationUsage()->addCommandLineOption("--DBName", "Name Database For Connection");
	// standalone option
	parser.getApplicationUsage()->addCommandLineOption("--standalone", "is standalone");
	parser.getApplicationUsage()->addCommandLineOption("--Vehicle", "Vehicle ID");
	parser.getApplicationUsage()->addCommandLineOption("--Weapon", "Weapon ID");
	parser.getApplicationUsage()->addCommandLineOption("--Launcher", "Launcher ID");
	// serial com
	parser.getApplicationUsage()->addCommandLineOption("--useSerialCom","Use Serial Control.");
	parser.getApplicationUsage()->addCommandLineOption("--scPort","Serial Control Port.");
	parser.getApplicationUsage()->addCommandLineOption("--scBoud","Serial Boudrate.");
	parser.getApplicationUsage()->addCommandLineOption("--scData","Serial Databit.");
	parser.getApplicationUsage()->addCommandLineOption("--scFirstPitch","Kalibrasi First Pitch.");
	parser.getApplicationUsage()->addCommandLineOption("--scFirstHeading","Kalibrasi First Heading.");
	parser.getApplicationUsage()->addCommandLineOption("--scFire","Value For Fire.");
	parser.getApplicationUsage()->addCommandLineOption("--scLock","Value For Lock.");

	parser.getApplicationUsage()->addCommandLineOption("--usePlayer","Use Player Control.");

	if (!parser.read("--port",mPort)){
		mPort = 5555;
	}
 
	if (!parser.read("--fullscreen",mFullScreen)){
		mFullScreen = false;
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

	if (!parser.read("--standalone",mIsStandAlone)){
		mIsStandAlone = false;
	}
	if ( mIsStandAlone ) {
		if (!parser.read("--vehicle",mVehicleID)){
			mVehicleID = 1;
		}
		if (!parser.read("--weapon", mWeaponID)){
			mWeaponID = 1;
		}
		if (!parser.read("--launcher", mLauncherID)){
			mLauncherID = 1;
		}

		if (!parser.read("--useSerialCom",mSC_Use)){
			mSC_Use = false;
		}

		if ( mSC_Use)
		{
			if (!parser.read("--scPort",mSC_Port)){
				mSC_Port = 16;
			}
			if (!parser.read("--scBoud",mSC_Boudrate)){
				mSC_Boudrate = 9600;
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
				mSC_Fire = 254;
			}

			if (!parser.read("--scFire",mSC_Lock)){
				mSC_Lock = 251;
			}
		}

	}

	if (!parser.read("--usePlayer",mUsePlayer)){
		mUsePlayer = false;
	}
}

void AppEntryPoint::OnShutdown(dtGame::GameApplication& app)
{
	//Shutdown network
	if (mSimServerNetworkComp)
		mSimServerNetworkComp->ShutdownNetwork();
	if (mSocketComponent)
		mSocketComponent->InitiateShutdown();
}

void AppEntryPoint::OnStartup(dtGame::GameApplication& app)
{
	VLDEnable();

	dtUtil::SetDataFilePathList(dtUtil::GetDeltaDataPathList() + 
		":../data" +
		":../data/model" +
		":../data/particles" +
		":../data/sounds" +
		":../data/fonts" +
		":../data/mesh"); 

	std::cout<<"Prepare Game Manager .....";
	dtGame::GameManager& gameManager = *app.GetGameManager();

	app.GetWindow()->SetFullScreenMode(mFullScreen);
	app.GetWindow()->ShowCursor(false);

	app.GetWindow()->SetWindowTitle("Server 3D");
	//app.GetScene()->UseSceneLight(true);
	SetAudio(app);

	std::cout << "Registering user messages ...";
	SimMessageType::RegisterMessageTypes(app.GetGameManager()->GetMessageFactory());
	std::cout << "done.\n";

	gameManager.LoadActorRegistry("didActors");
	gameManager.GetMachineInfo().SetName(C_MACHINE_SERVER);

	std::cout << "Creating message handler ...";
	mSimServerMessageComp = new SimServerMessage();
	gameManager.AddComponent(*mSimServerMessageComp, dtGame::GameManager::ComponentPriority::HIGHEST);
	std::cout << "done.\n";

	std::cout << "Creating Server Client Component ...";
	mSimServerClientComponent = new SimServerClientComponent();
	gameManager.AddComponent(*mSimServerClientComponent, dtGame::GameManager::ComponentPriority::NORMAL);
	std::cout << "done.\n";
	
	std::cout << "Creating network handler ...";
	mSimServerNetworkComp = new CSocketServerGM("WarShipGame", 1, "server.log", /*lockFactory,*/ INADDR_ANY, mPort);
	mSimServerNetworkComp->SetName("ServerNetworkComponent");
	gameManager.AddComponent(*mSimServerNetworkComp, dtGame::GameManager::ComponentPriority::HIGHER);
	std::cout << "done.\n";

	//create component socket
	std::cout << "Creating network handler for Instruktur ...\n";
	mSocketComponent = new  CSocketServer("Game Server",
		INADDR_ANY,  /* address, lupa konstantanya, harusnya semua address INADDR_ANY */
		5001,	/* port */
		10,		/* maxfreesocket */
		1,		/* maxfreebuffers */
		1024 * 1024
		);
	mSocketComponent->Start();
	mSocketComponent->StartAcceptingConnections(); 
	gameManager.AddComponent(*mSocketComponent, dtGame::GameManager::ComponentPriority::HIGHER);
	std::cout << "    done.\n";

	std::cout << "Creating input handler ...";
	mSimInputServerComp  = new InputComponent("SimServerInputComponent", false);
	gameManager.AddComponent(*mSimInputServerComp, dtGame::GameManager::ComponentPriority::NORMAL);
	std::cout << "done.\n";

	std::cout << "Creating actor controller ...";
	mSimActorControl= new SimActorControl;
	gameManager.AddComponent(*mSimActorControl, dtGame::GameManager::ComponentPriority::LOWER);
	std::cout << "done.\n";

	std::cout << "Creating canon component ...";
	mCanonHandle= new CanonHandle;
	gameManager.AddComponent(*mCanonHandle, dtGame::GameManager::ComponentPriority::LOWER);
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
		std::cout << "Loading ships data from database ...";
		mSimDatabaseConnection->GetListActorDefDatabase(mScenarioID);
	    std::cout << "done.\n";
		
		std::cout << "Create Environment From Database ScenarioID " << mScenarioID << std::endl;
		mSimDatabaseConnection->CreateOceanConfigFromDatabase(mScenarioID);
	    mSimDatabaseConnection->CreateEnvironmentFromDatabase(gameManager, mScenarioID);
		mSimDatabaseConnection->CreateOceanActor(gameManager);

		mSimEnvironmentDB = new SimEnvironmentDataBase;
		gameManager.AddComponent(*mSimEnvironmentDB, dtGame::GameManager::ComponentPriority::NORMAL);
		mSimEnvironmentDB->loadEnvironmentFromDatabase(mScenarioID);

		if (mCanonHandle != NULL)
		{
			std::cout << "Get Position for NAFAL GUN SUPPORT" << std::endl;
			mCanonHandle->mNGSpos = mSimDatabaseConnection->GetNGSpos(mScenarioID);
		}
	}
	
	std::cout << "Game Environment :: "<<gameManager.GetEnvironmentActor()->GetActor()->GetName()<<std::endl;
	app.GetWindow()->SetWindowTitle("Server 3D");

	std::cout << "Creating ships data scenario\n";
	InitializeCustomActors(gameManager, mUseDB);
	std::cout << "    done.\n";
    
	std::cout << "Registering messages to actors. \n";
	RegisterUserMessagesToGameActor(gameManager);
	
	std::cout << "Loading Effect Controller ...";
	mEffectCtrl = new SimEffectControl();
	gameManager.AddComponent(*mEffectCtrl, dtGame::GameManager::ComponentPriority::LOWER);
	std::cout << "done.\n";

	if ( mIsStandAlone ){
		SetStandAloneApp(gameManager);
	}
	else
		SetCamera(app);

	std::cout << "Opening server ...";
	bool bServer = mSimServerNetworkComp->SetupServer();
	if(!bServer) 
	{  
		throw dtUtil::Exception("\nError setting up server!!", __FILE__, __LINE__);
		app.Quit();
	}
	else 
	{
		std::cout << "\nServer running on port " <<  mPort << "\n";
	}

	std::cout << "................"<< std::endl; 
	std::cout << "3D SERVER READY"<< std::endl; /// sam //di pake launcher 2D untuk inisialisasi client socket connection
	std::cout << "................"<< std::endl;
}

void AppEntryPoint::SetAudio(dtGame::GameApplication& app)
{
	app.AddSender(&dtCore::System::GetInstance() );
	dtAudio::AudioManager::Instantiate();
	dtAudio::AudioManager::GetInstance().SetDistanceModel(AL_LINEAR_DISTANCE);

	mMic = dtAudio::AudioManager::GetListener();
	mMic->SetName("Server Audio Listener");
	mMic->SetGain(1.0f);
	assert( mMic );
	dtCore::Camera* cam = app.GetCamera();
	assert( cam );
	cam->AddChild( mMic );
	dtCore::Transform transform( 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f );
	mMic->SetTransform( transform, Transformable::REL_CS );
	std::cout << "Audio instantiated. \n";
}

void AppEntryPoint::SetCamera(dtGame::GameApplication& app)
{
	if ( mUsePlayer )
		mSimServerClientComponent->CreatePlayer(0, false);
	else
	{
		dtCore::Transform tx4(0.0f, 0.0f, 200.0f, 0, -89, 90);
		app.GetCamera()->SetTransform(tx4);
		fmm = new dtCore::FlyMotionModel( app.GetKeyboard(), app.GetMouse() );
		fmm->SetMaximumFlySpeed(200);
		fmm->SetTarget(app.GetCamera());
		fmm->SetEnabled(true);
	}
}

/*
digunakan hanya untuk demo version
*/
void AppEntryPoint::SetStandAloneApp(dtGame::GameManager &gameManager)
{	
	if ( mUsePlayer )
		mSimServerClientComponent->CreatePlayer(0, true);

	// added on 04052012 to check stand alone
	SimActorControl* simCtrl = static_cast<SimActorControl*> (gameManager.GetComponentByName(C_COMP_ACTOR_CONTROLLER));
	dtCore::RefPtr<dtDAL::ActorProxy> proxy = simCtrl->GetLauncherActors(C_WEAPON_TYPE_SPOUT,mVehicleID,mWeaponID,mLauncherID) ;

	dtCore::RefPtr<dtDAL::ActorProxy> ShipProxy = simCtrl->GetShipActorByID(mVehicleID);

	if (proxy == NULL)
	{
		proxy = simCtrl->CreateConstantDiponegoroCannon76(mVehicleID,mWeaponID,mLauncherID) ;
	}

	if (ShipProxy != NULL)
	{
		std::cout << "Ship Actor Find" << std::endl;
		if (proxy != NULL)
		{
			std::cout << "Launcher Actor Find" << std::endl;

			std::string mDOFName = GetCameraDOFName(mWeaponID,mLauncherID);
	
			if ( (mWeaponID == CT_CANNON_40) || 
				 (mWeaponID == CT_CANNON_57) ||
				 (mWeaponID == CT_CANNON_76) ||
				 (mWeaponID == CT_CANNON_120)
				)
			{
				dtCore::RefPtr<ShipModelActor> parent = static_cast<ShipModelActor*>(ShipProxy->GetActor());
				dtGame::GameActorProxy &pr = parent->GetGameActorProxy();
				osg::Node *model = pr.GetActor()->GetOSGNode();

				dtCore::RefPtr<dtUtil::NodeCollector> mtColector = new dtUtil::NodeCollector(model, dtUtil::NodeCollector::DOFTransformFlag);
				dtCore::RefPtr<osgSim::DOFTransform> mDOFTran = mtColector->GetDOFTransform(mDOFName);

				if (mDOFTran != NULL)
				{
					osg::Vec3 vPos = GetDOFPositionAbsolute(mDOFTran);
					dtCore::Transform CurrentPos ;
					CurrentPos.SetTranslation(vPos);

					/*dtCore::RefPtr<dtCore::Camera> mCam = gameManager.GetApplication().GetCamera();
					if ( mCam->GetParent() != NULL )
						mCam->GetParent()->RemoveChild(mCam);

					pr.GetActor()->AddChild(mCam);
					mCam->SetTransform(CurrentPos,dtCore::Transformable::ABS_CS);
					mCam->GetTransform(CurrentPos,dtCore::Transformable::REL_CS); 
					CurrentPos.SetRotation(180.0f,0.0f,0.0f);
					mCam->SetTransform(CurrentPos,dtCore::Transformable::REL_CS);*/
					std::cout <<"	:: TDS-"<<mLauncherID<<" handle "<<pr.GetActor()->GetName()<<std::endl;
				} 
				else
					std::cout <<"	:: TDS-"<<mVehicleID<<"-"<<mWeaponID<<"-"<<mLauncherID<<" handle "<<pr.GetActor()->GetName()<< ", but cannot find position init "<<mDOFName<<std::endl;
			}
			else
			{
				dtCore::RefPtr<LauncherSpoutActor> parent = static_cast<LauncherSpoutActor*>(proxy->GetActor());
				dtGame::GameActorProxy &pr = parent->GetGameActorProxy();
				osg::Node *model= pr.GetActor()->GetOSGNode();

				dtCore::RefPtr<dtUtil::NodeCollector> mtColector = new dtUtil::NodeCollector(model, dtUtil::NodeCollector::DOFTransformFlag);
				dtCore::RefPtr<osgSim::DOFTransform> mDOFTran = mtColector->GetDOFTransform(mDOFName);

				if (mDOFTran != NULL)
				{
					osg::Vec3 vPos = GetDOFPositionAbsolute(mDOFTran);
					dtCore::Transform CurrentPos ;
					CurrentPos.SetTranslation(vPos);

					/*dtCore::RefPtr<dtCore::Camera> mCam = gameManager.GetApplication().GetCamera();
					if ( mCam->GetParent() != NULL )
						mCam->GetParent()->RemoveChild(mCam);

					pr.GetActor()->AddChild(mCam);
					mCam->SetTransform(CurrentPos,dtCore::Transformable::ABS_CS);
					mCam->GetTransform(CurrentPos,dtCore::Transformable::REL_CS); 
					CurrentPos.SetRotation(0.0f,0.0f,0.0f);
					mCam->SetTransform(CurrentPos,dtCore::Transformable::REL_CS);*/
					std::cout <<"	:: TDS-"<<mLauncherID<<" handle "<<pr.GetActor()->GetName()<<std::endl;
				} 
				else
					std::cout <<"	:: TDS-"<<mVehicleID<<"-"<<mWeaponID<<"-"<<mLauncherID<<" handle "<<pr.GetActor()->GetName()<< ", but cannot find position init "<<mDOFName<<std::endl;
			}
		} 
		else 
		{
			std::cout <<"	:: Cannot find actor with vehicle id "<<mVehicleID<<" for observer init"<<std::endl;
		}
	}
	else
	{
		std::cout << "Cant't Find Vehicle" << std::endl; 
	}

	if (proxy != NULL)
		mSimServerClientComponent->SetPlayerAttachToLauncher(mVehicleID,mWeaponID,mLauncherID);
	 else 
		std::cout <<"	:: 3D Server Standalone, Cannot find launcher with launcher "<<mVehicleID<<"-"<<mWeaponID<<"-"<<mLauncherID<<std::endl;

	if ( mSC_Use )
	{
		std::cout << "Setting Port Control ... ";
		mSerialControl= new simSerialControl;
		gameManager.AddComponent(*mSerialControl, dtGame::GameManager::ComponentPriority::NORMAL);
		mSerialControl->Init(mVehicleID,mWeaponID,mLauncherID,mSC_Port,mSC_Boudrate,mSC_Data, mSC_InitFirstPitch, mSC_InitFirstHeading, mSC_Fire,mSC_Lock,true);
		//mSerialControl->Init(mVehicleID,mWeaponID,mLauncherID,mSC_Port,mSC_Boudrate,mSC_Data, mSC_InitFirstPitch ,true);
		mSerialControl->SetIsRunning(true);
		std::cout << "done.\n";

	} else
	{
		std::cout << "Creating JOYSTICK controler component for TDS...";
		didJoystickTDS *joytds = new didJoystickTDS("didJoystickTDS");
		gameManager.AddComponent(*joytds,dtGame::GameManager::ComponentPriority::NORMAL);
		joytds->Init(mVehicleID,mWeaponID,mLauncherID);
		joytds->SetIsRunning(true);
		std::cout << "done.\n";
	}
}

AppEntryPoint::AppEntryPoint()
{
   dtCore::System::GetInstance().SetFrameRate(60.0);
   dtCore::System::GetInstance().SetMaxTimeBetweenDraws(.1);
   dtCore::System::GetInstance().SetUseFixedTimeStep(true);
}

AppEntryPoint::~AppEntryPoint(void)
{
   dtAudio::AudioManager::Destroy();
}