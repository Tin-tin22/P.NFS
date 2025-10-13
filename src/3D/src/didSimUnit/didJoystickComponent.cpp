//++ Includes
#include "didJoystickComponent.h"
#include <iostream>
#include <dtCore/deltawin.h>
#include <dtUtil/mathdefines.h>
#include <dtGame/messagefactory.h>
#include <math.h>
#include <osg/math>

#include <osgviewer/api/win32/graphicswindowwin32>

#include "../didNetwork/SimTCPDataTypes.h"
#include "../didNetwork/SocketClientGM.h"
#include "../didCommon/SimMessages.h"
#include "../didCommon/SimMessageType.h"
//#include "../didActors/vehicleactor.h" // BAWE-20101125: PHYSICS_ATTRIBUTE. DISABLED
//#include "../didActors/shipmodelactor.h" // BAWE-20101125: PHYSICS_ATTRIBUTE. NEW_VERSION

#include "../LogiWheelUnspring/stdafx.h"

#include "../LogiWheelUnspring/LogiControllerInput.h"
#include "../LogiWheelUnspring/LogiControllerProperties.h"
#include "../LogiWheelUnspring/LogiWheel.h"

//-- Includes

///////////////////////////////////////////////////////////////////////////////////
/// ------------- didCameraControlComponent definitions ---------------------------

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++ Constants

//++ BAWE-20101202: JOYSTICK_TYPE
const std::string	didJoystickComponent::DEVICE_NAME_RUDDER_1	= "usb pad";						///< The Device name for the rudder type joystick
const std::string	didJoystickComponent::DEVICE_NAME_RUDDER_2	= "Microsoft PC-joystick driver";	///< The Device name for the rudder type joystick
const std::string	didJoystickComponent::DEVICE_NAME_STEER_1	= "Driving Force GT";				///< The Device name for the steering wheel type joystick (1st version)
const std::string	didJoystickComponent::DEVICE_NAME_STEER_2	= "Logitech Driving Force GT USB";	///< The Device name for the steering wheel type joystick (2nd version)


//-- BAWE-20101202: JOYSTICK_TYPE

const double	didJoystickComponent::UNINITIALIZED_AXIS	= -1.5259021893143654e-005;
const float		didJoystickComponent::MAX_DT_ACK			= 1.0; //Delta Time max acknowledge for sending the joystick messages
const int		didJoystickComponent::AXIS_THROTTLE_1		= 3;
const int		didJoystickComponent::AXIS_THROTTLE_2		= 4;
const int		didJoystickComponent::AXIS_RUDDER			= 5;
const int		didJoystickComponent::AXIS_STEER			= 0;


//++ BAWE-20100922: HACK MANIA! HACK MANIA! HACK MANIA! HACKED HARD CODED CONSTANT VALUES
//const double	didJoystickComponent::HACK_CONST_SHIP_LENGTH		= 100.0;	///< Panjang kapal
//const double	didJoystickComponent::HACK_CONST_SHIP_WIDTH			= 5.0;		///< Lebahr kapal
//const double	didJoystickComponent::HACK_CONST_MAX_AHEAD			= 24.0;		///< Max forward speed
//const double	didJoystickComponent::HACK_CONST_MAX_ASTERN			= -12.0;	///< Max backward speed
//const double	didJoystickComponent::HACK_CONST_MAX_STEER_ANGLE	= 45.0;		///< Max steer angle
//-- BAWE-20100922: HACK MANIA! HACK MANIA! HACK MANIA! HACKED HARD CODED CONSTANT VALUES

const double	didJoystickComponent::sForcedZero::THROTTLE_1_UNINITIALIZED	= -0.018f; ///< The forced zero value if the axis = throttle 1, and the state is MOVE_UNINITIALIZED (when the joystick is at the initial stage, the value is always -1.5259021893143654e-005)
const double	didJoystickComponent::sForcedZero::THROTTLE_2_UNINITIALIZED	= -0.018f; ///< The forced zero value if the axis = throttle 2, and the state is MOVE_UNINITIALIZED (when the joystick is at the initial stage, the value is always -1.5259021893143654e-005)
const double	didJoystickComponent::sForcedZero::RUDDER_UNINITIALIZED		= 0.090f; ///< The forced zero value if the axis = steer, and the state is MOVE_UNINITIALIZED (when the joystick is at the initial stage, the value is always -1.5259021893143654e-005)
const double	didJoystickComponent::sForcedZero::THROTTLE_1_INCREASE	= 0.120f; ///< The forced zero value if the axis = throttle 1, and the state is MOVE_INCREASE (from negative to 0)
const double	didJoystickComponent::sForcedZero::THROTTLE_2_INCREASE	= 0.120f; ///< The forced zero value if the axis = throttle 2, and the state is MOVE_INCREASE (from negative to 0)
const double	didJoystickComponent::sForcedZero::RUDDER_INCREASE		= 0.100f; ///< The forced zero value if the axis = steer, and the state is MOVE_INCREASE (from negative to 0)
const double	didJoystickComponent::sForcedZero::THROTTLE_1_DECREASE	= 0.120f; ///< The forced zero value if the axis = throttle 1, and the state is MOVE_DECREASE (from positive to 0)
const double	didJoystickComponent::sForcedZero::THROTTLE_2_DECREASE	= 0.120f; ///< The forced zero value if the axis = throttle 2, and the state is MOVE_DECREASE (from positive to 0)
const double	didJoystickComponent::sForcedZero::RUDDER_DECREASE		= 0.100f; ///< The forced zero value if the axis = steer, and the state is MOVE_DECREASE (from positive to 0)

