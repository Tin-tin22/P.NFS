///////////////////////////////////////////////////////////////////////////////
#include "simservermessage.h"
#include "../didUtils/simActorControl.h"
#include "../didUtils/utilityfunctions.h"
#include "../didCommon/simmessagetype.h"
#include "../didCommon/BaseConstant.h"
#include "../didNetwork/SimTCPDataTypes.h"

#include <dtDAL/actortype.h>
#include <dtDAL/gameeventmanager.h>
#include <dtDAL/Actorproperty.h>
#include <dtDAL/LibraryManager.h>

#include <dtCore/particlesystem.h>
#include <dtCore/refptr.h>

#define _WINSOCKAPI_
#ifndef WIN32_LEAN_AND_MEAN
#define WIN32_LEAN_AND_MEAN
#endif
#include <dtUtil/mswin.h>
#pragma comment(lib, "ws2_32.lib")

////////////////////////////////////////////////////////////////////////////////////

SimServerMessage::SimServerMessage()
	: dtGame::DefaultMessageProcessor(C_COMP_SERVER_MESSAGE)
{
	mLogins.clear();
	mCycleUpdate	= 0.0f;
	lastObserverID	= 0;
	enableProcessMessage = true;
}

SimServerMessage::~SimServerMessage()
{
	mLogins.clear();
}

Login* SimServerMessage::AddLogin( std::string mLoginName, int mParams1, int mParams2, int mParams3,
				std::string mMachineName, std::string mIPAddress, const dtCore::UniqueId& mUniqueID ) 
{
	Login *mLogin = new Login(mLoginName,mParams1,mParams2,mParams3,mMachineName,mIPAddress);
	(*mLogin).mUniqueId = mUniqueID ;
	mLogins.push_back(*mLogin);

	return mLogin;
}

bool SimServerMessage::IsInvalidMessage(const dtGame::Message& msg)
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

void SimServerMessage::HandleNetworkMessage(const dtGame::Message& msg)
{
	// Network messages will be handled by NetworkComponent, so only forward other messages to DefauttMessageProcessor
	if(msg.GetMessageType() != dtGame::MessageType::NETCLIENT_REQUEST_CONNECTION ||
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

	// receive notify request TDS from client
	if (msg.GetMessageType() == SimMessageType::NOTIFY_TDS)
		ProcessClientRequestTDS(msg);

	// receive notify login from client
	if (msg.GetMessageType() == SimMessageType::NOTIFY_LOGIN)
		ProcessClientNotifyLogin(msg);

	// receive ORDER EVENT
	if (msg.GetMessageType() == SimMessageType::ORDER_EVENT)
	{
		const MsgOrder &orderMsg = static_cast<const MsgOrder&>(msg);

		dtCore::RefPtr<MsgOrder> toSend;
		GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::ORDER_EVENT, toSend);

		// set message property
		toSend->SetVehicleID(orderMsg.GetVehicleID());
		toSend->SetOrderID(orderMsg.GetOrderID());
		toSend->SetFloatValue(orderMsg.GetFloatValue());

		GetGameManager()->SendNetworkMessage(*toSend.get());
		GetGameManager()->SendMessage(*toSend.get());
	}
	/*else
	if (msg.GetMessageType() == SimMessageType::UTILITY_AND_TOOLS)
	{
		ProcessUtilityAndTools(msg);
	} */
}

void SimServerMessage::HandleLocalMessage(const dtGame::Message& msg)
{
	if (msg.GetMessageType() == dtGame::MessageType::TICK_LOCAL)
	{
        const dtGame::TickMessage& mess = static_cast<const dtGame::TickMessage&>(msg);

		mCycleUpdate+= mess.GetDeltaSimTime();
		if ( mCycleUpdate>= C_UPDATEALLOBJECT_CYCLE_TIME)
		{
			dtCore::RefPtr<CSocketServerGM> socketserver = static_cast<CSocketServerGM*>(GetGameManager()->GetComponentByName("ServerNetworkComponent"));	

			if (!socketserver == NULL) 
			{
				if (socketserver->GetClientsNumber() > 0) UpdateAllObjectToClients();
			}
			mCycleUpdate -= C_UPDATEALLOBJECT_CYCLE_TIME;
		}

	} 
	else 
	if (msg.GetMessageType() == dtGame::MessageType::TICK_REMOTE)
	{
		// Do something when we get remote tick
	} 
	/*else if (msg.GetMessageType() == SimMessageType::UTILITY_AND_TOOLS)
	{
		ProcessUtilityAndTools(msg);
	}*/
}

