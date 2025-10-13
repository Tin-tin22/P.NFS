#include "didInputClient.h"
#include "../didCommon/const.h"
#include "../didCommon/SimMessages.h"
#include "../didCommon/SimMessageType.h"
#include "../didUtils/SimActorControl.h"
#include "../didUtils/SimEnvironmentControl.h"
#include "../didUtils/SimActorDefXML.h"

#include <dtGame/basemessages.h>
#include <dtGame/messagetype.h>
#include <dtGame/gameactor.h>


#include <dtCore/refptr.h>
#include <dtCore/isector.h>
#include <dtCore/camera.h>

#include <dtDAL/enginepropertytypes.h>
#include <dtABC/application.h>
#include <dtTerrain/terrain.h>
#include <dtActors/gamemeshactor.h>

#include <vector>

////////////////////////////////////////////////////////////////////
didInputClientComponent::didInputClientComponent(const std::string &name, bool inPlaybackMode) :
   dtGame::BaseInputComponent(name) 
{
  mShipFocusIndex= 0;
}

////////////////////////////////////////////////////////////////////
bool didInputClientComponent::HandleKeyReleased(const dtCore::Keyboard* keyboard, int key ) 
{
	bool handled = true;
 	dtCore::RefPtr<dtDAL::GameEvent> mEvent;
	 
	handled = false;

	if (!handled)
		return BaseInputComponent::HandleKeyReleased(keyboard, key );

    return handled;
}

int G_Counter= 0;