//-- Constants
//---------------------------------------------------------------------------------

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++ Methods Definitions

////+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
////++ Ctor & Dtor

////// Constructor
didJoystickComponent::didJoystickComponent(const std::string& name)
      : Parent(name)
      , mLogger(dtUtil::Log::GetInstance("didJoystickComponent.cpp"))
	  , mAttachedVehicleID(-1)
	  , mAttachedVehicleName("")
	  , mLastThrottle1(UNINITIALIZED_AXIS)
	  , mLastThrottle2(UNINITIALIZED_AXIS)
	  , mLastSteer(UNINITIALIZED_AXIS)
	  , mStateThrottle1(STATE_IDLE)
	  , mStateThrottle2(STATE_IDLE)
	  , mStateSteer(STATE_IDLE)
	  , mMovementThrottle1(MOVE_UNINITIALIZED)
	  , mMovementThrottle2(MOVE_UNINITIALIZED)
	  , mMovementSteer(MOVE_UNINITIALIZED)
	  , mDTAckThrottle1(0.0)
	  , mDTAckThrottle2(0.0)
	  , mDTAckSteer(0.0)
	  , mActiveType(RUDDER)
{
	mJoystickTypes.clear();

	//++ BAWE-20101230: MOVE TO ADDEDTOGM
//	LogiUnspring();
//	dtInputPLIB::Joystick::CreateInstances();
//
//	if (dtInputPLIB::Joystick::GetInstanceCount() > 0)
//	{
//		std::cout<<"\ndidJoystickComponent::didJoystickComponent: Joystick found. " \
//		<< std::endl;
//
//		//++ BAWE-20101202: JOYSTICK_TYPE
//		for (int instance = 0; instance < dtInputPLIB::Joystick::GetInstanceCount(); ++instance)
//		{
//			const std::string joystickName = dtInputPLIB::Joystick::GetInstance(instance)->GetDeviceName();
//std::cout<<"\ndidJoystickComponent::didJoystickComponent: DEVICE NAME["<< instance <<"] = "<< dtInputPLIB::Joystick::GetInstance(instance)->GetDeviceName() <<". " \
//<< std::endl;                                                                                                                                                                                                                                                                          
//			if ( joystickName == DEVICE_NAME_RUDDER_1 || joystickName == DEVICE_NAME_RUDDER_2 )
//				mJoystickTypes[RUDDER] = instance;
//			//else if ( joystickName == DEVICE_NAME_STEER_1 || joystickName == DEVICE_NAME_STEER_2)
//			else if ( joystickName.find("Logitech") != std::string::npos)
//				mJoystickTypes[STEER] = instance;
//		}
//		//-- BAWE-20101202: JOYSTICK_TYPE
//
//		mJoystickFound = true;
//	}
//	else
//	{
//		mJoystickFound = false;
//		std::cout<<"\ndidJoystickComponent::didJoystickComponent: CANNOT FIND JOYSTICK INSTANCE! CHECK THE CABLE OF THE JOYSTICK. " \
//		<< std::endl;
//	}
	//-- BAWE-20101230: MOVE TO ADDEDTOGM
}

////// Destructor
didJoystickComponent::~didJoystickComponent( )
{
}

////-- Ctor & Dtor
////-------------------------------------------------------------------------------

////+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
////++ INHERITED PUBLIC

