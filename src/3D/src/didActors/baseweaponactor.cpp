#include "baseweaponactor.h"
#include "didactorssources.h"

///////////////////////////////////////////////////////////////////////////////
BaseWeaponActorProxy::BaseWeaponActorProxy()
{

}

BaseWeaponActorProxy::~BaseWeaponActorProxy()
{

}


///////////////////////////////////////////////////////////////////////////////
void BaseWeaponActorProxy::BuildPropertyMap()
{

	dtGame::GameActorProxy::BuildPropertyMap();

	BaseWeaponActor* actor = NULL;
	GetActor(actor);

	AddProperty(new dtDAL::IntActorProperty(C_SET_VID, C_SET_VID, 
		dtDAL::IntActorProperty::SetFuncType(actor, &BaseWeaponActor::SetVehicleID), 
		dtDAL::IntActorProperty::GetFuncType(actor, &BaseWeaponActor::GetVehicleID),
		"Sets/gets Vehicle Id", C_TYPE_MISSILE));

	AddProperty(new dtDAL::IntActorProperty(C_SET_WID, C_SET_WID, 
		dtDAL::IntActorProperty::SetFuncType(actor, &BaseWeaponActor::SetWeaponID), 
		dtDAL::IntActorProperty::GetFuncType(actor, &BaseWeaponActor::GetWeaponID),
		"Sets Weapon Id",C_TYPE_MISSILE));

	AddProperty(new dtDAL::IntActorProperty(C_SET_LID, C_SET_LID, 
		dtDAL::IntActorProperty::SetFuncType(actor, &BaseWeaponActor::SetLauncherID), 
		dtDAL::IntActorProperty::GetFuncType(actor, &BaseWeaponActor::GetLauncherID),
		"Sets/gets Launcher Id", C_TYPE_MISSILE));

	AddProperty(new dtDAL::IntActorProperty(C_SET_TID,C_SET_TID,
		dtDAL::IntActorProperty::SetFuncType(actor,&BaseWeaponActor::SetWeaponTypeID),
		dtDAL::IntActorProperty::GetFuncType(actor,&BaseWeaponActor::GetWeaponTypeID),
		"set body / spout / missile",C_TYPE_MISSILE )); 

	AddProperty(new dtDAL::StringActorProperty(C_SET_MODEL,C_SET_MODEL,
		dtDAL::StringActorProperty::SetFuncType(actor,&BaseWeaponActor::SetModel),
		dtDAL::StringActorProperty::GetFuncType(actor,&BaseWeaponActor::GetModel),
		"Loads the model file",C_TYPE_MISSILE ));

	AddProperty(new dtDAL::StringActorProperty(C_SET_ATTACH_DOF_NAME,C_SET_ATTACH_DOF_NAME,
		dtDAL::StringActorProperty::SetFuncType(actor,&BaseWeaponActor::SetAttachDOFName),
		dtDAL::StringActorProperty::GetFuncType(actor,&BaseWeaponActor::GetAttachDOFName),
		"Set attach dof name",C_TYPE_MISSILE ));

	AddProperty(new dtDAL::FloatActorProperty(C_SET_INIT_HEADING, C_SET_INIT_HEADING,
		dtDAL::FloatActorProperty::SetFuncType(actor, &BaseWeaponActor::SetInitHeading),
		dtDAL::FloatActorProperty::GetFuncType(actor, &BaseWeaponActor::GetInitHeading),
		"init rotation", C_TYPE_MISSILE));

	AddProperty(new dtDAL::FloatActorProperty(C_SET_INIT_PITCH, C_SET_INIT_PITCH,
		dtDAL::FloatActorProperty::SetFuncType(actor, &BaseWeaponActor::SetInitPitch),
		dtDAL::FloatActorProperty::GetFuncType(actor, &BaseWeaponActor::GetInitPitch),
		"init rotation", C_TYPE_MISSILE));

	//Nando Added
	AddProperty(new dtDAL::FloatActorProperty(C_SET_INIT_STARTANGLE, C_SET_INIT_STARTANGLE,
		dtDAL::FloatActorProperty::SetFuncType(actor, &BaseWeaponActor::SetStartAngle),
		dtDAL::FloatActorProperty::GetFuncType(actor, &BaseWeaponActor::GetStartAngle),
		"init rotation", C_TYPE_MISSILE));

	AddProperty(new dtDAL::FloatActorProperty(C_SET_INIT_ENDANGLE, C_SET_INIT_ENDANGLE,
		dtDAL::FloatActorProperty::SetFuncType(actor, &BaseWeaponActor::SetEndAngle),
		dtDAL::FloatActorProperty::GetFuncType(actor, &BaseWeaponActor::GetEndAngle),
		"init rotation", C_TYPE_MISSILE));

	AddProperty(new dtDAL::FloatActorProperty(C_SET_INIT_STARTPITCH, C_SET_INIT_STARTPITCH,
		dtDAL::FloatActorProperty::SetFuncType(actor, &BaseWeaponActor::SetStartPitch),
		dtDAL::FloatActorProperty::GetFuncType(actor, &BaseWeaponActor::GetStartPitch),
		"init rotation", C_TYPE_MISSILE));

	AddProperty(new dtDAL::FloatActorProperty(C_SET_INIT_ENDPITCH, C_SET_INIT_ENDPITCH,
		dtDAL::FloatActorProperty::SetFuncType(actor, &BaseWeaponActor::SetEndPitch),
		dtDAL::FloatActorProperty::GetFuncType(actor, &BaseWeaponActor::GetEndPitch),
		"init rotation", C_TYPE_MISSILE));

}

