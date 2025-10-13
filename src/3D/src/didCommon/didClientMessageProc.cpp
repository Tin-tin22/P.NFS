#include "../didCommon/didClientMessageProc.h"

didClientMessageProc::didClientMessageProc()
: dtGame::DefaultMessageProcessor("didClientMessageProcessor")
{
	mFirstInit = true;
	mIsAttachedToHandledObject = false;
	MyHandledObjectID = "";
	isHandledIDFound = false;
}

didClientMessageProc::~didClientMessageProc()
{
}

void didClientMessageProc::HandleNetworkMessage(const dtGame::Message& msg)
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
		DefaultMessageProcessor::ProcessCreateActor(eventMsg);
		//std::cout<<"Creating: "<<eventMsg.GetName()<<std::endl;
		
		dtCore::RefPtr<dtGame::GameActorProxy> proxy = GetGameManager()->FindGameActorById(msg.GetAboutActorId());
		if (proxy->GetName()== "OceanActor")//proxy->GetActorType().GetCategory()== "dtcore.Environment")
		{	
			//GetGameManager()->SetEnvironmentActor(static_cast<dtActors::BasicEnvironmentActorProxy*> (proxy)); 
			dtCore::RefPtr<dtGame::IEnvGameActor> actEnvironment= static_cast<dtGame::IEnvGameActor *>(proxy->GetActor());
			GetGameManager()->SetEnvironmentActor(static_cast<dtGame::IEnvGameActorProxy *>(proxy.get()));
			/*
			dtCore::RefPtr<SimEnvironmentControl> mRef = static_cast<SimEnvironmentControl *>(GetGameManager()->GetComponentByName("Environment Controller"));
			if (mRef.valid())
			{
				if (mRef->mTerrain!= NULL)
				{
				  actEnvironment->AddChild(mRef->mTerrain.get());
				}
				if (mRef->mInfiniteTerrain!= NULL)
				{
				  actEnvironment->AddChild(mRef->mInfiniteTerrain.get());
				}
			}
			*/
		}
		GetGameManager()->RegisterForMessages(SimMessageType::ORDER_EVENT, *proxy,dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
		GetGameManager()->RegisterForMessages(SimMessageType::UTILITY_AND_TOOLS, *proxy,dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
	}
	else if(msg.GetMessageType() == dtGame::MessageType::INFO_ACTOR_UPDATED) 
	{
		const dtGame::ActorUpdateMessage& eventMsg = 
				static_cast<const dtGame::ActorUpdateMessage&>(msg);
	  DefaultMessageProcessor::ProcessUpdateActor(eventMsg);
	}
	else if(msg.GetMessageType() == dtGame::MessageType::INFO_ACTOR_DELETED) 
	{
		const dtGame::ActorDeletedMessage& eventMsg = 
				static_cast<const dtGame::ActorDeletedMessage&>(msg);
	  DefaultMessageProcessor::ProcessDeleteActor(eventMsg);
	}
	else if (msg.GetMessageType() == SimMessageType::REJECT_LOGIN)
	{
		LOG_INFO("You've been kicked");
	}
	else if (msg.GetMessageType() == SimMessageType::APPLY_LOGIN)
		ProcessApplyLoginMessage(msg);
	else if (msg.GetMessageType() == SimMessageType::UPDATE_PARENT)
		ProcessUpdateParentMessage(msg);
}

void didClientMessageProc::HandleLocalMessage(const dtGame::Message& msg)
{

	if (msg.GetMessageType() == dtGame::MessageType::TICK_LOCAL)
	{
		CSocketClientGM* netGM = 
			static_cast<CSocketClientGM*>(GetGameManager()->GetComponentByName("ClientNetworkComponent"));	
	

		if (!netGM==NULL){
			if(netGM->IsConnectedClient()) //netGM is used for checking if client connected
				// awal login
				if (mFirstInit) 
				{
					mFirstInit = false;
					ProcessRequestLogin();
				}
		}

	} 
	else 
	if (msg.GetMessageType() == dtGame::MessageType::TICK_REMOTE)
	{
	}
	else
	if(msg.GetMessageType() == dtGame::MessageType::INFO_GAME_EVENT) 
	{				
		const dtGame::GameEventMessage &eventMsg = 
				static_cast<const dtGame::GameEventMessage&>(msg);

		if (eventMsg.GetGameEvent() != NULL)
		{
		}
	}
  else
	{
		DefaultMessageProcessor::ProcessMessage(msg);
	}
}