void didJoystickComponent::ProcessMessage(const dtGame::Message& msg)
{
	const dtGame::MessageType& msgType = msg.GetMessageType();

	Parent::ProcessMessage(msg);

	if(msgType == dtGame::MessageType::TICK_LOCAL)
	{
		float dt = float(static_cast<const dtGame::TickMessage&>(msg).GetDeltaSimTime());
		Tick(dt);
	}
	else if (msgType == dtGame::MessageType::INFO_MAP_LOADED)
	{


		// sam. todo next, use database connect, jadi tidak ambil property statis yang gak perlu.

		mShipPhysics.mLength = 100.0f;
		mShipPhysics.mWidth = 8.0f;
		mShipPhysics.mHeight = 10.0f;
		mShipPhysics.mMaxAhead = 28.0f;
		mShipPhysics.mMaxAstern = 14.0f;
		mShipPhysics.mMaxSteer = 45.0f;
		//////////////////////////////////////////////////////////////////////////

		////++ BAWE-20101125: PHYSICS_ATTRIBUTE. DISABLED
		////VehicleActorProxy* attachedActorProxy;

		////GetGameManager()->FindActorByName(mAttachedVehicleName, attachedActorProxy);
		////VehicleActor* actor =
		////		dynamic_cast<VehicleActor*> (attachedActorProxy->GetActor());
		////mAttachedVehicleID = actor->GetVehicleID();
		////-- BAWE-20101125: PHYSICS_ATTRIBUTE. DISABLED

		////++ BAWE-20101125: PHYSICS_ATTRIBUTE. NEW_VERSION
		//ShipModelActorProxy* attachedActorProxy;

		//GetGameManager()->FindActorByName(mAttachedVehicleName, attachedActorProxy);
		//ShipModelActor* actor = dynamic_cast<ShipModelActor*> (attachedActorProxy->GetActor());
		//mAttachedVehicleID = actor->GetVehicleID();

		//mShipPhysics.mLength = actor->GetLength();
		//mShipPhysics.mWidth = actor->GetWidth();
		//mShipPhysics.mHeight = actor->GetHeight();
		//mShipPhysics.mMaxAhead = actor->GetMaxAheadSpeed();
		//mShipPhysics.mMaxAstern = actor->GetMaxAsternSpeed();
		//mShipPhysics.mMaxSteer = actor->GetMaxRudderAngle();
		////-- BAWE-20101125: PHYSICS_ATTRIBUTE. NEW_VERSION

		/////< @Todo: add the routines to set joystick type
		////++ BAWE-20101202: JOYSTICK_TYPE
		//SetActiveType((eJoystickType)actor->GetControlType());
		////-- BAWE-20101202: JOYSTICK_TYPE

	}


}

void didJoystickComponent::OnAddedToGM( )
{
	//RegisterForMessages(SimMessageType::ORDER_EVENT, dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
	//RegisterForMessages(dtGame::MessageType::TICK_LOCAL, dtGame::GameActorProxy::TICK_LOCAL_INVOKABLE);

	//++ BAWE-20101230: MOVE FROM CTOR
	LogiUnspring();
	dtInputPLIB::Joystick::CreateInstances();

	if (dtInputPLIB::Joystick::GetInstanceCount() > 0)
	{
		std::cout<<"\ndidJoystickComponent::didJoystickComponent: Joystick found. " \
		<< std::endl;

		//++ BAWE-20101202: JOYSTICK_TYPE
		for (int instance = 0; instance < dtInputPLIB::Joystick::GetInstanceCount(); ++instance)
		{
			const std::string joystickName = dtInputPLIB::Joystick::GetInstance(instance)->GetDeviceName();
			std::cout<<"\ndidJoystickComponent::didJoystickComponent: DEVICE NAME["<< instance <<"] = "<< dtInputPLIB::Joystick::GetInstance(instance)->GetDeviceName() <<". " << std::endl;                                                                                                                                                                                                                                                                          
			if ( joystickName == DEVICE_NAME_RUDDER_1 || joystickName == DEVICE_NAME_RUDDER_2 )
				mJoystickTypes[RUDDER] = instance;
			//else if ( joystickName == DEVICE_NAME_STEER_1 || joystickName == DEVICE_NAME_STEER_2)
			else if ( joystickName.find("Logitech") != std::string::npos)
				mJoystickTypes[STEER] = instance;
		}
		//-- BAWE-20101202: JOYSTICK_TYPE

		mJoystickFound = true;
	}
	else
	{
		mJoystickFound = false;
		std::cout<<"\ndidJoystickComponent::didJoystickComponent: CANNOT FIND JOYSTICK INSTANCE! CHECK THE CABLE OF THE JOYSTICK. " \
		<< std::endl;
	}
	//-- BAWE-20101230: MOVE FROM CTOR
}

void didJoystickComponent::OnRemovedFromGM( )
{
	
}

////-- INHERITED PUBLIC
////-------------------------------------------------------------------------------

////+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
////++ Generic Methods


using namespace LogitechControllerInput;
using namespace LogitechSteeringWheel;

/**
 *
 *
 */
