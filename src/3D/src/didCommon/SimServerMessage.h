#pragma once

#ifdef USE_VLD
#include <vld.h>
#endif

#include "../didNetwork/SocketServerGM.h"
#include "../didCommon/simMessages.h"
#include "../didCommon/simMessageType.h"
#include <dtGame\GMComponent.h>
#include <dtGame\gameactor.h>
#include <dtGame\actorupdatemessage.h>
#include <dtGame\basemessages.h>
#include <dtGame\defaultmessageprocessor.h>
#include <dtGame\environmentactor.h>
#include <dtGame\gameactor.h>
#include <dtGame\gamemanager.h>
#include <dtGame\gmcomponent.h>
#include <dtGame\invokable.h>
#include <dtGame\machineinfo.h>
#include <dtGame\messagefactory.h>
#include <dtGame\messageparameter.h>
#include <dtGame\messagetype.h>


#include <vector>

class SimServerMessage :
   public dtGame::DefaultMessageProcessor
{
	public:
		SimServerMessage();
		virtual ~SimServerMessage();

		/**
		* Fungsi untuk menambahkan login pada gamemanager
		* @param msg Message dari local atau network
		*/
		void ProcessMessage(const dtGame::Message& msg);
		/**
		
		* @ cLoginName = ANJUNGAN / OBSERVER / TDS
		* @ ANJUNGAN   = ( params1 = vehicleID	)
		* @ OBSERVER   = ( params1 = vehicleID , params2 = machineID )
		* @ TDS        = ( params1 = vehicleID , params2 = weaponID, params3 = launcherID )
		*/
		Login* AddLogin(std::string mLoginName, int mParams1, int mParams2, int mParams3, 
			std::string mMachineName, std::string mIPAddress, const dtCore::UniqueId& mUniqueID);
		
		bool ApplyLogin(std::string mLoginName, int mParams1, int mParams2, int mParams3, 
			std::string mMachineName, std::string mIPAddress);

		/**
		
		* @ cLoginName = ANJUNGAN / OBSERVER / TDS
		* @ ANJUNGAN   = ( params1 = vehicleID	)
		* @ OBSERVER   = ( params1 = vehicleID , params2 = observerID )
		* @ TDS        = ( params1 = vehicleID , params2 = weaponID, params3 = launcherID )
		*/
		bool ApplyOrAddLogin( const std::string mLoginName, const int mParams1, const int mParams2, const int mParams3, 
			const std::string mMachineName, const std::string& mIPAddress, const dtCore::UniqueId& mUniqueID );

		/**
		* Proses ketika user mencoba logout
		* @param mHost IP Address
		*/
		void EjectLogin(const std::string& mHost);

		/**
		* Vector untuk menyimpan data login
		*/
		std::vector<Login> mLogins;

		// - enable process message [7/21/2014 EKA]
		bool enableProcessMessage;

	private : 
		
	/**
	* Fungsi untuk meng-update data actor ke semua client
	*/
	void UpdateAllObjectToClients();

	/**
	* Fungsi untuk meng-create game actor ke client yang meminta
	*/
	void CreateAllObjectToClients(const dtGame::Message& msg);

	/**
	* Fungsi untuk meng-update parent game actor ke client
	*/
	void UpdateParentActor(const dtGame::Message& msg);

	/**
	* Fungsi pengecekan dari message yang masuk
	* @return kevaliditasan message
	*/
	bool IsInvalidMessage(const dtGame::Message& msg);

	/**
	* Proses untuk network message 
	* @param msg Message yang diterima
	*/
	void HandleNetworkMessage(const dtGame::Message& msg);

	/**
	* Proses untuk local message 
	* @param msg Message yang diterima
	*/
	void HandleLocalMessage(const dtGame::Message& msg);

	/**
	* Proses untuk message dengan tipe MessageType::NETCLIENT_NOTIFY_DISCONNECT 
	* @param msg Message yang diterima
	*/
	void ProcessClientNotifyDisconnect(const dtGame::Message& msg);

	/**
	* Proses untuk message dengan tipe SimMessageType::NOTIFY_LOGIN
	* @param msg Message yang diterima
	*/
	void ProcessClientNotifyLogin(const dtGame::Message& msg);
	void ProcessClientRequestTDS(const dtGame::Message& msg);
	//void ProcessUtilityAndTools(const dtGame::Message& msg);

	private : 
		//unsigned short int mCycleUpdate;
		float mCycleUpdate;
		int lastObserverID;

};