//void SimServerMessage::ProcessUtilityAndTools(const dtGame::Message& msg)
//{
//	const MsgUtilityAndTools &Msg = static_cast<const MsgUtilityAndTools&>(msg);
//	if ( Msg.GetOrderID()== TIPE_UTIL_CAM_REQUEST ) 
//	{
//		 
//		int shipID, weaponID , launcherID, missileID, OrderID;
//
//		shipID			= int(Msg.GetUAT0());
//		weaponID		= int(Msg.GetUAT1());
//		launcherID		= int(Msg.GetUAT2());
//		missileID		= int(Msg.GetUAT3());
//		OrderID  		= TIPE_UTIL_CAM_OBSERVER;
//
//		int mMaxUser=0;
//		for(std::vector<Login>::iterator iter = mLogins.begin(); iter != mLogins.end(); iter++)
//		{ 
//			if ( (*iter).mLoginName == C_LOGIN_OBSERVER ) mMaxUser = mMaxUser + 1; 
//		}
//
//		std::cout<<"Init Observer Event Max User :: "<< mMaxUser <<std::endl;
//
//		if ( mMaxUser > 0 ) 
//		{
//			lastObserverID = lastObserverID + 1 ;
//			if ( lastObserverID > mMaxUser ) lastObserverID = 1 ;
//
//			std::cout<<"Init Observer Event Observer ID :: "<< lastObserverID <<std::endl;
//
//			for(std::vector<Login>::iterator iter = mLogins.begin(); iter != mLogins.end(); iter++)
//			{ 
//				if ( (*iter).mLoginName == C_LOGIN_OBSERVER )
//				{
//					if ( (*iter).mParams2 == lastObserverID ) {
//						dtCore::RefPtr<MsgUtilityAndTools> MsgUtils;
//						GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::UTILITY_AND_TOOLS, MsgUtils);
//						
//						MsgUtils->SetOrderID(OrderID);
//						MsgUtils->SetUAT0(shipID);
//						MsgUtils->SetUAT1(weaponID);
//						MsgUtils->SetUAT2(launcherID);
//						MsgUtils->SetUAT3(missileID);
//						MsgUtils->SetUAT5(lastObserverID);
//						MsgUtils->SetUAT6(ORD_UTIL_CAMOBS_LF);
//
//						GetGameManager()->SendNetworkMessage(*MsgUtils.get());
//						GetGameManager()->SendMessage(*MsgUtils.get());
//						
//						std::cout<<"SEND OBSERVER EVENT TO :: LOGIN "<<(*iter).mLoginName<<"-"<< lastObserverID <<" MACHINE "<<(*iter).mMachineName<<" "<<(*iter).mIPAddress<<std::endl;
//						
//						break;
//					}
//				}	
//			}
//		}
//	}
//}

void SimServerMessage::ProcessMessage(const dtGame::Message& msg)
{
	if (enableProcessMessage)
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
}

