#include "SimMessageType.h"
#include "simmessages.h"

#include <dtGame/messageparameter.h>
#include <dtGame/messagefactory.h>

IMPLEMENT_ENUM(SimMessageType);

//const SimMessageType SimMessageType::SIM_GAME_MSG(C_MT_SIMMES, C_MT_INFO,C_MT_SIMMES,USER_DEFINED_MESSAGE_TYPE + 1);
const SimMessageType SimMessageType::NOTIFY_LOGIN(C_MT_NOTIFY_LOGIN, C_MT_INFO,C_MT_SIMMES, USER_DEFINED_MESSAGE_TYPE + 2);
const SimMessageType SimMessageType::APPLY_LOGIN(C_MT_APPLY_LOGIN, C_MT_INFO,C_MT_SIMMES, USER_DEFINED_MESSAGE_TYPE + 3);
const SimMessageType SimMessageType::REJECT_LOGIN(C_MT_REJECT_LOGIN, C_MT_INFO,C_MT_SIMMES, USER_DEFINED_MESSAGE_TYPE + 4);
const SimMessageType SimMessageType::UPDATE_PARENT(C_MT_UPDATE_PARENT, C_MT_INFO,C_MT_SIMMES, USER_DEFINED_MESSAGE_TYPE + 5);
//const SimMessageType SimMessageType::EVENT_ON_OBJECT(C_MT_EVENT_ON_OBJECT, C_MT_INFO,C_MT_SIMMES, USER_DEFINED_MESSAGE_TYPE + 6);
const SimMessageType SimMessageType::ORDER_EVENT(C_MT_ORDER_EVENT, C_MT_INFO,C_MT_SIMMES, USER_DEFINED_MESSAGE_TYPE + 7);
const SimMessageType SimMessageType::ASROCK_EVENT(C_MT_ASROCK_EVENT, C_MT_INFO,C_MT_SIMMES, USER_DEFINED_MESSAGE_TYPE + 9);
const SimMessageType SimMessageType::RBU_EVENT(C_MT_RBU_EVENT, C_MT_INFO,C_MT_SIMMES, USER_DEFINED_MESSAGE_TYPE + 10);
const SimMessageType SimMessageType::TORPEDO_EVENT(C_MT_TORPEDO_EVENT, C_MT_INFO,C_MT_SIMMES, USER_DEFINED_MESSAGE_TYPE + 11); //EKA-031111
const SimMessageType SimMessageType::POSITION_EVENT(C_MT_POSITION_EVENT, C_MT_INFO,C_MT_SIMMES, USER_DEFINED_MESSAGE_TYPE + 12);
const SimMessageType SimMessageType::CANNON_EVENT(C_MT_CANNON_EVENT, C_MT_INFO,C_MT_SIMMES, USER_DEFINED_MESSAGE_TYPE + 13);
const SimMessageType SimMessageType::TORPEDOSUT_EVENT(C_MT_TORPEDOSUT_EVENT, C_MT_INFO,C_MT_SIMMES, USER_DEFINED_MESSAGE_TYPE + 14);
const SimMessageType SimMessageType::ENVIRONMENT_CONTROL(C_MT_ENVIRONMENT_CONTROL, C_MT_INFO,C_MT_SIMMES, USER_DEFINED_MESSAGE_TYPE + 15);
const SimMessageType SimMessageType::ACTORS_CONTROL(C_MT_ACTORS_CONTROL, C_MT_INFO,C_MT_SIMMES, USER_DEFINED_MESSAGE_TYPE + 16);
const SimMessageType SimMessageType::UTILITY_AND_TOOLS(C_MT_UTILITY_AND_TOOLS, C_MT_INFO,C_MT_SIMMES, USER_DEFINED_MESSAGE_TYPE + 18);
const SimMessageType SimMessageType::NOTIFY_TDS(C_MT_NOTIFY_TDS, C_MT_INFO,C_MT_SIMMES, USER_DEFINED_MESSAGE_TYPE + 19);
const SimMessageType SimMessageType::APPLY_TDS(C_MT_APPLY_TDS, C_MT_INFO,C_MT_SIMMES, USER_DEFINED_MESSAGE_TYPE + 20);
const SimMessageType SimMessageType::DATABASE_EVENT(C_MT_DATABASE_EVENT, C_MT_INFO,C_MT_SIMMES, USER_DEFINED_MESSAGE_TYPE + 21);
const SimMessageType SimMessageType::OCEAN_CONTROL(C_MT_OCEAN_CONTROL, C_MT_INFO,C_MT_SIMMES, USER_DEFINED_MESSAGE_TYPE + 22); // BAWE-20110412: ON_THE_FLY_OCEAN_CONTROL
const SimMessageType SimMessageType::CAMERA_INPUTS(C_MT_CAMERA_INPUTS, C_MT_INFO,C_MT_SIMMES, USER_DEFINED_MESSAGE_TYPE + 23); // BAWE-20121210: NEW CAMERA_INPUTS
const SimMessageType SimMessageType::C802_EVENT(C_MT_C802_EVENT, C_MT_INFO,C_MT_SIMMES, USER_DEFINED_MESSAGE_TYPE + 24); // BAWE-20120227: C802_MISSILE_ACTOR
const SimMessageType SimMessageType::MISTRAL_EVENT(C_MT_MISTRAL_EVENT, C_MT_INFO,C_MT_SIMMES, USER_DEFINED_MESSAGE_TYPE + 25); //EKA
const SimMessageType SimMessageType::TETRAL_EVENT(C_MT_TETRAL_EVENT, C_MT_INFO,C_MT_SIMMES, USER_DEFINED_MESSAGE_TYPE + 26); //EKA
const SimMessageType SimMessageType::STRELA_EVENT(C_MT_STRELA_EVENT, C_MT_INFO,C_MT_SIMMES, USER_DEFINED_MESSAGE_TYPE + 27); //EKA
const SimMessageType SimMessageType::YAKHONT_EVENT(C_MT_YAKHONT_EVENT, C_MT_INFO,C_MT_SIMMES, USER_DEFINED_MESSAGE_TYPE + 28); //BAWE-20120315: YAKHONT_MISSILE_ACTOR
const SimMessageType SimMessageType::EXOCETMM_40_EVENT(C_MT_EXOCET_MM_40_EVENT, C_MT_INFO,C_MT_SIMMES, USER_DEFINED_MESSAGE_TYPE + 30); //NANDO-20120411: EXOCET_MM40_MISSILE_ACTOR
const SimMessageType SimMessageType::CANNONHANDLE_EVENT(C_MT_CANNONHANDLE_EVENT, C_MT_INFO,C_MT_SIMMES, USER_DEFINED_MESSAGE_TYPE + 31); //  [5/7/2013 DID RKT2]
const SimMessageType SimMessageType::HANDLE_MESSAGE_EVENT(C_MT_MESSAGE_HANDLE_EVENT, C_MT_INFO,C_MT_SIMMES, USER_DEFINED_MESSAGE_TYPE + 32); //  [5/7/2013 DID RKT2]


