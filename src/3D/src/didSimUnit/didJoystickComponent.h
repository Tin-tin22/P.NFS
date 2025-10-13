// $Id: didJoystickComponent.h

/**
 * @file didJoystickComponent.h
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
#ifndef _DID_JOYSTICK_COMP_H_
#define _DID_JOYSTICK_COMP_H_

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


//++ BAWE-20100930: didJoystickComponent class
/**
 * @class didJoystickComponent didJoystickComponent.h
 *
 * @brief The class for the joystick component
 *
 * The component is used to manage all inputs from joystick.
 */
//class DID_DLL_EXPORT didJoystickComponent : public dtGame::GMComponent
class didJoystickComponent : public dtGame::GMComponent
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
			TO_SEND_THROTTLE,
			TO_SEND_RUDDER,
			TO_SEND_ADD_ANGLE,
			TO_SEND_ADD_FORCE
		};

		//++ BAWE-20101202: JOYSTICK_TYPE
		/**
		 * Joystick instance type enum. 
		 * 
		 *
		 */
		enum eJoystickType
		{
			RUDDER,
			STEER
		};
		//-- BAWE-20101202: JOYSTICK_TYPE

		///////////////////////////////////////////////////////////////////
		// Structs
		/**
		 * Forced Zero struct for the constant values of each forced zero / center value boundary. 
		 * 
		 * Joystick can't detect whether the we are at the center of the axis or not. 
		 * The value of the center of the axis is not always 0. Even the value is different between after the axis is increased or decreased.
		 * That's why we use some kind of boundary that would be checked against with and the axis will always send 0 if it's iside the boundary.
		 * Will be checked based on the AxisMovement enum of the axis. The value is always static const double and defined in the source file.
		 *
		 */
		struct sForcedZero
		{
			static const double THROTTLE_1_UNINITIALIZED;	///< The forced zero value if the axis = throttle 1, and the state is MOVE_UNINITIALIZED (when the joystick is at the initial stage, the value is always -1.5259021893143654e-005)
			static const double THROTTLE_2_UNINITIALIZED;	///< The forced zero value if the axis = throttle 2, and the state is MOVE_UNINITIALIZED (when the joystick is at the initial stage, the value is always -1.5259021893143654e-005)
			static const double RUDDER_UNINITIALIZED;		///< The forced zero value if the axis = steer, and the state is MOVE_UNINITIALIZED (when the joystick is at the initial stage, the value is always -1.5259021893143654e-005)

			static const double THROTTLE_1_INCREASE;	///< The forced zero value if the axis = throttle 1, and the state is MOVE_INCREASE
			static const double THROTTLE_2_INCREASE;	///< The forced zero value if the axis = throttle 2, and the state is MOVE_INCREASE
			static const double RUDDER_INCREASE;		///< The forced zero value if the axis = steer, and the state is MOVE_INCREASE

			static const double THROTTLE_1_DECREASE;	///< The forced zero value if the axis = throttle 1, and the state is MOVE_DECREASE
			static const double THROTTLE_2_DECREASE;	///< The forced zero value if the axis = throttle 2, and the state is MOVE_DECREASE
			static const double RUDDER_DECREASE;		///< The forced zero value if the axis = steer, and the state is MOVE_DECREASE
		};

		/**
		 * Ship's physics struct.
		 * 
		 */
		//++ BAWE-20101125: PHYSICS_ATTRIBUTE
		struct sShipPhysics
		{
			float mLength;
			float mWidth;
			float mHeight;
			float mMaxAhead;
			float mMaxAstern;
			float mMaxSteer;

			//Ctor
			sShipPhysics()
				: mLength(100.0f)
				, mWidth(5.0f)
				, mHeight(20.0f)
				, mMaxAhead(30.0f)
				, mMaxAstern(-24.0f)
				, mMaxSteer(45.0f)
			{
			};
		};
		//-- BAWE-20101125: PHYSICS_ATTRIBUTE
		///////////////////////////////////////////////////////////////////
		// Constants
		//++ BAWE-20101202: JOYSTICK_TYPE
		static const std::string	DEVICE_NAME_RUDDER_1;		///< The Device name for the rudder type joystick
		static const std::string	DEVICE_NAME_RUDDER_2;		///< The Device name for the rudder type joystick
		static const std::string	DEVICE_NAME_STEER_1;	///< The Device name for the steering wheel type joystick (1st version)
		static const std::string	DEVICE_NAME_STEER_2;	///< The Device name for the steering wheel type joystick (2nd version)
		//-- BAWE-20101202: JOYSTICK_TYPE

		static const double		UNINITIALIZED_AXIS;			///< Uninitialized 
		static const float		MAX_DT_ACK;					///< The maximum DT acknowledge value before a state can be changed from STATE_CHANGING to STATE_ACKNOWLEDGED

		//Axis indices constants
		static const int		AXIS_THROTTLE_1;
		static const int		AXIS_THROTTLE_2;
		static const int		AXIS_STEER;
		static const int		AXIS_RUDDER;

		//++ BAWE-20100922: HACK MANIA! HACK MANIA! HACK MANIA! HACKED HARD CODED CONSTANT VALUES
		//static const double		HACK_CONST_SHIP_LENGTH;		///< Panjang kapal
		//static const double		HACK_CONST_SHIP_WIDTH;		///< Lebahr kapal
		//static const double		HACK_CONST_MAX_AHEAD;		///< Max forward speed
		//static const double		HACK_CONST_MAX_ASTERN;		///< Max backward speed
		//static const double		HACK_CONST_MAX_STEER_ANGLE;	///< Max steer angle
		//-- BAWE-20100922: HACK MANIA! HACK MANIA! HACK MANIA! HACKED HARD CODED CONSTANT VALUES


		///////////////////////////////////////////////////////////////////
		// Ctor & Dtor
        didJoystickComponent(const std::string& name = "didJoystickComponent");
		~didJoystickComponent(void);

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
		void Init( const std::string& attachedVehicleName		///< The name of the vehicle that this joystick component will affect.
				);

		//++ BAWE-20101202: JOYSTICK_TYPE
		/**
		 *
		 *
		 */
		inline void SetActiveType( eJoystickType type		///< The name of the vehicle that this joystick component will affect.
				)
		{
			if (type == RUDDER || type == STEER)
				mActiveType = type;
std::cout<<"\ndidJoystickComponent::didJoystickComponent: CURRENT DEVICE TYPE =";
type == RUDDER? (std::cout<< " RUDDER. "<< std::endl):(std::cout<< " STEER. "<< std::endl); 
		}
		//-- BAWE-20101202: JOYSTICK_TYPE

		inline void TestMaju()
		{
			Send(TO_SEND_THROTTLE, 20.0f);

		}

		inline void TestAddForce()
		{
			Send(TO_SEND_THROTTLE, 20.0f);

		}
		


	// Private methods
	private:
		/**
		 * Called to process the onTick routines. For this component it's the pooling of joystick events.
		 */
		void Tick(float dt);

		/**
		 * Check whether or not the component will have to send a new input message 
		 *
		 */
		void CheckSendMessage();

		/**
		 * Send a network message based on the type. 
		 *
		 */
		void Send(int toSendType, float value);

		/**
		 * Check if the joystick is currently at the forced 0 position or not. 
		 * NOTE: Joystick dodolz yang menyusahkan programmer. Knapa ga bisa 0 atau mendekati 0 kalo lagi center / di tengah2 aja seh? -_____-"
		 *
		 */
		bool CheckForcedZero(int axis);

		/**
		 * Calculate the throttle speed (throttle 1 + throttle 2) and the angle that will be resulted from calculation of the throttle vectors. 
		 *
		 */
		void CalcThrottle(double &speed, double &angle);

		/**
		 * Calculate the angle from the steer
		 *
		 */
		void CalcSteer(double &angle);




	// MEMBERS!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	// Protected Members
	protected:
		dtUtil::Log& mLogger;

	// Private Members
	private:
		bool			mJoystickFound;

		//++ BAWE-20101202: JOYSTICK_TYPE
		std::map <eJoystickType, int>	mJoystickTypes; 
		eJoystickType	mActiveType;
		//-- BAWE-20101202: JOYSTICK_TYPE

		int				mAttachedVehicleID;
		std::string		mAttachedVehicleName;

		//The last value of the axis input that will be checked for any changes
		double			mLastThrottle1;
		double			mLastThrottle2;
		double			mLastSteer;

		//The state of each axis
		eAxisState		mStateThrottle1;
		eAxisState		mStateThrottle2;
		eAxisState		mStateSteer;

		//The state of each axis
		eAxisMovement	mMovementThrottle1;
		eAxisMovement	mMovementThrottle2;
		eAxisMovement	mMovementSteer;

		//The changing-to-acknowledge delta time to determine whether the state should be changed from STATE_CHANGING to STATE_ACKNOWLEDGED after a period of time with no axis value changing
		float			mDTAckThrottle1;
		float			mDTAckThrottle2;
		float			mDTAckSteer;

		//ForcedZero constant struct
		sForcedZero		mForcedZero;

		//ShipPhysics struct
		sShipPhysics		mShipPhysics; // BAWE-20101125: PHYSICS_ATTRIBUTE
};


//-- BAWE-20100930: didCameraControlComponent class

#endif
//-- BAWE-20100927: Include guard