void SimServerMessage::UpdateParentActor(const dtGame::Message& msg)
{
	std::vector<dtGame::GameActorProxy*> gaps;
	GetGameManager()->GetAllGameActors(gaps);

	int mSize = gaps.size();
	for (int i = 0; i < mSize; i++)
	{
		// update game actor only
		if ( ( gaps[i]->GetActorType().GetCategory() == C_ACTOR_CAT ) &&
			 ( gaps[i]->GetActorType().GetName() != C_CN_EFFECT  )&&
			 ( gaps[i]->GetActorType().GetName() != C_CN_PLAYER  ) &&
			 ( gaps[i]->GetActor()->GetParent() != NULL  ) ) 
		{
			dtCore::RefPtr<MsgParentActor> appMsg;
			GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::UPDATE_PARENT, appMsg);
			appMsg->SetAboutActorId(gaps[i]->GetActor()->GetUniqueId());
			dtCore::UniqueId pID = (gaps[i]->GetActor()->GetParent()->GetUniqueId());
			appMsg->SetParentId(pID);
			appMsg->SetDestination(&msg.GetSource());
			GetGameManager()->SendNetworkMessage(*appMsg);

			std::cout<<"   Send Message Actor Update Parents : "<<gaps[i]->GetActor()->GetName()<<" \n"<<
				"	and parent is "<<gaps[i]->GetActor()->GetParent()->GetName()<<std::endl;

			/*
			if (gaps[i]->GetActor()->GetParent() != NULL) 
			{
				dtCore::UniqueId pID = (gaps[i]->GetActor()->GetParent()->GetUniqueId());
				appMsg->SetParentId(pID);
				appMsg->SetDestination(&msg.GetSource());
				GetGameManager()->SendNetworkMessage(*appMsg);
			}
			*/
		}
	}   
}

 
void SimServerMessage::UpdateAllObjectToClients()
{
	std::vector<dtGame::GameActorProxy*> gaps;
	GetGameManager()->GetAllGameActors(gaps);
	int mSize = gaps.size();
	for (int i = 0; i < mSize; i++)
	{
		if  ( ( gaps[i]->GetActorType().GetName() != C_CN_EFFECT ) &&
			  ( gaps[i]->GetActorType().GetName() != C_CN_PLAYER )
		    ) 
		{
			dtCore::RefPtr<dtGame::ActorUpdateMessage> newGameActorMsg = 
			  static_cast<dtGame::ActorUpdateMessage*>(GetGameManager()->GetMessageFactory().
			  CreateMessage(dtGame::MessageType::INFO_ACTOR_UPDATED).get());
			gaps[i]->PopulateActorUpdate(*newGameActorMsg);
			GetGameManager()->SendNetworkMessage(*newGameActorMsg);
			//std::cout<<"   Send Message Actor Update : "<<gaps[i]->GetActor()->GetName()<<std::endl;
		}
	}
}