///////////////////////////////////////////////////////////////////////////////
void SimMessageType::RegisterMessageTypes(dtGame::MessageFactory& factory)
{
	//factory.RegisterMessageType<MsgNewGameActor>(SIM_GAME_MSG);
	factory.RegisterMessageType<MsgApplyLogin>(NOTIFY_TDS);
	factory.RegisterMessageType<MsgApplyLogin>(APPLY_TDS);
	factory.RegisterMessageType<MsgApplyLogin>(NOTIFY_LOGIN);
	factory.RegisterMessageType<MsgApplyLogin>(APPLY_LOGIN);
	factory.RegisterMessageType<MsgApplyLogin>(REJECT_LOGIN);
	factory.RegisterMessageType<MsgParentActor>(UPDATE_PARENT);
	factory.RegisterMessageType<MsgOrder>(ORDER_EVENT);
	factory.RegisterMessageType<MsgSetAsrock>(ASROCK_EVENT);
	factory.RegisterMessageType<MsgSetMistral>(MISTRAL_EVENT); //EKA
	factory.RegisterMessageType<MsgSetTetral>(TETRAL_EVENT); //EKA
	factory.RegisterMessageType<MsgSetStrela>(STRELA_EVENT); //EKA
	factory.RegisterMessageType<MsgSetCannon>(CANNON_EVENT);
	factory.RegisterMessageType<MsgSetRBU>(RBU_EVENT);
	factory.RegisterMessageType<MsgPosition>(POSITION_EVENT);
	factory.RegisterMessageType<MsgEnvironmentControl>(ENVIRONMENT_CONTROL);
	factory.RegisterMessageType<MsgActorsControl>(ACTORS_CONTROL);
	factory.RegisterMessageType<MsgUtilityAndTools>(UTILITY_AND_TOOLS);
    factory.RegisterMessageType<MsgOceanControl>(OCEAN_CONTROL); // BAWE-20110412: ON_THE_FLY_OCEAN_CONTROL
	factory.RegisterMessageType<MsgSetTorpedoSUT>(TORPEDOSUT_EVENT);
	factory.RegisterMessageType<MsgDatabaseEvent>(DATABASE_EVENT);
	factory.RegisterMessageType<MsgSetTorpedo>(TORPEDO_EVENT); //EKA-031111
	factory.RegisterMessageType<MsgSetC802>(C802_EVENT); //BAWE-20120227: C802_MISSILE_ACTOR
	factory.RegisterMessageType<MsgSetYakhont>(YAKHONT_EVENT); //BAWE-20120315: YAKHONT_MISSILE_ACTOR
	factory.RegisterMessageType<MsgSetExocetMM40>(EXOCETMM_40_EVENT); //NANDO-20120411: EXOCET_MM40_MISSILE_ACTOR
	factory.RegisterMessageType<MsgSetCannon>(CANNONHANDLE_EVENT); //  [5/7/2013 DID RKT2]
	factory.RegisterMessageType<MsgSetHandleMessage>(HANDLE_MESSAGE_EVENT); //  [5/7/2013 DID RKT2]
}
 