void didJoystickComponent::LogiUnspring( )
{
	dtCore::DeltaWin *win =  GetGameManager()->GetApplication().GetWindow();
	osgViewer::GraphicsWindowWin32 *win32 = 
		dynamic_cast<osgViewer::GraphicsWindowWin32*>(win->GetOsgViewerGraphicsWindow());
	if(win32 != NULL)
	{
		// Get the HWND
		HWND hwndC = win32->getHWND();

		// Then we could just get the HINSTANCE:
		//HINSTANCE hInstC = GetModuleHandle( 0 ) ;

		ControllerInput* g_controllerInput = new ControllerInput(hwndC, TRUE);
		Wheel* g_wheel = new Wheel(g_controllerInput);

		ControllerPropertiesData propertiesData;
		ZeroMemory(&propertiesData, sizeof(propertiesData));
		propertiesData.forceEnable = FALSE;
		propertiesData.overallGain = 0;
		propertiesData.springGain = 0;
		propertiesData.damperGain = 0;
		propertiesData.combinePedals = FALSE;
		propertiesData.wheelRange = 900;
		propertiesData.defaultSpringEnabled = FALSE;
		propertiesData.defaultSpringGain = 0;

		HRESULT result;

		for (int index_ = 0; index_ < LogitechSteeringWheel::LG_MAX_CONTROLLERS; index_++)
		{
			if (g_wheel->IsConnected(index_))
			{
				if (g_wheel->IsConnected(index_, LG_MANUFACTURER_LOGITECH) && g_wheel->IsConnected(index_, LG_DEVICE_TYPE_WHEEL))
				{
std::cout<<"Index: "<<index_<<" connected. Set the wheel!"<<std::endl;
					result = g_wheel->SetPreferredControllerProperties(propertiesData);
					g_controllerInput->Update();
					g_wheel->Update();
std::cout<<"Setting Controller Properties: Index "<<index_<<" = ";
result == S_OK? (std::cout<<"SUCCESSFUL!"<<std::endl):(std::cout<<"FAILED!"<<std::endl);
					result = g_wheel->PlayCarAirborne(index_);
					g_controllerInput->Update();
					g_wheel->Update();
std::cout<<"Play Airborne: Index "<<index_<<" = ";
result == S_OK? (std::cout<<"SUCCESSFUL!"<<std::endl):(std::cout<<"FAILED!"<<std::endl);
					result = g_wheel->PlayConstantForce(index_, 0);
					g_controllerInput->Update();
					g_wheel->Update();
std::cout<<"Play Constant Force: Index "<<index_<<" = ";
result == S_OK? (std::cout<<"SUCCESSFUL!"<<std::endl):(std::cout<<"FAILED!"<<std::endl);
				}
			}
		}

		delete g_wheel;
		delete g_controllerInput;
	}
}

/**
 *
 *
 */
void didJoystickComponent::Init( const std::string& attachedVehicleName		///< The name of the vehicle that this joystick component will affect.
								)
{
	mAttachedVehicleName = attachedVehicleName;
}


/**
 *
 *
 */
