#include ".\socketclientgm.h"
#include "..\didNetwork\Win32Tools\Utils.h"
#include "..\didNetwork\Win32Tools\Exception.h"
#include <dtABC/application.h>

using JetByteTools::Win32::CCriticalSection;
using JetByteTools::Win32::CException;
using JetByteTools::Win32::Output;

CSocketClientGM::CSocketClientGM(
	const std::string &gameName, 
	const int gameVersion, 
	const std::string &logFile,
	//const JetByteTools::Win32::ICriticalSectionFactory &lockFactory,
    unsigned long addressToListenOn,
    unsigned short portToListenOn,
    size_t maxFreeSockets,
    size_t maxFreeBuffers,
    size_t bufferSize,
    size_t numThreads)
    :  CSocketComponent(gameName,gameVersion,logFile,"ClientNetworkComponent",// lockFactory,
		addressToListenOn, portToListenOn, maxFreeSockets, maxFreeBuffers, bufferSize, numThreads)
{
	mAcceptedClient = false;
}

CSocketClientGM::~CSocketClientGM(void)
{
}

bool CSocketClientGM::SetupClient(unsigned long addressToListenOn,
    unsigned short portToListenOn
    ) //start client
{
	try 
	{
		isServer = false;
		//StartAcceptingConnections(INADDR_ANY);
		Start();
		
		Connect2Server();
		
		//Adjust HostName and IPAddress MachineInfo of the GameManager
		char ac[80];
		if (gethostname(ac, sizeof(ac)) == SOCKET_ERROR) {
			return false;
		}
		
		struct hostent *phe = gethostbyname(ac);
		if (phe == 0) {
			return false;
		}

		//for (int i = 0; phe->h_addr_list[i] != 0; ++i) {
		struct in_addr addr;
		memcpy(&addr, phe->h_addr_list[0], sizeof(struct in_addr));
		//}

		// Adjust MachineInfo of the GameManager
        GetGameManager()->GetMachineInfo().SetHostName(ac);
        GetGameManager()->GetMachineInfo().SetIPAddress(inet_ntoa(addr));
	
		
		dtCore::RefPtr<dtGame::Message> message;// = 
		GetGameManager()->GetMessageFactory().CreateMessage(dtGame::MessageType::NETCLIENT_REQUEST_CONNECTION, message);
		message->SetSource(GetGameManager()->GetMachineInfo());
		message->SetDestination(NULL);
		SendToServer(*message);
		
		//SendNetworkMessage(*message);
	}
	catch(const CException &e)
	{
		Output(e.GetWhere()+" "+e.GetMessage());
		return false;
	}

	return true;
}

void CSocketClientGM::OnConnectionError(
    ConnectionErrorSource source,
    Socket *pSocket,
    JetByteTools::Win32::CIOBuffer *pBuffer,
    DWORD lastError)
{
	GetGameManager()->GetApplication().Quit();
}

void CSocketClientGM::OnConnectionDropped() {
	//TODO : reconnect by sending INFO_CLIENT_CONNECTED
	if (!IsShuttingDown) {/*
		dtCore::RefPtr<dtGame::Message> message;// = 
		GetGameManager()->GetMessageFactory().CreateMessage(dtGame::MessageType::INFO_CLIENT_CONNECTED, message);
		message->SetSource(GetGameManager()->GetMachineInfo());
		message->SetDestination(NULL);
		SendToServer(*message);*/
		GetGameManager()->GetApplication().Quit();
	}
}

void CSocketClientGM::ProcessNetServerAcceptConnection(const dtGame::Message& msg)
{
	//store server machine info
	mMachineInfoServer = new dtGame::MachineInfo("Server");
	mMachineInfoServer->SetUniqueId(msg.GetSource().GetUniqueId());
	mMachineInfoServer->SetHostName(msg.GetSource().GetHostName());
	mMachineInfoServer->SetIPAddress(msg.GetSource().GetIPAddress());
	mMachineInfoServer->SetTimeStamp(msg.GetSource().GetTimeStamp());
	mMachineInfoServer->SetPing(msg.GetSource().GetPing());

	mAcceptedClient = true;

	//TODO : send login info
}

void CSocketClientGM::ProcessNetServerRejectConnection(const dtGame::Message& msg) 
{
	mAcceptedClient = false;
	GetGameManager()->GetApplication().Quit();
}

const dtGame::MachineInfo* CSocketClientGM::GetServer()
{
	if(mMachineInfoServer.valid()) 
    {
        return mMachineInfoServer.get();
    }
    else
    {
        return NULL;
    }
}
