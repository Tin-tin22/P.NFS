 ///////////////////////////////////////////////////////////////////////////////

#include "SocketServer.h"

#include "../didNetwork/Win32Tools/Utils.h"
#include "../didNetwork/Win32Tools/Exception.h"
#include "../didNetwork/SimTCPDataTypes.h"


#include "../didCommon/simmessages.h"
#include "../didCommon/simmessagetype.h"
#include "../didUtils/simActorControl.h"
#include "../didUtils/utilityfunctions.h"
#include "../didUtils/simGameUtils.h"
#include "../didUtils/SimServerClientComponent.h"

 // - enable process message [7/21/2014 EKA]
#include "../didCommon/SimServerMessage.h"
#include "../didUtils/CanonHandle.h"
#include "../didUtils/SimInputServerComponent.h"

#include <dtterrain/dtedterrainreader.h>
#include <dtUtil/mswin.h>
using namespace std;
#include <limits>

//Nando Added
#include "../didActors/missileactor.h"
#include "../didActors/shipmodelactor.h"

//  salvo rbu dan yakhont [4/30/2013 DID RKT2]
#include "../didUtils/simDBConnection.h"
#include "../didActors/launcherbodyactor.h"

//  [5/13/2013 DID RKT2]
#include "../didUtils/SimClientMessageProc.h"
#include "../didActors/playeractor.h"
#include "../didActors/cannonspoutactor.h"
#include "../didActors/MistralRocketActor.h"
#include "../didActors/StrelaRocketActor.h"

using JetByteTools::Win32::CIOCompletionPort;
using JetByteTools::Win32::CIOBuffer;
using JetByteTools::Win32::Output;
using JetByteTools::Win32::ToString;
using JetByteTools::Win32::_tstring;
using JetByteTools::Win32::CCriticalSection;
using JetByteTools::Win32::CException;
using JetByteTools::Win32::GetLastErrorMessage;

relocateSocket::relocateSocket()
{

}


CSocketServer::CSocketServer(
   const std::string &welcomeMessage,
   unsigned long addressToListenOn,
   unsigned short portToListenOn,
   size_t maxFreeSockets,
   size_t maxFreeBuffers,
   size_t bufferSize /* = 1024 */,
   size_t numThreads /* = 0 */)
   :  JetByteTools::Win32::CSocketServer(addressToListenOn, portToListenOn, maxFreeSockets, maxFreeBuffers, bufferSize, numThreads),
      m_welcomeMessage(welcomeMessage)//,
			,dtGame::GMComponent("SocketServer")
{
  mTickLocalCounter= 0;
  mTickLocalCounterMissile = 0;
  
  TimeToTakeBuffer = 0;

  vecProc.resize(256, 0);
  vecSize.resize(256, 0);

  enableProcessMessage = true;
  
  RegisterProcedure(structPositionID, &CSocketServer::handlePacketPosition, sizeof(spPosition));
  RegisterProcedure(structOrderID, &CSocketServer::handlePacketOrder, sizeof(spOrder));
  RegisterProcedure(structCreateAR, &CSocketServer::handlePacketActorController, sizeof(spActorsController));
  RegisterProcedure(structUtilityAndTools, &CSocketServer::handlePacketUtilityAndTools, sizeof(spUtilityTools));
  RegisterProcedure(structMissilePos, NULL, sizeof(spMissilePos));
  RegisterProcedure(structSetTorpedoSUT, &CSocketServer::handlePacketSetTorpedoSUT, sizeof(spSetTorpedoSUT));
  RegisterProcedure(structSetAsrock, &CSocketServer::handlePacketSetAsrock, sizeof(spSetAsrock));
  RegisterProcedure(structSetCannon, &CSocketServer::handlePacketSetCannon, sizeof(spSetCannon));
  RegisterProcedure(structSetRBU, &CSocketServer::handlePacketSetRBU, sizeof(spSetRBU));
  RegisterProcedure(structSetExocetMM40, &CSocketServer::handlePacketSetExocet40, sizeof(spSetExocetMM40));
  RegisterProcedure(structSetTorpedo, &CSocketServer::handlePacketSetTorpedoA244, sizeof(spSetTorpedoA244));
  RegisterProcedure(structSetDatabaseEvent, &CSocketServer::handlePacketDatabaseEvent, sizeof(spDatabaseEvent));
  RegisterProcedure(structSetC802, &CSocketServer::handlePacketSetC802, sizeof(spSetC802)); // BAWE-20120327: C802_MISSILE_ACTOR
  RegisterProcedure(structSetYakhont, &CSocketServer::handlePacketSetYakhont, sizeof(spSetYakhont));
  RegisterProcedure(structSetMistral, &CSocketServer::handlePacketSetMistral, sizeof(spSetMistral));
  RegisterProcedure(structSetTetral, &CSocketServer::handlePacketSetTetral, sizeof(spSetTetral));
  RegisterProcedure(structSetStrela, &CSocketServer::handlePacketSetStrela, sizeof(spSetStrela));
  RegisterProcedure(structSetFindTarget, NULL, sizeof(spFindTarget));
  RegisterProcedure(structSetCannonSplash, NULL, sizeof(spCannonSplash));
  RegisterProcedure(structSetMessageHandling, NULL, sizeof(spMessageHandle));
}

void CSocketServer::takeReloSockData(double aDt)
{
	if (mRelocateSocket.size() > 0)
	{
		/*for (std::vector<relocateSocket*>::iterator iter=mRelocateSocket.begin(); iter!=mRelocateSocket.end(); iter++)
		{
			if ((*iter)->isEnable == true)
			{
				PacketRecognizer((*iter)->tempP, (*iter)->tempBuffSize, (*iter)->tempPSocket);
				(*iter)->isEnable = false;
				break;
			}
		}*/

		// -  [7/2/2014 EKA]
		PacketRecognizer(mRelocateSocket.at(0)->tempP, mRelocateSocket.at(0)->tempBuffSize, mRelocateSocket.at(0)->tempPSocket);
		//mRelocateSocket.erase(mRelocateSocket.begin());
		mRelocateSocket.pop_back();
	}
}

void CSocketServer::addReloSockData(char *tempP, unsigned int tempBuffSize, Socket *tempSocket)
{
	relocateSocket* reloSock = new relocateSocket();

	reloSock->tempP = tempP;
	reloSock->tempBuffSize = tempBuffSize;
	reloSock->tempPSocket = tempSocket;
	reloSock->isEnable = true;

	//std::cout << "Create Buffer" << std::endl;

	mRelocateSocket.push_back(reloSock);
}


void CSocketServer::OnStartAcceptingConnections()
{
   Output(_T("OnStartAcceptingConnections"));
}

void CSocketServer::OnStopAcceptingConnections()
{
   Output(_T("OnStopAcceptingConnections"));
}
      
void CSocketServer::OnShutdownInitiated()
{
   Output(_T("OnShutdownInitiated"));
}
      
void CSocketServer::OnShutdownComplete()
{
   Output(_T("OnShutdownComplete"));
}

void CSocketServer::OnConnectionEstablished(
   Socket *pSocket,
   CIOBuffer * /*pAddress*/)
{
   Output(_T("OnConnectionEstablished"));
   pSocket->Read();
}

void CSocketServer::OnConnectionClientClose(
   Socket * /*pSocket*/)
{
   Output(_T("OnConnectionClientClose"));
}

void CSocketServer::OnConnectionReset(
   Socket * /*pSocket*/)
{
   Output(_T("OnConnectionReset"));
}

bool CSocketServer::OnConnectionClosing(
   Socket *pSocket)
{
   Output(_T("OnConnectionClosing"));

   // we'll handle socket closure so that we can do a lingering close
   // note that this is not ideal as this code is executed on the an
   // IO thread. If we had a thread pool we could fire this off to the
   // thread pool to handle.

   pSocket->Close();

   return true;
}

void CSocketServer::OnConnectionClosed(
   Socket * /*pSocket*/)
{
   //Output(_T("OnConnectionClosed"));
}

void CSocketServer::OnConnectionCreated()
{
   //Output(_T("OnConnectionCreated"));
}

void CSocketServer::OnConnectionDestroyed()
{
   //Output(_T("OnConnectionDestroyed"));
}

void CSocketServer::OnConnectionError(
   ConnectionErrorSource source,
   Socket *pSocket,
   CIOBuffer *pBuffer,
   DWORD lastError)
{
   const LPCTSTR errorSource = (source == ZeroByteReadError ? _T(" Zero Byte Read Error:") : (source == ReadError ? _T(" Read Error:") : _T(" Write Error:")));

   //Output(_T("OnConnectionError - Socket = ") + ToString(pSocket) + _T(" Buffer = ") + ToString(pBuffer) + errorSource + GetLastErrorMessage(lastError));
}

void CSocketServer::OnError(
   const JetByteTools::Win32::_tstring &message)
{
   //Output(_T("OnError - ") + message);
}

void CSocketServer::OnBufferCreated()
{
   //Output(_T("OnBufferCreated"));
}

void CSocketServer::OnBufferAllocated()
{
  // Output(_T("OnBufferAllocated"));
}

void CSocketServer::OnBufferReleased()
{
   //Output(_T("OnBufferReleased"));
}

void CSocketServer::OnBufferDestroyed()
{
   //Output(_T("OnBufferDestroyed"));
}

void CSocketServer::OnThreadCreated()
{
   //Output(_T("OnThreadCreated"));
}

void CSocketServer::OnThreadBeginProcessing()
{
  // Output(_T("OnThreadBeginProcessing"));
}

void CSocketServer::OnThreadEndProcessing()
{
   //Output(_T("OnThreadEndProcessing"));
}

void CSocketServer::OnThreadDestroyed()
{
   //Output(_T("OnThreadDestroyed"));
}

void CSocketServer::ReadCompleted(
   Socket *pSocket,
   CIOBuffer *pBuffer)
{
	CCriticalSection::Owner lock(m_networkManipulationSection);

  // punya armand, thread safety meragukan
  bool bLoop;
  char *p, *p2;

  p= pSocket->FBuffer+ pSocket->FBufferNow;
  CopyMemory(p, pBuffer->GetBuffer(), pBuffer->GetUsed());
  pSocket->FBufferNow+= pBuffer->GetUsed();

	bLoop= true;
  while(bLoop)
  {
    if ((!pSocket->FBufferSizeKnown) && (pSocket->FBufferNow>= 4)) 
    {
      CopyMemory(&(pSocket->FBufferSize), pSocket->FBuffer, 4);
      pSocket->FBufferSizeKnown= true;
    }

    if ((pSocket->FBufferSizeKnown) && (pSocket->FBufferNow>= pSocket->FBufferSize+ 4)) 
    {
      p= pSocket->FBuffer+ 4;
      //PacketRecognizer(p, pSocket->FBufferSize, pSocket);
	  addReloSockData(p, pSocket->FBufferSize, pSocket);

      if (pSocket->FBufferNow>pSocket->FBufferSize+ 4) 
      {
        p= pSocket->FBuffer+ (pSocket->FBufferSize+ 4);
        pSocket->FBufferNow= pSocket->FBufferNow- (pSocket->FBufferSize+ 4);

        p2= new char[pSocket->FBufferNow];
        CopyMemory(p2, p, pSocket->FBufferNow);
        CopyMemory(pSocket->FBuffer, p2, pSocket->FBufferNow);
        
		delete[] p2;
        pSocket->FBufferSizeKnown= false;
      }
      else
      {
        pSocket->FBufferSize= 0;
        pSocket->FBufferNow= 0;
        pSocket->FBufferSizeKnown= false;
      }
    }
    else
      bLoop= false;
  }

  pSocket->Read();
   

}

void CSocketServer::PacketRecognizer(char* p, unsigned int size, Socket *pSocket)
{
  spCheck chk;
  CopyMemory(&chk, p, sizeof(spCheck));
  if((chk.pass[0]=='S')&&
     (chk.pass[1]=='K')&&
     (chk.pass[2]=='L'))
  {

    //kalo ada packet yang masuk ke server diapain tambah disini :D
    //---------------------------------------------------------------
    if(this->vecProc[chk.ID]!= NULL)
    {
      //this->*(vecProc[chk.ID])(p, size, pSocket);
      //this->*vecProc[chk.ID](p, size, pSocket);
      (this->*vecProc[chk.ID])(p, size, pSocket);
    }
    else
      std::cout<<"Unidentified packet, id: "<<int(chk.ID)<<std::endl;
  } //end if valid
  else
  {
    LOG_INFO("BUSUK PAKET");
    Output(_T("Invalid packet."));
  }
}

void CSocketServer::SendClient(Socket *pSocket, char* pPacket, int pSize)
{
	pSocket->Write(pPacket, pSize);
}

void CSocketServer::SendClientEx(unsigned char pID, char* pBuffer, Socket *pSocket) //pasti broadcast
{
	unsigned int size= 0;
  char *buffer;
  buffer= new char[1024*1024];

  spCheck chk;
  chk.ID= pID;
  chk.pass[0]= 'S';
  chk.pass[1]= 'K';
  chk.pass[2]= 'L';
  CopyMemory(pBuffer, &chk, sizeof(spCheck));
  
  size= vecSize[pID];
  CopyMemory(buffer, &size, 4);
  CopyMemory(buffer+ 4, pBuffer, size);
  //------------------------------------------

  Socket *pSock = m_activeList.Head();
  int i= 0;
	while (pSock)
  {
    std::string s;
    pSock->Write(buffer, size+ 4);
    
    pSock= SocketList::Next(pSock);
    i++;
  }

  delete[] buffer;
}

void CSocketServer::EchoMessage(
   Socket *pSocket,
   CIOBuffer *pBuffer) const
{
   pSocket->Write(pBuffer);
}

bool CSocketServer::IsInvalidMessage(const dtGame::Message& msg)
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

static int distX = 0;
static int distY = 0;
static bool firstTime = false;