void didJoystickComponent::Tick(float dt)
{
	double axisThrottle1;
	double axisThrottle2;
	double axisSteer;

	//if (mJoystickFound && mAttachedVehicleID > -1) // BAWE-20110622: PAUSE_GAME
    if (!GetGameManager()->IsPaused() && mJoystickFound && mAttachedVehicleID > -1) // BAWE-20110622: PAUSE_GAME
	{
		dtInputPLIB::Joystick::PollInstances();

		//Get states		
		//++ BAWE-20101202: JOYSTICK_TYPE. DISABLED
		//axisThrottle1 = dtInputPLIB::Joystick::GetInstance(0)->GetAxis(AXIS_THROTTLE_1)->GetState();
		//axisThrottle2 = dtInputPLIB::Joystick::GetInstance(0)->GetAxis(AXIS_THROTTLE_2)->GetState();
		//axisSteer = dtInputPLIB::Joystick::GetInstance(0)->GetAxis(AXIS_STEER)->GetState();
		//-- BAWE-20101202: JOYSTICK_TYPE. DISABLED
		//++ BAWE-20101202: JOYSTICK_TYPE. NEW
		if (mActiveType == RUDDER)
		{
			axisThrottle1 = dtInputPLIB::Joystick::GetInstance(mJoystickTypes[RUDDER])->GetAxis(AXIS_THROTTLE_1)->GetState();
			axisThrottle2 = dtInputPLIB::Joystick::GetInstance(mJoystickTypes[RUDDER])->GetAxis(AXIS_THROTTLE_2)->GetState();
			axisSteer = dtInputPLIB::Joystick::GetInstance(mJoystickTypes[RUDDER])->GetAxis(AXIS_RUDDER)->GetState();

			int tempInt = (int) (axisThrottle1 * 1000);
			axisThrottle1 = ((double) tempInt) / 1000;
			tempInt = (int) (axisThrottle2 * 1000);
			axisThrottle2 = ((double) tempInt) / 1000;
			tempInt = (int) (axisSteer * 1000);
			axisSteer = ((double) tempInt) / 1000;
		}
		else if (mActiveType == STEER)
		{
			axisSteer = (dtInputPLIB::Joystick::GetInstance(mJoystickTypes[STEER])->GetAxis(AXIS_STEER)->GetState()) * -1;
			int tempInt = (int) (axisSteer * 1000);
			axisSteer = ((double) tempInt) / 1000;
            axisThrottle1 = 0.0f;
            axisThrottle2 = 0.0f;
		}
		//-- BAWE-20101202: JOYSTICK_TYPE. NEW

		//Check changes

		////// Throttle 1
		//if (axisThrottle1 != mLastThrottle1)
		//{
		//	mStateThrottle1 = STATE_CHANGING;

		//	if (!(
		//		 mMovementThrottle1 == MOVE_UNINITIALIZED
		//		 && dtUtil::Abs(axisThrottle1) <= dtUtil::Abs(mForcedZero.THROTTLE_1_UNINITIALIZED)
		//		 && dtUtil::Abs(axisThrottle1) >= 0
		//		 ) )
		//	{
		//		if (mLastThrottle1 < axisThrottle1)
		//			mMovementThrottle1 = MOVE_INCREASE;
		//		else
		//			mMovementThrottle1 = MOVE_DECREASE;
		//	}

		//	mLastThrottle1 = axisThrottle1;
		//	mDTAckThrottle1 = 0; 

		//}
		//else if (mStateThrottle1 == STATE_CHANGING) //If the last value is the same with the current one and the state is changing
		//{
		//	mDTAckThrottle1 += dt;
		//	if (mDTAckThrottle1 >= MAX_DT_ACK)
		//	{
		//		mStateThrottle1 = STATE_ACKNOWLEDGED; //Ready to send message
		//		mDTAckThrottle1 = 0; 
		//	}
		//}

		////// Throttle 2
		//if (axisThrottle2 != mLastThrottle2)
		//{
		//	mStateThrottle2 = STATE_CHANGING;

		//	if (!(
		//		  mMovementThrottle2 == MOVE_UNINITIALIZED
		//		  && dtUtil::Abs(axisThrottle2) <= dtUtil::Abs(mForcedZero.THROTTLE_2_UNINITIALIZED)
		//		  && dtUtil::Abs(axisThrottle2) >= 0
		//		  ) )
		//	{
		//		if (mLastThrottle2 < axisThrottle2)
		//			mMovementThrottle2 = MOVE_INCREASE;
		//		else
		//			mMovementThrottle2 = MOVE_DECREASE;
		//	}

		//	mLastThrottle2 = axisThrottle2;
		//	mDTAckThrottle2 = 0; 
		//}
		//else if (mStateThrottle2 == STATE_CHANGING) //If the last value is the same with the current one and the state is changing
		//{
		//	mDTAckThrottle2 += dt;
		//	if (mDTAckThrottle2 >= MAX_DT_ACK)
		//	{
		//		mStateThrottle2 = STATE_ACKNOWLEDGED; //Ready to send message
		//		mDTAckThrottle2 = 0; 
		//	}
		//}

		//++ BAWE-20101202: JOYSTICK_TYPE. NEW
		if (mActiveType == RUDDER)
		{

			//// Throttle 1
			if (!(axisThrottle1 == mLastThrottle1))
			{
				mStateThrottle1 = STATE_CHANGING;

				if (!(
					 mMovementThrottle1 == MOVE_UNINITIALIZED
					 && dtUtil::Abs(axisThrottle1) <= dtUtil::Abs(mForcedZero.THROTTLE_1_UNINITIALIZED)
					 && dtUtil::Abs(axisThrottle1) >= 0
					 ) )
				{
					if (mLastThrottle1 < axisThrottle1)
						mMovementThrottle1 = MOVE_INCREASE;
					else
						mMovementThrottle1 = MOVE_DECREASE;

//std::cout<<"mStateThrottle1 STATE_CHANGING = ";
//mMovementThrottle1 == MOVE_INCREASE? (std::cout<<"MOVE_INCREASE"<<std::endl):(std::cout<<"MOVE_DECREASE"<<std::endl);
//std::cout<<"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!axisThrottle1 = "<<axisThrottle1<<std::endl;
//std::cout<<"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!mLastThrottle1 = "<<mLastThrottle1<<std::endl;
				}

				mLastThrottle1 = axisThrottle1;
				mDTAckThrottle1 = 0; 

			}
			else if (mStateThrottle1 == STATE_CHANGING) //If the last value is the same with the current one and the state is changing
			{
				mDTAckThrottle1 += dt;
				if (mDTAckThrottle1 >= MAX_DT_ACK)
				{
//std::cout<<"Ready to send: mLastThrottle1 = "<<mLastThrottle1<<std::endl;
					mStateThrottle1 = STATE_ACKNOWLEDGED; //Ready to send message
					mDTAckThrottle1 = 0; 
				}
			}

			//// Throttle 2
			if (!(axisThrottle2 == mLastThrottle2))
			{
				mStateThrottle2 = STATE_CHANGING;

				if (!(
					  mMovementThrottle2 == MOVE_UNINITIALIZED
					  && dtUtil::Abs(axisThrottle2) <= dtUtil::Abs(mForcedZero.THROTTLE_2_UNINITIALIZED)
					  && dtUtil::Abs(axisThrottle2) >= 0
					  ) )
				{
					if (mLastThrottle2 < axisThrottle2)
						mMovementThrottle2 = MOVE_INCREASE;
					else
						mMovementThrottle2 = MOVE_DECREASE;
//std::cout<<"mStateThrottle2 STATE_CHANGING = ";
//mMovementThrottle2 == MOVE_INCREASE? (std::cout<<"MOVE_INCREASE"<<std::endl):(std::cout<<"MOVE_DECREASE"<<std::endl);
//std::cout<<"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!axisThrottle2 = "<<axisThrottle2<<std::endl;
//std::cout<<"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!mLastThrottle2 = "<<mLastThrottle2<<std::endl;
				}

				mLastThrottle2 = axisThrottle2;
				mDTAckThrottle2 = 0; 
			}
			else if (mStateThrottle2 == STATE_CHANGING) //If the last value is the same with the current one and the state is changing
			{
				mDTAckThrottle2 += dt;
				if (mDTAckThrottle2 >= MAX_DT_ACK)
				{
//std::cout<<"Ready to send: mLastThrottle2 = "<<mLastThrottle2<<std::endl;
					mStateThrottle2 = STATE_ACKNOWLEDGED; //Ready to send message
					mDTAckThrottle2 = 0; 
				}
			}
		}
		//-- BAWE-20101202: JOYSTICK_TYPE. NEW

		//// Steer
		if (axisSteer != mLastSteer)
		{
			mStateSteer = STATE_CHANGING;

			if (!(
				  mMovementSteer == MOVE_UNINITIALIZED
				  && dtUtil::Abs(axisSteer) <= dtUtil::Abs(mForcedZero.RUDDER_UNINITIALIZED)
				  && dtUtil::Abs(axisSteer) >= 0
				  ) )
			{
				if (mLastSteer < axisSteer)
					mMovementSteer = MOVE_INCREASE;
				else
					mMovementSteer = MOVE_DECREASE;
			}

			mLastSteer = axisSteer;
			mDTAckSteer = 0;
		}
		else if (mStateSteer == STATE_CHANGING) //If the last value is the same with the current one and the state is changing
		{
			mDTAckSteer += dt;
			if (mDTAckSteer >= MAX_DT_ACK)
			{
				mStateSteer = STATE_ACKNOWLEDGED; //Ready to send message
				mDTAckSteer = 0;
			}
			
		}

		CheckSendMessage();
	}
}

