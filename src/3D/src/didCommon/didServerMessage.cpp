///////////////////////////////////////////////////////////////////////////////
#include "../didCommon/didServerMessage.h"
#include "../didUtils/simactordefxml.h"
#include "../didCommon/simmessagetype.h"

#include <dtDAL/gameevent.h>
#include <dtDAL/actortype.h>
#include <dtDAL/gameeventmanager.h>
#include <dtDAL/Actorproperty.h>

#include <dtCore/refptr.h>
#include <dtCore/keyboard.h>

////////////////////////////////////////////////////////////////////////////////////

didServerMessage::didServerMessage()
: dtGame::DefaultMessageProcessor("didServerMessage")
{
   mLogins.clear();
   mCount= 0;
}

didServerMessage::~didServerMessage()
{
	mLogins.clear();
}

Login* didServerMessage::AddLogin(std::string mName, std::string mPassword, 
											const Login::RoleType& mRole,std::string mObjName,
											std::string mObjType)
{
	Login *mLogin = new Login(mName,mPassword,mRole.GetName(),mObjName, mObjType);
	mLogins.push_back(*mLogin);
	return mLogin;
}

bool didServerMessage::IsInvalidMessage(const dtGame::Message& msg)
{
	if (GetGameManager() == NULL)
	{
		LOG_ERROR("This component is not assigned to a GameManager, but received a message.  It will be ignored.");         
		return true;
	}  

	if (msg.GetDestination() != NULL && GetGameManager()->GetMachineInfo() != *msg.GetDestination())
	{
		if (dtUtil::Log::GetInstance().IsLevelEnabled(dtUtil::Log::LOG_DEBUG))
		{
			LOG_DEBUG("Received message has a destination set to a different GameManager than this one. It will be ignored.");         
			return true;
		}
	}
	else
		return false;
  
  return false;
}

void didServerMessage::HandleNetworkMessage(const dtGame::Message& msg)
{
	// Network messages will be handled by NetworkComponent, so only forward other messages to DefauttMessageProcessor
	if( msg.GetMessageType() != dtGame::MessageType::NETCLIENT_REQUEST_CONNECTION ||
		msg.GetMessageType() != dtGame::MessageType::NETSERVER_ACCEPT_CONNECTION ||
		msg.GetMessageType() != dtGame::MessageType::NETSERVER_REJECT_CONNECTION ||
		msg.GetMessageType() != dtGame::MessageType::INFO_CLIENT_CONNECTED ||
		msg.GetMessageType() != dtGame::MessageType::NETCLIENT_NOTIFY_DISCONNECT ||
		msg.GetMessageType() != dtGame::MessageType::SERVER_REQUEST_REJECTED)
	{
		DefaultMessageProcessor::ProcessMessage(msg);
	}
	
	// receive notify disconnect from client
	if (msg.GetMessageType() == dtGame::MessageType::NETCLIENT_NOTIFY_DISCONNECT)
		ProcessClientNotifyDisconnect(msg);

	// receive notify login from client
	if (msg.GetMessageType() == SimMessageType::NOTIFY_LOGIN)
		ProcessClientNotifyLogin(msg);

	// receive info game event
	//if(msg.GetMessageType() == dtGame::MessageType::INFO_GAME_EVENT) 
	//	ProcessGameEvent(msg);

}

void didServerMessage::HandleLocalMessage(const dtGame::Message& msg)
{
	if (msg.GetMessageType() == dtGame::MessageType::TICK_LOCAL)
	{
		mCount++;
		if (mCount>= C_UPDATEALLOBJECT_CYCLE_TIME)
		{
			dtCore::RefPtr<CSocketServerGM> socketserver = static_cast<CSocketServerGM*>(GetGameManager()->GetComponentByName("ServerNetworkComponent"));	

			if (!socketserver == NULL) 
			{
				if (socketserver->GetClientsNumber() > 0) UpdateAllObjectToClients();
			}
			mCount= 0;
		}
	} 
	else 
	if (msg.GetMessageType() == dtGame::MessageType::TICK_REMOTE)
	{
		// Do something when we get remote tick
	}
}