void CSocketServer::HandleLocalMessage(const dtGame::Message& msg)
{
	//Nando Added For TDS/Strella/Mistral Stand Alone
	if (msg.GetMessageType() == SimMessageType::CANNON_EVENT)
	{
		const MsgSetCannon &MsgTDS = static_cast<const MsgSetCannon&>(msg);

		int VehicleID	= (int) MsgTDS.GetVehicleID();
		int WeaponID	= (int) MsgTDS.GetWeaponID();
		int LauncherID	= (int) MsgTDS.GetLauncherID();
		int MissileID	= (int) MsgTDS.GetMissileID();
		int MissileNum	= (int) MsgTDS.GetMissileNum();

		int OrderMessage = MsgTDS.GetOrderID();

		if( OrderMessage == ORD_CANNON_DIRECT_F )
		{
			dtCore::RefPtr<MsgSetCannon> msgSend;
			GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::CANNON_EVENT, msgSend);
			msgSend->SetVehicleID(VehicleID);
			msgSend->SetWeaponID(WeaponID);                                                                                                                    
			msgSend->SetLauncherID(LauncherID);
			msgSend->SetMissileID(MissileID);
			msgSend->SetMissileNum(MissileNum);
			msgSend->SetUpDown(MsgTDS.GetUpDown());
			msgSend->SetModeID(MsgTDS.GetModeID());

			std::cout << "Stand Alone Mode Fire" << std::endl;
			std::cout << "Event Cannon From Joystick" << std::endl;
			CheckValidMissilesForStandAlone(VehicleID, WeaponID, LauncherID , MissileID, MissileNum );

			msgSend->SetOrderID(ORD_CANNON_F);
			GetGameManager()->SendNetworkMessage(*msgSend.get());
			GetGameManager()->SendMessage(*msgSend.get());
		}
	}
	else if (msg.GetMessageType() == SimMessageType::MISTRAL_EVENT)
	{
		const MsgSetMistral &MsgTDS = static_cast<const MsgSetMistral&>(msg);

		int VehicleID	= (int) MsgTDS.GetVehicleID();
		int WeaponID	= (int) MsgTDS.GetWeaponID();
		int LauncherID	= (int) MsgTDS.GetLauncherID();
		int MissileID	= (int) MsgTDS.GetMissileID();
		int MissileNum	= (int) MsgTDS.GetMissileNum();

		int OrderMessage = MsgTDS.GetOrderID();

		if( OrderMessage == ORD_MISTRAL_DIRECT_F )
		{
			dtCore::RefPtr<MsgSetMistral> msgSend;
			GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::MISTRAL_EVENT, msgSend);
			msgSend->SetVehicleID(VehicleID);
			msgSend->SetWeaponID(WeaponID);
			msgSend->SetLauncherID(LauncherID);
			msgSend->SetMissileID(MissileID);
			msgSend->SetMissileNum(MissileNum);
			msgSend->SetTargetBearing(MsgTDS.GetTargetBearing());

			std::cout << "Stand Alone Mode Fire" << std::endl;
			std::cout << "Event Mistral From Joystick" << std::endl;
			CheckValidMissilesForStandAlone(VehicleID, WeaponID, LauncherID , MissileID, MissileNum );

			msgSend->SetOrderID(ORD_MISTRAL_FIRE);
			GetGameManager()->SendNetworkMessage(*msgSend.get());
			GetGameManager()->SendMessage(*msgSend.get());
		}
	}
	else if (msg.GetMessageType() == SimMessageType::STRELA_EVENT)
	{	
		const MsgSetStrela &MsgTDS = static_cast<const MsgSetStrela&>(msg);

		int VehicleID	= (int) MsgTDS.GetVehicleID();
		int WeaponID	= (int) MsgTDS.GetWeaponID(); 
		int LauncherID	= (int) MsgTDS.GetLauncherID();
		int MissileID	= (int) MsgTDS.GetMissileID();
		int MissileNum	= (int) MsgTDS.GetMissileNum();

		int OrderMessage = MsgTDS.GetOrderID();

		if( OrderMessage == ORD_STRELA_DIRECT_F )
		{
			dtCore::RefPtr<MsgSetStrela> msgSend;
			GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::STRELA_EVENT, msgSend);
			msgSend->SetVehicleID(VehicleID);
			msgSend->SetWeaponID(WeaponID);
			msgSend->SetLauncherID(LauncherID);
			msgSend->SetMissileID(MissileID);
			msgSend->SetMissileNum(MissileNum);
			msgSend->SetTargetBearing(MsgTDS.GetTargetBearing());

			std::cout << "Stand Alone Mode Fire" << std::endl;
			std::cout << "Event Strella From Joystick" << std::endl;
			CheckValidMissilesForStandAlone(VehicleID, WeaponID, LauncherID , MissileID, MissileNum );

			msgSend->SetOrderID(ORD_STRELA_FIRE);
			GetGameManager()->SendNetworkMessage(*msgSend.get());
			GetGameManager()->SendMessage(*msgSend.get());
		}
	}
	else if (msg.GetMessageType() == SimMessageType::TETRAL_EVENT)
	{	
		const MsgSetTetral &MsgTDS = static_cast<const MsgSetTetral&>(msg);

		int VehicleID	= (int) MsgTDS.GetVehicleID();
		int WeaponID	= (int) MsgTDS.GetWeaponID();
		int LauncherID	= (int) MsgTDS.GetLauncherID();
		int MissileID	= (int) MsgTDS.GetMissileID();
		int MissileNum	= (int) MsgTDS.GetMissileNum();

		int OrderMessage = MsgTDS.GetOrderID();

		if( OrderMessage == ORD_TETRAL_DIRECT_F )
		{
			dtCore::RefPtr<MsgSetStrela> msgSend;
			GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::TETRAL_EVENT, msgSend);
			msgSend->SetVehicleID(VehicleID);
			msgSend->SetWeaponID(WeaponID);
			msgSend->SetLauncherID(LauncherID);
			msgSend->SetMissileID(MissileID);
			msgSend->SetMissileNum(MissileNum);
			msgSend->SetTargetBearing(MsgTDS.GetTargetBearing());

			std::cout << "Stand Alone Mode Fire" << std::endl;
			std::cout << "Event Tetral From Joystick" << std::endl;
			CheckValidMissilesForStandAlone(VehicleID, WeaponID, LauncherID , MissileID, MissileNum );

			msgSend->SetOrderID(ORD_TETRAL_FIRE);
			GetGameManager()->SendNetworkMessage(*msgSend.get());
			GetGameManager()->SendMessage(*msgSend.get());
		}
	}
	else
	if (msg.GetMessageType() == SimMessageType::UTILITY_AND_TOOLS)
    {
        processUtilityAndTools(msg);
    }
	else
	if (msg.GetMessageType() == dtGame::MessageType::TICK_LOCAL)
	{
		const dtGame::TickMessage &tick = static_cast<const dtGame::TickMessage&>(msg);
		float deltaSimTime = tick.GetDeltaSimTime();

		if ( mTickLocalCounter >= C_UPDATEALLOBJECT_CYCLE_TIME_SHIP )
		{
			std::vector<dtGame::GameActorProxy *> fill;
			std::vector<dtGame::GameActorProxy *>::iterator iter;
			GetGameManager()->GetAllGameActors(fill);
;
			dtCore::Transform tmpTrans;
			std::string actTypeName = "";

			for (iter = fill.begin(); iter < fill.end(); iter++)
			{
				actTypeName = (*iter)->GetActorType().GetName() ;
				(*iter)->GetActorType().GetName() ;

				//std::cout << "actor size = " << fill.size() << " , actTypeName = " << actTypeName << std::endl;
				
				if (( actTypeName == C_CN_SHIP ) || ( actTypeName== C_CN_SUBMARINE )|| (actTypeName == C_CN_HELICOPTER )|| (actTypeName == C_CN_AIRCRAFT)) 
				{
					//std::cout << "mTickLocalCounter = " << mTickLocalCounter << " , actTypeName = " << actTypeName << std::endl;

					spPosition lsPos;

					dtCore::RefPtr<dtDAL::ActorProperty> VIDProp( (*iter)->GetProperty(C_SET_VID) );
					dtCore::RefPtr<dtDAL::IntActorProperty> intprop( static_cast<dtDAL::IntActorProperty*>( VIDProp.get() ) );
					lsPos.ShipID= intprop->GetValue();

					//tmpTrans.GetTranslation(x, y, z);
					//coord.SetCartesianPoint(osg::Vec3(x, y, z));

					((*iter)->GetGameActor()).GetTransform(tmpTrans);
					dtTerrain::GeoCoordinates coord;
					coord.SetCartesianPoint(tmpTrans.GetTranslation());
					lsPos.x= coord.GetLongitude();
					lsPos.y= coord.GetLatitude();
					//lsPos.z= coord.GetAltitude();
					//lsPos.z= tmpTrans.GetTranslation()[2]* DEF_METER_TO_FEET;
					lsPos.z= tmpTrans.GetTranslation()[2] ; // ambil meternya saja //* DEF_METRE_TO_DEGREE;

					/*
					lsPos.x= (x* dmtd)+ C_RELATIVE_X;
					lsPos.y= (y* dmtd)+ C_RELATIVE_Y;
					lsPos.z= (z* dmtd);
					*/

					// get speed start from here
					dtCore::RefPtr<dtDAL::ActorProperty> speedProp( (*iter)->GetProperty(C_SET_SPEED) );
					dtCore::RefPtr<dtDAL::FloatActorProperty> floatprop( static_cast<dtDAL::FloatActorProperty*>( speedProp.get() ) );
					lsPos.speed= floatprop->GetValue();

					// get heading start from here
					dtCore::RefPtr<dtDAL::ActorProperty> headProp( (*iter)->GetProperty(C_SET_COURSE) );
					dtCore::RefPtr<dtDAL::FloatActorProperty> floatprop2( static_cast<dtDAL::FloatActorProperty*>( headProp.get() ) );
					lsPos.heading = floatprop2->GetValue();

					// get pitch start from here
					// lsPos.pitch= (*iter)->GetRotation().x();

					dtCore::RefPtr<dtDAL::ActorProperty> pitchprop( (*iter)->GetProperty(C_SET_PITCH) );
					dtCore::RefPtr<dtDAL::FloatActorProperty> floatprop3( static_cast<dtDAL::FloatActorProperty*>( pitchprop.get() ) );
					lsPos.pitch = floatprop3->GetValue();

					// get roll start from here
					dtCore::RefPtr<dtDAL::ActorProperty> rollprop( (*iter)->GetProperty(C_SET_HEEL) ); // BAWE-20101208: SEPERATE_RUDDER_AND_ADDANGLE
					dtCore::RefPtr<dtDAL::FloatActorProperty> floatprop4( static_cast<dtDAL::FloatActorProperty*>( rollprop.get() ) );
					lsPos.roll = floatprop4->GetValue();

					//++ BAWE-20110706: NEW_POSITION_PACKET_WITH_ROLL
					// get rudder start from here
					dtCore::RefPtr<dtDAL::ActorProperty> rudderprop( (*iter)->GetProperty("DesiredRudderAngle") ); // BAWE-20110613: WRONG_RUDDER_INDIKATOR2D
					dtCore::RefPtr<dtDAL::FloatActorProperty> floatprop5( static_cast<dtDAL::FloatActorProperty*>( rudderprop.get() ) );
					lsPos.rudder = floatprop5->GetValue();
					//-- BAWE-20110706: NEW_POSITION_PACKET_WITH_ROLL

					SendClientEx(structPositionID, (char *)&lsPos);
				}
			}
			mTickLocalCounter = 0;
		}
		
		if ( mTickLocalCounterMissile >= C_UPDATEALLOBJECT_CYCLE_TIME_MISSILE )
		{
			std::vector<dtGame::GameActorProxy *> fill;
			std::vector<dtGame::GameActorProxy *>::iterator iter;
			GetGameManager()->GetAllGameActors(fill);

			dtCore::Transform tmpTrans;
			std::string actTypeName = "";

			mTickLocalCounterMissile = 0;

			for (iter = fill.begin(); iter < fill.end(); iter++)
			{
				actTypeName = (*iter)->GetActorType().GetName() ;
				(*iter)->GetActorType().GetName() ;

				if (
					( actTypeName== C_CN_EXOCET_40 )  || ( actTypeName== C_CN_ASROCK ) ||
					( actTypeName== C_CN_TORPSUT ) || ( actTypeName== C_CN_RBU ) ||
					( actTypeName== C_CN_TORPEDO ) || ( actTypeName== C_CN_TORPSUT ) ||
					( actTypeName== C_CN_YAKHONT ) || ( actTypeName== C_CN_C802 ) ||
					( actTypeName== C_CN_CANNONM ) || ( actTypeName== C_CN_TETRAL ) ||
					( actTypeName== C_CN_MISTRAL ) || ( actTypeName== C_CN_STRELA )
					)
				{
					//std::cout << "mTickLocalCounterMissile = " << mTickLocalCounterMissile << " , actTypeName = " << actTypeName << std::endl;

					// Do something when, ceck launched property
					dtCore::RefPtr<dtDAL::ActorProperty> VIDProp( (*iter)->GetProperty(C_SET_LAUNCHED) );
					dtCore::RefPtr<dtDAL::BooleanActorProperty> pisLaunched ( static_cast<dtDAL::BooleanActorProperty*>( VIDProp.get() ) );
					bool bIsLaunch = pisLaunched->GetValue();
					if ( bIsLaunch == true )
					{
						// send to 2D jika launched
						spMissilePos lsPos;

						dtCore::RefPtr<dtDAL::ActorProperty> VIDProp( (*iter)->GetProperty(C_SET_VID) );
						dtCore::RefPtr<dtDAL::IntActorProperty> vehicleProp ( static_cast<dtDAL::IntActorProperty*>( VIDProp.get() ) );
						lsPos.ShipID= (unsigned short int)vehicleProp->GetValue();

						dtCore::RefPtr<dtDAL::ActorProperty> WIDProp( (*iter)->GetProperty(C_SET_WID) );
						dtCore::RefPtr<dtDAL::IntActorProperty> weaponProp ( static_cast<dtDAL::IntActorProperty*>( WIDProp.get() ) );
						lsPos.WeaponID= (unsigned short int)weaponProp->GetValue();

						dtCore::RefPtr<dtDAL::ActorProperty> LIDProp( (*iter)->GetProperty(C_SET_LID) );
						dtCore::RefPtr<dtDAL::IntActorProperty> launcherProp ( static_cast<dtDAL::IntActorProperty*>( LIDProp.get() ) );
						lsPos.LauncherID= (unsigned short int)launcherProp->GetValue();

						dtCore::RefPtr<dtDAL::ActorProperty> MIDProp( (*iter)->GetProperty(C_SET_MID) );
						dtCore::RefPtr<dtDAL::IntActorProperty> MissileIDProp( static_cast<dtDAL::IntActorProperty*>( MIDProp.get() ) );
						lsPos.MissileID= (unsigned short int)MissileIDProp->GetValue();

						dtCore::RefPtr<dtDAL::ActorProperty> MNumProp( (*iter)->GetProperty(C_SET_MNUM) );
						dtCore::RefPtr<dtDAL::IntActorProperty> MissileNumProp( static_cast<dtDAL::IntActorProperty*>( MNumProp.get() ) );
						lsPos.MissileNum= (unsigned short int)MissileNumProp->GetValue();

						dtCore::RefPtr<dtDAL::ActorProperty> pspeedProp( (*iter)->GetProperty(C_SET_SPEED) );
						dtCore::RefPtr<dtDAL::FloatActorProperty> speedProp( static_cast<dtDAL::FloatActorProperty*>( pspeedProp.get() ) );
						lsPos.speed= (float)speedProp->GetValue();

						dtCore::RefPtr<dtDAL::ActorProperty> pheadProp( (*iter)->GetProperty(C_SET_HEADING) );
						dtCore::RefPtr<dtDAL::FloatActorProperty> headProp( static_cast<dtDAL::FloatActorProperty*>( pheadProp.get() ) );
						lsPos.heading= (float)headProp->GetValue();
						lsPos.heading = ValidateDegree(lsPos.heading);

						lsPos.Status = ST_MISSILE_RUN;

						if (lsPos.heading==std::numeric_limits<float>::quiet_NaN())
						{
							std::cout << "heading qnan" <<std::endl;
							lsPos.heading=0.0f;
						}

						((*iter)->GetGameActor()).GetTransform(tmpTrans);
						dtTerrain::GeoCoordinates coord;
						coord.SetCartesianPoint(tmpTrans.GetTranslation());
						lsPos.x= (double)coord.GetLongitude();
						lsPos.y= (double)coord.GetLatitude();
						//lsPos.z= coord.GetAltitude();
						lsPos.z= (double)tmpTrans.GetTranslation()[2] ; // ambil meternya saja //* DEF_METRE_TO_DEGREE;
						lsPos.heading= (float)tmpTrans.GetRotation()[0] * -1 ; // BAWE-20120228: GET_HEADING

						SendClientEx(structMissilePos, (char *)&lsPos);
					}
				}
			}
		}

		mTickLocalCounter += deltaSimTime;
		mTickLocalCounterMissile += deltaSimTime;
	} 
	else 
	if (msg.GetMessageType() == dtGame::MessageType::TICK_REMOTE)
	{
		// Do something when we get remote tick
	}
	else
	if(msg.GetMessageType() == dtGame::MessageType::INFO_GAME_EVENT) 
	{
		const dtGame::GameEventMessage &eventMsg = 
				static_cast<const dtGame::GameEventMessage&>(msg);

	}
    //++ BAWE-20110705: WRONG_RUDDER_INDIKATOR2D
    else if (msg.GetMessageType() == SimMessageType::ORDER_EVENT)
    {
        ProcessOrderEvent(msg);
    }
    //-- BAWE-20110705: WRONG_RUDDER_INDIKATOR2D
	else
	if (msg.GetMessageType() == SimMessageType::HANDLE_MESSAGE_EVENT)
	{
		spMessageHandle MessageSent;
		const MsgSetHandleMessage &MsgHandle = static_cast<const MsgSetHandleMessage&>(msg);
		MessageSent.MessageID = MsgHandle.GetMsgID();
		MessageSent.Cmd1 = MsgHandle.GetCmd1();
		MessageSent.Cmd2 = MsgHandle.GetCmd2();
		MessageSent.Cmd3 = MsgHandle.GetCmd3();
		MessageSent.Cmd4 = MsgHandle.GetCmd4();
		SendClientEx(structSetMessageHandling, (char *)&MessageSent);
	}

}

void CSocketServer::HandleNetworkMessage(const dtGame::Message& msg)
{
    //++ BAWE-20110705: WRONG_RUDDER_INDIKATOR2D
    if (msg.GetMessageType() == SimMessageType::ORDER_EVENT)
    {
        ProcessOrderEvent(msg);
    }
	//-- BAWE-20110705: WRONG_RUDDER_INDIKATOR2D

	//Nando for Cannon from TDS (Cannon, Mistral, Strella)
	else if (msg.GetMessageType() == SimMessageType::CANNON_EVENT)
	{
		const MsgSetCannon &MsgTDS = static_cast<const MsgSetCannon&>(msg);

		int VehicleID	 = (int) MsgTDS.GetVehicleID();
		int WeaponID	 = (int) MsgTDS.GetWeaponID();
		int LauncherID	 = (int) MsgTDS.GetLauncherID();
		int MissileID	 = (int) MsgTDS.GetMissileID();
		int MissileNum	 = (int) MsgTDS.GetMissileNum();
		int OrderMessage = MsgTDS.GetOrderID();

		dtCore::RefPtr<MsgSetCannon> msgSend;
		GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::CANNON_EVENT, msgSend);
		msgSend->SetVehicleID(VehicleID);
		msgSend->SetWeaponID(WeaponID);
		msgSend->SetLauncherID(LauncherID);
		msgSend->SetMissileID(MissileID);
		msgSend->SetMissileNum(MissileNum);
		msgSend->SetUpDown(MsgTDS.GetUpDown());
		msgSend->SetModeID(MsgTDS.GetModeID());

		if( OrderMessage == ORD_CANNON_DIRECT_F )
		{
			//std::cout << "Event Cannon Fire From Joystick" << std::endl;
			//CheckValidMissiles(VehicleID, WeaponID, LauncherID , MissileID, MissileNum );

			if (IsValidLauncher(VehicleID,WeaponID,LauncherID))
			{
				msgSend->SetOrderID(ORD_CANNON_F);
				GetGameManager()->SendNetworkMessage(*msgSend.get());
				GetGameManager()->SendMessage(*msgSend.get());
			}
			else
				std::cout << "Not Valid Launcher Canon" <<std::endl;

		}
		else
		if( OrderMessage == ORD_CANNON_DIRECT_UD )
		{
			if (IsValidLauncher(VehicleID,WeaponID,LauncherID))
			{
				msgSend->SetOrderID(ORD_CANNON_DIRECT_UD);

				GetGameManager()->SendNetworkMessage(*msgSend.get());
				GetGameManager()->SendMessage(*msgSend.get());
			}
			else
				std::cout << "Not Valid Launcher Canon" <<std::endl;			
		}
		else
		if( OrderMessage == ORD_CANNON_DIRECT_LR )
		{
			if (IsValidLauncher(VehicleID,WeaponID,LauncherID))
			{
				msgSend->SetOrderID(ORD_CANNON_DIRECT_LR);

				GetGameManager()->SendNetworkMessage(*msgSend.get());
				GetGameManager()->SendMessage(*msgSend.get());
			}
			else
				std::cout << "Not Valid Launcher Canon" <<std::endl;
		}
	}
	else if (msg.GetMessageType() == SimMessageType::MISTRAL_EVENT)
	{
		const MsgSetMistral &MsgTDS = static_cast<const MsgSetMistral&>(msg);

		int VehicleID	 = (int) MsgTDS.GetVehicleID();
		int WeaponID	 = (int) MsgTDS.GetWeaponID();
		int LauncherID	 = (int) MsgTDS.GetLauncherID();
		int MissileID	 = (int) MsgTDS.GetMissileID();
		int MissileNum	 = (int) MsgTDS.GetMissileNum();
		int OrderMessage = MsgTDS.GetOrderID();

		dtCore::RefPtr<MsgSetMistral> msgSend;
		GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::MISTRAL_EVENT, msgSend);
		msgSend->SetVehicleID(VehicleID);
		msgSend->SetWeaponID(WeaponID);
		msgSend->SetLauncherID(LauncherID);
		msgSend->SetMissileID(MissileID);
		msgSend->SetMissileNum(MissileNum);
		msgSend->SetTargetBearing(MsgTDS.GetTargetBearing());

		if( OrderMessage == ORD_MISTRAL_DIRECT_F )
		{
			//std::cout << "Event Fire Mistral From Joystick" << std::endl;
			//CheckValidMissiles(VehicleID, WeaponID, LauncherID , MissileID, MissileNum );

			if (IsValidLauncher(VehicleID, WeaponID, LauncherID) && IsValidMissile(VehicleID, WeaponID, LauncherID, MissileID, MissileNum))
			{
				msgSend->SetOrderID(ORD_MISTRAL_FIRE);
				GetGameManager()->SendNetworkMessage(*msgSend.get());
				GetGameManager()->SendMessage(*msgSend.get());
			}
			else
				std::cout<<"Reload Mistral " <<VehicleID<< "-"<<WeaponID<<"-"<<LauncherID<<"-"<<MissileID<<"-"<<MissileNum<<std::endl;
		}
		else
		if( OrderMessage == ORD_MISTRAL_DIRECT_LR )
		{
			//std::cout << "Event Mistral LR From Joystick - " <<VehicleID<<WeaponID<<LauncherID<< std::endl;
			if (IsValidLauncher(VehicleID, WeaponID, LauncherID) == true)
			{
				msgSend->SetOrderID(ORD_MISTRAL_DIRECT_LR);
				GetGameManager()->SendNetworkMessage(*msgSend.get());
				GetGameManager()->SendMessage(*msgSend.get());

				//kirim ke aplikasi 2D
				spSetMistral spMistral;
				spMistral.ShipID = (int) MsgTDS.GetVehicleID();
				spMistral.mWeaponID = (int) MsgTDS.GetWeaponID();
				spMistral.mLauncherID = (int) MsgTDS.GetLauncherID();
				spMistral.mMissileID = (int) MsgTDS.GetMissileID();
				spMistral.mMissileNum = (int) MsgTDS.GetMissileNum();
				spMistral.OrderID = ORD_MISTRAL_DIRECT_LR;
				spMistral.mTargetBearing = MsgTDS.GetTargetBearing();
				spMistral.mTargetRange = 0;
				spMistral.mTargetElev = MsgTDS.GetTargetElev();
				SendClientEx(structSetMistral, (char *)&spMistral);

				std::cout << "Send to 2D ORD_MISTRAL_DIRECT_LR" <<std::endl;
			}
			else
				std::cout << "Not Valid Launcher" <<std::endl;
		}
		else
		if( OrderMessage == ORD_MISTRAL_DIRECT_UD )
		{
			if (IsValidLauncher(VehicleID, WeaponID, LauncherID))
			{
				msgSend->SetOrderID(ORD_MISTRAL_DIRECT_UD);
				GetGameManager()->SendNetworkMessage(*msgSend.get());
				GetGameManager()->SendMessage(*msgSend.get());

				//kirim ke aplikasi 2D
				spSetMistral spMistral;
				spMistral.ShipID = (int) MsgTDS.GetVehicleID();
				spMistral.mWeaponID = (int) MsgTDS.GetWeaponID();
				spMistral.mLauncherID = (int) MsgTDS.GetLauncherID();
				spMistral.mMissileID = (int) MsgTDS.GetMissileID();
				spMistral.mMissileNum = (int) MsgTDS.GetMissileNum();
				spMistral.OrderID = ORD_MISTRAL_DIRECT_UD;
				spMistral.mTargetBearing = MsgTDS.GetTargetBearing();
				spMistral.mTargetRange = 0;
				spMistral.mTargetElev = MsgTDS.GetTargetElev();
				SendClientEx(structSetMistral, (char *)&spMistral);

				std::cout << "Send to 2D ORD_MISTRAL_DIRECT_UD" <<std::endl;
			}
			else
				std::cout << "Not Valid Launcher" <<std::endl;
		}
	}
	else if (msg.GetMessageType() == SimMessageType::STRELA_EVENT)
	{
		const MsgSetStrela &MsgTDS = static_cast<const MsgSetStrela&>(msg);

		int VehicleID	 = (int) MsgTDS.GetVehicleID();
		int WeaponID	 = (int) MsgTDS.GetWeaponID();
		int LauncherID	 = (int) MsgTDS.GetLauncherID();
		int MissileID	 = (int) MsgTDS.GetMissileID();
		int MissileNum	 = (int) MsgTDS.GetMissileNum();
		int OrderMessage = MsgTDS.GetOrderID();

		dtCore::RefPtr<MsgSetStrela> msgSend;
		GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::STRELA_EVENT, msgSend);
		msgSend->SetVehicleID(VehicleID);
		msgSend->SetWeaponID(WeaponID);
		msgSend->SetLauncherID(LauncherID);
		msgSend->SetMissileID(MissileID);
		msgSend->SetMissileNum(MissileNum);
		msgSend->SetTargetBearing(MsgTDS.GetTargetBearing()); 

		if( OrderMessage == ORD_STRELA_DIRECT_F )
		{
			//std::cout << "Event Strella From Joystick" << std::endl;
			//CheckValidMissiles(VehicleID, WeaponID, LauncherID , MissileID, MissileNum );

			if (IsValidLauncher(VehicleID, WeaponID, LauncherID) && IsValidMissile(VehicleID, WeaponID, LauncherID, MissileID, MissileNum))
			{
				msgSend->SetOrderID(ORD_STRELA_FIRE);
				GetGameManager()->SendNetworkMessage(*msgSend.get());
				GetGameManager()->SendMessage(*msgSend.get());
			}
			else
				std::cout<<"Reload Strela " <<VehicleID<< "-"<<WeaponID<<"-"<<LauncherID<<"-"<<MissileID<<"-"<<MissileNum<<std::endl;
		}
		else
		if( OrderMessage == ORD_STRELA_DIRECT_LR )
		{
			if (IsValidLauncher(VehicleID, WeaponID, LauncherID))
			{
				msgSend->SetOrderID(ORD_STRELA_DIRECT_LR);
				GetGameManager()->SendNetworkMessage(*msgSend.get());
				GetGameManager()->SendMessage(*msgSend.get());

				//kirim ke aplikasi 2D
				spSetStrela spStrela;
				spStrela.ShipID = (int) MsgTDS.GetVehicleID();
				spStrela.mWeaponID = (int) MsgTDS.GetWeaponID();
				spStrela.mLauncherID = (int) MsgTDS.GetLauncherID();
				spStrela.mMissileID = (int) MsgTDS.GetMissileID();
				spStrela.mMissileNum = (int) MsgTDS.GetMissileNum();
				spStrela.OrderID = ORD_STRELA_DIRECT_LR;
				spStrela.mTargetBearing = MsgTDS.GetTargetBearing();
				spStrela.mTargetRange = 0;
				spStrela.mTargetElev = MsgTDS.GetTargetElev();
				SendClientEx(structSetStrela, (char *)&spStrela);
			}			
		}
		else
		if( OrderMessage == ORD_STRELA_DIRECT_UD )
		{
			if (IsValidLauncher(VehicleID, WeaponID, LauncherID))
			{
				msgSend->SetOrderID(ORD_STRELA_DIRECT_UD);
				GetGameManager()->SendNetworkMessage(*msgSend.get());
				GetGameManager()->SendMessage(*msgSend.get());

				//kirim ke aplikasi 2D
				spSetStrela spStrela;
				spStrela.ShipID = (int) MsgTDS.GetVehicleID();
				spStrela.mWeaponID = (int) MsgTDS.GetWeaponID();
				spStrela.mLauncherID = (int) MsgTDS.GetLauncherID();
				spStrela.mMissileID = (int) MsgTDS.GetMissileID();
				spStrela.mMissileNum = (int) MsgTDS.GetMissileNum();
				spStrela.OrderID = ORD_STRELA_DIRECT_UD;
				spStrela.mTargetBearing = MsgTDS.GetTargetBearing();
				spStrela.mTargetRange = 0;
				spStrela.mTargetElev = MsgTDS.GetTargetElev();
				SendClientEx(structSetStrela, (char *)&spStrela);
			}
		}
	}
}

