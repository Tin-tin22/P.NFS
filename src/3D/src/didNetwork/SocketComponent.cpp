#include "../didNetwork/SocketComponent.h"

#include "..\didNetwork\Win32Tools\Utils.h"
#include "..\didNetwork\Win32Tools\Exception.h"

#define _WINSOCKAPI_
#ifndef WIN32_LEAN_AND_MEAN
#define WIN32_LEAN_AND_MEAN
#endif
#include <dtUtil/mswin.h>
#pragma comment(lib, "ws2_32.lib")

#include <assert.h>
#include <exception>


using JetByteTools::Win32::CIOBuffer;
using JetByteTools::Win32::Output;
using JetByteTools::Win32::CException;
using JetByteTools::Win32::CCriticalSection;


IMPLEMENT_ENUM(CSocketComponent::DestinationType);

const CSocketComponent::DestinationType CSocketComponent::DestinationType::DESTINATION("Destination");
const CSocketComponent::DestinationType CSocketComponent::DestinationType::ALL_CLIENTS("All Clients");
const CSocketComponent::DestinationType CSocketComponent::DestinationType::ALL_NOT_CLIENTS("All Not Clients");

CSocketComponent::CSocketComponent(
	const std::string &gameName, 
	const int gameVersion, 
	const std::string &logFile,
    const std::string &componentName,
	//const JetByteTools::Win32::ICriticalSectionFactory &lockFactory,
    unsigned long addressToListenOn,
    unsigned short portToListenOn,
    size_t maxFreeSockets,
    size_t maxFreeBuffers,
    size_t bufferSize,
    size_t numThreads)
    :  JetByteTools::Win32::CSocketServer(/*lockFactory,*/addressToListenOn, portToListenOn, maxFreeSockets, maxFreeBuffers, bufferSize, numThreads),
      dtGame::GMComponent(componentName)
{
	IsShuttingDown  = false;
	m_addressToListenOn  = addressToListenOn;
	localBuffer = CIOBuffer::Allocator::Allocate();
}

CSocketComponent::~CSocketComponent(void)
{
	localBuffer->Release();
}

void CSocketComponent::OnAddedToGM()
{
	dtGame::MessageFactory& msgFactory = GetGameManager()->GetMessageFactory();
	if (!msgFactory.IsMessageTypeSupported(dtGame::MessageType::NETCLIENT_REQUEST_CONNECTION))
		msgFactory.RegisterMessageType<dtGame::Message>(dtGame::MessageType::NETCLIENT_REQUEST_CONNECTION);
	if (!msgFactory.IsMessageTypeSupported(dtGame::MessageType::INFO_CLIENT_CONNECTED))
		msgFactory.RegisterMessageType<dtGame::Message>(dtGame::MessageType::INFO_CLIENT_CONNECTED);

	if (!msgFactory.IsMessageTypeSupported(dtGame::MessageType::NETSERVER_ACCEPT_CONNECTION))
		msgFactory.RegisterMessageType<dtGame::Message>(dtGame::MessageType::NETSERVER_ACCEPT_CONNECTION);
	if (!msgFactory.IsMessageTypeSupported(dtGame::MessageType::NETCLIENT_NOTIFY_DISCONNECT))
		msgFactory.RegisterMessageType<dtGame::Message>(dtGame::MessageType::NETCLIENT_NOTIFY_DISCONNECT);
}

