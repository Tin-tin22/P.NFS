/*
***
*** File           : $Workfile: SimSerialControl.h $
*** Version        : $Revision: 1  $
*** Date		   : 2012.05.14 
*** Sam
*** 
*/

#ifndef _SIM_SERIAL_CONTROL_H
#define _SIM_SERIAL_CONTROL_H

#include <dtUtil/log.h>
#include <dtGame/basemessages.h>
#include <dtGame/messagetype.h>
#include <dtGame/message.h>
#include <dtGame/gmcomponent.h>

#include <iostream>
#include <stdio.h>
#include <string.h>

class simSerialControl : public dtGame::GMComponent
{
	public:
		simSerialControl(void);
		~simSerialControl(void);

		virtual void ProcessMessage(const dtGame::Message& msg); 
		virtual void OnAddedToGM();	
		virtual void OnRemovedFromGM();

		dtCore::RefPtr<dtDAL::ActorProxy> GetShipActorByID(int mVehicleID );

		void SetIsRunning( const bool run );
		void Init(  const int mVehicleID, const int mWeaponID ,const int mLauncherID,
			const int mSerialPort, const int mSerialBaudRate, const int mSerialData,
			const int mInitFirstPitch, const int mInitFirstHeading, const int mInitFire,
			const int mInitLock, const bool mShOutConsole );

	private:
		 
		void RunLocal(float dt);

		void CameraCommand(int toSendType,float val);
		void TDSActorCommand(int toSendType, float val);
		void SendDataToCannon();
		

	protected:
		dtUtil::Log& mLogger;

		//////////////////////////////////////////////////////////////////////////
		 
		//////////////////////////////////////////////////////////////////////////

	private:

		enum eToSendType
		{
			TO_SEND_ELEVATION,
			TO_SEND_BEARING,
			TO_SEND_FIRE
		};

		bool			mShowOuputConsole;

		bool			mIsControlled;

		bool			mJoystickFound;
		bool			mIsRunning;
		bool			mIsSerialPortOpened;
		
		int				mAttachedSerialPort;
		int				mAttachedSerialBaudRate;
		int				mAttachedSerialData;

		int				mAttachedVehicleID;
		int				mAttachedWeaponID;
		int				mAttachedLauncherID;
		
		int				mAttachedFirstPitch;
		int				mAttachedFirstHeading;
		int				mAttachedInitFire;
		int				mAttachedInitLock;

		int				mLastBearing;
		int				mLastElevation;

		std::string		sLastInput ;


		int __OpenComport(int, int, int);
		int __PollComport(int, unsigned char *, int);
		int __SendByte(int, unsigned char);
		int __SendBuf(int, unsigned char *, int);
		int __IsCTSEnabled(int);
		
		void __CloseComport(int);
		void __cprintf(int, const char *);
		
};


#endif