void CSocketServer::ProcessMessage(const dtGame::Message &msg)
{
	if (enableProcessMessage)
	{
		if (IsInvalidMessage(msg)){	return;	}
		if(msg.GetSource() != GetGameManager()->GetMachineInfo()) 
		{
			//LOG_INFO("Network message coming..");
			HandleNetworkMessage(msg);
		}
		else 
		{
			HandleLocalMessage(msg);
		}

		if (msg.GetMessageType() == dtGame::MessageType::TICK_LOCAL)
		{
			const dtGame::TickMessage &tick = static_cast<const dtGame::TickMessage&>(msg);
			float deltaSimTime = tick.GetDeltaSimTime();

			takeReloSockData(deltaSimTime);
		}
	}

}

void CSocketServer::RegisterProcedure(unsigned short int aID, void(CSocketServer::*proc)(void*, int, Socket*), unsigned int aSize)
{
  if (aID>= vecSize.capacity())
  {
    vecProc.resize(aID+1, 0);
    vecSize.resize(aID+1, 0);
  }
  vecProc[aID]= proc;
  vecSize[aID]= aSize;
}

void CSocketServer::handlePacketPosition(void *pStruct, int pSize, Socket *pSocket)
{
	spPosition sPos;

	CopyMemory(&sPos, pStruct, pSize);
	std::ostringstream ost;

	dtCore::RefPtr<MsgPosition> MsgPosition;
	GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::POSITION_EVENT, MsgPosition);

	MsgPosition->SetVehicleID((unsigned int)sPos.ShipID);
	MsgPosition->SetOrderID(ORD_SETPOS);
	//MsgPosition->SetPosXValue((sPos.x- C_RELATIVE_X)* DEF_DEGREE_TO_METRE);
	//MsgPosition->SetPosYValue((sPos.y- C_RELATIVE_Y)* DEF_DEGREE_TO_METRE);
	//float z= sPos.z* DEF_FEET_TO_METER;
	//MsgPosition->SetPosZValue(z);

	dtTerrain::GeoCoordinates coord;
	coord.SetLongitude(sPos.x);
	coord.SetLatitude(sPos.y);

	std::cout<<"set position:"<<std::endl;
	std::cout<<"  long:"<< sPos.x <<std::endl;
	std::cout<<"  lat :"<< sPos.y<<std::endl;
	std::cout<<"  heading :"<< sPos.heading<<std::endl;

	MsgPosition->SetPosXValue((coord.GetCartesianPoint())[0]);
	MsgPosition->SetPosYValue((coord.GetCartesianPoint())[1]);
	//MsgPosition->SetPosZValue((coord.GetCartesianPoint())[2]);
	MsgPosition->SetPosZValue(sPos.z);
	MsgPosition->SetPosHValue(sPos.heading);
	MsgPosition->SetSpeedValue(sPos.speed);

	// send local message
	GetGameManager()->SendNetworkMessage(*MsgPosition.get());
	GetGameManager()->SendMessage(*MsgPosition.get());
}

void CSocketServer::handlePacketOrder(void *pStruct, int pSize, Socket *pSocket)
{
	spOrder sord;

	CopyMemory(&sord, pStruct, pSize); 
	
	//Update Fog
	if ( sord.OrderID == ORD_ENVI )
	{
		SimDBConnection* cdb= static_cast<SimDBConnection*>(GetGameManager()->GetComponentByName("Database Connection"));
		if( cdb!= NULL) 
		{
			bool isDatabaseConnected = cdb->isDatabaseConnected();
			if ( isDatabaseConnected ) 
			{
				std::cout<< "Change Fog Height!" <<std::endl;
				dtCore::RefPtr<MsgOceanControl> OceanCtrl;
				GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::OCEAN_CONTROL, OceanCtrl);

				// set message property
				OceanCtrl->SetOrderID(ORD_OCEAN_ABOVE_FOG_HEIGHT_CHANGE);
				OceanCtrl->SetFloatValue(sord.value);
				GetGameManager()->SendNetworkMessage(*OceanCtrl.get());
				GetGameManager()->SendMessage(*OceanCtrl.get());
			}
		}
	} 
	//Update Sea State
	else
	if ( sord.OrderID == ORD_SEA_STATE )
	{
		SimDBConnection* cdb= static_cast<SimDBConnection*>(GetGameManager()->GetComponentByName("Database Connection"));
		if( cdb!= NULL) 
		{
			bool isDatabaseConnected = cdb->isDatabaseConnected();
			if ( isDatabaseConnected ) 
			{
				std::cout<< "Change Sea State!" <<std::endl;
				dtCore::RefPtr<MsgOceanControl> OceanCtrl;
				GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::OCEAN_CONTROL, OceanCtrl);

				// set message property
				OceanCtrl->SetOrderID(ORD_OCEAN_SEA_STATE_CHANGE);
				OceanCtrl->SetIntValue(sord.value);
				GetGameManager()->SendNetworkMessage(*OceanCtrl.get());
				GetGameManager()->SendMessage(*OceanCtrl.get());
			}
		}
    } 
	//Update All Envi For Calculating 
	else 
	if (( sord.OrderID == ORD_HUMIDITY )      ||
		( sord.OrderID == ORD_TEMPERATURE )	  ||	
		( sord.OrderID == ORD_CURSPEED )	  ||
		( sord.OrderID == ORD_WINDSPEED )	  ||
		( sord.OrderID == ORD_WINDDIRECTION ) ||
		( sord.OrderID == ORD_CURDIRECTION )  ||
		( sord.OrderID == ORD_BAROPRESSURE))
	{
		std::cout<< "Change Environment" <<std::endl;
		dtCore::RefPtr<MsgOceanControl> OceanCtrl;
		GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::OCEAN_CONTROL, OceanCtrl);
		OceanCtrl->SetOrderID(sord.OrderID);
		OceanCtrl->SetFloatValue(sord.value);
		GetGameManager()->SendNetworkMessage(*OceanCtrl.get());
		GetGameManager()->SendMessage(*OceanCtrl.get());
	}
	else
    {   
		if ((unsigned int)sord.modeGuidance == 9)
		{
			//push vector waypoint
			PWaypoint* pw = new PWaypoint();
			pw->x = sord.x;
			pw->y = sord.y;
			pw->z = sord.z;

			pWayp.push_back(pw);
		}
		else if ((unsigned int)sord.modeGuidance == 14)
		{
			//delete vector
			pWayp.clear();
		}
		else
		{
			//play vector
			dtCore::RefPtr<MsgOrder> orderMsg;
			GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::ORDER_EVENT, orderMsg);

			orderMsg->SetVehicleID((unsigned int)sord.ShipID);
			orderMsg->SetOrderID((unsigned int)sord.OrderID);
			orderMsg->SetFloatValue(sord.value);
			orderMsg->SetModeGuidance((unsigned int)sord.modeGuidance);
			orderMsg->SetModeAltitude( 2 );

			GetGameManager()->SendNetworkMessage(*orderMsg.get());
			GetGameManager()->SendMessage(*orderMsg.get());
		}

		std::cout << "ship id : " << (unsigned int) sord.ShipID <<std::endl;
		std::cout << "OrderID : " << (unsigned int) sord.OrderID <<std::endl;
		std::cout << "modeGuidance : " << (unsigned int) sord.modeGuidance <<std::endl;
		std::cout << "x : " << sord.x <<std::endl;
		std::cout << "y : " << sord.y <<std::endl;
		std::cout << "z : " << sord.z <<std::endl;
	}	
}

void CSocketServer::handlePacketActorController( void *pStruct, int pSize, Socket *pSocket )
{
	spActorsController sp;

	CopyMemory(&sp, pStruct, pSize);

	dtCore::RefPtr<MsgActorsControl> Msg;
	GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::ACTORS_CONTROL, Msg);

	int ActTipe = sp.TipeID ;

	if ( ActTipe == TIPE_MISC_RANJAU )
	{
		dtTerrain::GeoCoordinates coord;
		  coord.SetLongitude(sp.x);
		  coord.SetLatitude(sp.y);

		Msg->SetVehicleID(sp.VehicleID);
		Msg->SetTipeID(sp.TipeID);
		Msg->SetOrderID(sp.OrderID);
		Msg->SetActorRuntimeID1(sp.ActorRuntimeID1);
		Msg->SetActorRuntimeID2(sp.ActorRuntimeID2);
		Msg->SetPosXValue((coord.GetCartesianPoint())[0]);
		Msg->SetPosYValue((coord.GetCartesianPoint())[1]);
		Msg->SetPosZValue(sp.z);
		Msg->SetPosHValue(sp.h);
		Msg->SetPosPValue(sp.p);
		Msg->SetPosRValue(sp.r);

		std::cout<<"  long:"<< sp.x <<std::endl;
		std::cout<<"  lat :"<< sp.y<<std::endl;

	} else
	{
		Msg->SetVehicleID(sp.VehicleID);
		Msg->SetTipeID(sp.TipeID);
		Msg->SetOrderID(sp.OrderID);
		Msg->SetActorRuntimeID1(sp.ActorRuntimeID1);
		Msg->SetActorRuntimeID2(sp.ActorRuntimeID2);
		Msg->SetActorRuntimeID3(sp.ActorRuntimeID3);
		Msg->SetActorRuntimeID4(sp.ActorRuntimeID4);
		Msg->SetPosXValue(sp.x);
		Msg->SetPosYValue(sp.y);
		Msg->SetPosZValue(sp.z); 
		Msg->SetPosHValue(sp.h);
		Msg->SetPosPValue(sp.p);
		Msg->SetPosRValue(sp.r);
	}
	GetGameManager()->SendNetworkMessage(*Msg.get());
	GetGameManager()->SendMessage(*Msg.get());
}

void CSocketServer::handlePacketUtilityAndTools( void *pStruct, int pSize, Socket *pSocket )
{
	spUtilityTools sp;
	CopyMemory(&sp, pStruct, pSize);

	bool is3DServer = false ;
	int orderID = int(sp.OrderID) ;

	if ( orderID == TIPE_UTIL_CAM_OBSERVER )
	{
		int observerID, weaponID , shipID, launcherID, missileID, missileNum, eventID;
		shipID			= int(sp.c0); 
		weaponID		= int(sp.c1);   /// objectTypeID ( ship, submarine, missile , misc )
		launcherID		= int(sp.c2); 
		missileID		= int(sp.c3); 
		missileNum		= int(sp.c4); 
		observerID		= int(sp.c5);   /// observerID   ( observer-1, observer-2, observer-3 , observer-4 )
		eventID			= int(sp.c6);
		  
		if ( observerID <= 0 ) /// server3D 
		{
			std::cout << "Get Message Observer. Config :: :: shipID = "<< shipID 
					<<" weaponID = "<< weaponID <<" launcherID = "<< launcherID 
					<<" missileID = "<< missileID 
					<<" missileNum = "<< missileNum << std::endl;
			
			SimServerClientComponent* simSC = static_cast<SimServerClientComponent*> (GetGameManager()->GetComponentByName(C_COMP_SERVER_CLIENT_CTRL));
			if ( simSC != NULL )
			{
				simSC->SetObserverFocus(shipID,weaponID,launcherID,missileID,missileNum,eventID);
				is3DServer = true ;
			}
		}  
	}
	// - Order ID RUN PROCESS MESSAGE [7/18/2014 EKA]
	else if (orderID == TIPE_UTIL_RUN_PROCESS_MESSAGE)
	{
		std::cout << "RUN PROCESS MESSAGE" << std::endl;
		SimActorControl* simCtrl = static_cast<SimActorControl*> (GetGameManager()->GetComponentByName(C_COMP_ACTOR_CONTROLLER));
		if ( simCtrl != NULL )
			simCtrl->enableProcessMessage = true;

		SimServerMessage* simSM = static_cast<SimServerMessage*> (GetGameManager()->GetComponentByName(C_COMP_SERVER_MESSAGE));
		if ( simSM != NULL )
			simSM->enableProcessMessage = true;

		SimDBConnection* cdb= static_cast<SimDBConnection*>(GetGameManager()->GetComponentByName(C_COMP_DB_CONNECTION));
		if( cdb!= NULL)
			cdb->enableProcessMessage = true;

		SimEnvironmentDataBase* simEnviDB = dynamic_cast<SimEnvironmentDataBase*> (GetGameManager()->GetComponentByName(C_COMP_ENVI_DB));
		if (simEnviDB != NULL)
			simEnviDB->enableProcessMessage = true;

		CanonHandle* ch = dynamic_cast<CanonHandle*> (GetGameManager()->GetComponentByName(C_COMP_ACTOR_CANON));
		if (ch != NULL)
			ch->enableProcessMessage = true;

		InputComponent* ic = dynamic_cast<InputComponent*> (GetGameManager()->GetComponentByName("SimServerInputComponent"));
		if (ic != NULL)
			ic->enableProcessMessage = true;

		/*CSocketServer* css = dynamic_cast<CSocketServer*> (GetGameManager()->GetComponentByName("SocketServer"));
		if (css != NULL)
			css->enableProcessMessage = true;*/

	}
	 
	if ( !is3DServer )
	{
		dtCore::RefPtr<MsgUtilityAndTools> Msg;
		GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::UTILITY_AND_TOOLS, Msg);

		Msg->SetOrderID(sp.OrderID);
		Msg->SetUAT0(int(sp.c0));
		Msg->SetUAT1(int(sp.c1));
		Msg->SetUAT2(int(sp.c2));
		Msg->SetUAT3(int(sp.c3));
		Msg->SetUAT4(int(sp.c4));
		Msg->SetUAT5(int(sp.c5));
		Msg->SetUAT6(int(sp.c6));

		GetGameManager()->SendNetworkMessage(*Msg.get());
		GetGameManager()->SendMessage(*Msg.get());
	}
}


