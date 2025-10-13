#include "../didutils/trajectory.h"
#include "../didutils/BaseFunction.h"  
#include "../didCommon/BaseConstant.h"  

#include <math.h>

trajectory::trajectory()
{
	FDirection = 0.0f;    
	FElevation = 0.0f;	  
	FTurnRate = 0.0f;     
	FElevTurnRate = 0.0f; 
	FAcceleration = 0.0f; 
	FSpeed = 0.0f ;       
	FSpeedTorp = 0.0f;
	FDeltaDir = 0.0f;     
	FDeltaElev = 0.0f;
	FAsroc_v0 = 0.0f;
	elev = 0.0f;
}
trajectory::~trajectory()
{
	/*SetDirection(0);
	SetElevation(0);
	SetTurnRate(0);
	SetAcceleration(0);
	SetSpeed(0);*/
}
//******************
double trajectory::GetDirection()
{
	return c_RadToDeg * FDirection ;
}
void trajectory::SetDirection(const double value)
{
	FDirection = c_DegToRad * value;
	//ValidateRadiant(FDirection); //for rbu 14022012
	/*FSinX = sin(FDirection);
	FCosX = cos(FDirection);*/
}
//**********************
double trajectory::GetElevation()
{
	return c_RadToDeg * FElevation;
}
void trajectory::SetElevation(const double value)
{
	FElevation = c_DegToRad * value;
	/*FSinZ = sin(FElevation);
	FCosZ = cos(FElevation);*/
}
//**********************
double trajectory::GetTurnRate()
{
	return c_RadToDeg * FTurnRate ;
}
void trajectory::SetTurnRate(const double value)
{
	FTurnRate = c_DegToRad * value ;
}
//*****************
double trajectory::GetElevTurnRate()
{
	return c_RadToDeg * FElevTurnRate ;
}
void trajectory::SetElevTurnRate(const double value)
{
	FElevTurnRate = c_DegToRad * value ;
}
//*****************

//*****************
double trajectory::GetAcceleration()
{
	return FAcceleration; //FAcceleration * c_Meter_To_NauticalMiles * c_HourToMilliSecond * c_MilliSecondToSecond ;
}
void trajectory::SetAcceleration(const double value)
{
	FAcceleration = value; //c_NauticalMiles_To_Meter * value * c_MilliSecondToHour * c_SecondToMilliSecond;
}
//******************
double trajectory::GetSpeed()
{
	return FSpeed / DEF_MACH_TO_METRE; //FSpeed * c_Meter_To_NauticalMiles * c_HourToMilliSecond * c_MilliSecondToSecond;
}
void trajectory::SetSpeed(const double value)
{
	FSpeed = value * DEF_MACH_TO_METRE;	// mach 1 = 340.3 m/s
							//c_NauticalMiles_To_Meter * value * c_MilliSecondToHour * c_SecondToMilliSecond;
} 

double trajectory::GetSpeedKnot()
{
	return FSpeedTorp / DEF_KNOT_TO_METRE; 

}
void trajectory::SetSpeedKnot(const double value)
{
	FSpeedTorp = value * DEF_KNOT_TO_METRE;
							
}

//********************
void trajectory::Calc_Speed(const double aDt)
{
	// speed : meter per second;
	// aDt   : second;
	//printf("FSpeed = %f\n",FSpeed);
	FSpeed = FSpeed + FAcceleration * aDt;
	

}
void trajectory::Calc_SpeedTorp(const double aDt)
{
	// speed : meter per second;
	// aDt   : second;

	FSpeedTorp = FSpeedTorp + FAcceleration * aDt;
	//printf("FSpeedTorp = %f\n",FSpeedTorp);
}

void trajectory::Calc_Direction(const double aDt)
{  
	//Direction : degree, 0 = north
	//FTurnRate : degree per second

	FDeltaDir   = FTurnRate * aDt;
	FDirection  = FDirection + FDeltaDir;
	FDirection = ValidateRadiant(FDirection);
}

void trajectory::Calc_Elevation(const double aDt)
{
	//FElevTurnRate : degree per second

	FDeltaElev   = FElevTurnRate * aDt;
	FElevation  = FElevation + FDeltaElev;
	//FElevation = ValidateRadiant(FElevation);
}

osg::Vec3 trajectory::Calc_Movement(const double aDt)
{
	// dari arah y+
	double d;
	osg::Vec3 dir;
	// x := v . t;
	d = FSpeed * aDt;

	dir.x() = static_cast<float>(d * cos(FElevation) * sin(FDirection));
	dir.y() = static_cast<float>(d * cos(FElevation) * cos(FDirection));
	dir.z() = static_cast<float>(d * sin(FElevation));

	return dir;
}