void CSocketComponent::ReadCompleted( //on retrieve data
   Socket *pSocket,
   CIOBuffer *pBuffer)
{
	CCriticalSection::Owner lock(m_networkManipulationSection);
	//std::cout<<"p:"<<int(&m_networkManipulationSection)<<std::endl;
	
	try
	{
		/*
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

			if ((pSocket->FBufferSizeKnown) && (pSocket->FBufferNow>= pSocket->FBufferSize+ 8)) 
			{
				p= pSocket->FBuffer+ 4;

				if ((p[0] == 'S')&&(p[1] == 'C')&&(p[2] == 'S'))  { 
					p= pSocket->FBuffer+ 8;
					dtUtil::DataStream stream;//(const_cast<char *> (buf->GetBuffer()),iSize);
					stream.WriteBinary(p,pSocket->FBufferSize);;
					OnReceivedDataStream(pSocket,stream);
				}
				
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
		*/
		
		
		//CIOBuffer *buf;
		unsigned int iSize;
		char * cstr;
		cstr = new char[4];
		bool incomplete = false;

		localBuffer->AddData(pBuffer->GetBuffer(),pBuffer->GetUsed());
					
		while ((localBuffer->GetUsed() > 8)&&(!incomplete))
		{
			CopyMemory(cstr, localBuffer->GetBuffer(),4);
			if ((cstr[0] == 'S')&&(cstr[1] == 'C')&&(cstr[2] == 'S'))  { 
				CopyMemory(&(iSize), localBuffer->GetBuffer()+4,4); //read size
				char * bufchar;
				bufchar = new char[iSize];
				if ((localBuffer->GetUsed() >= iSize+4)&&(iSize > 0)) 
				{
					
					localBuffer->ConsumeAndRemove(8); //size read
					//buf = localBuffer->SplitBuffer(iSize); //get message
					CopyMemory(bufchar, localBuffer->GetBuffer(),iSize);
					localBuffer->ConsumeAndRemove(iSize); 
					dtUtil::DataStream stream;//(const_cast<char *> (buf->GetBuffer()),iSize);
					//for (int i = 0; i < iSize; i++) {
					//	stream<<buf->GetBuffer()[i];
					//}
					stream.WriteBinary(bufchar,iSize);
					OnReceivedDataStream(pSocket,stream);
					//buf->Release();
				}
				else {
					// std::cout<<"packet busuk didalam ukuran "<<localBuffer->GetUsed()<<std::endl;
					incomplete = true;
				}
				delete[] bufchar;

			}
			else {
				std::cout<<"packet busuk ukuran "<<localBuffer->GetUsed()<<std::endl;
				incomplete = true;
			}
		}
		/*
		if (localBuffer->GetUsed() <= 0) 
		{
			localBuffer->Release();
			localBuffer = CIOBuffer::Allocator::Allocate();
		}
		*/
		
		delete[] cstr;
		pSocket->Read();
		
	}
	catch(const CException &e)
	{
		Output(_T("ReadCompleted - Exception - ") + e.GetWhere() + _T(" - ") + e.GetMessage());
		pSocket->Shutdown();
		GetGameManager()->GetApplication().Quit();
	}
	catch(...)
	{
		Output(_T("ReadCompleted - Unexpected Exception"));
		pSocket->Shutdown();
		GetGameManager()->GetApplication().Quit();
	}
}

void CSocketComponent::SendToServer(const dtGame::Message& message) 
{
	//CSocket listeningSocket(m_listeningSocket);
	SendNetworkMessage(message, m_outboundSocket);
}

void CSocketComponent::ShutdownNetwork() //shutdown
{
	IsShuttingDown = true;
	InitiateShutdown();
	//Terminate();
	return;
}

int CSocketComponent::GetClientsNumber()
{
	return m_activeList.Count();
}

void CSocketComponent::DisconnectMachine(const dtGame::MachineInfo *machineInfo)
{
	//CCriticalSection::Owner lock(m_machineMap);
	for (std::map <Socket*,dtCore::RefPtr<dtGame::MachineInfo> >::iterator p = MachineList.begin(); p!=MachineList.end();++p)
	{
		if ((*p).second.get()->GetUniqueId() == machineInfo->GetUniqueId()) 
		{
			MachineList.erase(p);
			(*p).first->Close();	
			return;
		}
	}
}

void CSocketComponent::RemoveClient(Socket *pSocket) 
{
	//CCriticalSection::Owner lock(m_clientVector);
	for (std::vector <Socket*>::iterator p = ClientList.begin(); p!=ClientList.end();++p)
	{
		if ((*p) == pSocket) 
		{
			//(*p).first->Close();	
			ClientList.erase(p);
			return;
		}
	}
}