bool didClientMessageProc::IsInvalidMessage(const dtGame::Message& msg)
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

void didClientMessageProc::ProcessMessage(const dtGame::Message& msg)
{
	if (IsInvalidMessage(msg)) {return;}
    
	if(msg.GetSource() != GetGameManager()->GetMachineInfo()) {
		//LOG_INFO(msg.GetMessageType().GetName() + " message received from: " + msg.GetSource().GetName() + " [" + msg.GetSource().GetHostName() + "]");        
		//std::cout<<"Got network message!"<<std::endl;
		HandleNetworkMessage(msg);
	}else {
		HandleLocalMessage(msg);
	}
}

void didClientMessageProc::ProcessUpdateParentMessage(const dtGame::Message& msg)
{
  //Object2 harus udah di-create
  //mMutex.acquire();
  const MsgParentActor &eventMsg = static_cast<const MsgParentActor&>(msg);
  
  dtCore::RefPtr<dtGame::GameActorProxy> proxy = GetGameManager()->FindGameActorById(eventMsg.GetAboutActorId());
  if(proxy!= NULL)
  {
  	dtGame::GameActorProxy *parent = GetGameManager()->FindGameActorById(eventMsg.GetParentId());
    if (parent != NULL)
    {
		if ( proxy->GetGameActor().GetParent() != NULL )  
			 proxy->GetGameActor().GetParent()->RemoveChild(&(proxy->GetGameActor()));
		if (parent->GetActor()->AddChild(proxy->GetActor()))
		{
			std::cout<<proxy->GetName()<<" become a child of "<<parent->GetName()<<std::endl;
		}
		else
		{
  			std::cout<<proxy->GetName()<<" cannot become a child of "<<parent->GetName()<<std::endl;
		}
	}
    else
    {
		/*
		//Special case untuk ship
		if( proxy->GetActorType().GetName()== C_CN_SHIP )
		//if (((proxy)->GetActorType().GetName()== C_CN_SHIP ) || ((proxy)->GetActorType().GetName()== C_CN_SUBMARINE ) ||
		//	((proxy)->GetActorType().GetName()== "East Java" ) || ((proxy)->GetActorType().GetName()== "Armatim Port" )) 
		{
		std::vector<dtDAL::ActorProxy *> ap;
		GetGameManager()->FindActorsByName("Environment", ap);
		if (ap[0]!= NULL) //Environment hanya ada satu, belum support multiple environment
		{
		//static_cast<dtActors::BasicEnvironmentActor*>( ap[0]->GetActor() )->GetWeather().GetEnvironment()->AddChild(proxy);
		if ( proxy->GetGameActor().GetParent() != NULL ) 
		proxy->GetGameActor().GetParent()->RemoveChild(&(proxy->GetGameActor()));
		static_cast<dtActors::BasicEnvironmentActor*>( ap[0]->GetActor() )->AddActor( *(proxy->GetActor()) );
		}
		else
		std::cout<<"Environment actor is missing!"<<std::endl;
		}
		else
		std::cout<<"Parent for "<<proxy->GetName()<<" is not exist... strange..."<<std::endl;
		*/
    }
  }
  else
  {
    std::cout<<"Cannot found the object!... strange..."<<std::endl;
  }
  
  ///mMutex.release();
}

