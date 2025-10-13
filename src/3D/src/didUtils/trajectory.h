#ifndef TRAJECTORY
#define TRAJECTORY

#ifdef USE_VLD

#include <vld.h>

#endif

#include <osg/Math>
#include <osg/MatrixTransform>
#include <iostream>

class trajectory{
  public:
    trajectory();
    virtual ~trajectory();
    void Calc_Speed(const double aDt);      // if accelerate	
    void Calc_SpeedTorp(const double aDt);
    void Calc_Direction(const double aDt);  // if turn
    void Calc_Elevation(const double aDt);  // if turn elevation
    osg::Vec3 Calc_Movement(const double aDt);   //
    osg::Vec3 Calc_MovementTorp(const double aDt);   //

	//Nando Added For Cannon
	double Sigmoid(const double t);

	//For Gun 76 Low Balistik
	double Gun_76Low_TimeToSpeedX(const double t);
	double Gun_76Low_TimeToRange(const double t);
	double Gun_76Low_TimeToHeight(const double t, const double maxT, const double maxHeight);
	double Gun_76Low_ElevToRange(const double GunElev);
	double Gun_76Low_ElevToHeight(const double GunElev);
	double Gun_76Low_RangeToTOF(const double GunRange);
	double Gun_76Low_RangeToElev(const double GunRange);
	osg::Vec3 Calc_Movement_CannonProjectile_76Low_byElev(const double aDt, const osg::Vec3 FirstPos,
				const double launchElev, double HeightMax, double TimeMax);
	
	//For Lock Air 
	double SearchLowAngel(const double TargetRange, const double TargetHeight);
	
	//For Gun 76 High Balistik
	double Gun_76High_TimeToHeight(const double t, const double maxT, const double maxHeight);
	double Gun_76High_ElevToRange(const double GunElev);
	double Gun_76High_ElevToHeight(const double GunElev);
	double Gun_76High_ElevToTOF(const double GunElev);
	double Gun_76High_RangeToTOF(const double GunRange);
	double Gun_76High_RangeToElev(const double GunRange);
	double Gun_76High_HeightToTime(const double Height, const double HeightMax, const double TimeMax);
	osg::Vec3 Calc_Movement_CannonProjectile_76High_byElev(const double aDt, const osg::Vec3 FirstPos,
				const double launchElev, double RangeMax, double HeightMax, double TimeMax, double TimeAX );

	//For Lock Air 
	double SearchHighAngel(const double TargetRange, const double TargetHeight);

	//For Gun 120
	double Gun_120_RangeToElev(const double GunRange);
	double Gun_120_GetV0X_ByElev(const double GunElev);
	double Gun_120_GetV0Y_ByElev(const double GunElev);
	osg::Vec3 Calc_Movement_CannonProjectile_120_byElev(const double aDt, const osg::Vec3 FirstPos, 
				const double launchElev, const double V0X, const double V0Y);

	//For Gun 40
	double Gun_40_RangeToElev(const double GunRange);
	double Gun_40_GetV0X_ByElev(const double GunElev);
	double Gun_40_GetV0Y_ByElev(const double GunElev);
	osg::Vec3 Calc_Movement_CannonProjectile_40_byElev(const double aDt, const osg::Vec3 FirstPos,
				const double launchElev, const double V0X, const double V0Y);


	// Asroc Trajectory [6/27/2012 DID RKT2]
	osg::Vec3 Calc_Movement_Asroc(const double aDt, const osg::Vec3 FirstPos, const double elev);
	osg::Vec3 Calc_Movement_Asroc_2(const double aDt, const osg::Vec3 FirstPos);
	void Set_v0_Asroc(const double v0_Asroc);
	void Initialize_Asroc(const int typeOfAsroc, const double elev);

	osg::Vec3 Calc_Movement_RBU(const double aDt, const osg::Vec3 FirstPos, const double elev);
	osg::Vec3 Calc_Movement_RBU_2(const double aDt, const osg::Vec3 FirstPos, const float diff);
	void Set_v0_RBU(const double v0_Asroc);
	void Initialize_RBU(const int typeOfAsroc, const double elev, const double rangeToTarget);

    double GetDirection();
    void SetDirection(const double value); // value dalam degree

    double GetElevation();
    void SetElevation(const double value); // value dalam degree

    double GetTurnRate();
    void SetTurnRate(const double value);  // value dalam degree

    double GetElevTurnRate();
    void SetElevTurnRate(const double value); // value dalam degree/sec

    double GetAcceleration();
    void SetAcceleration(const double value); // value dalam m/s2

    double GetSpeed();
    void SetSpeed(const double value); // value dalam  mach

    double GetSpeedKnot();
    void SetSpeedKnot(const double value); // value dalam  knot

    double GetDeltaDir();

	double 	elev, elev2 ;
	double	v0, v02, t2, tnew;
	double 	maxRange;
	double 	minRange;
	double ymax,xmax2, sisaJarak;

  private:
  	
    double FDirection;		// dalam rad 
    double FElevation;		// dalam rad
    double FTurnRate;		// dalam rad/s   
    double FElevTurnRate;	// dalam rad/s
    double FAcceleration;	// dalam m/s2                
    double FSpeed ;			// dalam m/s      
    double FSpeedTorp;		// dalam m/s
    double FDeltaDir;		// dalam rad
    double FDeltaElev;		// dalam rad 

    double FSinX, FCosX, FSinZ, FCosZ;

	// Asroc [6/27/2012 DID RKT2]
	double FAsroc_v0;

	// RBU [7/23/2012 DID RKT2]
	double FRBU_v0;
	
	enum TypeOfAsroc
	{
		B = 0
		, ErrikaLow
		, ErrikaHigh
		, NellyLow
		, NellyHigh
	};

	// Tipe RBU [7/23/2012 DID RKT2]
	enum TypeOfRBU
	{
		C = 0
		, Balistik1
		, Balistik2
	};

};

#endif