bool didInputClientComponent::HandleKeyPressed(const dtCore::Keyboard* keyboard, int key )
{
	bool handled = true;

	if (key== 'x')
	{
		std::vector<dtDAL::ActorProxy*> gaps;
		GetGameManager()->FindActorsByType(*(GetGameManager()->FindActorType(C_ACTOR_CAT, C_CN_SHIP)), gaps);
		mShipFocusIndex++;
		if(mShipFocusIndex >= gaps.size())
		mShipFocusIndex= 0;
		dtCore::Transform t;
		dtCore::RefPtr<dtGame::GameActorProxy> gap= static_cast<dtGame::GameActorProxy*>(gaps[mShipFocusIndex]);
		osg::Vec3 v3= gap->GetTranslation();
		v3[2]+= 500;
		t.SetTranslation(v3);
		osg::Vec3 rot(0.0f, -90.0f, 0.0f);
		t.SetRotation(rot);
		GetGameManager()->GetApplication().GetCamera()->SetTransform(t);


		dtCore::RefPtr<dtDAL::ActorProperty> VIDProp( gap->GetProperty("VehicleID") );
		dtCore::RefPtr<dtDAL::IntActorProperty> intprop( static_cast<dtDAL::IntActorProperty*>( VIDProp.get() ) );

		std::cout<<"Set camera focus to "<<gap->GetName()<<" Vehicle ID :: "<<intprop->GetValue()<<std::endl;

		handled= true; 
	}
	else if (key== 'z')
	{
		std::vector<dtDAL::ActorProxy*> gaps;
		GetGameManager()->FindActorsByType(*(GetGameManager()->FindActorType(C_ACTOR_CAT, C_CN_SHIP)), gaps);
		mShipFocusIndex--;
		if(mShipFocusIndex >= gaps.size())
		mShipFocusIndex= gaps.size()-1;

		dtCore::Transform t;
		dtCore::RefPtr<dtGame::GameActorProxy> gap= static_cast<dtGame::GameActorProxy*>(gaps[mShipFocusIndex]);
		osg::Vec3 v3= gap->GetTranslation();
		v3[2]+= 500;
		t.SetTranslation(v3);
		osg::Vec3 rot(0.0f, -90.0f, 0.0f);
		t.SetRotation(rot);
		GetGameManager()->GetApplication().GetCamera()->SetTransform(t);

		std::cout<<"Set camera focus to "<<gap->GetName()<<std::endl;

		handled= true;
	}

	else if (key== '0')
	{
		std::vector<dtGame::GameActorProxy *> fill;
		std::vector<dtGame::GameActorProxy *>::iterator iter;

		std::vector<dtDAL::ActorProperty *> fillp;
		std::vector<dtDAL::ActorProperty *>::iterator iterp;

		GetGameManager()->GetAllGameActors(fill);
		for (iter = fill.begin(); iter < fill.end(); iter++)
		{
			std::cout<<"** Actor name: "<<(*iter)->GetName()<<std::endl;
			(*iter)->GetPropertyList(fillp);
			for (iterp= fillp.begin(); iterp< fillp.end(); iterp++)
			{
				std::cout<<"   Property name: "<<(*iterp)->GetName()<<std::endl;
			}
		}
		handled= true;
		}
	else if (key== '1')
	{
		std::vector<dtGame::GameActorProxy *> fill;
		std::vector<dtGame::GameActorProxy *>::iterator iter;
		GetGameManager()->GetAllGameActors(fill);
		for (iter = fill.begin(); iter < fill.end(); iter++)
		{
			std::cout<<"** Actor name: "<<(*iter)->GetName()<<std::endl;
		}
		handled= true;
	}
	else if (key== '2')
	{
		dtCore::RefPtr<MsgOrder> orderMsg;
		GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::ORDER_EVENT, orderMsg);

		int shipID(32);
		orderMsg->SetVehicleID(shipID);
		orderMsg->SetOrderID(ORD_THROTTLE);
		orderMsg->SetFloatValue(float(25));

		GetGameManager()->SendNetworkMessage(*orderMsg.get());
		GetGameManager()->SendMessage(*orderMsg.get());

		std::cout<<"** Order Event Done "<<std::endl;

		handled= true;
	}
	else if (key== '3')
	{
		dtCore::RefPtr<MsgOrder> orderMsg;
		GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::ORDER_EVENT, orderMsg);

		int shipID(32);
		orderMsg->SetVehicleID(shipID);
		orderMsg->SetOrderID(ORD_RUDDER);
		orderMsg->SetFloatValue(float(25));

		GetGameManager()->SendNetworkMessage(*orderMsg.get());
		GetGameManager()->SendMessage(*orderMsg.get());

		std::cout<<"** Order Event Done "<<std::endl;

		handled= true;
	}
	else if (key== '4')
	{
		dtCore::RefPtr<MsgOrder> orderMsg;
		GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::ORDER_EVENT, orderMsg);

		int shipID(33);
		orderMsg->SetVehicleID(shipID);
		orderMsg->SetOrderID(ORD_THROTTLE);
		orderMsg->SetFloatValue(float(25));

		GetGameManager()->SendNetworkMessage(*orderMsg.get());
		GetGameManager()->SendMessage(*orderMsg.get());
		
		std::cout<<"** Order Event Done "<<std::endl;

		handled= true;
	}
	else if (key== '5')
	{
		dtCore::RefPtr<MsgOrder> orderMsg;
		GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::ORDER_EVENT, orderMsg);

		int shipID(33);
		orderMsg->SetVehicleID(shipID);
		orderMsg->SetOrderID(ORD_RUDDER);
		orderMsg->SetFloatValue(float(25));

		GetGameManager()->SendNetworkMessage(*orderMsg.get());
		GetGameManager()->SendMessage(*orderMsg.get());

		std::cout<<"** Order Event Done "<<std::endl;

		handled= true;
	}
	else if (key== 'C')
	{
		dtCore::RefPtr<dtGame::GameActorProxy> proxy;
		dtCore::RefPtr<dtGame::GameActor> actor;
		SimActorDefXML *mActorXML = static_cast<SimActorDefXML*>(GetGameManager()->GetComponentByName("ActorDefXMLComponent"));

		std::ostringstream ost;
		ost << "354";
		std::string shipId ,shipName ;
		shipId = ost.str();
		shipName = "NALA";

		proxy = mActorXML->CreateActor(shipId,shipName);
		proxy->GetProperty("VehicleID")->FromString(shipId);
		actor  = dynamic_cast<dtGame::GameActor*>(proxy->GetActor());
		
		osg::Vec3 trans(100.0f,300.0f,0);
		proxy->SetTranslation(trans);

		dtCore::RefPtr<dtDAL::ActorProperty> headProp( proxy->GetProperty("Course") );
		if (headProp!= NULL)
		{
			dtCore::RefPtr<dtDAL::FloatActorProperty> floatprop( static_cast<dtDAL::FloatActorProperty*>( headProp.get() ) );
			floatprop->SetValue(270.0f);
		}

		//if( actor->GetParent()!= NULL)
		//	actor->GetParent()->RemoveChild(actor.get());

		//prShip->GetActor()->AddChild(gap->GetActor());
		//GetGameManager()->GetScene().AddDrawable(actor.get());

		dtCore::RefPtr<dtGame::ActorUpdateMessage> mess = 
			static_cast<dtGame::ActorUpdateMessage*>(GetGameManager()->GetMessageFactory().CreateMessage(dtGame::MessageType::INFO_ACTOR_UPDATED).get());

		proxy->PopulateActorUpdate(*mess);

		GetGameManager()->SendNetworkMessage(*mess);
		GetGameManager()->SendMessage(*mess);

		GetGameManager()->AddActor(*proxy, false, true);

		std::vector<dtGame::GameActorProxy*> toFill;
		GetGameManager()->GetAllGameActors(toFill);

		for(std::vector<dtGame::GameActorProxy*>::iterator iter = toFill.begin(); 
			iter!=toFill.end(); iter++ ){
				std::cout<<":::"<<(*iter)->GetActor()->GetName()<<":::";
				GetGameManager()->RegisterForMessages(dtGame::MessageType::TICK_LOCAL,*(*iter),dtGame::GameActorProxy::TICK_LOCAL_INVOKABLE);
				GetGameManager()->RegisterForMessages(SimMessageType::ORDER_EVENT,*(*iter),dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
				GetGameManager()->RegisterForMessages(SimMessageType::POSITION_EVENT,*(*iter),dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
		}


		std::cout<<actor->GetName()<<" ID :"<< shipId <<" Added to Game."<<std::endl;	 


		handled= true;

	}
	else
		return BaseInputComponent::HandleKeyPressed(keyboard, key);
	return handled;
}


//////////////////////////////////////////////////////////////////////////
void didInputClientComponent::ProcessMessage(const dtGame::Message& message)
{

}