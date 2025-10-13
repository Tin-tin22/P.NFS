/*
***
*** File           : $Workfile: SimSerialControl.cpp $
*** Version        : $Revision: 1  $
*** Date		   : 2012.05.14 
*** Sam
*** 
*/


#include "SimSerialControl.h"
#include "../didNetwork/SocketClientGM.h"
#include "../didNetwork/SimTCPDataTypes.h"
#include "../didCommon/SimMessages.h"
#include "../didCommon/SimMessageType.h"
#include "../didUtils/utilityfunctions.h"
#include "../didUtils/SimServerClientComponent.h"

#include "../didActors/StrelaRocketActor.h"
#include "../didActors/MistralRocketActor.h"
#include "../didActors/cannonspoutactor.h"

#include <iostream>
#include <math.h>
#include <winnt.h>

#include <osg/math>

#include <dtUtil/mathdefines.h>
#define _WINSOCKAPI_
#ifndef WIN32_LEAN_AND_MEAN
#define WIN32_LEAN_AND_MEAN
#endif
#include <dtUtil/mswin.h>
#pragma comment(lib, "ws2_32.lib")
#include <dtGame/messagefactory.h>

#include <boost/tokenizer.hpp>
#include <boost/foreach.hpp>

//-- constant 
const int MAX_PORT = 20 ;
const int MAX_SIZE = 4096 ;

HANDLE m_hComm;

HANDLE _cport[MAX_PORT];
char _comlist[MAX_PORT][10]=
	{
	"\\\\.\\COM1",  "\\\\.\\COM2",  "\\\\.\\COM3",  "\\\\.\\COM4",
	"\\\\.\\COM5",  "\\\\.\\COM6",  "\\\\.\\COM7",  "\\\\.\\COM8",
	"\\\\.\\COM9",  "\\\\.\\COM10", "\\\\.\\COM11", "\\\\.\\COM12",
	"\\\\.\\COM13", "\\\\.\\COM14", "\\\\.\\COM15", "\\\\.\\COM16",
	"\\\\.\\COM17", "\\\\.\\COM18", "\\\\.\\COM19", "\\\\.\\COM20",
	};

char baudr[64];
//-- constant 



simSerialControl::simSerialControl(void): 
	dtGame::GMComponent("simSerialControl")
	, mLogger(dtUtil::Log::GetInstance("simSerialControl.cpp"))
	, mAttachedVehicleID(-1)
	, mAttachedSerialPort(0)
	, mAttachedSerialBaudRate(9600)
	, mIsSerialPortOpened(false)
	, mIsRunning(false)
	, mShowOuputConsole(false)
	, foundDollar(false)
	, foundStar(false)
	, mIsControlled(false)
{
	
}

simSerialControl::~simSerialControl( )
{
	__CloseComport(mAttachedSerialPort);
}