void CSocketServer::handlePacketSetAsrock(void *pStruct, int pSize, Socket *pSocket)
{
	spSetAsrock sSet;
	CopyMemory(&sSet, pStruct, pSize);
	
	int mShipID = (unsigned int)sSet.ShipID;
	int mWeaponID = (unsigned int)sSet.mWeaponID;
	int mLauncherID = (unsigned int)sSet.mLauncherID;
	int mMissileID = (unsigned int)sSet.mMissileID;
	int mMissileNum = (unsigned int)sSet.mMissileNum;
	int orderID = (unsigned int)sSet.OrderID;

	std::cout << "-------------------------------------------" << std::endl;
	std::cout << "vehicle = " << mShipID << std::endl;
	std::cout << "launcher = " << mLauncherID << std::endl;
	std::cout << "weapon = "<< mWeaponID << std::endl;
	std::cout << "mMissileID = " << mMissileID << std::endl;
	std::cout << "mMissileNum = " << mMissileNum << std::endl;
	std::cout << "bearing = " << sSet.mTargetBearing << std::endl;
	std::cout << "depth = " << sSet.mTargetDepth << std::endl;
	std::cout << "range = " << sSet.mTargetRange << std::endl;
	std::cout << "orderid = " << orderID << std::endl;
	std::cout << "fuze = " << sSet.fuze << std::endl;
	std::cout << "type = " << sSet.mMissileType << std::endl;
	std::cout << "target id = " << sSet.TargetShipID << std::endl;
	std::cout << "correct range = " << sSet.mCorrectRange <<std::endl;
	std::cout << "-------------------------------------------" << std::endl;


	if( orderID == ORD_ASROCK )
	{
		if ((IsValidLauncher(mShipID, mWeaponID, mLauncherID)==true) && 
			(IsValidMissile(mShipID,mWeaponID,mLauncherID,mMissileID,mMissileNum)==true))
		{
			dtCore::RefPtr<MsgSetAsrock> Msg = NULL;;
			GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::ASROCK_EVENT, Msg);
			Msg->SetVehicleID(mShipID);
			Msg->SetWeaponID(mWeaponID);
			Msg->SetLauncherID(mLauncherID);
			Msg->SetMissileID(mMissileID);
			Msg->SetMissileNum(mMissileNum);
			Msg->SetOrderID(orderID);
			Msg->SetTargetBearing(sSet.mTargetBearing);
			Msg->SetTargetRange(sSet.mTargetRange);
			Msg->SetMissileType(sSet.mMissileType);
			Msg->SetTargetDepth(sSet.mTargetDepth);
			Msg->SetMissileFuze(sSet.fuze);
			Msg->SetTargetID(sSet.TargetShipID);
			Msg->SetCorrectRange(sSet.mCorrectRange);

			GetGameManager()->SendNetworkMessage(*Msg);
			GetGameManager()->SendMessage(*Msg);

			/* CAMERA UTIL (dibuat player)*/
			std::cout << "Send Message for firing lock" << std::endl;
			dtCore::RefPtr<MsgUtilityAndTools> MsgCam;
			GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::UTILITY_AND_TOOLS, MsgCam);
			MsgCam->SetOrderID(TIPE_UTIL_PLAYER_SETTING);
			MsgCam->SetUAT0(0);
			MsgCam->SetUAT1(PLAYER_SET_FIRING_LOCK);
			MsgCam->SetUAT2(mShipID);
			MsgCam->SetUAT3(mWeaponID);
			MsgCam->SetUAT4(mLauncherID);
			MsgCam->SetUAT5(mMissileID);
			MsgCam->SetUAT6(mMissileNum);
			GetGameManager()->SendNetworkMessage(*MsgCam);   					
			GetGameManager()->SendMessage(*MsgCam); 
		}
		else
			std::cout << "You Must Reload Asroc" << std::endl;

	}
	else if (orderID == ORD_ASROCK_RELOAD)
	{
		if (IsValidLauncher(mShipID, mWeaponID, mLauncherID)==true)
		{
			SimActorControl* simCtrl = static_cast<SimActorControl*> (GetGameManager()->GetComponentByName(C_COMP_ACTOR_CONTROLLER));
			if ( simCtrl != NULL )
			{
				dtCore::RefPtr<dtDAL::ActorProxy> ap = simCtrl->GetMissileActors(mShipID,mWeaponID,mLauncherID,mMissileID, mMissileNum );
				if(!ap.valid())
				{
					simCtrl->CreateMissileActors(mShipID,mWeaponID,mLauncherID,mMissileID, mMissileNum );

					dtCore::RefPtr<MsgSetAsrock> Msg = NULL;;
					GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::ASROCK_EVENT, Msg);
					Msg->SetVehicleID(mShipID);
					Msg->SetWeaponID(mWeaponID);
					Msg->SetLauncherID(mLauncherID);
					Msg->SetMissileID(mMissileID);
					Msg->SetMissileNum(mMissileNum);
					Msg->SetOrderID(orderID);
					Msg->SetTargetBearing(sSet.mTargetBearing);
					Msg->SetTargetRange(sSet.mTargetRange);
					Msg->SetMissileType(sSet.mMissileType);
					Msg->SetTargetDepth(sSet.mTargetDepth);
					Msg->SetMissileFuze(sSet.fuze);
					Msg->SetTargetID(sSet.TargetShipID);
					Msg->SetCorrectRange(sSet.mCorrectRange);

					GetGameManager()->SendNetworkMessage(*Msg);
					GetGameManager()->SendMessage(*Msg);
				}
			}
		}
		else
			std::cout << "Not Valid Launcher" << std::endl;
	}
	else if (orderID == ORD_ASROCK_STATUS_ON)
	{
		CheckValidLaunchers(mShipID, mWeaponID, mLauncherID);
	}
	else if (orderID == ORD_ASROCK_STATUS_OFF)
	{
		SimActorControl* simCtrl = static_cast<SimActorControl*> (GetGameManager()->GetComponentByName(C_COMP_ACTOR_CONTROLLER));
		if ( simCtrl != NULL )
		{
			for (int iloop=1; iloop<=2; iloop++)
				if (IsValidMissile(mShipID,mWeaponID,mLauncherID,iloop,1))
					SetMissileStatus(mShipID,mWeaponID,mLauncherID,iloop,1,ST_MISSILE_DEL);

			dtCore::RefPtr<dtDAL::ActorProxy> aps = simCtrl->GetLauncherActors(C_WEAPON_TYPE_SPOUT,mShipID,mWeaponID,mLauncherID );
			if(aps.valid())
			{
				simCtrl->DeleteLauncherActors(C_WEAPON_TYPE_SPOUT, mShipID, mWeaponID, mLauncherID);
			}

			dtCore::RefPtr<dtDAL::ActorProxy> apb = simCtrl->GetLauncherActors(C_WEAPON_TYPE_BODY,mShipID,mWeaponID,mLauncherID );
			if(apb.valid())
			{
				simCtrl->DeleteLauncherActors(C_WEAPON_TYPE_BODY, mShipID, mWeaponID, mLauncherID);

				//harus nya di onremovedfromworld launcherbodyactor.cpp
				dtCore::RefPtr<dtDAL::ActorProxy> parentProxy = simCtrl->GetShipActorByID(mShipID);
				ShipModelActor* shp  = static_cast<ShipModelActor*>(parentProxy->GetActor());
				LauncherBodyActor* lba = static_cast<LauncherBodyActor*>(apb->GetActor());
				if (shp!= NULL) {
					shp->SetSwitchWeaponOFF(lba->GetIndexSwitchWeaponParents(), true);
					shp->GetGameActorProxy().NotifyFullActorUpdate();
				}
			}
		}
	}
	else
	{
		//yoga check
		if (IsValidLauncher(mShipID, mWeaponID, mLauncherID)==true)
		{
			//Set Target ID 
			std::vector<dtDAL::ActorProxy*> gaps;
			GetGameManager()->FindActorsByType(*(GetGameManager()->FindActorType(C_ACTOR_CAT, C_CN_PLAYER)), gaps);
			if(gaps.size() > 0 ) 
			{
				dtCore::RefPtr<dtGame::GameActorProxy> gap= static_cast<dtGame::GameActorProxy*>(gaps[0]);
				if ( gap!= NULL )
				{
					dtCore::RefPtr<PlayerActor> Player = static_cast<PlayerActor*>(gap->GetActor());
					Player->SetTargetIDAsrock(sSet.TargetShipID);
				}
			}

			dtCore::RefPtr<MsgSetAsrock> Msg = NULL;;
			GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::ASROCK_EVENT, Msg);
			Msg->SetVehicleID(mShipID);
			Msg->SetWeaponID(mWeaponID);
			Msg->SetLauncherID(mLauncherID);
			Msg->SetMissileID(mMissileID);
			Msg->SetMissileNum(mMissileNum);
			Msg->SetOrderID(orderID);
			Msg->SetTargetBearing(sSet.mTargetBearing);
			Msg->SetTargetRange(sSet.mTargetRange);
			Msg->SetMissileType(sSet.mMissileType);
			Msg->SetTargetDepth(sSet.mTargetDepth);
			Msg->SetMissileFuze(sSet.fuze);
			Msg->SetTargetID(sSet.TargetShipID);
			Msg->SetCorrectRange(sSet.mCorrectRange);

			GetGameManager()->SendNetworkMessage(*Msg);
			GetGameManager()->SendMessage(*Msg);



		}
	}
}


void CSocketServer::handlePacketSetRBU(void *pStruct, int pSize, Socket *pSocket)
{
	spSetRBU sSet;
	CopyMemory(&sSet, pStruct, pSize);
	
	int mShipID = (unsigned int)sSet.ShipID;
	int mWeaponID = (unsigned int)sSet.mWeaponID;
	int mLauncherID = (unsigned int)sSet.mLauncherID; 
	int mMissileID = (unsigned int)sSet.mMissileID;
	int mMissileNum = (unsigned int)sSet.mMissileNum;
	int orderID = (unsigned int)sSet.OrderID;

	int mMissileType = (unsigned int)sSet.mMissileType;
	int TargetShipID = (unsigned int)sSet.TargetShipID;
	int CountRBU = (unsigned int)sSet.CountRBU;

	float mTargetBearing = (float)sSet.mTargetBearing;
	float mTargetRange = (float)sSet.mTargetRange;
	float correctBearing = (float)sSet.correctBearing;
	float correctElevation = (float)sSet.correctElevation;
	float mTargetDepth = (float)sSet.mTargetDepth;

	std::cout << "-------------------------------------------" << std::endl;
	std::cout << "shipID = " << mShipID <<std::endl;
	std::cout << "mWeaponID = " << mWeaponID <<std::endl;
	std::cout << "mLauncherID = " << mLauncherID <<std::endl;
	std::cout << "mMissileID = " << mMissileID <<std::endl;
	std::cout << "mMissileNum = " << mMissileNum <<std::endl;
	std::cout << "orderID = " << orderID <<std::endl;
	std::cout << "bearing = " << mTargetBearing <<std::endl;
	std::cout << "range = " << mTargetRange <<std::endl;
	std::cout << "depth = " << mTargetDepth <<std::endl;
	std::cout << "type = " << mMissileType <<std::endl;
	std::cout << "target id = " << TargetShipID <<std::endl;
	std::cout << "count rbu = " << CountRBU<<std::endl;
	std::cout << "corectbearing = " << correctBearing <<std::endl;
	std::cout << "correct elev = " << correctElevation <<std::endl;
	std::cout << "-------------------------------------------" << std::endl;
 
	if (orderID == ORD_RBU_FIRE)
	{
		if ((IsValidLauncher(mShipID,mWeaponID,mLauncherID)==true) && (IsValidMissile(mShipID,mWeaponID,mLauncherID,mMissileID,mMissileNum)==true))
		{
			dtCore::RefPtr<MsgSetRBU> Msg = NULL;
			GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::RBU_EVENT, Msg);

			Msg->SetVehicleID(mShipID);
			Msg->SetWeaponID(mWeaponID);
			Msg->SetLauncherID(mLauncherID);
			Msg->SetMissileID(mMissileID);
			Msg->SetMissileNum(mMissileNum);
			Msg->SetOrderID(orderID);
			Msg->SetTargetBearing(mTargetBearing);
			Msg->SetTargetRange(mTargetRange);
			Msg->SetMissileType(mMissileType);
			Msg->SetTargetID(TargetShipID);
			Msg->SetCountRBU(CountRBU);
			Msg->SetCorrectBearing(correctBearing);
			Msg->SetCorrectElev(correctElevation);
			Msg->SetTargetDepth(mTargetDepth);
				
			//SimActorControl* simCtrl = static_cast<SimActorControl*> (GetGameManager()->GetComponentByName(C_COMP_ACTOR_CONTROLLER));
			//
			////untuk camera RBU salvo
			//if (CountRBU == 1)
			//{
			//	simCtrl->count_1 = true;
			//	simCtrl->count_4 = false;
			//	simCtrl->count_8 = false;
			//	simCtrl->count_12 = false;
			//}
			//else if (CountRBU == 4)
			//{
			//	simCtrl->count_1 = false;
			//	simCtrl->count_4 = true;
			//	simCtrl->count_8 = false;
			//	simCtrl->count_12 = false;
			//}
			//else if (CountRBU == 8)
			//{
			//	simCtrl->count_1 = false;
			//	simCtrl->count_4 = false;
			//	simCtrl->count_8 = true;
			//	simCtrl->count_12 = false;
			//}
			//else if (CountRBU == 12)
			//{
			//	simCtrl->count_1 = false;
			//	simCtrl->count_4 = false;
			//	simCtrl->count_8 = false;
			//	simCtrl->count_12 = true;
			//}

			GetGameManager()->SendNetworkMessage(*Msg);   	
			GetGameManager()->SendMessage(*Msg);

			/* CAMERA UTIL (dibuat player)*/
			std::cout << "Send Message for firing lock" << std::endl;
			dtCore::RefPtr<MsgUtilityAndTools> MsgCam;
			GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::UTILITY_AND_TOOLS, MsgCam);
			MsgCam->SetOrderID(TIPE_UTIL_PLAYER_SETTING);
			MsgCam->SetUAT0(0);
			MsgCam->SetUAT1(PLAYER_SET_FIRING_LOCK);
			MsgCam->SetUAT2(mShipID);
			MsgCam->SetUAT3(mWeaponID);
			MsgCam->SetUAT4(mLauncherID);
			MsgCam->SetUAT5(mMissileID);
			MsgCam->SetUAT6(mMissileNum);
			GetGameManager()->SendNetworkMessage(*MsgCam);   					
			GetGameManager()->SendMessage(*MsgCam); 
		}
		else
			std::cout << "You Must Reload RBU launcher or missile" << std::endl;
	}
	else if ((orderID == ORD_RBU_ASSIGNED) || (orderID == ORD_RBU_DEASSIGNED) || ( orderID == ORD_RBU_AUTO ))
	{
		if (IsValidLauncher(mShipID,mWeaponID,mLauncherID)==true)
		{
			// create order event message
			dtCore::RefPtr<MsgSetRBU> Msg = NULL;
			GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::RBU_EVENT, Msg);

			Msg->SetVehicleID(mShipID);
			Msg->SetWeaponID(mWeaponID);
			Msg->SetLauncherID(mLauncherID);
			Msg->SetMissileID(mMissileID);
			Msg->SetMissileNum(mMissileNum);
			Msg->SetOrderID(orderID);
			Msg->SetTargetBearing(mTargetBearing);
			Msg->SetTargetRange(mTargetRange);
			Msg->SetMissileType(mMissileType);
			Msg->SetTargetID(TargetShipID);
			Msg->SetCountRBU(CountRBU);
			Msg->SetCorrectBearing(correctBearing);
			Msg->SetCorrectElev(correctElevation);
			Msg->SetTargetDepth(mTargetDepth);

			GetGameManager()->SendNetworkMessage(*Msg);   	
			GetGameManager()->SendMessage(*Msg);

			//Set Target ID 
			std::vector<dtDAL::ActorProxy*> gaps;
			GetGameManager()->FindActorsByType(*(GetGameManager()->FindActorType(C_ACTOR_CAT, C_CN_PLAYER)), gaps);
			if(gaps.size() > 0 ) 
			{
				dtCore::RefPtr<dtGame::GameActorProxy> gap= static_cast<dtGame::GameActorProxy*>(gaps[0]);
				if ( gap!= NULL )
				{
					dtCore::RefPtr<PlayerActor> Player = static_cast<PlayerActor*>(gap->GetActor());
					Player->SetTargetIDRBU(TargetShipID);
				}
			}
		}
		else
			std::cout << "You Must Reload RBU launcher" << std::endl;
	}
	else if (orderID == ORD_RBU_LOADING)
	{
		if (IsValidLauncher(mShipID,mWeaponID,mLauncherID)==true)
		{
			// Cara pintas @-@ ngeluuuuu [4/30/2013 DID RKT2]
			SimDBConnection* cdb= static_cast<SimDBConnection*>(GetGameManager()->GetComponentByName("Database Connection"));
			if( cdb!= NULL) {
				bool isDatabaseConnected = cdb->isDatabaseConnected();
				if ( isDatabaseConnected ) {
					SimActorMissileDef* missile = cdb->FindActorMissileDef(mShipID,mWeaponID,mLauncherID,mMissileID,mMissileNum) ;
					missile = cdb->GetNewDatabaseActorMissileDef(mShipID,mWeaponID,mLauncherID,mMissileID,mMissileNum) ;
				}
			}			

			SimActorControl* simCtrl = static_cast<SimActorControl*> (GetGameManager()->GetComponentByName(C_COMP_ACTOR_CONTROLLER));
			if ( simCtrl != NULL )
			{
				dtCore::RefPtr<MsgSetRBU> Msg = NULL;
				GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::RBU_EVENT, Msg);

				Msg->SetVehicleID(mShipID);
				Msg->SetWeaponID(mWeaponID);
				Msg->SetLauncherID(mLauncherID);
				Msg->SetMissileID(mMissileID);
				Msg->SetMissileNum(mMissileNum);
				Msg->SetOrderID(orderID);
				Msg->SetTargetBearing(mTargetBearing);
				Msg->SetTargetRange(mTargetRange);
				Msg->SetMissileType(mMissileType);
				Msg->SetTargetID(TargetShipID);
				Msg->SetCountRBU(CountRBU);
				Msg->SetCorrectBearing(correctBearing);
				Msg->SetCorrectElev(correctElevation);
				Msg->SetTargetDepth(mTargetDepth);

				GetGameManager()->SendNetworkMessage(*Msg);   	
				GetGameManager()->SendMessage(*Msg);

				simCtrl->SetFireRBU(mShipID, TargetShipID, mWeaponID ,mLauncherID ,true, CountRBU, mTargetDepth, mMissileType,mTargetRange,mTargetBearing, false);
			}
			else
				std::cout << "Not Valid simCtrl" << std::endl;
		}
		else
			std::cout << "You Must Reload RBU launcher" << std::endl;
	}
	else if (orderID == ORD_RBU_STARTF)
	{
		//if (IsValidMissile(mShipID, mWeaponID, mLauncherID, mMissileID, mMissileNum)==true)
		if ( IsValidLauncher(mShipID,mWeaponID,mLauncherID)==true )
		{
			SimActorControl* simCtrl = static_cast<SimActorControl*> (GetGameManager()->GetComponentByName(C_COMP_ACTOR_CONTROLLER));
			if ( simCtrl != NULL )
			{
				simCtrl->SetFireRBU(mShipID, TargetShipID, mWeaponID ,mLauncherID ,false, CountRBU, mTargetDepth, mMissileType,mTargetRange,mTargetBearing, true);

				/* CAMERA UTIL (dibuat player)*/
				std::cout << "Send Message for firing lock" << std::endl;
				dtCore::RefPtr<MsgUtilityAndTools> MsgCam;
				GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::UTILITY_AND_TOOLS, MsgCam);
				MsgCam->SetOrderID(TIPE_UTIL_PLAYER_SETTING);
				MsgCam->SetUAT0(0);
				MsgCam->SetUAT1(PLAYER_SET_FIRING_LOCK);
				MsgCam->SetUAT2(mShipID);
				MsgCam->SetUAT3(mWeaponID);
				MsgCam->SetUAT4(mLauncherID);
				MsgCam->SetUAT5(mMissileID);
				MsgCam->SetUAT6(mMissileNum);
				GetGameManager()->SendNetworkMessage(*MsgCam);   					
				GetGameManager()->SendMessage(*MsgCam); 
			}
			else
				std::cout << "Not Valid simCtrl" << std::endl;
		}
		else
			std::cout << "You Must Reload Launcher RBU" << std::endl;
	}
	else if (orderID == ORD_RBU_STATUS_ON)
	{
		CheckValidLaunchers(mShipID, mWeaponID, mLauncherID);
	}
	else if (orderID == ORD_RBU_STATUS_OFF)
	{
		SimActorControl* simCtrl = static_cast<SimActorControl*> (GetGameManager()->GetComponentByName(C_COMP_ACTOR_CONTROLLER));
		if ( simCtrl != NULL )
		{
			// Make Sure that missile also deleted [5/14/2013 DID RKT2]
			for (int iloop=1; iloop<=12; iloop++)
				if (IsValidMissile(mShipID,mWeaponID,mLauncherID,iloop,1))
					SetMissileStatus(mShipID,mWeaponID,mLauncherID,iloop,1,ST_MISSILE_DEL);

			dtCore::RefPtr<dtDAL::ActorProxy> aps = simCtrl->GetLauncherActors(C_WEAPON_TYPE_SPOUT,mShipID,mWeaponID,mLauncherID );
			if(aps.valid())
				simCtrl->DeleteLauncherActors(C_WEAPON_TYPE_SPOUT, mShipID, mWeaponID, mLauncherID);

			dtCore::RefPtr<dtDAL::ActorProxy> apb = simCtrl->GetLauncherActors(C_WEAPON_TYPE_BODY,mShipID,mWeaponID,mLauncherID );
			if(apb.valid())
			{
				simCtrl->DeleteLauncherActors(C_WEAPON_TYPE_BODY, mShipID, mWeaponID, mLauncherID);

				//harus nya di onremovedfromworld launcherbodyactor.cpp
				dtCore::RefPtr<dtDAL::ActorProxy> parentProxy = simCtrl->GetShipActorByID(mShipID);
				ShipModelActor* shp  = static_cast<ShipModelActor*>(parentProxy->GetActor());
				LauncherBodyActor* lba = static_cast<LauncherBodyActor*>(apb->GetActor());
				if (shp!= NULL) {
					shp->SetSwitchWeaponOFF(lba->GetIndexSwitchWeaponParents(), true); //launcher 1
					shp->GetGameActorProxy().NotifyFullActorUpdate();
				}
			}
		}
	}
}