void CSocketComponent::RemoveMachine(Socket *pSocket) 
{
	//CCriticalSection::Owner lock(m_machineMap);
	for (std::map <Socket*,dtCore::RefPtr<dtGame::MachineInfo> >::iterator p = MachineList.begin(); p!=MachineList.end();++p)
	{
		if ((*p).first == pSocket) 
		{
			MachineList.erase(p);
			return;
		}
	}
}

bool CSocketComponent::isSocketClient(Socket *pSocket)
{
	//check connected client 
	for (std::vector<Socket*>::iterator p = ClientList.begin(); p!=ClientList.end();++p)
	{
		if ((*p) == pSocket) return true;
	}

	return false;
}

//data translators
void CSocketComponent::OnReceivedDataStream(Socket *pSocket, dtUtil::DataStream& dataStream)
{
	try {
		dtCore::RefPtr<dtGame::Message> message; 
		//CCriticalSection::Owner lock(m_networkManipulationSection);
		//converted to Socket Server
		if(!isSocketClient(pSocket))//!networkBridge.IsConnectedClient()) 
		{
			// Read MessageType::mId for special case
			dataStream.Rewind();
			unsigned short msgId = 0;
			dataStream.Read(msgId);
			dataStream.Rewind();
			
			if(msgId == dtGame::MessageType::NETCLIENT_REQUEST_CONNECTION.GetId() 
				|| msgId == dtGame::MessageType::NETSERVER_ACCEPT_CONNECTION.GetId()) 
			{
				message = CreateMessage(dataStream, pSocket);
			
				//Set the MachineInfo of the Socket
				dtCore::RefPtr<dtGame::MachineInfo> clientInfo = new dtGame::MachineInfo();
				clientInfo->SetName(message->GetSource().GetName());
				clientInfo->SetUniqueId(message->GetSource().GetUniqueId());
				clientInfo->SetHostName(message->GetSource().GetHostName());
				clientInfo->SetIPAddress(message->GetSource().GetIPAddress());
				clientInfo->SetTimeStamp(message->GetSource().GetTimeStamp());
				clientInfo->SetPing(message->GetSource().GetPing());

				MachineList.insert(MachinePair(pSocket,clientInfo));

				dataStream.Rewind();
				message.release();
			}
			else 
			{
				LOG_DEBUG("Received DataStream with MessageType " + dtUtil::ToString(msgId) + " while not being a client.");
			}
		}
		// create message, again maybe but with proper Source!
		dataStream.Rewind();
		message = CreateMessage(dataStream,pSocket);
		//if (message->GetMessageType() == dtGame::MessageType::INFO_ACTOR_CREATED) 
		//	Output(_T("got msg - ")+message->GetMessageType().GetName());
		OnReceivedNetworkMessage(*message, pSocket);
		message.release();
	} catch (...) {
		Output(_T("Unexpected Exception - OnReceivedDataStream"));
		return;
	}
}

void CSocketComponent::OnReceivedNetworkMessage(const dtGame::Message& message, Socket *pSocket)
{
	//converted to Socket Server
	//lock network resource
	//CCriticalSection::Owner lock(m_networkManipulationSection);
	try {
		if(!isSocketClient(pSocket)) 
		{
			if(message.GetMessageType() == dtGame::MessageType::NETCLIENT_REQUEST_CONNECTION
				|| message.GetMessageType() == dtGame::MessageType::NETSERVER_ACCEPT_CONNECTION)
			{
				GetGameManager()->SendMessage(message);
				//store connected client 
				ClientList.push_back(pSocket);
			}
			else
			{
				LOG_ERROR("Received " + message.GetMessageType().GetName() + " while connection is not accepted.");
			}
		}
		else 
		{
			// Send the Message to our GameManagerMessageProcessor
			GetGameManager()->SendMessage(message);
		}
	} catch (...) {
		Output(_T("Unexpected Exception - OnReceivedNetworkMessage"));
		return;
	}
	//Output(_T("OnReceivedNetworkMessage done"));
    //automatic unlock Network resource
}