double trajectory::Gun_76Low_TimeToSpeedX(const double t)
{
	double SpeedX;
	SpeedX = ( - 4.03428 * pow(10.0, -05.0) * pow(t, 5.0)  + 0.005878895 * pow(t, 4.0) - 0.32695943  * pow(t, 3.0) + 8.615260231 * pow(t, 2.0) - 111.9018568 * t + 868.6728886);
	
	if ( SpeedX > 0)
	{
		return SpeedX;
	}
	else
	{
		return 0;
	}
}

double trajectory::Sigmoid(const double t)
{
	return ( -1 + 2 / (1 +  exp(-t)));
}


double trajectory::Gun_76Low_TimeToRange(const double t)
{
	if (t > 0)
	{
		double x, Range;

		x = sqrt(t);
		Range = ( - 0.02907127 * pow(x, 3.0) + 0.383275697 * pow(x, 2.0) + 0.861348954 * x - 0.129575272 );
		return( 1000.0 * Range );
	}
	else
	{
		return 0;
	}
}

double trajectory::Gun_76Low_ElevToRange(const double GunElev)
{
	return ( -0.043037695 * pow(GunElev, 4.0) +3.584767811 * pow(GunElev, 3.0) -107.4852179 * pow(GunElev, 2.0) +1644.802547 * GunElev +561.26334);
}

double trajectory::Gun_76Low_RangeToElev(const double GunRange)
{
	double r;
	r = 0.001 * GunRange;

	return ( 0.000640365 * pow(r, 4.0) - 0.011721821 * pow(r, 3.0) + 0.17811014  * pow(r, 2.0) - 0.071564918 * r ); 
}

double trajectory::Gun_76Low_ElevToHeight(const double GunElev)
{
	double Height;
	Height = ( 0.001036599 * pow(GunElev, 4.0) - 0.107590687 * pow(GunElev, 3.0) + 5.244975761 * pow(GunElev, 2.0) + 20.25173288 * GunElev - 15.4167862);
		
	return Height;

	if ( Height < 0)
	{
		return 0;
	}
}

double trajectory::Gun_76Low_RangeToTOF(const double GunRange)
{
	double r;
	r = 0.001 * GunRange;	
	return( 0.00107063  * pow(r, 4.0) - 0.028098132 * pow(r, 3.0) + 0.386844803 * pow(r, 2.0) + 0.294670735 * r + 0.314859117 );
}

double trajectory::Gun_76Low_TimeToHeight(const double t, const double maxT, const double maxHeight)
{
	double a, x;

	if ( maxT > 0 ) 
	{
		x = 0.5 * maxT;
		a = maxHeight / ((x - 0) * (x - maxT));

		return (a * (t - 0) * (t - maxT));
	}
	else
	{
		return 0;
	}
}

osg::Vec3 trajectory::Calc_Movement_CannonProjectile_76Low_byElev(const double aDt, const osg::Vec3 FirstPos, const double launchElev, double HeightMax, double TimeMax)
{
	osg::Vec3 dir;
	double Speed, dX, TimeToHeight;

	Speed = Gun_76Low_TimeToSpeedX(aDt);
	FSpeed =  Speed;
	
	dX = Gun_76Low_TimeToRange(aDt);
	TimeToHeight = Gun_76Low_TimeToHeight(aDt, TimeMax, HeightMax);

	dir.x() = static_cast<float> (FirstPos.x() +  ( dX * sin (FDirection)));
	dir.y() = static_cast<float> (FirstPos.y() +  ( dX * cos (FDirection)));
	dir.z() = static_cast<float> (FirstPos.z() +  TimeToHeight);

	return dir;
}

double trajectory::Gun_76High_RangeToTOF(const double GunRange)
{
	double x, y;

	x = 0.001 * GunRange;
	y = - 0.02860150187235132 * pow(x, 2.0) + 0.630486821625656 * x + 5.91178274931193;
	return(pow(y, 2.0));
}

double trajectory::Gun_76High_RangeToElev(const double GunRange)
{
	double x, y, Elev;

	x = 0.001 * GunRange;
	y =  ( 0.000842593* pow(x, 2.0) + 0.044424219 * x + 0.04294116 );
	
	if ( y < 0.0 )		
		y = 0.0;

	if ( y > 1.0 )
		y = 1.0;

	Elev = ((c_RadToDeg * asin(y))/2);
	
	if ( Elev < 45 ) 
		return( 90 - Elev );
	else
		return( Elev );
}

double trajectory::Gun_76High_HeightToTime(const double Height, const double HeightMax, const double TimeMax)
{
	double t, a, dh, dt, dt2;

	if ( (TimeMax <= 0) || (TimeMax > 120) )
	{
		return 0;
	}
	else
	{
		t   = TimeMax / 2;
		a   = HeightMax / pow(t, 2.0);
		dh  = HeightMax - Height;

		dt2 = abs(dh / a);

		if ( dt2 < 0.0000000001 ) 
		{
			return 0;
		}
		else
		{
			dt = sqrt(dt2);
			return(t - dt);
		}
	}
}

