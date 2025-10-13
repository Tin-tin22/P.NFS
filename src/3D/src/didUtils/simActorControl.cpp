///////////////////////////////////////////////////////////////////////////////
//
// File           : $Workfile: simActorControl.cpp $
// Version        : $Revision: 1.17 $
// Function       :  
// Sam
// 
///////////////////////////////////////////////////////////////////////////////

#include "./simActorControl.h"
#include "../didActors/ShipModelActor.h"
#include "../didActors/SubMarineActor.h"
#include "../didActors/HelicopterActor.h"
#include "../didActors/playeractor.h"
#include "../didActors/AircraftActor.h"
#include "../didUtils/utilityfunctions.h"
#include "../didUtils/simDBConnection.h"
#include "../didUtils/SimServerClientComponent.h"
#include "../didNetwork/SimTCPDataTypes.h"
#include "../ext/pthreads-w32-2-9-1-release/Pre-built.2/include/pthread.h"
#include "../didActors/launcherbodyactor.h"


//#include <eh.h>
#include <dtABC/application.h>

#include <dtCore/Transform.h>
#include <dtCore/camera.h>
#include <dtCore/scene.h>
#include <dtCore/FlyMotionModel.h>
#include <dtCore/system.h>

#include <dtDAL/enginepropertytypes.h>
#include <dtDAL/ActorType.h>
#include <dtDAL/actorproperty.h>
#include <dtDAL/actorproxy.h>
#include <dtDAL/LibraryManager.h>
#include <iostream>
#include <string>

// Nando Added
#include "../didCommon/SimMessages.h"
#include "../didCommon/simmessagetype.h"
#include "../didCommon/BaseConstant.h"
#define _WINSOCKAPI_
#ifndef WIN32_LEAN_AND_MEAN
#define WIN32_LEAN_AND_MEAN
#endif
#include <Windows.h>
#include <dtUtil/mswin.h>
#pragma comment(lib, "ws2_32.lib")
//++ Constants
 
const std::string C_MODEL_MISC_1			= "../data/mesh/misc/ojk1.ive";
const std::string C_MODEL_MISC_2			= "../data/mesh/misc/ojk2.ive";
const std::string C_MODEL_MISC_3			= "../data/mesh/misc/ojk3.ive";
const std::string C_MODEL_MISC_4			= "../data/mesh/misc/misc1.ive";
const std::string C_MODEL_MISC_5			= "../data/mesh/misc/misc2.ive";
const std::string C_MODEL_MISC_6			= "../data/mesh/misc/misc3.ive";

//++ Constants
pthread_mutex_t var=PTHREAD_MUTEX_INITIALIZER;

