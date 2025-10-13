#include "SimClientMessageProc.h"

#include "../didNetwork/SimTCPDataTypes.h"
#include "../didUtils/utilityfunctions.h"

#include "../didUtils/SimEnvironmentXML.h"
#include "../didCommon/simMessageType.h"
#include "../didCommon/simMessages.h"
#include "../didCommon/BaseConstant.h"
#include "../didActors/shipmodelactor.h"
#include "../didActors/cannonspoutactor.h"

#include <dtUtil/mswin.h>

SimClientMessageProc::SimClientMessageProc() : dtGame::DefaultMessageProcessor("SimClientMessageProcessor")
{
	isTDSNotify = false ;
	mFirstInit = true;
}

SimClientMessageProc::~SimClientMessageProc()
{

}

void SimClientMessageProc::SetLoginClientData ( const std::string& LGD, const int VID, const int WID, const int LID ) 
{
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
		
		DefaultMessageProcessor::ProcessCreateActor(eventMsg);

		dtCore::RefPtr<dtGame::GameActorProxy> proxy = GetGameManager()->FindGameActorById(msg.GetAboutActorId());
		if ( proxy->GetGameActor().GetParent() != NULL ) 
			std::cout<<"Receive Message Creating : "<<eventMsg.GetName()<<" parent is "<<proxy->GetGameActor().GetParent()->GetName()<<std::endl;
		else
			std::cout<<"Receive Message Creating : "<<eventMsg.GetName()<<std::endl;


		if (proxy->GetName()== C_CN_OCEAN)//proxy->GetActorType().GetCategory()== "dtcore.Environment")
		{	
			//dtCore::RefPtr<dtGame::IEnvGameActor> actEnvironment= static_cast<dtGame::IEnvGameActor *>(proxy->GetActor());
			if ( proxy->GetActor()->GetParent() != NULL )
				proxy->GetActor()->GetParent()->RemoveChild(proxy->GetActor());
			GetGameManager()->SetEnvironmentActor(static_cast<dtGame::IEnvGameActorProxy *>(proxy.get()));

			std::cout<<"Update : "<<proxy->GetName()<<" and set as Environment Actor"<<std::endl;
		}
			
		std::string actTypeName = proxy->GetActorType().GetName();
		if (( actTypeName == C_CN_SHIP ) || ( actTypeName == C_CN_SUBMARINE )||( actTypeName == C_CN_HELICOPTER ))
		{
			GetGameManager()->RegisterForMessages(SimMessageType::ORDER_EVENT, *proxy,dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
		} else if ( actTypeName != C_CN_OCEAN )
			RegisterEventOnActors(*proxy,actTypeName);
		 
		/*GetGameManager()->RegisterForMessages(SimMessageType::ASROCK_EVENT, *proxy,dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
		GetGameManager()->RegisterForMessages(SimMessageType::RBU_EVENT, *proxy,dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
		GetGameManager()->RegisterForMessages(SimMessageType::EXOCET_EVENT, *proxy,dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
		GetGameManager()->RegisterForMessages(SimMessageType::TORPEDOSUT_EVENT, *proxy,dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
		GetGameManager()->RegisterForMessages(SimMessageType::TORPEDO_EVENT, *proxy,dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
		GetGameManager()->RegisterForMessages(SimMessageType::CANNON_EVENT, *proxy,dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
		GetGameManager()->RegisterForMessages(SimMessageType::EXOCET_40_EVENT, *proxy,dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
		GetGameManager()->RegisterForMessages(SimMessageType::TETRAL_EVENT, *proxy,dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
		GetGameManager()->RegisterForMessages(SimMessageType::STRELA_EVENT, *proxy,dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
		GetGameManager()->RegisterForMessages(SimMessageType::MISTRAL_EVENT, *proxy,dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
		GetGameManager()->RegisterForMessages(SimMessageType::C802_EVENT, *proxy,dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
		GetGameManager()->RegisterForMessages(SimMessageType::YAKHONT_EVENT, *proxy,dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);*/

	}
	else if(msg.GetMessageType() == dtGame::MessageType::INFO_ACTOR_UPDATED) 
	{
		const dtGame::ActorUpdateMessage& eventMsg = 
				static_cast<const dtGame::ActorUpdateMessage&>(msg);
		DefaultMessageProcessor::ProcessUpdateActor(eventMsg);
	}
	else if(msg.GetMessageType() == dtGame::MessageType::INFO_ACTOR_DELETED) 
	{
		const dtGame::ActorDeletedMessage& eventMsg = static_cast<const dtGame::ActorDeletedMessage&>(msg);
		DefaultMessageProcessor::ProcessDeleteActor(eventMsg);
		if ( GetGameManager()->GetApplication().GetCamera()->GetParent() != NULL )
		{
			if ( GetGameManager()->GetApplication().GetCamera()->GetParent()->GetUniqueId() == eventMsg.GetAboutActorId() )
			{
				GetGameManager()->GetApplication().GetCamera()->GetParent()->RemoveChild(GetGameManager()->GetApplication().GetCamera());
			}
		}
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
	if(msg.GetMessageType() == dtGame::MessageType::INFO_GAME_EVENT) 
	{				
		const dtGame::GameEventMessage &eventMsg =  static_cast<const dtGame::GameEventMessage&>(msg);

		if (eventMsg.GetGameEvent() != NULL)
		{

		}

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

dtCore::RefPtr<dtDAL::ActorProxy> SimClientMessageProc::GetLauncherActors( const int actTypeID , const int mVehicleID, const int mWeaponID, const int mLauncherID )
{
	dtCore::RefPtr<dtDAL::ActorProxy> proxy ;

	std::vector<dtGame::GameActorProxy *> fill;
	std::vector<dtGame::GameActorProxy *>::iterator iter;
	GetGameManager()->GetAllGameActors(fill);

	const std::string& actTypeName = GetActorWeaponTypeName(mWeaponID, actTypeID );

	for (iter = fill.begin(); iter < fill.end(); iter++)
	{

		if (((*iter)->GetActorType().GetName()== actTypeName )) 
		{
			dtCore::RefPtr<dtDAL::ActorProperty> PVehID( (*iter)->GetProperty(C_SET_VID) );
			dtCore::RefPtr<dtDAL::IntActorProperty> ValID( static_cast<dtDAL::IntActorProperty*>( PVehID.get() ) );
			int tgt( ValID->GetValue() );

			if ( tgt == mVehicleID )
			{

				dtCore::RefPtr<dtDAL::ActorProperty> PWeaponID( (*iter)->GetProperty(C_SET_WID) );
				dtCore::RefPtr<dtDAL::IntActorProperty> ValWeaponID( static_cast<dtDAL::IntActorProperty*>( PWeaponID.get() ) );
				int wpn( ValWeaponID->GetValue() );

				if ( wpn == mWeaponID )
				{
					dtCore::RefPtr<dtDAL::ActorProperty> PLauncherID( (*iter)->GetProperty(C_SET_LID) );
					dtCore::RefPtr<dtDAL::IntActorProperty> ValLauncherID( static_cast<dtDAL::IntActorProperty*>( PLauncherID.get() ) );
					int lcr( ValLauncherID->GetValue() );
					if ( lcr == mLauncherID )
					{
						proxy = (*iter);
						break;
					}
				}
			}
		}
	}
	if(!proxy.valid())
	{
		return NULL;
	}
	return proxy;
}

dtCore::RefPtr<dtDAL::ActorProxy> SimClientMessageProc::GetShipActorByID(int mVehicleID )
{
	dtCore::RefPtr<dtDAL::ActorProxy> proxy ;

	std::vector<dtGame::GameActorProxy *> fill;
	std::vector<dtGame::GameActorProxy *>::iterator iter;
	GetGameManager()->GetAllGameActors(fill);

	for (iter = fill.begin(); iter < fill.end(); iter++)
	{
		if (((*iter)->GetActorType().GetName()== C_CN_SHIP ) || ((*iter)->GetActorType().GetName()== C_CN_SUBMARINE )
			|| ((*iter)->GetActorType().GetName()== C_CN_HELICOPTER )) 
		{
			dtCore::RefPtr<dtDAL::ActorProperty> PVehID( (*iter)->GetProperty(C_SET_VID) );
			dtCore::RefPtr<dtDAL::IntActorProperty> ValID( static_cast<dtDAL::IntActorProperty*>( PVehID.get() ) );
			int tgt( ValID->GetValue() );
			if ( tgt == mVehicleID )
			{
				proxy = (*iter);
				break;
			}
		}
	}
	if(!proxy.valid())
	{
		return NULL;
	}
	return proxy;
}

dtCore::RefPtr<dtDAL::ActorProxy> SimClientMessageProc::GetMissileActor( 
	const int mVehicleID, const int mWeaponID, const int mLauncherID, const int mMissileID, const int mMissileNum )
{
	dtCore::RefPtr<dtDAL::ActorProxy> proxy ;

	std::vector<dtGame::GameActorProxy *> fill;
	std::vector<dtGame::GameActorProxy *>::iterator iter;
	GetGameManager()->GetAllGameActors(fill);

	const std::string& actTypeName = GetActorWeaponTypeName(mWeaponID,C_WEAPON_TYPE_MISSILE);

	for (iter = fill.begin(); iter < fill.end(); iter++)
	{
		if (((*iter)->GetActorType().GetName()== actTypeName )) 
		{
			dtCore::RefPtr<dtDAL::ActorProperty> pVehicleID( (*iter)->GetProperty(C_SET_VID) );
			dtCore::RefPtr<dtDAL::IntActorProperty> ValVehicleID( static_cast<dtDAL::IntActorProperty*>( pVehicleID.get() ) );
			int shipID( ValVehicleID->GetValue() );
			if ( shipID == mVehicleID )
			{
				dtCore::RefPtr<dtDAL::ActorProperty> pWeaponID( (*iter)->GetProperty(C_SET_WID) );
				dtCore::RefPtr<dtDAL::IntActorProperty> ValWeaponID( static_cast<dtDAL::IntActorProperty*>( pWeaponID.get() ) );
				int wpnid( ValWeaponID->GetValue() );
				if ( wpnid == mWeaponID )
				{
					dtCore::RefPtr<dtDAL::ActorProperty> pLauncherID( (*iter)->GetProperty(C_SET_LID) );
					dtCore::RefPtr<dtDAL::IntActorProperty> ValLauncherID( static_cast<dtDAL::IntActorProperty*>( pLauncherID.get() ) );
					int lcid( ValLauncherID->GetValue() );
					if ( lcid == mLauncherID )
					{
						dtCore::RefPtr<dtDAL::ActorProperty> pMissileID( (*iter)->GetProperty(C_SET_MID) );
						dtCore::RefPtr<dtDAL::IntActorProperty> ValID( static_cast<dtDAL::IntActorProperty*>( pMissileID.get() ) );
						int tgt( ValID->GetValue() );
						if ( tgt == mMissileID )
						{
							dtCore::RefPtr<dtDAL::ActorProperty> pMissileNum( (*iter)->GetProperty(C_SET_MNUM) );
							dtCore::RefPtr<dtDAL::IntActorProperty> numID( static_cast<dtDAL::IntActorProperty*>( pMissileNum.get() ) );
							int num( numID->GetValue() );
							if ( num == mMissileNum )
							{
								proxy = (*iter);
								break;
							}
						}
					}
				}
			}
		}
	}
	if(!proxy.valid())
	{
		return NULL;
	}
	return proxy;
}

void SimClientMessageProc::SetCameraObserver( const int vehicleID, const int weaponID, const int launcherID, const int missileID, const int missileNum, const int orderID)
{
        
	const std::string& actTypeName = GetActorWeaponTypeName( weaponID ,C_WEAPON_TYPE_MISSILE);

	dtCore::RefPtr<dtDAL::ActorProxy> proxy ;
    
    bool actorFound = false;
    //Search the actor proxy
    if ( ( vehicleID > 0 ) && ( weaponID > 0 ) && ( launcherID > 0 ) && ( missileID > 0 ) && ( missileNum > 0 )) //Search missiles
    {
		proxy = GetMissileActor( vehicleID, weaponID ,launcherID, missileID, missileNum);
		
		if(proxy.valid())
		{  
			actorFound = true;
		}
            
    }
    else //Search ship / sub / heli
    {               
		std::vector<dtGame::GameActorProxy *> fill;
		std::vector<dtGame::GameActorProxy *>::iterator iter;
		GetGameManager()->GetAllGameActors(fill);

        for (iter = fill.begin(); iter < fill.end(); iter++)
        {
			std::string actName = (*iter)->GetActorType().GetName() ;
        
            if (( actName == C_CN_SHIP ) || (actName == C_CN_SUBMARINE ) || (actName== C_CN_HELICOPTER )) 
            {
                dtCore::RefPtr<dtDAL::ActorProperty> VehicleID( (*iter)->GetProperty(C_SET_VID) );
                dtCore::RefPtr<dtDAL::IntActorProperty> ValID( static_cast<dtDAL::IntActorProperty*>( VehicleID.get() ) );
                int tgt( ValID->GetValue() );
                if ( tgt == vehicleID )
                {
                    proxy = *iter;
                    actorFound = true;
                    break;
                }
            }
        }

    }
    
    if (!actorFound)
    {
		std::cout << "Set Camera Observer. Cannot find Actor :: :: vehicleID = "<< vehicleID 
				<<" params-1 = "<< weaponID <<" params-2 = "<< launcherID 
				<<" params-3 = "<< missileID << std::endl;
    }
	else
	{
		bool bRemoveChild = true ;
		float x, y, z, h, p, r;
		dtCore::Transform tmpTrans;
		dtCore::UniqueId mCurrentTargetId (proxy->GetActor()->GetUniqueId());
		dtCore::RefPtr<dtCore::Camera> mCam = GetGameManager()->GetApplication().GetCamera();

    	if (  orderID == ORD_UTIL_CAMOBS_UP || orderID == ORD_UTIL_CAMOBS_FR ||
			  orderID == ORD_UTIL_CAMOBS_BK || orderID == ORD_UTIL_CAMOBS_LF ||
			  orderID == ORD_UTIL_CAMOBS_RG )
		{
				if ( mCam->GetParent() != NULL )
				{
					if (  mCam->GetParent()->GetUniqueId() == mCurrentTargetId )
					{
						bRemoveChild = false ;
						std::cout<<"Camera already set on "<<proxy->GetActor()->GetName()<<std::endl;
					} 
					else
					{
						bRemoveChild = true ;
						mCam->GetParent()->RemoveChild(GetGameManager()->GetApplication().GetCamera());
						proxy->GetActor()->AddChild(mCam);
					}
				}
				else
				{
					bRemoveChild = true ;
					proxy->GetActor()->AddChild(mCam);
				}

				switch (orderID)
				{
					case ORD_UTIL_CAMOBS_UP: 
						tmpTrans.Set(0,-100.0f,500.0f,0,-75.0f,0);
					break;
					case ORD_UTIL_CAMOBS_FR : 
						tmpTrans.Set(0,+150.0f,15.0f,180.0f,0,0);
					break;
					case ORD_UTIL_CAMOBS_BK : 
						tmpTrans.Set(0,-150.0f,15.0f,0,0,0);
					break;
					case ORD_UTIL_CAMOBS_LF : 
						tmpTrans.Set(-150,0,15.0f,-90.0f,0,0);
					break;
					case ORD_UTIL_CAMOBS_RG : 
						tmpTrans.Set(150,0,15.0f,90.0f,0,0);
					break;
				}

				mCam->SetTransform(tmpTrans,dtCore::Transformable::REL_CS);

				if ( bRemoveChild )
				{
					mCam->GetTransform(tmpTrans,dtCore::Transformable::ABS_CS);
					if ( mCam->GetParent() != NULL )
						mCam->GetParent()->RemoveChild(mCam);				
					mCam->SetTransform(tmpTrans,dtCore::Transformable::ABS_CS);
				}

		}
		else if ( orderID == ORD_UTIL_CAMOBS_MOVE_UP || orderID == ORD_UTIL_CAMOBS_MOVE_DW ||
			 orderID == ORD_UTIL_CAMOBS_MOVE_RG || orderID == ORD_UTIL_CAMOBS_MOVE_LF ||
			 orderID == ORD_UTIL_CAMOBS_MOVE_FR  || orderID == ORD_UTIL_CAMOBS_MOVE_BK )
		{
			osg::Matrix mat;
			osg::Quat q;
			osg::Vec3 viewDir;
			osg::Vec3 pos;

			mCam->GetTransform(tmpTrans);
			tmpTrans.GetRotation(mat);
			mat.get(q);

			switch (orderID)
			{
				case ORD_UTIL_CAMOBS_MOVE_UP: 
				{
					viewDir = q * osg::Vec3(0,0,5);
					tmpTrans.GetTranslation(pos);
					pos = pos + viewDir;
					tmpTrans.SetTranslation(pos);
					mCam->SetTransform(tmpTrans);
					//std::cout<<"Camera Move Right. "<<std::endl;
				}
				break;

				case ORD_UTIL_CAMOBS_MOVE_DW: 
				{
					viewDir = q * osg::Vec3(0,0,-5);
					tmpTrans.GetTranslation(pos);
					pos = pos + viewDir;
					tmpTrans.SetTranslation(pos);
					mCam->SetTransform(tmpTrans);
					//std::cout<<"Camera Move Right. "<<std::endl;
				}
				break;

				case ORD_UTIL_CAMOBS_MOVE_RG: 
				{
					viewDir = q * osg::Vec3(+5,0,0);
					tmpTrans.GetTranslation(pos);
					pos = pos + viewDir;
					tmpTrans.SetTranslation(pos);
					mCam->SetTransform(tmpTrans);
					//std::cout<<"Camera Move Right. "<<std::endl;
				}
				break;

				case ORD_UTIL_CAMOBS_MOVE_LF: 
				{
					viewDir = q * osg::Vec3(-5,0,0);
					tmpTrans.GetTranslation(pos);
					pos = pos + viewDir;
					tmpTrans.SetTranslation(pos);
					mCam->SetTransform(tmpTrans);
					//std::cout<<"Camera Move Left. "<<std::endl;
				}
				break;

				case ORD_UTIL_CAMOBS_MOVE_FR: 
				{
					viewDir = q * osg::Vec3(0,5,0);
					tmpTrans.GetTranslation(pos);
					pos = pos + viewDir;
					tmpTrans.SetTranslation(pos);
					mCam->SetTransform(tmpTrans);
					//std::cout<<"Camera Move Forward. "<<std::endl;
				}
				break;

				case ORD_UTIL_CAMOBS_MOVE_BK: 
				{
					viewDir = q * osg::Vec3(0,-5,0);
					tmpTrans.GetTranslation(pos);
					pos = pos + viewDir;
					tmpTrans.SetTranslation(pos);
					mCam->SetTransform(tmpTrans);
					//std::cout<<"Camera Move Back. "<<std::endl;
				}
				break;
			}
		}
		else if ( orderID == ORD_UTIL_CAMOBS_ROT_UP || orderID == ORD_UTIL_CAMOBS_ROT_DW ||
			 orderID == ORD_UTIL_CAMOBS_ROT_RG || orderID == ORD_UTIL_CAMOBS_ROT_LF )
		{
			switch (orderID)
			{
				case ORD_UTIL_CAMOBS_ROT_UP: 
				{
					mCam->GetTransform(tmpTrans);
					tmpTrans.GetTranslation(x, y, z);
					tmpTrans.GetRotation(h, p, r);
					tmpTrans.Set(x,y,z,h,p+1.0f,r);
					mCam->SetTransform(tmpTrans);
				}
				break;

				case ORD_UTIL_CAMOBS_ROT_DW: 
				{
					mCam->GetTransform(tmpTrans);
					tmpTrans.GetTranslation(x, y, z);
					tmpTrans.GetRotation(h, p, r);
					tmpTrans.Set(x,y,z,h,p-1.0f,r);
					mCam->SetTransform(tmpTrans);
				}
				break;

				case ORD_UTIL_CAMOBS_ROT_LF: 
				{
					mCam->GetTransform(tmpTrans);
					tmpTrans.GetTranslation(x, y, z);
					tmpTrans.GetRotation(h, p, r);
					tmpTrans.Set(x,y,z,h-1.0f,p,r);
					mCam->SetTransform(tmpTrans);
				}
				break;

				case ORD_UTIL_CAMOBS_ROT_RG: 
				{
					mCam->GetTransform(tmpTrans);
					tmpTrans.GetTranslation(x, y, z);
					tmpTrans.GetRotation(h, p, r);
					tmpTrans.Set(x,y,z,h+1.0f,p,r);
					mCam->SetTransform(tmpTrans);
				}
				break;
			}
		}
		else if ( orderID == ORD_UTIL_CAMOBS_LOCK || orderID == ORD_UTIL_CAMOBS_ULOCK  )
		{
			switch (orderID)
			{
				case ORD_UTIL_CAMOBS_LOCK: 
				{
					mCam->GetTransform(tmpTrans);
					if ( mCam->GetParent() != NULL )
						mCam->GetParent()->RemoveChild(mCam);
					proxy->GetActor()->AddChild(mCam);
					mCam->SetTransform(tmpTrans);
					std::cout<<"Lock Camera on "<<proxy->GetActor()->GetName()<<std::endl;
				}
				break;
				case ORD_UTIL_CAMOBS_ULOCK: 
				{
					mCam->GetTransform(tmpTrans);
					if ( mCam->GetParent() != NULL )
					{
						mCam->GetParent()->RemoveChild(mCam);
						mCam->SetTransform(tmpTrans);
						std::cout<<"UnLock Camera from "<<proxy->GetActor()->GetName()<<std::endl;
					}
					else
						std::cout<<"Camera :: Already UnLock"<<std::endl;
				}
				break;
			}
		}
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
	 
	if ( Msg.GetOrderID()== TIPE_UTIL_CAM_OBSERVER ) /// hanya untuk test
	{
		int observerID, vehicleID, weaponID , launcherID, missileID, missileNum, orderID;
		vehicleID		= Msg.GetUAT0(); 
		weaponID    	= Msg.GetUAT1();		/// objectTypeID ( ship, submarine, missile , misc )
		launcherID		= Msg.GetUAT2(); 
		missileID		= int(Msg.GetUAT3()); 
		missileNum		= int(Msg.GetUAT4()); 
		observerID		= int(Msg.GetUAT5());   /// observerID   ( observer-1, observer-2, observer-3 , observer-4 )
		orderID			= int(Msg.GetUAT6());

		std::string objectType = GetActorWeaponTypeName(weaponID,C_WEAPON_TYPE_MISSILE);

		std::ostringstream obsID ;
		obsID << observerID ;
		std::string sname = "OBSERVER-"+obsID.str() ;

		if ( GetGameManager()->GetMachineInfo().GetName() == sname )
		{
			std::cout << "Get Message Observer. Config :: :: Vehicle = "<< vehicleID 
				<<" Weapon = "<< weaponID <<" launcherID = "<< launcherID 
				<<" missileID = "<< missileID << std::endl;
			SetCameraObserver(vehicleID,weaponID,launcherID,missileID,missileNum,orderID);
		}	
	}
	//if ( Msg.GetOrderID()== TIPE_UTIL_EVENT_EXPLODE ) ///  
	//{
	//	int tipeExplode		 = Msg.GetUAT0();  // CT_CANNON
	//	float xPos   		 = Msg.GetUAT1();  // x
	//	float yPos   		 = Msg.GetUAT2();  // y
	//	float zPos   		 = Msg.GetUAT3();  // z
	//	int sts    			 = Msg.GetUAT4();  // status

	//	MissileExplode(tipeExplode, xPos, yPos, zPos, sts);
	//}
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
	
	if ( mLoginName == C_LOGIN_OBSERVER )
	{
		dtGame::GameActorProxy* proxy = NULL;
		proxy = GetGameManager()->FindGameActorById(MyHandledObjectID);

		if ( proxy != NULL )
		{
			dtCore::RefPtr<dtGame::GameActorProxy> gap = dynamic_cast<dtGame::GameActorProxy*>(proxy);
			dtCore::Transform t;
			osg::Vec3 v3= gap->GetTranslation();
			v3[1]+= 50;
			v3[2]+= 500;
			t.SetTranslation(v3);
			osg::Vec3 rot(0.0f, -85.0f, 0.0f);
			t.SetRotation(rot);
			GetGameManager()->GetApplication().GetCamera()->SetTransform(t);
							
			osg::Node *model = gap->GetActor()->GetOSGNode();
			dtCore::RefPtr<dtUtil::NodeCollector> mtColector = new dtUtil::NodeCollector(model, dtUtil::NodeCollector::DOFTransformFlag);
			dtCore::RefPtr<osgSim::DOFTransform> mDOFTran = mtColector->GetDOFTransform("DOF_TDS1");
				
			if (mDOFTran != NULL)
			{
				std::cout << "DOF TDS FOUND" << std::endl;
			}
			else
			{
				std::cout << "DOF TDS NOT FOUND" << std::endl;
			}
		} else 
		{
			std::cout <<"	:: "<< GetName()<<" Cannot find actor with vehicle id "<<mVehicleID<<" for observer init"<<std::endl;
		}
	}

	else if ( mLoginName == C_LOGIN_TDS )
	{
		/*dtGame::GameActorProxy* SpoutProxy = NULL;
		dtGame::GameActorProxy* ShipProxy = NULL;*/

		//Edited By Nando (Rubah Camera Cannnon n Strella)
		//proxy = GetGameManager()->FindGameActorById(MyHandledObjectID);

		dtCore::RefPtr<dtDAL::ActorProxy> SpoutProxy = GetLauncherActors(C_WEAPON_TYPE_SPOUT,mVehicleID,mWeaponID,mLauncherID);
		dtCore::RefPtr<dtDAL::ActorProxy> ShipProxy = GetShipActorByID(mVehicleID);

		if ( ShipProxy != NULL)
		{
			std::cout << "Ship With ID " << mVehicleID << " Found" << std::endl;

			if ( SpoutProxy != NULL )
			{
				std::cout << "Launcher With ID "<< mVehicleID<<"-"<<mWeaponID<<"-"<<mLauncherID<< " Found" << std::endl;

				//Ganti Untuk TDS = DOF_TDS1;
				std::string mDOFName = GetCameraDOFName(mWeaponID,mLauncherID) ;

				if ((mWeaponID == CT_CANNON_40) || 
					(mWeaponID == CT_CANNON_57) ||
					(mWeaponID == CT_CANNON_76) ||
					(mWeaponID == CT_CANNON_120)
					)
				{
					//Get Ship Actor
					dtCore::RefPtr<ShipModelActor> gap = static_cast<ShipModelActor*>(ShipProxy->GetActor());
					dtGame::GameActorProxy &ap = gap->GetGameActorProxy();					
					osg::Node *model = ap.GetActor()->GetOSGNode();

					dtCore::RefPtr<dtUtil::NodeCollector> mtColector = new dtUtil::NodeCollector(model, dtUtil::NodeCollector::DOFTransformFlag);
					dtCore::RefPtr<osgSim::DOFTransform> mDOFTran = mtColector->GetDOFTransform(mDOFName);

					//GetSpoutActor
					dtCore::RefPtr<LauncherSpoutActor> SpoutActP = static_cast<LauncherSpoutActor*>(SpoutProxy->GetActor());
					static dtCore::Transform CannonSpoutTransform;
					
					SpoutActP->GetTransform(CannonSpoutTransform); 
					
					float Heading ,Pitch ,Roll;
					Heading = 0;
					Pitch	= 0;
					Roll	= 0;
					CannonSpoutTransform.GetRotation(Heading , Pitch ,Roll);
					std::cout << "Init Heading Camera : " << Heading << std::endl;

					if (mDOFTran != NULL)
					{
						osg::Vec3 vPos = GetDOFPositionAbsolute(mDOFTran);
						dtCore::Transform CurrentPos ;
						CurrentPos.SetTranslation(vPos);

						dtCore::RefPtr<dtCore::Camera> mCam = GetGameManager()->GetApplication().GetCamera();
						if ( mCam->GetParent() != NULL )
							mCam->GetParent()->RemoveChild(mCam);

						ap.GetActor()->AddChild(mCam);
						mCam->SetTransform(CurrentPos,dtCore::Transformable::ABS_CS);
						mCam->GetTransform(CurrentPos,dtCore::Transformable::REL_CS); 
						CurrentPos.SetRotation(Heading,0.0f,0.0f);
						mCam->SetTransform(CurrentPos,dtCore::Transformable::REL_CS);
						std::cout <<"	:: TDS-"<<mLauncherID<<" handle "<<ap.GetActor()->GetName()<<std::endl;
					} 
					else
						std::cout <<"	:: TDS-"<<mVehicleID<<"-"<<mWeaponID<<"-"<<mLauncherID<<" handle "<<ap.GetActor()->GetName()<< ", but cannot find position init "<<mDOFName<<std::endl;
				}
				else
				if ((mWeaponID == CT_STRELA)  ||
					(mWeaponID == CT_MISTRAL) ||
					(mWeaponID == CT_TETRAL)
					)
				{
					dtCore::RefPtr<LauncherSpoutActor> gap = static_cast<LauncherSpoutActor*>(SpoutProxy->GetActor());
					dtGame::GameActorProxy &ap = gap->GetGameActorProxy();	
					osg::Node *model = ap.GetActor()->GetOSGNode();
					dtCore::RefPtr<dtUtil::NodeCollector> mtColector = new dtUtil::NodeCollector(model, dtUtil::NodeCollector::DOFTransformFlag);
					dtCore::RefPtr<osgSim::DOFTransform> mDOFTran = mtColector->GetDOFTransform(mDOFName);

					if (mDOFTran != NULL)
					{
						osg::Vec3 vPos = GetDOFPositionAbsolute(mDOFTran);
						dtCore::Transform CurrentPos ;
						CurrentPos.SetTranslation(vPos);

						dtCore::RefPtr<dtCore::Camera> mCam = GetGameManager()->GetApplication().GetCamera();
						if ( mCam->GetParent() != NULL )
							mCam->GetParent()->RemoveChild(mCam);
						ap.GetActor()->AddChild(mCam);
						mCam->SetTransform(CurrentPos,dtCore::Transformable::ABS_CS);
						mCam->GetTransform(CurrentPos,dtCore::Transformable::REL_CS);
						CurrentPos.SetRotation(0.0f,0.0f,0.0f);
						mCam->SetTransform(CurrentPos,dtCore::Transformable::REL_CS);
						std::cout <<"	:: TDS-"<<mLauncherID<<" handle "<<ap.GetActor()->GetName()<<std::endl;

					} 
					else
						std::cout <<"	:: TDS-"<<mVehicleID<<"-"<<mWeaponID<<"-"<<mLauncherID<<" handle "<<ap.GetActor()->GetName()<< ", but cannot find position init "<<mDOFName<<std::endl;
				}
			} 
			else 
			{
				std::cout <<"	::  Cannot find Spout for observer init " <<std::endl;
			}
		}
		else
		{
			std::cout << " :: "<< "Cannot Find Vehicle with ID " << mVehicleID << std::cout;
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
      SimEnvironmentXML* simEnviXML = dynamic_cast <SimEnvironmentXML*>(GetGameManager()->GetComponentByName("SimEnvironmentXML"));
      actor->SetNight(simEnviXML->CheckNightScene());

  }

  return gap;


}