void CSocketServer::handlePacketSetCannon(void *pStruct, int pSize, Socket *pSocket)
{
	spSetCannon sSet;
	CopyMemory(&sSet, pStruct, pSize);
	
	int mShipID = (unsigned int)sSet.ShipID;
	int mWeaponID = (unsigned int)sSet.mWeaponID;
	int mLauncherID = (unsigned int)sSet.mLauncherID;
	int mMissileID = (unsigned int)sSet.mMissileID;
	int mMissileNum = (unsigned int)sSet.mMissileNum;
	int orderID = (unsigned int)sSet.OrderID;
	int mModeID = (unsigned int)sSet.mModeID;
	int mTargetID = (unsigned int)sSet.mTargetID;
	int balistikID = (unsigned int)sSet.mBalistikID;
	int rateSalvoPerMinute = (unsigned int)sSet.mRateSalvoPerMinutes;

	std::cout << "-------------------------------------------" << std::endl;
	std::cout << "Ship ID : " << mShipID << std::endl;
	std::cout << "Weapon ID : " << mWeaponID << std::endl;
	std::cout << "Launcher ID : " << mLauncherID << std::endl;
	std::cout << "Missile ID : " << mMissileID << std::endl;
	std::cout << "Missile Number : " << mMissileNum << std::endl;
	std::cout << "Order ID : " << orderID << std::endl;
	std::cout << "Mode ID : " << mModeID << std::endl;
	std::cout << "Target ID : " << mTargetID << std::endl;
	std::cout << "Up Down : " << sSet.mUpDown << std::endl; 
	std::cout << "Correct Elev : " << sSet.mAutoCorrectElev << std::endl;
	std::cout << "Correct Bearing : " << sSet.mAutoCorrectBearing << std::endl;
	std::cout << "Balistik ID : " << balistikID << std::endl;
	std::cout << "Rate Salvo Per Minutes : " << rateSalvoPerMinute << std::endl;
	std::cout << "-------------------------------------------" << std::endl;

	if ( orderID == ORD_CANNON_START_F)
	{
		SimActorControl* simCtrl = static_cast<SimActorControl*> (GetGameManager()->GetComponentByName(C_COMP_ACTOR_CONTROLLER));
		if ( simCtrl != NULL )
		{
			simCtrl->isSalvoCannon = true;
			simCtrl->SetFireCannon(mShipID, mWeaponID ,mLauncherID ,true, rateSalvoPerMinute);
		}
	}
	else
	if ( orderID == ORD_CANNON_STOP_F)
	{
		SimActorControl* simCtrl = static_cast<SimActorControl*> (GetGameManager()->GetComponentByName(C_COMP_ACTOR_CONTROLLER));
		if ( simCtrl != NULL )
		{
			simCtrl->isSalvoCannon = false;
			simCtrl->SetFireCannon(mShipID, mWeaponID ,mLauncherID ,false, rateSalvoPerMinute);
		}
	}
	else
	if ( orderID == ORD_CANNON_ON)
	{
		CheckValidLaunchers(mShipID,mWeaponID,mLauncherID);
	}
	else
	if ( orderID == ORD_CANNON_OFF)
	{
		SimActorControl* simCtrl = static_cast<SimActorControl*> (GetGameManager()->GetComponentByName(C_COMP_ACTOR_CONTROLLER));
		if ( simCtrl != NULL )
		{
			/*for (int iloop=1; iloop<=4; iloop++)
				if (IsValidMissile(mShipID,mWeaponID,mLauncherID,iloop,1))
					SetMissileStatus(mShipID,mWeaponID,mLauncherID,iloop,1,ST_MISSILE_DEL);*/

			dtCore::RefPtr<dtDAL::ActorProxy> aps = simCtrl->GetLauncherActors(C_WEAPON_TYPE_SPOUT,mShipID,mWeaponID,mLauncherID );
			if(aps.valid())
			{
				simCtrl->DeleteLauncherActors(C_WEAPON_TYPE_SPOUT, mShipID, mWeaponID, mLauncherID);
			}

			dtCore::RefPtr<dtDAL::ActorProxy> apb = simCtrl->GetLauncherActors(C_WEAPON_TYPE_BODY,mShipID,mWeaponID,mLauncherID );
			if(apb.valid())
			{
				simCtrl->DeleteLauncherActors(C_WEAPON_TYPE_BODY, mShipID, mWeaponID, mLauncherID);

				//harus nya di onremovedfromworld launcherbodyactor.cpp
				dtCore::RefPtr<dtDAL::ActorProxy> parentProxy = simCtrl->GetShipActorByID(mShipID);
				ShipModelActor* shp  = static_cast<ShipModelActor*>(parentProxy->GetActor());
				LauncherBodyActor* lba = static_cast<LauncherBodyActor*>(apb->GetActor());
				if (shp!= NULL) {
					shp->SetSwitchWeaponOFF(lba->GetIndexSwitchWeaponParents(), true);
					shp->GetGameActorProxy().NotifyFullActorUpdate();
				}
			}
		}
	}
	else if ( orderID == ORD_CANNON_UNLOCK)
	{
		SimActorControl* simCtrl = static_cast<SimActorControl*> (GetGameManager()->GetComponentByName(C_COMP_ACTOR_CONTROLLER));
		if ( simCtrl != NULL )
		{
			dtCore::RefPtr<dtDAL::ActorProxy> ap = simCtrl->GetLauncherActors(C_WEAPON_TYPE_SPOUT,mShipID,mWeaponID,mLauncherID );
			if(ap.valid())
			{
				dtCore::RefPtr<CannonSpoutActor> Spout = static_cast<CannonSpoutActor*>(ap->GetActor());
				Spout->SetIsUnlockToFire(true);
				SetMissileStatus(mShipID,mWeaponID,mLauncherID,mMissileID,mMissileNum,ST_MISSILE_UNLOCK);
			}
		}
	}
	else if ( orderID == ORD_CANNON_LOCK)
	{
		SimActorControl* simCtrl = static_cast<SimActorControl*> (GetGameManager()->GetComponentByName(C_COMP_ACTOR_CONTROLLER));
		if ( simCtrl != NULL )
		{
			dtCore::RefPtr<dtDAL::ActorProxy> ap = simCtrl->GetLauncherActors(C_WEAPON_TYPE_SPOUT,mShipID,mWeaponID,mLauncherID );
			if(ap.valid())
			{
				dtCore::RefPtr<CannonSpoutActor> Spout = static_cast<CannonSpoutActor*>(ap->GetActor());
				Spout->SetIsUnlockToFire(false);
				SetMissileStatus(mShipID,mWeaponID,mLauncherID,mMissileID,mMissileNum,ST_MISSILE_LOCK);
			}
		}
	}
	else //if( orderID == ORD_CANNON_F ) deassign, dll
	{
		if (IsValidLauncher(mShipID,mWeaponID,mLauncherID))
		{
			dtCore::RefPtr<MsgSetCannon> Msg = NULL;
			GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::CANNON_EVENT, Msg);
			Msg->SetVehicleID(mShipID);
			Msg->SetWeaponID(mWeaponID);
			Msg->SetLauncherID(mLauncherID);
			Msg->SetMissileID(mMissileID);
			Msg->SetMissileNum(mMissileNum);
			Msg->SetOrderID(orderID);
			Msg->SetModeID(mModeID);
			Msg->SetTargetID(mTargetID);
			Msg->SetUpDown(sSet.mUpDown);
			Msg->SetAutoCorrectElev(sSet.mAutoCorrectElev);
			Msg->SetAutoCorrectBearing(sSet.mAutoCorrectBearing);
			Msg->SetBalistikID(balistikID);

			GetGameManager()->SendNetworkMessage(*Msg);   	
			GetGameManager()->SendMessage(*Msg); 
		}	
	}
}

void CSocketServer::handlePacketSetExocet40(void *pStruct, int pSize, Socket *pSocket)
{
	spSetExocetMM40 sSet;
	CopyMemory(&sSet, pStruct, pSize);

	int mShipID = (unsigned int)sSet.ShipID;
	int mWeaponID = (unsigned int)sSet.mWeaponID;
	int mLauncherID = (unsigned int)sSet.mLauncherID;
	int mMissileID = (unsigned int)sSet.mMissileID;
	int mMissileNum = (unsigned int)sSet.mMissileNum;
	int orderID = (unsigned int)sSet.OrderID;

	//Show Receive Socket
	std::cout << "-------------------------------------------" << std::endl;
	std::cout << "Vehicle ID : " << mShipID << std::endl;
	std::cout << "Weapon ID : " << mWeaponID <<std::endl;
	std::cout << "Launcher ID : " << mLauncherID <<std::endl;
	std::cout << "Missile ID : " << mMissileID << std::endl;
	std::cout << "Missile Number : " << mMissileNum <<std::endl;
	std::cout << "Order ID : " << (int) sSet.OrderID <<std::endl;
	std::cout << "Target Range : " << sSet.mTRange <<std::endl;
	std::cout << "Target bearing : " << sSet.mTBearing <<std::endl;
	std::cout << "Angular Mode : " << (int) sSet.mAngular_Mode <<std::endl;
	std::cout << "Agility Mode : " << (int) sSet.mAgility_Mode <<std::endl;
	std::cout << "Initial Step Mode : " << (int) sSet.mInitialStep_Mode <<std::endl;
	std::cout << "Obstacle Alt : " << sSet.mObstacle_Alt << std::endl;
	std::cout << "Obstacle Range : " << sSet.mObstacle_Range <<std::endl;
	std::cout << "Approach Range : " << sSet.mApproach_Range <<std::endl;
	std::cout << "Terminal Range : " << sSet.mTerminal_Range <<std::endl;
	std::cout << "Left Angle : " << sSet.mLAngle <<std::endl;
	std::cout << "Right Angle : " << sSet.mRAngle <<std::endl;
	std::cout << "Far Range : " << sSet.mFRange <<std::endl;
	std::cout << "Near Range : " << sSet.mNRange <<std::endl;
	std::cout << "Masking 1 : " << (int) sSet.mMasking_1 <<std::endl;
	std::cout << "Masking 2 : " << (int) sSet.mMasking_2 <<std::endl;
	std::cout << "Masking 3 : " << (int) sSet.mMasking_3 <<std::endl;
	std::cout << "Masking 4 : " << (int) sSet.mMasking_4 <<std::endl;
	std::cout << "Masking 5 : " << (int) sSet.mMasking_5 <<std::endl;
	std::cout << "Masking 6 : " << (int) sSet.mMasking_6 <<std::endl;
	std::cout << "Masking 7 : " << (int) sSet.mMasking_7 <<std::endl;
	std::cout << "Masking 8 : " << (int) sSet.mMasking_8 <<std::endl;
	std::cout << "Masking 9 : " << (int) sSet.mMasking_9 <<std::endl;
	std::cout << "Masking 10 : " <<(int) sSet.mMasking_10 <<std::endl;
	std::cout << "Masking 11 : " <<(int) sSet.mMasking_11 <<std::endl;
	std::cout << "Masking 12 : " << (int)sSet.mMasking_12 <<std::endl;
	std::cout << "Masking 13 : " << (int)sSet.mMasking_13 <<std::endl;
	std::cout << "Masking 14 : " << (int)sSet.mMasking_14 <<std::endl;
	std::cout << "Masking 15 : " << (int)sSet.mMasking_15 <<std::endl;
	std::cout << "Masking 16 : " << (int)sSet.mMasking_16 <<std::endl;
	std::cout << std::fixed << "SeekerOpenPosX : " << sSet.mSeekerOpenPosX <<std::endl;
	std::cout << std::fixed << "SeekerOpenPosY : " << sSet.mSeekerOpenPosY <<std::endl;
	std::cout << std::fixed << "SeekerOpenHeading : " << sSet.mSeekerOpenHeading <<std::endl;
	std::cout << "-------------------------------------------" << std::endl;

	if (orderID == ORD_MM40_RELOAD)
	{
		SimActorControl* simCtrl = static_cast<SimActorControl*> (GetGameManager()->GetComponentByName(C_COMP_ACTOR_CONTROLLER));
		if ( simCtrl != NULL )
		{
			dtCore::RefPtr<dtDAL::ActorProxy> ap = simCtrl->GetMissileActors(mShipID,mWeaponID,mLauncherID,mMissileID, mMissileNum );
			if(!ap.valid())
			{
				simCtrl->CreateMissileActors(mShipID,mWeaponID,mLauncherID,mMissileID, mMissileNum );
			}
		}
	}

	else if (orderID == ORD_MM40_FIRE)
	{
		if ( IsValidMissile(mShipID,mWeaponID,mLauncherID,mMissileID,mMissileNum))
		{
			dtCore::RefPtr<MsgSetExocetMM40> Msg = NULL;
			GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::EXOCETMM_40_EVENT, Msg);

			/*dtTerrain::GeoCoordinates coord;
			coord.SetLongitude(sSet.mSeekerOpenPosX);
			coord.SetLatitude(sSet.mSeekerOpenPosY);
			*/
			
			//ambil env_peta dari scenario kemudian diambil xoffset dan yoffset dari env_port
			dtTerrain::GeoCoordinates coord3DExxocet;

			if (sSet.mSeekerOpenPosX != 0)
			{
				SimDBConnection* cdb= static_cast<SimDBConnection*>(GetGameManager()->GetComponentByName("Database Connection"));
				double xOffset,yOffset;

				if (cdb != NULL)
				{
					bool isDatabaseConnected = cdb->isDatabaseConnected();
					if (isDatabaseConnected)
					{
						xOffset = cdb->GetxOffSetFromScenarioID(0);
						yOffset = cdb->GetyOffSetFromScenarioID(0);
						//std::cout<<"xOffDatabase : "<<boost::format("%1$.16f") % xOffset<<std::endl;
						std::cout << std::fixed << "xOffsetDatabase = " << xOffset << std::endl;
						std::cout << std::fixed << "yOffsetDatabase = " << yOffset << std::endl;
					}
				}

				//dicari koordinat x y dalam 3D mengacu pada offset scenario yang sedang berjalan
				coord3DExxocet.SetLongitude((sSet.mSeekerOpenPosX - xOffset) * DEF_DEGREE_TO_METRE);
				coord3DExxocet.SetLatitude((sSet.mSeekerOpenPosY - yOffset) * DEF_DEGREE_TO_METRE);
				std::cout<<"X 3D EXXOCET AFTER OFFSET : "<<coord3DExxocet.GetLongitude()<<std::endl;
				std::cout<<"Y 3D EXXOCET AFTER OFFSET : "<<coord3DExxocet.GetLatitude()<<std::endl;
			}


			Msg->SetVehicleID(mShipID);
			Msg->SetWeaponID(mWeaponID);
			Msg->SetLauncherID(mLauncherID);
			Msg->SetMissileID(mMissileID);
			Msg->SetMissileNum(mMissileNum);
			Msg->SetOrderID(sSet.OrderID);
			Msg->SetTargetRange(sSet.mTRange);
			Msg->SetTargetBearing(sSet.mTBearing);
			Msg->SetAngularMode(sSet.mAngular_Mode);
			Msg->SetAgilityMode(sSet.mAgility_Mode);
			Msg->SetInitialStepMode(sSet.mInitialStep_Mode);
			Msg->SetObstacle_Alt(sSet.mObstacle_Alt);
			Msg->SetObstacle_Range(sSet.mObstacle_Range);
			Msg->SetApproach_Range(sSet.mApproach_Range);
			Msg->SetTerminal_Range(sSet.mTerminal_Range);
			Msg->SetLeft_Angle(sSet.mLAngle);
			Msg->SetRight_Angle(sSet.mRAngle);
			Msg->SetFar_Range(sSet.mFRange);
			Msg->SetNear_Range(sSet.mNRange);
			Msg->SetMasking_1(sSet.mMasking_1);
			Msg->SetMasking_2(sSet.mMasking_2);
			Msg->SetMasking_3(sSet.mMasking_3);
			Msg->SetMasking_4(sSet.mMasking_4);
			Msg->SetMasking_5(sSet.mMasking_5);
			Msg->SetMasking_6(sSet.mMasking_6);
			Msg->SetMasking_7(sSet.mMasking_7);
			Msg->SetMasking_8(sSet.mMasking_8);
			Msg->SetMasking_9(sSet.mMasking_9);
			Msg->SetMasking_10(sSet.mMasking_10);
			Msg->SetMasking_11(sSet.mMasking_11);
			Msg->SetMasking_12(sSet.mMasking_12);
			Msg->SetMasking_13(sSet.mMasking_13);
			Msg->SetMasking_14(sSet.mMasking_14);
			Msg->SetMasking_15(sSet.mMasking_15);
			Msg->SetMasking_16(sSet.mMasking_16);
			Msg->SetSeekerOpenPosX(coord3DExxocet.GetLongitude());
			Msg->SetSeekerOpenPosY(coord3DExxocet.GetLatitude());
			Msg->SetSeekerOpenHeading(sSet.mSeekerOpenHeading);

			//std::cout<<"XSOCKET : "<<(coord.GetCartesianPoint())[0]<<std::endl;
			//std::cout<<"YSOCKET : "<<(coord.GetCartesianPoint())[1]<<std::endl;
			// send local message
			GetGameManager()->SendNetworkMessage(*Msg);   					
			GetGameManager()->SendMessage(*Msg); 

			//Set Target Range for Player 
			std::vector<dtDAL::ActorProxy*> gaps;
			GetGameManager()->FindActorsByType(*(GetGameManager()->FindActorType(C_ACTOR_CAT, C_CN_PLAYER)), gaps);
			if(gaps.size() > 0 ) 
			{
				dtCore::RefPtr<dtGame::GameActorProxy> gap= static_cast<dtGame::GameActorProxy*>(gaps[0]);
				if ( gap!= NULL )
				{
					dtCore::RefPtr<PlayerActor> Player = static_cast<PlayerActor*>(gap->GetActor());
					Player->setTargetBearingExo(sSet.mTBearing);
					Player->setAngularModePlayer(sSet.mAngular_Mode);
				}
			}

			/* CAMERA UTIL (dibuat player)*/
			std::cout << "Send Message for firing lock" << std::endl;
			dtCore::RefPtr<MsgUtilityAndTools> MsgCam;
			GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::UTILITY_AND_TOOLS, MsgCam);
			MsgCam->SetOrderID(TIPE_UTIL_PLAYER_SETTING);
			MsgCam->SetUAT0(0);
			MsgCam->SetUAT1(PLAYER_SET_FIRING_LOCK);
			MsgCam->SetUAT2(mShipID);
			MsgCam->SetUAT3(mWeaponID);
			MsgCam->SetUAT4(mLauncherID);
			MsgCam->SetUAT5(mMissileID);
			MsgCam->SetUAT6(mMissileNum);
			GetGameManager()->SendNetworkMessage(*MsgCam);   					
			GetGameManager()->SendMessage(*MsgCam); 
		}
		else
				std::cout << "You Must Reload Exocet" << std::endl;
	}
}

void CSocketServer::handlePacketSetTorpedoSUT(void *pStruct, int pSize, Socket *pSocket)
{
	spSetTorpedoSUT sSet;
	CopyMemory(&sSet, pStruct, pSize);
	
	int mShipID = (unsigned int)sSet.ShipID;
	int mWeaponID = (unsigned int)sSet.mWeaponID;
	int mLauncherID = (unsigned int)sSet.mLauncherID;
	int mMissileID = (unsigned int)sSet.mMissileID;
	int mMissileNum = (unsigned int)sSet.mMissileNum;
	int orderID = (unsigned int)sSet.OrderID;
	int predm = (unsigned int)sSet.predm;
	int tgtID = (unsigned int)sSet.mTgtID;

	std::cout << "-------------------------------------------" << std::endl;
	std::cout << "ShipID = " << mShipID << std::endl;
	std::cout << "mLauncherID = " << mLauncherID << std::endl;
	std::cout << "mWeaponID = " << mWeaponID <<std::endl;
	std::cout << "mMissileID = " << mMissileID << std::endl;
	std::cout << "mMissileNum = " << mMissileNum << std::endl;
	std::cout << "OrderID = " << orderID << std::endl;
	std::cout << "mTorpedoCourse = " << sSet.mTorpedoCourse << std::endl;
	std::cout << "mTorpedoSpeed = " << sSet.mTorpedoSpeed << std::endl;
	std::cout << "mTorpedoDepth = " << sSet.mTorpedoDepth << std::endl;
	std::cout << "mTorpedoSafeDistance = " << sSet.mTorpedoSafeDistance << std::endl;
	std::cout << "enableDistance = " << sSet.mTorpedoEnDis << std::endl;
	std::cout << "predm = " << predm << std::endl;
	std::cout << "targetID = " << tgtID << std::endl;
	std::cout << "-------------------------------------------" << std::endl;

	if ( orderID == ORD_TORPEDOSUT_FIRED || orderID == ORD_TORPEDOSUT_HOMING || orderID == ORD_TORPEDOSUT_HANDLE || 
		orderID == ORD_TORPEDOSUT_DELETE || orderID == ORD_TORPEDOSUT_SEARCH || orderID == ORD_TORPEDOSUT_SHUTDOWN )
	{
		if (IsValidMissile(mShipID,mWeaponID,mLauncherID,mMissileID,mMissileNum)==true)
		{
			dtCore::RefPtr<MsgSetTorpedoSUT> Msg = NULL;
			GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::TORPEDOSUT_EVENT, Msg);
			Msg->SetVehicleID(mShipID);
			Msg->SetWeaponID(mWeaponID);
			Msg->SetLauncherID(mLauncherID);
			Msg->SetMissileID(mMissileID);
			Msg->SetMissileNum(mMissileNum);
			Msg->SetOrderID(orderID);
			Msg->SetModePrediction(predm);
			Msg->SetTargetID(tgtID);
			Msg->SetTorpedoCourse(sSet.mTorpedoCourse);
			Msg->SetTorpedoSpeed(sSet.mTorpedoSpeed);
			Msg->SetTorpedoDepth(sSet.mTorpedoDepth);
			Msg->SetTorpedoSafeDistance(sSet.mTorpedoSafeDistance);
			Msg->SetTorpedoEnDis(sSet.mTorpedoEnDis);
			Msg->SetTargetType(sSet.mTargetType); //surface atau subsurface

			GetGameManager()->SendNetworkMessage(*Msg);   					
			GetGameManager()->SendMessage(*Msg);
			
			if (orderID == ORD_TORPEDOSUT_FIRED)
			{
				/* CAMERA UTIL (dibuat player)*/
				std::cout << "Send Message for firing lock" << std::endl;
				dtCore::RefPtr<MsgUtilityAndTools> MsgCam;
				GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::UTILITY_AND_TOOLS, MsgCam);
				MsgCam->SetOrderID(TIPE_UTIL_PLAYER_SETTING);
				MsgCam->SetUAT0(0);
				MsgCam->SetUAT1(PLAYER_SET_FIRING_LOCK);
				MsgCam->SetUAT2(mShipID);
				MsgCam->SetUAT3(mWeaponID);
				MsgCam->SetUAT4(mLauncherID);
				MsgCam->SetUAT5(mMissileID);
				MsgCam->SetUAT6(mMissileNum);
				GetGameManager()->SendNetworkMessage(*MsgCam);   					
				GetGameManager()->SendMessage(*MsgCam);
			} 
		}
		else
			std::cout << "You Must Reload SUT" << std::endl;
	}
	else if (orderID == ORD_TORPEDOSUT_RELOAD)
	{
		SimActorControl* simCtrl = static_cast<SimActorControl*> (GetGameManager()->GetComponentByName(C_COMP_ACTOR_CONTROLLER));
		if ( simCtrl != NULL )
		{
			dtCore::RefPtr<dtDAL::ActorProxy> ap = simCtrl->GetMissileActors(mShipID,mWeaponID,mLauncherID,mMissileID, mMissileNum );
			if(!ap.valid())
			{
				simCtrl->CreateMissileActors(mShipID,mWeaponID,mLauncherID,mMissileID, mMissileNum );
			}
		}
	}
	else if (orderID == ORD_TORPEDOSUT_STATUS_ON)
	{
	}
}

