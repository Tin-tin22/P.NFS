#pragma once

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

class didServerMessage :
   public dtGame::DefaultMessageProcessor
{
	public:
		didServerMessage();
		virtual ~didServerMessage();

		/**
    * Fungsi untuk menambahkan login pada gamemanager
    * @param msg Message dari local atau network
    */
		void ProcessMessage(const dtGame::Message& msg);

    /**
    * Fungsi untuk menambahkan login pada gamemanager
    * @param mName Username
    * @param mPassword Password
    * @param mRole Tipe Role
    * @param mObjName Nama Object / Actor yang akan dihandle
    */
		Login* AddLogin(std::string mName, std::string mPassword, 
										const Login::RoleType& mRole, std::string mObjName,
										std::string mObjType);
    /**
    * Proses login ketika user mencoba login
    * @param mName Username
    * @param mPassword Password
    * @param mRole Tipe Role
    * @param mObjName Nama Object / Actor yang akan dihandle
    * @param mIPAddress IP dari client
    * @return kevaliditasan login
    */
		bool ApplyLogin(const std::string mName,const  std::string mPassword, 
			const std::string& mRole, std::string& mObjName, std::string& mObjType,
			const std::string& mIPAddress);

    /**
    * Proses login ketika user mencoba login
    * @param mName Object Name
    * @param mIPAddress IP dari client
    * @return kevaliditasan login
    */
		bool ApplyLogin(const std::string mName, const std::string& mIPAddress);

		/**
    * Proses ketika user mencoba logout
    * @param mName Username
    * @param mPassword Password
    * @param mRole Tipe Role
    */
		void EjectLogin(const std::string& mName, const std::string& mPassword, const std::string& mRole);

    /**
    * Proses ketika user mencoba logout
    * @param mHost IP Address
    */
		void EjectLogin(const std::string& mHost);

	private : 
    /**
    * Vector untuk menyimpan data login
    */
		std::vector<Login> mLogins;
		
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

		/**
    * Proses untuk message dengan tipe MessageType::INFO_GAME_EVENT
    * @param msg Message yang diterima
    */
	//	void ProcessGameEvent(const dtGame::Message& msg);

		/**
    * Proses untuk message dengan tipe SimMessageType::ORDER_EVENT
    * @param msg Message yang diterima
    */
	//	void ProcessGameOrderEvent(const dtGame::Message& msg);

    unsigned short int mCount;
};
