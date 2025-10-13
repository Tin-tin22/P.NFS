#if defined (_MSC_VER) && (_MSC_VER >= 1020)
#pragma once
#endif

#ifdef USE_VLD
#include <vld.h>
#endif

#ifndef SOCKET_COMPONENT_INCLUDED__
#define SOCKET_COMPONENT_INCLUDED__

#include <list>
#include <vector>

#include <dtGame/GMComponent.h>
#include <dtGame/gameapplication.h>
#include <dtGame/gamemanager.h>
#include <dtGame/message.h>
#include <dtGame/messagetype.h>
#include <dtGame/messagefactory.h>
#include <dtGame/basemessages.h>

#include "..\didNetwork\Win32Tools\SocketServer.h"
#include "../didNetwork/Win32Tools/Exception.h"
#include "../didNetwork/Win32Tools/Socket.h"
#include <iostream>

#define DEBUG_ONLY



///////////////////////////////////////////////////////////////////////////////
// Classes defined in other files...
///////////////////////////////////////////////////////////////////////////////

namespace JetByteTools
{
   namespace Win32
   {
      class CIOCompletionPort;
   }
}

//class MachineInfoMessage;

class CSocketComponent :
	public JetByteTools::Win32::CSocketServer
	,public dtGame::GMComponent
{
	
protected:
	/**
	*	shutdown flag
	*/
	bool IsShuttingDown;

	/**
	* stored target address
	*/
	unsigned long m_addressToListenOn;
	
    /**
    * @class DestinationType
    * @brief enumeration class to address different stored connections
    */
    class DestinationType : public dtUtil::Enumeration
    {
        DECLARE_ENUM(DestinationType);
    public:
        static const DestinationType DESTINATION;
        static const DestinationType ALL_CLIENTS;
        static const DestinationType ALL_NOT_CLIENTS;

    private:
        DestinationType(const std::string &name) : dtUtil::Enumeration(name)
        {
            AddInstance(this);
        }
        virtual ~DestinationType() {}
    };
public:

	class JetByteTools::Win32::CSocketServer;
	friend class JetByteTools::Win32::CSocketServer;
	/**
	*	constructor
	*/
	CSocketComponent(
		 const std::string &gameName, 
		 const int gameVersion, 
		 const std::string &logFile,
		 const std::string &componentName,
		 //const JetByteTools::Win32::ICriticalSectionFactory &lockFactory,
         unsigned long addressToListenOn = INADDR_ANY, //listen all
         unsigned short portToListenOn = 7000,
         size_t maxFreeSockets = 10,
         size_t maxFreeBuffers = 1,
         size_t bufferSize = 1024,
         size_t numThreads = 0);

	/**
	*	destructor
	*/
	~CSocketComponent(void);
	
	/**
	*	typedefs for machineinfo-socket map
	*/
	typedef std::map <Socket*,dtCore::RefPtr<dtGame::MachineInfo> > Machines;
	typedef std::pair<Socket*,dtCore::RefPtr<dtGame::MachineInfo> > MachinePair;
	
	/**
	*	map of client machineinfos, with sockets as keys
	*/
	Machines MachineList;
	
	/**
	*	vector of accepted clients 
	*/
	std::vector <Socket*> ClientList;

	/**
	*	Shutdown the Server, server stop receiving/sending data
	*/
	void ShutdownNetwork();

	/**
	*	additional initialization of component
	*/
	virtual void OnAddedToGM();

	/**
	*	necessary virtual from GMComponent, used for sending network message
	*/
	virtual void DispatchNetworkMessage(const dtGame::Message& message);
	
	/**
	*	necessary virtual from GMComponent, used for processing local message
	*/
	virtual void ProcessMessage(const dtGame::Message& message);
	
	/**
	*	SendClient wrapper, used in various functions which copied from dtNetGM
	*/
	void SendNetworkMessage(const dtGame::Message& message, const DestinationType& destinationType = DestinationType::DESTINATION);

	/**
	*	SendClient wrapper, used in client
	*/
	void SendNetworkMessage(const dtGame::Message& message, Socket *pSocket);

	/**
	*	get number of connected client, wether accepted or not
	*/
	int GetClientsNumber();
	
	/**
	*	disconnect single connection to decribed client 
	*/
	void DisconnectMachine(const dtGame::MachineInfo *machineInfo);

	/**
	*	remove single machine from list 
	*/
	void RemoveMachine(Socket *pSocket);

	/**
	*	remove single socket from list 
	*/
	void RemoveClient(Socket *pSocket);

	/**
	*	send data to single client
	*/
	void SendClient(Socket *pSocket, const char* pPacket, int pSize);

	/**
	*	critical section for network resource
	*	INFO : critical section to lock a thread, mutex to lock a process
	*/
	JetByteTools::Win32::CCriticalSection m_networkManipulationSection; 

	/**
	*	critical section for machine map manipulation
	*/
	//JetByteTools::Win32::CCriticalSection m_machineMap; 

	/**
	*	critical section for client vector manipulation
	*/
	//JetByteTools::Win32::CCriticalSection m_clientVector; 

	/**
    * Processes a MessageType::NETCLIENT_REQUEST_CONNECTION Message.
    * @param msg The message
    */
	virtual void ProcessNetClientRequestConnection(const dtGame::Message& msg) { };

    /**
    * Processes a MessageType::NETSERVER_ACCEPT_CONNECTION Message.
    * @param msg The message
    */
    virtual void ProcessNetServerAcceptConnection(const dtGame::Message& msg) { };

    /**
    * Processes a MessageType::NETSERVER_REJECT_CONNECTION Message.
    * @param msg The message
    */
	virtual void ProcessNetServerRejectConnection(const dtGame::Message& msg) { };

    /**
    * Processes a MessageType::INFO_CLIENT_CONNECTED Message.
    * @param msg The message
    */
    virtual void ProcessInfoClientConnected(const dtGame::Message& msg) { };

    /**
    * Processes a MessageType::NETCLIENT_NOTIFY_DISCONNECT Message.
    * @param msg The message
    */
    virtual void ProcessNetClientNotifyDisconnect(const dtGame::Message& msg) { };

    /**
    * Processes a MessageType::SERVER_REQUEST_REJECTED Message.
    * @param msg The message
    */
    virtual void ProcessNetServerRejectMessage(const dtGame::Message& msg) { };

	//SOCKET CreateOutboundSocket(unsigned long address, unsigned short port);

	//JetByteTools::Win32::CSocketServer::Socket *Connect(const sockaddr_in &address);

	//JetByteTools::Win32::CSocketServer::Socket *AllocateSocket(SOCKET theSocket);

	//void ConnectServer();

	void SendToServer(const dtGame::Message& message);

	bool isSocketClient(Socket *pSocket);


private :
	//CSocketServer::Socket m_OutboundSocket;


	JetByteTools::Win32::CIOBuffer *localBuffer;
	
	/**
	*	Creating data stream from message, taken directly from dtNetGM/servercomponent
	*/
	dtUtil::DataStream CSocketComponent::CreateDataStream(const dtGame::Message& message);
	
	/**
	*	Creating message from data stream, taken directly from dtNetGM/servercomponent
	*/
	dtCore::RefPtr<dtGame::Message> CreateMessage(dtUtil::DataStream& dataStream, Socket *pSocket);
	
	/**
	*	search for a client machine info, based on its UniqueID
	*/
	const dtGame::MachineInfo* GetMachineInfo(const dtCore::UniqueId& uniqueId);
	
	/**
	*	first handler of received data, taken directly from dtNetGM/servercomponent
	*/
	void OnReceivedDataStream(Socket *pSocket, dtUtil::DataStream& dataStream);
    
	/**
	*	second handler of received data, taken directly from dtNetGM/servercomponent
	*/
	void OnReceivedNetworkMessage(const dtGame::Message& message, Socket *pSocket);

	virtual void OnStartAcceptingConnections();
    virtual void OnStopAcceptingConnections();
    virtual void OnShutdownInitiated();
    virtual void OnShutdownComplete();

    virtual void OnConnectionCreated();
    virtual void OnConnectionEstablished(
        Socket *pSocket,
        JetByteTools::Win32::CIOBuffer *pAddress);
    virtual void OnConnectionClientClose(
        Socket *pSocket);
    virtual void OnConnectionReset(
        Socket *pSocket);
    virtual bool OnConnectionClosing(
        Socket *pSocket);
    virtual void OnConnectionClosed(
        Socket *pSocket);
    virtual void OnConnectionDestroyed();

    virtual void OnConnectionError(
        ConnectionErrorSource source,
        Socket *pSocket,
        JetByteTools::Win32::CIOBuffer *pBuffer,
        DWORD lastError);

    virtual void OnError(
        const JetByteTools::Win32::_tstring &message);

    virtual void OnBufferCreated();
    virtual void OnBufferAllocated();
    virtual void OnBufferReleased();
    virtual void OnBufferDestroyed();

    virtual void OnThreadCreated();
    virtual void OnThreadBeginProcessing();
    virtual void OnThreadEndProcessing();
    virtual void OnThreadDestroyed();

    /**
	*	data receiver
	*/
	virtual void ReadCompleted(
        Socket *pSocket,
        JetByteTools::Win32::CIOBuffer *pBuffer);

    const std::string m_welcomeMessage;
/*
	virtual SOCKET CreateListeningSocket(
         unsigned long address,
         unsigned short port);
*/
	//void CSocketComponent::Connect(SOCKET s, const SOCKADDR_IN &address);
};

#endif // SOCKET_COMPONENT_INCLUDED__