//EKA-151111
void CSocketServer::handlePacketSetTorpedoA244(void *pStruct, int pSize, Socket *pSocket)
{
	spSetTorpedoA244 sSet;

	CopyMemory(&sSet, pStruct, pSize);

	int mShipID = (unsigned int)sSet.ShipID;	
	int mWeaponID = (unsigned int)sSet.mWeaponID;	
	int mLauncherID = (unsigned int)sSet.mLauncherID;		
	int mMissileID = (unsigned int)sSet.mMissileID;
	int mMissileNum = (unsigned int)sSet.mMissileNum;
	int mOrderID = (unsigned int)sSet.OrderID;

	std::cout << "-------------------------------------------" << std::endl;
	std::cout << "Ship ID = " << mShipID << std::endl;
	std::cout << "Launcher ID = " << mLauncherID << std::endl;
	std::cout << "missile = " << mMissileID << std::endl;
	std::cout << "orderID = " << mOrderID << std::endl;
	std::cout << "ISC = " << sSet.ISC << std::endl;
	std::cout << "ISR = " << sSet.ISR << std::endl;
	std::cout << "WTR = " << sSet.WTR << std::endl;
	std::cout << "CEI = " << sSet.CEI << std::endl;
	std::cout << "PRG = " << sSet.PRG << std::endl;
	std::cout << "DOP = " << sSet.DOP << std::endl;
	std::cout << "ACE = " << sSet.ACE << std::endl;
	std::cout << "FLO = " << sSet.FLO << std::endl;
	std::cout << "ISD = " << sSet.ISD << std::endl;
	std::cout << "ACM = " << sSet.ACM << std::endl;
	std::cout << "-------------------------------------------" << std::endl;

	if (mOrderID == ORD_TORPEDO_FIRED)
	{
		if (IsValidMissile(mShipID,mWeaponID,mLauncherID,mMissileID,mMissileNum)==true)
		{
			dtCore::RefPtr<MsgSetTorpedo> Msg = NULL;
			GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::TORPEDO_EVENT, Msg);
			Msg->SetVehicleID(mShipID);
			Msg->SetWeaponID(mWeaponID);
			Msg->SetLauncherID(mLauncherID);
			Msg->SetMissileID(mMissileID);
			Msg->SetMissileNum(mMissileNum);
			Msg->SetOrderID(mOrderID);
			Msg->SetTorpedoISC(sSet.ISC);
			Msg->SetTorpedoISR(sSet.ISR);
			Msg->SetTorpedoWTR(sSet.WTR);
			Msg->SetTorpedoCEI(sSet.CEI);
			Msg->SetTorpedoPRG(sSet.PRG);
			Msg->SetTorpedoDOP(sSet.DOP);
			Msg->SetTorpedoACE(sSet.ACE);
			Msg->SetTorpedoFLO(sSet.FLO);
			Msg->SetTorpedoISD(sSet.ISD);		
			Msg->SetTorpedoACM(sSet.ACM);

			GetGameManager()->SendNetworkMessage(*Msg);   					
			GetGameManager()->SendMessage(*Msg);

			
			/* CAMERA UTIL (dibuat player)*/
			std::cout << "Send Message for firing lock" << std::endl;
			dtCore::RefPtr<MsgUtilityAndTools> MsgCam;
			GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::UTILITY_AND_TOOLS, MsgCam);
			MsgCam->SetOrderID(TIPE_UTIL_PLAYER_SETTING);
			MsgCam->SetUAT0(0);
			MsgCam->SetUAT1(PLAYER_SET_FIRING_LOCK);
			MsgCam->SetUAT2(mShipID);
			MsgCam->SetUAT3(mWeaponID);
			MsgCam->SetUAT4(mLauncherID);
			MsgCam->SetUAT5(mMissileID);
			MsgCam->SetUAT6(mMissileNum);
			GetGameManager()->SendNetworkMessage(*MsgCam);   					
			GetGameManager()->SendMessage(*MsgCam); 
		}
		else
			std::cout << "You Must Reload A244" << std::endl;
	}
	else if (mOrderID == ORD_TORPEDO_RELOAD)
	{
		SimActorControl* simCtrl = static_cast<SimActorControl*> (GetGameManager()->GetComponentByName(C_COMP_ACTOR_CONTROLLER));
		if ( simCtrl != NULL )
		{
			dtCore::RefPtr<dtDAL::ActorProxy> ap = simCtrl->GetMissileActors(mShipID,mWeaponID,mLauncherID,mMissileID, mMissileNum );
			if(!ap.valid())
			{
				simCtrl->CreateMissileActors(mShipID,mWeaponID,mLauncherID,mMissileID, mMissileNum );
			}
		}
	}	 
}

void CSocketServer::handlePacketSetC802(void *pStruct, int pSize, Socket *pSocket)
{
	spSetC802 sSet;
	CopyMemory(&sSet, pStruct, pSize);

	int mShipID = (unsigned int)sSet.ShipID;	
	int mWeaponID = (unsigned int)sSet.mWeaponID;	
	int mLauncherID = (unsigned int)sSet.mLauncherID;		
	int mMissileID = (unsigned int)sSet.mMissileID;
	int mMissileNum = (unsigned int)sSet.mMissileNum;

	int orderID = (unsigned int)sSet.OrderID;	

	std::cout << "-------------------------------------------" << std::endl;
	std::cout << "mShipID		= " << mShipID << std::endl;
	std::cout << "mWeaponID		= " << mWeaponID << std::endl;
	std::cout << "mLauncherID	= " << mLauncherID << std::endl;
	std::cout << "mMissileID	= " << mMissileID << std::endl;
	std::  cout << "mMissileNum	= " << mMissileNum << std::endl;
	std::cout << "orderID		= " << orderID << std::endl;
	std::cout << "bearing		= " << sSet.mBearing << std::endl;
	std::cout << "range			= " << sSet.mRange << std::endl;
	std::cout << "-------------------------------------------" << std::endl;

	if( (orderID == ORD_C802_FIRE) || (orderID == ORD_C802_RELEASE) )
	{
		if (IsValidMissile(mShipID, mWeaponID, mLauncherID, mMissileID, mMissileNum)==true)
		{
			dtCore::RefPtr<MsgSetC802> Msg = NULL;
			GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::C802_EVENT, Msg);

			Msg->SetVehicleID(mShipID);
			Msg->SetWeaponID(mWeaponID);
			Msg->SetLauncherID(mLauncherID);
			Msg->SetMissileID(mMissileID);
			Msg->SetMissileNum(mMissileNum);
			Msg->SetOrderID(orderID);
			Msg->SetBearingToTarget(sSet.mBearing);
			Msg->SetDistanceToTarget(sSet.mRange);
			GetGameManager()->SendNetworkMessage(*Msg);   					
			GetGameManager()->SendMessage(*Msg);

			/* CAMERA UTIL (dibuat player)*/
			std::cout << "Send Message for firing lock" << std::endl;
			dtCore::RefPtr<MsgUtilityAndTools> MsgCam;
			GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::UTILITY_AND_TOOLS, MsgCam);
			MsgCam->SetOrderID(TIPE_UTIL_PLAYER_SETTING);
			MsgCam->SetUAT0(0);
			MsgCam->SetUAT1(PLAYER_SET_FIRING_LOCK);
			MsgCam->SetUAT2(mShipID);
			MsgCam->SetUAT3(mWeaponID);
			MsgCam->SetUAT4(mLauncherID);
			MsgCam->SetUAT5(mMissileID);
			MsgCam->SetUAT6(mMissileNum);
			GetGameManager()->SendNetworkMessage(*MsgCam);   					
			GetGameManager()->SendMessage(*MsgCam); 
		}
		else
			std::cout << "You Must Reload C802" << std::endl;
	}
	else if (orderID == ORD_C802_RELOAD)
	{
		SimActorControl* simCtrl = static_cast<SimActorControl*> (GetGameManager()->GetComponentByName(C_COMP_ACTOR_CONTROLLER));
		if ( simCtrl != NULL )
		{
			dtCore::RefPtr<dtDAL::ActorProxy> ap = simCtrl->GetMissileActors(mShipID,mWeaponID,mLauncherID,mMissileID, mMissileNum );
			if(!ap.valid())
			{
				simCtrl->CreateMissileActors(mShipID,mWeaponID,mLauncherID,mMissileID, mMissileNum );
			}
		}
	}

	/*dtCore::RefPtr<MsgUtilityAndTools> MsgCam;
	GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::UTILITY_AND_TOOLS, MsgCam);
	MsgCam->SetOrderID(TIPE_UTIL_PLAYER_SETTING);
	MsgCam->SetUAT0(0);
	MsgCam->SetUAT1(PLAYER_SET_FIRING_LOCK);
	MsgCam->SetUAT2(mShipID);
	MsgCam->SetUAT3(mWeaponID);
	MsgCam->SetUAT4(mLauncherID);
	MsgCam->SetUAT5(mMissileID);
	MsgCam->SetUAT6(mMissileNum);
	GetGameManager()->SendNetworkMessage(*MsgCam);   					
	GetGameManager()->SendMessage(*MsgCam);*/
}

void CSocketServer::handlePacketSetYakhont(void *pStruct, int pSize, Socket *pSocket){
	spSetYakhont sSet;
	CopyMemory(&sSet, pStruct, pSize);

	int mShipID = (unsigned int)sSet.ShipID;	
	int mWeaponID = (unsigned int)sSet.mWeaponID;	
	int mLauncherID = (unsigned int)sSet.mLauncherID;		
	int mMissileID = (unsigned int)sSet.mMissileID;
	int mMissileNum = (unsigned int)sSet.mMissileNum;
	int launcher1 = (unsigned int)sSet.launcher1;
	int launcher2 = (unsigned int)sSet.launcher2;
	int launcher3 = (unsigned int)sSet.launcher3;
	int launcher4 = (unsigned int)sSet.launcher4;

	static int CountMissile(0);
	if (launcher1==1) CountMissile++;
	if (launcher2==1) CountMissile++;
	if (launcher3==1) CountMissile++;
	if (launcher4==1) CountMissile++;

	int countYakhont = CountMissile;
	int orderID = (unsigned int)sSet.OrderID;	

	std::cout << "-------------------------------------------" << std::endl;
	std::cout << "mShipID = " << mShipID << std::endl;
	std::cout << "mWeaponID = " << mWeaponID << std::endl;
	std::cout << "mLauncherID = " << mLauncherID << std::endl;
	std::cout << "mMissileID = " << mMissileID << std::endl;
	std::cout << "mMissileNum = " << mMissileNum << std::endl;
	std::cout << "orderID = " << orderID << std::endl;
	std::cout << "bearing = " << sSet.mBearing << std::endl;
	std::cout << "range	= " << sSet.mRange << std::endl;
	std::cout << "launcher1 = " << launcher1 << std::endl;
	std::cout << "launcher2 = " << launcher2 << std::endl;
	std::cout << "launcher3 = " << launcher3 << std::endl;
	std::cout << "launcher4	= " << launcher4 << std::endl;
	std::cout << "-------------------------------------------" << std::endl;

	if( orderID == ORD_YAKHONT_FIRE )
	{
		if (IsValidMissile(mShipID, mWeaponID, mLauncherID,mMissileID,mMissileNum)==true)
		{
			SimActorControl* simCtrl = static_cast<SimActorControl*> (GetGameManager()->GetComponentByName(C_COMP_ACTOR_CONTROLLER));
			if ( simCtrl != NULL )
			{
				simCtrl->isSalvoYakhont = true;
				simCtrl->SetFireYakhont(mShipID, mWeaponID ,mLauncherID ,false, countYakhont,launcher1,launcher2,launcher3,launcher4,sSet.mBearing, sSet.mRange, true, false);
			}

			

			/* CAMERA UTIL (dibuat player)*/
			std::cout << "Send Message for firing lock" << std::endl;
			dtCore::RefPtr<MsgUtilityAndTools> MsgCam;
			GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::UTILITY_AND_TOOLS, MsgCam);
			MsgCam->SetOrderID(TIPE_UTIL_PLAYER_SETTING);
			MsgCam->SetUAT0(0);
			MsgCam->SetUAT1(PLAYER_SET_FIRING_LOCK);
			MsgCam->SetUAT2(mShipID);
			MsgCam->SetUAT3(mWeaponID);
			MsgCam->SetUAT4(mLauncherID);
			MsgCam->SetUAT5(mMissileID);
			MsgCam->SetUAT6(mMissileNum);
			GetGameManager()->SendNetworkMessage(*MsgCam);   					
			GetGameManager()->SendMessage(*MsgCam); 

			CountMissile = 0;
		}
		else
			std::cout << "You Must Reload Yakhont" << std::endl;
	}
	else if ( orderID == ORD_YAKHONT_RELOAD)
	{
		// Cara pintas @-@ ngeluuuuu [4/30/2013 DID RKT2]
		/*SimDBConnection* cdb= static_cast<SimDBConnection*>(GetGameManager()->GetComponentByName("Database Connection"));
		if( cdb!= NULL) {
			bool isDatabaseConnected = cdb->isDatabaseConnected();
			if ( isDatabaseConnected ) {
				SimActorMissileDef* missile = cdb->FindActorMissileDef(mShipID,mWeaponID,mLauncherID,mMissileID,mMissileNum) ;
				missile = cdb->GetNewDatabaseActorMissileDef(mShipID,mWeaponID,mLauncherID,mMissileID,mMissileNum) ;

			}
		}*/

		SimActorControl* simCtrl = static_cast<SimActorControl*> (GetGameManager()->GetComponentByName(C_COMP_ACTOR_CONTROLLER));
		if ( simCtrl != NULL )
		{
			simCtrl->isSalvoYakhont = true;
			simCtrl->SetFireYakhont(mShipID, mWeaponID ,mLauncherID ,true, countYakhont,launcher1,launcher2,launcher3,launcher4,sSet.mBearing, sSet.mRange, false, false);
		}

		CountMissile = 0;
	}
	else if (orderID == ORD_YAKHONT_STATUS_ON)
	{
		// Cara pintas @-@ ngeluuuuu [4/30/2013 DID RKT2]
		SimDBConnection* cdb= static_cast<SimDBConnection*>(GetGameManager()->GetComponentByName("Database Connection"));
		if( cdb!= NULL) {
		bool isDatabaseConnected = cdb->isDatabaseConnected();
		if ( isDatabaseConnected ) {
			SimActorWeaponDef* weapon = cdb->FindActorWeaponDef(mShipID,mWeaponID,mLauncherID);			// start [5/2/2013 DID RKT2]
			if (weapon == NULL)
			{
				weapon = cdb->GetNewDatabaseActorWeaponDef(mShipID,mWeaponID,mLauncherID);
			}
		}
		}
	}
	if( orderID == ORD_YAKHONT_RELEASE )
	{
		if (IsValidMissile(mShipID, mWeaponID, mLauncherID,mMissileID,mMissileNum)==true)
		{
			/*dtCore::RefPtr<MsgSetYakhont> Msg;
			GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::YAKHONT_EVENT, Msg);

			Msg->SetVehicleID(mShipID);
			Msg->SetWeaponID(mWeaponID);
			Msg->SetLauncherID(mLauncherID);
			Msg->SetMissileID(mMissileID);
			Msg->SetMissileNum(mMissileNum);

			Msg->SetOrderID(orderID);

			GetGameManager()->SendNetworkMessage(*Msg.get());
			GetGameManager()->SendMessage(*Msg.get());*/

			SimActorControl* simCtrl = static_cast<SimActorControl*> (GetGameManager()->GetComponentByName(C_COMP_ACTOR_CONTROLLER));
			if ( simCtrl != NULL )
			{
				simCtrl->isSalvoYakhont = false;
				simCtrl->isReleaseYakhont = true;
				simCtrl->SetFireYakhont(mShipID, mWeaponID ,mLauncherID ,false, countYakhont,launcher1,launcher2,launcher3,launcher4,sSet.mBearing, sSet.mRange, false, true);
			}
		}
	}
}