void didServerMessage::ProcessMessage(const dtGame::Message& msg)
{
	if (IsInvalidMessage(msg)){	
		LOG_INFO("Invalid message");
		return;	
	}

	if(msg.GetSource() != GetGameManager()->GetMachineInfo()) {
		HandleNetworkMessage(msg);
	}else {
		HandleLocalMessage(msg);
	}
}

void didServerMessage::UpdateParentActor(const dtGame::Message& msg)
{
	std::vector<dtGame::GameActorProxy*> gaps;
	GetGameManager()->GetAllGameActors(gaps);

	int mSize = gaps.size();
	for (int i = 0; i < mSize; i++)
	{
		// update game actor only
		if (
		     gaps[i]->GetActorType().GetCategory() == C_ACTOR_CAT &&
		     gaps[i]->GetActor()->GetParent() != NULL
		   ) 
		{
			dtCore::RefPtr<MsgParentActor> appMsg;
			GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::UPDATE_PARENT, appMsg);
			appMsg->SetAboutActorId(gaps[i]->GetActor()->GetUniqueId());
			dtCore::UniqueId pID = (gaps[i]->GetActor()->GetParent()->GetUniqueId());
			appMsg->SetParentId(pID);
			appMsg->SetDestination(&msg.GetSource());
			GetGameManager()->SendNetworkMessage(*appMsg);
			
			/* if (gaps[i]->GetActor()->GetParent() != NULL) 
			{
				dtCore::UniqueId pID = (gaps[i]->GetActor()->GetParent()->GetUniqueId());
				appMsg->SetParentId(pID);
				appMsg->SetDestination(&msg.GetSource());
				GetGameManager()->SendNetworkMessage(*appMsg);
			} */
		}
	}
}

 
void didServerMessage::UpdateAllObjectToClients()
{
	std::vector<dtGame::GameActorProxy*> gaps;
	GetGameManager()->GetAllGameActors(gaps);
	//const std::vector<std::string> pn;
  
	int mSize = gaps.size();
	for (int i = 0; i < mSize; i++)
	{
		dtCore::RefPtr<dtGame::ActorUpdateMessage> newGameActor = 
		  static_cast<dtGame::ActorUpdateMessage*>(GetGameManager()->GetMessageFactory().
		  CreateMessage(dtGame::MessageType::INFO_ACTOR_UPDATED).get());
		gaps[i]->PopulateActorUpdate(*newGameActor);
		GetGameManager()->SendNetworkMessage(*newGameActor);
	}
}

void didServerMessage::CreateAllObjectToClients(const dtGame::Message& msg)
{
	std::vector<dtGame::GameActorProxy*> gaps;
	std::vector<dtGame::GameActorProxy*>::iterator igaps;
	GetGameManager()->GetAllGameActors(gaps);
  
    const MsgApplyLogin& apply = static_cast<const MsgApplyLogin&>(msg);
  
	for (igaps = gaps.begin(); igaps != gaps.end(); igaps++)
	{
		dtCore::RefPtr<dtGame::ActorUpdateMessage> newMsg= static_cast<dtGame::ActorUpdateMessage*>
			(GetGameManager()->GetMessageFactory().CreateMessage(dtGame::MessageType::INFO_ACTOR_CREATED).get());
			newMsg->SetDestination(&apply.GetSource());
		
			(*igaps)->PopulateActorUpdate(*newMsg);
			GetGameManager()->SendNetworkMessage(*newMsg);
	}
}

void didServerMessage::EjectLogin(const std::string& mHost)
{
		for(std::vector<Login>::iterator iter = mLogins.begin(); iter != mLogins.end(); iter++)
		{
			if((*iter).IPAddress == mHost)
			{
				(*iter).isApplied = false; 
				(*iter).IPAddress = "";
				break;
			}
		}
}