int simSerialControl::__OpenComport(int comport_number, int baudrate, int data)
{
	if((comport_number > ( MAX_PORT - 1 ) )||( comport_number < 0 ))
	{
		printf("illegal port-control number ...");
		return(1);
	}

	if ( data == 8 )
	{
		switch(baudrate)
		{
		case     110 : strcpy(baudr, "baud=110 data=8 parity=N stop=1");
			break;
		case     300 : strcpy(baudr, "baud=300 data=8 parity=N stop=1");
			break;
		case     600 : strcpy(baudr, "baud=600 data=8 parity=N stop=1");
			break;
		case    1200 : strcpy(baudr, "baud=1200 data=8 parity=N stop=1");
			break;
		case    2400 : strcpy(baudr, "baud=2400 data=8 parity=N stop=1");
			break;
		case    4800 : strcpy(baudr, "baud=4800 data=8 parity=N stop=1");
			break;
		case    9600 : strcpy(baudr, "baud=9600 data=8 parity=N stop=1");
			break;
		case   19200 : strcpy(baudr, "baud=19200 data=8 parity=N stop=1");
			break;
		case   38400 : strcpy(baudr, "baud=38400 data=8 parity=N stop=1");
			break;
		case   57600 : strcpy(baudr, "baud=57600 data=8 parity=N stop=1");
			break;
		case  115200 : strcpy(baudr, "baud=115200 data=8 parity=N stop=1");
			break;
		case  128000 : strcpy(baudr, "baud=128000 data=8 parity=N stop=1");
			break;
		case  256000 : strcpy(baudr, "baud=256000 data=8 parity=N stop=1");
			break;
		default      : printf("invalid baudrate ... ");
			return(1);
			break;
		}

	}
	else if ( data == 10 )
	{
		switch(baudrate)
		{
		case     110 : strcpy(baudr, "baud=110 data=10 parity=N stop=1");
			break;
		case     300 : strcpy(baudr, "baud=300 data=10 parity=N stop=1");
			break;
		case     600 : strcpy(baudr, "baud=600 data=10 parity=N stop=1");
			break;
		case    1200 : strcpy(baudr, "baud=1200 data=10 parity=N stop=1");
			break;
		case    2400 : strcpy(baudr, "baud=2400 data=10 parity=N stop=1");
			break;
		case    4800 : strcpy(baudr, "baud=4800 data=10 parity=N stop=1");
			break;
		case    9600 : strcpy(baudr, "baud=9600 data=10 parity=N stop=1");
			break;
		case   19200 : strcpy(baudr, "baud=19200 data=10 parity=N stop=1");
			break;
		case   38400 : strcpy(baudr, "baud=38400 data=10 parity=N stop=1");
			break;
		case   57600 : strcpy(baudr, "baud=57600 data=10 parity=N stop=1");
			break;
		case  115200 : strcpy(baudr, "baud=115200 data=10 parity=N stop=1");
			break;
		case  128000 : strcpy(baudr, "baud=128000 data=10 parity=N stop=1");
			break;
		case  256000 : strcpy(baudr, "baud=256000 data=10 parity=N stop=1");
			break;
		default      : printf("invalid baudrate ... ");
			return(1);
			break;
		}

	}
	else if ( data == 12 )
	{
		switch(baudrate)
		{
		case     110 : strcpy(baudr, "baud=110 data=12 parity=N stop=1");
			break;
		case     300 : strcpy(baudr, "baud=300 data=12 parity=N stop=1");
			break;
		case     600 : strcpy(baudr, "baud=600 data=12 parity=N stop=1");
			break;
		case    1200 : strcpy(baudr, "baud=1200 data=12 parity=N stop=1");
			break;
		case    2400 : strcpy(baudr, "baud=2400 data=12 parity=N stop=1");
			break;
		case    4800 : strcpy(baudr, "baud=4800 data=12 parity=N stop=1");
			break;
		case    9600 : strcpy(baudr, "baud=9600 data=12 parity=N stop=1");
			break;
		case   19200 : strcpy(baudr, "baud=19200 data=12 parity=N stop=1");
			break;
		case   38400 : strcpy(baudr, "baud=38400 data=12 parity=N stop=1");
			break;
		case   57600 : strcpy(baudr, "baud=57600 data=12 parity=N stop=1");
			break;
		case  115200 : strcpy(baudr, "baud=115200 data=12 parity=N stop=1");
			break;
		case  128000 : strcpy(baudr, "baud=128000 data=12 parity=N stop=1");
			break;
		case  256000 : strcpy(baudr, "baud=256000 data=12 parity=N stop=1");
			break;
		default      : printf("invalid baudrate ... ");
			return(1);
			break;
		}

	}
	else if ( data == 16 )
	{
		switch(baudrate)
		{
		case     110 : strcpy(baudr, "baud=110 data=16 parity=N stop=1");
			break;
		case     300 : strcpy(baudr, "baud=300 data=16 parity=N stop=1");
			break;
		case     600 : strcpy(baudr, "baud=600 data=16 parity=N stop=1");
			break;
		case    1200 : strcpy(baudr, "baud=1200 data=16 parity=N stop=1");
			break;
		case    2400 : strcpy(baudr, "baud=2400 data=16 parity=N stop=1");
			break;
		case    4800 : strcpy(baudr, "baud=4800 data=16 parity=N stop=1");
			break;
		case    9600 : strcpy(baudr, "baud=9600 data=16 parity=N stop=1");
			break;
		case   19200 : strcpy(baudr, "baud=19200 data=16 parity=N stop=1");
			break;
		case   38400 : strcpy(baudr, "baud=38400 data=16 parity=N stop=1");
			break;
		case   57600 : strcpy(baudr, "baud=57600 data=16 parity=N stop=1");
			break;
		case  115200 : strcpy(baudr, "baud=115200 data=16 parity=N stop=1");
			break;
		case  128000 : strcpy(baudr, "baud=128000 data=16 parity=N stop=1");
			break;
		case  256000 : strcpy(baudr, "baud=256000 data=16 parity=N stop=1");
			break;
		default      : printf("invalid baudrate ... ");
			return(1);
			break;
		}

	}
	else 
		printf("invalid data port ... ");

	_cport[comport_number] = CreateFileA(_comlist[comport_number],
		GENERIC_READ/*|GENERIC_WRITE*/,
		0,                          /* no share  */
		0,                          /* no security */
		OPEN_EXISTING,
		0,                          /* no threads */
		NULL);                      /* no templates */

	if( _cport[comport_number]==INVALID_HANDLE_VALUE )
	{
		printf("unable to open port-control ... ");
		return(1);
	}

	DCB port_settings;
	memset(&port_settings, 0, sizeof(port_settings));  /* clear the new struct  */
	port_settings.DCBlength = sizeof(port_settings);

	port_settings.BaudRate = baudrate;
	port_settings.fDtrControl = DTR_CONTROL_ENABLE ;
	port_settings.fRtsControl = RTS_CONTROL_ENABLE ;
	port_settings.Parity = NOPARITY ;
	port_settings.StopBits = ONESTOPBIT ;
	port_settings.fBinary = 1;
	port_settings.ByteSize = 8;

	if(!BuildCommDCBA(baudr, &port_settings))
	{
		printf("unable to set port-control dcb settings ... ");
		CloseHandle(_cport[comport_number]);
		return(1);
	}

	if(!SetCommState(_cport[comport_number], &port_settings))
	{
		printf("unable to set port-control cfg settings ... ");
		CloseHandle(_cport[comport_number]);
		return(1);
	}

	COMMTIMEOUTS Cptimeouts;

	Cptimeouts.ReadIntervalTimeout         = MAXDWORD;
	Cptimeouts.ReadTotalTimeoutMultiplier  = 0;
	Cptimeouts.ReadTotalTimeoutConstant    = 0;
	Cptimeouts.WriteTotalTimeoutMultiplier = 0;
	Cptimeouts.WriteTotalTimeoutConstant   = 0;

	/*
	Cptimeouts.ReadIntervalTimeout = 1;
	Cptimeouts.ReadTotalTimeoutMultiplier = 1;
	Cptimeouts.ReadTotalTimeoutConstant = 1;
	Cptimeouts.WriteTotalTimeoutMultiplier = 1;
	Cptimeouts.WriteTotalTimeoutConstant = 1;
    */

	if(!SetCommTimeouts(_cport[comport_number], &Cptimeouts))
	{
		printf("unable to set port-control time-out settings ... ");
		CloseHandle(_cport[comport_number]);
		return(1);
	}

	return(0);
}