/**
 * Check if the joystick is currently at the forced 0 position or not. 
 * NOTE: Joystick dodolz yang menyusahkan programmer. Knapa ga bisa 0 atau mendekati 0 kalo lagi center / di tengah2 aja seh? -_____-"
 *
 */
bool didJoystickComponent::CheckForcedZero(int axis)
{
	bool retValue = false;
	switch(axis)
	{
		case AXIS_THROTTLE_1:
			if ( 
					( mMovementThrottle1 == MOVE_UNINITIALIZED )
					//|| (mMovementThrottle1 == MOVE_INCREASE && dtUtil::Abs(mLastThrottle1) <= mForcedZero.THROTTLE_1_INCREASE ) 
					//|| (mMovementThrottle1 == MOVE_DECREASE && dtUtil::Abs(mLastThrottle1) <= mForcedZero.THROTTLE_1_DECREASE ) 
					|| (mMovementThrottle1 == MOVE_INCREASE && mLastThrottle1 < mForcedZero.THROTTLE_1_INCREASE && mLastThrottle2 > 0.0f ) 
					|| (mMovementThrottle1 == MOVE_DECREASE && mLastThrottle1 < mForcedZero.THROTTLE_1_DECREASE && mLastThrottle2 > 0.0f ) 
				)
			{
				retValue = true;	
			}
			break;
		case AXIS_THROTTLE_2:
			if ( 
					( mMovementThrottle2 == MOVE_UNINITIALIZED )
					//|| ( mMovementThrottle2 == MOVE_INCREASE && dtUtil::Abs(mLastThrottle2) <= mForcedZero.THROTTLE_2_INCREASE ) 
					//|| ( mMovementThrottle2 == MOVE_DECREASE && dtUtil::Abs(mLastThrottle2) <= mForcedZero.THROTTLE_2_DECREASE ) 
					|| ( mMovementThrottle2 == MOVE_INCREASE && mLastThrottle2 < mForcedZero.THROTTLE_2_INCREASE && mLastThrottle2 > 0.0f ) 
					|| ( mMovementThrottle2 == MOVE_DECREASE && mLastThrottle2 < mForcedZero.THROTTLE_2_DECREASE && mLastThrottle2 > 0.0f )
				)
			{
				retValue = true;	
			}
			break;
		case AXIS_RUDDER:
			if (mActiveType == RUDDER)
			{
				if ( 
						( mMovementSteer == MOVE_UNINITIALIZED )
						//|| ( mMovementSteer == MOVE_INCREASE && dtUtil::Abs(mLastSteer) <= mForcedZero.STEER_INCREASE ) 
						//|| ( mMovementSteer == MOVE_DECREASE && dtUtil::Abs(mLastSteer) <= mForcedZero.STEER_DECREASE ) 
						|| ( mMovementSteer == MOVE_INCREASE && mLastSteer < mForcedZero.RUDDER_INCREASE && mLastSteer > 0.0f ) 
						|| ( mMovementSteer == MOVE_DECREASE && mLastSteer < mForcedZero.RUDDER_DECREASE && mLastSteer > 0.0f )
					)
				{
					retValue = true;	
				}
			}
			else
			{
				if ( 
						( mMovementSteer == MOVE_UNINITIALIZED )
						//|| ( mMovementSteer == MOVE_INCREASE && dtUtil::Abs(mLastSteer) <= mForcedZero.STEER_INCREASE ) 
						//|| ( mMovementSteer == MOVE_DECREASE && dtUtil::Abs(mLastSteer) <= mForcedZero.STEER_DECREASE ) 
						|| ( mMovementSteer == MOVE_INCREASE && mLastSteer < 0.06f && mLastSteer > -0.06f ) 
						|| ( mMovementSteer == MOVE_DECREASE && mLastSteer < 0.06f && mLastSteer > -0.06f )
					)
				{
					retValue = true;	
				}
			}
			break;
		default:
			break;
	}
	return retValue;
}

