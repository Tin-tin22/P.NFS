//++ Includes
#include "didJoystickTDS.h"
#include "../didNetwork/SocketClientGM.h"
#include "../didNetwork/SimTCPDataTypes.h"
#include "../didCommon/SimMessages.h"
#include "../didCommon/SimMessageType.h"
#include "../didUtils/utilityfunctions.h"

#include "../LogiWheelUnspring/stdafx.h"
#include "../LogiWheelUnspring/LogiControllerInput.h"
#include "../LogiWheelUnspring/LogiControllerProperties.h"
#include "../LogiWheelUnspring/LogiWheel.h"

#include <iostream>
#include <math.h>

#include <osg/math>
#include <osgviewer/api/win32/graphicswindowwin32>

#include <dtUtil/mathdefines.h>
#include <dtGame/messagefactory.h>
#include <dtCore/deltawin.h>

#define _WINSOCKAPI_
#ifndef WIN32_LEAN_AND_MEAN
#define WIN32_LEAN_AND_MEAN
#endif
#include <dtUtil/mswin.h>
#pragma comment(lib, "ws2_32.lib")

//++ Constants

const std::string	didJoystickTDS::DEVICE_NAME_TDS_1	= "usb pad";						///< The Device name for the rudder type joystick
const std::string	didJoystickTDS::DEVICE_NAME_TDS_2	= "Microsoft PC-joystick driver";	///< The Device name for the rudder type joystick

const double	didJoystickTDS::UNINITIALIZED_AXIS	= -1.5259021893143654e-005;
const float		didJoystickTDS::MAX_DT_ACK			= 1.0; //Delta Time max acknowledge for sending the joystick messages
const int		didJoystickTDS::AXIS_UP_DOWN		= 1;
const int		didJoystickTDS::AXIS_LEFT_RIGHT		= 0;

//-- Constants

////// Constructor
didJoystickTDS::didJoystickTDS(const std::string& name)
      : Parent(name)
      , mLogger(dtUtil::Log::GetInstance("didJoystickTDS.cpp"))
	  , mAttachedVehicleID(-1)
	  , mIsRunning(false)
	  , mLastUPDown(UNINITIALIZED_AXIS)
	  , mLastSteer(UNINITIALIZED_AXIS)
	  , mActiveType(ATTACK)
{
	mJoystickTypes.clear();
}

////// Destructor
didJoystickTDS::~didJoystickTDS( )
{
}


void didJoystickTDS::ProcessMessage(const dtGame::Message& msg)
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
		/*ShipModelActorProxy* attachedActorProxy;

		GetGameManager()->FindActorByName(mAttachedVehicleName, attachedActorProxy);
		ShipModelActor* actor = dynamic_cast<ShipModelActor*> (attachedActorProxy->GetActor());
		mAttachedVehicleID = actor->GetVehicleID();*/

   
		//SetActiveType((eJoystickType)actor->GetControlType());

		mIsRunning = true ;
	}
}

void didJoystickTDS::OnAddedToGM( )
{
	LogiUnspring();
	dtInputPLIB::Joystick::CreateInstances();

	if (dtInputPLIB::Joystick::GetInstanceCount() > 0)
	{
		std::cout<<"\ndidJoystickTDS::didJoystickTDS: Joystick found. " \
		<< std::endl;

		for (int instance = 0; instance < dtInputPLIB::Joystick::GetInstanceCount(); ++instance)
		{
			const std::string joystickName = dtInputPLIB::Joystick::GetInstance(instance)->GetDeviceName();
			std::cout<<"\ndidJoystickTDS::didJoystickTDS: DEVICE NAME["<< instance <<"] = "<< dtInputPLIB::Joystick::GetInstance(instance)->GetDeviceName() <<". " \
			<< std::endl;                                                                                                                                                                                                                                                                          
			if ( joystickName == DEVICE_NAME_TDS_1 || joystickName == DEVICE_NAME_TDS_2 )
				mJoystickTypes[ATTACK] = instance;
		}

		mJoystickFound = true;
	}
	else
	{
		mJoystickFound = false;
		std::cout<<"\ndidJoystickTDS::didJoystickTDS: CANNOT FIND JOYSTICK INSTANCE! CHECK THE CABLE OF THE JOYSTICK. " \
		<< std::endl;
	}
}

