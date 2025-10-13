#pragma once

#ifdef USE_VLD
#include <vld.h>
#endif

#include <dtgame/messagetype.h>
#include <dtGame/message.h>


//=================================const message type===============================================//
const std::string C_MT_INFO			    		= "Info";
const std::string C_MT_SIMMES					= "Simulation Messages";
const std::string C_MT_NOTIFY_LOGIN				= "Notify Login";
const std::string C_MT_APPLY_LOGIN				= "Apply Login";
const std::string C_MT_REJECT_LOGIN				= "Reject Login";
const std::string C_MT_UPDATE_PARENT			= "Update Parent";
const std::string C_MT_EVENT_ON_OBJECT			= "Event On Object";
const std::string C_MT_ORDER_EVENT				= "Order Event";
const std::string C_MT_EXOCET_EVENT				= "Exocet Event";
const std::string C_MT_ASROCK_EVENT				= "Asrock Event";
const std::string C_MT_RBU_EVENT				= "RBU Event";
const std::string C_MT_TORPEDOSUT_EVENT			= "TorpedoSUT Event";
const std::string C_MT_TORPEDO_EVENT			= "Torpedo Event"; //EKA-031111
const std::string C_MT_C802_EVENT	    		= "C802 Event"; // BAWE-20120227: C802_MISSILE_ACTOR
const std::string C_MT_TETRAL_EVENT				= "Tetral Event"; //EKA-060312
const std::string C_MT_MISTRAL_EVENT			= "Mistral Event"; //EKA-060312
const std::string C_MT_STRELA_EVENT				= "Strela Event"; //EKA-060312
const std::string C_MT_YAKHONT_EVENT    		= "Yakhont Event"; //BAWE-20120315: YAKHONT_MISSILE_ACTOR
const std::string C_MT_EXOCET_40_EVENT  		= "Exocet MM 40 Event"; //BAWE-20120315: YAKHONT_MISSILE_ACTOR
const std::string C_MT_EXOCET_MM_40_EVENT  		= "Exocet MM_40 Event"; //NANDO-20120411: EXOCET_MISSILE_ACTOR
const std::string C_MT_POSITION_EVENT			= "Position Event";
const std::string C_MT_CANNON_EVENT				= "Cannon Event";
const std::string C_MT_ENVIRONMENT_CONTROL		= "Environment Control";
const std::string C_MT_ACTORS_CONTROL			= "Actors Control";
const std::string C_MT_UTILITY_AND_TOOLS		= "Utility And Tools";
const std::string C_MT_OCEAN_CONTROL			= "Ocean Control";
const std::string C_MT_CAMERA_INPUTS			= "Camera Inputs";
const std::string C_MT_NOTIFY_TDS				= "Notify TDS";
const std::string C_MT_APPLY_TDS				= "Apply TDS";
const std::string C_MT_DATABASE_EVENT   		= "DATABASE EVENT";
const std::string C_MT_CANNONHANDLE_EVENT		= "Cannon Handle Event";
const std::string C_MT_MESSAGE_HANDLE_EVENT     = "Message Handle Event";
//=================================const message type===============================================//

class SimMessageType :
	public dtGame::MessageType
{
public:
   DECLARE_ENUM(SimMessageType);

   public:
		//static const SimMessageType SIM_GAME_MSG;
		static const SimMessageType NOTIFY_TDS;
		static const SimMessageType APPLY_TDS;
		static const SimMessageType NOTIFY_LOGIN;
		static const SimMessageType APPLY_LOGIN;
		static const SimMessageType REJECT_LOGIN;
		static const SimMessageType UPDATE_PARENT;
		//static const SimMessageType EVENT_ON_OBJECT;
		static const SimMessageType ORDER_EVENT;
		static const SimMessageType POSITION_EVENT;
		static const SimMessageType ENVIRONMENT_CONTROL;
		static const SimMessageType ACTORS_CONTROL;
		static const SimMessageType TEXTURE_CAMERA_CONTROL;
		static const SimMessageType UTILITY_AND_TOOLS;
		static const SimMessageType OCEAN_CONTROL; // BAWE-20110412: ON_THE_FLY_OCEAN_CONTROL
		static const SimMessageType TORPEDOSUT_EVENT;
		static const SimMessageType ASROCK_EVENT;
		static const SimMessageType RBU_EVENT;
		static const SimMessageType CANNON_EVENT;
		static const SimMessageType CANNONHANDLE_EVENT;
		static const SimMessageType DATABASE_EVENT;
		static const SimMessageType TORPEDO_EVENT; //EKA-031111
		static const SimMessageType CAMERA_INPUTS; // BAWE-20121210: NEW CAMERA_INPUTS
		static const SimMessageType C802_EVENT; // BAWE-20120227: C802_MISSILE_ACTOR
		static const SimMessageType MISTRAL_EVENT; //EKA-080312
		static const SimMessageType TETRAL_EVENT; //EKA-080312
		static const SimMessageType STRELA_EVENT; //EKA-080312
		static const SimMessageType YAKHONT_EVENT; //BAWE-20120315: YAKHONT_MISSILE_ACTOR
		static const SimMessageType EXOCETMM_40_EVENT; //Nando-20120411 : EXOCET_MM40_MISSILE_ACTOR
		static const SimMessageType HANDLE_MESSAGE_EVENT;
		

		static void RegisterMessageTypes(dtGame::MessageFactory& factory);

   protected:

		SimMessageType( const std::string &name, 
						   const std::string &category,
						   const std::string &description, 
						   const unsigned short messageId) :
		 dtGame::MessageType(name, category, description, messageId)
		{
		 AddInstance(this);
		}
		virtual ~SimMessageType() { }

};