dtUtil::DataStream CSocketComponent::CreateDataStream(const dtGame::Message& message)
{
	//CCriticalSection::Owner lock(m_networkManipulationSection);
	dtUtil::DataStream stream;

	stream.Write(message.GetMessageType().GetId()); // MessageType.mId
	stream.Write(message.GetSource().GetUniqueId().ToString()); // Source
	//DONE: if mId = NETCLIENT_REQUEST_CONNECTION add hostname and ipaddress as String
	if (message.GetMessageType() == dtGame::MessageType::NETCLIENT_REQUEST_CONNECTION
		|| message.GetMessageType() == dtGame::MessageType::NETSERVER_ACCEPT_CONNECTION)
	{
		stream.Write(message.GetSource().GetHostName());
		stream.Write(message.GetSource().GetIPAddress());
	}
	if(message.GetDestination() != NULL) 
	{
		stream.Write(message.GetDestination()->GetUniqueId().ToString()); // Destination
	}
	else 
	{
		stream.Write(std::string(""));
	}
	stream.Write(message.GetSendingActorId().ToString()); // Sending Actor
	stream.Write(message.GetAboutActorId().ToString()); // About Actor

	message.ToDataStream(stream);

	if(message.GetCausingMessage() != NULL) {
		stream.AppendDataStream(CreateDataStream(*message.GetCausingMessage()));
		// append causing message??
	}

	return stream;
}

dtCore::RefPtr<dtGame::Message> CSocketComponent::CreateMessage(dtUtil::DataStream& dataStream, Socket *pSocket)
{
	//Output("Start Create Message"); 
	dtCore::RefPtr<dtGame::Message> msg;
	try {
		unsigned short msgId = 0;

		// MessageType.mId
		dataStream.Read(msgId);

		// Check if message is supported
		if(!GetGameManager()->GetMessageFactory().IsMessageTypeSupported(
				GetGameManager()->GetMessageFactory().GetMessageTypeById(msgId))) 
		{
			Output("Received an unsupported message. MessageId = " + dtUtil::ToString(msgId));
			return msg;
		}
		
		// Create Message 
		msg = GetGameManager()->GetMessageFactory().CreateMessage(GetGameManager()->GetMessageFactory().GetMessageTypeById(msgId));
		if(!msg.valid()) {
			Output("Error creating message from stream.");
			return msg;
		}
		std::string szUniqueId;
		std::string szHostName;
		std::string szIPAddress;

		// Source
		dataStream.Read(szUniqueId);
		//DONE: if mId = NETCLIENT_REQUEST_CONNECTION add hostname and ipaddress as String
		if (msg.get()->GetMessageType() == dtGame::MessageType::NETCLIENT_REQUEST_CONNECTION
			|| msg.get()->GetMessageType() == dtGame::MessageType::NETSERVER_ACCEPT_CONNECTION)
		{
			dataStream.Read(szHostName);
			dataStream.Read(szIPAddress);

			std::cout << "Client Info : " << szHostName << "/" << szIPAddress << "/" << GetGameManager()->GetRealClockTime() << std::endl; 

			//create new machine info
			dtCore::RefPtr<dtGame::MachineInfo> clientInfo = new dtGame::MachineInfo();
			clientInfo->SetName("New Connection");
			clientInfo->SetUniqueId(dtCore::UniqueId(szUniqueId));
			clientInfo->SetHostName(szHostName);
			clientInfo->SetIPAddress(szIPAddress);
			clientInfo->SetTimeStamp(GetGameManager()->GetRealClockTime());
			//clientInfo->SetPing(message->GetSource().GetPing());

			msg->SetSource(*clientInfo.get());
		}
		else 
		{
			msg->SetSource(*GetMachineInfo(dtCore::UniqueId(szUniqueId)));
		}
		// Destination
		dataStream.Read(szUniqueId);
		if(szUniqueId.size() != 0) 
		{
			msg->SetDestination(GetMachineInfo(dtCore::UniqueId(szUniqueId)));
		}

		// Sending Actor
		dataStream.Read(szUniqueId);
		msg->SetSendingActorId(dtCore::UniqueId(szUniqueId));

		// About Actor
		dataStream.Read(szUniqueId);
		msg->SetAboutActorId(dtCore::UniqueId(szUniqueId));

		msg->FromDataStream(dataStream);

		if(dataStream.GetRemainingReadSize() != 0) 
		{
			// more information, there must be a causing message!
			msg->SetCausingMessage((CreateMessage(dataStream, pSocket)).get());
		}
	} catch (dtUtil::Exception &e) {
		Output(_T("dtUtil Exception - OnCreateMessage : ")+e.What());
	} catch (...) {
		Output(_T("Unexpected Exception - OnCreateMessage"));
	}
	//Output("End Create Message"); 
	
	return msg;
}