void SimServerMessage::CreateAllObjectToClients(const dtGame::Message& msg)
{
	std::vector<dtGame::GameActorProxy*> gaps;
	std::vector<dtGame::GameActorProxy*>::iterator igaps;
	GetGameManager()->GetAllGameActors(gaps);

	const MsgApplyLogin& apply = static_cast<const MsgApplyLogin&>(msg);
	
	//for (igaps = gaps.begin(); igaps != gaps.end(); igaps++)
	//{
	//	dtCore::RefPtr<dtGame::ActorUpdateMessage> newMsg= static_cast<dtGame::ActorUpdateMessage*>
	//		(GetGameManager()->GetMessageFactory().CreateMessage(dtGame::MessageType::INFO_ACTOR_CREATED).get());
	//	newMsg->SetDestination(&apply.GetSource());
	//	
	//	newMsg->SetAboutActorId((*igaps)->GetActor()->GetUniqueId());
	//	newMsg->SetActorTypeName((*igaps)->GetActorType().GetName());

	//	(*igaps)->PopulateActorUpdate(*newMsg);
	//	GetGameManager()->SendNetworkMessage(*newMsg);
	//	//}
	//}
	//

	/// ocean first
	for (igaps = gaps.begin(); igaps != gaps.end(); igaps++)
	{
		std::string actName = (*igaps)->GetActorType().GetName() ;

		if  ( actName == C_CN_OCEAN_CFG )
		{
			dtCore::RefPtr<dtGame::ActorUpdateMessage> newMsg= static_cast<dtGame::ActorUpdateMessage*>
				(GetGameManager()->GetMessageFactory().CreateMessage(dtGame::MessageType::INFO_ACTOR_CREATED).get());
			newMsg->SetDestination(&apply.GetSource());
			
			newMsg->SetAboutActorId((*igaps)->GetActor()->GetUniqueId());
			newMsg->SetActorTypeName((*igaps)->GetActorType().GetName());

			(*igaps)->PopulateActorUpdate(*newMsg);
			GetGameManager()->SendNetworkMessage(*newMsg);

			std::cout<<"1. Send Message Actor Create : "<<(*igaps)->GetActor()->GetName()<<std::endl;
		}
	}

	for (igaps = gaps.begin(); igaps != gaps.end(); igaps++)
	{
		std::string actName = (*igaps)->GetActorType().GetName() ;

		if  ( actName == C_CN_OCEAN )// || ( actName == C_CN_OCEAN_CFG ) ) 
		{
			dtCore::RefPtr<dtGame::ActorUpdateMessage> newMsg= static_cast<dtGame::ActorUpdateMessage*>
				(GetGameManager()->GetMessageFactory().CreateMessage(dtGame::MessageType::INFO_ACTOR_CREATED).get());
			newMsg->SetDestination(&apply.GetSource());
			
			newMsg->SetAboutActorId((*igaps)->GetActor()->GetUniqueId());
			newMsg->SetActorTypeName((*igaps)->GetActorType().GetName());

			(*igaps)->PopulateActorUpdate(*newMsg);
			GetGameManager()->SendNetworkMessage(*newMsg);

			std::cout<<"2. Send Message Actor Create : "<<(*igaps)->GetActor()->GetName()<<std::endl;
		}
	}

	/// second is ship
	for (igaps = gaps.begin(); igaps != gaps.end(); igaps++)
	{
		std::string actName = (*igaps)->GetActorType().GetName() ;

		if  ( (actName == C_CN_SHIP ) || (actName == C_CN_SUBMARINE ) || (actName == C_CN_HELICOPTER )|| (actName == C_CN_AIRCRAFT)) 
		{
			dtCore::RefPtr<dtGame::ActorUpdateMessage> newMsg= static_cast<dtGame::ActorUpdateMessage*>
				(GetGameManager()->GetMessageFactory().CreateMessage(dtGame::MessageType::INFO_ACTOR_CREATED).get());
			newMsg->SetDestination(&apply.GetSource());
			
			newMsg->SetAboutActorId((*igaps)->GetActor()->GetUniqueId());
			newMsg->SetActorTypeName((*igaps)->GetActorType().GetName());

			(*igaps)->PopulateActorUpdate(*newMsg);
			GetGameManager()->SendNetworkMessage(*newMsg);

			std::cout<<"3. Send Message Actor Create : "<<(*igaps)->GetActor()->GetName()<<std::endl;

		}

	}

	/// third is launcher
	for (igaps = gaps.begin(); igaps != gaps.end(); igaps++)
	{
		std::string actName = (*igaps)->GetActorType().GetName() ;

		if   (  (actName == C_CN_ASROCKB ) || (actName == C_CN_CANNONB ) || (actName == C_CN_RBUB ) ||
			    ( actName == C_CN_MISTRALB) || (actName == C_CN_STRELAB ) || (actName == C_CN_TETRALB )  )
		{
			dtCore::RefPtr<dtGame::ActorUpdateMessage> newMsg= static_cast<dtGame::ActorUpdateMessage*>
				(GetGameManager()->GetMessageFactory().CreateMessage(dtGame::MessageType::INFO_ACTOR_CREATED).get());
			newMsg->SetDestination(&apply.GetSource());

			newMsg->SetAboutActorId((*igaps)->GetActor()->GetUniqueId());
			newMsg->SetActorTypeName((*igaps)->GetActorType().GetName());

			(*igaps)->PopulateActorUpdate(*newMsg);
			GetGameManager()->SendNetworkMessage(*newMsg);

			std::cout<<"4. Send Message Actor Create : "<<(*igaps)->GetActor()->GetName()<<std::endl;
		}
	}

	/// then spout  
	for (igaps = gaps.begin(); igaps != gaps.end(); igaps++)
	{
		std::string actName = (*igaps)->GetActorType().GetName() ;

		if   (  (actName == C_CN_ASROCKS ) || (actName == C_CN_CANNONS ) || (actName == C_CN_RBUS ) ||
			    ( actName == C_CN_MISTRALS) || (actName == C_CN_STRELAS ) || (actName == C_CN_TETRALS ) ) 
		{

			dtCore::RefPtr<dtGame::ActorUpdateMessage> newMsg= static_cast<dtGame::ActorUpdateMessage*>
				(GetGameManager()->GetMessageFactory().CreateMessage(dtGame::MessageType::INFO_ACTOR_CREATED).get());
			newMsg->SetDestination(&apply.GetSource());
			
			newMsg->SetAboutActorId((*igaps)->GetActor()->GetUniqueId());
			newMsg->SetActorTypeName((*igaps)->GetActorType().GetName());

			(*igaps)->PopulateActorUpdate(*newMsg);
			GetGameManager()->SendNetworkMessage(*newMsg);

			std::cout<<"5. Send Message Actor Create : "<<(*igaps)->GetActor()->GetName()<<std::endl;

		}
	}

	/// then other  
	for (igaps = gaps.begin(); igaps != gaps.end(); igaps++)
	{
		std::string actName = (*igaps)->GetActorType().GetName() ;

		if		 (  (actName	== C_CN_OCEAN		) || (actName	== C_CN_OCEAN_CFG   )
				 || (actName	== C_CN_SHIP		) || (actName	== C_CN_SUBMARINE	) || (actName	== C_CN_HELICOPTER	) || (actName == C_CN_AIRCRAFT)
				 || (actName	== C_CN_ASROCKB		) || (actName	== C_CN_ASROCKS		)
				 || (actName	== C_CN_RBUB		) || (actName	== C_CN_RBUS		)
				 || (actName	== C_CN_MISTRALB	) || (actName	== C_CN_MISTRALS	)
				 || (actName	== C_CN_STRELAB 	) || (actName	== C_CN_STRELAS  	)
				 || (actName	== C_CN_TETRALB 	) || (actName	== C_CN_TETRALS  	)
				 || (actName	== C_CN_CANNONS		) || (actName	== C_CN_CANNONB		)
				 || (actName	== C_CN_EFFECT		) || (actName	== C_CN_PLAYER		)
				 ) 
		{
			continue ;
		} else
		{
			dtCore::RefPtr<dtGame::ActorUpdateMessage> newMsg= static_cast<dtGame::ActorUpdateMessage*>
				(GetGameManager()->GetMessageFactory().CreateMessage(dtGame::MessageType::INFO_ACTOR_CREATED).get());
			newMsg->SetDestination(&apply.GetSource());
			
			newMsg->SetAboutActorId((*igaps)->GetActor()->GetUniqueId());
			newMsg->SetActorTypeName((*igaps)->GetActorType().GetName());

			(*igaps)->PopulateActorUpdate(*newMsg);
			GetGameManager()->SendNetworkMessage(*newMsg);

			//std::cout<<"5. Send Message Actor Create : '"<<actName<<"' "<<(*igaps)->GetActor()->GetName()<<std::endl;
			std::cout<<"5. Send Message Actor Create : "<<(*igaps)->GetActor()->GetName()<<std::endl;
		}
	}
}