void CSocketServer::handlePacketSetTetral(void *pStruct, int pSize, Socket *pSocket)
{
	spSetTetral sSet;

	CopyMemory(&sSet, pStruct, pSize);

	int mShipID = (unsigned int)sSet.ShipID;	
	int mWeaponID = (unsigned int)sSet.mWeaponID;	
	int mLauncherID = (unsigned int)sSet.mLauncherID;		
	int mMissileID = (unsigned int)sSet.mMissileID;
	int mMissileNum = (unsigned int)sSet.mMissileNum;

	int sett = (unsigned int)sSet.OrderID;

	std::cout << "------------------TETRAL-------------------" << std::endl;
	std::cout << "Ship ID = " << mShipID << std::endl;
	std::cout << "Weapon ID = " << mWeaponID << std::endl;
	std::cout << "Launcher ID = " << mLauncherID << std::endl;
	std::cout << "missile = " << mMissileID << std::endl;
	std::cout << "missileNum = " << mMissileNum << std::endl;
	std::cout << "orderID = " << sett << std::endl;
	std::cout << "bearing = " << sSet.mTargetBearing << std::endl;
	std::cout << "elev = " << sSet.mTargetElev << std::endl;
	std::cout << "range = " << sSet.mTargetRange << std::endl;	
	std::cout << "-------------------------------------------" << std::endl;

	if( sett == ORD_TETRAL_FIRE )
	{
		if ((IsValidLauncher(mShipID, mWeaponID, mLauncherID)==true) && 
			(IsValidMissile(mShipID,mWeaponID,mLauncherID,mMissileID,mMissileNum)==true))
		{
			dtCore::RefPtr<MsgSetTetral> Msg = NULL;
			GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::TETRAL_EVENT, Msg);

			Msg->SetVehicleID(mShipID);
			Msg->SetWeaponID(mWeaponID);
			Msg->SetLauncherID(mLauncherID);
			Msg->SetMissileID(mMissileID);
			Msg->SetMissileNum(mMissileNum);
			Msg->SetOrderID(sSet.OrderID);
			Msg->SetTargetBearing(sSet.mTargetBearing);
			Msg->SetTargetRange(sSet.mTargetRange);
			Msg->SetTargetElev(sSet.mTargetElev);

			GetGameManager()->SendNetworkMessage(*Msg);   					
			GetGameManager()->SendMessage(*Msg); 

			/* CAMERA UTIL (dibuat player)*/
			std::cout << "Send Message for firing lock" << std::endl;
			dtCore::RefPtr<MsgUtilityAndTools> MsgCam;
			GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::UTILITY_AND_TOOLS, MsgCam);
			MsgCam->SetOrderID(TIPE_UTIL_PLAYER_SETTING);
			MsgCam->SetUAT0(0);
			MsgCam->SetUAT1(PLAYER_SET_FIRING_LOCK);
			MsgCam->SetUAT2(mShipID);
			MsgCam->SetUAT3(mWeaponID);
			MsgCam->SetUAT4(mLauncherID);
			MsgCam->SetUAT5(mMissileID);
			MsgCam->SetUAT6(mMissileNum);
			GetGameManager()->SendNetworkMessage(*MsgCam);   					
			GetGameManager()->SendMessage(*MsgCam); 
		}
		else
			std::cout << "You Must Reload Tetral" << std::endl;
	}
	else if (sett == ORD_TETRAL_RELOAD)
	{
		if (IsValidLauncher(mShipID, mWeaponID, mLauncherID)==true)
		{
			SimActorControl* simCtrl = static_cast<SimActorControl*> (GetGameManager()->GetComponentByName(C_COMP_ACTOR_CONTROLLER));
			if ( simCtrl != NULL )
			{
				dtCore::RefPtr<dtDAL::ActorProxy> ap = simCtrl->GetMissileActors(mShipID,mWeaponID,mLauncherID,mMissileID, mMissileNum );
				if(!ap.valid())
				{
					simCtrl->CreateMissileActors(mShipID,mWeaponID,mLauncherID,mMissileID, mMissileNum );
				}
			}
		}
		else
			std::cout << "Not Valid Launcher" << std::endl;
	}
	else if (sett == ORD_TETRAL_STATUS_ON)
	{
		CheckValidLaunchers(mShipID, mWeaponID, mLauncherID);
	}
	else if (sett == ORD_TETRAL_STATUS_OFF)
	{
		SimActorControl* simCtrl = static_cast<SimActorControl*> (GetGameManager()->GetComponentByName(C_COMP_ACTOR_CONTROLLER));
		if ( simCtrl != NULL )
		{
			for (int iloop=1; iloop<=4; iloop++)
				if (IsValidMissile(mShipID,mWeaponID,mLauncherID,iloop,1))
					SetMissileStatus(mShipID,mWeaponID,mLauncherID,iloop,1,ST_MISSILE_DEL);

			dtCore::RefPtr<dtDAL::ActorProxy> aps = simCtrl->GetLauncherActors(C_WEAPON_TYPE_SPOUT,mShipID,mWeaponID,mLauncherID );
			if(aps.valid())
			{
				simCtrl->DeleteLauncherActors(C_WEAPON_TYPE_SPOUT, mShipID, mWeaponID, mLauncherID);
			}

			dtCore::RefPtr<dtDAL::ActorProxy> apb = simCtrl->GetLauncherActors(C_WEAPON_TYPE_BODY,mShipID,mWeaponID,mLauncherID );
			if(apb.valid())
			{
				simCtrl->DeleteLauncherActors(C_WEAPON_TYPE_BODY, mShipID, mWeaponID, mLauncherID);

				//harus nya di onremovedfromworld launcherbodyactor.cpp
				dtCore::RefPtr<dtDAL::ActorProxy> parentProxy = simCtrl->GetShipActorByID(mShipID);
				ShipModelActor* shp  = static_cast<ShipModelActor*>(parentProxy->GetActor());
				LauncherBodyActor* lba = static_cast<LauncherBodyActor*>(apb->GetActor());
				if (shp!= NULL) {
					shp->SetSwitchWeaponOFF(lba->GetIndexSwitchWeaponParents(), true);
					shp->GetGameActorProxy().NotifyFullActorUpdate();
				}
			}
		}
	}
	else
	{
		if (IsValidLauncher(mShipID, mWeaponID, mLauncherID)==true)
		{
			dtCore::RefPtr<MsgSetTetral> Msg = NULL;
			GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::TETRAL_EVENT, Msg);

			Msg->SetVehicleID(mShipID);
			Msg->SetWeaponID(mWeaponID);
			Msg->SetLauncherID(mLauncherID);
			Msg->SetMissileID(mMissileID);
			Msg->SetMissileNum(mMissileNum);
			Msg->SetOrderID(sSet.OrderID);
			Msg->SetTargetBearing(sSet.mTargetBearing);
			Msg->SetTargetRange(sSet.mTargetRange);
			Msg->SetTargetElev(sSet.mTargetElev);

			GetGameManager()->SendNetworkMessage(*Msg);   					
			GetGameManager()->SendMessage(*Msg); 
		}
	}
}


void CSocketServer::handlePacketSetMistral(void *pStruct, int pSize, Socket *pSocket)
{
	spSetMistral sSet;
	CopyMemory(&sSet, pStruct, pSize);
	//memcpy(&sSet,&pStruct,pSize);

	int mShipID = (unsigned int)sSet.ShipID;	
	int mWeaponID = (unsigned int)sSet.mWeaponID;	
	int mLauncherID = (unsigned int)sSet.mLauncherID;		
	int mMissileID = (unsigned int)sSet.mMissileID;
	int mMissileNum = (unsigned int)sSet.mMissileNum;
	int sett = (unsigned int)sSet.OrderID;
	float mTargetBearing = sSet.mTargetBearing;
	float mTargetRange = sSet.mTargetRange;
	float mTargetElev = sSet.mTargetElev;

	sSet.mMissileID = NULL;
	sSet.ShipID = NULL;
	sSet.mWeaponID = NULL;
	sSet.mLauncherID = NULL;
	sSet.mMissileNum= NULL;
	sSet.OrderID = NULL;
	sSet.mTargetBearing = NULL;
	sSet.mTargetElev = NULL;
	sSet.mTargetRange = NULL;

	pStruct = NULL;
	free (pStruct);

	std::cout << "------------MISTRAL-------------------" << std::endl;
	std::cout << "Ship ID = " << mShipID << std::endl;
	std::cout << "Weapon ID = " << mWeaponID << std::endl;
	std::cout << "Launcher ID = " << mLauncherID << std::endl;
	std::cout << "missile = " << mMissileID << std::endl;
	std::cout << "missileNum = " << mMissileNum << std::endl;
	std::cout << "orderID = " << sett << std::endl;
	std::cout << "bearing = " << mTargetBearing << std::endl;
	std::cout << "elev = " << mTargetRange << std::endl;
	std::cout << "range = " << mTargetElev << std::endl;
	std::cout << "-------------------------------------------" << std::endl;

	if( sett == ORD_MISTRAL_FIRE )
	{
		if ((IsValidLauncher(mShipID, mWeaponID, mLauncherID)==true) && 
			(IsValidMissile(mShipID,mWeaponID,mLauncherID,mMissileID,mMissileNum)==true))
		{
			dtCore::RefPtr<MsgSetMistral> Msg = NULL;
			GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::MISTRAL_EVENT, Msg);

			Msg->SetVehicleID(mShipID);
			Msg->SetWeaponID(mWeaponID);
			Msg->SetLauncherID(mLauncherID);
			Msg->SetMissileID(mMissileID);
			Msg->SetMissileNum(mMissileNum);
			Msg->SetOrderID(sett);
			Msg->SetTargetBearing(mTargetBearing);
			Msg->SetTargetRange(mTargetRange);
			Msg->SetTargetElev(mTargetElev);

			// send local message
			GetGameManager()->SendNetworkMessage(*Msg);   					
			GetGameManager()->SendMessage(*Msg); 

			/* CAMERA UTIL (dibuat player)*/
			std::cout << "Send Message for firing lock" << std::endl;
			dtCore::RefPtr<MsgUtilityAndTools> MsgCam;
			GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::UTILITY_AND_TOOLS, MsgCam);
			MsgCam->SetOrderID(TIPE_UTIL_PLAYER_SETTING);
			MsgCam->SetUAT0(0);
			MsgCam->SetUAT1(PLAYER_SET_FIRING_LOCK);
			MsgCam->SetUAT2(mShipID);
			MsgCam->SetUAT3(mWeaponID);
			MsgCam->SetUAT4(mLauncherID);
			MsgCam->SetUAT5(mMissileID);
			MsgCam->SetUAT6(mMissileNum);
			GetGameManager()->SendNetworkMessage(*MsgCam);   					
			GetGameManager()->SendMessage(*MsgCam); 
		}
		else
			std::cout << "You Must Reload Mistral" << std::endl;
	}
	else if (sett == ORD_MISTRAL_RELOAD)
	{
		if (IsValidLauncher(mShipID, mWeaponID, mLauncherID)==true)
		{
			SimActorControl* simCtrl = static_cast<SimActorControl*> (GetGameManager()->GetComponentByName(C_COMP_ACTOR_CONTROLLER));
			if ( simCtrl != NULL )
			{
				dtCore::RefPtr<dtDAL::ActorProxy> ap = simCtrl->GetMissileActors(mShipID,mWeaponID,mLauncherID,mMissileID, mMissileNum );
				if(!ap.valid())
				{
					simCtrl->CreateMissileActors(mShipID,mWeaponID,mLauncherID,mMissileID, mMissileNum );
				}
			}
		}
		else
			std::cout << "Not Valid Launcher" << std::endl;
	}
	else if (sett == ORD_MISTRAL_STATUS_ON)
	{
		CheckValidLaunchers(mShipID, mWeaponID, mLauncherID);
	}
	else if (sett == ORD_MISTRAL_STATUS_OFF)
	{
		SimActorControl* simCtrl = static_cast<SimActorControl*> (GetGameManager()->GetComponentByName(C_COMP_ACTOR_CONTROLLER));
		if ( simCtrl != NULL )
		{
			for (int iloop=1; iloop<=2; iloop++)
				if (IsValidMissile(mShipID,mWeaponID,mLauncherID,iloop,1))
					SetMissileStatus(mShipID,mWeaponID,mLauncherID,iloop,1,ST_MISSILE_DEL);

			dtCore::RefPtr<dtDAL::ActorProxy> aps = simCtrl->GetLauncherActors(C_WEAPON_TYPE_SPOUT,mShipID,mWeaponID,mLauncherID );
			if(aps.valid())
			{
				simCtrl->DeleteLauncherActors(C_WEAPON_TYPE_SPOUT, mShipID, mWeaponID, mLauncherID);
			}
			else
				std::cout << "No Launcher Spout" << std::endl;

			dtCore::RefPtr<dtDAL::ActorProxy> apb = simCtrl->GetLauncherActors(C_WEAPON_TYPE_BODY,mShipID,mWeaponID,mLauncherID );
			if(apb.valid())
			{
				simCtrl->DeleteLauncherActors(C_WEAPON_TYPE_BODY, mShipID, mWeaponID, mLauncherID);

				//harus nya di onremovedfromworld launcherbodyactor.cpp
				dtCore::RefPtr<dtDAL::ActorProxy> parentProxy = simCtrl->GetShipActorByID(mShipID);
				ShipModelActor* shp  = static_cast<ShipModelActor*>(parentProxy->GetActor());
				LauncherBodyActor* lba = static_cast<LauncherBodyActor*>(apb->GetActor());
				if (shp!= NULL) {
					shp->SetSwitchWeaponOFF(lba->GetIndexSwitchWeaponParents(), true);
					shp->GetGameActorProxy().NotifyFullActorUpdate();
				}
				shp = NULL;
				free(shp);
				lba = NULL;
				free(lba);
			}
			else
				std::cout << "No Launcher Body" << std::endl;
		}
		simCtrl = NULL;
		free(simCtrl);
	}
	else if (sett == ORD_MISTRAL_STATUS_UNLOCK)
	{
		dtCore::RefPtr<dtDAL::ActorProxy> proxy ;
		SimActorControl* simCtrl = static_cast<SimActorControl*> (GetGameManager()->GetComponentByName(C_COMP_ACTOR_CONTROLLER));

		if ( simCtrl != NULL )
			proxy = simCtrl->GetMissileActors( mShipID, mWeaponID, mLauncherID, mMissileID, mMissileNum);

		if ( proxy.valid())
		{
			dtCore::RefPtr<MsgSetMistral> Msg = NULL;
			GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::MISTRAL_EVENT, Msg);

			Msg->SetVehicleID(mShipID);
			Msg->SetWeaponID(mWeaponID);
			Msg->SetLauncherID(mLauncherID);
			Msg->SetMissileID(mMissileID);
			Msg->SetMissileNum(mMissileNum);
			Msg->SetOrderID(sett);

			GetGameManager()->SendNetworkMessage(*Msg);   					
			GetGameManager()->SendMessage(*Msg); 

			SetMissileStatus(mShipID,mWeaponID,mLauncherID,mMissileID,mMissileNum,ST_MISSILE_UNLOCK);
		}
	}
	else if (sett == ORD_MISTRAL_STATUS_LOCK)
	{
		dtCore::RefPtr<dtDAL::ActorProxy> proxy ;
		SimActorControl* simCtrl = static_cast<SimActorControl*> (GetGameManager()->GetComponentByName(C_COMP_ACTOR_CONTROLLER));

		if ( simCtrl != NULL )
			proxy = simCtrl->GetMissileActors( mShipID, mWeaponID, mLauncherID, mMissileID, mMissileNum);

		if ( proxy.valid())
		{
			dtCore::RefPtr<MsgSetMistral> Msg = NULL;
			GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::MISTRAL_EVENT, Msg);

			Msg->SetVehicleID(mShipID);
			Msg->SetWeaponID(mWeaponID);
			Msg->SetLauncherID(mLauncherID);
			Msg->SetMissileID(mMissileID);
			Msg->SetMissileNum(mMissileNum);
			Msg->SetOrderID(sett);

			GetGameManager()->SendNetworkMessage(*Msg);   					
			GetGameManager()->SendMessage(*Msg); 

			SetMissileStatus(mShipID,mWeaponID,mLauncherID,mMissileID,mMissileNum,ST_MISSILE_LOCK);
		}
	}
	else
	{
		if (IsValidLauncher(mShipID, mWeaponID, mLauncherID)==true)
		{	
			dtCore::RefPtr<MsgSetMistral> Msg = NULL;
			GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::MISTRAL_EVENT, Msg);

			Msg->SetVehicleID(mShipID);
			Msg->SetWeaponID(mWeaponID);
			Msg->SetLauncherID(mLauncherID);
			Msg->SetMissileID(mMissileID);
			Msg->SetMissileNum(mMissileNum);
			Msg->SetOrderID(sett);
			Msg->SetTargetBearing(mTargetBearing);
			Msg->SetTargetRange(mTargetRange);
			Msg->SetTargetElev(mTargetElev);

			// send local message
			GetGameManager()->SendNetworkMessage(*Msg);   					
			GetGameManager()->SendMessage(*Msg); 
		}
	}
}

void CSocketServer::handlePacketSetStrela(void *pStruct, int pSize, Socket *pSocket)
{
	spSetStrela sSet;
	CopyMemory(&sSet, pStruct, pSize);

	int mShipID = (unsigned int)sSet.ShipID;	
	int mWeaponID = (unsigned int)sSet.mWeaponID;	
	int mLauncherID = (unsigned int)sSet.mLauncherID;		
	int mMissileID = (unsigned int)sSet.mMissileID;
	int mMissileNum = (unsigned int)sSet.mMissileNum;

	int sett = (unsigned int)sSet.OrderID;

	std::cout << "-----------------STRELA-------------------" << std::endl; 
	std::cout << "Ship ID = " << mShipID << std::endl;
	std::cout << "Weapon ID = " << mWeaponID << std::endl;
	std::cout << "Launcher ID = " << mLauncherID << std::endl;
	std::cout << "missile = " << mMissileID << std::endl;
	std::cout << "missileNum = " << mMissileNum << std::endl;
	std::cout << "orderID = " << sett<< std::endl;
	std::cout << "bearing = " << sSet.mTargetBearing << std::endl;
	std::cout << "elev = " << sSet.mTargetElev << std::endl;
	std::cout << "range = " << sSet.mTargetRange << std::endl;	
	std::cout << "-------------------------------------------" << std::endl;

	if( sett == ORD_STRELA_FIRE )
	{
		if ((IsValidLauncher(mShipID, mWeaponID, mLauncherID)==true) && 
			(IsValidMissile(mShipID,mWeaponID,mLauncherID,mMissileID,mMissileNum)==true))
		{
			dtCore::RefPtr<MsgSetStrela> Msg = NULL;
			GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::STRELA_EVENT, Msg);

			Msg->SetVehicleID(mShipID);
			Msg->SetWeaponID(mWeaponID);
			Msg->SetLauncherID(mLauncherID);
			Msg->SetMissileID(mMissileID);
			Msg->SetMissileNum(mMissileNum);
			Msg->SetOrderID(sSet.OrderID);
			Msg->SetTargetBearing(sSet.mTargetBearing);
			Msg->SetTargetRange(sSet.mTargetElev);
			Msg->SetTargetElev(sSet.mTargetElev);

			// send local message
			GetGameManager()->SendNetworkMessage(*Msg);   					
			GetGameManager()->SendMessage(*Msg);

			/* CAMERA UTIL (dibuat player)*/
			std::cout << "Send Message for firing lock" << std::endl;
			dtCore::RefPtr<MsgUtilityAndTools> MsgCam;
			GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::UTILITY_AND_TOOLS, MsgCam);
			MsgCam->SetOrderID(TIPE_UTIL_PLAYER_SETTING);
			MsgCam->SetUAT0(0);
			MsgCam->SetUAT1(PLAYER_SET_FIRING_LOCK);
			MsgCam->SetUAT2(mShipID);
			MsgCam->SetUAT3(mWeaponID);
			MsgCam->SetUAT4(mLauncherID);
			MsgCam->SetUAT5(mMissileID);
			MsgCam->SetUAT6(mMissileNum);
			GetGameManager()->SendNetworkMessage(*MsgCam);   					
			GetGameManager()->SendMessage(*MsgCam); 
		}
		else
			std::cout << "You Must Reload Strela" << std::endl;
	}
	else if (sett == ORD_STRELA_RELOAD)
	{
		if (IsValidLauncher(mShipID, mWeaponID, mLauncherID)==true)
		{
			SimActorControl* simCtrl = static_cast<SimActorControl*> (GetGameManager()->GetComponentByName(C_COMP_ACTOR_CONTROLLER));
			if ( simCtrl != NULL )
			{
				dtCore::RefPtr<dtDAL::ActorProxy> ap = simCtrl->GetMissileActors(mShipID,mWeaponID,mLauncherID,mMissileID, mMissileNum );
				if(!ap.valid())
				{
					simCtrl->CreateMissileActors(mShipID,mWeaponID,mLauncherID,mMissileID, mMissileNum );
				}
			}
		}
		else
			std::cout << "Not Valid Launcher" << std::endl;
	}
	else if (sett == ORD_STRELA_STATUS_ON)
	{
		CheckValidLaunchers(mShipID, mWeaponID, mLauncherID);
	}
	else if (sett == ORD_STRELA_STATUS_OFF)
	{
		SimActorControl* simCtrl = static_cast<SimActorControl*> (GetGameManager()->GetComponentByName(C_COMP_ACTOR_CONTROLLER));
		if ( simCtrl != NULL )
		{
			for (int iloop=1; iloop<=4; iloop++)
				if (IsValidMissile(mShipID,mWeaponID,mLauncherID,iloop,1))
					SetMissileStatus(mShipID,mWeaponID,mLauncherID,iloop,1,ST_MISSILE_DEL);

			dtCore::RefPtr<dtDAL::ActorProxy> aps = simCtrl->GetLauncherActors(C_WEAPON_TYPE_SPOUT,mShipID,mWeaponID,mLauncherID );
			if(aps.valid())
			{
				simCtrl->DeleteLauncherActors(C_WEAPON_TYPE_SPOUT, mShipID, mWeaponID, mLauncherID);
			}

			dtCore::RefPtr<dtDAL::ActorProxy> apb = simCtrl->GetLauncherActors(C_WEAPON_TYPE_BODY,mShipID,mWeaponID,mLauncherID );
			if(apb.valid())
			{
				simCtrl->DeleteLauncherActors(C_WEAPON_TYPE_BODY, mShipID, mWeaponID, mLauncherID);

				//harus nya di onremovedfromworld launcherbodyactor.cpp
				dtCore::RefPtr<dtDAL::ActorProxy> parentProxy = simCtrl->GetShipActorByID(mShipID);
				ShipModelActor* shp  = static_cast<ShipModelActor*>(parentProxy->GetActor());
				LauncherBodyActor* lba = static_cast<LauncherBodyActor*>(apb->GetActor());
				if (shp!= NULL) {
					shp->SetSwitchWeaponOFF(lba->GetIndexSwitchWeaponParents(), true);
					shp->GetGameActorProxy().NotifyFullActorUpdate();
				}
			}
		}
	}
	else if (sett == ORD_STRELA_STATUS_UNLOCK)
	{
		dtCore::RefPtr<dtDAL::ActorProxy> proxy ;
		SimActorControl* simCtrl = static_cast<SimActorControl*> (GetGameManager()->GetComponentByName(C_COMP_ACTOR_CONTROLLER));

		if ( simCtrl != NULL )
			proxy = simCtrl->GetMissileActors( mShipID, mWeaponID, mLauncherID, mMissileID, mMissileNum);

		if ( proxy.valid())
		{
			dtCore::RefPtr<MsgSetStrela> Msg = NULL;
			GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::STRELA_EVENT, Msg);

			Msg->SetVehicleID(mShipID);
			Msg->SetWeaponID(mWeaponID);
			Msg->SetLauncherID(mLauncherID);
			Msg->SetMissileID(mMissileID);
			Msg->SetMissileNum(mMissileNum);
			Msg->SetOrderID(sSet.OrderID);

			GetGameManager()->SendNetworkMessage(*Msg);   					
			GetGameManager()->SendMessage(*Msg);

			SetMissileStatus(mShipID,mWeaponID,mLauncherID,mMissileID,mMissileNum,ST_MISSILE_UNLOCK);
		}
	}
	else if (sett == ORD_STRELA_STATUS_LOCK)
	{
		dtCore::RefPtr<dtDAL::ActorProxy> proxy ;
		SimActorControl* simCtrl = static_cast<SimActorControl*> (GetGameManager()->GetComponentByName(C_COMP_ACTOR_CONTROLLER));

		if ( simCtrl != NULL )
			proxy = simCtrl->GetMissileActors( mShipID, mWeaponID, mLauncherID, mMissileID, mMissileNum);

		if ( proxy.valid())
		{
			dtCore::RefPtr<MsgSetStrela> Msg = NULL;
			GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::STRELA_EVENT, Msg);

			Msg->SetVehicleID(mShipID);
			Msg->SetWeaponID(mWeaponID);
			Msg->SetLauncherID(mLauncherID);
			Msg->SetMissileID(mMissileID);
			Msg->SetMissileNum(mMissileNum);
			Msg->SetOrderID(sSet.OrderID);

			GetGameManager()->SendNetworkMessage(*Msg);   					
			GetGameManager()->SendMessage(*Msg);

			SetMissileStatus(mShipID,mWeaponID,mLauncherID,mMissileID,mMissileNum,ST_MISSILE_LOCK);
		}
	}
	else
	{
		if (IsValidLauncher(mShipID, mWeaponID, mLauncherID)==true)
		{

			dtCore::RefPtr<MsgSetStrela> Msg = NULL;
			GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::STRELA_EVENT, Msg);

			Msg->SetVehicleID(mShipID);
			Msg->SetWeaponID(mWeaponID);
			Msg->SetLauncherID(mLauncherID);
			Msg->SetMissileID(mMissileID);
			Msg->SetMissileNum(mMissileNum);
			Msg->SetOrderID(sSet.OrderID);
			Msg->SetTargetBearing(sSet.mTargetBearing);
			Msg->SetTargetRange(sSet.mTargetElev);
			Msg->SetTargetElev(sSet.mTargetElev);

			// send local message
			GetGameManager()->SendNetworkMessage(*Msg);   					
			GetGameManager()->SendMessage(*Msg); 
		}
	}
}

