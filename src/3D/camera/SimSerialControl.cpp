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

//Nando Added 
//#include "../didActors/shipmodelactor.h"

#include <iostream>
#include <math.h>
#include <winnt.h>

#include <osg/math>

#include <dtUtil/mathdefines.h>
#include <dtUtil/mswin.h>
#include <dtGame/messagefactory.h>

#include <boost/tokenizer.hpp>

//-- constant 
const int MAX_PORT = 20 ;
const int MAX_SIZE = 4096 ;

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
	else 
		printf("invalid data port ... ");

	_cport[comport_number] = CreateFileA(_comlist[comport_number],
		GENERIC_READ/*|GENERIC_WRITE*/,
		0,                          /* no share  */
		NULL,                       /* no security */
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
}

dtCore::RefPtr<dtDAL::ActorProxy> simSerialControl::GetShipActorByID(int mVehicleID )
{
	dtCore::RefPtr<dtDAL::ActorProxy> proxy ;

	std::vector<dtGame::GameActorProxy *> fill;
	std::vector<dtGame::GameActorProxy *>::iterator iter;
	GetGameManager()->GetAllGameActors(fill);

	for (iter = fill.begin(); iter < fill.end(); iter++)
	{
		if (((*iter)->GetActorType().GetName()== C_CN_SHIP ) || ((*iter)->GetActorType().GetName()== C_CN_SUBMARINE )
			|| ((*iter)->GetActorType().GetName()== C_CN_HELICOPTER )) 
		{
			dtCore::RefPtr<dtDAL::ActorProperty> PVehID( (*iter)->GetProperty(C_SET_VID) );
			dtCore::RefPtr<dtDAL::IntActorProperty> ValID( static_cast<dtDAL::IntActorProperty*>( PVehID.get() ) );
			int tgt( ValID->GetValue() );
			if ( tgt == mVehicleID )
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
		buf[n] = 0;   /* tambahkan "null" at the end of a string! */

		//int nBuff = 0 ;
		for(i=0; i < n; i++)
		{
			if (buf[i]=='@') buf[i] ='9' ;
			if (buf[i] < 32) buf[i] = ' '; // '.';  /* replace unreadable control-codes by spasi */
			if (buf[i] == NULL) break;
		}

		std::string sInput = (char *)buf;

		//$168 255 260 FF FF CR LF
		if ( sInput.substr(0, 4) == "$168" ) 
		{

			typedef boost::tokenizer<boost::char_separator<char> >  tokenizer;
			boost::char_separator<char> sep(" ", "|", boost::keep_empty_tokens);
			tokenizer tokens(sInput, sep);

			const int iBearing	 = 2 ;
			const int iElevation = 3 ;
			const int iPortB     = 4 ;

			std::ostringstream sTemp  ;

			int iCount = 0 ;

			for (tokenizer::iterator tok_iter = tokens.begin();
				tok_iter != tokens.end(); ++tok_iter)
			{	
				iCount ++ ;
				sTemp.clear();
				sTemp.str(*tok_iter) ;

				if ( sTemp.str().length() == 3) 
				{
					unsigned int valHex;   
					std::stringstream ss;
					ss << std::hex << sTemp.str() ; // "$"+
					ss >> valHex;

					if ( iCount == iBearing ) 
					{
						float val	= ( valHex / 1023.0f )* 270.0f  ;
						//int ival	= (int) (( val - 135 ) * -1 );

						int ival	= (int) ( val - 135);
						//float ival = (float) (val - 135);

						if ( ival != mLastBearing )
						{
							mLastBearing = ival ;

							if ((mAttachedWeaponID == CT_CANNON_40) ||
								(mAttachedWeaponID == CT_CANNON_57) ||
								(mAttachedWeaponID == CT_CANNON_76) ||
								(mAttachedWeaponID == CT_CANNON_120))
							{
								if ( mIsControlled )
								{
									CameraCommand(TO_SEND_BEARING, mLastBearing);
									SendDataToCannon();
									if ( mShowOuputConsole ) std::cout << "Camera New Rotation L-R : " << mLastBearing << "\n";
									//TDSActorCommand(TO_SEND_BEARING,mLastBearing);
									//if ( mShowOuputConsole ) std::cout << "Send New Rotation L-R : " << mLastBearing << "\n";
								}
								else
								{
									//TDSActorCommand(TO_SEND_BEARING,mLastBearing);
									CameraCommand(TO_SEND_BEARING, mLastBearing);
									if ( mShowOuputConsole ) std::cout << "Camera New Rotation L-R : " << mLastBearing << "\n";
								}
							}
							else
							if ((mAttachedWeaponID == CT_MISTRAL) ||
								(mAttachedWeaponID == CT_STRELA)  ||
								(mAttachedWeaponID == CT_TETRAL))
							{
								if ( mIsControlled )
								{
									TDSActorCommand(TO_SEND_BEARING,mLastBearing);
									//if ( mShowOuputConsole ) std::cout << "Send New Rotation L-R : " << mLastBearing << "\n";
								}
								else
								{
									TDSActorCommand(TO_SEND_BEARING,mLastBearing);
									//CameraCommand(TO_SEND_BEARING,mLastBearing);
									//if ( mShowOuputConsole ) std::cout << "Camera New Rotation L-R : " << mLastBearing << "\n";
								}
							}
							
						}
						
					}
					else if ( iCount == iElevation )
					{
						float val	= ( valHex / 1023.0f )* 270.0f ;
						//int ival	= (int) (( val - 135 ) * -1 );

						int ival	= (int) ( val + mAttachedFirstPitch ) ;
						//float ival = (float) (val + mAttachedFirstPitch);

						if ( ival != mLastElevation )
						{
							mLastElevation = ival ;
							
							if ((mAttachedWeaponID == CT_CANNON_40) ||
								(mAttachedWeaponID == CT_CANNON_57) ||
								(mAttachedWeaponID == CT_CANNON_76) ||
								(mAttachedWeaponID == CT_CANNON_120))
							{
								if ( mIsControlled )
								{
									CameraCommand(TO_SEND_ELEVATION,mLastElevation);
									SendDataToCannon();
									if ( mShowOuputConsole ) std::cout << "Camera New Rotation U-D : " << mLastElevation << "\n";
									//TDSActorCommand(TO_SEND_ELEVATION,mLastElevation);
									//if ( mShowOuputConsole ) std::cout << "Send New Rotation U-D : " << mLastElevation << "\n";
								}
								else
								{
									//TDSActorCommand(TO_SEND_ELEVATION,mLastElevation);
									CameraCommand(TO_SEND_ELEVATION,mLastElevation);
									if ( mShowOuputConsole ) std::cout << "Camera New Rotation U-D : " << mLastElevation << "\n";
									//if ( mShowOuputConsole ) std::cout << "Send New Rotation U-D : " << mLastElevation << "\n";
								}
							}
							else
							if ((mAttachedWeaponID == CT_MISTRAL) ||
								(mAttachedWeaponID == CT_STRELA)  ||
								(mAttachedWeaponID == CT_TETRAL))
							{
								if ( mIsControlled )
								{
									TDSActorCommand(TO_SEND_ELEVATION,mLastElevation);
									if ( mShowOuputConsole ) std::cout << "Send New Rotation U-D : " << mLastElevation << "\n";
								}
								else
								{
									TDSActorCommand(TO_SEND_ELEVATION,mLastElevation);
									//CameraCommand(TO_SEND_ELEVATION,mLastElevation);
									//if ( mShowOuputConsole ) std::cout << "Camera New Rotation U-D : " << mLastElevation << "\n";
									if ( mShowOuputConsole ) std::cout << "Send New Rotation U-D : " << mLastElevation << "\n";
								}
							}
						}
						
					}

				} // end if ( sTemp.str().length() == 3) 
				else if ( sTemp.str().length() == 2)
				{

					unsigned int valHex;   
					std::stringstream ss;
					ss << std::hex << sTemp.str() ; // "$"+
					ss >> valHex;

					if ( iCount == iPortB ) 
					{
						float val	=  valHex ; 
						int ival	= (int) (val);

						// if ( mShowOuputConsole ) std::cout << "test --> " << val << "\n";

						if (( ival == mAttachedInitFire ) || ( ival == 250 ) )
						{
							TDSActorCommand(TO_SEND_FIRE,0);
							if ( mShowOuputConsole ) std::cout << "Get New Port-B : fire(254) --> " << val << "\n";

						} else if ( ival == mAttachedInitLock )
						{
							if ( !mIsControlled )
							{ 
								mIsControlled = true ;

								if ((mAttachedWeaponID == CT_CANNON_40) ||
									(mAttachedWeaponID == CT_CANNON_57) ||
									(mAttachedWeaponID == CT_CANNON_76) ||
									(mAttachedWeaponID == CT_CANNON_120))
								{
									SendDataToCannon();
									if ( mShowOuputConsole ) std::cout << "Set State Controlled \n";
								}
								else
								if ((mAttachedWeaponID == CT_STRELA)  ||
									(mAttachedWeaponID == CT_MISTRAL) ||
									(mAttachedWeaponID == CT_TETRAL)
									)
								{
									TDSActorCommand(TO_SEND_FIRE,0);
									if ( mShowOuputConsole ) std::cout << "Set State Fire \n";
								}
								
								/*dtCore::RefPtr<dtCore::Camera> mCam = GetGameManager()->GetApplication().GetCamera();
								if ( mCam->GetParent() !=NULL )
								{
									dtCore::Transform tmpTrans;
									mCam->GetTransform(tmpTrans,dtCore::Transformable::REL_CS);
									tmpTrans.SetRotation(0.0f,0.0f,0.0f);
									mCam->SetTransform(tmpTrans,dtCore::Transformable::REL_CS);
								}*/
							}
						}
						else if ( ival == 255 )
						{
							if ( mIsControlled )
							{ 
								mIsControlled = false ;
								if ( mShowOuputConsole ) std::cout << "Set State Release Controller \n";
							}
						} 
						 
					}

				}  
			} // end for (tokenizer::iterator 
			
		}

		//printf("received %i bytes: %s\n", n, (char *)buf);

	} // end if( n > 0)
	 
}

void simSerialControl::SendDataToCannon()
{
	//Send Data To Cannon (Bearing and Elev From Camera)
	dtCore::RefPtr<dtCore::Camera> mCam = GetGameManager()->GetApplication().GetCamera();
	float h, p, r;
	dtCore::Transform tmpTrans;
	mCam->GetTransform(tmpTrans,dtCore::Transformable::ABS_CS);
	tmpTrans.GetRotation(h,p,r);

	std::cout << "Send Data TDS To Cannon" << std::endl;
	std::cout << "Elevation : " << p << std::endl;
	std::cout << "Bearing :" << h << std::endl;

	TDSActorCommand(TO_SEND_ELEVATION,p);
	TDSActorCommand(TO_SEND_BEARING,h);
}

void simSerialControl::CameraCommand(int toSendType,float val)
{
	dtCore::RefPtr<dtCore::Camera> mCam = GetGameManager()->GetApplication().GetCamera();
	float h, p, r;
	dtCore::Transform tmpTrans;
	mCam->GetTransform(tmpTrans,dtCore::Transformable::REL_CS);
	tmpTrans.GetRotation(h,p,r);

	/*dtCore::RefPtr<dtDAL::ActorProxy> ShipProxy = GetShipActorByID(mAttachedVehicleID);
	float ShipH, ShipP, ShipR;
	dtCore::Transform ShipTrans;

	if ( ShipProxy.valid())
	{
		dtCore::RefPtr<ShipActor> Ship = static_cast<ShipActor*>(ShipProxy->GetActor());
		dtGame::GameActorProxy &Shp = Ship->GetGameActorProxy();

		Ship->GetTransform(ShipTrans);
		ShipTrans.GetRotation(ShipH, ShipP, ShipR);
	}
	else
	{
		ShipH = 0;
	}*/

	switch (toSendType)
	{
	case TO_SEND_ELEVATION	: 
		{
			if ( p != val )
				tmpTrans.SetRotation(h,val,r);
		}
		break ;

	case TO_SEND_BEARING	:
		{
			std::cout << "Old Bearing : " << h << std::endl;
			std::cout << "Value From Console : " << val << std::endl;

			/*if ( h != val )
				tmpTrans.SetRotation(val,p,r);break ;*/
			
			tmpTrans.SetRotation(mAttachedFirstHeading + val /*+ ShipH*/ , p, r);
		}
		break;
	}
	mCam->SetTransform(tmpTrans,dtCore::Transformable::REL_CS);
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

			if (MNum > 5)
				MNum = 1;

			dtCore::RefPtr<MsgSetCannon> msg;
			GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::CANNON_EVENT, msg);
			msg->SetVehicleID(mAttachedVehicleID);
			msg->SetWeaponID(mAttachedWeaponID);
			msg->SetLauncherID(mAttachedLauncherID);
			msg->SetMissileID(1);
			msg->SetMissileNum(MNum);
			msg->SetUpDown(val);
			msg->SetModeID(1);

			switch (toSendType)
			{
				case TO_SEND_FIRE		: msg->SetOrderID(ORD_CANNON_DIRECT_F);break ;
				case TO_SEND_ELEVATION	: msg->SetOrderID(ORD_CANNON_DIRECT_UD);break ;
				case TO_SEND_BEARING	: msg->SetOrderID(ORD_CANNON_DIRECT_LR);break ;
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
			msg->SetMissileNum(1);
			msg->SetTargetBearing(val);
			switch (toSendType)
			{
				case TO_SEND_FIRE		: msg->SetOrderID(ORD_MISTRAL_DIRECT_F);break ;
				case TO_SEND_ELEVATION	: msg->SetOrderID(ORD_MISTRAL_DIRECT_UD);break ;
				case TO_SEND_BEARING	: msg->SetOrderID(ORD_MISTRAL_DIRECT_LR);break ;
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
			msg->SetMissileNum(1);
			msg->SetTargetBearing(val);
			switch (toSendType)
			{
				case TO_SEND_FIRE		: msg->SetOrderID(ORD_STRELA_DIRECT_F);break ;
				case TO_SEND_ELEVATION	: msg->SetOrderID(ORD_STRELA_DIRECT_UD);break ;
				case TO_SEND_BEARING	: msg->SetOrderID(ORD_STRELA_DIRECT_LR);break ;
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
		if ( mIsRunning ) RunLocal(dt);
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