const dtGame::MachineInfo* CSocketComponent::GetMachineInfo(const dtCore::UniqueId& uniqueId)
{
	//lock network resource
	//CCriticalSection::Owner lock(m_networkManipulationSection);
	
	//CCriticalSection::Owner lock(m_machineMap);
	if(uniqueId == GetGameManager()->GetMachineInfo().GetUniqueId()) 
    {
        return &(GetGameManager()->GetMachineInfo());
    }

	//get stored machine info
	for (std::map <Socket*,dtCore::RefPtr<dtGame::MachineInfo> >::iterator p = MachineList.begin(); p!=MachineList.end();++p)
	{
		if (uniqueId == (*p).second->GetUniqueId()) return (*p).second.get();
	}
	//automatic unlock Network resource
	return NULL;
}

//data sender
void CSocketComponent::SendClient(Socket *pSocket, const char* pPacket, int pSize)
{
	//lock network resource
	//CCriticalSection::Owner lock(m_networkManipulationSection);

	//std::cout<<"send msg size : "<<pSize<<std::endl;
	unsigned int size= 0;
	char *buffer;
	buffer= new char[1024*1024];
	std::string header = "SCS";

	size= pSize;
	CopyMemory(buffer, header.c_str(), 4);
	CopyMemory(buffer+ 4, &size, 4);
	CopyMemory(buffer+ 8, pPacket, size);
	pSocket->Write(buffer, size+ 8);
	//assert(size+8 < 1024);
	delete[] buffer;
	
	//unlock network resource (automatic)
}

//interfaces from GMComponent
void CSocketComponent::DispatchNetworkMessage(const dtGame::Message& message) //sending data
{
	//lock network resource
	//CCriticalSection::Owner lock(m_networkManipulationSection);
	bool messageDispatched = false;

	if(message.GetDestination() == NULL) {
        // No Destination
        
        // Send a connection request to all non-client connections, but only
        // if we are requesting a connection
        if(message.GetMessageType() == dtGame::MessageType::NETCLIENT_REQUEST_CONNECTION) {
            // This message should be send to connections which are not clients!
            SendNetworkMessage(message, DestinationType::ALL_NOT_CLIENTS);
			messageDispatched = true;
        }
        else {
            // Send message to all ClientConnections, default behavior for null destination!
            SendNetworkMessage(message, DestinationType::ALL_CLIENTS);
			messageDispatched = true;
        }
    }
    else {
        // trying to send a message across the network to ourselves
        if(message.GetDestination()->GetUniqueId() == GetGameManager()->GetMachineInfo().GetUniqueId()) {
            GetGameManager()->SendMessage(message);
			messageDispatched = true;
        }
        else {
            SendNetworkMessage(message);
			messageDispatched = true;
        }
    }

	//assert(messageDispatched);
	//unlock network resource (automatic)
}
void CSocketComponent::SendNetworkMessage(const dtGame::Message& message, Socket *pSocket)
{
	//lock network resource
	//CCriticalSection::Owner lock(m_networkManipulationSection);

    if(IsShuttingDown)
        return;

	if (message.GetMessageType() == dtGame::MessageType::INFO_ACTOR_CREATED) 
		Output(_T("Send1 via network ")+message.GetMessageType().GetName());

	// Create the MessageDataStream
	dtUtil::DataStream dataStream = CreateDataStream(message);

	SendClient(pSocket,dataStream.GetBuffer(),dataStream.GetBufferSize());

	//unlock network resource (automatic)
}