double trajectory::Gun_76High_TimeToHeight(const double t, const double maxT, const double maxHeight)
{
	double a, x;

	if ( maxT > 0 ) 
	{
		x = 0.5 * maxT;
		a = maxHeight / ((x - 0) * (x - maxT));

		return (a * (t - 0) * (t - maxT));
	}
	else
	{
		return 0;
	}
}

double trajectory::Gun_76High_ElevToRange(const double GunElev)
{
	double x, Range;

	x = sin( 2* c_DegToRad * GunElev );
	Range = ( -2.665269695* pow(x, 2.0) + 19.1354017 * x - 0.046825845 );
	return( 1000 * Range );
}

double trajectory::Gun_76High_ElevToTOF(const double GunElev)
{
	return( -0.010709204* pow(GunElev ,2.0) + 2.143751228*GunElev - 8.319353207);
}

double trajectory::Gun_76High_ElevToHeight(const double GunElev)
{
	double x, height;

	x = sin(c_DegToRad * GunElev );
	height = (2.947601528 * pow(x, 2.0) + 13.72305254*x - 5.486492431);
	return( 1000 * height );
}

double trajectory::SearchHighAngel(const double TargetRange, const double TargetHeight)
{
	int i;
	double t1; 
	double e1, dR;
	double err, delta; 
	bool locked;

	double GunTime, LowTimeMax, Gun76High_range;

	double FGun_76High_TimeMax;
	double FGun_76High_HeightMax;
	double FGun_76High_RangeMax;

	e1		= 72;
	i		= 0;
	delta	= 0;
	locked	= false;

	do
	{
		e1 = e1 + delta;
		FGun_76High_RangeMax	= Gun_76High_ElevToRange(e1); 
		FGun_76High_HeightMax	= Gun_76High_ElevToHeight(e1); 
		FGun_76High_TimeMax		= Gun_76High_ElevToTOF(e1);

		t1  = Gun_76High_HeightToTime( TargetHeight , FGun_76High_HeightMax, FGun_76High_TimeMax );
		
		if ( FGun_76High_RangeMax <= 0 )
		{
			dR = 0;
		}
		else
		{
			LowTimeMax = Gun_76Low_RangeToTOF( FGun_76High_RangeMax );
			GunTime = LowTimeMax * t1 / FGun_76High_TimeMax;
			Gun76High_range = Gun_76Low_TimeToRange(GunTime); 
			dR = Gun76High_range ;
		}
		
		err = dR - TargetRange;

		delta	=  (2.0 * Sigmoid( 0.001 * err ));
		
		if ( abs(delta) < 0.1 )
			locked = true;	
		else
			locked = false;

		i++;

	}
	while (  ( (i < 40)	&& (locked == false ) && (e1 <= 80) && (e1 > 45)) );

	if ( locked == true )
		return e1;
	else
		return( -1.0 );
}

osg::Vec3 trajectory::Calc_Movement_CannonProjectile_76High_byElev(const double aDt, const osg::Vec3 FirstPos, const double launchElev, double RangeMax, double HeightMax, double TimeMax, double TimeAX)
{
	osg::Vec3 dir;
	double Speed, TimeToHeight, GundX;
	double GunTime, Gun76High_range;

	Speed = Gun_76Low_TimeToSpeedX(aDt);
	FSpeed =  Speed;

	if ( RangeMax <= 0 )
	{
		GundX = 0;
	}
	else
	{
		GunTime = TimeAX * aDt / TimeMax;
		Gun76High_range = Gun_76Low_TimeToRange(GunTime); 
		GundX = Gun76High_range ;
	}

	TimeToHeight = Gun_76High_TimeToHeight(aDt, TimeMax, HeightMax);

	dir.x() = static_cast<float> ( FirstPos.x() + ( GundX * sin (FDirection) ));
	dir.y() = static_cast<float> ( FirstPos.y() + ( GundX * cos (FDirection) ));
	dir.z() = static_cast<float> ( FirstPos.z() + TimeToHeight);

	return dir;
}

osg::Vec3 trajectory::Calc_MovementTorp(const double aDt)
{
	double d;
	osg::Vec3 dir;
	// x := v . t;
	d = FSpeedTorp * aDt;

	dir.x() = static_cast<float>(d * cos(FElevation) * sin (FDirection));
	dir.y() = static_cast<float>(d * cos(FElevation) * cos(FDirection));
	dir.z() = static_cast<float>(d * sin(FElevation));
	
	return dir;
}

double trajectory::GetDeltaDir()
{
	return c_RadToDeg * FDeltaDir;
}

