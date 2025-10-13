#if defined (_MSC_VER) && (_MSC_VER >= 1020)
#pragma once
#endif

//++ BAWE-20101025: LEAK DETECTION
#ifdef USE_VLD

#include <vld.h>

#endif
//++ BAWE-20101025: LEAK DETECTION

#ifndef GM_SOCKET_CLIENT_INCLUDED__
#define GM_SOCKET_CLIENT_INCLUDED__

#include "../didNetwork/SocketComponent.h"

class CSocketClientGM :
	public CSocketComponent
{
public:
	CSocketClientGM(
		 const std::string &gameName, 
		 const int gameVersion, 
		 const std::string &logFile,
		 //const JetByteTools::Win32::ICriticalSectionFactory &lockFactory,
		 unsigned long addressToListenOn = INADDR_ANY, //listen all
         unsigned short portToListenOn = 7000,
         size_t maxFreeSockets = 10,
         size_t maxFreeBuffers = 1,
         size_t bufferSize = 1024*1024,
         size_t numThreads = 0);

	~CSocketClientGM(void);

	/**
	*	Start up the server
	*/
	bool SetupClient(unsigned long addressToListenOn,
		unsigned short portToListenOn
    );

	/**
    * Processes a MessageType::NETCLIENT_REQUEST_CONNECTION Message.
    * @param msg The message
    */
	virtual void ProcessNetClientRequestConnection(const dtGame::Message& msg) { };

    /**
    * Processes a MessageType::NETSERVER_ACCEPT_CONNECTION Message.
    * @param msg The message
    */
    virtual void ProcessNetServerAcceptConnection(const dtGame::Message& msg);

    /**
    * Processes a MessageType::NETSERVER_REJECT_CONNECTION Message.
    * @param msg The message
    */
	virtual void ProcessNetServerRejectConnection(const dtGame::Message& msg);

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

	virtual void OnConnectionError(
        ConnectionErrorSource source,
        Socket *pSocket,
        JetByteTools::Win32::CIOBuffer *pBuffer,
        DWORD lastError);

	virtual void OnConnectionDropped();
	/**
    * Reveals if a server has accepted our connectionrequest
    * @return boolean indicating if the server has accepted our connection request
    */  
    bool IsConnectedClient() { return mAcceptedClient; };

	/**
    * Returns the MachineInfo of the Server, or NULL if we don't have a accepted connection 
    * @return MachineInfo
    */  
    const dtGame::MachineInfo* GetServer();
private:
	// MachineInfo of the Server
	dtCore::RefPtr<dtGame::MachineInfo> mMachineInfoServer;

	// bool indicating if the server has accepted our connection
    bool mAcceptedClient; 
};

#endif // GM_SOCKET_CLIENT_INCLUDED__