/**
 * Check whether or not the component will have to send a new input message 
 *
 */
void didJoystickComponent::CheckSendMessage()
{
	double speed, steerAngle, addAngle;

	//Throttle1
	if (mStateThrottle1 == STATE_ACKNOWLEDGED || mStateThrottle2 == STATE_ACKNOWLEDGED)
	{
		CalcThrottle(speed, addAngle);

		Send(TO_SEND_THROTTLE, speed);
		Send(TO_SEND_ADD_ANGLE, addAngle);

		mStateThrottle1 = STATE_IDLE;
		mStateThrottle2 = STATE_IDLE;
		mDTAckThrottle1 = 0; 
		mDTAckThrottle2 = 0; 

	}

	//Steer
	if (mStateSteer == STATE_ACKNOWLEDGED)
	{
		CalcSteer(steerAngle);

		Send(TO_SEND_RUDDER, steerAngle);

		mStateSteer = STATE_IDLE;
		mDTAckSteer = 0;
	}
}

/**
 * Send a network message based on the type. 
 *
 */
void didJoystickComponent::Send(int toSendType, float value)
{
	CSocketClientGM* netGM = 
		static_cast<CSocketClientGM*>(GetGameManager()->GetComponentByName("ClientNetworkComponent"));	

	dtCore::RefPtr<MsgOrder> msg;
//	MessageFactory& msgFactory = GetGameManager()->GetMessageFactory();

	switch (toSendType)
	{
		case TO_SEND_THROTTLE:
			std::cout<<"didJoystickComponent::Send: ORDER = THROTTLE VAL = "<<value<<std::endl;
			//std::cout<<"didJoystickComponent::Send: mLastThrottle1 = "<<mLastThrottle1<<std::endl;
			//std::cout<<"didJoystickComponent::Send: mLastThrottle2 = "<<mLastThrottle2<<std::endl;
			GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::ORDER_EVENT, msg);

			msg->SetVehicleID(mAttachedVehicleID);
			msg->SetOrderID(ORD_THROTTLE);
			msg->SetFloatValue(value);
			//msg->SetFloatValue(18); // BAWE: TEST HARD CODED VALUE
			GetGameManager()->SendNetworkMessage(*msg.get());
			break;

		case TO_SEND_RUDDER:
			std::cout<<"didJoystickComponent::Send: ORDER = RUDDER VAL = "<<value<<std::endl;
			//std::cout<<"didJoystickComponent::Send: mLastSteer = "<<mLastSteer<<std::endl;
			GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::ORDER_EVENT, msg);

			msg->SetVehicleID(mAttachedVehicleID);
			msg->SetOrderID(ORD_RUDDER);
			msg->SetFloatValue(value);
			GetGameManager()->SendNetworkMessage(*msg.get());
			break;

		case TO_SEND_ADD_ANGLE:
			std::cout<<"didJoystickComponent::Send: ORDER = ADD_ANGLE VAL = "<<value<<std::endl;
			GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::ORDER_EVENT, msg);

			msg->SetVehicleID(mAttachedVehicleID);
			msg->SetOrderID(ORD_ADDANGLE);
			msg->SetFloatValue(value);
			GetGameManager()->SendNetworkMessage(*msg.get());
			break;

		case TO_SEND_ADD_FORCE:
			std::cout<<"didJoystickComponent::Send: ORDER = ADD_FORCE VAL = "<<value<<std::endl;
			GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::ORDER_EVENT, msg);

			msg->SetVehicleID(mAttachedVehicleID);
			msg->SetOrderID(ORD_ADDFORCE);
			msg->SetFloatValue(value);
			GetGameManager()->SendNetworkMessage(*msg.get());
			break;

		default:
			std::cout<<"didJoystickComponent::Send: Type not found. " \
			<< std::endl;
			break;
	}
}