double trajectory::SearchLowAngel(const double TargetRange, const double TargetHeight)
{
	int i;
	double tt, e1;
	double Height;
	double err, delta;
	bool locked;

	double FGun_76Low_TimeMax;
	double FGun_76Low_HeightMax;
	double FGun_76Low_RangeMax;

	tt = Gun_76Low_RangeToTOF(TargetRange);
	e1 = c_RadToDeg * (atan2(TargetHeight, TargetRange));

	i  = 0;

	do 
	{
		FGun_76Low_RangeMax		= Gun_76Low_ElevToRange(e1); 
		FGun_76Low_HeightMax	= Gun_76Low_ElevToHeight(e1); 
		FGun_76Low_TimeMax		= Gun_76Low_RangeToTOF(FGun_76Low_RangeMax);

		Height = Gun_76Low_TimeToHeight(tt, FGun_76Low_TimeMax, FGun_76Low_HeightMax);

		err = TargetHeight - Height;
		delta =  (2.0 * Sigmoid( 0.001 * err ));
		e1 = e1 + delta;
		
		i++;

		if ( abs(err) < 1.0 )
			locked = true;
		else
			locked = false;

	}  while ( (( locked == false ) && ( i <= 45 ) && ( e1 > 0) ) );

	if ( locked == true )
		return(e1);
	else
		return(-1.0);
}

double trajectory::Gun_120_RangeToElev(const double GunRange)
{
	if (( GunRange > 0 ) && ( GunRange <= 3500 )) 
	{
		return(((0.0003)*pow(((GunRange/100)), 2.0)) + ((0.0426)*((GunRange/100))) + 0.0074);
	}
	else
	if (( GunRange > 3500 ) && ( GunRange <= 7000 ))
	{
		return(((0.0006)*pow(((GunRange/100)), 2.0)) + ((0.019)*((GunRange/100))) + 0.4617);
	}
	else
	if (( GunRange > 7000 ) && ( GunRange <= 10500 )) 
	{
		return(((0.0011)*pow(((GunRange/100)), 2.0)) - ((0.0477)*((GunRange/100))) + 2.849);
	}
	else
	if (( GunRange > 10500 ) && ( GunRange <= 14000 ))
	{
		return(((0.1229)*pow(((GunRange/1000)), 2.0)) - ((0.7451)*((GunRange/1000))) + 4.3499);
	}
	else
	if (( GunRange > 14000 ) && ( GunRange <= 17500 )) 
	{
		return(((0.1246)*pow(((GunRange/1000)), 2.0)) - ((0.4754)*((GunRange/1000))));
	}
	else
	if (( GunRange > 17500 ) && ( GunRange <= 18350))
	{
		return(((0.0174)*pow(((GunRange/100)-175), 2.0)) + ((0.3609)*((GunRange/100)-175)) + 30.323);
	}
	else
	{
		return 0;
	}
}

double trajectory::Gun_120_GetV0X_ByElev(const double GunElev)
{
	if (( GunElev > 0.05 ) && ( GunElev <= 1.9 ))
	{
		return((-7.0619*(pow(GunElev, 2.0))) + (-40.285*GunElev) + 778.26);
	}
	else
	if (( GunElev > 1.9 ) && ( GunElev <= 4.93 ))
	{
		return((3.4889*(pow(GunElev, 2.0))) + (-60.798*GunElev) + 782.56);
	}
	else
	if (( GunElev > 4.93 ) && ( GunElev <= 10.06 ))
	{
		return((1.651*(pow(GunElev, 2.0))) + (-43.559*GunElev) + 741.34);
	}
	else
	if (( GunElev > 10.06 ) && ( GunElev <= 18.02 ))
	{
		return((0.413*(pow(GunElev, 2.0))) + (-18.644*GunElev) + 614.76);
	}
	else
	if (( GunElev > 18.02 ) && ( GunElev <= 30.14 )) 
	{
		return((0.1289*(pow(GunElev, 2.0))) + (-8.7146*GunElev) + 527.14);
	}
	else
	if (( GunElev > 30.14 ) && ( GunElev <= 40 )) 
	{
		return((0.0614*(pow(GunElev, 2.0))) + (-4.8105*GunElev) + 470.38);
	}
	else
	{
		return 0;
	}
}

