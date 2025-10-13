// $Id: didJoystickComponent.h

/**
 * @file didJoystickTDS.h
 * CopyFrom @file didJoystickComponent.h
 *
 * @author Bawenang R. P. P.
 *
 * @date August 27th, 2010
 *
 * @brief The header file for didJoystickComponent component.
 *
 * didJoystickComponent is the component that manages / control the inputs from ship simulator joystick.
 * Currently there's 4 inputs from the ship simulator joystick. The 1st and 2nd engine throttles, the steer, and buttons.
 * If the component detected any changes from any of them, it will send a corresponding message to the game.
 *
 */

//++ BAWE-20100927: Include guard
#ifndef _DID_JOYSTICK_TDS_H_
#define _DID_JOYSTICK_TDS_H_

#ifndef WIN32_LEAN_AND_MEAN
#define WIN32_LEAN_AND_MEAN
#endif

//++ BAWE-20101025: LEAK DETECTION
#ifdef USE_VLD

#include <vld.h>

#endif
//++ BAWE-20101025: LEAK DETECTION

//++ Includes
#include "Export.h"
#include <dtUtil/log.h>
#include <dtGame/basemessages.h>
#include <dtGame/messagetype.h>
#include <dtGame/message.h>
#include <dtGame/gmcomponent.h>

#include <dtInputPLIB/joystick.h>
#include <iostream>
//-- Includes


#define FC_DTRDSR       0x01
#define FC_RTSCTS       0x02
#define FC_XONXOFF      0x04
#define ASCII_BEL       0x07
#define ASCII_BS        0x08
#define ASCII_LF        0x0A
#define ASCII_CR        0x0D
#define ASCII_XON       0x11
#define ASCII_XOFF      0x13
 
class didJoystickTDS : public dtGame::GMComponent
{
	// METHODS!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	// Public Methods
	public:
		///////////////////////////////////////////////////////////////////
		// Parent Typedef
		typedef dtGame::GMComponent Parent;

		///////////////////////////////////////////////////////////////////
		// Enums
		/**
		 * Axis state enum. 
		 * 
		 * To check whether the axis is idle, still changing the value, or the value is acknowledged and ready to be sent.
		 *
		 */
		enum eAxisState 
		{
			STATE_IDLE,
			STATE_CHANGING,
			STATE_ACKNOWLEDGED,
            STATE_IGNORE
		};

		/**
		 * Axis movement state enum. 
		 * 
		 * To check whether the axis's change is increased or decreased. Only applicable if the axis state = STATE_CHANGING.
		 *
		 */
		enum eAxisMovement
		{
			MOVE_UNINITIALIZED,
			MOVE_INCREASE,
			MOVE_DECREASE
		};

		/**
		 * The to send type enum.
		 * 
		 * To choose between sending THROTTLE, STEER, OR ADD_ANGLE (the angle that was made from throttle change) to the server / from
		 *
		 */
		enum eToSendType
		{
			TO_SEND_UP_DOWN,
			TO_SEND_LEFT_RIGHT,
			TO_SEND_FIRE
		};

		enum eJoystickType
		{
			//RUDDER,
			//STEER,
			ATTACK
		};
		///////////////////////////////////////////////////////////////////
		 
		struct sForcedZero
		{
			static const double UPDOWN_UNINITIALIZED;	///< The forced zero value if the axis = throttle 1, and the state is MOVE_UNINITIALIZED (when the joystick is at the initial stage, the value is always -1.5259021893143654e-005)
			static const double RUDDER_UNINITIALIZED;		///< The forced zero value if the axis = steer, and the state is MOVE_UNINITIALIZED (when the joystick is at the initial stage, the value is always -1.5259021893143654e-005)

			static const double UPDOWN_INCREASE;	    ///< The forced zero value if the axis = throttle 1, and the state is MOVE_INCREASE
			static const double RUDDER_INCREASE;		///< The forced zero value if the axis = steer, and the state is MOVE_INCREASE

			static const double UPDOWN_DECREASE;	   ///< The forced zero value if the axis = throttle 1, and the state is MOVE_DECREASE
			static const double RUDDER_DECREASE;		///< The forced zero value if the axis = steer, and the state is MOVE_DECREASE
		};

		 
		// Constants
		static const std::string	DEVICE_NAME_TDS_1;		///< The Device name for the rudder type joystick
		static const std::string	DEVICE_NAME_TDS_2;		///< The Device name for the rudder type joystick

		static const double		UNINITIALIZED_AXIS;			///< Uninitialized 
		static const float		MAX_DT_ACK;					///< The maximum DT acknowledge value before a state can be changed from STATE_CHANGING to STATE_ACKNOWLEDGED

		//Axis indices constants
		static const int		AXIS_UP_DOWN;
		static const int		AXIS_LEFT_RIGHT;


		///////////////////////////////////////////////////////////////////
		// Ctor & Dtor
        didJoystickTDS(const std::string& name = "didJoystickTDS");
		~didJoystickTDS(void);

		///////////////////////////////////////////////////////////////////
		// Inherited Methods

		/**
		 * Function called by a GameManager to process Messages. This function forwards the connection related
		 * messages to the functions processing these messages.
		 * 
		 * @param The Message to be processed
		 */        
		virtual void ProcessMessage(const dtGame::Message& msg); 

		/**
		 * Called when this component is added to the Game Manager
		 */
		virtual void OnAddedToGM();	

		/**
		 * Called when this component is removed from the Game Manager
		 */
		virtual void OnRemovedFromGM();

		///////////////////////////////////////////////////////////////////
		// Class Generic Methods

		/**
		 *
		 *
		 */
		void LogiUnspring( );

		/**
		 *
		 *
		 */

		void SetIsRunning( const bool run );

		void Init( const int mVehicleID, const int mWeaponID , const int mLauncherID );

		inline void SetActiveType( eJoystickType type		///< The name of the vehicle that this joystick component will affect.
				)
		{
			if (type == ATTACK ) 
			{
				mActiveType = type;
				std::cout<<"didJoystickTDS: CURRENT DEVICE TYPE = ATTACK"<< std::endl ; 
			}
		}
		 
		


	// Private methods
	private:
		/**
		 * Called to process the onTick routines. For this component it's the pooling of joystick events.
		 */
		void Tick(float dt);

		void Send(int toSendType, float value);

	protected:
		dtUtil::Log& mLogger;

	private:
		bool			mJoystickFound;
		bool			mIsRunning;

		std::map <eJoystickType, int>	mJoystickTypes; 
		eJoystickType	mActiveType;

		int				mAttachedVehicleID;
		//std::string		mAttachedVehicleName;
		int				mAttachedWeaponID;
		int				mAttachedLauncherID;

		//The last value of the axis input that will be checked for any changes
		double			mLastUPDown;
		double			mLastSteer;


 
};


#endif