void didServerMessage::EjectLogin(const std::string& mName, const std::string& mPassword, const  std::string& mRole)
{
	for(std::vector<Login>::iterator iter = mLogins.begin(); iter != mLogins.end(); iter++)
  {
		if(((*iter).Name == mName) && ((*iter).Password == mPassword) && ((*iter).Role == mRole))
    {
			if ((*iter).isApplied) {
				(*iter).isApplied = false; 
				(*iter).IPAddress = "";
				return ;
			} else {
				return ;
			}
    }
	}
	LOG_ERROR("Login with name " + mName + " try to logout but not registered to server login. " +
		"It will be ignored!");
}

bool didServerMessage::ApplyLogin(const std::string mName, const std::string& mIPAddress)
{
	return true;
}

bool didServerMessage::ApplyLogin(const std::string mName, const std::string mPassword, 
																	const std::string& mRole, std::string& mObjName,
																	std::string& mObjType,
																	const std::string& mIPAddress)
{
	for(std::vector<Login>::iterator iter = mLogins.begin(); iter != mLogins.end(); iter++)
  {
		if (!(*iter).isApplied && (*iter).ObjectHandledName == mName ){
			(*iter).isApplied = true;
			(*iter).IPAddress = mIPAddress;
			mObjName = (*iter).ObjectHandledName;
			mObjType = (*iter).ObjectHandledType;
			return true;
		}else {
			return false;
		}

  }

	return false;
}

void didServerMessage::ProcessClientNotifyDisconnect(const dtGame::Message& msg)
{
	LOG_INFO("Client Disconnect");
	CSocketServerGM* socketserver = static_cast<CSocketServerGM*>(GetGameManager()->GetComponentByName("ServerNetworkComponent"));

	socketserver->DisconnectMachine(&msg.GetSource());
	EjectLogin(msg.GetSource().GetIPAddress());
}