double trajectory::Gun_120_GetV0Y_ByElev(const double GunElev)
{
	if (( GunElev > 0.05 ) && ( GunElev <= 1.9 ))
	{
		return((-7.0619*(pow(GunElev, 2.0))) + (-40.285*GunElev) + 778.26);
	}
	else
	if (( GunElev > 1.9 ) && ( GunElev <= 4.93 ))
	{
		return((0.4951*(pow(GunElev, 2.0))) + (-21.937*GunElev) + 816.72);
	}
	else
	if (( GunElev > 4.93 ) && ( GunElev <= 10.06 ))
	{
		return((0.2156*(pow(GunElev, 2.0))) + (-16.992*GunElev) + 799.05);
	}
	else
	if (( GunElev > 10.06 ) && ( GunElev <= 18.02 ))
	{
		return((0.3914*(pow(GunElev, 2.0))) + (-20.022*GunElev) + 810.97);
	}
	else
	if (( GunElev > 18.02 ) && ( GunElev <= 30.14 )) 
	{
		return((0.1613*(pow(GunElev, 2.0))) + (-11.74*GunElev) + 736.15);
	}
	else
	if (( GunElev > 30.14 ) && ( GunElev <= 40 )) 
	{
		return((0.0761*(pow(GunElev, 2.0))) + (-6.8575*GunElev) + 661.1);
	}
	else
	{
		return 0;
	}
}

osg::Vec3 trajectory::Calc_Movement_CannonProjectile_120_byElev(const double aDt, const osg::Vec3 FirstPos, const double launchElev, const double V0X, const double V0Y)
{
	osg::Vec3 dir;
	double GunPosX, GunPosY;

	FSpeed =  ( V0X + V0Y ) / 2;
	GunPosX =  V0X * cos(c_DegToRad*launchElev) * aDt;
	GunPosY = (V0Y * sin(c_DegToRad*launchElev) * aDt) - (5 * aDt * aDt);

	dir.x() = static_cast<float> ( FirstPos.x() + ( GunPosX * sin (FDirection) ));
	dir.y() = static_cast<float> ( FirstPos.y() + ( GunPosX * cos (FDirection) ));
	dir.z() = static_cast<float> ( FirstPos.z() +  GunPosY );

	return dir;
}

double trajectory::Gun_40_RangeToElev(const double GunRange)
{
	if ((GunRange > 0) && (GunRange < 600)) 
	{
		return((0.0003*pow((GunRange/100), 2.0)) + (0.0295*GunRange/100) - 0.0005);
	}
	else
	if ((GunRange >= 600) && (GunRange < 3300))
	{
		return((0.0008*pow((GunRange/100), 2.0)) + (0.02*GunRange/100) + 0.0498);
	}
	else
	if ((GunRange >= 3300) && (GunRange < 6700)) 
	{
		return((0.0027*pow((GunRange/100), 2.0)) - (0.1182*GunRange/100) + 2.6125);
	}
	else
	if ((GunRange >= 6700) && (GunRange < 9200))
	{
		return((0.0031*pow(((GunRange/100) - 66), 2.0)) + (0.2336*((GunRange/100) - 66)) + 6.4387);
	}
	else
	if ((GunRange >= 9200) && (GunRange < 11100))
	{
		return((0.0072*pow(((GunRange/100) - 91), 2.0)) + (0.3738*((GunRange/100) - 91)) + 14.292);
	}
	else
	if ((GunRange >= 1100) && (GunRange < 12300)) 
	{
		return((0.0541*pow(((GunRange/100) - 110), 2.0)) + (0.3815*((GunRange/100) - 110)) + 24.507);
	}
	else
		return 0;
}

double trajectory::Gun_40_GetV0X_ByElev(const double GunElev)
{
	if ((GunElev >= 0) && (GunElev <= 0.18))
	{
		return((0.1685*(pow(100*GunElev, 3.0))) - (5.2738*pow(100*GunElev, 2.0)) + (48.98*100*GunElev) + 807.74);
	}
	else
	if ((GunElev >= 0.19) && (GunElev <= 1.54))
	{
		return((-24.879*pow(GunElev, 3)) + (113.7*pow(GunElev, 2.0)) - (304.08*GunElev) + 981.15);
	}
	else
	if ((GunElev >= 1.55) && (GunElev <= 6.65))
	{
		return((0.4717*pow(GunElev, 4.0)) - (9.5861*pow(GunElev, 3.0)) + (75.601*pow(GunElev, 2.0)) - (303.83*GunElev) + 1020.7);
	}
	else
	if ((GunElev >= 6.66) && (GunElev <= 14.63))
	{
		return((-0.0667*pow(GunElev, 3.0)) + (2.8295*pow(GunElev, 2.0)) - (47.542*GunElev) + 653.11);
	}
	else
	if ((GunElev >= 14.64) && (GunElev <= 24.72))
	{
		return((-0.0147*pow(GunElev, 3.0)) + (1.0379*pow(GunElev, 2.0)) - (27.817*GunElev) + 586.13);
	}
	else
	if ((GunElev >= 24.73) && (GunElev <= 40))
	{
		return((-23.931*pow(GunElev/10, 3.0)) + (226.79*pow(GunElev/10, 2.0)) - (729.39*GunElev/10) + 1086.3);
	}
	else
		return 0;
}