void SimServerMessage::ProcessClientNotifyDisconnect(const dtGame::Message& msg)
{
	LOG_INFO("Client Disconnect");
	CSocketServerGM* socketserver = static_cast<CSocketServerGM*>(GetGameManager()->GetComponentByName("ServerNetworkComponent"));

	socketserver->DisconnectMachine(&msg.GetSource());
	EjectLogin(msg.GetSource().GetIPAddress());
}

void SimServerMessage::EjectLogin(const std::string& mHost)
{
	for(std::vector<Login>::iterator iter = mLogins.begin(); iter != mLogins.end(); iter++)
	{
		if((*iter).mIPAddress == mHost)
		{
			(*iter).isApplied = false; 
			(*iter).mIPAddress = "";
			break;
		}
	}
}
 

bool SimServerMessage::ApplyLogin(std::string mLoginName, int mParams1, int mParams2, int mParams3,
								  std::string mMachineName, std::string mIPAddress)
{
	for(std::vector<Login>::iterator iter = mLogins.begin(); iter != mLogins.end(); iter++)
	{
		if (!(*iter).isApplied && (*iter).mLoginName == mLoginName && 
			 (*iter).mParams1 == mParams1 && (*iter).mParams2 == mParams2  && (*iter).mParams3 == mParams3 && 
			 (*iter).mMachineName == mMachineName && (*iter).mIPAddress == mIPAddress )
		{
			(*iter).isApplied = true;
			return true;
		} else {
			return false;
		}
	}
	return false;
}

bool SimServerMessage::ApplyOrAddLogin(const std::string mLoginName,
	const int mParams1, const int mParams2, const int mParams3, 
	const std::string mMachineName, const std::string& mIPAddress, const dtCore::UniqueId& mUniqueID )
{
	bool found = false;

	for(std::vector<Login>::iterator iter = mLogins.begin(); iter != mLogins.end(); iter++)
	{
		if ( (*iter).mLoginName == mLoginName && (*iter).mParams1 == mParams1 && (*iter).mParams2 == mParams2 && (*iter).mParams3 == mParams3 &&
			 (*iter).mMachineName == mMachineName && (*iter).mIPAddress == mIPAddress )
		{
			(*iter).isApplied		= true;
			(*iter).mUniqueId		= mUniqueID;

			if ( mLoginName == C_LOGIN_ANJUNGAN ){
				std::cout<<"APPLY LOGIN "<<(*iter).mLoginName<<
					" VEHICLE "<<(*iter).mParams1<< 
					" Machine "<<(*iter).mMachineName<<" IP "<<(*iter).mIPAddress<<std::endl;
			} else if ( mLoginName == C_LOGIN_OBSERVER ){
				std::cout<<"APPLY LOGIN "<<(*iter).mLoginName<<
					" VEHICLE "<<(*iter).mParams1<<" OBSERVER "<<(*iter).mParams2<< 
					" MACHINE "<<(*iter).mMachineName<<" IP "<<(*iter).mIPAddress<<std::endl;
			} else if ( mLoginName == C_LOGIN_TDS ){
				std::cout<<"APPLY LOGIN "<<(*iter).mLoginName<<
					" VEHICLE "<<(*iter).mParams1<<" WEAPON "<<(*iter).mParams2<<" LAUNCHER "<<(*iter).mParams3<<
					" MACHINE "<<(*iter).mMachineName<<" IP "<<(*iter).mIPAddress<<std::endl;
			}

			found = true;
			break;
		}
	}
	
	if (!found){
		AddLogin(mLoginName, mParams1, mParams2, mParams3, mMachineName, mIPAddress, mUniqueID );
	}
	return true;
}

