///////////////////////////////////////////////////////////////////////////////
#include "SimEffectControl.h"
#include "../didUtils/simActorControl.h"
#include "../didUtils/utilityfunctions.h"
#include "../didCommon/simmessagetype.h"
#include "../didCommon/BaseConstant.h"
#include "../didNetwork/SimTCPDataTypes.h"

#include "../didActors/effectactor.h"

#include <dtCore/scene.h>

#include <dtDAL/actortype.h>
#include <dtDAL/gameeventmanager.h>
#include <dtDAL/Actorproperty.h>
#include <dtDAL/LibraryManager.h>

#include <dtCore/particlesystem.h>
#include <dtCore/refptr.h>
#define _WINSOCKAPI_
#ifndef WIN32_LEAN_AND_MEAN
#define WIN32_LEAN_AND_MEAN
#endif
#include <dtUtil/mswin.h>
#pragma comment(lib, "ws2_32.lib")

//////////////////////////////////////////////////////////////////////////
SimEffectControl::SimEffectControl(): dtGame::DefaultMessageProcessor("SimEffectControl")
{
	mEffects.clear();
	mCycleUpdate	= 0.0f;
}

SimEffectControl::~SimEffectControl()
{
	mEffects.clear();
}

/*
GetLifeTime ini bisa di taruh di actorEffect.
*/
int SimEffectControl::GetLifeTimeFromWeaponID ( int WID )  
{
	float lt = 5.0f ;
	if ( WID == CT_ASROC)				lt = 5.0f; 
	else if ( WID == CT_C802)			lt = 5.0f;
	else if ( WID == CT_CANNON_120)		lt = 5.0f;
	else if ( WID == CT_CANNON_76)		lt = 5.0f;
	else if ( WID == CT_CANNON_57)		lt = 5.0f;
	else if ( WID == CT_CANNON_40)		lt = 5.0f;
	else if ( WID == CT_EXOCET_40)		lt = 5.0f; 
	else if ( WID == CT_MISTRAL)		lt = 5.0f;
	else if ( WID == CT_RBU_6000)		lt = 5.0f;
	else if ( WID == CT_STRELA)			lt = 5.0f;
	else if ( WID == CT_TETRAL)			lt = 5.0f;
	else if ( WID == CT_TORPEDO_SUT)	lt = 5.0f;
	else if ( WID == CT_TORPEDO_A244S)	lt = 5.0f;
	else if ( WID == CT_YAKHONT)		lt = 5.0f;
	return lt ;
}

void SimEffectControl::ProcessEffectControl(const dtGame::Message& msg)
{
	const MsgUtilityAndTools &Msg = static_cast<const MsgUtilityAndTools&>(msg);
	if ( Msg.GetOrderID()== TIPE_UTIL_EVENT_EXPLODE ) ///  
	{
		int weaponID		= Msg.GetUAT0();			// CT_CANNON and others
		int launcherID		= (int) Msg.GetUAT6();		// Nando Added launcher ID for ASKOP WCC
		int VehicleID		= (int) Msg.GetUAT5();		// Nando Added vehicle ID for ASKOP WCC
		int setCamera   	=  Msg.GetUAT4();   
		float camOffset		= 0.0f;
		float lifeTime		=  GetLifeTimeFromWeaponID(weaponID);

		osg::Vec3 xyz(Msg.GetUAT1(),Msg.GetUAT2(),Msg.GetUAT3()); // position
		AddEffectAndExplode(0, VehicleID,weaponID, launcherID, lifeTime,xyz) ;

		if ( setCamera == 1 ) // true
		{
			xyz.y() = xyz.y()- camOffset ;
			dtCore::Transform tmpTrans;
			tmpTrans.SetTranslation(xyz);
			GetGameManager()->GetApplication().GetCamera()->SetTransform(tmpTrans,dtCore::Transformable::ABS_CS);
		}
	}
	else
	if ( Msg.GetOrderID()== TIPE_UTIL_SPOUT_EXPLODE )
	{
		int WeaponID	= (int) Msg.GetUAT0();
		int ExplodeID   = (int) Msg.GetUAT1();
		int ExplodeType = (int) Msg.GetUAT2();
		float lifeTime  = GetLifeTimeFromWeaponID(WeaponID);
		osg::Vec3 xyz(Msg.GetUAT3(),Msg.GetUAT4(),Msg.GetUAT5()); 

		AddEffectAndExplodeSpout(0, 0,WeaponID, 0, lifeTime, xyz) ;
	}
}