/**
 * Calculate the throttle speed (throttle 1 + throttle 2) and the angle that will be resulted from calculation of the throttle vectors. 
 *
 */
void didJoystickComponent::CalcThrottle(double &speed, double &angle)
{
	double speedKiri, speedKanan;
	int iSpeedKiri, iSpeedKanan;

	double currThrottle1 = CheckForcedZero(AXIS_THROTTLE_1)? 0 : mLastThrottle1;
	double currThrottle2 = CheckForcedZero(AXIS_THROTTLE_2)? 0 : mLastThrottle2;

	//double currThrottle1 =  mLastThrottle1;
	//double currThrottle2 =  mLastThrottle2;


	int tempAhead = (int) mShipPhysics.mMaxAhead * 1000 / 2;
	int tempAstern = (int) mShipPhysics.mMaxAstern * 1000 / 2;
	
	//Throttle 1 / kiri
	if ( currThrottle1 >= 0 )
	{
		iSpeedKiri = currThrottle1 * tempAhead;
	}
	else
	{
		iSpeedKiri = currThrottle1 * tempAstern * -1;
	}

	//Throttle 2 / kanan
	if ( currThrottle2 >= 0 )
	{
		iSpeedKanan = currThrottle2 * tempAhead;
	}
	else
	{
		iSpeedKanan = currThrottle2 * tempAstern * -1;
	}

	iSpeedKiri = iSpeedKiri / 100;
	iSpeedKanan = iSpeedKanan / 100;

	speedKiri = (double) iSpeedKiri / 10;
	speedKanan = (double) iSpeedKanan / 10;

	//Calculate the throttle
	double A = 2 * ((180 / osg::PI) * (std::atan((mShipPhysics.mWidth / 2) / (mShipPhysics.mLength / 2))));

    double st1 = (90 - (A / 2));
    double st2 = (90 + (A / 2));

    double stt1 = cos(osg::DegreesToRadians(st1));
    double stt2 = cos(osg::DegreesToRadians(st2));
    double stt3 = sin(osg::DegreesToRadians(st1));
    double stt4 = sin(osg::DegreesToRadians(st2));

    double vX1 = (speedKiri * stt1);
    double vX2 = (speedKanan * stt2);
    double vY1 = (speedKiri * stt3);
    double vY2 = (speedKanan * stt4);

	double sX = vX1 + vX2;
    double sY = vY1 + vY2;

	double Total;
    if (sY < 0) 
      Total = (sqrt((sX*sX) +(sY*sY)) * -1);
    else
      Total = sqrt((sX*sX) +(sY*sY));

	double sdtArah;
    if ((speedKiri) == (speedKanan)) 
      sdtArah = 89.363;
    else
      sdtArah = (sY / sX);

	double Arah = osg::RadiansToDegrees(std::atan((sdtArah)));

	double addRudder;
    if (abs(speedKiri) == abs(speedKanan))
      addRudder = 0;
    else
      addRudder = abs(90 - abs(Arah));

	//speed = Total;
	speed = ( Total > 0.7f || Total < -0.7f )? Total : 0.0f;
    if (Arah >= 0)
      angle = addRudder;
    else
      angle = -addRudder;

//std::cout<<"didJoystickComponent::CalcThrottle: speed = "<<speed<<std::endl;
//std::cout<<"didJoystickComponent::CalcThrottle: angle = "<<angle<<std::endl;
}

/**
 * Calculate the angle from the steer
 *
 */
void didJoystickComponent::CalcSteer(double &angle)
{

	int iAngle;
	double currSteer = CheckForcedZero(AXIS_RUDDER)? 0 : mLastSteer;

	int tempSteer = (int) mShipPhysics.mMaxSteer * 1000;

	iAngle = currSteer * tempSteer * -1;
	angle  = (double) iAngle / 1000;

}

////-- Generic Methods
////-------------------------------------------------------------------------------