void BaseWeaponActorProxy::BuildInvokables()
{
    dtGame::GameActorProxy::BuildInvokables();
}

void BaseWeaponActorProxy::OnEnteredWorld()
{
	dtGame::GameActorProxy::OnEnteredWorld();
	RegisterForMessages(dtGame::MessageType::TICK_LOCAL, dtGame::GameActorProxy::TICK_LOCAL_INVOKABLE);
	GetActor()->AddSender(&(GetGameManager()->GetScene()));
}

void BaseWeaponActorProxy::OnRemovedFromWorld()
{
	dtGame::GameActorProxy::OnRemovedFromWorld();
}

///////////////////////////////////////////////////////////////////////////////
 
BaseWeaponActor::BaseWeaponActor(dtGame::GameActorProxy& proxy)
                : dtGame::GameActor(proxy)
                , mVehicleID(0)
				, mWeaponID(0)
                , mLauncherID(0)
				, mWeaponTypeID(0)
				, mPosInitHeading(0)
				, mPosInitPitch(0)
				, mStartAngle(0.0f)
				, mEndAngle(0.0f)
				, mStartPitch(0.0f)
				, mEndPitch(0.0f)
				, mDofName("")
				, mModelFile("")
				, OceanEnviX(0.0f)
				, OceanEnviY(0.0f)
				, WindEnviX(0.0f)
				, WindEnviY(0.0f)
{

}

BaseWeaponActor::~BaseWeaponActor()
{

}

void BaseWeaponActor::SetVehicleID(const int val)
{
    mVehicleID = val;
}
int BaseWeaponActor::GetVehicleID()const
{
    return mVehicleID;
}

void BaseWeaponActor::SetWeaponID(const int val)
{
	mWeaponID = val;
}
int BaseWeaponActor::GetWeaponID()const
{
	return mWeaponID;
}

void BaseWeaponActor::SetLauncherID(const int val)
{
    mLauncherID = val;
}
int BaseWeaponActor::GetLauncherID()const
{
    return mLauncherID;    
}


void BaseWeaponActor::SetWeaponTypeID ( const int val)
{ 
	mWeaponTypeID = val;
}

int BaseWeaponActor::GetWeaponTypeID() const 
{ 
	return mWeaponTypeID; 
}

void BaseWeaponActor::SetAttachDOFName ( const std::string &name) 
{ 
	mDofName = name;
}

std::string BaseWeaponActor::GetAttachDOFName() const 
{ 
	return mDofName; 
}

void BaseWeaponActor::SetInitHeading(int val) 
{ 
	mPosInitHeading = val;
}

float BaseWeaponActor::GetInitHeading() 
{ 
	return mPosInitHeading;
}

void BaseWeaponActor::SetInitPitch(int val) 
{ 
	mPosInitPitch = val;
}

float BaseWeaponActor::GetInitPitch() 
{ 
	return mPosInitPitch;
}

//Nando Added
//Start Rot Angle
void BaseWeaponActor::SetStartAngle(const float val)
{
	mStartAngle = val;
}
int BaseWeaponActor::GetStartAngle() const
{
	return mStartAngle;
}

//End Rot Angle
void BaseWeaponActor::SetEndAngle(const float val)
{
	mEndAngle = val;
}
int BaseWeaponActor::GetEndAngle() const
{
	return mEndAngle;
}

//Start Pitch Angle
void BaseWeaponActor::SetStartPitch(const float val)
{
	mStartPitch = val;
}
int BaseWeaponActor::GetStartPitch() const
{
	return mStartPitch;
}