void SimEffectControl::CleanUpActorEffect()
{
	for(std::vector<EffectControlDef>::iterator iter = mEffects.begin(); iter != mEffects.end(); iter++)
	{
		dtCore::UniqueId nUniqueID((*iter).GetUIDObjectHandled());
		dtCore::RefPtr<dtGame::GameActorProxy> gap = GetGameManager()->FindGameActorById(nUniqueID);
		if ( gap )
		{
			EffectActor* ea  = static_cast<EffectActor*>(gap->GetActor());
			if ( ea->GetEffectState() == false )
			{
				std::string s = ea->GetName();
				GetGameManager()->DeleteActor(*gap);

				std::cout<<GetGameManager()->GetMachineInfo().GetName() <<" :: clean up -> "<<s<<std::endl;

				mEffects.erase(iter);
				if(iter == mEffects.end())
				{
					break;
				}
			}
		}
	}
}

int SimEffectControl::GetLastEffectID()
{
	int newNum = 0 ;

	for(std::vector<EffectControlDef>::iterator iter = mEffects.begin(); iter != mEffects.end(); iter++)
	{
		if ( (*iter).mSetID > newNum  )
			newNum = (*iter).mSetID ;
	}
	return newNum + 1;

};

bool SimEffectControl::AddEffectAndExplode(const int mSetID, const int mVehicleID, const int mTypeEffect, const int mLauncherEffect,  const float mLifeTime, const osg::Vec3 xyz )
{
	bool found = false;
	EffectActor* ea  = NULL ;

	for(std::vector<EffectControlDef>::iterator iter = mEffects.begin(); iter != mEffects.end(); iter++)
	{
		if ( (*iter).mSetID == mSetID )
		{
			dtCore::UniqueId nUniqueID((*iter).GetUIDObjectHandled());

			dtCore::RefPtr<dtGame::GameActorProxy> gap = GetGameManager()->FindGameActorById(nUniqueID);
			if ( gap )
			{
				ea  = static_cast<EffectActor*>(gap->GetActor());
				found = true;
				break;
			}
		}
	}

	if (found)
	{
	  if ( ea != NULL )
	  {
		  dtCore::Transform tmpTrans;
		  tmpTrans.SetTranslation(xyz);
		  ea->SetTransform(tmpTrans,dtCore::Transformable::ABS_CS);
		  ea->SwitchOnEffect();
		  std::cout<<"Switch ON "<<ea->GetName()<<"..."<<std::endl;
	  } 
	  else
		  std::cout<<GetName()<<" :: Indicated Actor Found but NULL "<<std::endl;
	} 
	else  
	{
		int EffectID ;

		if ( mSetID == 0 ) EffectID = GetLastEffectID(); 

		EffectControlDef *mEffect = new EffectControlDef(EffectID,mTypeEffect,mLifeTime);

		dtCore::RefPtr<dtDAL::ActorProxy> ap= GetGameManager()->CreateActor(C_ACTOR_CAT, C_CN_EFFECT);
		dtCore::RefPtr<dtGame::GameActorProxy> gap= static_cast<dtGame::GameActorProxy *>(ap.get());
		dtCore::RefPtr<dtGame::GameActor> ga= static_cast<dtGame::GameActor*>(gap->GetActor());
		std::ostringstream sEffectID;
		sEffectID << EffectID ;
		ga->SetName("ActorEffect-"+sEffectID.str());
		GetGameManager()->AddActor(*gap, false, false);

		ea  = static_cast<EffectActor*>(gap->GetActor());
		ea->SetWeaponID(mTypeEffect);
		ea->SetTimeOut(mLifeTime);
		ea->SetEffectState(true);
		ea->OnExplode(xyz);

		dtCore::UniqueId nUniqueID(ea->GetUniqueId());

		mEffect->SetUIDObjectHandled(nUniqueID) ;
		mEffects.push_back(*mEffect);
		dtCore::Transform tmpTrans;
		tmpTrans.SetTranslation(xyz);

		ea->SetTransform(tmpTrans,dtCore::Transformable::ABS_CS);
		ea->SwitchOnEffect();

		//Send Splah 
		if ( mLauncherEffect != 0 )
		{
			if (( mTypeEffect == CT_CANNON_120 ) ||
				( mTypeEffect == CT_CANNON_76 )	 ||
				( mTypeEffect == CT_CANNON_57 )  || 
				( mTypeEffect == CT_CANNON_40 ))
			{
				dtCore::RefPtr<MsgUtilityAndTools> MsgUtils;
				GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::UTILITY_AND_TOOLS, MsgUtils);

				MsgUtils->SetOrderID(TIPE_UTIL_MISSILE_EXPLODE);
				MsgUtils->SetUAT0(mVehicleID);				//vehicleID
				MsgUtils->SetUAT1(mTypeEffect);				//WeaponID 
				MsgUtils->SetUAT2(mLauncherEffect);			//launcherID
				MsgUtils->SetUAT3(xyz.x());		//PosX
				MsgUtils->SetUAT4(xyz.y());		//PosY
				MsgUtils->SetUAT5(xyz.z());		//PosZ

				GetGameManager()->SendNetworkMessage(*MsgUtils);
				GetGameManager()->SendMessage(*MsgUtils);
			}
		}
	}
	return true;
} 

