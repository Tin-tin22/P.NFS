#if defined (_MSC_VER) && (_MSC_VER >= 1020)
#pragma once
#endif

//++ BAWE-20101025: LEAK DETECTION
#ifdef USE_VLD

#include <vld.h>

#endif
//++ BAWE-20101025: LEAK DETECTION

#ifndef GM_SOCKET_SERVER_INCLUDED__
#define GM_SOCKET_SERVER_INCLUDED__

#include ".\SocketComponent.h"

#include <dtGame\gamemanager.h>
#include <dtGame/messagetype.h>
#include <dtGame/messagefactory.h>

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

class CSocketServerGM :
	public CSocketComponent
{
public:

	//friend class CSocketComponent;
	/**
	*	constructor
	*/
	CSocketServerGM(
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

	/**
	*	destructor
	*/
	~CSocketServerGM(void);
	
	/**
	*	flag if accepting client, currently always true
	*/
	bool acceptClient;

	/**
	*	Start up the server
	*/
	bool SetupServer(void);

	/**
    * Processes a MessageType::NETCLIENT_REQUEST_CONNECTION Message.
    * @param msg The message
    */
	virtual void ProcessNetClientRequestConnection(const dtGame::Message& msg);

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
    virtual void ProcessInfoClientConnected(const dtGame::Message& msg);

    /**
    * Processes a MessageType::NETCLIENT_NOTIFY_DISCONNECT Message.
    * @param msg The message
    */
    virtual void ProcessNetClientNotifyDisconnect(const dtGame::Message& msg);

    /**
    * Processes a MessageType::SERVER_REQUEST_REJECTED Message.
    * @param msg The message
    */
    virtual void ProcessNetServerRejectMessage(const dtGame::Message& msg) { };

};

#endif // GM_SOCKET_SERVER_INCLUDED__

