#include "objectactor.h"
#include "oceanactor.h"
#include "oceanconfigactor.h"

#include "didactorssources.h"

using namespace   osgOcean;
using namespace   didEnviro;


////////////////////////////////////////////////////////
ObjectActorProxy::ObjectActorProxy()
{
   //
}
ObjectActorProxy::~ObjectActorProxy()
{
}

void ObjectActorProxy::BuildInvokables()
{
   dtGame::GameActorProxy::BuildInvokables();
}

void ObjectActorProxy::BuildPropertyMap()
{
   dtGame::GameActorProxy::BuildPropertyMap();
   
   const std::string GROUP = C_TYPE_MISC;

   ObjectActor* actor = NULL;
   
   GetActor(actor);

   AddProperty(new dtDAL::StringActorProperty(C_SET_MODEL,C_SET_MODEL,
    dtDAL::StringActorProperty::SetFuncType(actor,&ObjectActor::SetModel),
    dtDAL::StringActorProperty::GetFuncType(actor,&ObjectActor::GetModel), "Set Model", GROUP));

   AddProperty(new dtDAL::IntActorProperty(C_SET_VID, C_SET_VID, 
	dtDAL::IntActorProperty::SetFuncType(actor, &ObjectActor::SetVehicleID), 
	dtDAL::IntActorProperty::GetFuncType(actor, &ObjectActor::GetVehicleID),"Sets Vehicle Id", GROUP));
 
   AddProperty(new dtDAL::IntActorProperty(C_SET_TID, C_SET_TID, 
	dtDAL::IntActorProperty::SetFuncType(actor, &ObjectActor::SetTipeID), 
	dtDAL::IntActorProperty::GetFuncType(actor, &ObjectActor::GetTipeID),"Sets Tipe Id", GROUP));

}

void ObjectActorProxy::OnEnteredWorld()
{
  RegisterForMessages(dtGame::MessageType::TICK_LOCAL, dtGame::GameActorProxy::TICK_LOCAL_INVOKABLE);
}


////////////////////////////////////////////////////////////
ObjectActor::ObjectActor(dtGame::GameActorProxy &proxy)
	:dtGame::GameActor(proxy)
{
	//SetName(C_CN_MISC);
}

ObjectActor::~ObjectActor()
{
}


void ObjectActor::OnEnteredWorld()
{
	 //
}

void ObjectActor::ProcessMessage(const dtGame::Message &message)
{
	if(GetGameActorProxy().IsInGM()){
		if(message.GetMessageType().GetName() == SimMessageType::ORDER_EVENT.GetName())
			ProcessOrderEvent(message);
	}
}

void ObjectActor::ProcessOrderEvent(const dtGame::Message &message)
{
	const MsgOrder &orderMsg = static_cast<const MsgOrder&>(message);
	

}

void ObjectActor::TickLocal(const dtGame::Message &tickMessage)
{
	const dtGame::TickMessage &tick = static_cast<const dtGame::TickMessage&>(tickMessage);
	float deltaSimTime = tick.GetDeltaSimTime();

	UpdateHeight(deltaSimTime);
	 
}

void ObjectActor::UpdateHeight(float elapsedTime)
{
	float x,y,z ;
	dtCore::Transform tx;

	GetTransform(tx,ABS_CS);
	tx.GetTranslation(x,y,z);

	dtGame::IEnvGameActorProxy* envActorProxy = GetGameActorProxy().GetGameManager()->GetEnvironmentActor();
	OceanActor* actor = NULL;
	if (envActorProxy) actor = dynamic_cast<OceanActor*> (envActorProxy->GetActor());
		if (actor != NULL)
		{
			osg::Vec3f normal;
			//float height = (( actor->GetOceanSurfaceHeightAt(x,y, &normal)) * 0.0001 ) + z;
			float height = actor->GetOceanSurfaceHeightAt(x,y, &normal) * 0.9;
			z = height ;
		}

	tx.SetTranslation(x,y,z);
	SetTransform(tx,ABS_CS);

}


void ObjectActor::SetModel(const std::string &fileName)
{
   if (mModelFile != fileName)
   {
      dtCore::RefPtr<osgDB::ReaderWriter::Options> options = new osgDB::ReaderWriter::Options();

      options->setObjectCacheHint(osgDB::ReaderWriter::Options::CACHE_NONE);
      osg::Node *model = osgDB::readNodeFile(fileName,options.get());
      if (model != NULL)
      {
         if (GetMatrixNode()->getNumChildren() != 0)
            GetMatrixNode()->removeChild(0,GetMatrixNode()->getNumChildren());
         GetMatrixNode()->addChild(model);
         mModelFile = fileName;
      }
      else
      {
		  std::cout<<"Unable to load model file: " <<fileName<<std::endl;
      }

      if (!IsRemote() && GetGameActorProxy().IsInGM())
      {
         dtCore::RefPtr<dtGame::Message> updateMsg = GetGameActorProxy().GetGameManager()->
            GetMessageFactory().CreateMessage(dtGame::MessageType::INFO_ACTOR_UPDATED);
         dtGame::ActorUpdateMessage *message = static_cast<dtGame::ActorUpdateMessage *> (updateMsg.get());
         GetGameActorProxy().PopulateActorUpdate(*message);

         GetGameActorProxy().GetGameManager()->SendMessage(*updateMsg);
      }
   }
}