bool SimEffectControl::AddEffectAndExplodeSpout(const int mSetID, const int mVehicleID, const int mTypeEffect, const int mLauncherEffect,  const float mLifeTime, const osg::Vec3 xyz )
{
	bool found = false;
	EffectActor* ea  = NULL ;

	for(std::vector<EffectControlDef>::iterator iter = mEffects.begin(); iter != mEffects.end(); iter++)
	{
		if ( (*iter).mSetID == mSetID )
		{
			dtCore::UniqueId nUniqueID((*iter).GetUIDObjectHandled());

			dtCore::RefPtr<dtGame::GameActorProxy> gap = GetGameManager()->FindGameActorById(nUniqueID);
			if ( gap )
			{
				ea  = static_cast<EffectActor*>(gap->GetActor());
				found = true;
				break;
			}
		}
	}

	if (found)
	{
	  if ( ea != NULL )
	  {
		  dtCore::Transform tmpTrans;
		  tmpTrans.SetTranslation(xyz);
		  ea->SetTransform(tmpTrans,dtCore::Transformable::ABS_CS);
		  ea->SwitchOnEffect();
		  std::cout<<"Switch ON "<<ea->GetName()<<"..."<<std::endl;

	  } 
	  else
		  std::cout<<GetName()<<" :: Indicated Actor Found but NULL "<<std::endl;  

	} 
	else  
	{
		int EffectID ;
		if ( mSetID == 0 ) EffectID = GetLastEffectID(); 
		EffectControlDef *mEffect = new EffectControlDef(EffectID,mTypeEffect,mLifeTime);

		dtCore::RefPtr<dtDAL::ActorProxy> ap= GetGameManager()->CreateActor(C_ACTOR_CAT, C_CN_EFFECT);
		dtCore::RefPtr<dtGame::GameActorProxy> gap= static_cast<dtGame::GameActorProxy *>(ap.get());
		dtCore::RefPtr<dtGame::GameActor> ga= static_cast<dtGame::GameActor*>(gap->GetActor());
		std::ostringstream sEffectID;
		sEffectID << EffectID ;
		ga->SetName("ActorEffect-"+sEffectID.str());
		GetGameManager()->AddActor(*gap, false, false);

		ea  = static_cast<EffectActor*>(gap->GetActor());
		ea->SetLauncherExplode(mTypeEffect);
		ea->SetTimeOut(mLifeTime);
		ea->SetEffectState(true);
		ea-> OnExplode(xyz);
		dtCore::UniqueId nUniqueID(ea->GetUniqueId());

		mEffect->SetUIDObjectHandled(nUniqueID) ;
		mEffects.push_back(*mEffect);
		dtCore::Transform tmpTrans;
		tmpTrans.SetTranslation(xyz);

		ea->SetTransform(tmpTrans,dtCore::Transformable::ABS_CS); 
		ea->SwitchOnEffect();
	}

	return true;
} 