//End Pitch Angle
void BaseWeaponActor::SetEndPitch(const float val)
{
	mEndPitch = val;
}
int BaseWeaponActor::GetEndPitch() const
{
	return mEndPitch;
}

void BaseWeaponActor::SendStatusMessageTo2D(const int MsgID, const double cmd1,const double cmd2, const double cmd3, const double cmd4)
{
	if ( GetGameActorProxy().GetGameManager()->GetMachineInfo().GetName() == C_MACHINE_SERVER )
	{
		dtCore::RefPtr<MsgSetHandleMessage> MsgMessageHandle;
		dtGame::GameManager* gm= GetGameActorProxy().GetGameManager();
		dtGame::MessageFactory* mf=&gm->GetMessageFactory();
		mf->CreateMessage(*(mf->GetMessageTypeByName(C_MT_MESSAGE_HANDLE_EVENT)),MsgMessageHandle);

		MsgMessageHandle->SetMsgID(MsgID);
		MsgMessageHandle->SetCmd1(cmd1);
		MsgMessageHandle->SetCmd2(cmd2);
		MsgMessageHandle->SetCmd3(cmd3);
		MsgMessageHandle->SetCmd4(cmd4);
		GetGameActorProxy().GetGameManager()->SendNetworkMessage(*MsgMessageHandle);   					
		GetGameActorProxy().GetGameManager()->SendMessage(*MsgMessageHandle);
	}
}

void BaseWeaponActor::UpdateStatusPlayer( const int sts)
{
	if ( GetGameActorProxy().GetGameManager()->GetMachineInfo().GetName() == C_MACHINE_SERVER )
	{
		dtCore::RefPtr<MsgUtilityAndTools> MsgCam;
		//GetGameActorProxy().GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::UTILITY_AND_TOOLS, MsgCam);

		dtGame::GameManager* gm= GetGameActorProxy().GetGameManager();
		dtGame::MessageFactory* mf=&gm->GetMessageFactory();
		mf->CreateMessage(*(mf->GetMessageTypeByName(C_MT_UTILITY_AND_TOOLS)),MsgCam);

		MsgCam->SetOrderID(TIPE_UTIL_PLAYER_SETTING);
		MsgCam->SetUAT0(0);
		MsgCam->SetUAT1(sts);
		MsgCam->SetUAT2(6);
		MsgCam->SetUAT3(1);
		MsgCam->SetUAT4(1);
		MsgCam->SetUAT5(1);
		MsgCam->SetUAT6(1);
		GetGameActorProxy().GetGameManager()->SendNetworkMessage(*MsgCam);   					
		GetGameActorProxy().GetGameManager()->SendMessage(*MsgCam);
	}
}

void BaseWeaponActor::UpdateStatusDBEffectTo3DExplode( const float x, const float y, const float z, const int sts)
{
	if ( GetGameActorProxy().GetGameManager()->GetMachineInfo().GetName() == C_MACHINE_SERVER )
	{
		dtCore::RefPtr<MsgUtilityAndTools> msgExplode;
		//GetGameActorProxy().GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::UTILITY_AND_TOOLS, msgExplode);

		dtGame::GameManager* gm= GetGameActorProxy().GetGameManager();
		dtGame::MessageFactory* mf=&gm->GetMessageFactory();
		mf->CreateMessage(*(mf->GetMessageTypeByName(C_MT_UTILITY_AND_TOOLS)),msgExplode);

		if ( sts == ST_MISSILE_EXPLODE  ) 
		{ 
			msgExplode->SetOrderID(TIPE_UTIL_EVENT_EXPLODE);
			msgExplode->SetUAT0(mWeaponID);
			msgExplode->SetUAT1(x);   // x
			msgExplode->SetUAT2(y);   // y
			msgExplode->SetUAT3(z);   // z
			msgExplode->SetUAT5(mVehicleID);
			msgExplode->SetUAT6(mLauncherID);
			GetGameActorProxy().GetGameManager()->SendNetworkMessage(*msgExplode);
			GetGameActorProxy().GetGameManager()->SendMessage(*msgExplode);
			std::cout<<GetName()<<" send status  3D Explode"<<std::endl;
		}

	}
}

void BaseWeaponActor::SetModel(const std::string &fileName)
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
			LOG_ERROR("Unable to load model file: " + fileName);
		}

		//the game manager is not set when this property is first set at map load time.
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

