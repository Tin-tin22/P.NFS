#ifndef BASE_FUNCTION_H
#define BASE_FUNCTION_H

#include <osg/Math>
#include <osg/MatrixTransform>

/*		KONSTANTA		*/
//=======================//
const double c_Degree_To_NauticalMile    = 60.0;
const double c_NauticalMile_To_Degree    = 1.0/60.0;

const double c_NauticalMiles_To_Meter    = 1852.0;
const double c_Meter_To_NauticalMiles    = 1.0/1852.0;

const double c_NauticalMile_To_Feet      = 6076.131;

const double c_MilliSecondToHour		= 0.001 / 3600.0;
const double c_HourToMilliSecond		= 3600000.0;

const double c_MilliSecondToSecond  = 0.001;
const double c_SecondToMilliSecond  = 1000.0;

const double c_Meter_To_Feet             = 3.2808399;
const double c_Feet_To_Meter             = 1.0/ c_Meter_To_Feet;

const double c_NauticalMiles_To_Yard    = 2025.0;
const double c_Yard_To_NauticalMiles    = 1.0f/2025.0;

const double c_NauticalMile_To_Fathom   =  1012.68591;
const double c_Fathom_To_NauticalMile   =  1.0/1012.68591;

const double c_Kiloyards_To_Meter	= 914.4;

const double Pi   = osg::PI;
const double c_2_Pi = 2.0 * Pi;
const double c_180_per_Pi    = 180.0 / Pi;
const double Pi_per_180    = Pi / 180.0;

const double c_RadToDeg   = c_180_per_Pi;
const double c_DegToRad   = Pi_per_180;

const double MinZero    = 0.000000001f;       // lebih kecil dari  ini dianggap 0.0;

const double SPEED_OF_LIGHT		  = 299792460.0f  ;  // m per s
const double SPEED_OF_SOUND_IN_SEA = 1500.0f;  // (approx) m per s

/*		TYPE DATA		
======================= */
/*struct t2DPoint {
	double x;
	double y;
};*/


/*		FUNGSI2			
======================== */

// ==coordinate conversion==
inline osg::Vec2d ConvCoordPolar_To_Cartesian(const double aAngleRadian, const double aRadius)
{
	osg::Vec2d result;
	result.x() = aRadius * cos(aAngleRadian);
	result.y() = aRadius * sin(aAngleRadian);

	return result;
}

// ==distance conversion==
inline double ConvMeter_To_Feet(const double aMeter)
{
	return aMeter * 0.3048;
}

inline double ConvFeet_To_Meter(const double aMeter)
{
	return aMeter * 3.28083;
}

// ==direction conversion==
inline double ConvCartesian_To_Compass(const double degree)
{
	// input : derajat (0..360) dari sumbu X, CCW, cartesian
	// output: derajat (0..360) dari utara,   CW, kompas
	double result;
	result = 90.0 - degree;
	if(result < 0.0) 
		result = result + 360.0;
	return result;
}

inline double ConvCompass_To_Cartesian(const double degree)
{
	// input : derajat (0..360) dari utara,   CW, kompas
	// output: derajat (0..360) dari sumbu X, CCW, cartesian
	double result;
	result = 90.0 - degree;
	if (result < 0.0)
		result = result + 360.0;
	return result;
}

// ==speed conversion==
inline double ConvMeterPerSecond_To_KiloMeterPerHour(const double aMps)
{
	return aMps * 3.600;
}
inline double ConvKiloMeterPerHour_To_MeterPerSecond(const double aKmpH)
{
	return aKmpH * 10.0 / 36.0;
}
inline double ConvMeterPerSecond_To_FeetPerMinute(const double aMps)
{
	return aMps *  3.28 * 60.0;
}
inline double ConvMeterPerSecond_To_Knots(const double aMps)
{
	return (aMps / 1852.0) * 3600.0;
}
inline double ConvKnots_To_MeterPerSecond(const double aKts)
{
	return (aKts * 1852.0) / 3600.0;
}