////////////////////////////////////////////////////////////////////////////
void SimServerMessage::ProcessClientRequestTDS(const dtGame::Message& msg)
{
	const MsgApplyLogin& apply = static_cast<const MsgApplyLogin&>(msg);  

	std::string nLoginName, nHostName, nIPAddress ;
	int nParamID1 , nParamID2, nParamID3;

	nLoginName		= apply.GetLoginName();
	nParamID1		= (int)apply.GetParams1();
	nParamID2		= (int)apply.GetParams2();
	nParamID3		= (int)apply.GetParams3();
	nHostName		= apply.GetSource().GetHostName();
	nIPAddress		= apply.GetSource().GetIPAddress();
	dtCore::UniqueId nUniqueID( apply.GetSource().GetUniqueId() );
	std::cout << "TDS Client Request... "<< nLoginName <<"-"<<nParamID1<<"-"<<nParamID2<<"-"<< nParamID3 << std::endl;

	SimActorControl* simCtrl = static_cast<SimActorControl*> (GetGameManager()->GetComponentByName(C_COMP_ACTOR_CONTROLLER));
	dtCore::RefPtr<dtDAL::ActorProxy> tdsProxy = simCtrl->GetLauncherActors( C_WEAPON_TYPE_SPOUT, nParamID1, nParamID2, nParamID3);
	
	dtCore::UniqueId tdsHandleUniqueID ;
	if(!tdsProxy.valid())
	{
		simCtrl->CreateLaunchersActors(apply.GetParams1(),apply.GetParams2(), apply.GetParams3() );
	} 
	
	if(tdsProxy.valid())
	{
		tdsHandleUniqueID = tdsProxy->GetActor()->GetUniqueId();
		std::cout << "TDS Launcher... &&& ready" << std::endl;
	}

	dtCore::RefPtr<MsgApplyLogin> appMsg;
	GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::APPLY_TDS, appMsg);

	appMsg->SetLoginName(apply.GetLoginName());
	appMsg->SetDestination(&apply.GetSource());

	appMsg->SetObjectIDToBeHandled(tdsHandleUniqueID);			
	std::cout << "Sending network message type: SimMessageType::APPLY_TDS " << std::endl;
	GetGameManager()->SendNetworkMessage(*appMsg);		 
}