std::string BaseWeaponActor::GetModel() const 
{ 
	return mModelFile; 
}
dtCore::RefPtr<dtDAL::ActorProxy> BaseWeaponActor::GetShipActorByID(int VID )
{
	dtCore::RefPtr<dtDAL::ActorProxy> proxy = NULL;

	std::vector<dtGame::GameActorProxy *> fill;
	std::vector<dtGame::GameActorProxy *>::iterator iter;
	GetGameActorProxy().GetGameManager()->GetAllGameActors(fill);

	for (iter = fill.begin(); iter < fill.end(); iter++)
	{
		//nando Edit +AirSHIP
		if (((*iter)->GetActorType().GetName()== C_CN_SHIP )		|| 
			((*iter)->GetActorType().GetName()== C_CN_SUBMARINE )	||
			((*iter)->GetActorType().GetName()== C_CN_HELICOPTER) ) 
		{
			dtCore::RefPtr<dtDAL::ActorProperty> PVehID( (*iter)->GetProperty(C_SET_VID) );
			dtCore::RefPtr<dtDAL::IntActorProperty> ValID( static_cast<dtDAL::IntActorProperty*>( PVehID.get() ) );
			int tgt( ValID->GetValue() );
			if ( tgt == VID )
			{
				proxy = (*iter);
				break;
			}
		}
	}
	if(!proxy.valid())
	{
		return NULL;
	}
	return proxy;
}


dtCore::RefPtr<dtDAL::ActorProxy> BaseWeaponActor::GetLauncherActors( const int actTypeID, const int mVehicleID, const int mWeaponID, const int mLauncherID  )
{

	dtCore::RefPtr<dtDAL::ActorProxy> proxy = NULL;

	std::vector<dtGame::GameActorProxy *> fill;
	std::vector<dtGame::GameActorProxy *>::iterator iter;
	GetGameActorProxy().GetGameManager()->GetAllGameActors(fill);

	const std::string& actTypeName = GetActorWeaponTypeName(mWeaponID,actTypeID);

	for (iter = fill.begin(); iter < fill.end(); iter++)
	{

		if (((*iter)->GetActorType().GetName()== actTypeName )) 
		{
			dtCore::RefPtr<dtDAL::ActorProperty> PVehID( (*iter)->GetProperty(C_SET_VID) );
			dtCore::RefPtr<dtDAL::IntActorProperty> ValID( static_cast<dtDAL::IntActorProperty*>( PVehID.get() ) );
			int tgt( ValID->GetValue() );
			if ( tgt == mVehicleID )
			{
				dtCore::RefPtr<dtDAL::ActorProperty> PWeaponID( (*iter)->GetProperty(C_SET_WID) );
				dtCore::RefPtr<dtDAL::IntActorProperty> ValWeaponID( static_cast<dtDAL::IntActorProperty*>( PWeaponID.get() ) );
				int wpn( ValWeaponID->GetValue() );
				if ( wpn == mWeaponID )
				{
					dtCore::RefPtr<dtDAL::ActorProperty> PLauncherID( (*iter)->GetProperty(C_SET_LID) );
					dtCore::RefPtr<dtDAL::IntActorProperty> ValLauncherID( static_cast<dtDAL::IntActorProperty*>( PLauncherID.get() ) );
					int lcr( ValLauncherID->GetValue() );
					if ( lcr == mLauncherID )
					{
						proxy = (*iter);
						break;
					}
				}
			}
		}
	}
	if(!proxy.valid())
	{
		return NULL;
	}
	return proxy;

}

void BaseWeaponActor::OnEnteredWorld()
{
	dtGame::GameActor::OnEnteredWorld();

	AddSender(&(GetGameActorProxy().GetGameManager()->GetScene()));
}

void BaseWeaponActor::OnRemovedFromWorld()
{
	RemoveSender(&(GetGameActorProxy().GetGameManager()->GetScene()));
}

//Environemnt
float BaseWeaponActor::GetEnvi_SeaState()
{
	SimEnvironmentDataBase* simEnviDB = dynamic_cast<SimEnvironmentDataBase*> (GetGameActorProxy().GetGameManager()->GetComponentByName(C_COMP_ENVI_DB));
	if (simEnviDB != NULL)
	{
		return simEnviDB->mEnvi_SeaState;
	}
	else
		return 0.0f;
}

float BaseWeaponActor::GetEnvi_WindSpeed()
{
	SimEnvironmentDataBase* simEnviDB = dynamic_cast<SimEnvironmentDataBase*> (GetGameActorProxy().GetGameManager()->GetComponentByName(C_COMP_ENVI_DB));
	if (simEnviDB != NULL)
	{
		return simEnviDB->mEnvi_WindSpeed;
	}
	else
		return 0.0f;
}