void CSocketComponent::SendNetworkMessage(const dtGame::Message& message, const DestinationType& destinationType)
{
	//lock network resource
	//CCriticalSection::Owner lock(m_networkManipulationSection);

    if(IsShuttingDown)
        return;

	//if (message.GetMessageType() == dtGame::MessageType::INFO_ACTOR_CREATED) 
	//	Output(_T("Send2 via network ")+message.GetMessageType().GetName());

	bool messageSent = false;

	//if (message.GetMessageType() == SimMessageType::NOTIFY_LOGIN) std::cout<<C_MT_NOTIFY_LOGIN<<std::endl;
	//if (message.GetMessageType() == dtGame::MessageType::INFO_ACTOR_CREATED) std::cout<<"Create actor : "<<message.GetSendingActorId().ToString()<<std::endl;

    // Create the MessageDataStream
	dtUtil::DataStream dataStream = CreateDataStream(message);

    if(destinationType == DestinationType::DESTINATION) 
    {
		//CCriticalSection::Owner lock(m_machineMap);
		//send message to destination
		for (std::map <Socket*,dtCore::RefPtr<dtGame::MachineInfo> >::iterator p = MachineList.begin(); p!=MachineList.end();++p)
		{
			if ((*p).second.get()->GetUniqueId() == message.GetDestination()->GetUniqueId())
			{
				SendClient((*p).first,dataStream.GetBuffer(),dataStream.GetBufferSize());
				messageSent = true;
				return;
			}
		}
    } // DestinationType::DESTINATION
    else 
    {
        if(destinationType == DestinationType::ALL_CLIENTS) 
        { 
			//CCriticalSection::Owner lock(m_clientVector);
	
			//send message to all clients whose connection had been accepted
			for (std::vector<Socket*>::iterator p = ClientList.begin(); p!=ClientList.end();++p)
			{
				SendClient((*p),dataStream.GetBuffer(),dataStream.GetBufferSize());
				messageSent = true;
			}
        } // DestinationType::ALL_CLIENTS
        else 
        { // DestinationType::ALL_NOT_CLIENTS   
            
			//send message to all clients whose connection had not been accepted
			Socket *pSock = m_activeList.Head();
			int i= 0;
			bool isConnected;
			//CCriticalSection::Owner lock(m_clientVector);

			while (pSock)
			{
				isConnected = false;
	
				for (std::vector<Socket*>::iterator p = ClientList.begin(); p!=ClientList.end();++p)
				{
					if ((*p)==pSock) {
						isConnected = true;
						break;
					}
				}

				if (!isConnected) 
				{
					SendClient(pSock,dataStream.GetBuffer(),dataStream.GetBufferSize());
					messageSent = true;
				}

				pSock= SocketList::Next(pSock);
				i++;
			}			
        } // DestinationType::ALL_NOT_CLIENTS
    }
	
	//assert(messageSent);
    //unlock network resource (automatic)
}

