#include "SimClientMessageProc.h"

#include "../didNetwork/SimTCPDataTypes.h"
#include "../didUtils/utilityfunctions.h"
#include "../didUtils/SimServerClientComponent.h"
#include "../didCommon/simMessageType.h"
#include "../didCommon/simMessages.h"
#include "../didCommon/BaseConstant.h"
#include "../didActors/shipmodelactor.h"
#include "../didActors/oceanactor.h"

#define _WINSOCKAPI_
#ifndef WIN32_LEAN_AND_MEAN
#define WIN32_LEAN_AND_MEAN
#endif
#include <dtUtil/mswin.h>
#pragma comment(lib, "ws2_32.lib")

SimClientMessageProc::SimClientMessageProc() : dtGame::DefaultMessageProcessor("SimClientMessageProcessor")
{
	isTDSNotify = false ;
	mFirstInit = true;
}

SimClientMessageProc::~SimClientMessageProc()
{

}

void SimClientMessageProc::SetLoginClientData ( const int MCN, const std::string& LGD, const int VID, const int WID, const int LID ) 
{
	mMachineID      = MCN ;
	mLoginName		= LGD ;
	mVehicleID		= VID ;
	mWeaponID		= WID ;
	mLauncherID		= LID ;
}

//////////////////////////////////////////////////////////////////////////
void SimClientMessageProc::RegisterEventOnActors(dtGame::GameActorProxy& gap, const std::string& actTypeName ) 
{
	
	GetGameManager()->RegisterForMessages(dtGame::MessageType::TICK_LOCAL,gap,dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);

	if (( actTypeName == C_CN_ASROCK )||( actTypeName == C_CN_ASROCKB )||( actTypeName == C_CN_ASROCKS))		
		GetGameManager()->RegisterForMessages(SimMessageType::ASROCK_EVENT,gap,dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
	else if ( actTypeName == C_CN_C802 )			
		GetGameManager()->RegisterForMessages(SimMessageType::C802_EVENT,gap,dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
	else if (( actTypeName == C_CN_CANNONM )|| ( actTypeName == C_CN_CANNONB )||( actTypeName == C_CN_CANNONS ))	
		GetGameManager()->RegisterForMessages(SimMessageType::CANNON_EVENT,gap,dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
	else if (( actTypeName == C_CN_MISTRAL)	|| ( actTypeName == C_CN_MISTRALB) || ( actTypeName == C_CN_MISTRALS ) )	
		GetGameManager()->RegisterForMessages(SimMessageType::MISTRAL_EVENT,gap,dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
	else if (( actTypeName == C_CN_RBU ) || ( actTypeName == C_CN_RBUB ) || ( actTypeName == C_CN_RBUS ))		
		GetGameManager()->RegisterForMessages(SimMessageType::RBU_EVENT,gap,dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
	else if (( actTypeName == C_CN_STRELA) || ( actTypeName == C_CN_STRELAB) || ( actTypeName == C_CN_STRELAS) )			
		GetGameManager()->RegisterForMessages(SimMessageType::STRELA_EVENT,gap,dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
	else if (( actTypeName == C_CN_TETRAL) || ( actTypeName == C_CN_TETRALB) || ( actTypeName == C_CN_TETRALS) )			
		GetGameManager()->RegisterForMessages(SimMessageType::TETRAL_EVENT,gap,dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
	else if ( actTypeName == C_CN_TORPSUT )	
		GetGameManager()->RegisterForMessages(SimMessageType::TORPEDOSUT_EVENT,gap,dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
	else if ( actTypeName == C_CN_TORPEDO )		
		GetGameManager()->RegisterForMessages(SimMessageType::TORPEDO_EVENT,gap,dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
	else if ( actTypeName == C_CN_YAKHONT)		
		GetGameManager()->RegisterForMessages(SimMessageType::YAKHONT_EVENT,gap,dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
	else if ( actTypeName == C_CN_EXOCET_40)
		GetGameManager()->RegisterForMessages(SimMessageType::EXOCETMM_40_EVENT,gap,dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
	else
		std::cout<<" !!!! WARNING !!!! :: "<<GetName()<<" Unregistered event on  :: "<<actTypeName<<" see [RegisterEventOnActors] procedure.."<<std::endl;

}

void SimClientMessageProc::HandleNetworkMessage(const dtGame::Message& msg)
{
	if(msg.GetMessageType() == dtGame::MessageType::NETCLIENT_NOTIFY_DISCONNECT || 
		msg.GetMessageType() == dtGame::MessageType::NETCLIENT_REQUEST_CONNECTION ||  
		msg.GetMessageType() == dtGame::MessageType::NETSERVER_ACCEPT_CONNECTION ||  
		msg.GetMessageType() == dtGame::MessageType::INFO_CLIENT_CONNECTED ||  
		msg.GetMessageType() == dtGame::MessageType::NETSERVER_REJECT_CONNECTION)
	{
	}
 	else if(msg.GetMessageType() == dtGame::MessageType::INFO_ACTOR_CREATED) 
	{
		const dtGame::ActorUpdateMessage& eventMsg = static_cast<const dtGame::ActorUpdateMessage&>(msg);
		
		std::cout<<"Receive Message Creating : "<<eventMsg.GetName()<<"  "<<msg.GetAboutActorId()<<std::endl;

		DefaultMessageProcessor::ProcessCreateActor(eventMsg);

		dtCore::RefPtr<dtGame::GameActorProxy> proxy = GetGameManager()->FindGameActorById(msg.GetAboutActorId());
		if ( proxy->GetGameActor().GetParent() != NULL ) 
			std::cout<<"Receive Message Creating : "<<eventMsg.GetName()<<" parent is "<<proxy->GetGameActor().GetParent()->GetName()<<std::endl;
		else
			std::cout<<"Receive Message Creating : "<<eventMsg.GetName()<<std::endl;


		if (proxy->GetName()== C_CN_OCEAN )//proxy->GetActorType().GetCategory()== "dtcore.Environment")
		{	

			if ( proxy->GetActor()->GetParent() != NULL )
			{
				if ( proxy->GetActor()->GetParent()->GetName() != "OceanEnvironment" )
				{
					proxy->GetActor()->GetParent()->RemoveChild(proxy->GetActor());

					dtCore::RefPtr<dtGame::IEnvGameActorProxy> ocp = static_cast<dtGame::IEnvGameActorProxy *>(proxy.get());
					GetGameManager()->SetEnvironmentActor(ocp);

					std::cout<<"Change : "<<proxy->GetName()<<" and set as Environment Actor"<<std::endl;
				}
			}
			else
			{
				
				dtCore::RefPtr<dtGame::IEnvGameActorProxy> ocp = static_cast<dtGame::IEnvGameActorProxy *>(proxy.get());
    			GetGameManager()->SetEnvironmentActor(ocp);
				std::cout<<"Update : "<<proxy->GetName()<<" and set as Environment Actor"<<std::endl;
			}
		}
			
		std::string actTypeName = proxy->GetActorType().GetName();
		if (( actTypeName == C_CN_SHIP ) || ( actTypeName == C_CN_SUBMARINE )||( actTypeName == C_CN_HELICOPTER )||( actTypeName == C_CN_AIRCRAFT))
		{
			std::cout << "Register Ship Actor" << std::endl;
			GetGameManager()->RegisterForMessages(SimMessageType::ORDER_EVENT, *proxy,dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
		} else if ( actTypeName != C_CN_OCEAN )
		{
			std::cout << "Register Ocean Actor" << std::endl;
			RegisterEventOnActors(*proxy,actTypeName);
		}

	}
	else if(msg.GetMessageType() == dtGame::MessageType::INFO_ACTOR_UPDATED) 
	{
		const dtGame::ActorUpdateMessage& eventMsg = 
				static_cast<const dtGame::ActorUpdateMessage&>(msg);
		DefaultMessageProcessor::ProcessUpdateActor(eventMsg);
	}
	else if(msg.GetMessageType() == dtGame::MessageType::INFO_ACTOR_DELETED) 
	{
		std::cout<<GetName()<<" receive message delete"<<std::endl;
		const dtGame::ActorDeletedMessage& eventMsg = static_cast<const dtGame::ActorDeletedMessage&>(msg);
		dtCore::UniqueId mCurrentTargetId (eventMsg.GetAboutActorId() );
		SimServerClientComponent* simSC = static_cast<SimServerClientComponent*> (GetGameManager()->GetComponentByName(C_COMP_SERVER_CLIENT_CTRL));
		if ( simSC != NULL )
		{
			simSC->VerifyPlayerBeforeDeleteParent(mCurrentTargetId);
		}
		DefaultMessageProcessor::ProcessDeleteActor(eventMsg);
	}
	else if (msg.GetMessageType() == SimMessageType::REJECT_LOGIN)
	{
		LOG_INFO("You've been kicked");
	}
	else if (msg.GetMessageType() == SimMessageType::APPLY_TDS)
		isTDSNotify = true;
	else if (msg.GetMessageType() == SimMessageType::APPLY_LOGIN)
		ProcessApplyLoginMessage(msg);
	else if (msg.GetMessageType() == SimMessageType::UPDATE_PARENT)
		ProcessUpdateParentMessage(msg);
	else if (msg.GetMessageType() == SimMessageType::UTILITY_AND_TOOLS)
	    ProcessUtilityAndToolObserver(msg);
}

void SimClientMessageProc::HandleLocalMessage(const dtGame::Message& msg)
{

	if (msg.GetMessageType() == dtGame::MessageType::TICK_LOCAL)
	{
		CSocketClientGM* netGM =  static_cast<CSocketClientGM*>(GetGameManager()->GetComponentByName("ClientNetworkComponent"));	

		if (!netGM==NULL){
			if(netGM->IsConnectedClient()) //netGM is used for checking if client connected
				// awal login
				if ( mLoginName == C_LOGIN_TDS )
				{
					if (mFirstInit) 
					{
						mFirstInit = false;
						ProcessRequestTDS();				
					}
					if ( isTDSNotify ) 
					{
						isTDSNotify = false ;
						ProcessRequestLogin();
					}
				}
				else
				{
					if (mFirstInit) 
					{
						mFirstInit = false;
						ProcessRequestLogin();
					}
				}
		}

	} 
	else 
	if (msg.GetMessageType() == dtGame::MessageType::TICK_REMOTE)
	{
	}
	else
	{
		DefaultMessageProcessor::ProcessMessage(msg);
	}
}

bool SimClientMessageProc::IsInvalidMessage(const dtGame::Message& msg)
{
	if (GetGameManager() == NULL)
	{
		LOG_ERROR("This component is not assigned to a GameManager, but received a message.  It will be ignored.");         
		return true;
	}  

	if (msg.GetDestination() != NULL && GetGameManager()->GetMachineInfo().GetUniqueId()!= msg.GetDestination()->GetUniqueId())
	{
		LOG_DEBUG("Received message has a destination set to a different GameManager than this one. It will be ignored.");
		return true;
	}

	return false;
}

void SimClientMessageProc::ProcessMessage(const dtGame::Message& msg)
{
	if (IsInvalidMessage(msg)) {return;}
    
	if(msg.GetSource() != GetGameManager()->GetMachineInfo()) {
		HandleNetworkMessage(msg);
	}else {
		HandleLocalMessage(msg);
	}
}

 

 
void SimClientMessageProc::MissileExplode(int WeaponType, float PosX, float PosY, float PosZ, int Status)
{
	dtCore::RefPtr<dtCore::ParticleSystem> mExplosion= new dtCore::ParticleSystem();
	dtCore::RefPtr<dtAudio::Sound> missileSound =  dtAudio::AudioManager::GetInstance().NewSound();

	if ((WeaponType == CT_CANNON_40) || 
		(WeaponType == CT_CANNON_57) ||
		(WeaponType == CT_CANNON_76) ||
		(WeaponType == CT_CANNON_120))
	{
		mExplosion->LoadFile(C_PARTICLES_CANNON40_EXPLODE,true);
	}
	else if (WeaponType == CT_ASROC || WeaponType == CT_RBU_6000)
		mExplosion->LoadFile(C_PARTICLES_EXPLODE,true);
	else if (WeaponType == CT_STRELA || WeaponType == CT_TETRAL || WeaponType == CT_MISTRAL)
		mExplosion->LoadFile(C_PARTICLES_TORPEDO_EXPLODE,true);
	else
		mExplosion->LoadFile(C_PARTICLES_SHIP_ESMOKE, true);

	GetGameManager()->GetScene().AddDrawable(mExplosion.get());

	std::vector<dtDAL::ActorProxy *> ap;
	GetGameManager()->FindActorsByName(C_CN_OCEAN, ap);

	if (ap[0]!= NULL) 
	{
		static_cast<dtGame::IEnvGameActor*>( ap[0]->GetActor() )->AddChild(mExplosion.get());
	}
	else
		std::cout<<"Environment actor is missing!"<<std::endl;

	dtCore::Transform tmpTrans;
	tmpTrans.Set(PosX, PosY, PosZ,0,0,0);
	mExplosion->SetTransform(tmpTrans,dtCore::Transformable::ABS_CS);
	mExplosion->SetEnabled(true);

	missileSound->LoadFile("Sounds/ledakan.wav");
	assert(missileSound);
	missileSound->SetMaxDistance(1000.0f);
	missileSound->SetTransform(tmpTrans,dtCore::Transformable::ABS_CS);
	missileSound->SetLooping(false);

	if ( missileSound != NULL )
	{
		if ( !missileSound->IsPlaying() ) 
			missileSound->Play();
	}

	std::cout<<"--Server Explode Effect at x : "<<PosX<<" y : "<<PosY<<" z : "<< PosZ <<std::endl;

	dtCore::RefPtr<dtCore::Camera> mCam = GetGameManager()->GetApplication().GetCamera();

	if(Status == 2.0f){
		dtCore::Transform camPos;
		camPos.Set(PosX,PosY-25,PosZ,0,0,0);
		mCam->SetTransform(camPos,dtCore::Transformable::ABS_CS);
	}
}

void SimClientMessageProc::ProcessUtilityAndToolObserver(const dtGame::Message& msg)
{
	const MsgUtilityAndTools &Msg = static_cast<const MsgUtilityAndTools&>(msg);
	 
	//Hanya Untuk Test Event
	std::cout << "Masuk Event Camera Client Message Proc" << std::endl;

	if ( Msg.GetOrderID()== TIPE_UTIL_CAM_OBSERVER ) /// hanya untuk test
	{
		int observerID, vehicleID, weaponID , launcherID, missileID, missileNum, eventID;
		vehicleID		= Msg.GetUAT0(); 
		weaponID    	= Msg.GetUAT1();		/// objectTypeID ( ship, submarine, missile , misc )
		launcherID		= Msg.GetUAT2(); 
		missileID		= int(Msg.GetUAT3()); 
		missileNum		= int(Msg.GetUAT4()); 
		observerID		= int(Msg.GetUAT5());   /// observerID   ( observer-1, observer-2, observer-3 , observer-4 )
		eventID			= int(Msg.GetUAT6());

		//std::ostringstream obsID ;
		//obsID << observerID ;
		//std::string sname = "OBSERVER-"+obsID.str() ;
		//if ( GetGameManager()->GetMachineInfo().GetName() == sname )

		if ( mMachineID == observerID )
		{
			std::cout << "Get Message Observer. Config :: :: Vehicle = "<< vehicleID 
				<<" Weapon = "<< weaponID <<" launcherID = "<< launcherID 
				<<" missileID = "<< missileID << std::endl;
			
			SimServerClientComponent* simSC = static_cast<SimServerClientComponent*> (GetGameManager()->GetComponentByName(C_COMP_SERVER_CLIENT_CTRL));
			if ( simSC != NULL )
			{
				simSC->SetObserverFocus(vehicleID,weaponID,launcherID,missileID,missileNum,eventID);
			}
		}	
	}
	 
}

void SimClientMessageProc::ProcessUpdateParentMessage(const dtGame::Message& msg)
{
	//Object2 harus udah di-create
	//mMutex.acquire();
	const MsgParentActor &eventMsg = static_cast<const MsgParentActor&>(msg);

	dtCore::RefPtr<dtGame::GameActorProxy> proxy = GetGameManager()->FindGameActorById(eventMsg.GetAboutActorId());
	if(proxy!= NULL)
	{
		dtGame::GameActorProxy *parent = GetGameManager()->FindGameActorById(eventMsg.GetParentId());
		if ( parent != NULL)
		{
			if ( proxy->GetGameActor().GetParent() != NULL )  
				proxy->GetGameActor().GetParent()->RemoveChild(&(proxy->GetGameActor()));

			if (parent->GetActor()->AddChild(proxy->GetActor()))
				std::cout<<proxy->GetName()<<" \n"<< "	become a child of "<<parent->GetName()<<std::endl;
			else
				std::cout<<proxy->GetName()<<" cannot become a child of "<<parent->GetName()<<std::endl;

		}
		else if ( parent == NULL)
		{
			if ( proxy->GetGameActor().GetName()== C_CN_OCEAN ){

				dtCore::RefPtr<dtGame::IEnvGameActorProxy> gap= static_cast<dtGame::IEnvGameActorProxy *>(proxy.get());
				dtCore::RefPtr<dtGame::IEnvGameActor> ga= static_cast<dtGame::IEnvGameActor*>(gap->GetActor());
				GetGameManager()->SetEnvironmentActor(gap);
				std::cout<<" Recieve update parent for Ocean Environment, already set on create. try to re-setting as environment actor."<<std::endl;
			}
			else if ( proxy->GetGameActor().GetParent() == NULL )
			{
				if ( proxy->GetActorType().GetCategory() == C_ACTOR_CAT  )
				{
					std::vector<dtDAL::ActorProxy *> ap;
					GetGameManager()->FindActorsByName(C_CN_OCEAN, ap);
					if (ap[0]!= NULL) //Environment hanya ada satu, belum support multiple environment
					{
						if ( proxy->GetGameActor().GetParent() != NULL ) 
						proxy->GetGameActor().GetParent()->RemoveChild(&(proxy->GetGameActor()));
						static_cast<dtGame::IEnvGameActor*>( ap[0]->GetActor() )->AddActor( *(proxy->GetActor()) );
						std::cout<<"	** Update Parent for "<<proxy->GetName()<<" now is "<<proxy->GetGameActor().GetParent()->GetName()<<std::endl;

					} else
						std::cout<<"Environment actor is missing!"<<std::endl;
				} 
			}

		}
	}
	else // if(proxy!= NULL)
	{
		std::cout<<"Cannot found the object!... strange...update parents failed."<<std::endl;
	}

	///mMutex.release();
}

void SimClientMessageProc::ProcessApplyLoginMessage(const dtGame::Message& msg)
{
	const MsgApplyLogin& eventMsg = static_cast<const MsgApplyLogin&>(msg);
	
	dtCore::UniqueId MyHandledObjectID  = eventMsg.GetObjectIDToBeHandled();
	
	/// if needed
	mLoginName			= eventMsg.GetLoginName();
	mVehicleID			= eventMsg.GetParams1();
	mWeaponID			= eventMsg.GetParams2();
	mLauncherID			= eventMsg.GetParams3();
	
	SimServerClientComponent* simSC = static_cast<SimServerClientComponent*> (GetGameManager()->GetComponentByName(C_COMP_SERVER_CLIENT_CTRL));
	if ( simSC != NULL )
	{
		if ( mLoginName == C_LOGIN_OBSERVER )
		{
			simSC->SetObserverFocusByUID(MyHandledObjectID);
		}
		else if ( mLoginName == C_LOGIN_TDS )
		{
			simSC->SetPlayerAttachToLauncher(mVehicleID,mWeaponID,mLauncherID);
		}
	}

	std::cout<<"    process Apply Login :: LoginName :"<<eventMsg.GetLoginName()<<" success."<<std::endl;
	
	// sam. kok ini menggunakan INFO_MAP_LOADED, sebaiknya buat event baru...
	GetGameManager()->SendMessage(*(GetGameManager())->GetMessageFactory().CreateMessage(dtGame::MessageType::INFO_MAP_LOADED)); 


}

void SimClientMessageProc::ProcessRequestTDS()
{
	// setelah minta semua object, segera coba login ke server
	CSocketClientGM* netGM = static_cast<CSocketClientGM*>(GetGameManager()->GetComponentByName("ClientNetworkComponent"));	
	
	dtCore::RefPtr<MsgApplyLogin> appMsg;

	GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::NOTIFY_TDS, appMsg);

	appMsg->SetLoginName(mLoginName);
	appMsg->SetParams1(mVehicleID);
	appMsg->SetParams2(mWeaponID);
    appMsg->SetParams3(mLauncherID);
	appMsg->SetDestination(netGM->GetServer()); //netGM is used for getting Server machineinfo

	std::cout<<"    process Request TDS Login :: LoginName :"<<mLoginName<<" Vehicle : "<<mVehicleID<<
		" Weapon : "<<mWeaponID<<" Launcher : "<<mLauncherID<<std::endl;
	GetGameManager()->SendNetworkMessage(*appMsg);
}

void SimClientMessageProc::ProcessRequestLogin()
{
	// setelah minta semua object, segera coba login ke server
	CSocketClientGM* netGM = static_cast<CSocketClientGM*>(GetGameManager()->GetComponentByName("ClientNetworkComponent"));	
	
	dtCore::RefPtr<MsgApplyLogin> appMsg;

	GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::NOTIFY_LOGIN, appMsg);

	appMsg->SetLoginName(mLoginName);
	appMsg->SetParams1(mVehicleID);
	appMsg->SetParams2(mWeaponID);
    appMsg->SetParams3(mLauncherID);
	appMsg->SetDestination(netGM->GetServer()); //netGM is used for getting Server machineinfo

	std::cout<<"    process Request Login :: LoginName :"<<mLoginName<<" Vehicle : "<<mVehicleID<<
		" Weapon : "<<mWeaponID<<
		" Launcher : "<<mLauncherID<<std::endl;
	GetGameManager()->SendNetworkMessage(*appMsg);
}

void SimClientMessageProc::ProcessCreateActor(const dtGame::ActorUpdateMessage &msg)
{
  dtGame::GameActorProxy *proxy = GetGameManager()->FindGameActorById(msg.GetAboutActorId());
  if (proxy == NULL)
  {
      //just to make sure the message is actually remote
     /* if (msg.GetSource() != GetGameManager()->GetMachineInfo())
      {
  
        try
        {
            dtCore::RefPtr<dtGame::GameActorProxy> gap = ProcessRemoteCreateActor(msg);
            if (gap.valid())
            {
              std::cout<<"  by pass :  process remote create actor: "<<gap->GetName()<<std::endl;
              ProcessRemoteUpdateActor(msg, gap.get());
              GetGameManager()->AddActor(*gap, true, false);
            }
        }
        catch (const dtUtil::Exception& ex)
        {
            LOG_ERROR(ex.ToString() 
              + " exception encountered trying to create a remote actor.  The actor will be ignored. Message: " + ex.What());
        }
      }*/

  }
  else if (!proxy->IsRemote())
  {
      //std::cout<<"    process local create actor: "<<proxy->GetName()<<std::endl;
      ProcessLocalCreateActor(msg);
  }
  else 
  {
      //std::cout<<"    process remote update actor: "<<proxy->GetName()<<std::endl;
      ProcessRemoteUpdateActor(msg, proxy);
  }
}

dtCore::RefPtr<dtGame::GameActorProxy> SimClientMessageProc::ProcessRemoteCreateActor(const dtGame::ActorUpdateMessage& msg) 
{
  const std::string &typeName = msg.GetActorTypeName();
  const std::string &catName = msg.GetActorTypeCategory();

  dtCore::RefPtr<dtGame::GameActorProxy> gap;
  dtCore::RefPtr<const dtDAL::ActorType> type = GetGameManager()->FindActorType(catName, typeName);

  if (!type.valid())
  {
	  std::cout<<"    process remote update actor: "<<" INVALID_PARAMETER "<<std::endl;
  }
        
  gap = GetGameManager()->CreateRemoteGameActor(*type);
  //Change the id to match the one this is ghosting.
  gap->SetId(msg.GetAboutActorId());         

  if (typeName == "KRI")
  {
      /// set by property
	  dtCore::RefPtr<ShipModelActor> actor =  dynamic_cast<ShipModelActor*> ( gap->GetActor());

      std::string actorName = msg.GetName();
      if (mLoginName.compare(actorName) == 0)
                actor->SetCameraAttached(true);

  }

  return gap;


}