void didJoystickTDS::OnRemovedFromGM( )
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
void didJoystickTDS::LogiUnspring( )
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
 
void didJoystickTDS::SetIsRunning( const bool run )
{
	mIsRunning = run ;
}

void didJoystickTDS::Init( const int mVehicleID, const int mWeaponID ,const int mLauncherID )
{
	mAttachedVehicleID   = mVehicleID;
	mAttachedWeaponID    = mWeaponID; 
	mAttachedLauncherID  = mLauncherID; 
}
 
void didJoystickTDS::Tick(float dt)
{
	
    if (!GetGameManager()->IsPaused() && mJoystickFound && mAttachedVehicleID > -1)  
	{
		double axisUPDown;
		double axisLeftRight;

		dtInputPLIB::Joystick::PollInstances();
		 
		if (mActiveType == ATTACK)
		{
			axisUPDown		  = dtInputPLIB::Joystick::GetInstance(mJoystickTypes[ATTACK])->GetAxis(AXIS_UP_DOWN)->GetState();
			axisLeftRight     = dtInputPLIB::Joystick::GetInstance(mJoystickTypes[ATTACK])->GetAxis(AXIS_LEFT_RIGHT)->GetState();
			bool btnFire      = dtInputPLIB::Joystick::GetInstance(mJoystickTypes[ATTACK])->GetButton(0)->GetState();

			int scLR = 127;
			int scUD = 127 ;

			int tempInt			= (int) (axisUPDown * 100);
			if ( tempInt >=0 )
			    axisUPDown		= (int) ((((double) tempInt) / 100 ) * scUD );
			else
				axisUPDown		= (int) (-1 * ( abs((((double) tempInt)/100) * scUD )))  ;
			
			tempInt				= (int) (axisLeftRight * 100);
			if ( tempInt >=0 )
			    axisLeftRight	= (int) ((((double) tempInt) / 100 ) * scLR ) ;
			else
				axisLeftRight	= (int) (-1 * ( abs((((double) tempInt)/100) * scLR )))  ;

			if (!(axisUPDown == mLastUPDown))
			{
				mLastUPDown = axisUPDown ;
				Send(TO_SEND_UP_DOWN, axisUPDown);
				std::cout<<"Joystick UP-DOWN "<<mLastUPDown<< std::endl;
			} 
			if (!(axisLeftRight == mLastSteer))
			{
				mLastSteer = axisLeftRight ;
				Send(TO_SEND_LEFT_RIGHT, -mLastSteer);
				std::cout<<"Joystick LEFT-RIGHT "<<mLastSteer<< std::endl;
			}  
			
			if ( btnFire ) Send(TO_SEND_FIRE,0);
			
		}
	}

}
 
