#include "../didNetwork/SocketClientGM.h"
#include "../didUtils/SimEnvironmentControl.h"
#include "../didCommon/simMessageType.h"
#include "../didCommon/simMessages.h"

#include <dtgame/defaultmessageprocessor.h>
#include <dtGame/message.h>

#include <dtDAL/gameevent.h>
#include <dtDAL/gameeventmanager.h>
#include <dtDAL/enginepropertytypes.h>
#include <dtDal/ActorType.h>
#include <dtDAL/ActorProperty.h>
#include <dtGame/basemessages.h>
#include <dtGame/gameactor.h>
#include <dtGame/ActorUpdateMessage.h>

#include <dtCore/Keyboard.h>
#include <dtCore/Scene.h>
#include <dtCore/FlyMotionModel.h>
#include <dtCore/camera.h>
#include <dtCore/environment.h>
#include <dtcore/deltawin.h>

#include <dtABC/application.h>
#include <iostream>


struct ControlledComponentData
{
   int VehicleID;
   int ComponentID;
   //std::string ComponentName;
};

class didClientMessageProc :
	public dtGame::DefaultMessageProcessor
{
	public:
		std::string LoginName;
    std::string LookCamera;

		didClientMessageProc(void);
		virtual ~didClientMessageProc(void);
		void ProcessMessage(const dtGame::Message& msg);
		
		const std::string GetHandledObjectName() const { return MyHandledObjectName;}
		const dtCore::UniqueId GetHandledObjectId() const { return MyHandledObjectID;}

	private :
		bool mFirstInit, mIsAttachedToHandledObject;
		bool isHandledIDFound;
		dtCore::Transform tx;

		//GNE::Mutex mMutex;

		std::string MyHandledObjectName;
		dtCore::UniqueId MyHandledObjectID;

		bool IsInvalidMessage(const dtGame::Message& msg);
		void HandleNetworkMessage(const dtGame::Message& msg);
		void HandleLocalMessage(const dtGame::Message& msg);

		void ProcessUpdateParentMessage(const dtGame::Message& msg);
		void ProcessApplyLoginMessage(const dtGame::Message& msg);
		void ProcessRequestLogin();

    void ProcessCreateActor(const dtGame::ActorUpdateMessage &msg);
    dtCore::RefPtr<dtGame::GameActorProxy> ProcessRemoteCreateActor(const dtGame::ActorUpdateMessage& msg);

    ControlledComponentData mControlledComponentData;

};