double trajectory::Gun_40_GetV0Y_ByElev(const double GunElev)
{
	if ((GunElev >= 0) && (GunElev <= 0.18))
	{
		return((0.2027*(pow(100*GunElev, 3.0))) + (6.444*pow(100*GunElev, 2.0)) - (65.064*100*GunElev) + 1214.6);
	}
	else
	if ((GunElev >= 0.19) && (GunElev <= 1.54))
	{
		return((162.57*pow(GunElev, 3.0)) - (423.9*pow(GunElev, 2.0)) + (240.74*GunElev) + 924.24);
	}
	else
	if ((GunElev >= 1.55) && (GunElev <= 6.65))
	{
		return((1.6345*pow(GunElev, 3.0)) - (17.232*pow(GunElev, 2.0)) + (9.7817*GunElev) + 869.95);
	}
	else
	if ((GunElev >= 6.66) && (GunElev <= 14.63))
	{
		return((1.1299*pow(GunElev, 2.0)) - (39.46*GunElev) + 867.79);
	}
	else
	if ((GunElev >= 14.64) && (GunElev <= 24.72))
	{
		return((0.257*pow(GunElev, 2.0)) - (16.043*GunElev) + 709.27);
	}
	else
	if ((GunElev >= 24.73) && (GunElev <= 40))
	{
		return((-20.127*pow(GunElev/10, 4.0)) + (294.24*pow(GunElev/10, 3.0)) - (1553.9*pow(GunElev/10, 2.0)) + (3513.3*GunElev/10) - 2416.8);
	}
	else
		return 0;
}

osg::Vec3 trajectory::Calc_Movement_CannonProjectile_40_byElev(const double aDt, const osg::Vec3 FirstPos, const double launchElev, const double V0X, const double V0Y)
{
	osg::Vec3 dir;
	double GunPosX, GunPosY;

	FSpeed =  ( V0X + V0Y ) / 2;

	GunPosX = V0X * cos(c_DegToRad*launchElev) * aDt;
	GunPosY = (V0Y * sin(c_DegToRad*launchElev) * aDt) - (5 * aDt * aDt);

	dir.x() = static_cast<float> ( FirstPos.x() + ( GunPosX * sin (FDirection) ));
	dir.y() = static_cast<float> ( FirstPos.y() + ( GunPosX * cos (FDirection) ));
	dir.z() = static_cast<float> ( FirstPos.z() +  GunPosY );

	return dir;
}

// Asroc Trajectory [6/27/2012 DID RKT2]
void trajectory::Set_v0_Asroc(const double v0_Asroc){
	FAsroc_v0 = v0_Asroc;
}