void didJoystickTDS::Send(int toSendType, float value)
{
	if ( mIsRunning )
	{
		CSocketClientGM* netGM =  static_cast<CSocketClientGM*>(GetGameManager()->GetComponentByName("ClientNetworkComponent"));	

		if (( mAttachedWeaponID == CT_CANNON_120 )||( mAttachedWeaponID == CT_CANNON_76 )||( mAttachedWeaponID == CT_CANNON_57 )||
			( mAttachedWeaponID == CT_CANNON_40 ))
		{
			static int MNum(0);
			MNum = MNum + 1;

			dtCore::RefPtr<MsgSetCannon> msg;
			GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::CANNON_EVENT, msg);
			msg->SetVehicleID(mAttachedVehicleID);
			msg->SetWeaponID(mAttachedWeaponID);
			msg->SetLauncherID(mAttachedLauncherID);
			msg->SetMissileID(1);
			msg->SetMissileNum(MNum);
			msg->SetUpDown(value);
			msg->SetModeID(1);

			switch (toSendType)
			{
				case TO_SEND_FIRE		: msg->SetOrderID(ORD_CANNON_DIRECT_F); break ;
				case TO_SEND_UP_DOWN	: msg->SetOrderID(ORD_CANNON_DIRECT_UD); break ;
				case TO_SEND_LEFT_RIGHT	: msg->SetOrderID(ORD_CANNON_DIRECT_LR); break ;
			}

			GetGameManager()->SendNetworkMessage(*msg.get());
			GetGameManager()->SendMessage(*msg.get());

		} else if ( mAttachedWeaponID == CT_MISTRAL )
		{
			static int MNum(0);
			MNum = MNum + 1;

			dtCore::RefPtr<MsgSetMistral> msg;
			GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::MISTRAL_EVENT, msg);
			msg->SetVehicleID(mAttachedVehicleID); 
			msg->SetWeaponID(mAttachedWeaponID);
			msg->SetLauncherID(mAttachedLauncherID);
			msg->SetMissileID(1);
			msg->SetMissileNum(MNum);
			msg->SetTargetBearing(value);
			switch (toSendType)
			{
				case TO_SEND_FIRE		: msg->SetOrderID(ORD_MISTRAL_DIRECT_F);break ;
				case TO_SEND_UP_DOWN	: msg->SetOrderID(ORD_MISTRAL_DIRECT_UD);break ;
				case TO_SEND_LEFT_RIGHT	: msg->SetOrderID(ORD_MISTRAL_DIRECT_LR);break ;
			}
			GetGameManager()->SendNetworkMessage(*msg.get());
			GetGameManager()->SendMessage(*msg.get());

		} else if ( mAttachedWeaponID == CT_STRELA )
		{
			static int MNum(0);
			MNum = MNum + 1;

			dtCore::RefPtr<MsgSetStrela> msg;
			GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::STRELA_EVENT, msg);
			msg->SetVehicleID(mAttachedVehicleID);
			msg->SetWeaponID(mAttachedWeaponID);
			msg->SetLauncherID(mAttachedLauncherID);
			msg->SetMissileID(1);
			msg->SetMissileNum(MNum);
			msg->SetTargetBearing(value);
			switch (toSendType)
			{
				case TO_SEND_FIRE		: msg->SetOrderID(ORD_STRELA_DIRECT_F);break ;
				case TO_SEND_UP_DOWN	: msg->SetOrderID(ORD_STRELA_DIRECT_UD);break ;
				case TO_SEND_LEFT_RIGHT	: msg->SetOrderID(ORD_STRELA_DIRECT_LR);break ;
			}
			GetGameManager()->SendNetworkMessage(*msg.get());
			GetGameManager()->SendMessage(*msg.get());

		} else if ( mAttachedWeaponID == CT_TETRAL )
		{
			static int MNum(0);
			MNum = MNum + 1;

			dtCore::RefPtr<MsgSetTetral> msg;
			GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::TETRAL_EVENT, msg);
			msg->SetVehicleID(mAttachedVehicleID);
			msg->SetWeaponID(mAttachedWeaponID);
			msg->SetLauncherID(mAttachedLauncherID);
			msg->SetMissileID(1);
			msg->SetMissileNum(MNum);
			msg->SetTargetBearing(value);
			switch (toSendType)
			{
				case TO_SEND_FIRE		: msg->SetOrderID(ORD_TETRAL_FIRE);break ;
				case TO_SEND_UP_DOWN	: msg->SetOrderID(ORD_TETRAL_DIRECT_UD);break ;
				case TO_SEND_LEFT_RIGHT	: msg->SetOrderID(ORD_TETRAL_DIRECT_LR);break ;
			}
			GetGameManager()->SendNetworkMessage(*msg.get());
			GetGameManager()->SendMessage(*msg.get());
		}

	

	}
}
 