void didServerMessage::ProcessClientNotifyLogin(const dtGame::Message& msg)
{
	const MsgApplyLogin& apply = static_cast<const MsgApplyLogin&>(msg);  

	LOG_INFO("Notify Login coming from client");

	// success login applying object to be handled to client
	std::string nName ;
	//std::string nType ;
	std::string nLookCamera;
	

	if (ApplyLogin(apply.GetLoginName(),msg.GetSource().GetIPAddress()))
	{
		
		dtCore::RefPtr<MsgApplyLogin> appMsg;
		dtCore::UniqueId id;
		std::vector<dtGame::GameActorProxy*> gaps;
		bool found = false;

		dtCore::Transform tx;

		// tambahan
		nName = apply.GetLoginName();
        nLookCamera = apply.GetLookCamera();

		if ( nLookCamera == C_LOGIN_OBS )
		{
			osg::Vec3 v3(0.0f, 0.0f, 0.0f);
			v3[2]+= 500;
			tx.SetTranslation(v3);
			osg::Vec3 rot(0.0f, -90.0f, 0.0f);
			tx.SetRotation(rot);
			std::cout << "Use " << nLookCamera <<" Camera : "<< v3[0]<< ";" << v3[1]<< ";" << v3[2]<< "; Rotation " << v3[1]<< "\n";
		}
		else if ( nLookCamera == C_LOGIN_ANJUNGAN )
		{
			
			//find actor by name
			GetGameManager()->GetAllGameActors(gaps);

			int mSize = gaps.size();
			// cari nama obyek yang dihandle di list game actor gamemanager
			for (int i = 0; i < mSize; i++){
				if (gaps[i]->GetActor()->GetName() == nName) {
					id = gaps[i]->GetActor()->GetUniqueId();
					found = true;
					break;
				}
			}

			if (!found){
				LOG_INFO("Object with name " + nName + " not found!");
				LOG_INFO("Logon canceled..");
				
				//jika object tak ada, reject login
				GetGameManager()->GetMessageFactory().
					CreateMessage(SimMessageType::REJECT_LOGIN, appMsg);

				appMsg->SetLoginName(apply.GetLoginName());
				appMsg->SetDestination(&apply.GetSource());
				appMsg->SetReasonIfReject("Try to handle " + nName + ", but doesn't exist!");

				GetGameManager()->SendNetworkMessage(*appMsg);
				
				std::cout<<"Client Connect with "<<nName<<", but doesn't exist!"<<std::endl;

				return;
			}
		}
		//Send relative long, lat

		dtCore::RefPtr<MsgEnvironmentControl> EnvMsg;
		GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::ENVIRONMENT_CONTROL, EnvMsg);
		EnvMsg->SetLatitude(C_RELATIVE_Y);
		EnvMsg->SetLongitude(C_RELATIVE_X);
  	    EnvMsg->SetDestination(&apply.GetSource());
		GetGameManager()->SendNetworkMessage(*EnvMsg);
    
		//create all actor to client
		CreateAllObjectToClients(msg);

		// segera login ke server
		GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::APPLY_LOGIN, appMsg);

		appMsg->SetLoginName(apply.GetLoginName());
		appMsg->SetDestination(&apply.GetSource());

		//set the UID object to be handled below
		appMsg->SetObjectNameToBeHandled(nName);
		appMsg->SetObjectIDToBeHandled(id);			
		
		
		// find type on scenario XML document
		//SimScenarioXML *scenXML = static_cast<SimScenarioXML*>(GetGameManager()->GetComponentByName("ScenarioXMLComponent"));
		//nType = scenXML->GetModelTypeFromName(nName);
		// find component on XML document
		SimActorDefXML *actXML = static_cast<SimActorDefXML*>(GetGameManager()->GetComponentByName("ActorDefXMLComponent"));
		SimActorCompDef *actComp = actXML->FindActorCompDefByName(nName);

		if (actComp != NULL){
			LOG_INFO("Component Found");

			SimActorCamera* actCam = actComp->GetCameraFromName(nLookCamera);

			if (!actCam) 
			{
			  LOG_INFO("Camera with name " + nName + " not found!");
			  LOG_INFO("Logon canceled..");
			  //jika object tak ada, reject login
			  GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::REJECT_LOGIN, appMsg);
			  // added by sam for login with ID
			  appMsg->SetLoginName(apply.GetLoginName());
			  appMsg->SetDestination(&apply.GetSource());
			  appMsg->SetReasonIfReject("Try to handle " + nName + ", but doesn't exist!");
			  GetGameManager()->SendNetworkMessage(*appMsg);
			  return;
			}
			tx.SetTranslation(actCam->camtranslation.x(),actCam->camtranslation.y(),actCam->camtranslation.z());
			std::cout << "Use " << nLookCamera << " camera : " << actCam->camtranslation.x() << ";" << actCam->camtranslation.y() << ";" << actCam->camtranslation.z() << "\n";
			appMsg->SetCameraPosition(tx);
		}
		
		LOG_INFO(nName + " is to sent..");
		LOG_INFO(id.ToString() + " is to sent..");
		//update parent actor remote client
		UpdateParentActor(msg);
		//send to network
		GetGameManager()->SendNetworkMessage(*appMsg);
	}
	// failed login reject client to play game
	else
	{
		// send failed login to client, segera login ke server
		dtCore::RefPtr<MsgApplyLogin> appMsg;
		GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::REJECT_LOGIN, appMsg);
		appMsg->SetLoginName(apply.GetLoginName());
		appMsg->SetDestination(&apply.GetSource());
		appMsg->SetReasonIfReject("You are not qualified for the game...!");
		std::cout<<"Client "<<nName<<"You are not qualified for the game...!"<<std::endl;
		GetGameManager()->SendNetworkMessage(*appMsg);
	}
}