float BaseWeaponActor::GetEnvi_CurrrentSpeed()
{
	SimEnvironmentDataBase* simEnviDB = dynamic_cast<SimEnvironmentDataBase*> (GetGameActorProxy().GetGameManager()->GetComponentByName(C_COMP_ENVI_DB));
	if (simEnviDB != NULL)
	{
		return simEnviDB->mEnvi_CurrentSpeed;
	}
	else
		return 0.0f;
}

float BaseWeaponActor::GetEnvi_Temperature()
{
	SimEnvironmentDataBase* simEnviDB = dynamic_cast<SimEnvironmentDataBase*> (GetGameActorProxy().GetGameManager()->GetComponentByName(C_COMP_ENVI_DB));
	if (simEnviDB != NULL)
	{
		return simEnviDB->mEnvi_Temperature;
	}
	else
		return 0.0f;
}

float BaseWeaponActor::GetEnvi_BarometerPressure()
{
	SimEnvironmentDataBase* simEnviDB = dynamic_cast<SimEnvironmentDataBase*> (GetGameActorProxy().GetGameManager()->GetComponentByName(C_COMP_ENVI_DB));
	if (simEnviDB != NULL)
	{
		return simEnviDB->mEnvi_BarometerPressure;
	}
	else
		return 0.0f;
}

float BaseWeaponActor::GetEnvi_Humidity()
{
	SimEnvironmentDataBase* simEnviDB = dynamic_cast<SimEnvironmentDataBase*> (GetGameActorProxy().GetGameManager()->GetComponentByName(C_COMP_ENVI_DB));
	if (simEnviDB != NULL)
	{
		return simEnviDB->mEnvi_Humidity;
	}
	else
		return 0.0f;
}

float BaseWeaponActor::GetEnvi_WindDirection()
{
	SimEnvironmentDataBase* simEnviDB = dynamic_cast<SimEnvironmentDataBase*> (GetGameActorProxy().GetGameManager()->GetComponentByName(C_COMP_ENVI_DB));
	if (simEnviDB != NULL)
	{
		return simEnviDB->mEnvi_WindDirection;
	}
	else
		return 0.0f;
}

float BaseWeaponActor::GetEnvi_CurrentDirection()
{
	SimEnvironmentDataBase* simEnviDB = dynamic_cast<SimEnvironmentDataBase*> (GetGameActorProxy().GetGameManager()->GetComponentByName(C_COMP_ENVI_DB));
	if (simEnviDB != NULL)
	{
		return simEnviDB->mEnvi_CurrentDirection;
	}
	else
		return 0.0f;
}

float BaseWeaponActor::GetFog_Height()
{
	SimEnvironmentDataBase* simEnviDB = dynamic_cast<SimEnvironmentDataBase*> (GetGameActorProxy().GetGameManager()->GetComponentByName(C_COMP_ENVI_DB));
	if (simEnviDB != NULL)
	{
		return simEnviDB->mEnvi_Fog_Height;
	}
	else
		return 0.0f;
}

float BaseWeaponActor::GetOceanDirX()
{
	SimEnvironmentDataBase* simEnviDB = dynamic_cast<SimEnvironmentDataBase*> (GetGameActorProxy().GetGameManager()->GetComponentByName(C_COMP_ENVI_DB));
	if (simEnviDB != NULL)
	{
		return simEnviDB->DriftX;
	}
	else
		return 0.0f;
}

float BaseWeaponActor::GetOceanDirY()
{
	SimEnvironmentDataBase* simEnviDB = dynamic_cast<SimEnvironmentDataBase*> (GetGameActorProxy().GetGameManager()->GetComponentByName(C_COMP_ENVI_DB));
	if (simEnviDB != NULL)
	{
		return simEnviDB->DriftY;
	}
	else
		return 0.0f;
}

float BaseWeaponActor::GetWindDirX()
{
	SimEnvironmentDataBase* simEnviDB = dynamic_cast<SimEnvironmentDataBase*> (GetGameActorProxy().GetGameManager()->GetComponentByName(C_COMP_ENVI_DB));
	if (simEnviDB != NULL)
	{
		return simEnviDB->WindX;
	}
	else
		return 0.0f;
}

float BaseWeaponActor::GetWindDirY()
{
	SimEnvironmentDataBase* simEnviDB = dynamic_cast<SimEnvironmentDataBase*> (GetGameActorProxy().GetGameManager()->GetComponentByName(C_COMP_ENVI_DB));
	if (simEnviDB != NULL)
	{
		return simEnviDB->WindY;
	}
	else
		return 0.0f;
}