inline double ConvMach_To_Knot(const double aSpdMach)
{
	return aSpdMach * 661.47;
}
inline double ConvKnot_To_Mach(const double aSpdKnot)
{
	return aSpdKnot * 0.0015118;
}
/*inline double GetMachLevel(const double atLevel)
{
	if(atLevel <  1005.0) return 661.7;
	else if (atLevel <  2005.0) return 659.2;
	else if (atLevel <  3005.0) return 657.2;
	else if (atLevel <  4005.0) return 654.9;
	else if (atLevel <  5005.0) return 652.6;
	else if (atLevel <  6005.0) return 650.3;
	else if (atLevel <  7005.0) return 647.9;
	else if (atLevel <  8005.0) return 645.6;
	else if (atLevel <  9005.0) return 643.3;
	else if (atLevel < 10005.0) return 640.9;
	else if (atLevel < 15005.0) return 638.6;
	else if (atLevel < 20005.0) return 626.7;
	else if (atLevel < 25005.0) return 614.6;
	else if (atLevel < 30005.0) return 602.2;
	else if (atLevel < 35005.0) return 589.5;
	else if (atLevel < 36089.0) return 576.6;
	else return 573.8;
}

inline double ConvMach_To_Knot(const double aSpdMach, const double atLevel)
{
	return aSpdMach * GetMachLevel(atLevel);
}
inline double ConvKnot_To_Mach(const double aSpdKnot, const double atLevel)
{
	return aSpdKnot / GetMachLevel(atLevel);
}*/

// ==direction==
// degree unit
inline double ValidateDegree(const double aDeg)
{
	double result;
	result = aDeg;
	while (result > 360.0)
	{
		result = result - 360.0;
	}
	while (result < 0.0)
	{
		result = result + 360.0;
	}
	return result;
}
// radian unit
inline double ValidateRadiant(const double aRad)
{
	double result;
	result = aRad;
	while (result > c_2_Pi)
	{
		result = result - c_2_Pi;
	}
	while (result < 0.0)
	{
		result = result + c_2_Pi;
	}
	return result;
}
inline double AddRadianClockWise(const double aRad, const double goCW)
{
	double result;
	result = aRad - goCW;
	while (result < 0.0)
	{
		result = result + c_2_Pi;
	}
	return result;
}
inline double AddRadianCounterClockWise(const double aRad, const double goCCW)
{
	double result;
	result = aRad + goCCW;
	while (result > c_2_Pi)
	{
		result = result - c_2_Pi;
	}
	return result;
}
inline double RadiantBack(const double aRad)
{
	double result;
	result = aRad + Pi;
	while (result > c_2_Pi) 
	{
		result = result - c_2_Pi;
	}
	return result;
}
inline bool IsRadiantDestAtLeft(const double src, const double dest)
{
	//return true jika dest dikiri src, cartesian, east = 0
	double back;
	back = ValidateRadiant(dest - src);
	return (back - Pi) < 0.0;
}

// ==Compas direction==
inline bool DegComp_IsBeetwen(const double aDegTes, const double aDeg1, const double  aDeg2)
{
	double d1, d2;
	d1 = (aDegTes-aDeg1);
	if (d1 < 0.0) d1 = d1+ 360.0;

	d2 = (aDeg2-aDeg1);
	if (d2 < 0.0) d2 = d2+ 360.0;

	return d1 < d2;
}

inline double Range3D(double x1, double y1, double z1, double x2, double y2, double z2)
{
	//X,Y dalam Degree, Z Dalam Ft
	return sqrtf(osg::square(x2-x1) + osg::square(y2-y1) + osg::square((z2-z1)/c_NauticalMile_To_Feet));
}

inline double RangeVec3(osg::Vec3 v1, osg::Vec3 v2)
{
	return sqrtf(osg::square(v2[0]-v1[0]) + osg::square(v2[1]-v1[1]) + osg::square(v2[2]-v1[2]));
}

inline osg::Vec2 NextPost2D(osg::Vec2 PrePost, int speed,double Heading, double deltaT)
{
	//DeltaT dalam Jam, speed dalam knot
	double speed_x,speed_y;
    double dx,dy;
	osg::Vec2 result;
	
	speed_x = speed * cos(osg::DegreesToRadians(Heading));
	speed_y = speed * sin(osg::DegreesToRadians(Heading));

	dx = speed_x * deltaT;
	dy = speed_y * deltaT;

	result.x() = PrePost.x() + c_NauticalMile_To_Degree * dx;
	result.y() = PrePost.y() + c_NauticalMile_To_Degree * dy;

	return result;
}

inline float NorthToEast(float degree)
{
	float frac;
	int degInt;

	//input: derajat (0..360) dari utara, CW, kompas}
	//ouput: derajat (0..360) dari sumbu X, CCW, cartesian }
	frac = degree - floor(degree);
	degInt =  static_cast<int>((359 - osg::round(degree) )+90 ) % 360;
	return degInt + (1-frac);
}

inline double InitDir(int iCount, double sh)
{
	double dir;
	if ((iCount % 2) == 0)	//kiri
		dir =  sh - 60.0;
	else					// kanan
		dir = sh + 60.0;

	ValidateDegree(dir);
	return dir;

};



#endif