void CSocketServer::handlePacketDatabaseEvent(void *pStruct, int pSize, Socket *pSocket)
{
	spDatabaseEvent sEvent;
	CopyMemory(&sEvent, pStruct, pSize);
	//if ( sEvent.TypeID == ORD_DBE_TEST )
	//{        
	dtCore::RefPtr<MsgDatabaseEvent> dbeMsg;
	GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::DATABASE_EVENT, dbeMsg);

	dbeMsg->SetTypeID((unsigned int)sEvent.TypeID);
	dbeMsg->SetOrderID((unsigned int)sEvent.OrderID);
	dbeMsg->SetDetailID((unsigned int)sEvent.DetailID);

	GetGameManager()->SendNetworkMessage(*dbeMsg.get());
	GetGameManager()->SendMessage(*dbeMsg.get());
	//}		 
} 

void CSocketServer::ProcessOrderEvent(const dtGame::Message &message)
{
	
	const MsgOrder &orderMsg = static_cast<const MsgOrder&>(message);
	if (orderMsg.GetOrderID() == ORD_RUDDER)
	{
		std::cout<<"------------------- CSocketServer::ProcessOrderEvent from Joystick Component ------------------"<<std::endl;

		dtCore::RefPtr<dtGame::GameActorProxy> gap = NULL ;

		SimActorControl* simCtrl = static_cast<SimActorControl*> (GetGameManager()->GetComponentByName(C_COMP_ACTOR_CONTROLLER));
		if ( simCtrl != NULL )  {
			dtCore::RefPtr<dtDAL::ActorProxy> shipProxy = simCtrl->GetShipActorByID(orderMsg.GetVehicleID());
			gap = static_cast<dtGame::GameActorProxy *>(shipProxy.get());
		}

		if ( gap )
		{
			spPosition lsPos;
			dtCore::Transform tmpTrans;

			lsPos.ShipID= orderMsg.GetVehicleID();
			
			(gap->GetGameActor()).GetTransform(tmpTrans);			
			dtTerrain::GeoCoordinates coord;
			coord.SetCartesianPoint(tmpTrans.GetTranslation());
			lsPos.x= coord.GetLongitude();
			lsPos.y= coord.GetLatitude();
			//lsPos.z= coord.GetAltitude();
			//lsPos.z= tmpTrans.GetTranslation()[2]* DEF_METER_TO_FEET;
			lsPos.z= tmpTrans.GetTranslation()[2]* DEF_METRE_TO_DEGREE;

			// get speed start from here
			dtCore::RefPtr<dtDAL::ActorProperty> speedProp( gap->GetProperty(C_SET_SPEED) );
			dtCore::RefPtr<dtDAL::FloatActorProperty> floatprop( static_cast<dtDAL::FloatActorProperty*>( speedProp.get() ) );
			lsPos.speed= floatprop->GetValue();

			// get heading start from here
			dtCore::RefPtr<dtDAL::ActorProperty> headProp( gap->GetProperty(C_SET_COURSE) );
			dtCore::RefPtr<dtDAL::FloatActorProperty> floatprop2( static_cast<dtDAL::FloatActorProperty*>( headProp.get() ) );
			lsPos.heading = floatprop2->GetValue();

			// get pitch start from here
			dtCore::RefPtr<dtDAL::ActorProperty> pitchprop( gap->GetProperty(C_SET_PITCH) );
			dtCore::RefPtr<dtDAL::FloatActorProperty> floatprop3( static_cast<dtDAL::FloatActorProperty*>( pitchprop.get() ) );
			lsPos.pitch = floatprop3->GetValue();

			//++ BAWE-20110706: NEW_POSITION_PACKET_WITH_ROLL
			// get rudder start from here
			dtCore::RefPtr<dtDAL::ActorProperty> rollprop( gap->GetProperty(C_SET_HEEL) ); // BAWE-20110613: WRONG_RUDDER_INDIKATOR2D
			dtCore::RefPtr<dtDAL::FloatActorProperty> floatprop4( static_cast<dtDAL::FloatActorProperty*>( rollprop.get() ) );
			lsPos.roll = floatprop4->GetValue();
			//-- BAWE-20110706: NEW_POSITION_PACKET_WITH_ROLL

			// get roll start from here
			// desired angle. not roll. for now
			lsPos.rudder = orderMsg.GetFloatValue();

			SendClientEx(structPositionID, (char *)&lsPos);

		}
	}
}

void CSocketServer::MissileExplode(int WeaponType, float PosX, float PosY, float PosZ, int Status)
{
	dtCore::RefPtr<dtCore::ParticleSystem> mExplosion= new dtCore::ParticleSystem();
	dtCore::RefPtr<dtAudio::Sound> missileSound =  dtAudio::AudioManager::GetInstance().NewSound();

	if ((WeaponType == CT_CANNON_40) || 
		(WeaponType == CT_CANNON_57) ||
		(WeaponType == CT_CANNON_76) ||
		(WeaponType == CT_CANNON_120))
	{
		mExplosion->LoadFile(C_PARTICLES_WATER_EXPLODE,true);

		dtCore::Transform tmpTrans;
		dtTerrain::GeoCoordinates coord;

		tmpTrans.Set(PosX, PosY, PosZ,0,0,0);
		coord.SetCartesianPoint(tmpTrans.GetTranslation());

		spCannonSplash Splash;
		Splash.mWeaponID = WeaponType;
		Splash.PosX		 = coord.GetLongitude();
		Splash.PosY		 = coord.GetLatitude();
		Splash.PosZ		 = PosZ;

		SendClientEx(structSetCannonSplash, (char *)&Splash);
		std::cout << "Send Cannon Splash, X: " << Splash.PosX << " Y: " << Splash.PosY << " Z: " << Splash.PosZ << std::endl;
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

void CSocketServer::processUtilityAndTools(const dtGame::Message &message) 
{
	const MsgUtilityAndTools &msg = static_cast<const MsgUtilityAndTools&>(message);
	if ( msg.GetOrderID() == TIPE_UTIL_MISSILE_STATUS )
	{
		int vid = msg.GetUAT0();
		int mwpn = msg.GetUAT1(); 
		int mlcr = msg.GetUAT2(); /// launcher
		int mid = msg.GetUAT3();  /// missileid
		int mnum = msg.GetUAT4();  /// missileid
		int sts = msg.GetUAT5(); 
		SetMissileStatus( vid, mwpn, mlcr, mid , mnum, sts ); 
	} 
	else if ( msg.GetOrderID() == TIPE_UTIL_SHIP_STATUS )
	{
		int vid	 = msg.GetUAT0();
		int morder = msg.GetUAT1(); 
		SetShipStatus( vid, morder ); 
	}
	else
	if ( msg.GetOrderID() == TIPE_UTIL_MISSILE_EXPLODE )
	{
		dtCore::Transform tmpTrans;
		dtTerrain::GeoCoordinates coord;

		//c0 = weaponID, c1 = launcherID, c2 = PosX, c3 = PosY, c4= PosZ

		tmpTrans.Set(msg.GetUAT3() , msg.GetUAT4() , msg.GetUAT5() ,0,0,0);
		coord.SetCartesianPoint(tmpTrans.GetTranslation());

		spCannonSplash Splash;

		Splash.mVehicleID  = msg.GetUAT0();
		Splash.mWeaponID   = msg.GetUAT1();
		Splash.mLauncherID = msg.GetUAT2();
		Splash.PosX		   = coord.GetLongitude();
		Splash.PosY		   = coord.GetLatitude();
		Splash.PosZ		   = msg.GetUAT5();

		SendClientEx(structSetCannonSplash, (char *)&Splash);
		//std::cout << "Send Cannon Splash @, X: " << Splash.PosX << " Y: " << Splash.PosY << " Z: " << Splash.PosZ << std::endl;
	}
	else
	if ( msg.GetOrderID() == TIPE_UTIL_MISSILE_FINDTARGET )
	{
		spFindTarget spFind;
		spFind.mVehicleID = msg.GetUAT0();
		spFind.mWeaponID   = msg.GetUAT1();
		spFind.mLauncherID = msg.GetUAT2();
		spFind.mMissileID = msg.GetUAT3();
		spFind.isFind = msg.GetUAT4();
		spFind.mTargetID = msg.GetUAT5();
		SendClientEx(structSetFindTarget, (char *)&spFind);
		std::cout << "Send To TOCOS that SUT Find Target " <<std::endl;
	}
	else
	if ( msg.GetOrderID() == TIPE_UTIL_TRAC2D )
	{
		spUtilityTools spAsroc;
		spAsroc.c0 = msg.GetUAT0();
		spAsroc.c1 = msg.GetUAT1();
		spAsroc.c2 = msg.GetUAT2();
		spAsroc.c3 = msg.GetUAT3();
		spAsroc.c4 = msg.GetUAT4();
		spAsroc.c5 = msg.GetUAT5();
		SendClientEx(structUtilityAndTools, (char *)&spAsroc);
		std::cout << "Send To 2D Trac" <<std::endl;
	}
}


void CSocketServer::CheckValidLaunchers(int mShipID, int mWeaponID, int mLauncherID )
{
	SimActorControl* simCtrl = static_cast<SimActorControl*> (GetGameManager()->GetComponentByName(C_COMP_ACTOR_CONTROLLER));
	if ( simCtrl != NULL )
	{
		dtCore::RefPtr<dtDAL::ActorProxy> ap = simCtrl->GetLauncherActors(C_WEAPON_TYPE_SPOUT,mShipID,mWeaponID,mLauncherID );
		if(!ap.valid())
		{
			simCtrl->CreateLaunchersActors(mShipID,mWeaponID,mLauncherID);
		}
	}
	else
	{
		std::cout << "Sim Actor Control Not Valid" << std::endl;
	}

	simCtrl = NULL;
	free(simCtrl);
}



void CSocketServer::CheckValidMissilesForStandAlone(int mShipID, int mWeaponID, int mLauncherID, int mMissileID, int mMissileNum )
{
	SimActorControl* simCtrl = static_cast<SimActorControl*> (GetGameManager()->GetComponentByName(C_COMP_ACTOR_CONTROLLER));
	if ( simCtrl != NULL )
	{
		dtCore::RefPtr<dtDAL::ActorProxy> ap = simCtrl->GetMissileActors(mShipID,mWeaponID,mLauncherID,mMissileID, mMissileNum );
		if(!ap.valid())
		{
			simCtrl->CreateMissileActorsForStandAlone(mShipID,mWeaponID,mLauncherID,mMissileID, mMissileNum );
		}
	}
}

void CSocketServer::CheckValidMissiles(int mShipID, int mWeaponID, int mLauncherID, int mMissileID, int mMissileNum )
{
	SimActorControl* simCtrl = static_cast<SimActorControl*> (GetGameManager()->GetComponentByName(C_COMP_ACTOR_CONTROLLER));
	if ( simCtrl != NULL )
	{
		dtCore::RefPtr<dtDAL::ActorProxy> ap = simCtrl->GetMissileActors(mShipID,mWeaponID,mLauncherID,mMissileID, mMissileNum );
		if(!ap.valid())
		{
			simCtrl->CreateMissileActors(mShipID,mWeaponID,mLauncherID,mMissileID, mMissileNum );
		}
	}
}

bool CSocketServer::IsValidLauncher(int mShipID, int mWeaponID, int mLauncherID)
{
	SimActorControl* simCtrl = static_cast<SimActorControl*> (GetGameManager()->GetComponentByName(C_COMP_ACTOR_CONTROLLER));
	if ( simCtrl != NULL )
	{
		dtCore::RefPtr<dtDAL::ActorProxy> ap = simCtrl->GetLauncherActors(C_WEAPON_TYPE_SPOUT,mShipID,mWeaponID,mLauncherID );
		if(ap.valid())
		{
			return true;
		}
	}

	return false;
}

bool CSocketServer::IsValidMissile(int mShipID, int mWeaponID, int mLauncherID, int mMissileID, int mMissileNum  )
{
	SimActorControl* simCtrl = static_cast<SimActorControl*> (GetGameManager()->GetComponentByName(C_COMP_ACTOR_CONTROLLER));
	if ( simCtrl != NULL )
	{
		dtCore::RefPtr<dtDAL::ActorProxy> ap = simCtrl->GetMissileActors(mShipID,mWeaponID,mLauncherID,mMissileID, mMissileNum );
		if(ap.valid())
		{
			return true;
		}
	}

	return false;
}

dtCore::RefPtr<dtDAL::ActorProxy> CSocketServer::IsValidMissileByLauncher(int mShipID, int mWeaponID, int mLauncherID)
{
	SimActorControl* simCtrl = static_cast<SimActorControl*> (GetGameManager()->GetComponentByName(C_COMP_ACTOR_CONTROLLER));
	if ( simCtrl != NULL )
	{
		dtCore::RefPtr<dtDAL::ActorProxy> ap = simCtrl->GetMissileByLauncher(mShipID,mWeaponID,mLauncherID);
		if(ap.valid())
		{
			return ap;
		}
	}

	return NULL;
}

/////////////////////////////////////////////////////////////////////////
// VID = shipID ( c0 ), missileID ( c1 ),  status ( c2 ) 
/////////////////////////////////////////////////////////////////////////
void CSocketServer::SetMissileStatus( const int VID, const int weaponID, const int launcherID, const int missileID, const int missileNum, const int missileStatus  )
{
	spMissilePos mPos;
	if ( missileStatus == ST_MISSILE_HIT )
	{
		mPos.ShipID = VID;
		mPos.WeaponID = weaponID;
		mPos.LauncherID = launcherID;
		mPos.MissileID = missileID;
		mPos.MissileNum = missileNum;
		
		mPos.Status = ST_MISSILE_HIT;
		SendClientEx(structMissilePos, (char *)  &mPos);

		//Nando Added
		dtCore::RefPtr<dtDAL::ActorProxy> proxy ;
		SimActorControl* simCtrl = static_cast<SimActorControl*> (GetGameManager()->GetComponentByName(C_COMP_ACTOR_CONTROLLER));

		if ( simCtrl != NULL )
			proxy = simCtrl->GetMissileActors( VID, weaponID, launcherID, missileID, missileNum);

		if( proxy.valid())
		{  
			dtCore::RefPtr<MissilesActor> Missile = static_cast<MissilesActor*>(proxy->GetActor());
			dtGame::GameActorProxy &Mis = Missile->GetGameActorProxy();

			osg::Vec3 MissilePos;
			MissilePos = Mis.GetTranslation();	

			MissileExplode(weaponID, MissilePos.x(), MissilePos.y(), MissilePos.z(), 0);
		}

		std::cout<<"Send Status fired on VehicleID = "<<VID<<" by missileid = "<< missileID <<std::endl;

	} else if ( missileStatus == ST_MISSILE_DEL )
	{
		/// send ke 2D Instruktur delete actor
		mPos.ShipID = VID;
		mPos.WeaponID = weaponID;
		mPos.LauncherID = launcherID;
		mPos.MissileID = missileID;
		mPos.MissileNum = missileNum;
		mPos.heading = 0;
		mPos.speed = 0;
		mPos.x = 0;
		mPos.y = 0;
		mPos.z = 0;

		mPos.Status = ST_MISSILE_DEL;
		SendClientEx(structMissilePos, (char *)  &mPos);

		SimActorControl* simCtrl = static_cast<SimActorControl*> (GetGameManager()->GetComponentByName(C_COMP_ACTOR_CONTROLLER));
		if ( simCtrl != NULL )
		{
			std::cout<< " send to 2D & receive message delete actor with config :: " <<VID<<"-"<<weaponID<<"-"<<launcherID<<"-"<<missileID<<"-"<<missileNum<< std::endl;
			simCtrl->DeleteMissileActors(VID,weaponID,launcherID,missileID, missileNum);
		}
	} else if ( missileStatus == ST_MISSILE_LOADED || missileStatus == ST_MISSILE_UNLOCK || missileStatus == ST_MISSILE_LOCK)
	{
		/// send ke 2D Instruktur actor loaded 
		mPos.ShipID = VID;
		mPos.WeaponID = weaponID;
		mPos.LauncherID = launcherID; 
		mPos.MissileID = missileID;
		mPos.MissileNum = missileNum;
		mPos.heading = 0;
		mPos.speed = 0;
		mPos.x = 0;
		mPos.y = 0;
		mPos.z = 0;

		mPos.Status = missileStatus;

		std::cout << "send info missile load/unlock/lock"<< mPos.ShipID << "-" << mPos.WeaponID << "-" <<mPos.LauncherID
			<< "-" << mPos.MissileID << "-" << mPos.MissileNum <<" socket to instruktur 2D" <<std::endl;

		SendClientEx(structMissilePos, (char *)  &mPos);
	}  
}

/////////////////////////////////////////////////////////////////////////
// VID = shipID ( c0 ), shipType ( c1 ) ( ship / submarine ),  status ( c2 ) 
/////////////////////////////////////////////////////////////////////////

void CSocketServer::SetShipStatus( const int VID, const int shipStatus  )
{
	spOrder mOrder;
	if ( shipStatus == ORD_SHIP_DEL )
	{
		mOrder.ShipID = VID;
		mOrder.OrderID = ORD_SHIP_DEL;
		SendClientEx(structOrderID, (char *)  &mOrder);
		std::cout<<"Send Status delete ship to 2D, VehicleID " <<std::endl;
	}
}