void CSocketComponent::ProcessMessage(const dtGame::Message& message) //process data from manager
{
	if (GetGameManager() == NULL)
    {
        LOG_ERROR("This component is not assigned to a GameManager, but received a message.  It will be ignored.");         
        return;
    }  

    if (message.GetDestination() != NULL && GetGameManager()->GetMachineInfo().GetUniqueId()!= message.GetDestination()->GetUniqueId())
    {
        LOG_DEBUG("Received message has a destination set to a different GameManager than this one. It will be ignored.");         
        return;
    }

	// Forward all messages to the appropriate function
    if (message.GetMessageType() == dtGame::MessageType::NETCLIENT_REQUEST_CONNECTION)
        ProcessNetClientRequestConnection(message);

    else if(message.GetMessageType() == dtGame::MessageType::NETSERVER_ACCEPT_CONNECTION)
        ProcessNetServerAcceptConnection(message);

    else if(message.GetMessageType() == dtGame::MessageType::NETSERVER_REJECT_CONNECTION)
        ProcessNetServerRejectConnection(static_cast<const dtGame::NetServerRejectMessage&>(message));

    else if(message.GetMessageType() == dtGame::MessageType::INFO_CLIENT_CONNECTED)
        ProcessInfoClientConnected(message);

    else if(message.GetMessageType() == dtGame::MessageType::NETCLIENT_NOTIFY_DISCONNECT)
        ProcessNetClientNotifyDisconnect(message);

    else if(message.GetMessageType() == dtGame::MessageType::SERVER_REQUEST_REJECTED)
        ProcessNetServerRejectMessage(static_cast<const dtGame::ServerMessageRejected&>(message));
}

//interfaces from CSocketServer
void CSocketComponent::OnStartAcceptingConnections()
{

}

void CSocketComponent::OnStopAcceptingConnections()
{
	//Output(_T("OnStopAcceptingConnections"));
}

void CSocketComponent::OnShutdownInitiated()
{
	//Output(_T("OnShutdownInitiated"));
}

void CSocketComponent::OnShutdownComplete()
{
	Output(_T("OnShutdownComplete"));
}

void CSocketComponent::OnConnectionCreated()
{
	//Output(_T("OnConnectionCreated"));
}

void CSocketComponent::OnConnectionEstablished(
    Socket *pSocket,
    JetByteTools::Win32::CIOBuffer *pAddress)
{
	pSocket->Read();
}

void CSocketComponent::OnConnectionClientClose(
    Socket *pSocket)
{
	//Output(_T("OnConnectionClientClose"));
}

void CSocketComponent::OnConnectionReset(
    Socket *pSocket)
{
	//Output(_T("OnConnectionReset"));
}

bool CSocketComponent::OnConnectionClosing(
    Socket *pSocket)
{
	pSocket->Close();
	Output(_T("OnConnectionClosing"));
	return true;
}

void CSocketComponent::OnConnectionClosed(
    Socket *pSocket)
{
	Machines::iterator p = MachineList.find(pSocket);
	dtGame::MachineInfo* machine = (*p).second.get();
	std::cout << "Connection from "<<machine->GetIPAddress()<<" closed" << std::endl;
	//Output("Connection from "+machine->GetIPAddress()+" closed");
	RemoveClient(pSocket);
	RemoveMachine(pSocket);
	//Output(_T("OnConnectionClosed"));
}

void CSocketComponent::OnConnectionDestroyed()
{

}


void CSocketComponent::OnConnectionError(
    ConnectionErrorSource source,
    Socket *pSocket,
    JetByteTools::Win32::CIOBuffer *pBuffer,
    DWORD lastError)
{
	const LPCTSTR errorSource = (source == ZeroByteReadError ? _T(" Zero Byte Read Error:") : (source == ReadError ? _T(" Read Error:") : _T(" Write Error:")));
	Output(_T(errorSource));
}


void CSocketComponent::OnError(
    const JetByteTools::Win32::_tstring &message)
{
	Output(_T(message));
}


void CSocketComponent::OnBufferCreated()
{

}

void CSocketComponent::OnBufferAllocated()
{

}

void CSocketComponent::OnBufferReleased()
{

}

void CSocketComponent::OnBufferDestroyed()
{

}


void CSocketComponent::OnThreadCreated()
{

}

void CSocketComponent::OnThreadBeginProcessing()
{

}

void CSocketComponent::OnThreadEndProcessing()
{

}

void CSocketComponent::OnThreadDestroyed()
{
	//Output(_T("thread mati!"));
}