void trajectory::Initialize_Asroc(const int typeOfAsroc, const double a){
	elev = a;
	if (typeOfAsroc == NellyHigh) {
		if ((elev >= 0.0) && (elev <= 13.99)){
			v0 = (1.3669 * pow(elev,2.0)) - (48.81 * elev) + 743.19 ;
			t2 = (-0.058 * pow(elev,2.0)) + (0.4194*elev)  + 3.1828 ;

			std::cout << "Nelly High a>0.0 & a<13.99" << std::endl;
		}
		else if ((elev >= 14.0) && (elev <= 22.0)){
			v0 = (-0.0179 * pow(elev,3.0)) + (1.3537 * pow(elev,2.0)) - (39.269 * elev) + 660.63 ;
			t2 = (-0.003  * pow(elev,2.0)) + (0.3412 * elev) + 3.7333 ;

			std::cout << "Nelly High a>14 & a<22" << std::endl;
		}
		else if ((elev >= 22.01) && (elev <= 45.0)){
			v0 = (0.0854  * pow(elev,2.0)) - (8.4785 * elev) + 404.55 ;
			t2 = (-0.0013 * pow(elev,2.0)) + (0.2591 * elev) + 4.7024 ;

			std::cout << "Nelly High a>22 & a<45" << std::endl;
		}
		maxRange = 3600;
		minRange = 2350;
	}
	else if (typeOfAsroc == NellyLow) {
		if ((elev >= 0.0) && (elev <= 13.99)){
			v0 = (0.4835 * pow(elev,2.0)) - (20.385 * elev) + 440.76 ;
			t2 = (-0.0078* pow(elev,2.0)) + (0.4601 * elev) + 1.1254 ;
		}
		else if ((elev >= 14.00) && (elev <= 21.99)){
			v0 = (0.2055 * pow(elev,2.0)) - (12.597 * elev) + 385.81 ;
			t2 = (-0.0034* pow(elev,2.0)) + (0.3395 * elev) + 1.9651 ;
		}
		else if ((elev >= 22.00) && (elev <= 25.99)){
			v0 = (0.3407 * pow(elev,2.0)) - (16.821 * elev) + 378 ;
			t2 = (-0.0013* pow(elev,2.0)) + (0.2408 * elev) + 3.1185 ;
		}
		else if ((elev >= 26.00) && (elev <= 45.00)){
			v0 = (0.0498 * pow(elev,2.0)) - (5.2551 * elev) + 297.16 ;
			t2 = (-0.0011* pow(elev,2.0)) + (0.2314 * elev) + 3.2883 ;
			std::cout << "Nelly Low a>26 & a<45, elev = " << elev << std::endl;
		}
		maxRange = 2350;
		minRange = 1620;
	}
	else if (typeOfAsroc == ErrikaHigh) {
		if ((elev >= 0.0) && (elev <= 22.00)){
			v0 = (-0.0185 * pow(elev,3.0)) + (1.1749 * pow(elev,2.0)) - (28.889 * elev) + 433.56;
			t2 = (-0.0034* pow(elev,2.0)) + (0.2876 * elev) + 1.6881 ;
		}
		else if ((elev >= 22.01) && (elev <= 45.00)){
			v0 = (0.0509 * pow(elev,2.0)) - (5.1012 * elev) + 257.49 ;
			t2 = (-0.001* pow(elev,2.0)) + (0.1859 * elev) + 2.7752 ;
		}
		maxRange = 1620;
		minRange = 1040;
	}
	else if (typeOfAsroc == ErrikaLow) {
		if ((elev >= 0.0) && (elev <= 22.00)){
			v0 = (0.3284 * pow(elev,2.0)) - (15.658 * elev) + 320.68 ;
			t2 = (-0.0022* pow(elev,2.0)) + (0.2009 * elev) + 1.6237 ;
		}
		else if ((elev >= 22.01) && (elev <= 45.00)){
			v0 = (0.0424 * pow(elev,2.0)) - (4.2159 * elev) + 204.46 ;
			t2 = (-0.0007* pow(elev,2.0)) + (0.1358 * elev) + 2.3256 ;
		}

		maxRange = 1040;
		minRange = 600;
	}
	else {
		maxRange = 3600;
		minRange = 600;
		v0 = 0.0;
	}

	ymax = (pow(v0,2.0) * pow(sin(elev*c_DegToRad),2.0)) / 20;
	xmax2 = 2 * (maxRange + (((elev-8.5) / (45-8.5)) * (minRange-maxRange)) - ((pow(v0,2.0)*sin(2*elev*c_DegToRad))/20));
	elev2 = c_RadToDeg * atan2((4*ymax), xmax2);
	v02 = (1/sin(elev2*c_DegToRad)) * (sqrt(20*ymax));
	tnew = (v02*sin(elev2*c_DegToRad)) / 10;

	std::cout << "elev : " << elev <<std::endl;
	std::cout << "v0 : " << v0 <<std::endl;
	std::cout << "ymax : " << ymax <<std::endl;
	std::cout << "xmax : " << xmax2 <<std::endl;
	std::cout << "elev2 : " << elev2 <<std::endl;
	std::cout << "v02 : "<< v02 <<std::endl;
	std::cout << "tnew : " << tnew <<std::endl;
}

osg::Vec3 trajectory::Calc_Movement_Asroc(const double aDt, const osg::Vec3 FirstPos, const double elev){
	osg::Vec3 dir;

	dir.x() = static_cast<double> ( FirstPos.x() + ( FAsroc_v0 * cos (elev * c_DegToRad) * aDt) * sin(FDirection));
	dir.y() = static_cast<double> ( FirstPos.y() + ( FAsroc_v0 * cos (elev * c_DegToRad) * aDt) * cos(FDirection));
	dir.z() = static_cast<double> ( FirstPos.z() + ( (FAsroc_v0 * sin (elev * c_DegToRad) * aDt) - (5 * pow(aDt,2.0))) );

	return dir;
}

osg::Vec3 trajectory::Calc_Movement_Asroc_2(const double aDt, const osg::Vec3 FirstPos){
	osg::Vec3 dir;

	double rumusan1 = v02 * cos (elev2 * c_DegToRad) * aDt;
	double rumusan2 = (pow(v0,2.0)*sin(2*elev*c_DegToRad)) / 20;
	double rumusan3 = (xmax2) / (2.0);
	dir.x() = static_cast<double> ( FirstPos.x() + ((rumusan1 + rumusan2 - rumusan3 )* sin(FDirection)));
	dir.y() = static_cast<double> ( FirstPos.y() + ((rumusan1 + rumusan2 - rumusan3 )* cos(FDirection)));
	dir.z() = static_cast<double> ( FirstPos.z() + ( (v02 * sin (elev2 * c_DegToRad) * aDt) - (5 * pow(aDt,2.0))) );

	return dir;
}