void SimServerMessage::ProcessClientNotifyLogin(const dtGame::Message& msg)
{
	const MsgApplyLogin& apply = static_cast<const MsgApplyLogin&>(msg);  

	std::string nLoginName, nHostName, nIPAddress ;
	int nParamID1 , nParamID2, nParamID3;

	nLoginName		= apply.GetLoginName();
	nParamID1		= apply.GetParams1();
	nParamID2		= apply.GetParams2();
	nParamID3		= apply.GetParams3();
	nHostName		= apply.GetSource().GetHostName();
    nIPAddress		= apply.GetSource().GetIPAddress();
	dtCore::UniqueId nUniqueID( apply.GetSource().GetUniqueId() );

	SimActorControl* simCtrl = dynamic_cast<SimActorControl*> (GetGameManager()->GetComponentByName(C_COMP_ACTOR_CONTROLLER));
	if ( simCtrl == NULL )
	{
		std::cout<<"	:: "<<GetName()<<" something wrong with actor control component, exit simulation."<<std::endl;
		return;
	}

	dtCore::RefPtr<dtDAL::ActorProxy> loginProxy = NULL ;
	if (( nLoginName == C_LOGIN_ANJUNGAN ) || ( nLoginName == C_LOGIN_OBSERVER ) || ( nLoginName == C_LOGIN_TDS ))  
	{
		if ( ApplyOrAddLogin( nLoginName, nParamID1 ,nParamID2, nParamID3 , nHostName , nIPAddress , nUniqueID ) )
		{
			if (( nLoginName == C_LOGIN_ANJUNGAN ) || ( nLoginName == C_LOGIN_OBSERVER ) )
			{
				loginProxy = simCtrl->GetShipActorByID(nParamID1);
				if( !loginProxy.valid() )
				{
					if ( nLoginName == C_LOGIN_ANJUNGAN ) 
					{
						dtCore::RefPtr<MsgApplyLogin> appMsg;
						GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::REJECT_LOGIN, appMsg);
						appMsg->SetLoginName(apply.GetLoginName());
						appMsg->SetDestination(&apply.GetSource());
						std::cout << "Sending network message type: SimMessageType::REJECT_LOGIN " << std::endl;
						GetGameManager()->SendNetworkMessage(*appMsg);
						std::cout<<"Client Connect with "<<nLoginName<<", about handle vehicle ID "<<nParamID1<<
							", but does not exist. return to exit "<<std::endl;
						return;
					} 
					else
					{  
						/// C_LOGIN_OBSERVER continue without handle actor...
						std::cout<<"Client Connect with "<<nLoginName<<", about handle vehicle ID "<<nParamID1<<
							", but does not exist. continue observer. "<<std::endl;

					}
				}  

			} else if ( nLoginName == C_LOGIN_TDS )
			{
				loginProxy = simCtrl->GetLauncherActors( C_WEAPON_TYPE_SPOUT, apply.GetParams1(), apply.GetParams2(), apply.GetParams3());

				if( !loginProxy.valid() )
				{ 
					dtCore::RefPtr<MsgApplyLogin> appMsg;
					GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::REJECT_LOGIN, appMsg);
					appMsg->SetLoginName(apply.GetLoginName());
					appMsg->SetDestination(&apply.GetSource());
					std::cout << "Sending network message type: SimMessageType::REJECT_LOGIN " << std::endl;
					GetGameManager()->SendNetworkMessage(*appMsg);
					std::cout<<"TDS Connect with , about handle :: vehicle ID  : "<<nParamID1<<
						", Weapon ID : "<<nParamID2<<" Launcher ID : "<<nParamID3<<
						", but does not exist. return to exit "<<std::endl;
					return;
				}
			}

			dtCore::RefPtr<MsgEnvironmentControl> EnvMsg;
			GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::ENVIRONMENT_CONTROL, EnvMsg);
			EnvMsg->SetDestination(&apply.GetSource());
			GetGameManager()->SendNetworkMessage(*EnvMsg);

			//create all actor to client
			CreateAllObjectToClients(msg);

			// segera login ke server
			dtCore::RefPtr<MsgApplyLogin> appMsg;
			GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::APPLY_LOGIN, appMsg);
			appMsg->SetLoginName(apply.GetLoginName());
			appMsg->SetDestination(&apply.GetSource());
			appMsg->SetParams1(apply.GetParams1());
			appMsg->SetParams2(apply.GetParams2());
			appMsg->SetParams3(apply.GetParams3());
			if ( loginProxy.valid ()) appMsg->SetObjectIDToBeHandled(loginProxy->GetActor()->GetUniqueId());			
			
			//send to network
			std::cout << "Sending network message type: SimMessageType::APPLY_LOGIN " << std::endl;
			GetGameManager()->SendNetworkMessage(*appMsg);

			//update parent actor remote client
			UpdateParentActor(msg);
			
			std::cout << "	:: Login "<< nLoginName << " success." << std::endl;
		}
	} else  // not in Role :: C_LOGIN_ANJUNGAN,C_LOGIN_OBSERVER,C_LOGIN_TDS 
	{
		// send failed login to client, segera login ke server
		dtCore::RefPtr<MsgApplyLogin> appMsg;
		GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::REJECT_LOGIN, appMsg);
		appMsg->SetLoginName(apply.GetLoginName());
		appMsg->SetDestination(&apply.GetSource());
		std::cout<<"Client "<<nLoginName<<" You are not qualified for the game...!"<<std::endl;
		GetGameManager()->SendNetworkMessage(*appMsg);
	}
}
 
