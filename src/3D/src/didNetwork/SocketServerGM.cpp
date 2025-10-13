#include "..\didNetwork\socketservergm.h"
#include "..\didNetwork\Win32Tools\Utils.h"
#include "..\didNetwork\Win32Tools\Exception.h"

using JetByteTools::Win32::CCriticalSection;
using JetByteTools::Win32::CException;

CSocketServerGM::CSocketServerGM(
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
    :  CSocketComponent(gameName,gameVersion,logFile,"ServerNetworkComponent",// lockFactory,
		addressToListenOn, portToListenOn, maxFreeSockets, maxFreeBuffers, bufferSize, numThreads)
{
	acceptClient = true;
}

CSocketServerGM::~CSocketServerGM(void)
{
}

bool CSocketServerGM::SetupServer(void) //start server
{
	//CCriticalSection::Owner lock(m_networkManipulationSection);
	try 
	{ 
		Start();
		StartAcceptingConnections();
	}
	catch(const CException &e)
	{
		return false;
	}
	//Adjust HostName and IPAddress MachineInfo of the GameManager
	if (m_addressToListenOn == INADDR_ANY) 
	{
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
		
	}
	return true;
}

void CSocketServerGM::ProcessNetClientRequestConnection(const dtGame::Message& msg)
{
	//handle net client connect request
	if (acceptClient) 
	{
		//generate NETSERVER_ACCEPT_CONNECTION message 
		dtCore::RefPtr<dtGame::Message> message = 
			GetGameManager()->GetMessageFactory().CreateMessage(dtGame::MessageType::NETSERVER_ACCEPT_CONNECTION);
		message->SetDestination(&msg.GetSource());
		message->SetSource(GetGameManager()->GetMachineInfo());
		SendNetworkMessage(*message);
	}
	else 
	{
		//generate NETSERVER_REJECT_CONNECTION message 
		dtCore::RefPtr<dtGame::Message> message = 
			GetGameManager()->GetMessageFactory().CreateMessage(dtGame::MessageType::NETSERVER_REJECT_CONNECTION);
		message->SetDestination(&msg.GetSource());
		message->SetSource(GetGameManager()->GetMachineInfo());
		SendNetworkMessage(*message);
	}
}

void CSocketServerGM::ProcessNetClientNotifyDisconnect(const dtGame::Message& msg)
{
	//handle net client disconnect request, do logging on client
	if(*msg.GetDestination() != GetGameManager()->GetMachineInfo()) 
    {
        LOG_ERROR("Received client notify disconnect message from " + msg.GetSource().GetHostName() + ".");
    }
    else 
    {
        
    }
}

void CSocketServerGM::ProcessInfoClientConnected( const dtGame::Message& msg )
{
	//TODO : handle reconnecting client
}