void simSerialControl::__CloseComport(int comport_number)
{
	CloseHandle(_cport[comport_number]);
}

int simSerialControl::__PollComport(int comport_number, unsigned char *buf, int size)
{
	int n;
	if( size > MAX_SIZE )  size = MAX_SIZE;
	ReadFile(_cport[comport_number], buf, size, (LPDWORD)((void *)&n), NULL);
	return(n);

	
	/*OVERLAPPED osReader = {0};
	DWORD dwRead;
	COMSTAT ComStat;
	osReader.hEvent = CreateEvent(NULL, TRUE, FALSE, NULL);

	if (osReader.hEvent == NULL)
		// Error creating overlapped event; abort.
		std::cout << "Error in creating Overlapped event" << std::endl;

	dwRead = (DWORD) ComStat.cbInQue;
	//if( limit < (int) dwRead ) dwRead = (DWORD) limit;

	//ReadFile(_cport[comport_number], buf, size, (LPDWORD)((void *)&n), &osReader);
	ReadFile(_cport[comport_number], buf, size, &dwRead, &osReader);

	return(n);*/
}

dtCore::RefPtr<dtDAL::ActorProxy> simSerialControl::GetMissileActors(const int mVehicleID, const int mWeaponID, const int mLauncherID, const int mMissileID, const int mMissileNum )
{
	if ( mMissileNum == 0 ) 
		return NULL ;

	dtCore::RefPtr<dtDAL::ActorProxy> proxy ;

	std::vector<dtGame::GameActorProxy *> fill;
	std::vector<dtGame::GameActorProxy *>::iterator iter;
	GetGameManager()->GetAllGameActors(fill);

	const std::string& actTypeName = GetActorWeaponTypeName(mWeaponID,C_WEAPON_TYPE_MISSILE);

	for (iter = fill.begin(); iter < fill.end(); iter++)
	{
		if (((*iter)->GetActorType().GetName()== actTypeName )) 
		{
			dtCore::RefPtr<dtDAL::ActorProperty> pVehicleID( (*iter)->GetProperty(C_SET_VID) );
			dtCore::RefPtr<dtDAL::IntActorProperty> ValVehicleID( static_cast<dtDAL::IntActorProperty*>( pVehicleID.get() ) );
			int shipID( ValVehicleID->GetValue() );
			if ( shipID == mVehicleID )
			{
				dtCore::RefPtr<dtDAL::ActorProperty> pWeaponID( (*iter)->GetProperty(C_SET_WID) );
				dtCore::RefPtr<dtDAL::IntActorProperty> ValWeaponID( static_cast<dtDAL::IntActorProperty*>( pWeaponID.get() ) );
				int wpnid( ValWeaponID->GetValue() );
				if ( wpnid == mWeaponID )
				{
					dtCore::RefPtr<dtDAL::ActorProperty> pLauncherID( (*iter)->GetProperty(C_SET_LID) );
					dtCore::RefPtr<dtDAL::IntActorProperty> ValLauncherID( static_cast<dtDAL::IntActorProperty*>( pLauncherID.get() ) );
					int lcid( ValLauncherID->GetValue() );
					if ( lcid == mLauncherID )
					{
						dtCore::RefPtr<dtDAL::ActorProperty> pMissileID( (*iter)->GetProperty(C_SET_MID) );
						dtCore::RefPtr<dtDAL::IntActorProperty> ValID( static_cast<dtDAL::IntActorProperty*>( pMissileID.get() ) );
						int tgt( ValID->GetValue() );
						if ( tgt == mMissileID )
						{
							dtCore::RefPtr<dtDAL::ActorProperty> pMissileNum( (*iter)->GetProperty(C_SET_MNUM) );
							dtCore::RefPtr<dtDAL::IntActorProperty> ValNum( static_cast<dtDAL::IntActorProperty*>( pMissileNum.get() ) );
							int num( ValNum->GetValue() );
							if ( num == mMissileNum )
							{
								proxy = (*iter);
								break;
							}
						}
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

int simSerialControl::__SendByte(int comport_number, unsigned char byte)
{
	int n;

	WriteFile(_cport[comport_number], &byte, 1, (LPDWORD)((void *)&n), NULL);

	if(n<0)  return(1);

	return(0);
}

int simSerialControl::__SendBuf(int comport_number, unsigned char *buf, int size)
{
	int n;

	if(WriteFile(_cport[comport_number], buf, size, (LPDWORD)((void *)&n), NULL))
	{
		return(n);
	}

	return(-1);
}

void simSerialControl::__cprintf(int comport_number, const char *text)  /* sends a string to serial port */
{
	while(*text != 0)  __SendByte(comport_number, *(text++));
}

int simSerialControl::__IsCTSEnabled(int comport_number)
{
	int status;

	GetCommModemStatus(_cport[comport_number], (LPDWORD)((void *)&status));

	if(status&MS_CTS_ON) return(1);
	else return(0);
}

void simSerialControl::RunLocal(float dt)
{
	int i = 0;
	int n = 0;
	unsigned char buf[MAX_SIZE];

	n = __PollComport(mAttachedSerialPort, buf, (MAX_SIZE-1));

	if( n > 0)
	{
		std::string sInput = (char *)buf;
		//std::cout << sInput << std::endl;

		firstFound = sInput.find("$");		
		if (firstFound!=std::string::npos){
			foundDollar = true;
		}

		if (foundDollar){
			lastFound = sInput.find("*",firstFound+1,1);
			if (lastFound!=std::string::npos){
				foundStar = true;
			}
		}

		if (foundDollar && foundStar && ((lastFound-firstFound) == 20))
		{
			//std::cout << sInput.substr(firstFound,20) << std::endl;
			foundDollar = false;
			foundStar = false;

			unsigned int valHex,valHex2;   
			std::stringstream ss,ss2;
			float val,val2;

			ss << std::hex << sInput.substr(firstFound+9,4) ;
			ss >> valHex;
			val	= ( valHex * 270.0f )/16384  ;
			//std::cout << "bearing = " << sInput.substr(firstFound+9,4) << " = " << val << std::endl;

			ss2 << std::hex << sInput.substr(firstFound+14,4) ;
			ss2 >> valHex2;
			val2 = ( valHex2 * 270.0f )/16384  ;
			//std::cout << "elevasi = " << sInput.substr(firstFound+14,4) << " = " << val2 << std::endl;

			MoveTDS(dt, val, val2, sInput[firstFound+19]);
		}
	}
}

void simSerialControl::SendDataToCannon()
{
	//Send Data To Cannon (Bearing and Elev From Camera) 
	/* Old Camera */
	/*dtCore::RefPtr<dtCore::Camera> mCam = GetGameManager()->GetApplication().GetCamera();
	float h, p, r;
	dtCore::Transform tmpTrans;
	mCam->GetTransform(tmpTrans,dtCore::Transformable::ABS_CS);
	tmpTrans.GetRotation(h,p,r);*/

	/* New Camera (Player) */
	std::vector<dtDAL::ActorProxy*> gaps;
	GetGameManager()->FindActorsByType(*(GetGameManager()->FindActorType(C_ACTOR_CAT, C_CN_PLAYER)), gaps);
	if(gaps.size() > 0 ) 
	{
		dtCore::RefPtr<dtGame::GameActorProxy> gap= static_cast<dtGame::GameActorProxy*>(gaps[0]);
		if ( gap!= NULL )
		{
			float Heading, Pitch , Roll;
			dtCore::Transform playerTrans;
			dtCore::RefPtr<dtGame::GameActor> Player = static_cast<dtGame::GameActor*>(gap->GetActor());
			Player->GetTransform(playerTrans,dtCore::Transformable::ABS_CS);
			playerTrans.GetRotation(Heading, Pitch, Roll);

			std::cout << "Send Data TDS To Cannon" << std::endl;
			std::cout << "Elevation : " << Pitch << std::endl; 
			std::cout << "Bearing :" << Heading << std::endl;

			TDSActorCommand(TO_SEND_ELEVATION, Pitch); 
			TDSActorCommand(TO_SEND_BEARING, Heading);
		}
	}
}

void simSerialControl::CameraCommand(int toSendType,float val)
{
	/* Old Camera */
	/*dtCore::RefPtr<dtCore::Camera> mCam = GetGameManager()->GetApplication().GetCamera();
	float h, p, r;
	dtCore::Transform tmpTrans;
	mCam->GetTransform(tmpTrans,dtCore::Transformable::REL_CS);
	tmpTrans.GetRotation(h,p,r);*/

	/* New Camera (player) */
	std::vector<dtDAL::ActorProxy*> gaps;
	GetGameManager()->FindActorsByType(*(GetGameManager()->FindActorType(C_ACTOR_CAT, C_CN_PLAYER)), gaps);
	if(gaps.size() > 0 ) 
	{
		dtCore::RefPtr<dtGame::GameActorProxy> gap= static_cast<dtGame::GameActorProxy*>(gaps[0]);
		if ( gap!= NULL )
		{
			float Heading, Pitch , Roll;
			dtCore::Transform playerTrans;
			dtCore::RefPtr<dtGame::GameActor> Player = static_cast<dtGame::GameActor*>(gap->GetActor());
			Player->GetTransform(playerTrans,dtCore::Transformable::REL_CS);
			playerTrans.GetRotation(Heading, Pitch, Roll);

			//std::cout<< toSendType << " : " <<val << ", " << Heading << ", " << Pitch << std::endl;

			switch (toSendType)
			{
				case TO_SEND_ELEVATION	: 
					{
						if ( Pitch != val )
						{
							//Pitch = val;
							//if (Pitch < 0) Pitch=0;
							//if (Pitch > 90) Pitch=90;
							playerTrans.SetRotation(Heading ,val, Roll); 

							std::cout<< " e: " <<val << ", " << Pitch << std::endl;
						}
					}
					break ;

				case TO_SEND_BEARING	:
					{
						std::cout<< " b: " <<val << ", " << Heading << std::endl;

						static float constantZeroHeading(0.0f);
						if (mAttachedWeaponID == CT_CANNON_40 && mAttachedLauncherID == 2 &&
							(mAttachedVehicleID == 6 || mAttachedVehicleID == 5 || mAttachedVehicleID == 4))
							constantZeroHeading = -45.0f;
						else if (mAttachedWeaponID == CT_CANNON_40 && mAttachedLauncherID == 3 &&
							(mAttachedVehicleID == 6 || mAttachedVehicleID == 5 || mAttachedVehicleID == 4))
							constantZeroHeading = 180.0f-45.0f;
						else
							constantZeroHeading = 45.0f;

						playerTrans.SetRotation(mAttachedFirstHeading + val + constantZeroHeading, Pitch, Roll);
					}
					break;
			}

			Player->SetTransform(playerTrans,dtCore::Transformable::REL_CS);
		}
	}
}

void simSerialControl::TDSActorCommand(int toSendType, float val)
{
	if ( mIsRunning )
	{
		CSocketClientGM* netGM =  static_cast<CSocketClientGM*>(GetGameManager()->GetComponentByName("ClientNetworkComponent"));	

		if (( mAttachedWeaponID == CT_CANNON_120 )||( mAttachedWeaponID == CT_CANNON_76 )||( mAttachedWeaponID == CT_CANNON_57 )||
			( mAttachedWeaponID == CT_CANNON_40 ))
		{
			static int MNum(0);
			MNum = MNum + 1;

			if (MNum > 20)
				MNum = 1;

			dtCore::RefPtr<MsgSetCannon> msg;
			GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::CANNON_EVENT, msg);
			msg->SetVehicleID(mAttachedVehicleID);
			msg->SetWeaponID(mAttachedWeaponID);
			msg->SetLauncherID(mAttachedLauncherID);
			msg->SetMissileID(MNum);
			msg->SetMissileNum(1);
			msg->SetUpDown(val);
			msg->SetModeID(1);

			switch (toSendType)
			{
				case TO_SEND_FIRE		: msg->SetOrderID(ORD_CANNON_DIRECT_F);break ;
					/*{
						dtCore::RefPtr<dtDAL::ActorProxy> ap = GetLauncherActors(C_WEAPON_TYPE_SPOUT,mAttachedVehicleID,mAttachedWeaponID,mAttachedLauncherID );
						if(ap.valid())
						{
							dtCore::RefPtr<CannonSpoutActor> Spout = static_cast<CannonSpoutActor*>(ap->GetActor());
							if ( Spout->GetIsUnlockToFire() == true )
								msg->SetOrderID(ORD_CANNON_DIRECT_F);
							else
								std::cout<<"you must unlock canon spout-"<< mAttachedLauncherID<<std::endl;
						}
						else
							std::cout<<"you must reload canon spout-"<< mAttachedLauncherID<<std::endl;
						break ;
					}*/
					
				case TO_SEND_ELEVATION	: msg->SetOrderID(ORD_CANNON_DIRECT_UD);break ;
				case TO_SEND_BEARING	: msg->SetOrderID(ORD_CANNON_DIRECT_LR);break ;
			}

			GetGameManager()->SendNetworkMessage(*msg.get());
			GetGameManager()->SendMessage(*msg.get());

		} else if ( mAttachedWeaponID == CT_MISTRAL )
		{ 
			static int MNum(0);
			MNum = MNum + 1;

			if (MNum > 2)
				MNum = 1;

			dtCore::RefPtr<MsgSetMistral> msg;
			GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::MISTRAL_EVENT, msg);
			msg->SetVehicleID(mAttachedVehicleID);
			msg->SetWeaponID(mAttachedWeaponID);
			msg->SetLauncherID(mAttachedLauncherID); 
			msg->SetMissileID(MNum);
			msg->SetMissileNum(1);
			msg->SetTargetBearing(val);
			switch (toSendType) 
			{
				case TO_SEND_FIRE		: //msg->SetOrderID(ORD_MISTRAL_DIRECT_F);break ;
					{
						dtCore::RefPtr<dtDAL::ActorProxy> proxy = GetMissileActors( mAttachedVehicleID, mAttachedWeaponID, mAttachedLauncherID, MNum, 1);
						if ( proxy.valid())
						{
							dtCore::RefPtr<MistralRocketActor> Missile = static_cast<MistralRocketActor*>(proxy->GetActor());
							if ( Missile->GetIsUnlockToFire() == 1){
								msg->SetOrderID(ORD_MISTRAL_DIRECT_F);
								std::cout<<"Fire Mistral-"<<mAttachedLauncherID<<"-"<<MNum<<"-1"<<std::endl;
							}
							else
								std::cout<<"you must unlock mistral-"<<mAttachedLauncherID<<"-"<<MNum<<"-1"<<std::endl;
						}
						else
							std::cout<<"you must reload mistral-"<<mAttachedLauncherID<<"-"<<MNum<<"-1"<<std::endl;
						break ;
					}
				case TO_SEND_ELEVATION	: 
					{
						msg->SetOrderID(ORD_MISTRAL_DIRECT_UD);
						msg->SetTargetElev(mLastElevation);
						break ;
					}
				case TO_SEND_BEARING	: 
					{
						msg->SetOrderID(ORD_MISTRAL_DIRECT_LR);
						msg->SetTargetBearing(mLastBearing);
						break ;
					}
			}
			GetGameManager()->SendNetworkMessage(*msg.get());
			GetGameManager()->SendMessage(*msg.get());

		} else if ( mAttachedWeaponID == CT_STRELA )
		{
			static int MNum(0);
			MNum = MNum + 1;

			if (MNum > 4)
				MNum = 1;

			dtCore::RefPtr<MsgSetStrela> msg;
			GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::STRELA_EVENT, msg);
			msg->SetVehicleID(mAttachedVehicleID);
			msg->SetWeaponID(mAttachedWeaponID);
			msg->SetLauncherID(mAttachedLauncherID);
			msg->SetMissileID(MNum);
			msg->SetMissileNum(1);
			msg->SetTargetBearing(val);
			switch (toSendType)
			{
				case TO_SEND_FIRE		: //msg->SetOrderID(ORD_STRELA_DIRECT_F);break ;
					{
						dtCore::RefPtr<dtDAL::ActorProxy> proxy = GetMissileActors( mAttachedVehicleID, mAttachedWeaponID, mAttachedLauncherID, MNum, 1);
						if ( proxy.valid())
						{
							dtCore::RefPtr<StrelaRocketActor> Missile = static_cast<StrelaRocketActor*>(proxy->GetActor());
							if ( Missile->GetIsUnlockToFire() == 1){
								msg->SetOrderID(ORD_STRELA_DIRECT_F);
								std::cout<<"Fire Strela-"<<mAttachedLauncherID<<"-"<<MNum<<"-1"<<std::endl;
							}
							else
								std::cout<<"you must unlock strela-"<<mAttachedLauncherID<<"-"<<MNum<<"-1"<<std::endl;
						}
						else
							std::cout <<"you must reload strela-"<<mAttachedLauncherID<<"-"<<MNum<<"-1"<<std::endl;
						break ;
					}
				case TO_SEND_ELEVATION	: 
					{
						msg->SetOrderID(ORD_STRELA_DIRECT_UD);
						msg->SetTargetElev(mLastElevation);
						break ;
					}
				case TO_SEND_BEARING	: 
					{
						msg->SetOrderID(ORD_STRELA_DIRECT_LR);
						msg->SetTargetBearing(mLastBearing);
						break ;
					}
			}
			GetGameManager()->SendNetworkMessage(*msg.get());
			GetGameManager()->SendMessage(*msg.get());

		} else if ( mAttachedWeaponID == CT_TETRAL )
		{
			static int MNum(0);
			MNum = MNum + 1;

			if (MNum > 4)
				MNum = 1;

			dtCore::RefPtr<MsgSetTetral> msg;
			GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::TETRAL_EVENT, msg);
			msg->SetVehicleID(mAttachedVehicleID);
			msg->SetWeaponID(mAttachedWeaponID);
			msg->SetLauncherID(mAttachedLauncherID);
			msg->SetMissileID(MNum);
			msg->SetMissileNum(1);
			msg->SetTargetBearing(val);
			switch (toSendType)
			{
				case TO_SEND_FIRE		: msg->SetOrderID(ORD_TETRAL_DIRECT_F);break ;
				case TO_SEND_ELEVATION	: msg->SetOrderID(ORD_TETRAL_DIRECT_UD);break ;
				case TO_SEND_BEARING	: msg->SetOrderID(ORD_TETRAL_DIRECT_LR);break ;
			}
			GetGameManager()->SendNetworkMessage(*msg.get());
			GetGameManager()->SendMessage(*msg.get());
		}
	}
}

void simSerialControl::OnAddedToGM( )
{

}

void simSerialControl::OnRemovedFromGM( )
{
	mIsRunning = false ;
	
}

void simSerialControl::SetIsRunning( const bool run )
{
	if ( mIsSerialPortOpened )
		mIsRunning = run ;
	else
		std::cout << "Cannot Run Port Control :: "<<mAttachedSerialPort+1<<"["<<mAttachedSerialBaudRate<<"] :: ??? ... \n";
}


void simSerialControl::ProcessMessage(const dtGame::Message& msg)
{
	const dtGame::MessageType& msgType = msg.GetMessageType();

	if(msgType == dtGame::MessageType::TICK_LOCAL)
	{
		float dt = float(static_cast<const dtGame::TickMessage&>(msg).GetDeltaSimTime());
		static float deltatime=0;
		deltatime+=dt;

		//if (deltatime>0.126)
		//{
			if ( mIsRunning ) RunLocal(dt);
			//deltatime = 0;
		//}
		
	}
	else if (msgType == dtGame::MessageType::INFO_MAP_LOADED)
	{
		if ( mIsSerialPortOpened ) mIsRunning = true ;
	}
}

void simSerialControl::Init( const int mVehicleID, const int mWeaponID ,const int mLauncherID,
							const int mSerialPort, const int mSerialBaudRate, const int mSerialData,
							const int mInitFirstPitch,const int mInitFirstHeading, const int mInitFire, 
							const int mInitLock, const bool mShOutConsole )
{
	mShowOuputConsole    = mShOutConsole ;

	mAttachedVehicleID   = mVehicleID;
	mAttachedWeaponID    = mWeaponID; 
	mAttachedLauncherID  = mLauncherID; 

	mAttachedSerialPort  = mSerialPort - 1 ; /// index _cport
	mAttachedSerialData  = mSerialData ;

	if ( mSerialBaudRate > 0 ) 
		 mAttachedSerialBaudRate = mSerialBaudRate ;
	else
		 mAttachedSerialBaudRate = 9600 ;  // default 

	mAttachedFirstPitch   = mInitFirstPitch;
	mAttachedFirstHeading = mInitFirstHeading;
	mAttachedInitFire	 = mInitFire ;
	mAttachedInitLock	 = mInitLock ;

	if( __OpenComport( mAttachedSerialPort, mAttachedSerialBaudRate, mAttachedSerialData )!= 1 )
	{
		mIsSerialPortOpened = true ;
		std::cout << "Port Control :: "<<mSerialPort<<"["<<mAttachedSerialBaudRate<<"] :: opened ... \n";
	}

}

// -  [5/21/2014 EKA]
void simSerialControl::MoveTDS(float dt, float bearing, float elevation, char isFire)
{
	if (bearing>=0 && bearing<=270)
		CheckMoveLR(bearing);
	if (elevation>=0 && elevation<=270)
		CheckMoveUD(elevation);
	CheckFire(dt,isFire);
}

void simSerialControl::CheckMoveLR(float bearing)
{
	//if ( bearing != mLastBearing )
	float brg = bearing - mAttachedFirstHeading;
	if ( abs (brg - mLastBearing) > 0.1)
	{
		mLastBearing = brg ;

		if ((mAttachedWeaponID == CT_CANNON_40) ||
			(mAttachedWeaponID == CT_CANNON_57) ||
			(mAttachedWeaponID == CT_CANNON_76) ||
			(mAttachedWeaponID == CT_CANNON_120))
		{
			if ( mIsControlled )
			{
				CameraCommand(TO_SEND_BEARING, mLastBearing);
				SendDataToCannon();
				if ( mShowOuputConsole ) std::cout << "Send New Rotation L-R : " << mLastBearing << "\n";
			}
			else
			{
				CameraCommand(TO_SEND_BEARING, mLastBearing);
				if ( mShowOuputConsole ) std::cout << "Camera New Rotation L-R : " << mLastBearing << "\n";
			}
		}
		else
			if ((mAttachedWeaponID == CT_MISTRAL)   ||
				(mAttachedWeaponID == CT_STRELA)    ||
				(mAttachedWeaponID == CT_TETRAL))
			{
				TDSActorCommand(TO_SEND_BEARING,mLastBearing);
				if ( mShowOuputConsole ) std::cout << "Send New Rotation L-R : " << mLastBearing << "\n";
			}
	}
}

void simSerialControl::CheckMoveUD(float elevation)
{
	//if ( elevation != mLastElevation )
	float elev = 0.0f;

	if ( elevation < ( mAttachedFirstPitch - 20 ) )
		elev = mAttachedFirstPitch - ( elevation + 20 );
	if ( elevation > ( mAttachedFirstPitch - 20 ) )
		elev = ( mAttachedFirstPitch - 20) - elevation;

	if ( abs (elev - mLastElevation) > 0.1)
	{
		mLastElevation = elev ;

		if (( mAttachedWeaponID == CT_CANNON_40 ) ||
			( mAttachedWeaponID == CT_CANNON_57 ) ||
			( mAttachedWeaponID == CT_CANNON_76 ) ||
			( mAttachedWeaponID == CT_CANNON_120))
		{
			if ( mIsControlled )
			{
				CameraCommand(TO_SEND_ELEVATION,mLastElevation);
				SendDataToCannon();		
				if ( mShowOuputConsole ) std::cout << "Send New Rotation U-D : " << mLastElevation << "\n";
			}
			else
			{
				CameraCommand(TO_SEND_ELEVATION,mLastElevation);
				if ( mShowOuputConsole ) std::cout << "Camera New Rotation U-D : " << mLastElevation << "\n";
			}
		}
		else
			if (( mAttachedWeaponID == CT_MISTRAL )   ||
				( mAttachedWeaponID == CT_STRELA  )   ||
				( mAttachedWeaponID == CT_TETRAL  ))
			{
				TDSActorCommand(TO_SEND_ELEVATION,mLastElevation);
				if ( mShowOuputConsole ) std::cout << "Send New Rotation U-D : " << mLastElevation << "\n";
			}
	}
}

void simSerialControl::CheckFire(float dt, char isFire)
{	
	if (isFire == 'L' ){
		if ((mAttachedWeaponID == CT_CANNON_40)||
			(mAttachedWeaponID == CT_CANNON_57)||
			(mAttachedWeaponID == CT_CANNON_76)||
			(mAttachedWeaponID == CT_CANNON_120))
		{
			TDSActorCommand(TO_SEND_FIRE,0);
		}
		if ( mShowOuputConsole ) std::cout << "Get New Port-B : fire(254) --> " << isFire << "\n";
	}
	else if ( isFire == 'N' )
	{
		if ( !mIsControlled )
		{ 
			mIsControlled = true ;
			if ((mAttachedWeaponID == CT_CANNON_40)||
				(mAttachedWeaponID == CT_CANNON_57)||
				(mAttachedWeaponID == CT_CANNON_76)||
				(mAttachedWeaponID == CT_CANNON_120))
			{
				TDSActorCommand(TO_SEND_FIRE,0);
			}
			if ((mAttachedWeaponID == CT_STRELA)   ||
				(mAttachedWeaponID == CT_MISTRAL)  ||
				(mAttachedWeaponID == CT_TETRAL))
			{
				TDSActorCommand(TO_SEND_FIRE,0);
				if ( mShowOuputConsole ) std::cout << "Set State Fire \n";
			}
		}
	}
	else if ( isFire == 'M' )
	{
		if ( !mIsControlled )
		{ 
			mIsControlled = true ;
			if ((mAttachedWeaponID == CT_CANNON_40)||
				(mAttachedWeaponID == CT_CANNON_57)||
				(mAttachedWeaponID == CT_CANNON_76)||
				(mAttachedWeaponID == CT_CANNON_120))
			{
				SendDataToCannon();
				if ( mShowOuputConsole ) std::cout << "Set State Controlled \n";
			}
			else
			if ((mAttachedWeaponID == CT_STRELA)   ||
				(mAttachedWeaponID == CT_MISTRAL)  ||
				(mAttachedWeaponID == CT_TETRAL))
			{
				TDSActorCommand(TO_SEND_FIRE,0);
				if ( mShowOuputConsole ) std::cout << "Set State Fire \n";
			}
		}
	}
	else if ( isFire == 'O' )
	{
		if ( mIsControlled )
		{ 
			mIsControlled = false ;
			if ( mShowOuputConsole ) std::cout << "Set State Release Controller \n";
		}
	}
}

dtCore::RefPtr<dtDAL::ActorProxy> simSerialControl::GetLauncherActors(const int actTypeID, const int mVehicleID, const int mWeaponID, const int mLauncherID  )
{

	dtCore::RefPtr<dtDAL::ActorProxy> proxy ;

	std::vector<dtGame::GameActorProxy *> fill;
	std::vector<dtGame::GameActorProxy *>::iterator iter;
	GetGameManager()->GetAllGameActors(fill);

	const std::string& actTypeName = GetActorWeaponTypeName(mWeaponID, actTypeID );

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