//////////////////////////////////////////////////////////////////////////

bool SimEffectControl::IsInvalidMessage(const dtGame::Message& msg)
{
	if (GetGameManager() == NULL)
	{
		LOG_ERROR("This component is not assigned to a GameManager, but received a message.  It will be ignored.");         
		return true;
	}  

	if (msg.GetDestination() != NULL && GetGameManager()->GetMachineInfo().GetUniqueId()!= msg.GetDestination()->GetUniqueId())
	{
		LOG_DEBUG("Received message has a destination set to a different GameManager than this one. It will be ignored.");
		return true;
	}

	return false;
}

void SimEffectControl::ProcessMessage(const dtGame::Message& msg)
{
	if (IsInvalidMessage(msg)) {return;}

	if(msg.GetSource() != GetGameManager()->GetMachineInfo()) {
		HandleNetworkMessage(msg);
	}else {
		HandleLocalMessage(msg);
	}
}

void SimEffectControl::HandleLocalMessage(const dtGame::Message& msg)
{
	if (msg.GetMessageType() == dtGame::MessageType::TICK_LOCAL)
	{
		const dtGame::TickMessage& mess = static_cast<const dtGame::TickMessage&>(msg);

		mCycleUpdate+= mess.GetDeltaSimTime();

		if ( mCycleUpdate>= C_UPDATEALLOBJECT_CYCLE_TIME_3D)
		{
			if ( !mEffects.empty() )	CleanUpActorEffect();
			mCycleUpdate -= C_UPDATEALLOBJECT_CYCLE_TIME_3D;
		}
	} 
	else if (msg.GetMessageType() == dtGame::MessageType::TICK_REMOTE)
	{
		// Do something when we get remote tick
	} else if (msg.GetMessageType() == SimMessageType::UTILITY_AND_TOOLS)
	{
		ProcessEffectControl(msg);
	}
	else
	{
		DefaultMessageProcessor::ProcessMessage(msg);
	}
}

void SimEffectControl::HandleNetworkMessage(const dtGame::Message& msg)
{
	 if (msg.GetMessageType() == SimMessageType::UTILITY_AND_TOOLS)
		ProcessEffectControl(msg);
}


//////////////////////////////////////////////////////////////////////////
EffectControlDef* SimEffectControl::AddEffect(const int mSetID, const int mTypeEffect, const int mLifeTime ) 
{
	EffectControlDef *mEffect = new EffectControlDef(mSetID,mTypeEffect,mLifeTime);
	mEffects.push_back(*mEffect);
	return mEffect;
}

//////////////////////////////////////////////////////////////////////////
EffectControlDef::EffectControlDef(int cSetID, int cTypeEffect ,float cLifeTime) 
{
	mSetID			= cSetID ;
	mTypeEffect		= cTypeEffect;
	mLifeTime		= cLifeTime ;
}

////////////////////////////////////////////////////////////////////////////////////