void didClientMessageProc::ProcessApplyLoginMessage(const dtGame::Message& msg)
{
	if ( LookCamera == C_LOGIN_OBS )
	{
		std::cout <<" USE " << LookCamera <<  std::endl;
		std::cout <<" 3D OBSERVER READY....."<<std::endl;
		//GetGameManager()->GetApplication().GetCamera()->SetTransform(tx,dtCore::Transformable::REL_CS);
	}
	else 
	{
		const MsgApplyLogin& eventMsg = static_cast<const MsgApplyLogin&>(msg);
		MyHandledObjectName = eventMsg.GetObjectNameToBeHandled();
		MyHandledObjectID   = eventMsg.GetObjectIDToBeHandled();
		dtGame::GameActorProxy* proxy = NULL;
		proxy = GetGameManager()->FindGameActorById(MyHandledObjectID);

		if (proxy!=NULL)
		{
			if ( LookCamera == C_LOGIN_ANJUNGAN )
			{
				std::cout <<MyHandledObjectName<<" :: "<<proxy->GetActor()->GetName()<< " USE " << LookCamera <<  std::endl;
				proxy->GetActor()->AddChild(GetGameManager()->GetApplication().GetCamera());
				tx.SetTranslation(eventMsg.GetTranslation());
				//GetGameManager()->GetApplication().GetWindow()->SetPosition(0,10, 2400, 600);
			}
			else
				std::cout<<"Mode ini tidak terdaftar!"<<std::endl;
			GetGameManager()->GetApplication().GetCamera()->SetTransform(tx,dtCore::Transformable::REL_CS);
		} 
		else 
		{
			std::cout<<"Object dos't exist !"<<std::endl;
		}
	}

}

void didClientMessageProc::ProcessRequestLogin()
{
	// setelah minta semua object, segera coba login ke server
	CSocketClientGM* netGM = 
		static_cast<CSocketClientGM*>(GetGameManager()->GetComponentByName("ClientNetworkComponent"));	
	
	dtCore::RefPtr<MsgApplyLogin> appMsg;

	GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::NOTIFY_LOGIN, appMsg);

	appMsg->SetLoginName(LoginName);
	appMsg->SetLookCamera(LookCamera);
	appMsg->SetDestination(netGM->GetServer()); //netGM is used for getting Server machineinfo

	//LOG_INFO("Notify Login");
	GetGameManager()->SendNetworkMessage(*appMsg);
}

void didClientMessageProc::ProcessCreateActor(const dtGame::ActorUpdateMessage &msg)
{
  dtGame::GameActorProxy *proxy = GetGameManager()->FindGameActorById(msg.GetAboutActorId());
  if (proxy == NULL)
  {
      //just to make sure the message is actually remote
      if (msg.GetSource() != GetGameManager()->GetMachineInfo())
      {
  
        try
        {
            dtCore::RefPtr<dtGame::GameActorProxy> gap = ProcessRemoteCreateActor(msg);
            if (gap.valid())
            {
              std::cout<<"    process remote create actor: "<<gap->GetName()<<std::endl;
              ProcessRemoteUpdateActor(msg, gap.get());
              GetGameManager()->AddActor(*gap, true, false);
            }
        }
        catch (const dtUtil::Exception& ex)
        {
            LOG_ERROR(ex.TypeEnum().GetName() 
              + " exception encountered trying to create a remote actor.  The actor will be ignored. Message: " + ex.What());
        }
      }
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

dtCore::RefPtr<dtGame::GameActorProxy> didClientMessageProc::ProcessRemoteCreateActor(const dtGame::ActorUpdateMessage& msg) 
{
  const std::string &typeName = msg.GetActorTypeName();
  const std::string &catName = msg.GetActorTypeCategory();

  dtCore::RefPtr<dtGame::GameActorProxy> gap;
  dtCore::RefPtr<const dtDAL::ActorType> type = GetGameManager()->FindActorType(catName, typeName);

  if (!type.valid())
  {
      //throw dtUtil::Exception(dtGame::ExceptionEnum::INVALID_PARAMETER, "The actor type parameters with value \"" 
      //  + catName + "." + typeName + "\" are invalid because no such actor type is registered.", __FILE__, __LINE__);
  }
        
  gap = GetGameManager()->CreateRemoteGameActor(*type);
  //Change the id to match the one this is ghosting.
  gap->SetId(msg.GetAboutActorId());         
  //std::cout<<"  Creating remote actor: "<<gap->GetName()<<std::endl;
  return gap;
}