// RBU Trajectory [7/23/2012 DID RKT2]
osg::Vec3 trajectory::Calc_Movement_RBU(const double aDt, const osg::Vec3 FirstPos, const double elev){
	osg::Vec3 dir;

	dir.x() = static_cast<double> ( FirstPos.x() + ( FRBU_v0 * cos (elev * c_DegToRad) * aDt) * sin(FDirection));
	dir.y() = static_cast<double> ( FirstPos.y() + ( FRBU_v0 * cos (elev * c_DegToRad) * aDt) * cos(FDirection));
	dir.z() = static_cast<double> ( FirstPos.z() + ( (FRBU_v0 * sin (elev * c_DegToRad) * aDt) - (5 * pow(aDt,2.0))) );

	return dir;
}
osg::Vec3 trajectory::Calc_Movement_RBU_2(const double aDt, const osg::Vec3 FirstPos, const float diff){
	osg::Vec3 dir;

	double rumusan1 = v02 * cos (elev2 * c_DegToRad) * aDt;
	dir.x() = static_cast<double> ( FirstPos.x() + ((rumusan1 +  diff)* sin(FDirection)));
	dir.y() = static_cast<double> ( FirstPos.y() + ((rumusan1 + diff )* cos(FDirection)));
	dir.z() = static_cast<double> ( FirstPos.z() + ( (v02 * sin (elev2 * c_DegToRad) * aDt) - (5 * pow(aDt,2.0))) );

	return dir;
}

void trajectory::Set_v0_RBU(const double v0_RBU){
	FRBU_v0 = v0_RBU;
}

void trajectory::Initialize_RBU(const int typeOfRBU, const double a, const double rangeToTarget){
	elev = a;
	if (typeOfRBU == Balistik1) {
		if ((elev >= 0.0) && (elev <= 13.99)){
			v0 = (0.6371 * pow(elev,3.0)) - (24.978 * pow(elev,2.0)) + (328.17 * elev) - 1107.9 ;
			t2 = (-0.0032 * pow(elev,3.0)) + (0.1229 * pow(elev,2.0)) - (1.5157 * elev) + 7.3787 ;
		}
		else if ((elev >= 14.0) && (elev <= 22.0)){
			v0 = (-0.1502  * pow(elev,2.0)) + (2.6605 * elev) + 331.31;
			t2 = (0.0023  * pow(elev,2.0)) + (0.0095 * elev) + 0.9062 ;
		}
		else if ((elev >= 22.01) && (elev <= 45.0)){
			v0 = (0.049  * pow(elev,2.0)) - (5.4819 * elev) + 414.6 ;
			t2 = (0.0027 * pow(elev,2.0)) - (0.0203 * elev) + 1.3731 ;
		}
		maxRange = 1500;
		minRange = 500;
	}
	else if (typeOfRBU == Balistik2) {
		if ((elev >= 0.0) && (elev <= 13.99)){
			v0 = (0.6372 * pow(elev,3.0)) - (24.979 * pow(elev,2.0)) + (328.19* elev) - 1108 ;
			t2 = (-0.0092* pow(elev,3.0)) + (0.3546 * pow(elev,2.0)) - (4.3263* elev) + 21.024 ;
		}
		else if ((elev >= 14.0) && (elev <= 22.0)){
			v0 = (-0.1503  * pow(elev,2.0)) + (2.6611 * elev) + 331.31;
			t2 = (0.0082  * pow(elev,2.0)) + (0.0535 * elev) + 2.4432;
		}
		else if ((elev >= 22.01) && (elev <= 45.0)){
			v0 = (0.049  * pow(elev,2.0)) - (5.4817 * elev) + 414.6 ;
			t2 = (0.0104 * pow(elev,2.0)) - (0.0835 * elev) + 4.4701 ;
		}

		maxRange = 5500;
		minRange = 1500;
	}

	ymax = (v0 * sin(elev*c_DegToRad)*t2) - (5 * pow(t2,2.0));
	xmax2 = 2 * (maxRange + (((elev-8.5) / (45-8.5)) * (minRange-maxRange)) - ((pow(v0,2.0)*sin(2*elev*c_DegToRad))/20));
	elev2 =  c_RadToDeg * atan2((2*ymax) , (rangeToTarget - (v0 * cos (elev * c_DegToRad) * t2)));
	v02 = (1/sin(elev2*c_DegToRad)) * (sqrt(20*ymax));
	tnew = (v02*sin(elev2*c_DegToRad)) / 10;

	std::cout << "t2 : " << t2 <<std::endl;
	std::cout << "elev : " << elev <<std::endl;
	std::cout << "v0 : " << v0 <<std::endl;
	std::cout << "ymax : " << ymax <<std::endl;
	std::cout << "xmax : " << xmax2 <<std::endl;
	std::cout << "elev2 : " << elev2 <<std::endl;
	std::cout << "v02 : "<< v02 <<std::endl;
	std::cout << "tnew : " << tnew <<std::endl;
}