//  CPPUNIT_ASSERT[3/4/2013 DID RKT2]
#define CPPUNIT_ASSERT(condition)                                                 \
	( CPPUNIT_NS::Asserter::failIf( !(condition),                                   \
	CPPUNIT_NS::Message( "assertion failed",         \
	"Expression: " #condition), \
	CPPUNIT_SOURCELINE() ) )

//  CPPUNIT_ASSERT_MESSAGE[3/4/2013 DID RKT2]
#define CPPUNIT_ASSERT_MESSAGE(message,condition)                          \
	( CPPUNIT_NS::Asserter::failIf( !(condition),                            \
	CPPUNIT_NS::Message( "assertion failed", \
	"Expression: "      \
	#condition,         \
	message ),          \
	CPPUNIT_SOURCELINE() ) )

// CPPUNIT_EXTRACT_EXCEPTION_TYPE_ [3/1/2013 DID RKT2]
#define CPPUNIT_EXTRACT_EXCEPTION_TYPE_( exception, no_rtti_message ) \
	std::string( no_rtti_message )

//  CPPUNIT_GET_PARAMETER_STRING[3/1/2013 DID RKT2]
#define CPPUNIT_GET_PARAMETER_STRING( parameter ) #parameter

//  CPPUNIT_ASSERT_THROW_MESSAGE[3/1/2013 DID RKT2]
# define CPPUNIT_ASSERT_THROW_MESSAGE( message, expression, ExceptionType )   \
	do {                                                                       \
		bool cpputCorrectExceptionThrown_ = false;                              \
		CPPUNIT_NS::Message cpputMsg_( "expected exception not thrown" );       \
		cpputMsg_.addDetail( message );                                         \
		cpputMsg_.addDetail( "Expected: "                                       \
		CPPUNIT_GET_PARAMETER_STRING( ExceptionType ) );   \
		\
		try {                                                                   \
			expression;                                                          \
		} catch ( const ExceptionType & ) {                                     \
			cpputCorrectExceptionThrown_ = true;                                 \
		} catch ( const std::exception &e) {                                    \
			cpputMsg_.addDetail( "Actual  : " +                                  \
			CPPUNIT_EXTRACT_EXCEPTION_TYPE_( e,             \
			"std::exception or derived") );     \
			cpputMsg_.addDetail( std::string("What()  : ") + e.what() );         \
		} catch ( ... ) {                                                       \
			cpputMsg_.addDetail( "Actual  : unknown.");                          \
		}                                                                       \
		\
		if ( cpputCorrectExceptionThrown_ )                                     \
		break;                                                               \
		\
		CPPUNIT_NS::Asserter::fail( cpputMsg_,                                  \
		CPPUNIT_SOURCELINE() );                     \
	} while ( false )

//  CPPUNIT_ASSERT_NO_THROW_MESSAGE [3/1/2013 DID RKT2]
# define CPPUNIT_ASSERT_NO_THROW_MESSAGE( message, expression )               \
	do {                                                                       \
		CPPUNIT_NS::Message cpputMsg_( "unexpected exception caught" );         \
		cpputMsg_.addDetail( message );                                         \
		\
		try {                                                                   \
			expression;                                                          \
		} catch ( const std::exception &e ) {                                   \
			cpputMsg_.addDetail( "Caught: " +                                    \
			CPPUNIT_EXTRACT_EXCEPTION_TYPE_( e,             \
			"std::exception or derived" ) );    \
			cpputMsg_.addDetail( std::string("What(): ") + e.what() );           \
			CPPUNIT_NS::Asserter::fail( cpputMsg_,                               \
			CPPUNIT_SOURCELINE() );                  \
		} catch ( ... ) {                                                       \
			cpputMsg_.addDetail( "Caught: unknown." );                           \
			CPPUNIT_NS::Asserter::fail( cpputMsg_,                               \
			CPPUNIT_SOURCELINE() );                  \
		}                                                                       \
	} while ( false )

//  CPPUNIT_FAIL[3/4/2013 DID RKT2]
#define CPPUNIT_FAIL( message )                                         \
	( CPPUNIT_NS::Asserter::fail( CPPUNIT_NS::Message( "forced failure",  \
	message ),         \
	CPPUNIT_SOURCELINE() ) )

SimActorControl::SimActorControl(void): 
	dtGame::GMComponent(C_COMP_ACTOR_CONTROLLER),cfgLauncher(),cfgMissile()
{
	isFirst = true;
	i_launcher = 0;
	isSalvoCannon = false;
	isSalvoRBU = false;
	isSalvoYakhont = false;
	isReleaseYakhont = false;
	enableProcessMessage = true;

	count_1 = false;
	count_4 = false;
	count_8 = false;
	count_12 = false;
}

SimActorControl::~SimActorControl(void)
{

}

void SimActorControl::ProcessMessage(const dtGame::Message& Message)
{
	if (enableProcessMessage)
	{
		//LOG_INFO("Actors Control Event");
		if(Message.GetMessageType().GetName() == SimMessageType::POSITION_EVENT.GetName())
		{
			ProcessSetShipPosition(Message);
		}
		else if(Message.GetMessageType().GetName() == SimMessageType::ACTORS_CONTROL.GetName())
		{
			ProcessSetActorController(Message);
		}
		//nando added
		else
			if (Message.GetMessageType().GetName() == SimMessageType::TICK_LOCAL.GetName())
			{
				//if((isSalvoCannon==true) || (isSalvoRBU==true) || (isSalvoYakhont==true))
				//{-
				const dtGame::TickMessage &tick = static_cast<const dtGame::TickMessage&>(Message);
				float deltaSimTime = tick.GetDeltaSimTime();

				CheckForSalvo(deltaSimTime);
				CheckLaunchSalvo(deltaSimTime);
				//std::cout << "Check Salvo" << std::endl;
				//}	
			}
	}
}

const unsigned int DEL_CURR = 1; // ...
const unsigned int DEL_ALL  = 2; // ...

void SimActorControl::ProcessSetActorController(const dtGame::Message &message)
{
	const MsgActorsControl &Msg = static_cast<const MsgActorsControl&>(message);

	int ObjectMiscType = (int)Msg.GetTipeID();

	switch ( ObjectMiscType )
	{
		//////////////////////////////////////////////////////////////////////////
		case TIPE_AR_SHIP :
		{
			switch ( Msg.GetOrderID())
			{
				case STATE_AR_CLEAR :
					DeleteShipActor(DEL_ALL,0);
				break;

				case STATE_AR_DEL :
					{
						int mVehicleID = (int)Msg.GetVehicleID();
						dtCore::RefPtr<dtDAL::ActorProxy> proxy = GetShipActorByID(mVehicleID);
						if(!proxy.valid())
						{
							std::cout<<GetName()<<" invalid proxy with vehicle ID :: "<<mVehicleID<<std::endl;
						}
						else
							DeleteShipActor(DEL_CURR,mVehicleID);
								
					}
				break;

				case STATE_AR_CREATE :
				{
					int mVehicleID = (int)Msg.GetVehicleID();
					dtCore::RefPtr<dtDAL::ActorProxy> proxy = GetShipActorByID(mVehicleID);
					if(!proxy.valid())
					{
						double x(Msg.GetPosXValue()); 
						double y(Msg.GetPosYValue()); 
						double z(Msg.GetPosZValue()); 
						double h(Msg.GetPosHValue()); 
						CreateDefaultShipActor(mVehicleID, x,y,z ,h);
					}
					else
						std::cout<<proxy->GetActor()->GetName()<<" already exist."<<std::endl;	 
				}
			}
		}
		break;

		case TIPE_AR_SUBMARINE :
		{
			switch ( Msg.GetOrderID())
			{
				case STATE_AR_CLEAR :
					DeleteShipActor(DEL_ALL,0);
				break;

				case STATE_AR_DEL :
					{
						int mVehicleID = (int)Msg.GetVehicleID();
						dtCore::RefPtr<dtDAL::ActorProxy> proxy = GetShipActorByID(mVehicleID);
						if(!proxy.valid())
						{
							std::cout<<GetName()<<" invalid proxy with vehicle ID :: "<<mVehicleID<<std::endl;
						}
						else
							DeleteShipActor(DEL_CURR,mVehicleID);
								
					}
				break;

				case STATE_AR_CREATE :
				{
					int mVehicleID = (int)Msg.GetVehicleID();
					dtCore::RefPtr<dtDAL::ActorProxy> proxy = GetShipActorByID(mVehicleID);
					if(!proxy.valid())
					{
						double x(Msg.GetPosXValue()); 
						double y(Msg.GetPosYValue()); 
						double z(Msg.GetPosZValue()); 
						double h(Msg.GetPosHValue()); 
						CreateSubMarineActor(mVehicleID, x,y,z ,h);
					}
					else
						std::cout<<proxy->GetActor()->GetName()<<" already exist."<<std::endl;	 
				}
			}
		}
		break;

		case TIPE_AR_HELICOPTER :
			{
				switch ( Msg.GetOrderID())
				{
				case STATE_AR_CLEAR :
					DeleteShipActor(DEL_ALL,0);
					break;

				case STATE_AR_DEL :
					{
						int mVehicleID = (int)Msg.GetVehicleID();
						dtCore::RefPtr<dtDAL::ActorProxy> proxy = GetShipActorByID(mVehicleID);
						if(!proxy.valid())
						{
							std::cout<<GetName()<<" invalid proxy with vehicle ID :: "<<mVehicleID<<std::endl;
						}
						else
							DeleteShipActor(DEL_CURR,mVehicleID);

					}
					break;

				case STATE_AR_CREATE :
					{
						int mVehicleID = (int)Msg.GetVehicleID();
						dtCore::RefPtr<dtDAL::ActorProxy> proxy = GetShipActorByID(mVehicleID);
						if(!proxy.valid())
						{
							double x(Msg.GetPosXValue()); 
							double y(Msg.GetPosYValue()); 
							double z(Msg.GetPosZValue()); 
							double h(Msg.GetPosHValue()); 
							CreateHelicopterActor(mVehicleID, x,y,z ,h);
						}
						else
							std::cout<<proxy->GetActor()->GetName()<<" already exist."<<std::endl;	 
					}
				}
			}
			break;

		case TIPE_AR_AIRCRAFT :
			{
				switch ( Msg.GetOrderID())
				{
				case STATE_AR_CLEAR :
					DeleteShipActor(DEL_ALL,0);
					break;

				case STATE_AR_DEL :
					{
						int mVehicleID = (int)Msg.GetVehicleID();
						dtCore::RefPtr<dtDAL::ActorProxy> proxy = GetShipActorByID(mVehicleID);
						if(!proxy.valid())
						{
							std::cout<<GetName()<<" invalid proxy with vehicle ID :: "<<mVehicleID<<std::endl;
						}
						else
							DeleteShipActor(DEL_CURR,mVehicleID);

					} 
					break;

				case STATE_AR_CREATE :
					{
						int mVehicleID = (int)Msg.GetVehicleID();
						dtCore::RefPtr<dtDAL::ActorProxy> proxy = GetShipActorByID(mVehicleID);
						if(!proxy.valid())
						{
							double x(Msg.GetPosXValue()); 
							double y(Msg.GetPosYValue()); 
							double z(Msg.GetPosZValue()); 
							double h(Msg.GetPosHValue()); 
							//CreateHelicopterActor(mVehicleID, x,y,z ,h);
							CreateAircraftActor(mVehicleID, x, y, z, h);
						}
						else
							std::cout<<proxy->GetActor()->GetName()<<" already exist."<<std::endl;	 
					}
				}
			}
			break;
		//////////////////////////////////////////////////////////////////////////

		case TIPE_AR_LAUNCHER :
			{
				switch ( Msg.GetOrderID())
				{
				case STATE_AR_CLEAR :
					// 
					break;

				case STATE_AR_DEL :
					// 
					break;

				case STATE_AR_CREATE :
					{
						int mVehicleID  = (int)Msg.GetVehicleID();
						int mWeaponID   = (int)Msg.GetActorRuntimeID1();
						int mLauncherID = (int)Msg.GetActorRuntimeID2();

						dtCore::RefPtr<dtDAL::ActorProxy> proxy = GetLauncherActors(C_WEAPON_TYPE_SPOUT, mVehicleID, mWeaponID, mLauncherID);
						if(!proxy.valid())
							CreateLaunchersActors( mVehicleID, mWeaponID, mLauncherID );
						else
							std::cout<<proxy->GetActor()->GetName()<<" already exist."<<std::endl;	 
					}
					break;
				}
			}
			break;

		//////////////////////////////////////////////////////////////////////////

		case TIPE_AR_MISSILE :
			{
				switch ( Msg.GetOrderID())
				{
				case STATE_AR_CLEAR :
					// 
					break;

				case STATE_AR_DEL :
					{
						int mVehicleID  = (int)Msg.GetVehicleID();
						int mWeaponID   = (int)Msg.GetActorRuntimeID1();
						int mLauncherID = (int)Msg.GetActorRuntimeID2();
						int mMissileID  = (int)Msg.GetActorRuntimeID3();
						int mMissileNum = (int)Msg.GetActorRuntimeID4();
						DeleteMissileActors(mVehicleID, mWeaponID, mLauncherID, mMissileID, mMissileNum);
					}
					
					break;

				case STATE_AR_CREATE :
					{
						int mVehicleID  = (int)Msg.GetVehicleID();
						int mWeaponID   = (int)Msg.GetActorRuntimeID1();
						int mLauncherID = (int)Msg.GetActorRuntimeID2();
						int mMissileID  = (int)Msg.GetActorRuntimeID3();
						int mMissileNum = (int)Msg.GetActorRuntimeID4();
						
						dtCore::RefPtr<dtDAL::ActorProxy> proxy = GetMissileActors(mVehicleID, mWeaponID, mLauncherID, mMissileID, mMissileNum);
						if(!proxy.valid())
							CreateMissileActors( mVehicleID, mWeaponID, mLauncherID, mMissileID, mMissileNum);
						else
							std::cout<<proxy->GetActor()->GetName()<<" already exist."<<std::endl;	 
					}
					break;
				}
			}
			break;
		

		//////////////////////////////////////////////////////////////////////////

		case TIPE_MISC_OJK :
			{
				switch ( Msg.GetOrderID())
				{
				case ORD_MISC_CLEAR :
					DeleteObjectMisc(ObjectMiscType, DEL_ALL, 0);
					break;

				case ORD_MISC_DEL :
					DeleteObjectMisc(ObjectMiscType, DEL_CURR, (int)Msg.GetVehicleID());
					break;

				case ORD_MISC_CREATE :
					{
						int ObjectID = (int)Msg.GetVehicleID();
						dtCore::RefPtr<dtDAL::ActorProxy> proxy = GetMiscActorByID(ObjectID);
						if(!proxy.valid())
						{
							int mModelID = (int)Msg.GetPosPValue(); 
							double x(Msg.GetPosXValue()); 
							double y(Msg.GetPosYValue()); 
							double z(Msg.GetPosZValue()); 
							double h(Msg.GetPosHValue()); 
							CreateActorMisc(ObjectID, ObjectMiscType, mModelID, x,y,z ,h);
						}
						else
							std::cout<<proxy->GetActor()->GetName()<<" already exist."<<std::endl;	 
					}
					break;
				}
			}
			break;

		case TIPE_MISC_OLL :
			{
				switch ( Msg.GetOrderID())
				{
				case ORD_MISC_CLEAR :
					DeleteObjectMisc(ObjectMiscType, DEL_ALL, 0);
					break;

				case ORD_MISC_DEL :
					DeleteObjectMisc(ObjectMiscType, DEL_CURR, (int)Msg.GetVehicleID());
					break;

				case ORD_MISC_CREATE :
					{
						int ObjectID = (int)Msg.GetVehicleID();
						dtCore::RefPtr<dtDAL::ActorProxy> proxy = GetMiscActorByID(ObjectID);
						if(!proxy.valid())
						{
							int mModelID = (int)Msg.GetPosPValue();
							double x(Msg.GetPosXValue()); 
							double y(Msg.GetPosYValue()); 
							double z(Msg.GetPosZValue()); 
							double h(Msg.GetPosHValue()); 
							CreateActorMisc(ObjectID, ObjectMiscType, mModelID, x,y,z ,h);
						}
						else
							std::cout<<proxy->GetActor()->GetName()<<" already exist."<<std::endl;	 
					}
					break;
				}
			}
			break;

		case TIPE_MISC_RANJAU:
		{

		}
		break;		
	}
}


//void SimActorControl::SendRequestSetCameraOnMissile( const int VID, const int WID, const int LID, const int MID, const int MNum )
//{
//	dtCore::RefPtr<dtDAL::ActorProxy> proxy = GetMissileActors(VID,WID,LID,MID,MNum);
//	if(!proxy.valid())
//	{
//		std::cout<< " receive command set missile camera actor " << proxy->GetActor()->GetName() << std::endl;
//		dtCore::RefPtr<dtCore::Camera> mCam = GetGameManager()->GetApplication().GetCamera();
//		dtCore::UniqueId mCurrentTargetId (proxy->GetActor()->GetUniqueId());
//
//		if ( mCam->GetParent() != NULL )
//		{
//			if (  mCam->GetParent()->GetUniqueId() == mCurrentTargetId )
//			{
//				std::cout<<"Camera already set on "<<proxy->GetActor()->GetName()<<std::endl;
//			} 
//			else
//			{
//				mCam->GetParent()->RemoveChild(GetGameManager()->GetApplication().GetCamera());
//				std::cout<<"Remove Parent Child before add to "<<proxy->GetActor()->GetName()<<std::endl;
//			}
//		}
//
//		dtCore::RefPtr<MsgUtilityAndTools> Msg;
//		GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::UTILITY_AND_TOOLS, Msg);
//
//		Msg->SetOrderID(TIPE_UTIL_CAM_REQUEST);
//		Msg->SetUAT0(VID);
//		Msg->SetUAT1(WID);
//		Msg->SetUAT2(LID);
//		Msg->SetUAT3(MID);
//		Msg->SetUAT4(0);
//		Msg->SetUAT5(0);
//		Msg->SetUAT6(0);
//
//		//GetGameManager()->SendNetworkMessage(*Msg.get());
//		GetGameManager()->SendMessage(*Msg.get());
//							
//	}
//	else
//		std::cout<< " receive command set missile camera actor :: " << VID <<":" << WID << ":" << LID <<":" << MID <<
//			", but can't find missile id" << std::endl;	 
//
//}

//void SimActorControl::SendRequestSetCameraOnMissile( const int VID, const int WID, const int LID, const int MID, const int MNum , const dtCore::Transform pos) 
//{
//	SendRequestSetCameraOnMissile(VID,WID,LID,MID, MNum);
//	GetGameManager()->GetApplication().GetCamera()->SetTransform(pos, dtCore::Transformable::REL_CS);
//}


//////////////////////////////////////////////////////////////////////////
void SimActorControl::RegisterEventOnActors(dtGame::GameActorProxy& gap, const int mWeaponID ) 
{
	GetGameManager()->RegisterForMessages(dtGame::MessageType::TICK_LOCAL,gap,dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);

	if ( mWeaponID == CT_ASROC)			
		GetGameManager()->RegisterForMessages(SimMessageType::ASROCK_EVENT,gap,dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
	else if ( mWeaponID == CT_C802)			
		GetGameManager()->RegisterForMessages(SimMessageType::C802_EVENT,gap,dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
	else if ( mWeaponID == CT_CANNON_120)		
		GetGameManager()->RegisterForMessages(SimMessageType::CANNON_EVENT,gap,dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
	else if ( mWeaponID == CT_CANNON_76)		
		GetGameManager()->RegisterForMessages(SimMessageType::CANNON_EVENT,gap,dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
	else if ( mWeaponID == CT_CANNON_57)		
		GetGameManager()->RegisterForMessages(SimMessageType::CANNON_EVENT,gap,dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
	else if ( mWeaponID == CT_CANNON_40)		
		GetGameManager()->RegisterForMessages(SimMessageType::CANNON_EVENT,gap,dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
	else if ( mWeaponID == CT_MISTRAL)		
		GetGameManager()->RegisterForMessages(SimMessageType::MISTRAL_EVENT,gap,dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
	else if ( mWeaponID == CT_RBU_6000)		
		GetGameManager()->RegisterForMessages(SimMessageType::RBU_EVENT,gap,dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
	else if ( mWeaponID == CT_STRELA)			
		GetGameManager()->RegisterForMessages(SimMessageType::STRELA_EVENT,gap,dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
	else if ( mWeaponID == CT_TETRAL)			
		GetGameManager()->RegisterForMessages(SimMessageType::TETRAL_EVENT,gap,dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
	else if ( mWeaponID == CT_TORPEDO_SUT)	
		GetGameManager()->RegisterForMessages(SimMessageType::TORPEDOSUT_EVENT,gap,dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
	else if ( mWeaponID == CT_TORPEDO_A244S)	
		GetGameManager()->RegisterForMessages(SimMessageType::TORPEDO_EVENT,gap,dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
	else if ( mWeaponID == CT_YAKHONT)		
		GetGameManager()->RegisterForMessages(SimMessageType::YAKHONT_EVENT,gap,dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
	else if ( mWeaponID == CT_EXOCET_40)
		GetGameManager()->RegisterForMessages(SimMessageType::EXOCETMM_40_EVENT,gap,dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
	else
		std::cout<<" !!!! WARNING !!!! :: "<<GetName()<<" Unregigistered event on weapon ID :: "<<mWeaponID<<" see [RegisterEventOnActors] procedure.."<<std::endl;

}

//////////////////////////////////////////////////////////////////////////

void SimActorControl::SetConfigLauncherActors ( const int mVehicleID, const int mWeaponID, const int mLauncherID ) 
{
	SimDBConnection* cdb= static_cast<SimDBConnection*>(GetGameManager()->GetComponentByName("Database Connection"));
	if( cdb!= NULL) {
		bool isDatabaseConnected = cdb->isDatabaseConnected();

		if ( isDatabaseConnected ) {

			SimActorWeaponDef* weapon = cdb->FindActorWeaponDef(mVehicleID,mWeaponID,mLauncherID) ;

			if ( weapon == NULL){
				std::cout << "weapon null" << std::endl;
				weapon = cdb->GetNewDatabaseActorWeaponDef(mVehicleID,mWeaponID,mLauncherID);				
			}
			if ( weapon != NULL){
				//std::cout << "weapon not null" << std::endl;
				cfgLauncher.mDatabaseID		=	weapon->DatabaseID		;
				cfgLauncher.mVehicleID		=	weapon->Weapon_ShipID	;
				cfgLauncher.mWeaponID		=	weapon->Weapon_ID		; 
				cfgLauncher.mLauncherID		=	weapon->Weapon_Launcher	;
				cfgLauncher.mModelID1		=	weapon->Weapon_ModelID1	;
				cfgLauncher.mModelID2		=	weapon->Weapon_ModelID2	;
				cfgLauncher.mDOFID1			=	weapon->Weapon_DOFID1	;
				cfgLauncher.mDOFID2			=	weapon->Weapon_DOFID2	;
				cfgLauncher.mSwitchID		=	weapon->Weapon_SwitchID	;
				cfgLauncher.mPOS_Heading	=   weapon->POS_Heading		;
				cfgLauncher.mPOS_Pitch  	=   weapon->POS_Pitch		;
				cfgLauncher.mName			=	weapon->Weapon_Name		;
				cfgLauncher.mModelName1		=	weapon->MeshName1		;
				cfgLauncher.mModelName2		=	weapon->MeshName2		;
				cfgLauncher.mDOFName1		=	weapon->DOFName1		;
				cfgLauncher.mDOFName2		=	weapon->DOFName2		;
				cfgLauncher.mSwitchName		=	weapon->SwitchName		;

				cfgLauncher.mStartAngle		=   weapon->StartAngle		;
				cfgLauncher.mEndAngle		=	weapon->EndAngle		;
				cfgLauncher.mStartPitch		=	weapon->StartPitch		;
				cfgLauncher.mEndPitch		=	weapon->EndPitch		;

				/*std::cout << "cfgLauncher.mDatabaseID : " << cfgLauncher.mDatabaseID<< std::endl;
				std::cout << "cfgLauncher.mVehicleID : " << cfgLauncher.mVehicleID<< std::endl;
				std::cout << "cfgLauncher.mWeaponID : " << cfgLauncher.mWeaponID<< std::endl;
				std::cout << "cfgLauncher.mLauncherID : " << cfgLauncher.mLauncherID<< std::endl;
				std::cout << "cfgLauncher.mModelID1 : " << cfgLauncher.mModelID1<< std::endl;
				std::cout << "cfgLauncher.mModelID2 : " << cfgLauncher.mModelID2<< std::endl;
				std::cout << "cfgLauncher.mDOFID1 : " << cfgLauncher.mDOFID1<< std::endl;
				std::cout << "cfgLauncher.mDOFID2 : " << cfgLauncher.mDOFID2<< std::endl;
				std::cout << "cfgLauncher.mSwitchID : " << cfgLauncher.mSwitchID<< std::endl;
				std::cout << "cfgLauncher.mPOS_Heading : " << cfgLauncher.mPOS_Heading<< std::endl;
				std::cout << "cfgLauncher.mPOS_Pitch : " <<cfgLauncher.mPOS_Pitch << std::endl;
				std::cout << "cfgLauncher.mName : " <<cfgLauncher.mName << std::endl;
				std::cout << "cfgLauncher.mModelName1 : " <<cfgLauncher.mModelName1 << std::endl;
				std::cout << "cfgLauncher.mModelName2 : " << cfgLauncher.mModelName2<< std::endl;
				std::cout << "cfgLauncher.mDOFName1 : " << cfgLauncher.mDOFName1<< std::endl;
				std::cout << "cfgLauncher.mDOFName2 : " << cfgLauncher.mDOFName2<< std::endl;
				std::cout << "cfgLauncher.mSwitchName : " << cfgLauncher.mSwitchName<< std::endl;
				std::cout << "cfgLauncher.mStartAngle : " << cfgLauncher.mStartAngle	<< std::endl;
				std::cout << "cfgLauncher.mEndAngle : " << cfgLauncher.mEndAngle<< std::endl;
				std::cout << "cfgLauncher.mStartPitch : " << cfgLauncher.mStartPitch<< std::endl;
				std::cout << "cfgLauncher.mEndPitch : " << cfgLauncher.mEndPitch<< std::endl;*/

			} else /// set SimActorWeaponDef manually
			{
				/// out off from scenario berarti.
				std::cout<<"Set Config Launcher failed ::  "<<mVehicleID<<"-"<<mWeaponID<<"-"<<mLauncherID<<" tidak di temukan di database"<<std::endl;
			}

		} /// end if ( isDatabaseConnected )

	} else
	{
		std::cout << "database not connected" << std::endl;
	}

}

void SimActorControl::CreateLaunchersSpoutActors() 
{
	/// spout 
	dtCore::RefPtr<dtDAL::ActorProxy> parentProxy = GetLauncherActors(C_WEAPON_TYPE_BODY, cfgLauncher.mVehicleID, cfgLauncher.mWeaponID ,cfgLauncher.mLauncherID);
	if ( parentProxy.valid() )
	{ 
		osg::Node *model = parentProxy->GetActor()->GetOSGNode();

		dtCore::RefPtr<dtUtil::NodeCollector> mtColector = new dtUtil::NodeCollector(model, dtUtil::NodeCollector::DOFTransformFlag);
		dtCore::RefPtr<osgSim::DOFTransform> mDOF;

		model = NULL;
		free(model);

		mDOF = mtColector->GetDOFTransform(cfgLauncher.mDOFName2);

		if (mDOF != NULL)
		{
			const std::string& actTypeName = GetActorWeaponTypeName(cfgLauncher.mWeaponID,C_WEAPON_TYPE_SPOUT);

			//dtCore::RefPtr<dtDAL::ActorProxy> ap = dtDAL::LibraryManager::GetInstance().CreateActorProxy(C_ACTOR_CAT, actTypeName);
			dtCore::RefPtr<dtDAL::ActorProxy> ap = GetGameManager()->CreateActor(C_ACTOR_CAT, actTypeName);
			dtCore::RefPtr<dtGame::GameActorProxy> gap= static_cast<dtGame::GameActorProxy *>(ap.get());
			dtCore::RefPtr<dtGame::GameActor> ga= static_cast<dtGame::GameActor*>(gap->GetActor());

			std::ostringstream sID, sWeaponID, sLauncherID, sWeaponTypeID, sPOS_H, sPOS_P ;
			std::ostringstream sStartAngle, sEndAngle;
			std::ostringstream sStartPitch, sEndPitch;

			sID << cfgLauncher.mVehicleID ;
			sWeaponID << cfgLauncher.mWeaponID;
			sLauncherID << cfgLauncher.mLauncherID ;
			sWeaponTypeID << C_WEAPON_TYPE_SPOUT ;

			sPOS_H << cfgLauncher.mPOS_Heading ;
			sPOS_P << cfgLauncher.mPOS_Pitch ;

			sStartAngle << cfgLauncher.mStartAngle;
			sEndAngle	<< cfgLauncher.mEndAngle;
			sStartPitch	<< cfgLauncher.mStartPitch; 
			sEndPitch	<< cfgLauncher.mEndPitch;

			gap->GetProperty(C_SET_VID)->FromString(sID.str());
			gap->GetProperty(C_SET_WID)->FromString(sWeaponID.str());
			gap->GetProperty(C_SET_LID)->FromString(sLauncherID.str());
			gap->GetProperty(C_SET_TID)->FromString(sWeaponTypeID.str());
			gap->GetProperty(C_SET_MODEL)->FromString(cfgLauncher.mModelName2);
			gap->GetProperty(C_SET_ATTACH_DOF_NAME)->FromString(cfgLauncher.mDOFName2); /// Untuk spout pake dof name kedua
			gap->GetProperty(C_SET_INIT_HEADING)->FromString(sPOS_H.str());
			gap->GetProperty(C_SET_INIT_PITCH)->FromString(sPOS_P.str());

			gap->GetProperty(C_SET_INIT_STARTPITCH)->FromString(sStartPitch.str());
			gap->GetProperty(C_SET_INIT_ENDPITCH)->FromString(sEndPitch.str());
			gap->GetProperty(C_SET_INIT_STARTANGLE)->FromString(sStartAngle.str());
			gap->GetProperty(C_SET_INIT_ENDANGLE)->FromString(sEndAngle.str());

			//std::cout << "error sebelum addactor CreateLaunchersSpoutActors" <<std::endl;

			if (GetGameManager()!=NULL)
			{
				GetGameManager()->AddActor(*gap, false, false);

				RegisterEventOnActors(*gap, cfgLauncher.mWeaponID );

				dtCore::RefPtr<dtGame::ActorUpdateMessage> mes = 
					static_cast<dtGame::ActorUpdateMessage*>(GetGameManager()->GetMessageFactory().CreateMessage(dtGame::MessageType::INFO_ACTOR_CREATED).get());

				gap->PopulateActorUpdate(*mes);

				GetGameManager()->SendNetworkMessage(*mes);
				GetGameManager()->SendMessage(*mes);

				std::cout<<"   ::"<<GetName()<<"::"<<ga->GetName()<<" Added to Scene..."<<std::endl;
			}
			ga->SetName(cfgLauncher.mName+"-SPOUT");
			ga = NULL;
			free(ga);
		}
		else
			std::cout<<"   ::"<<GetName()<<" can't find DOF '"<<cfgLauncher.mDOFName2<<"' for "<<parentProxy->GetActor()->GetName()<<std::endl;

	}	 

}

void SimActorControl::CreateLaunchersBodyActors()
{
	dtCore::RefPtr<dtDAL::ActorProxy> parentProxy = GetShipActorByID(cfgLauncher.mVehicleID);
	if ( parentProxy.valid() )
	{
		dtCore::RefPtr<ShipActor> parent = static_cast<ShipActor*>(parentProxy->GetActor());
		osg::Node *model = parent->GetOSGNode();

		dtCore::RefPtr<dtUtil::NodeCollector> mtColector = new dtUtil::NodeCollector(model, dtUtil::NodeCollector::DOFTransformFlag);
		dtCore::RefPtr<osgSim::DOFTransform> mDOF;

		model = NULL;
		free(model);

		mDOF = mtColector->GetDOFTransform(cfgLauncher.mDOFName1);
		if (mDOF != NULL)
		{
			const std::string& actTypeName = GetActorWeaponTypeName(cfgLauncher.mWeaponID,C_WEAPON_TYPE_BODY);

			//dtCore::RefPtr<dtDAL::ActorProxy> ap = dtDAL::LibraryManager::GetInstance().CreateActorProxy(C_ACTOR_CAT, actTypeName);
			dtCore::RefPtr<dtDAL::ActorProxy> ap = GetGameManager()->CreateActor(C_ACTOR_CAT, actTypeName);
			dtCore::RefPtr<dtGame::GameActorProxy> gap= static_cast<dtGame::GameActorProxy *>(ap.get());
			dtCore::RefPtr<dtGame::GameActor> ga= static_cast<dtGame::GameActor*>(gap->GetActor());

			std::ostringstream sShipID, sWeaponID, sLauncherID, sWeaponTypeID, sPOS_H, sPOS_P ;
			std::ostringstream sStartAngle, sEndAngle;
			std::ostringstream sStartPitch, sEndPitch;

			sShipID << cfgLauncher.mVehicleID ;
			sWeaponID << cfgLauncher.mWeaponID ;
			sLauncherID << cfgLauncher.mLauncherID ; 
			sWeaponTypeID << C_WEAPON_TYPE_BODY;
			sPOS_H << cfgLauncher.mPOS_Heading ;
			sPOS_P << cfgLauncher.mPOS_Pitch ;

			sStartAngle << cfgLauncher.mStartAngle;
			sEndAngle	<< cfgLauncher.mEndAngle;
			sStartPitch	<< cfgLauncher.mStartPitch; 
			sEndPitch	<< cfgLauncher.mEndPitch;

			gap->GetProperty(C_SET_VID)->FromString(sShipID.str());
			gap->GetProperty(C_SET_WID)->FromString(sWeaponID.str());
			gap->GetProperty(C_SET_LID)->FromString(sLauncherID.str());
			gap->GetProperty(C_SET_TID)->FromString(sWeaponTypeID.str());
			gap->GetProperty(C_SET_MODEL)->FromString(cfgLauncher.mModelName1);
			gap->GetProperty(C_SET_ATTACH_DOF_NAME)->FromString(cfgLauncher.mDOFName1);
			gap->GetProperty(C_SET_INIT_HEADING)->FromString(sPOS_H.str());
			gap->GetProperty(C_SET_INIT_PITCH)->FromString(sPOS_P.str());
			gap->GetProperty(C_SET_INIT_SWITCHNAME)->FromString(cfgLauncher.mSwitchName);

			gap->GetProperty(C_SET_INIT_STARTANGLE)->FromString(sStartAngle.str());
			gap->GetProperty(C_SET_INIT_ENDANGLE)->FromString(sEndAngle.str());
			gap->GetProperty(C_SET_INIT_STARTPITCH)->FromString(sStartPitch.str());
			gap->GetProperty(C_SET_INIT_ENDPITCH)->FromString(sEndPitch.str());

			if (GetGameManager()!=NULL)
			{
				//std::cout << "error sebelum addactor CreateLaunchersBodyActors" <<std::endl;
				if (gap.valid()){
					GetGameManager()->AddActor(*gap, false, false);
					//CPPUNIT_ASSERT(gap.valid());
				}
				else
					std::cout << "not valid gap" <<std::endl;
				//std::cout << "error sesudah addactor CreateLaunchersBodyActors" <<std::endl;

				RegisterEventOnActors(*gap, cfgLauncher.mWeaponID );

				dtCore::RefPtr<dtGame::ActorUpdateMessage> mes = 
					static_cast<dtGame::ActorUpdateMessage*>(GetGameManager()->GetMessageFactory().CreateMessage(dtGame::MessageType::INFO_ACTOR_CREATED).get());

				gap->PopulateActorUpdate(*mes);

				GetGameManager()->SendNetworkMessage(*mes);
				GetGameManager()->SendMessage(*mes);


				std::cout<<"   ::"<<GetName()<<"::"<<ga->GetName()<<" Added to Scene..."<<std::endl;
			}

			gap = NULL;
			free(gap);
			ga->SetName(cfgLauncher.mName+"-BASE");
			//std::cout<<"mname : "<<cfgLauncher.mName<<std::endl;
			ga = NULL;
			free(ga);
		}
		else
			std::cout<<"   ::"<<GetName()<<" can't find DOF '"<<cfgLauncher.mDOFName1<<"' for "<<parentProxy->GetActor()->GetName()<<std::endl;
	}	 
}

void SimActorControl::CreateLaunchersActors( const int mVehicleID, const int mWeaponID, const int mLauncherID )
{
	SetConfigLauncherActors( mVehicleID,mWeaponID,mLauncherID ) ;
	CreateLaunchersBodyActors();
	CreateLaunchersSpoutActors(); 
}

void SimActorControl::SetConfigMissileActors ( const int mVehicleID, const int mWeaponID, const int mLauncherID, const int mMissileID, const int mMissileNum )  
{
	SimDBConnection* cdb= static_cast<SimDBConnection*>(GetGameManager()->GetComponentByName("Database Connection"));
	if( cdb!= NULL) {
		bool isDatabaseConnected = cdb->isDatabaseConnected();

		if ( isDatabaseConnected ) {

			SimActorMissileDef* missile = cdb->FindActorMissileDef(mVehicleID,mWeaponID,mLauncherID,mMissileID,mMissileNum) ;
			if ( missile == NULL){
				missile = cdb->GetNewDatabaseActorMissileDef(mVehicleID,mWeaponID,mLauncherID,mMissileID,mMissileNum) ;
				//std::cout << "missile null" << std::endl;
			}

			if ( missile != NULL){
				//std::cout << "missile not null" << std::endl;

				cfgMissile.VehicleID		=	missile->VehicleID		;
				cfgMissile.WeaponID 		=	missile->WeaponID		;
				cfgMissile.LauncherID		=	missile->LauncherID		;
				cfgMissile.MissileID		=	missile->MissileID		;
				cfgMissile.MissileNum		=	missile->MissileNum		;

				cfgMissile.mPOS_Heading		=	missile->POS_Heading    ;
				cfgMissile.mPOS_Pitch  		=	missile->POS_Pitch 		;
 
				cfgMissile.MissileName 		=	missile->MissileName    ;
				cfgMissile.MeshName 		=	missile->MeshName       ;
				cfgMissile.DOFName 			=	missile->DOFName        ;

				cfgMissile.IsHasLauncher  	=	missile->IsHasLauncher  ;
				//cfgMissile.Lethality		=	missile->Lethality		;
				cfgMissile.Lethality		=	cdb->GetWeaponLethalityFromIDWeapon(mWeaponID);

				std::cout << "cfgMissile.Lethality : " <<cfgMissile.Lethality << std::endl; 

			} else /// set SimActorMissileDef manually
			{
				/// out off from scenario berarti.
				std::cout<<"Set Config Missile failed :: Data "<<mVehicleID<<"-"<<mWeaponID<<"-"<<mLauncherID<<"-"<<mMissileID<<"-"<<mMissileNum<<" tidak di temukan di database"<<std::endl;
				
			}
		} /// end if ( isDatabaseConnected )

	} else
	{
		/// may be useless ( set manually with constant )
		//std::cout << "may be useless" << std::endl;

		cfgMissile.VehicleID		=	mVehicleID		;
		cfgMissile.WeaponID 		=	mWeaponID		;
		cfgMissile.LauncherID		=	mLauncherID		;
		cfgMissile.MissileID		=	mMissileID		;
		cfgMissile.MissileNum		=	mMissileNum		;

		cfgMissile.mPOS_Heading		=	0  				;
		cfgMissile.mPOS_Pitch  		=	0  				;
		cfgMissile.Lethality  		=	0  				;

		cfgMissile.MissileName 		=	""				;
		cfgMissile.MeshName 		=	""				;
		cfgMissile.DOFName 			=	""				;

		cfgMissile.IsHasLauncher  	=	false			;
	}

}

void SimActorControl::CreateMissileActorsForStandAlone( const int mVehicleID, const int mWeaponID, const int mLauncherID , const int mMissileID, const int mMissileNum)
{

	std::cout << "Create Missile For Stand Alone" << std::endl;

	cfgMissile.VehicleID		= mVehicleID	;
	cfgMissile.WeaponID 		= mWeaponID		;
	cfgMissile.LauncherID		= mLauncherID	;
	cfgMissile.MissileID		= mMissileID	;
	cfgMissile.MissileNum		= mMissileNum	;
	cfgMissile.mPOS_Heading		= 0	;
	cfgMissile.mPOS_Pitch  		= 0	;
	cfgMissile.IsHasLauncher  	= 1 ;

	//StandAlone Version (TDS(CANNON 40, 57, 76, 120), STRELLA, MISSTRAL)
	//For Just Assign in Launcher 1
	if ( mWeaponID == CT_CANNON_40)
	{
		cfgMissile.MissileName 		= "CANNON-40";
		cfgMissile.MeshName 		= C_FOLDER_WEAPON + "40mm.ive";
		cfgMissile.DOFName 			= "DOF_Meriam40Missile";
	}
	else 
	if ( mWeaponID == CT_CANNON_57 )
	{
		cfgMissile.MissileName 		= "CANNON-57";
		cfgMissile.MeshName 		= C_FOLDER_WEAPON + "57mm.ive";
		cfgMissile.DOFName 			= "DOF_Meriam57Missile";
	}
	if ( mWeaponID == CT_CANNON_76 )
	{
		cfgMissile.MissileName 		= "CANNON-76";
		cfgMissile.MeshName 		= C_FOLDER_WEAPON + "76mm.ive";
		cfgMissile.DOFName 			= "DOF_Meriam76Missile";
	}
	else
	if ( mWeaponID == CT_CANNON_120 )
	{
		cfgMissile.MissileName 		= "CANNON-120";
		cfgMissile.MeshName 		= C_FOLDER_WEAPON + "120mm.ive";
		cfgMissile.DOFName 			= "DOF_Meriam120Missile";
	}
	else
	if ( mWeaponID == CT_MISTRAL)
	{
		cfgMissile.MissileName 		= "MISTRAL";
		cfgMissile.MeshName 		= C_FOLDER_WEAPON + "mistral.ive";
		cfgMissile.DOFName 			= "DOF_MistralMissile1";
	}
	else
	if ( mWeaponID == CT_STRELA)
	{
		cfgMissile.MissileName 		= "STRELLA";
		cfgMissile.MeshName 		= C_FOLDER_WEAPON + "Strela.ive";
		cfgMissile.DOFName 			= "DOF_StrelaMissile1";
	}
	
	dtCore::RefPtr<dtDAL::ActorProxy> parentProxy = NULL ;
	parentProxy = GetLauncherActors(C_WEAPON_TYPE_SPOUT,mVehicleID,mWeaponID,mLauncherID);
	
	if( parentProxy.valid())
	{
		osg::Node *model = parentProxy->GetActor()->GetOSGNode();

		dtCore::RefPtr<dtUtil::NodeCollector> mtColector = new dtUtil::NodeCollector(model, dtUtil::NodeCollector::DOFTransformFlag);
		dtCore::RefPtr<osgSim::DOFTransform> mDOFTran;

		model = NULL;
		free(model);

		mDOFTran = mtColector->GetDOFTransform(cfgMissile.DOFName); 

		if (mDOFTran != NULL)
		{
			const std::string& actTypeName = GetActorWeaponTypeName(mWeaponID,C_WEAPON_TYPE_MISSILE);

			std::cout << actTypeName << std::endl;

			dtCore::RefPtr<dtDAL::ActorProxy> ap = dtDAL::LibraryManager::GetInstance().CreateActorProxy(C_ACTOR_CAT, actTypeName);
			dtCore::RefPtr<dtGame::GameActorProxy> gap= static_cast<dtGame::GameActorProxy *>(ap.get());
			dtCore::RefPtr<dtGame::GameActor> ga= static_cast<dtGame::GameActor*>(gap->GetActor());

			std::ostringstream sShipID, sWeaponID, sLauncherID, sMissileID, sMissileNum, sWeaponTypeID, sPOS_H, sPOS_P, sHasLauncher ;
			sShipID << cfgMissile.VehicleID ;
			sWeaponID << cfgMissile.WeaponID ;
			sLauncherID << cfgMissile.LauncherID ;
			sMissileID << cfgMissile.MissileID ;
			sMissileNum << cfgMissile.MissileNum ;
			sWeaponTypeID << C_WEAPON_TYPE_MISSILE;
			sPOS_H << cfgMissile.mPOS_Heading ;
			sPOS_P << cfgMissile.mPOS_Pitch ;
			sHasLauncher << cfgMissile.IsHasLauncher ;

			gap->GetProperty(C_SET_VID)->FromString(sShipID.str());
			gap->GetProperty(C_SET_WID)->FromString(sWeaponID.str());
			gap->GetProperty(C_SET_LID)->FromString(sLauncherID.str());
			gap->GetProperty(C_SET_MID)->FromString(sMissileID.str());
			gap->GetProperty(C_SET_MNUM)->FromString(sMissileNum.str());
			gap->GetProperty(C_SET_TID)->FromString(sWeaponTypeID.str());
			gap->GetProperty(C_SET_MODEL)->FromString(cfgMissile.MeshName);
			gap->GetProperty(C_SET_ATTACH_DOF_NAME)->FromString(cfgMissile.DOFName);
			gap->GetProperty(C_SET_INIT_HEADING)->FromString(sPOS_H.str());
			gap->GetProperty(C_SET_INIT_PITCH)->FromString(sPOS_P.str());
			gap->GetProperty(C_SET_HAS_LAUNCHER)->FromString(sHasLauncher.str());

			ga->SetName(cfgMissile.MissileName);

			GetGameManager()->AddActor(*gap, false, false);

			GetGameManager()->RegisterForMessages(dtGame::MessageType::TICK_LOCAL,*gap,dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
			RegisterEventOnActors(*gap, cfgMissile.WeaponID );

			dtCore::RefPtr<dtGame::ActorUpdateMessage> mes = 
				static_cast<dtGame::ActorUpdateMessage*>(GetGameManager()->GetMessageFactory().CreateMessage(dtGame::MessageType::INFO_ACTOR_CREATED).get());

			gap->PopulateActorUpdate(*mes);

			GetGameManager()->SendNetworkMessage(*mes);
			GetGameManager()->SendMessage(*mes);

		} else
			std::cout<<"   ::"<<GetName()<<" can't find DOF '"<<cfgMissile.DOFName<<"' for "<<parentProxy->GetActor()->GetName()<<std::endl;

	}
	else
		std::cout << "Parent Proxy Not Valid" << std::endl;

}

void SimActorControl::CreateMissileActors( const int mVehicleID, const int mWeaponID, const int mLauncherID , const int mMissileID, const int mMissileNum)
{
	/*SetConfigMissileActors(mVehicleID, mWeaponID, mLauncherID, mMissileID, mMissileNum  );
	const std::string& actTypeName = GetActorWeaponTypeName(mWeaponID,C_WEAPON_TYPE_MISSILE);
	dtCore::RefPtr<const dtDAL::ActorType> type = GetGameManager()->FindActorType(C_ACTOR_CAT, actTypeName);
	CPPUNIT_ASSERT(type != NULL);
	dtCore::RefPtr<dtGame::GameActorProxy> proxy;
	GetGameManager()->CreateActor(*type, proxy);
	CPPUNIT_ASSERT_MESSAGE("Proxy should not be in the gm yet", proxy->IsInGM() != true);
	CPPUNIT_ASSERT_MESSAGE("Proxy should have a valid GM on it", proxy->GetGameManager() != NULL);
	CPPUNIT_ASSERT_MESSAGE("Proxy, the result of a dynamic_cast to dtGame::GameActorProxy, should not be NULL",proxy != NULL);
	CPPUNIT_ASSERT_MESSAGE("IsGameActorProxy should return true", proxy->IsGameActorProxy());
	CPPUNIT_ASSERT_MESSAGE("The proxy should have the GameManager pointer set to valid",proxy->GetGameManager() != NULL);

	CPPUNIT_ASSERT_THROW_MESSAGE("Adding an actor as both remote and published should throw and exception.",
		GetGameManager()->AddActor(*proxy,false,false), dtUtil::Exception);

	GetGameManager()->AddActor(*proxy, false, false);*/


	SetConfigMissileActors(mVehicleID, mWeaponID, mLauncherID, mMissileID, mMissileNum  );

	dtCore::RefPtr<dtDAL::ActorProxy> parentProxy = NULL ;
	if ( cfgMissile.IsHasLauncher )
		parentProxy = GetLauncherActors(C_WEAPON_TYPE_SPOUT,mVehicleID,mWeaponID,mLauncherID);
	else
		parentProxy = GetShipActorByID(mVehicleID);

	if( parentProxy.valid())
	{
		osg::Node *model = parentProxy->GetActor()->GetOSGNode();

		dtCore::RefPtr<dtUtil::NodeCollector> mtColector = new dtUtil::NodeCollector(model, dtUtil::NodeCollector::DOFTransformFlag);
		dtCore::RefPtr<osgSim::DOFTransform> mDOFTran;

		model = NULL;
		free(model);

		mDOFTran = mtColector->GetDOFTransform(cfgMissile.DOFName); 

		if (mDOFTran != NULL)
		{
			Confirm_MissileActorLoaded(mVehicleID,mWeaponID,mLauncherID,mMissileID,mMissileNum);

			const std::string& actTypeName = GetActorWeaponTypeName(mWeaponID,C_WEAPON_TYPE_MISSILE);

			std::cout << actTypeName << std::endl;

			dtCore::RefPtr<dtDAL::ActorProxy> ap = dtDAL::LibraryManager::GetInstance().CreateActorProxy(C_ACTOR_CAT, actTypeName);
			dtCore::RefPtr<dtGame::GameActorProxy> gap= static_cast<dtGame::GameActorProxy *>(ap.get());
			dtCore::RefPtr<dtGame::GameActor> ga= static_cast<dtGame::GameActor*>(gap->GetActor());

			std::ostringstream sShipID, sWeaponID, sLauncherID, sMissileID, sMissileNum, sWeaponTypeID, sPOS_H, sPOS_P, sHasLauncher, sLethality ;
			sShipID << cfgMissile.VehicleID ;
			sWeaponID << cfgMissile.WeaponID ;
			sLauncherID << cfgMissile.LauncherID ;
			sMissileID << cfgMissile.MissileID ;
			sMissileNum << cfgMissile.MissileNum ;
			sWeaponTypeID << C_WEAPON_TYPE_MISSILE;
			sPOS_H << cfgMissile.mPOS_Heading ;
			sPOS_P << cfgMissile.mPOS_Pitch ;
			sHasLauncher << cfgMissile.IsHasLauncher ;
			sLethality << cfgMissile.Lethality;

			std::cout << "cfgMissile.Lethality : " << cfgMissile.Lethality << std::endl;

			gap->GetProperty(C_SET_VID)->FromString(sShipID.str());
			gap->GetProperty(C_SET_WID)->FromString(sWeaponID.str());
			gap->GetProperty(C_SET_LID)->FromString(sLauncherID.str());
			gap->GetProperty(C_SET_MID)->FromString(sMissileID.str());
			gap->GetProperty(C_SET_MNUM)->FromString(sMissileNum.str());
			gap->GetProperty(C_SET_TID)->FromString(sWeaponTypeID.str());
			gap->GetProperty(C_SET_MODEL)->FromString(cfgMissile.MeshName);
			gap->GetProperty(C_SET_ATTACH_DOF_NAME)->FromString(cfgMissile.DOFName);
			gap->GetProperty(C_SET_INIT_HEADING)->FromString(sPOS_H.str());
			gap->GetProperty(C_SET_INIT_PITCH)->FromString(sPOS_P.str());
			gap->GetProperty(C_SET_HAS_LAUNCHER)->FromString(sHasLauncher.str());
			gap->GetProperty(C_SET_LETHALITY)->FromString(sLethality.str());

			//ga->SetName(cfgMissile.MissileName+"-MISSILE");
			ga->SetName(cfgMissile.MissileName);

			//Sleep(10);
			//CPPUNIT_ASSERT_THROW_MESSAGE("Adding an actor as both remote and published should throw and exception.",
				//GetGameManager()->AddActor(*gap,false,true), dtUtil::Exception);
			GetGameManager()->AddActor(*gap, false, false);

			/*try
			{
				_set_se_translator( trans_func );
				GetGameManager()->AddActor(*gap, false, false);
			}
			catch (const dtUtil::Exception& ex)
			{
				std::cout << "catch error" <<std::endl;
				CPPUNIT_FAIL(std::string("Unknown Exception thrown adding an actor: ") + ex.What());
			}*/

			GetGameManager()->RegisterForMessages(dtGame::MessageType::TICK_LOCAL,*gap,dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
			RegisterEventOnActors(*gap, cfgMissile.WeaponID );

			dtCore::RefPtr<dtGame::ActorUpdateMessage> mes = 
				static_cast<dtGame::ActorUpdateMessage*>(GetGameManager()->GetMessageFactory().CreateMessage(dtGame::MessageType::INFO_ACTOR_CREATED).get());

			gap->PopulateActorUpdate(*mes);

			GetGameManager()->SendNetworkMessage(*mes);
			GetGameManager()->SendMessage(*mes);

			//std::cout<<"   ::"<<GetName()<<"::"<<ga->GetName()<<" Added to Scene..."<<std::endl;

			gap = NULL;
			free(gap);
			ga = NULL;
			free(ga);

		} else
			std::cout<<"   ::"<<GetName()<<" can't find DOF '"<<cfgMissile.DOFName<<"' for "<<parentProxy->GetActor()->GetName()<<std::endl;
	}
	else
		std::cout << "Parent Proxy Not Valid" << std::endl;
}

/*void SimActorControl::trans_func( unsigned int u, EXCEPTION_POINTERS* pExp )
{
	printf( "In trans_func.\n" );
	throw SE_Exception();
}*/
 
//////////////////////////////////////////////////////////////////////////

void SimActorControl::CreateDefaultShipActor( const int mVehicleID, const double x, const double y, const double z,const double h )
{
	
	std::ostringstream sID,sMaxSpeed,sDamage ;
	sID << mVehicleID ;

	dtCore::RefPtr<dtDAL::ActorProxy> ap= GetGameManager()->CreateActor(C_ACTOR_CAT, C_CN_SHIP);
	dtCore::RefPtr<dtGame::GameActorProxy> gap= static_cast<dtGame::GameActorProxy *>(ap.get());
	dtCore::RefPtr<dtGame::GameActor> ga= static_cast<dtGame::GameActor*>(gap->GetActor());

	std::string shipName;
	SimDBConnection *cdb= static_cast<SimDBConnection*>(GetGameManager()->GetComponentByName("Database Connection"));
	
	std::string fileModel;
	std::string IveModel;
	double max_speed (0.0f);
	int damage (0);
	if( cdb!= NULL) 
	{
		shipName = cdb->GetShipNameByID(mVehicleID);
		max_speed = cdb->GetShipMaxSpeedByID(mVehicleID);
		damage = cdb->GetShipDamageByID(mVehicleID);
		
		sMaxSpeed << max_speed;
		sDamage << damage;
		
		int IDShipModel;
		if ( shipName != "" )
		{
			IDShipModel = cdb->GetModelIDFromShipID(mVehicleID);
			IveModel = cdb->GetModelNameFromIDModel(IDShipModel);
			fileModel = C_FOLDER_SHIP + IveModel;

			//std::cout << "ID SHIP MODEL : " << IDShipModel << std::endl;
			//std::cout << "IVE MODEL : " << IveModel << std::endl;
		}
		else
		{
			shipName  = "SHIP-"+sID.str();
			IDShipModel = cdb->GetModelIDFromShipID(mVehicleID);
			IveModel = cdb->GetModelNameFromIDModel(IDShipModel);
			fileModel = C_FOLDER_SHIP + IveModel; //+".ive";
		}
	}
	else
	{
		fileModel = C_FOLDER_SHIP + "1" + ".ive";
	}
    
	gap->GetProperty(C_SET_VID)->FromString(sID.str());
	gap->GetProperty(C_SET_MODEL)->FromString(fileModel);
	gap->GetProperty("MaxAheadSpeed")->FromString(sMaxSpeed.str());
	gap->GetProperty(C_SET_DAMAGE)->FromString(sDamage.str());
	ga->SetName(shipName);

	GetGameManager()->AddActor(*gap,false,true);
	
	osg::Vec3 pos, rot ;

	pos.x() = x;
	pos.y() = y;
	pos.z() = z;

	rot.x() = h;

	dtCore::Transform tx;

	tx.SetTranslation(pos);
	tx.SetRotation(rot);

	ga->SetTransform(tx,dtCore::Transformable::REL_CS);
	GetGameManager()->RegisterForMessages(SimMessageType::ORDER_EVENT,*gap,dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
	
	GetGameManager()->GetScene().AddDrawable(ga.get());

	std::vector<dtDAL::ActorProxy *> ocp;
	GetGameManager()->FindActorsByName(C_CN_OCEAN, ocp);
	if (ocp[0]!= NULL) //Environment hanya ada satu, belum support multiple environment
	{
		if ( gap->GetGameActor().GetParent() != NULL ) 
		gap->GetGameActor().GetParent()->RemoveChild(&(gap->GetGameActor()));
		static_cast<dtGame::IEnvGameActor*>(ocp[0]->GetActor())->AddActor( *(ga) );
	}
	else
		std::cout<<"Environment actor is missing!"<<std::endl;

	std::cout<<ga->GetName()<<" Added to Scene Pos X "<<pos.x()<<" Y : "<<pos.y()<<std::endl;
 
	dtCore::RefPtr<dtGame::ActorUpdateMessage> mes = 
		static_cast<dtGame::ActorUpdateMessage*>(GetGameManager()->GetMessageFactory().CreateMessage(dtGame::MessageType::INFO_ACTOR_CREATED).get());

	gap->PopulateActorUpdate(*mes);

	GetGameManager()->SendNetworkMessage(*mes);
	GetGameManager()->SendMessage(*mes);
}

void SimActorControl::CreateSubMarineActor( const int mVehicleID, const double x, const double y, const double z, const double h )
{
	
	std::ostringstream sID,sMaxSpeed,sDamage ;
	sID << mVehicleID ;

	dtCore::RefPtr<dtDAL::ActorProxy> ap= GetGameManager()->CreateActor(C_ACTOR_CAT, C_CN_SUBMARINE);
	dtCore::RefPtr<dtGame::GameActorProxy> gap= static_cast<dtGame::GameActorProxy *>(ap.get());
	dtCore::RefPtr<dtGame::GameActor> ga= static_cast<dtGame::GameActor*>(gap->GetActor());

    /*std::string fModel;
	fModel = C_FOLDER_SHIP+sID.str()+".ive";*/


	std::string shipName;
	SimDBConnection *cdb= static_cast<SimDBConnection*>(GetGameManager()->GetComponentByName("Database Connection"));

	std::string fileModel;
	std::string IveModel;
	double max_speed (0.0f);
	int damage (0);
	if( cdb!= NULL) 
	{
		shipName = cdb->GetShipNameByID(mVehicleID);
		max_speed = cdb->GetShipMaxSpeedByID(mVehicleID);
		damage = cdb->GetShipDamageByID(mVehicleID);
		sMaxSpeed << max_speed;
		sDamage << damage;

		int IDShipModel;
		if ( shipName != "" )
		{
			IDShipModel = cdb->GetModelIDFromShipID(mVehicleID);
			IveModel = cdb->GetModelNameFromIDModel(IDShipModel);
			fileModel = C_FOLDER_SHIP + IveModel;

			//std::cout << "ID SHIP MODEL : " << IDShipModel << std::endl;
			//std::cout << "IVE MODEL : " << IveModel << std::endl;
		}
		else
		{
			shipName  = "SHIP-"+sID.str();
			IDShipModel = cdb->GetModelIDFromShipID(mVehicleID);
			IveModel = cdb->GetModelNameFromIDModel(IDShipModel);
			fileModel = C_FOLDER_SHIP + IveModel; //+".ive";
		}
	}
	else
	{
		fileModel = C_FOLDER_SHIP + "1" + ".ive";
	}

    gap->GetProperty(C_SET_VID)->FromString(sID.str());
	gap->GetProperty(C_SET_MODEL)->FromString(fileModel);
	gap->GetProperty("MaxAheadSpeed")->FromString(sMaxSpeed.str());
	gap->GetProperty(C_SET_DAMAGE)->FromString(sDamage.str());
	ga->SetName("SubMarine-"+sID.str());

	GetGameManager()->AddActor(*gap,false,true);
	
	osg::Vec3 pos, rot ;

	pos.x() = x;
	pos.y() = y;
	pos.z() = z;

	rot.x() = h;

	dtCore::Transform tx;

	tx.SetTranslation(pos);
	tx.SetRotation(rot);

	ga->SetTransform(tx,dtCore::Transformable::REL_CS);
	GetGameManager()->RegisterForMessages(SimMessageType::ORDER_EVENT,*gap,dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
	
	GetGameManager()->GetScene().AddDrawable(ga.get());

	std::vector<dtDAL::ActorProxy *> ocp;
	GetGameManager()->FindActorsByName(C_CN_OCEAN, ocp);
	if (ocp[0]!= NULL) //Environment hanya ada satu, belum support multiple environment
	{
		if ( gap->GetGameActor().GetParent() != NULL ) 
		gap->GetGameActor().GetParent()->RemoveChild(&(gap->GetGameActor()));
		static_cast<dtGame::IEnvGameActor*>(ocp[0]->GetActor())->AddActor( *(ga) );
	}
	else
		std::cout<<"Environment actor is missing!"<<std::endl;

	std::cout<<ga->GetName()<<" Added to Scene Pos X "<<pos.x()<<" Y : "<<pos.y()<<" Z : "<<pos.z()<<std::endl;
 
	dtCore::RefPtr<dtGame::ActorUpdateMessage> mes = 
		static_cast<dtGame::ActorUpdateMessage*>(GetGameManager()->GetMessageFactory().CreateMessage(dtGame::MessageType::INFO_ACTOR_CREATED).get());

	gap->PopulateActorUpdate(*mes);

	GetGameManager()->SendNetworkMessage(*mes);
	GetGameManager()->SendMessage(*mes);


}

void SimActorControl::CreateHelicopterActor( const int mVehicleID, const double x, const double y, const double z, const double h )
{
	std::ostringstream sID, sMaxSpeed, sDamage ;
	sID << mVehicleID ;

	dtCore::RefPtr<dtDAL::ActorProxy> ap= GetGameManager()->CreateActor(C_ACTOR_CAT, C_CN_HELICOPTER);
	dtCore::RefPtr<dtGame::GameActorProxy> gap= static_cast<dtGame::GameActorProxy *>(ap.get());
	dtCore::RefPtr<dtGame::GameActor> ga= static_cast<dtGame::GameActor*>(gap->GetActor());

	std::string shipName;
	SimDBConnection *cdb= static_cast<SimDBConnection*>(GetGameManager()->GetComponentByName("Database Connection"));

	std::string fileModel;
	std::string IveModel;
	double max_speed (0.0f);
	double damage (0.0f);
	if( cdb!= NULL) 
	{
		shipName = cdb->GetShipNameByID(mVehicleID);
		max_speed = cdb->GetShipMaxSpeedByID(mVehicleID);
		damage = cdb->GetShipDamageByID(mVehicleID);
		sMaxSpeed << max_speed;
		sDamage << damage;

		int IDShipModel;
		if ( shipName != "" )
		{
			IDShipModel = cdb->GetModelIDFromShipID(mVehicleID);
			IveModel = cdb->GetModelNameFromIDModel(IDShipModel);
			fileModel = C_FOLDER_SHIP + IveModel;

			//std::cout << "ID SHIP MODEL : " << IDShipModel << std::endl;
			//std::cout << "IVE MODEL : " << IveModel << std::endl;
		}
		else
		{
			shipName  = "SHIP-"+sID.str();
			IDShipModel = cdb->GetModelIDFromShipID(mVehicleID);
			IveModel = cdb->GetModelNameFromIDModel(IDShipModel);
			fileModel = C_FOLDER_SHIP + IveModel; //+".ive";
		}
	}
	else
	{
		fileModel = C_FOLDER_SHIP + "1" + ".ive";
	}

	gap->GetProperty(C_SET_VID)->FromString(sID.str());
	gap->GetProperty(C_SET_MODEL)->FromString(fileModel);
	gap->GetProperty("MaxAheadSpeed")->FromString(sMaxSpeed.str());
	gap->GetProperty(C_SET_DAMAGE)->FromString(sDamage.str());
	ga->SetName("Helicopter-"+sID.str());

	GetGameManager()->AddActor(*gap,false,true);

	osg::Vec3 pos, rot ;

	pos.x() = x;
	pos.y() = y;
	pos.z() = z;

	rot.x() = h;

	dtCore::Transform tx;

	tx.SetTranslation(pos);
	tx.SetRotation(rot);

	ga->SetTransform(tx,dtCore::Transformable::REL_CS);
	GetGameManager()->RegisterForMessages(SimMessageType::ORDER_EVENT,*gap,dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);

	GetGameManager()->GetScene().AddDrawable(ga.get());

	std::vector<dtDAL::ActorProxy *> ocp;
	GetGameManager()->FindActorsByName(C_CN_OCEAN, ocp);
	if (ocp[0]!= NULL) //Environment hanya ada satu, belum support multiple environment
	{
		if ( gap->GetGameActor().GetParent() != NULL ) 
			gap->GetGameActor().GetParent()->RemoveChild(&(gap->GetGameActor()));
		static_cast<dtGame::IEnvGameActor*>(ocp[0]->GetActor())->AddActor( *(ga) );
	}
	else
		std::cout<<"Environment actor is missing!"<<std::endl;

	std::cout<<ga->GetName()<<" Added to Scene Pos X "<<pos.x()<<" Y : "<<pos.y()<<" Z : "<<pos.z()<<std::endl;

	dtCore::RefPtr<dtGame::ActorUpdateMessage> mes = 
		static_cast<dtGame::ActorUpdateMessage*>(GetGameManager()->GetMessageFactory().CreateMessage(dtGame::MessageType::INFO_ACTOR_CREATED).get());

	gap->PopulateActorUpdate(*mes);

	GetGameManager()->SendNetworkMessage(*mes);
	GetGameManager()->SendMessage(*mes);

}

void SimActorControl::CreateAircraftActor( const int mVehicleID, const double x, const double y, const double z, const double h )
{

	std::ostringstream sID, sMaxSpeed, sDamage ;
	sID << mVehicleID ;

	dtCore::RefPtr<dtDAL::ActorProxy> ap= GetGameManager()->CreateActor(C_ACTOR_CAT, C_CN_AIRCRAFT);
	dtCore::RefPtr<dtGame::GameActorProxy> gap= static_cast<dtGame::GameActorProxy *>(ap.get());
	dtCore::RefPtr<dtGame::GameActor> ga= static_cast<dtGame::GameActor*>(gap->GetActor());

	std::string shipName;
	SimDBConnection *cdb= static_cast<SimDBConnection*>(GetGameManager()->GetComponentByName("Database Connection"));

	std::string fileModel;
	std::string IveModel;
	double max_speed (0.0f);
	double damage (0.0f);
	if( cdb!= NULL) 
	{
		shipName = cdb->GetShipNameByID(mVehicleID);
		max_speed = cdb->GetShipMaxSpeedByID(mVehicleID);
		damage = cdb->GetShipDamageByID(mVehicleID);
		sMaxSpeed << max_speed;
		sDamage << damage;

		int IDShipModel;
		if ( shipName != "" )
		{
			IDShipModel = cdb->GetModelIDFromShipID(mVehicleID);
			IveModel = cdb->GetModelNameFromIDModel(IDShipModel);
			fileModel = C_FOLDER_SHIP + IveModel;

			//std::cout << "ID SHIP MODEL : " << IDShipModel << std::endl;
			//std::cout << "IVE MODEL : " << IveModel << std::endl;
		}
		else
		{
			shipName  = "SHIP-"+sID.str();
			IDShipModel = cdb->GetModelIDFromShipID(mVehicleID);
			IveModel = cdb->GetModelNameFromIDModel(IDShipModel);
			fileModel = C_FOLDER_SHIP + IveModel; //+".ive";
		}
	}
	else
	{
		fileModel = C_FOLDER_SHIP + "1" + ".ive";
	}

	gap->GetProperty(C_SET_VID)->FromString(sID.str());
	gap->GetProperty(C_SET_MODEL)->FromString(fileModel);
	gap->GetProperty("MaxAheadSpeed")->FromString(sMaxSpeed.str());
	gap->GetProperty(C_SET_DAMAGE)->FromString(sDamage.str());
	ga->SetName("Aircraft-"+sID.str());

	GetGameManager()->AddActor(*gap,false,true);

	osg::Vec3 pos, rot ;

	pos.x() = x;
	pos.y() = y;
	pos.z() = z;

	rot.x() = h;

	dtCore::Transform tx;

	tx.SetTranslation(pos);
	tx.SetRotation(rot);

	ga->SetTransform(tx,dtCore::Transformable::REL_CS);
	GetGameManager()->RegisterForMessages(SimMessageType::ORDER_EVENT,*gap,dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);

	GetGameManager()->GetScene().AddDrawable(ga.get());

	std::vector<dtDAL::ActorProxy *> ocp;
	GetGameManager()->FindActorsByName(C_CN_OCEAN, ocp);
	if (ocp[0]!= NULL) //Environment hanya ada satu, belum support multiple environment
	{
		if ( gap->GetGameActor().GetParent() != NULL ) 
			gap->GetGameActor().GetParent()->RemoveChild(&(gap->GetGameActor()));
		static_cast<dtGame::IEnvGameActor*>(ocp[0]->GetActor())->AddActor( *(ga) );
	}
	else
		std::cout<<"Environment actor is missing!"<<std::endl;

	std::cout<<ga->GetName()<<" Added to Scene Pos X "<<pos.x()<<" Y : "<<pos.y()<<" Z : "<<pos.z()<<std::endl;

	dtCore::RefPtr<dtGame::ActorUpdateMessage> mes = 
		static_cast<dtGame::ActorUpdateMessage*>(GetGameManager()->GetMessageFactory().CreateMessage(dtGame::MessageType::INFO_ACTOR_CREATED).get());

	gap->PopulateActorUpdate(*mes);

	GetGameManager()->SendNetworkMessage(*mes);
	GetGameManager()->SendMessage(*mes);
}

void SimActorControl::CreateActorMisc( const int mObjectID, const int mTipeID, const int mModelID , const double x, const double y, const double z,const double h )
{

	dtCore::RefPtr<dtDAL::ActorProxy> ap= GetGameManager()->CreateActor(C_ACTOR_CAT, C_CN_MISC);
	dtCore::RefPtr<dtGame::GameActorProxy> gap= static_cast<dtGame::GameActorProxy *>(ap.get());
	dtCore::RefPtr<dtGame::GameActor> ga= static_cast<dtGame::GameActor*>(gap->GetActor());
	
	std::ostringstream sID, sTipe;

	sID << mObjectID ;

	gap->GetProperty(C_SET_VID)->FromString(sID.str());

	sTipe << mTipeID ;

	gap->GetProperty(C_SET_TID)->FromString(sTipe.str());
	
	
	switch ( mModelID )
	{
		case ORD_MISC_MODEL_1 :
			gap->GetProperty(C_SET_MODEL)->FromString(C_MODEL_MISC_1);
			break;
		case ORD_MISC_MODEL_2 :
			gap->GetProperty(C_SET_MODEL)->FromString(C_MODEL_MISC_2);
			break;
		case ORD_MISC_MODEL_3 :
			gap->GetProperty(C_SET_MODEL)->FromString(C_MODEL_MISC_3);
			break;
		case ORD_MISC_MODEL_4 :
			gap->GetProperty(C_SET_MODEL)->FromString(C_MODEL_MISC_4);
			break;
		case ORD_MISC_MODEL_5 :
			gap->GetProperty(C_SET_MODEL)->FromString(C_MODEL_MISC_5);
			break;
		case ORD_MISC_MODEL_6 :
			gap->GetProperty(C_SET_MODEL)->FromString(C_MODEL_MISC_6);
			break;

	}
	
	switch ( mTipeID )
	{
		case TIPE_MISC_OJK :
			ga->SetName("OJK-"+sID.str());
			break;
		case TIPE_MISC_OLL :
			ga->SetName("OLL-"+sID.str());
			break;
	}
	
	
	GetGameManager()->AddActor(*gap,false,true);
	
	osg::Vec3 pos, rot ;

	pos.x() = x;
	pos.y() = y;
	pos.z() = z;

	rot.x() = h;

	dtCore::Transform tx;

	tx.SetTranslation(pos);
	tx.SetRotation(rot);

	ga->SetTransform(tx,dtCore::Transformable::ABS_CS);

	GetGameManager()->GetScene().AddDrawable(ga.get());

	dtCore::RefPtr<dtGame::ActorUpdateMessage> mess = 
		static_cast<dtGame::ActorUpdateMessage*>(GetGameManager()->GetMessageFactory().CreateMessage(dtGame::MessageType::INFO_ACTOR_UPDATED).get());

	gap->PopulateActorUpdate(*mess);

	GetGameManager()->SendNetworkMessage(*mess);
	GetGameManager()->SendMessage(*mess);

	std::cout<<ga->GetName()<<" Added to Scene Pos X "<<pos.x()<<" Y : "<<pos.y()<<std::endl;	 		 

}


////////////// typeID ( ship / submarine )

void SimActorControl::ProcessSetShipPosition(const dtGame::Message &message)
{
	const MsgPosition &Msg = static_cast<const MsgPosition&>(message);
	switch ( Msg.GetOrderID())
	{
		case ORD_SETPOS : 
		{
			dtCore::RefPtr<dtDAL::ActorProxy> proxy = GetShipActorByID(Msg.GetVehicleID());
			if( proxy.valid())
			{
				dtCore::Transform tmpTrans;

				dtCore::RefPtr<dtGame::GameActorProxy> gap= static_cast<dtGame::GameActorProxy *>(proxy.get());

				dtCore::Transform tx;
				//tx.Set(Msg.GetPosXValue(),Msg.GetPosYValue(),0.05f,Msg.GetPosHValue(),0,0,1,1,1);
				tx.Set(Msg.GetPosXValue(),Msg.GetPosYValue(),Msg.GetPosZValue(),Msg.GetPosHValue(),0,0,1,1,1);

				if (gap->GetActorType().GetName()== C_CN_SHIP )
				{
	                dtCore::RefPtr<ShipModelActor> ga = static_cast<ShipModelActor*>(proxy->GetActor());
					ga->SetTransform(tx);
					ga->ResetOceanWaveVars();
					static_cast<dtDAL::FloatActorProperty*>(gap->GetProperty(C_SET_COURSE))->SetValue(Msg.GetPosHValue());
					static_cast<dtDAL::FloatActorProperty*>(gap->GetProperty(C_SET_SPEED))->SetValue(Msg.GetSpeedValue());
					static_cast<dtDAL::IntActorProperty*>(gap->GetProperty("ModeGuidance"))->SetValue(0);
					//static_cast<dtDAL::IntActorProperty*>(gap->GetProperty("ModeAltitude"))->SetValue(0);
					dtCore::RefPtr<dtGame::ActorUpdateMessage> newGameActorMsg = 
								static_cast<dtGame::ActorUpdateMessage*>(GetGameManager()->GetMessageFactory().
					CreateMessage(dtGame::MessageType::INFO_ACTOR_UPDATED).get());
					gap->PopulateActorUpdate(*newGameActorMsg);
					GetGameManager()->SendNetworkMessage(*newGameActorMsg);

					dtCore::RefPtr<MsgOrder> msg;	
					GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::ORDER_EVENT, msg);

					msg->SetVehicleID(Msg.GetVehicleID());
					msg->SetOrderID(ORD_RESETOCEANWAVE);
					// send local message

					GetGameManager()->SendNetworkMessage(*msg.get());
					GetGameManager()->SendMessage(*msg.get());

				}
				else if ((gap->GetActorType().GetName()== C_CN_SUBMARINE )||(gap->GetActorType().GetName()== C_CN_HELICOPTER )
					||(gap->GetActorType().GetName()== C_CN_AIRCRAFT))
				{
					dtCore::RefPtr<ShipModelActor> ga = static_cast<ShipModelActor*>(proxy->GetActor());
					ga->SetTransform(tx);
					static_cast<dtDAL::FloatActorProperty*>(gap->GetProperty(C_SET_COURSE))->SetValue(Msg.GetPosHValue());
					static_cast<dtDAL::FloatActorProperty*>(gap->GetProperty(C_SET_SPEED))->SetValue(Msg.GetSpeedValue());
					static_cast<dtDAL::IntActorProperty*>(gap->GetProperty("ModeGuidance"))->SetValue(0);
					static_cast<dtDAL::IntActorProperty*>(gap->GetProperty("ModeAltitude"))->SetValue(0);
					dtCore::RefPtr<dtGame::ActorUpdateMessage> newGameActorMsg = 
								static_cast<dtGame::ActorUpdateMessage*>(GetGameManager()->GetMessageFactory().
					CreateMessage(dtGame::MessageType::INFO_ACTOR_UPDATED).get());
					gap->PopulateActorUpdate(*newGameActorMsg);
					GetGameManager()->SendNetworkMessage(*newGameActorMsg);

				}

				std::cout<< GetName() << " Process Set Ship Position " << Msg.GetVehicleID()<< std::endl;
				std::cout<< "  X : " << Msg.GetPosXValue()<< "  Y : " << Msg.GetPosYValue()<< "  Z : " << Msg.GetPosZValue()<< std::endl;
				//std::cout<< "z terrain Vehicle: " << GetGameManager()->GetScene().GetHeightOfTerrain(Msg.GetPosXValue(), Msg.GetPosYValue()) << std::endl;

				/*std::cout<< "z terrain : " << GetGameManager()->GetScene().GetHeightOfTerrain(4692.6, 1227.4) << " - " << GetGameManager()->GetScene().GetHeightOfTerrain(4692.6, 1227.4)-6 << std::endl;
				std::cout<< "z terrain : " << GetGameManager()->GetScene().GetHeightOfTerrain(4842.6, 1027.4) << " - " << GetGameManager()->GetScene().GetHeightOfTerrain(4842.6, 1027.4)-6 << std::endl;
				std::cout<< "z terrain : " << GetGameManager()->GetScene().GetHeightOfTerrain(4192.6, 777.4) << " - " << GetGameManager()->GetScene().GetHeightOfTerrain(4192.6, 777.4)-5 << std::endl;

				std::cout<< "z terrain : " << GetGameManager()->GetScene().GetHeightOfTerrain(3742.6, 477.4) << " - " << GetGameManager()->GetScene().GetHeightOfTerrain(3742.6, 477.4)-12.264 << std::endl;
				std::cout<< "z terrain : " << GetGameManager()->GetScene().GetHeightOfTerrain(2942.6, 227.4) << " - " << GetGameManager()->GetScene().GetHeightOfTerrain(2942.6, 227.4)-3.86 << std::endl;
				std::cout<< "z terrain : " << GetGameManager()->GetScene().GetHeightOfTerrain(3592.6, -222.6) << " - " << GetGameManager()->GetScene().GetHeightOfTerrain(3592.6, -222.6)-87.4 << std::endl;

				std::cout<< "z terrain : " << GetGameManager()->GetScene().GetHeightOfTerrain(5042.6, 477.4) << " - " << GetGameManager()->GetScene().GetHeightOfTerrain(5042.6, 477.4)-56.4 << std::endl;
				std::cout<< "z terrain : " << GetGameManager()->GetScene().GetHeightOfTerrain(4642.6, -72.6) << " - " << GetGameManager()->GetScene().GetHeightOfTerrain(4642.6, -72.6)-129 << std::endl;
				std::cout<< "z terrain : " << GetGameManager()->GetScene().GetHeightOfTerrain(5442.6, -72.6) << " - " << GetGameManager()->GetScene().GetHeightOfTerrain(5442.6, -72.6)-53.4 << std::endl;

				std::cout<< "z terrain : " << GetGameManager()->GetScene().GetHeightOfTerrain(5142.6, 1177.4) << " - " << GetGameManager()->GetScene().GetHeightOfTerrain(5142.6, 1177.4)-38 << std::endl;
				std::cout<< "z terrain : " << GetGameManager()->GetScene().GetHeightOfTerrain(5592.6, 1427.4) << " - " << GetGameManager()->GetScene().GetHeightOfTerrain(5592.6, 1427.4)-27.8 << std::endl;
				std::cout<< "z terrain : " << GetGameManager()->GetScene().GetHeightOfTerrain(5542.6, 927.4) << " - " << GetGameManager()->GetScene().GetHeightOfTerrain(5542.6, 927.4)-35.02 << std::endl;*/

			}
			else
				std::cout<< "Process Set Ship Position " << Msg.GetVehicleID()<< " ship does not exist"<< std::endl;
		}
		break;
	}
}


void SimActorControl::SetFireCannon(const int mVehicleID, const int mWeaponID, const int mLauncherID, const bool StartFire, const int mRateSalvoPerMinutes)
{
	SimDBConnection* cdb= static_cast<SimDBConnection*>(GetGameManager()->GetComponentByName("Database Connection"));
	if( cdb!= NULL)
	{ 
		bool isDatabaseConnected = cdb->isDatabaseConnected();
		if ( isDatabaseConnected ) 
		{
			SimActorWeaponDef* weapon = cdb->FindActorWeaponDef(mVehicleID,mWeaponID,mLauncherID) ;

			if ( weapon != NULL)
			{
				weapon->isFire = StartFire;
				weapon->IntervalTimeSalvo = 60.0f/mRateSalvoPerMinutes;
			}		
		}
		else
		{
			std::cout << "Database Not Connected" << std::endl;
		}
	}
}

void SimActorControl::CheckForSalvo(float aDt)
{
	SimDBConnection* cdb= static_cast<SimDBConnection*>(GetGameManager()->GetComponentByName("Database Connection"));
	if( cdb!= NULL)
	{
		for(std::vector<SimActorShipDef*>::iterator iterShip= cdb->mVehicleActors.begin(); 
			iterShip!=cdb->mVehicleActors.end(); iterShip++ )
		{
			for(std::vector<SimActorWeaponDef*>::iterator iterWeapon= (*iterShip)->mCompDefWeaponShip.begin();
				iterWeapon!= (*iterShip)->mCompDefWeaponShip.end(); iterWeapon++)
			{
				if (((*iterWeapon)->Weapon_ID == CT_CANNON_40) ||
				   ((*iterWeapon)->Weapon_ID == CT_CANNON_57)  ||
				   ((*iterWeapon)->Weapon_ID == CT_CANNON_76)  ||
				   ((*iterWeapon)->Weapon_ID == CT_CANNON_120))
				{
					if ((*iterWeapon)->isFire == true)
					{
						(*iterWeapon)->IntervalSalvo += aDt;
						if ((*iterWeapon)->IntervalSalvo > (*iterWeapon)->IntervalTimeSalvo)
						{
							std::cout << (*iterWeapon)->IntervalTimeSalvo << " canon per minutes" << std::endl;
							(*iterWeapon)->CountFire += 1;

							int m_VehicleID = (*iterWeapon)->Weapon_ShipID;
							int m_WeaponID = (*iterWeapon)->Weapon_ID;
							int m_LauncherID = (*iterWeapon)->Weapon_Launcher;
							int m_MissileID = 1;
							int m_MissileNumber = (*iterWeapon)->CountFire;

							CreateCannonMissileAndLaunch(m_VehicleID, m_WeaponID, m_LauncherID, m_MissileID, m_MissileNumber);

							(*iterWeapon)->IntervalSalvo = 0;
						}
					}
						
				}
				else if ( (*iterWeapon)->Weapon_ID == CT_RBU_6000 )
				{
					if ( (*iterWeapon)->isFire == true )
					{
						(*iterWeapon)->IntervalSalvo += aDt;

						if ((*iterWeapon)->IntervalSalvo > (*iterWeapon)->IntervalTimeSalvo )
						{
							if( (*iterWeapon)->CountFire < (*iterWeapon)->CountRBU )
							{
								int MissileIDRBU[12] = {1,7,6,12,2,8,5,11,3,9,4,10};

								int m_VehicleID = (*iterWeapon)->Weapon_ShipID;
								int m_WeaponID = (*iterWeapon)->Weapon_ID;
								int m_LauncherID = (*iterWeapon)->Weapon_Launcher;
								int m_MissileID = MissileIDRBU[(*iterWeapon)->CountFire];								
								int m_MissileNumber = 1;
								int m_depth = (*iterWeapon)->DepthRBU;
								int m_typerbu = (*iterWeapon)->TypeRBU;
								int m_range = (*iterWeapon)->rangeRBU;
								int m_bearing = (*iterWeapon)->bearingRBU;

								(*iterWeapon)->CountFire += 1;

								std::cout << (*iterWeapon)->CountFire << " - " << (*iterWeapon)->CountRBU <<std::endl;

								//CreateRBUMissile(m_VehicleID, m_WeaponID, m_LauncherID, m_MissileID, m_MissileNumber, m_depth, m_typerbu, m_range, m_bearing);
								CreateRBUMissile(m_VehicleID, m_WeaponID, m_LauncherID, m_MissileID, m_MissileNumber, m_depth, m_typerbu, m_range, m_bearing);
							}
							else
							{
								std::cout << "reset" <<std::endl;
								(*iterWeapon)->isFire = false;
								(*iterWeapon)->CountFire = 0;
								isSalvoRBU = false;
							}

							(*iterWeapon)->IntervalSalvo = 0;
						}
					}
				}
				else if ( (*iterWeapon)->Weapon_ID == CT_YAKHONT )
				{
					if ((*iterWeapon)->isFire == true)
					{
						//std::cout << "m_LauncherID : " << (*iterWeapon)->i_launcher << " : " << (*iterWeapon)->LauncherYakhont[(*iterWeapon)->i_launcher] <<std::endl;
						if ((*iterWeapon)->LauncherYakhont[(*iterWeapon)->i_launcher] != 0)
						{
							if ((*iterWeapon)->i_launcher < 4)
							{
								//(*iterWeapon)->IntervalSalvo += aDt;
								//if ((*iterWeapon)->IntervalSalvo > (*iterWeapon)->IntervalTimeSalvo )
								//{
								int m_VehicleID = (*iterWeapon)->Weapon_ShipID;
								int m_WeaponID = (*iterWeapon)->Weapon_ID;
								int m_LauncherID = (*iterWeapon)->LauncherYakhont[(*iterWeapon)->i_launcher];
								double m_bearing = (*iterWeapon)->bearing;
								double m_range = (*iterWeapon)->range;
								int m_MissileID = 1;
								int m_MissileNumber = 1;

								CreateYakhontMissile(m_VehicleID, m_WeaponID, m_LauncherID, m_MissileID, m_MissileNumber, m_bearing, m_range);
								//(*iterWeapon)->IntervalSalvo = 0;
								(*iterWeapon)->i_launcher ++;
								//}
							}
							else
							{
								(*iterWeapon)->isFire = false;
								(*iterWeapon)->i_launcher = 0;
								isSalvoYakhont = false;
							}
						}
						else
						{
							(*iterWeapon)->i_launcher ++;
						}
					}		
				}
			}
		}
	}
}


void SimActorControl::CheckLaunchSalvo(float aDt)
{
	SimDBConnection* cdb= static_cast<SimDBConnection*>(GetGameManager()->GetComponentByName("Database Connection"));
	if( cdb!= NULL)
	{
		for(std::vector<SimActorShipDef*>::iterator iterShip= cdb->mVehicleActors.begin(); 
			iterShip!=cdb->mVehicleActors.end(); iterShip++ )
		{
			for(std::vector<SimActorWeaponDef*>::iterator iterWeapon= (*iterShip)->mCompDefWeaponShip.begin();
				iterWeapon!= (*iterShip)->mCompDefWeaponShip.end(); iterWeapon++)
			{				
				if ( (*iterWeapon)->Weapon_ID == CT_RBU_6000 )
				{
					if ( (*iterWeapon)->launchFire == true )
					{
						(*iterWeapon)->IntervalSalvo += aDt;

						if ((*iterWeapon)->IntervalSalvo > (*iterWeapon)->IntervalTimeSalvo )
						{
							if( (*iterWeapon)->CountFire < (*iterWeapon)->CountRBU )
							{
								int MissileIDRBU[12] = {1,7,6,12,2,8,5,11,3,9,4,10};

								int m_VehicleID = (*iterWeapon)->Weapon_ShipID;
								int m_WeaponID = (*iterWeapon)->Weapon_ID;
								int m_LauncherID = (*iterWeapon)->Weapon_Launcher;
								int m_MissileID = MissileIDRBU[(*iterWeapon)->CountFire];
								int m_MissileNumber = 1;
								int m_depth = (*iterWeapon)->DepthRBU;
								int m_typerbu = (*iterWeapon)->TypeRBU;
								int m_range = (*iterWeapon)->rangeRBU;
								int m_bearing = (*iterWeapon)->bearingRBU;

								(*iterWeapon)->CountFire += 1;

								std::cout << (*iterWeapon)->CountFire << " - " << (*iterWeapon)->CountRBU <<std::endl;
								
								//LaunchRBUMissile(m_VehicleID, m_WeaponID, m_LauncherID, m_MissileID, m_MissileNumber, m_depth, m_typerbu, m_range, m_bearing);
								LaunchRBUMissile(m_VehicleID, m_WeaponID, m_LauncherID, m_MissileID, m_MissileNumber, m_depth, m_typerbu, m_range, m_bearing);
								
								/* CAMERA UTIL (dibuat player)*/
								std::cout << "Send Message for firing lock" << std::endl;
								dtCore::RefPtr<MsgUtilityAndTools> MsgCam;
								GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::UTILITY_AND_TOOLS, MsgCam);
								MsgCam->SetOrderID(TIPE_UTIL_PLAYER_SETTING);
								MsgCam->SetUAT0(0);
								MsgCam->SetUAT1(PLAYER_SET_FIRING_LOCK);
								MsgCam->SetUAT2(m_VehicleID);
								MsgCam->SetUAT3(m_WeaponID);
								MsgCam->SetUAT4(m_LauncherID);
								MsgCam->SetUAT5(m_MissileID);
								MsgCam->SetUAT6(m_MissileNumber);
								GetGameManager()->SendNetworkMessage(*MsgCam);   					
								GetGameManager()->SendMessage(*MsgCam);

								////set camera RBU
								//if ((*iterWeapon)->CountRBU == 1 && count_1 == true)
								//{
								//	/* CAMERA UTIL (dibuat player)*/
								//	std::cout << "Send Message for firing lock" << std::endl;
								//	dtCore::RefPtr<MsgUtilityAndTools> MsgCam;
								//	GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::UTILITY_AND_TOOLS, MsgCam);
								//	MsgCam->SetOrderID(TIPE_UTIL_PLAYER_SETTING);
								//	MsgCam->SetUAT0(0);
								//	MsgCam->SetUAT1(PLAYER_SET_FIRING_LOCK);
								//	MsgCam->SetUAT2(m_VehicleID);
								//	MsgCam->SetUAT3(m_WeaponID);
								//	MsgCam->SetUAT4(m_LauncherID);
								//	MsgCam->SetUAT5(m_MissileID);
								//	MsgCam->SetUAT6(m_MissileNumber);
								//	GetGameManager()->SendNetworkMessage(*MsgCam);   					
								//	GetGameManager()->SendMessage(*MsgCam);

								//	count_1 = false;
								//}
								//else if ((*iterWeapon)->CountRBU == 4 && count_4 == true)
								//{
								//	/* CAMERA UTIL (dibuat player)*/
								//	std::cout << "Send Message for firing lock" << std::endl;
								//	dtCore::RefPtr<MsgUtilityAndTools> MsgCam;
								//	GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::UTILITY_AND_TOOLS, MsgCam);
								//	MsgCam->SetOrderID(TIPE_UTIL_PLAYER_SETTING);
								//	MsgCam->SetUAT0(0);
								//	MsgCam->SetUAT1(PLAYER_SET_FIRING_LOCK);
								//	MsgCam->SetUAT2(m_VehicleID);
								//	MsgCam->SetUAT3(m_WeaponID);
								//	MsgCam->SetUAT4(m_LauncherID);
								//	MsgCam->SetUAT5(m_MissileID);
								//	MsgCam->SetUAT6(m_MissileNumber);
								//	GetGameManager()->SendNetworkMessage(*MsgCam);   					
								//	GetGameManager()->SendMessage(*MsgCam);

								//	count_4 = false;
								//}
								//else if ((*iterWeapon)->CountRBU == 8 && count_8 == true)
								//{
								//	/* CAMERA UTIL (dibuat player)*/
								//	std::cout << "Send Message for firing lock" << std::endl;
								//	dtCore::RefPtr<MsgUtilityAndTools> MsgCam;
								//	GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::UTILITY_AND_TOOLS, MsgCam);
								//	MsgCam->SetOrderID(TIPE_UTIL_PLAYER_SETTING);
								//	MsgCam->SetUAT0(0);
								//	MsgCam->SetUAT1(PLAYER_SET_FIRING_LOCK);
								//	MsgCam->SetUAT2(m_VehicleID);
								//	MsgCam->SetUAT3(m_WeaponID);
								//	MsgCam->SetUAT4(m_LauncherID);
								//	MsgCam->SetUAT5(m_MissileID);
								//	MsgCam->SetUAT6(m_MissileNumber);
								//	GetGameManager()->SendNetworkMessage(*MsgCam);   					
								//	GetGameManager()->SendMessage(*MsgCam);

								//	count_8 = false;
								//}
								//else if ((*iterWeapon)->CountRBU == 12 && count_12 == true)
								//{
								//	/* CAMERA UTIL (dibuat player)*/
								//	std::cout << "Send Message for firing lock" << std::endl;
								//	dtCore::RefPtr<MsgUtilityAndTools> MsgCam;
								//	GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::UTILITY_AND_TOOLS, MsgCam);
								//	MsgCam->SetOrderID(TIPE_UTIL_PLAYER_SETTING);
								//	MsgCam->SetUAT0(0);
								//	MsgCam->SetUAT1(PLAYER_SET_FIRING_LOCK);
								//	MsgCam->SetUAT2(m_VehicleID);
								//	MsgCam->SetUAT3(m_WeaponID);
								//	MsgCam->SetUAT4(m_LauncherID);
								//	MsgCam->SetUAT5(m_MissileID);
								//	MsgCam->SetUAT6(m_MissileNumber);
								//	GetGameManager()->SendNetworkMessage(*MsgCam);   					
								//	GetGameManager()->SendMessage(*MsgCam);

								//	count_12 = false;
								//}
							}
							else
							{
								(*iterWeapon)->isFire = false;
								(*iterWeapon)->launchFire= false;
								(*iterWeapon)->CountFire = 0;
								isSalvoRBU = false;
							}

							(*iterWeapon)->IntervalSalvo = 0;
						}

					}
				}
				else if ( (*iterWeapon)->Weapon_ID == CT_YAKHONT )
				{
					if ((*iterWeapon)->launchFire == true)
					{
						if ((*iterWeapon)->i_launcher < 4)
						{
							if ((*iterWeapon)->LauncherYakhont[(*iterWeapon)->i_launcher] != 0)
							{
								int m_VehicleID = (*iterWeapon)->Weapon_ShipID;
								int m_WeaponID = (*iterWeapon)->Weapon_ID;
								int m_LauncherID = (*iterWeapon)->LauncherYakhont[(*iterWeapon)->i_launcher];
								double m_bearing = (*iterWeapon)->bearing;
								double m_range = (*iterWeapon)->range;
								int m_MissileID = 1;
								int m_MissileNumber = 1;								

								if((*iterWeapon)->firstLaunch == true)
								{
									std::cout << " first yakhont-"<<(*iterWeapon)->i_launcher<< " : " << m_LauncherID << std::endl;
									LaunchYakhontMissile(m_VehicleID, m_WeaponID, m_LauncherID, m_MissileID, m_MissileNumber, m_bearing, m_range, ORD_YAKHONT_FIRE);
									(*iterWeapon)->firstLaunch = false;
									(*iterWeapon)->i_launcher ++;

									/* CAMERA UTIL (dibuat player)*/
									std::cout << "Send Message for firing lock" << std::endl;
									dtCore::RefPtr<MsgUtilityAndTools> MsgCam;
									GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::UTILITY_AND_TOOLS, MsgCam);
									MsgCam->SetOrderID(TIPE_UTIL_PLAYER_SETTING);
									MsgCam->SetUAT0(0);
									MsgCam->SetUAT1(PLAYER_SET_FIRING_LOCK);
									MsgCam->SetUAT2(m_VehicleID);
									MsgCam->SetUAT3(m_WeaponID);
									MsgCam->SetUAT4(m_LauncherID);
									MsgCam->SetUAT5(m_MissileID);
									MsgCam->SetUAT6(m_MissileNumber);
									GetGameManager()->SendNetworkMessage(*MsgCam);   					
									GetGameManager()->SendMessage(*MsgCam); 
								}
								else
								{
									(*iterWeapon)->IntervalSalvo += aDt;
									if ((*iterWeapon)->IntervalSalvo > (*iterWeapon)->IntervalTimeSalvo )
									{
										std::cout << "yakhont-"<<(*iterWeapon)->i_launcher<< " : " << m_LauncherID << std::endl;
										LaunchYakhontMissile(m_VehicleID, m_WeaponID, m_LauncherID, m_MissileID, m_MissileNumber, m_bearing, m_range, ORD_YAKHONT_FIRE);
										(*iterWeapon)->IntervalSalvo = 0;
										(*iterWeapon)->i_launcher ++;

										/* CAMERA UTIL (dibuat player)*/
										std::cout << "Send Message for firing lock" << std::endl;
										dtCore::RefPtr<MsgUtilityAndTools> MsgCam;
										GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::UTILITY_AND_TOOLS, MsgCam);
										MsgCam->SetOrderID(TIPE_UTIL_PLAYER_SETTING);
										MsgCam->SetUAT0(0);
										MsgCam->SetUAT1(PLAYER_SET_FIRING_LOCK);
										MsgCam->SetUAT2(m_VehicleID);
										MsgCam->SetUAT3(m_WeaponID);
										MsgCam->SetUAT4(m_LauncherID);
										MsgCam->SetUAT5(m_MissileID);
										MsgCam->SetUAT6(m_MissileNumber);
										GetGameManager()->SendNetworkMessage(*MsgCam);   					
										GetGameManager()->SendMessage(*MsgCam); 
									}
								}
							}
							else
								(*iterWeapon)->i_launcher ++;
						}
						else
						{
							(*iterWeapon)->launchFire = false;
							(*iterWeapon)->i_launcher = 0;
							(*iterWeapon)->firstLaunch = true;
						}
					}

					if ((*iterWeapon)->isRelease == true)
					{
						if ((*iterWeapon)->i_launcher < 4)
						{
							if ((*iterWeapon)->LauncherYakhont[(*iterWeapon)->i_launcher] != 0)
							{
								int m_VehicleID = (*iterWeapon)->Weapon_ShipID;
								int m_WeaponID = (*iterWeapon)->Weapon_ID;
								int m_LauncherID = (*iterWeapon)->LauncherYakhont[(*iterWeapon)->i_launcher];
								double m_bearing = (*iterWeapon)->bearing;
								double m_range = (*iterWeapon)->range;
								int m_MissileID = 1;
								int m_MissileNumber = 1;								

								if((*iterWeapon)->firstLaunch == true)
								{
									std::cout << "first release yakhont-"<<(*iterWeapon)->i_launcher<< " : " << m_LauncherID << std::endl;
									LaunchYakhontMissile(m_VehicleID, m_WeaponID, m_LauncherID, m_MissileID, m_MissileNumber, m_bearing, m_range, ORD_YAKHONT_RELEASE);
									(*iterWeapon)->firstLaunch = false;
									(*iterWeapon)->i_launcher ++;

									/* CAMERA UTIL (dibuat player)*/
									std::cout << "Send Message for firing lock" << std::endl;
									dtCore::RefPtr<MsgUtilityAndTools> MsgCam;
									GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::UTILITY_AND_TOOLS, MsgCam);
									MsgCam->SetOrderID(TIPE_UTIL_PLAYER_SETTING);
									MsgCam->SetUAT0(0);
									MsgCam->SetUAT1(PLAYER_SET_FIRING_LOCK);
									MsgCam->SetUAT2(m_VehicleID);
									MsgCam->SetUAT3(m_WeaponID);
									MsgCam->SetUAT4(m_LauncherID);
									MsgCam->SetUAT5(m_MissileID);
									MsgCam->SetUAT6(m_MissileNumber);
									GetGameManager()->SendNetworkMessage(*MsgCam);   					
									GetGameManager()->SendMessage(*MsgCam); 


								}
								else
								{
									(*iterWeapon)->IntervalSalvo += aDt;
									if ((*iterWeapon)->IntervalSalvo > (*iterWeapon)->IntervalTimeSalvo )
									{
										std::cout << "yakhont-"<<(*iterWeapon)->i_launcher<< " : " << m_LauncherID << std::endl;
										LaunchYakhontMissile(m_VehicleID, m_WeaponID, m_LauncherID, m_MissileID, m_MissileNumber, m_bearing, m_range, ORD_YAKHONT_RELEASE);
										(*iterWeapon)->IntervalSalvo = 0;
										(*iterWeapon)->i_launcher ++;
									} 
								}
							}
							else
								(*iterWeapon)->i_launcher ++;
						}
						else
						{
							(*iterWeapon)->launchFire = false;
							(*iterWeapon)->i_launcher = 0;
							(*iterWeapon)->firstLaunch = true;
							(*iterWeapon)->isRelease = false;
						}
					}
				}
			}
		}
	}
}


void SimActorControl::CreateCannonMissileAndLaunch(const int mVehicleID, const int mWeaponID, const int mLauncherID , const int mMissileID, const int mMissileNum )
{
	//std::cout << "Create Cannon " << mVehicleID << "-" << mWeaponID << "-" << mLauncherID << "-" << mMissileID << "-" << mMissileNum << std::endl;

	dtCore::RefPtr<MsgSetCannon> Msg;
	GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::CANNON_EVENT, Msg); 

	static float MisNumber(0);
	MisNumber = MisNumber + 1;

	Msg->SetVehicleID(mVehicleID);
	Msg->SetWeaponID(mWeaponID);
	Msg->SetLauncherID(mLauncherID);
	Msg->SetMissileID(mMissileID);
	Msg->SetMissileNum(mMissileNum);
	Msg->SetOrderID(ORD_CANNON_F);
	Msg->SetModeID(1);

	/*
	dtCore::RefPtr<dtDAL::ActorProxy> ap = GetMissileActors(mVehicleID, mWeaponID, mLauncherID, mMissileID, mMissileNum );
	if(!ap.valid())
	{
		CreateMissileActors(mVehicleID, mWeaponID, mLauncherID, mMissileID, mMissileNum );
	}
	*/

	GetGameManager()->SendNetworkMessage(*Msg.get());
	GetGameManager()->SendMessage(*Msg.get());
}

void SimActorControl::SetFireRBU(const int mVehicleID, const int mTargetID, const int mWeaponID, const int mLauncherID , const bool StartFire, const int countRBU, 
								   const float depth, const int mTypeRBU, const float mRange,  const float mBearing, const bool LaunchFire)
{
 	SimDBConnection* cdb= static_cast<SimDBConnection*>(GetGameManager()->GetComponentByName(C_COMP_DB_CONNECTION));
	if( cdb!= NULL)
	{
		bool isDatabaseConnected = cdb->isDatabaseConnected();
		if ( isDatabaseConnected ) 
		{
			SimActorWeaponDef* weapon = cdb->FindActorWeaponDef(mVehicleID,mWeaponID,mLauncherID) ;

			if ( weapon != NULL)
			{
				weapon->isFire = StartFire;
				weapon->CountRBU = countRBU;
				if ( countRBU > 12 )
				{
					weapon->CountRBU = 12;
					std::cout << "Warning!!Count RBU overload. Count RBU Set to 12" << std::endl;
				}
				weapon->DepthRBU = depth;
				weapon->TypeRBU = mTypeRBU;
				weapon->launchFire = LaunchFire;
				weapon->IntervalTimeSalvo = 0.5;
				weapon->IntervalSalvo = 0;

				// ambil actor ship id dan targetid [7/26/2012 DID RKT2]
				
				dtCore::RefPtr<dtDAL::ActorProxy> parentProxy = GetShipActorByID(mTargetID);
				dtCore::RefPtr<dtDAL::ActorProxy> pProxy = GetShipActorByID(mVehicleID);
				if ( parentProxy.valid() )
				{
					dtCore::RefPtr<ShipActor> parent = static_cast<ShipActor*>(parentProxy->GetActor());
					dtGame::GameActorProxy &pr = parent->GetGameActorProxy();
					parent->GetTransform(objectTransform);
					objectTransform.GetTranslation(objectPosition);
					objectTransform.GetRotation(objectRotation);
				}				
				if ( pProxy.valid() )
				{
					dtCore::RefPtr<ShipActor> parent = static_cast<ShipActor*>(pProxy->GetActor());
					dtGame::GameActorProxy &pr = parent->GetGameActorProxy();
					parent->GetTransform(ownShipTransform);
					ownShipTransform.GetTranslation(ownShipPosition);
					ownShipTransform.GetRotation(ownShipRotation);
				}

				if (( pProxy.valid() ) && ( parentProxy.valid() )){
					// First bearing and elev [7/26/2012 DID RKT2]
					konstan = 360 / 12;
					nbearing = ComputeBearingTo2(ownShipPosition.x(),ownShipPosition.y(),objectPosition.x(),objectPosition.y());
					ndistance = Range3D(ownShipPosition.x(), ownShipPosition.y(), 0, objectPosition.x(), objectPosition.y(), 0);
					if (mTypeRBU == 1)
						nElev	  = (0.0365 * ndistance) - 9.75 ;
					else
						nElev	  = (0.0091 * ndistance) - 5.1875 ;

					weapon->rangeRBU = ndistance;
					weapon->bearingRBU = nbearing;
				}
				else
				{
					konstan = 360 / 12;
					ndistance = mRange;
					nbearing = mBearing;
					if (mTypeRBU == 1)
						nElev	  = (0.0365 * ndistance) - 9.75 ;
					else
						nElev	  = (0.0091 * ndistance) - 5.1875 ;

					weapon->rangeRBU = mRange;
					weapon->bearingRBU = mBearing;
				}
			}
		}
		else
		{
			std::cout << "Database Not Connected" << std::endl;
		}
	}
}

void SimActorControl::CreateRBUMissile(const int mVehicleID, const int mWeaponID, const int mLauncherID , const int mMissileID, const int mMissileNum,
												const float depth, const int mTypeRBU, const float mRange,  const float mBearing )
{
	dtCore::RefPtr<dtDAL::ActorProxy> ap = GetMissileActors(mVehicleID, mWeaponID, mLauncherID, mMissileID, mMissileNum );
	if(!ap.valid())
	{
		CreateMissileActors(mVehicleID, mWeaponID, mLauncherID, mMissileID, mMissileNum );
	}
}

void SimActorControl::LaunchRBUMissile(const int mVehicleID, const int mWeaponID, const int mLauncherID , const int mMissileID, const int mMissileNum,
									   const float depth, const int mTypeRBU, const float mRange,  const float mBearing )
{
	dtCore::RefPtr<MsgSetRBU> Msg;
	GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::RBU_EVENT, Msg); 

	static float iterasiKoreksi(0);

	Msg->SetVehicleID(mVehicleID);
	Msg->SetWeaponID(mWeaponID);
	Msg->SetLauncherID(mLauncherID);
	Msg->SetMissileID(mMissileID);
	Msg->SetMissileNum(mMissileNum);
	Msg->SetOrderID(ORD_RBU_FIRE);
	Msg->SetTargetDepth(depth);
	Msg->SetMissileType(mTypeRBU);
	Msg->SetTargetBearing(mBearing);
	
	NewPoint = RangeBearingToCoord(ownShipPosition, mRange, mBearing);
	WayPoint = RangeBearingToCoord(NewPoint, 100, iterasiKoreksi * konstan);
	rangeWS = Range3D(ownShipPosition.x(),ownShipPosition.y(),0,WayPoint.x(),WayPoint.y(),0);
	NewTargetBearing = ComputeBearingTo2(ownShipPosition.x(), ownShipPosition.y(), WayPoint.x(), WayPoint.y());
	NewTargetBearing = ValidateDegree(NewTargetBearing);

	if (mTypeRBU == 1)
		NewElevation	  = (0.0365 * rangeWS) - 9.75 ;
	else
		NewElevation	  = (0.0091 * rangeWS) - 5.1875 ;

	Msg->SetTargetRange(rangeWS);
	Msg->SetCorrectBearing(NewTargetBearing-nbearing);
	Msg->SetCorrectElev(NewElevation-nElev );

	std::cout << "CorBearing " << NewTargetBearing-nbearing << " ; CorElev : " << NewElevation-nElev << ", NewElev : " << NewElevation << std::endl;

	iterasiKoreksi = iterasiKoreksi + 1;

	GetGameManager()->SendNetworkMessage(*Msg.get());
	GetGameManager()->SendMessage(*Msg.get());
}

// Salvo Yakhont [7/30/2012 DID RKT2]
void SimActorControl::SetFireYakhont(const int mVehicleID, const int mWeaponID, const int mLauncherID, const bool StartFire, const int countYakhont
									 , const int l1, const int l2, const int l3, const int l4
									 , const double bearing, const double range, const bool LaunchFire, const bool isRelease)
{
	SimDBConnection* cdb= static_cast<SimDBConnection*>(GetGameManager()->GetComponentByName("Database Connection"));
	if( cdb!= NULL)
	{
		bool isDatabaseConnected = cdb->isDatabaseConnected();
		if ( isDatabaseConnected ) 
		{
			SimActorWeaponDef* weapon = cdb->FindActorWeaponDef(mVehicleID,mWeaponID,mLauncherID) ;

			if (weapon == NULL)
			{
				weapon = cdb->GetNewDatabaseActorWeaponDef(mVehicleID,mWeaponID,mLauncherID);
			}

			if ( weapon != NULL)
			{ 
				weapon->isFire = StartFire;
				weapon->CountRBU = countYakhont;
				weapon->bearing = bearing;
				weapon->range = range;
				weapon->launchFire = LaunchFire; 
				weapon->i_launcher = 0;
				weapon->IntervalTimeSalvo = 10.0f;
				weapon->isRelease = isRelease;
				//weapon->firstLaunch = true;

				if ( l1 == 1 ) weapon->LauncherYakhont[0] = 1;
				else weapon->LauncherYakhont[0] = 0;
				if ( l2 == 1 ) weapon->LauncherYakhont[1] = 2;
				else weapon->LauncherYakhont[1] = 0;
				if ( l3 == 1 ) weapon->LauncherYakhont[2] = 3;
				else weapon->LauncherYakhont[2] = 0;
				if ( l4 == 1 ) weapon->LauncherYakhont[3] = 4;
				else weapon->LauncherYakhont[3] = 0;
			}		
		}
		else
		{
			std::cout << "Database Not Connected" << std::endl;
		}
	}
}

void SimActorControl::CreateYakhontMissile(const int mVehicleID, const int mWeaponID, const int mLauncherID , const int mMissileID, const int mMissileNum
													, const double bearing, const double range)
{
	dtCore::RefPtr<dtDAL::ActorProxy> ap = GetMissileActors(mVehicleID, mWeaponID, mLauncherID, mMissileID, mMissileNum );
	if(!ap.valid())
	{
		std::cout << "Create Missile " << mVehicleID << "-" << mWeaponID << "-" << mLauncherID << "-" << mMissileID << "-" << mMissileNum << std::endl;
		CreateMissileActors(mVehicleID, mWeaponID, mLauncherID, mMissileID, mMissileNum );
	}
}

void SimActorControl::LaunchYakhontMissile(const int mVehicleID, const int mWeaponID, const int mLauncherID , const int mMissileID, const int mMissileNum
										   , const double bearing, const double range, const int OrderID)
{
	dtCore::RefPtr<MsgSetYakhont> Msg;
	GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::YAKHONT_EVENT, Msg); 

	Msg->SetVehicleID(mVehicleID);
	Msg->SetWeaponID(mWeaponID);
	Msg->SetLauncherID(mLauncherID);
	Msg->SetMissileID(1);
	Msg->SetMissileNum(1);
	Msg->SetOrderID(OrderID);
	Msg->SetBearingToTarget(bearing); 
	Msg->SetDistanceToTarget(range);

	GetGameManager()->SendNetworkMessage(*Msg.get());
	GetGameManager()->SendMessage(*Msg.get());
}

dtCore::RefPtr<dtDAL::ActorProxy> SimActorControl::CreateConstantDiponegoroCannon76( const int cVehicleID, const int cWeaponID, const int cLauncherID )
{
   cfgLauncher.mDatabaseID		=	0 ;
   cfgLauncher.mVehicleID		=	cVehicleID ;
   cfgLauncher.mWeaponID		=	cWeaponID ; 
   cfgLauncher.mLauncherID		=	cLauncherID	;

	//Versi HardCore Mode...Tidak connect database

	//Hanya Dibuat 3 Versi Cannon 
    // 1. Meriam 76 launcher 1 di DIPONEGORO heading 0
    // 2. Meriam 57 launcher 1 di KAPITEN PATIMURA heading 0
    // 3. Meriam 40 launcher 2 di SINGA heading 180

    //Strella Launcher 1 di KAPITEN PATIMURA
    //Mistral Launcher 1 di AHMAD YANI
	//Tetral Launcher 1 di DIPONEGORO

    //Selain kombinasi di atas tidak bisa..hanya untuk versi DEMO

   if (cWeaponID == CT_CANNON_76)
   {
	   cfgLauncher.mModelID1		=	67	;
	   cfgLauncher.mModelID2		=	68 ;
	   cfgLauncher.mDOFID1			=	3	;
	   cfgLauncher.mDOFID2			=	4	;
	   cfgLauncher.mSwitchID		=	2	;
	   cfgLauncher.mPOS_Heading		=   0		;
	   cfgLauncher.mPOS_Pitch  		=   0		;
	   cfgLauncher.mName			=	"Demo-TDS-DIPONEGORO"	;
	   cfgLauncher.mModelName1		=	C_FOLDER_WEAPON + "Meriam76Base.ive"		;
	   cfgLauncher.mModelName2		=	C_FOLDER_WEAPON + "Meriam76Launcher.ive"	;
	   cfgLauncher.mDOFName1		=	"DOF_Meriam76Base"		;
	   cfgLauncher.mDOFName2		=	"DOF_Meriam76Launcher"	;
	   cfgLauncher.mSwitchName		=	"SwitchMeriam76"		; 
   }
   else
   if (cWeaponID == CT_CANNON_57)
   {
	   cfgLauncher.mModelID1		=	65	;
	   cfgLauncher.mModelID2		=	66 ;
	   cfgLauncher.mDOFID1			=	5	;
	   cfgLauncher.mDOFID2			=	6	;
	   cfgLauncher.mSwitchID		=	3	;
	   cfgLauncher.mPOS_Heading		=   180		;
	   cfgLauncher.mPOS_Pitch  		=   0		;
	   cfgLauncher.mName			=	"Demo-TDS-KAPITEN PATIMURA"	;
	   cfgLauncher.mModelName1		=	C_FOLDER_WEAPON + "Meriam57Base.ive"		;
	   cfgLauncher.mModelName2		=	C_FOLDER_WEAPON + "Meriam57Launcher.ive"	;
	   cfgLauncher.mDOFName1		=	"DOF_Meriam57Base"		;
	   cfgLauncher.mDOFName2		=	"DOF_Meriam57Launcher"	;
	   cfgLauncher.mSwitchName		=	"SwitchMeriam57"		;
   }	
   else
   if (cWeaponID == CT_CANNON_40)
   {
	   cfgLauncher.mModelID1		=	63	;
	   cfgLauncher.mModelID2		=	64 ;
	   cfgLauncher.mDOFID1			=	74	;
	   cfgLauncher.mDOFID2			=	9	;
	   cfgLauncher.mSwitchID		=	4	;
	   cfgLauncher.mPOS_Heading		=   180		;
	   cfgLauncher.mPOS_Pitch  		=   0		;
	   cfgLauncher.mName			=	"Demo-TDS-ANDAU"	;
	   cfgLauncher.mModelName1		=	C_FOLDER_WEAPON + "Meriam40Base.ive"		;
	   cfgLauncher.mModelName2		=	C_FOLDER_WEAPON + "Meriam40Launcher.ive"	;
	   cfgLauncher.mDOFName1		=	"DOF_Meriam40Base"		;
	   cfgLauncher.mDOFName2		=	"DOF_Meriam40Launcher"	;
	   cfgLauncher.mSwitchName		=	"SwitchMeriam40_1"		;
   }	
   else
   if (cWeaponID == CT_TETRAL)
   {
	   cfgLauncher.mModelID1		=	82	;
	   cfgLauncher.mModelID2		=	83 ;
	   cfgLauncher.mDOFID1			=	46	;
	   cfgLauncher.mDOFID2			=	48	;
	   cfgLauncher.mSwitchID		=	12	;
	   cfgLauncher.mPOS_Heading		=   90		;
	   cfgLauncher.mPOS_Pitch  		=   0		;
	   cfgLauncher.mName			=	"Demo-TETRAL-DIPONEGORO"	;
	   cfgLauncher.mModelName1		=	C_FOLDER_WEAPON + "TetralBase.ive"		;
	   cfgLauncher.mModelName2		=	C_FOLDER_WEAPON + "TetralLauncher.ive"	;
	   cfgLauncher.mDOFName1		=	"DOF_TetralBase_1"		;
	   cfgLauncher.mDOFName2		=	"DOF_TetralLauncher"	;
	   cfgLauncher.mSwitchName		=	"SwitchTetral_1"		;
   }
   else
   if (cWeaponID == CT_STRELA)
   {
	   cfgLauncher.mModelID1		=	80	;
	   cfgLauncher.mModelID2		=	81 ;
	   cfgLauncher.mDOFID1			=	41	;
	   cfgLauncher.mDOFID2			=	45	;
	   cfgLauncher.mSwitchID		=	10	;
	   cfgLauncher.mPOS_Heading		=   90		;
	   cfgLauncher.mPOS_Pitch  		=   0		;
	   cfgLauncher.mName			=	"Demo-STRELA-K-PATIMURA"	;
	   cfgLauncher.mModelName1		=	C_FOLDER_WEAPON + "StrelaBase.ive"		;
	   cfgLauncher.mModelName2		=	C_FOLDER_WEAPON + "StrelaLauncher.ive"	;
	   cfgLauncher.mDOFName1		=	"DOF_StrelaBase_1"		;
	   cfgLauncher.mDOFName2		=	"DOF_StrelaLauncher"	;
	   cfgLauncher.mSwitchName		=	"SwitchStrela_1"		;
   }
   else
   if (cWeaponID == CT_MISTRAL)
   {
	   cfgLauncher.mModelID1		=	75	;
	   cfgLauncher.mModelID2		=	76  ;
	   cfgLauncher.mDOFID1			=	22	;
	   cfgLauncher.mDOFID2			=	24	;
	   cfgLauncher.mSwitchID		=	14	;
	   cfgLauncher.mPOS_Heading		=   90	;
	   cfgLauncher.mPOS_Pitch  		=   0		;
	   cfgLauncher.mName			=	"Demo-MISTRAL-AHMAD YANI"	;
	   cfgLauncher.mModelName1		=	C_FOLDER_WEAPON + "MistralBase.ive"		;
	   cfgLauncher.mModelName2		=	C_FOLDER_WEAPON + "MistralLauncher.ive"	;
	   cfgLauncher.mDOFName1		=	"DOF_MistralBase_1"		;
	   cfgLauncher.mDOFName2		=	"DOF_MistralLauncher"	;
	   cfgLauncher.mSwitchName		=	"SwitchMistral_1"		;
   }

   

   cfgLauncher.mStartAngle		=   260.0f					;
   cfgLauncher.mEndAngle		=	100.0f					;
   cfgLauncher.mStartPitch		=	0.0f					;
   cfgLauncher.mEndPitch		=	0.0f					;

   CreateLaunchersBodyActors();
   CreateLaunchersSpoutActors();

   return GetLauncherActors(C_WEAPON_TYPE_SPOUT,cVehicleID,cWeaponID,cLauncherID) ;

}

dtCore::RefPtr<dtDAL::ActorProxy> SimActorControl::CreateConstantMandauCannon40( const int cVehicleID, const int cWeaponID, const int cLauncherID )
{
	cfgLauncher.mDatabaseID		=	0 ;
	cfgLauncher.mVehicleID		=	cVehicleID ;
	cfgLauncher.mWeaponID		=	cWeaponID ; 
	cfgLauncher.mLauncherID		=	cLauncherID	;
	cfgLauncher.mModelID1		=	67	;
	cfgLauncher.mModelID2		=	68 ;
	cfgLauncher.mDOFID1			=	3	;
	cfgLauncher.mDOFID2			=	4	;
	cfgLauncher.mSwitchID		=	2	;
	cfgLauncher.mPOS_Heading		=   0		;
	cfgLauncher.mPOS_Pitch  		=   0		;
	cfgLauncher.mName			=	"Demo-TDS-MANDAU"	;
	cfgLauncher.mModelName1		=	C_FOLDER_WEAPON + "Meriam40Base.ive"		;
	cfgLauncher.mModelName2		=	C_FOLDER_WEAPON + "Meriam40Launcher.ive"	;
	cfgLauncher.mDOFName1		=	"DOF_Meriam40Base"		;
	cfgLauncher.mDOFName2		=	"DOF_Meriam40Launcher"	;
	cfgLauncher.mSwitchName		=	C_SwitchMeriam40_1		;

	cfgLauncher.mStartAngle		=   260.0f					;
	cfgLauncher.mEndAngle		=	100.0f					;
	cfgLauncher.mStartPitch		=	0.0f					;
	cfgLauncher.mEndPitch		=	0.0f					;

	CreateLaunchersBodyActors();
	CreateLaunchersSpoutActors();

	return GetLauncherActors(C_WEAPON_TYPE_SPOUT,cVehicleID,cWeaponID,cLauncherID) ;

}


dtCore::RefPtr<dtDAL::ActorProxy> SimActorControl::GetShipActorByID(int mVehicleID )
{
	SimServerClientComponent* simSC = static_cast<SimServerClientComponent*> (GetGameManager()->GetComponentByName(C_COMP_SERVER_CLIENT_CTRL));
	if ( simSC != NULL )
	{ 
		return simSC->GetShipActorByID(mVehicleID);
	} else
		return NULL ;
}

dtCore::RefPtr<dtDAL::ActorProxy> SimActorControl::GetLauncherActors(const int actTypeID, const int mVehicleID, const int mWeaponID, const int mLauncherID  )
{
	SimServerClientComponent* simSC = static_cast<SimServerClientComponent*> (GetGameManager()->GetComponentByName(C_COMP_SERVER_CLIENT_CTRL));
	if ( simSC != NULL )
	{
		return simSC->GetLauncherActors(actTypeID, mVehicleID, mWeaponID, mLauncherID);
	} else
		return NULL ;
}

dtCore::RefPtr<dtDAL::ActorProxy> SimActorControl::GetMissileActors(const int mVehicleID, const int mWeaponID, const int mLauncherID, const int mMissileID, const int mMissileNum )
{
	SimServerClientComponent* simSC = static_cast<SimServerClientComponent*> (GetGameManager()->GetComponentByName(C_COMP_SERVER_CLIENT_CTRL));
	if ( simSC != NULL )
	{
		return simSC->GetMissileActors(mVehicleID, mWeaponID, mLauncherID, mMissileID, mMissileNum);
	}else
		return NULL ;
}

dtCore::RefPtr<dtDAL::ActorProxy> SimActorControl::GetMissileByLauncher(const int mVehicleID, const int mWeaponID, const int mLauncherID)
{
	SimServerClientComponent* simSC = static_cast<SimServerClientComponent*> (GetGameManager()->GetComponentByName(C_COMP_SERVER_CLIENT_CTRL));
	if ( simSC != NULL )
	{
		return simSC->GetMissileByLauncher(mVehicleID, mWeaponID, mLauncherID);
	}else
		return NULL ;
}

dtCore::RefPtr<dtDAL::ActorProxy> SimActorControl::GetMiscActorByID(int mMiscID )
{
	SimServerClientComponent* simSC = static_cast<SimServerClientComponent*> (GetGameManager()->GetComponentByName(C_COMP_SERVER_CLIENT_CTRL));
	if ( simSC != NULL )
	{
		return simSC->GetMiscActorByID(mMiscID);
	} else
		return NULL ;
}

//////////////////////////////////////////////////////////////////////////

void SimActorControl::Confirm_DeleteShipActor( const int vehicleID )
{
	/// send info delete actor to instruktur 2D
	dtCore::RefPtr<MsgUtilityAndTools> msg;
	GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::UTILITY_AND_TOOLS, msg);

	msg->SetOrderID(TIPE_UTIL_SHIP_STATUS);
	msg->SetUAT0(vehicleID);
	msg->SetUAT1(ORD_SHIP_DEL);
	GetGameManager()->SendNetworkMessage(*msg);
	GetGameManager()->SendMessage(*msg);
}

void SimActorControl::Confirm_MissileActorLoaded(const int VID, const int WID, const int LID,const int MID, const int MNum)
{
	/// send info missile loaded to instruktur 2D

	std::cout << "send info missile loaded to instruktur 2D" <<std::endl;

	dtCore::RefPtr<MsgUtilityAndTools> msg;
	GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::UTILITY_AND_TOOLS, msg);

	msg->SetOrderID(TIPE_UTIL_MISSILE_STATUS);
	msg->SetUAT0(VID);
	msg->SetUAT1(WID);
	msg->SetUAT2(LID);
	msg->SetUAT3(MID);
	msg->SetUAT4(MNum);
	msg->SetUAT5(ST_MISSILE_LOADED); 

	GetGameManager()->SendNetworkMessage(*msg);
	GetGameManager()->SendMessage(*msg);
}

void SimActorControl::DeleteShipActor( int opt, int SetID  )
{
	std::vector<dtGame::GameActorProxy *> fill;
	std::vector<dtGame::GameActorProxy *>::iterator iter;
	GetGameManager()->GetAllGameActors(fill);

	for (iter = fill.begin(); iter < fill.end(); iter++)
	{
		if (((*iter)->GetActorType().GetName()== C_CN_SHIP ) || ((*iter)->GetActorType().GetName()== C_CN_SUBMARINE )
			|| ((*iter)->GetActorType().GetName()== C_CN_HELICOPTER )|| ((*iter)->GetActorType().GetName()== C_CN_AIRCRAFT )) 
		{
			if ( opt == DEL_ALL ) 
			{
				Confirm_DeleteShipActor(SetID);

				dtCore::UniqueId mCurrentTargetId ((*iter)->GetActor()->GetUniqueId());
				SimServerClientComponent* simSC = static_cast<SimServerClientComponent*> (GetGameManager()->GetComponentByName(C_COMP_SERVER_CLIENT_CTRL));
				if ( simSC != NULL )
				{
					simSC->VerifyPlayerBeforeDeleteParent(mCurrentTargetId);
				}

				std::cout<< GetName() << " clear ship actor " << (*iter)->GetActor()->GetName() << std::endl;
				dtCore::RefPtr<dtGame::ActorDeletedMessage> mess = 
					static_cast<dtGame::ActorDeletedMessage*>(GetGameManager()->GetMessageFactory().CreateMessage(dtGame::MessageType::INFO_ACTOR_DELETED).get());
				mess->SetAboutActorId(mCurrentTargetId);
				GetGameManager()->DeleteActor(*(*iter));
				GetGameManager()->SendMessage(*mess);
				GetGameManager()->SendNetworkMessage(*mess);
			}
			else
				if ( opt == DEL_CURR ) 
				{
					dtCore::RefPtr<dtDAL::ActorProperty> VehicleID( (*iter)->GetProperty(C_SET_VID) );
					dtCore::RefPtr<dtDAL::IntActorProperty> ValID( static_cast<dtDAL::IntActorProperty*>( VehicleID.get() ) );
					int tgt( ValID->GetValue() );
					if ( tgt == SetID )
					{
						Confirm_DeleteShipActor(tgt);

						dtCore::UniqueId mCurrentTargetId ((*iter)->GetActor()->GetUniqueId());
						SimServerClientComponent* simSC = static_cast<SimServerClientComponent*> (GetGameManager()->GetComponentByName(C_COMP_SERVER_CLIENT_CTRL));
						if ( simSC != NULL )
						{
							simSC->VerifyPlayerBeforeDeleteParent(mCurrentTargetId);
						}

						std::cout<< GetName() << " delete ship " << (*iter)->GetActor()->GetName() << std::endl;
						dtCore::RefPtr<dtGame::ActorDeletedMessage> mess = 
							static_cast<dtGame::ActorDeletedMessage*>(GetGameManager()->GetMessageFactory().CreateMessage(dtGame::MessageType::INFO_ACTOR_DELETED).get());
						mess->SetAboutActorId(mCurrentTargetId);
						GetGameManager()->DeleteActor(*(*iter));
						GetGameManager()->SendMessage(*mess);
						GetGameManager()->SendNetworkMessage(*mess);
						break;
					}
				}  
		}
	}
}

void SimActorControl::DeleteMissileActors( const int VID, const int weaponID, const int LID, const int missileID, const int missileNum )
{
	dtCore::RefPtr<dtDAL::ActorProxy> proxy = GetMissileActors(VID, weaponID , LID, missileID, missileNum);
	if( proxy.valid() )
	{
		dtCore::UniqueId mCurrentTargetId (proxy->GetActor()->GetUniqueId());

		SimServerClientComponent* simSC = static_cast<SimServerClientComponent*> (GetGameManager()->GetComponentByName(C_COMP_SERVER_CLIENT_CTRL));
		if ( simSC != NULL )
		{
			simSC->VerifyPlayerBeforeDeleteParent(mCurrentTargetId);
		}

		dtCore::RefPtr<dtGame::ActorDeletedMessage> mess = static_cast<dtGame::ActorDeletedMessage*>(GetGameManager()->GetMessageFactory().CreateMessage(dtGame::MessageType::INFO_ACTOR_DELETED).get());
		mess->SetAboutActorId(mCurrentTargetId);
		GetGameManager()->DeleteActor(*proxy);
		GetGameManager()->SendMessage(*mess);
		GetGameManager()->SendNetworkMessage(*mess);

		std::cout<<proxy->GetName()<<" deleted"<<std::endl;
		
		//Check Delete Berkala
		//Missile Tidak Terdetele
		dtCore::RefPtr<dtGame::GameActorProxy> gap = GetGameManager()->FindGameActorById(mCurrentTargetId);
		if ( gap )
		{
			std::cout << "Kenapa Masih Ada Missile?????" <<std::endl;
			
			SimServerClientComponent* simSC = static_cast<SimServerClientComponent*> (GetGameManager()->GetComponentByName(C_COMP_SERVER_CLIENT_CTRL));
			if ( simSC != NULL )
			{
				simSC->VerifyPlayerBeforeDeleteParent(mCurrentTargetId);
			}

			dtCore::RefPtr<dtGame::ActorDeletedMessage> mess = static_cast<dtGame::ActorDeletedMessage*>(GetGameManager()->GetMessageFactory().CreateMessage(dtGame::MessageType::INFO_ACTOR_DELETED).get());
			mess->SetAboutActorId(mCurrentTargetId);
			GetGameManager()->DeleteActor(*proxy);
			GetGameManager()->SendMessage(*mess);
			GetGameManager()->SendNetworkMessage(*mess);

			std::cout<<proxy->GetName()<<" deleted"<<std::endl;
		}

	} else
		std::cout<<" Received Command deleted on data ( fail:: "<<VID<<"-"<<weaponID<<"-"<<LID<<"-"<<missileID<<"-"<<missileNum<<std::endl;

}

void SimActorControl::DeleteLauncherActors( const int actTypeID, const int VID, const int weaponID, const int LID)
{
	dtCore::RefPtr<dtDAL::ActorProxy> proxy = GetLauncherActors(actTypeID, VID, weaponID , LID);
	if( proxy.valid() )
	{
		dtCore::UniqueId mCurrentTargetId (proxy->GetActor()->GetUniqueId());

		SimServerClientComponent* simSC = static_cast<SimServerClientComponent*> (GetGameManager()->GetComponentByName(C_COMP_SERVER_CLIENT_CTRL));
		if ( simSC != NULL )
		{
			simSC->VerifyPlayerBeforeDeleteParent(mCurrentTargetId);
		}

		dtCore::RefPtr<dtGame::ActorDeletedMessage> mess = static_cast<dtGame::ActorDeletedMessage*>(GetGameManager()->GetMessageFactory().CreateMessage(dtGame::MessageType::INFO_ACTOR_DELETED).get());
		mess->SetAboutActorId(mCurrentTargetId);
		GetGameManager()->DeleteActor(*proxy);
		GetGameManager()->SendMessage(*mess);
		GetGameManager()->SendNetworkMessage(*mess);

		std::cout<<proxy->GetName()<<" deleted"<<std::endl;
	}
}

void SimActorControl::DeleteObjectMisc( int TipeID , int opt, int SetID  )
{
	std::vector<dtGame::GameActorProxy *> fill;
	std::vector<dtGame::GameActorProxy *>::iterator iter;
	GetGameManager()->GetAllGameActors(fill);
	for (iter = fill.begin(); iter < fill.end(); iter++)
	{
		if( (*iter)->GetActorType().GetName().compare(C_CN_MISC) == 0 ) 
		{
			dtCore::RefPtr<dtDAL::ActorProperty> actTipeID( (*iter)->GetProperty(C_SET_TID) );
			dtCore::RefPtr<dtDAL::IntActorProperty> ValTipeID( static_cast<dtDAL::IntActorProperty*>( actTipeID.get() ) );
			int mTipe( ValTipeID->GetValue() );
			if ( mTipe == TipeID )
			{
				if ( opt == DEL_ALL ) 
				{
					std::cout<< GetName() << " clear misc actor " << (*iter)->GetActor()->GetName() << std::endl;
					dtCore::RefPtr<dtGame::ActorDeletedMessage> mess = 
						static_cast<dtGame::ActorDeletedMessage*>(GetGameManager()->GetMessageFactory().CreateMessage(dtGame::MessageType::INFO_ACTOR_DELETED).get());
					mess->SetAboutActorId((*iter)->GetActor()->GetUniqueId());
					GetGameManager()->DeleteActor(*(*iter));
					GetGameManager()->SendMessage(*mess);
					GetGameManager()->SendNetworkMessage(*mess);
				}
				else
					if ( opt == DEL_CURR ) 
					{
						dtCore::RefPtr<dtDAL::ActorProperty> VehicleID( (*iter)->GetProperty(C_SET_VID) );
						dtCore::RefPtr<dtDAL::IntActorProperty> ValID( static_cast<dtDAL::IntActorProperty*>( VehicleID.get() ) );
						int tgt( ValID->GetValue() );
						if ( tgt == SetID )
						{
							std::cout<< GetName() << " delete misc " << (*iter)->GetActor()->GetName() << std::endl;
							dtCore::RefPtr<dtGame::ActorDeletedMessage> mess = 
								static_cast<dtGame::ActorDeletedMessage*>(GetGameManager()->GetMessageFactory().CreateMessage(dtGame::MessageType::INFO_ACTOR_DELETED).get());
							mess->SetAboutActorId((*iter)->GetActor()->GetUniqueId());
							GetGameManager()->DeleteActor(*(*iter));
							GetGameManager()->SendMessage(*mess);
							GetGameManager()->SendNetworkMessage(*mess);

							break;
						}
					}
			} /// end if ( mTipe == TipeID )
		}
	}
}

