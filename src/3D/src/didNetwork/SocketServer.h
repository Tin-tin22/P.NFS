#if defined (_MSC_VER) && (_MSC_VER >= 1020)
#pragma once
#endif

#ifdef USE_VLD
#include <vld.h>
#endif


#ifndef ECHO_SERVER_SOCKET_SERVER_INCLUDED__
#define ECHO_SERVER_SOCKET_SERVER_INCLUDED__
 
#include <dtGame\GMComponent.h>

/// include ini sementara harus di bawah seperti ini
#include "..\didNetwork\Win32Tools\CriticalSection.h"
#include "..\didNetwork\Win32Tools\SocketServer.h"
#include "..\didNetwork\Win32Tools\tstring.h"

// - waypoint [7/22/2014 EKA]
#include "../didUtils/SimActorDefinitions.h"

#define DEBUG_ONLY
 

namespace JetByteTools
{
   namespace Win32
   {
      class CIOCompletionPort;
   }
}


///////////////////////////////////////////////////////////////////////////////
// end of Structs
///////////////////////////////////////////////////////////////////////////////

//yoga added
class relocateSocket 
{
private:
protected:
public:
	relocateSocket();
	~relocateSocket(){};

	bool isEnable;
	char *tempP;
	unsigned int tempBuffSize;
	JetByteTools::Win32::CSocketServer::Socket *tempPSocket;
};

class CSocketServer : 
	public JetByteTools::Win32::CSocketServer//,
	,public dtGame::GMComponent
{
   public :
	  /**
	  *	critical section for network resource
	  *	INFO : critical section to lock a thread, mutex to lock a process
	  */
	  float TimeToTakeBuffer;	

	  JetByteTools::Win32::CCriticalSection m_networkManipulationSection; 
    
	  std::list<Socket*> m_socketList;
      std::list<Socket*>::iterator m_isocketList;

      CSocketServer(
         const std::string &welcomeMessage,
         unsigned long addressToListenOn,
         unsigned short portToListenOn,
         size_t maxFreeSockets,
         size_t maxFreeBuffers,
         size_t bufferSize = 1024,
         size_t numThreads = 0);
      
      void SendClient(Socket *pSocket, char* pPacket, int pSize);
      void SendClientEx(unsigned char pID, char* pBuffer, Socket *pSocket= NULL);

      std::vector< void(CSocketServer::*)(void*, int, Socket*) > vecProc;
      std::vector<int> vecSize;

      void ProcessOrderEvent(const dtGame::Message &message);
	  void processUtilityAndTools(const dtGame::Message &message);
	  void processLocalAsrockEvent(const dtGame::Message &message);

	  //yoga added
	  std::vector<relocateSocket*> mRelocateSocket;
	  void takeReloSockData(double aDt);
	  void addReloSockData(char *tempP, unsigned int tempBuffSize, Socket *tempSocket);

	  // - Object [7/17/2014 EKA]
	  std::vector<PWaypoint*> pWayp;

	  // - enable process message [7/21/2014 EKA]
	  bool enableProcessMessage;

   private :

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

      virtual void ReadCompleted(
         Socket *pSocket,
         JetByteTools::Win32::CIOBuffer *pBuffer);

      void EchoMessage(
         Socket *pSocket,
         JetByteTools::Win32::CIOBuffer *pBuffer) const;

      void PacketRecognizer(char* p, unsigned int size, Socket *pSocket);
      void RegisterProcedure(unsigned short int aID, void(CSocketServer::*proc)(void*, int, Socket*), unsigned int aSize);
      
      const std::string m_welcomeMessage;
      //unsigned int mTickLocalCounter;
	  //unsigned int mTickLocalCounterMissile;
	  float mTickLocalCounter;
	  float mTickLocalCounterMissile;

      // No copies do not implement
      CSocketServer(const CSocketServer &rhs);            
      CSocketServer &operator=(const CSocketServer &rhs); 
	  
	  void ProcessMessage(const dtGame::Message &msg);
      bool IsInvalidMessage(const dtGame::Message& msg);
      void HandleNetworkMessage(const dtGame::Message& msg);
      void HandleLocalMessage(const dtGame::Message& msg);
      void handlePacketPosition(void *pStruct, int pSize, Socket *pSocket);
      void handlePacketOrder(void *pStruct, int pSize, Socket *pSocket);
	  void handlePacketActorController( void *pStruct, int pSize, Socket *pSocket );
	  void handlePacketUtilityAndTools( void *pStruct, int pSize, Socket *pSocket );
	  void handlePacketSetTorpedoSUT(void *pStruct, int pSize, Socket *pSocket);
	  void handlePacketSetTorpedoA244(void *pStruct, int pSize, Socket *pSocket); //EKA-141111
	  void handlePacketSetAsrock(void *pStruct, int pSize, Socket *pSocket);
	  void handlePacketSetCannon(void *pStruct, int pSize, Socket *pSocket);
	  void handlePacketSetRBU(void *pStruct, int pSize, Socket *pSocket);
	  //void handlePacketSetExocet(void *pStruct, int pSize, Socket *pSocket);
	  void handlePacketSetExocet40(void *pStruct, int pSize, Socket *pSocket);
	  void handlePacketDatabaseEvent(void *pStruct, int pSize, Socket *pSocket);
	  void handlePacketSetC802(void *pStruct, int pSize, Socket *pSocket); //BAWE-20120327: C802_MISSILE_ACTOR
	  void handlePacketSetMistral(void *pStruct, int pSize, Socket *pSocket); //EKA
	  void handlePacketSetTetral(void *pStruct, int pSize, Socket *pSocket); //EKA
	  void handlePacketSetStrela(void *pStruct, int pSize, Socket *pSocket); //EKA
	  void handlePacketSetYakhont(void *pStruct, int pSize, Socket *pSocket); //EKA

	  void SetShipStatus( const int VID, const int shipStatus  );
	  
	  void SetMissileStatus( const int VID, const int weaponID, const int launcherID, const int missileID, const int missileNum , const int missileStatus  );

	  void CheckValidLaunchers(int mShipID, int mWeaponID, int mLauncherID );
	  void CheckValidMissiles(int mShipID, int mWeaponID, int mLauncherID, int mMissileID, int mMissileNum  );
	  void CheckValidMissilesForStandAlone(int mShipID, int mWeaponID, int mLauncherID, int mMissileID, int mMissileNum );	

	  void MissileExplode(int WeaponType, float PosX, float PosY, float PosZ, int Status);

	  bool IsValidLauncher(int mShipID, int mWeaponID, int mLauncherID);
	  bool IsValidMissile(int mShipID, int mWeaponID, int mLauncherID, int mMissileID, int mMissileNum  );
	  dtCore::RefPtr<dtDAL::ActorProxy>  IsValidMissileByLauncher(int mShipID, int mWeaponID, int mLauncherID); //  [5/14/2013 DID RKT2]
};

#endif // 
