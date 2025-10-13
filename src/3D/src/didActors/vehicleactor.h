#ifndef APP_VEHICLE_ACTOR
#define APP_VEHICLE_ACTOR

#ifdef USE_VLD
#include <vld.h>
#endif
#include "didactorsheaders.h"

namespace dtCore
{
	class Object;
}

namespace dtDAL
{
	class ActorProxyIcon;
}

class DID_ACTORS_EXPORT VehicleActor : public dtGame::GameActor
{
public:
	class DID_ACTORS_EXPORT CoordSys : public dtUtil::Enumeration
	{
		DECLARE_ENUM(CoordSys);

		public:
			static CoordSys SYS_ABS;
			static CoordSys SYS_REL;
	    
		private:
			CoordSys(const std::string &name) : dtUtil::Enumeration(name)
			{
			   AddInstance(this);
			}
	};

	/// Constructor
	VehicleActor(dtGame::GameActorProxy &proxy);

	virtual void MoveVehicle(double deltaTime);
	virtual void UpdatePosition(float elapsedTime);
	virtual void SetModelPosition();

	void Update(float elapsedTime);
	void UpdateRudder(float elapsedTime);
	void UpdateAddAngle(float elapsedTime);
	void UpdateThrottle(float elapsedTime);
	void UpdateSpeed(float elapsedTime);
	void UpdateEffRudderAndHeel(float elapsedTime);
	void UpdateCourse(float elapsedTime);
	void UpdateVerRudder(float elapsedTime);
	void UpdateVerEffRudderAndTrim(float elapsedTime);
	void UpdatePitch(float elapsedTime);
	void UpdateStatusTargetSwitch(  const int idxSwitch, const std::string sts, const osg::Vec3 vpos, const int Lethality);

	// To Movement Speed Vehicle [6/20/2013 DID RKT2]
	void Acceleration_GoForward(float elapsedTime);
	void Acceleration_GoBack(float elapsedTime);
	void Deceleration_GoForward(float elapsedTime);
	void Deceleration_GoBack(float elapsedTime);
	void Deceleration_GoBack2(float elapsedTime);

	void SetVehicleID(int val) { mVehicleID = val;}
	void SetPosition(dtCore::Transform newPosition){position = newPosition;};	
	void SetPitch(float ptc){pitch = ptc;};
	void SetDesiredRudderAngle(float rudder);	
	void SetVerRudderAngle(float f){VerRudderAngle= f;};
	void SetVerEffRudderAngle(float f){VerEffRudderAngle= f;};
	void SetShaftHP(float shp){shaftHP = shp;};
	void SetTrimFactor(float tTrimFactor){trim = tTrimFactor;};
	void SetThrottleRate(float engineRate){throttleRate = engineRate;};
	void SetThrottle(float p){throttle= p;};
	void SetRudderAngle(float p){rudderAngle= p;};
	void SetEffRudderAngle(float p){effRudderAngle= p;};
	void SetDesiredThrottle(float p){desiredThrottle= p;};

	/*
	* The Tactical Diameter is the diameter a ship can turn within (once 
	* heeled) at 15 knots speed with 15 degrees rudder ordered.  All other
	* speed/rudder combinations will be derived from this number.  1000 
	* yards is a reasonable default as it is used for Naval multi-ship 
	* maneuvers.
	*/
	void SetTacticalDiameter(float diameter = 1000.0f){tacticalDiameter = diameter;};

	void SetRudderSwingRate(float tRudderSwingRate){rudderSwingRate = tRudderSwingRate;};
	void SetDisplacement(float tonnage){displacement = tonnage;};

	/**
	* The list of the ship during a turn.
	*/
	void SetHeel(float p){heel= p;};

	void SetHeelFactor(float tHeelFactor){heelFactor = tHeelFactor;};
	void SetMaxRudderAngle(float maxRudder){maxRudderAngle = maxRudder;};
	void SetMaxAheadSpeed(float maxAhdSpd){maxAheadSpeed = maxAhdSpd;};
	void SetMaxAsternSpeed(float maxAstnSpd){maxAsternSpeed = maxAstnSpd;};
	void SetIsTarget( const bool val ) {mInitSwitchTarget = val; };
	void SetNight( const bool state ){mIsNight = state; };
	void SetVerDesiredRudderAngle(float rudder);
	void SetDesiredAddAngle(float p){desiredAddAngle= p;};
	void SetModeGuidance(int g){modeGuidance = g;};
	void SetModeAltitude(int g){modeAltitude = g;};
	void SetDamage(int g){damage = g;};

	/*
	* Desired speed in knots.  Ensures the desiredSpeed is within max
	* ahead and max astern values.
	*/
	void SetDesiredThrottlePosition(float desiredSpeed);

	/*
	* Setting speed will change the speed immediately.  If a realistic
	* speed adjustment is desired, set the desired throttle position and
	* the speed will eventually change to the proper position.
	*/

	void SetSpeed(float spd);

	/*
	* Setting course will change the course immediately.  If a realistic
	* course adjustment is desired, set the desired rudder angle and
	* monitor the course until the proper course is achieved.
	*/
	void SetCourse(float crs);

	void InitTargetSwitch();
	void ShipHitByPosition(osg::Vec3 pos, int Lethality );
	void StartEngines(){mEngineRunning = true;};
	void ShutDownEngines(){mEngineRunning = false;};
	void SetCoordSys(CoordSys &sys){mCoordSys = &sys;};	

	float GetSpeed(){return speed;};	
	float GetDamage(){return damage;};
	float GetTrim(){return trim;};
	float GetMaxRudderAngle(){return maxRudderAngle;};
	float GetMaxAheadSpeed(){return maxAheadSpeed;};
	float GetMaxAsternSpeed(){return maxAsternSpeed;};
	float GetRudderSwingRate(){return rudderSwingRate;};	
	float GetHeelFactor(){return heelFactor;};
	float GetHeel(){return heel;};
	float GetCourse(){return course;};	
	float GetVerEffRudderAngle(){return VerEffRudderAngle;};
	float GetVerRudderAngle(){return VerRudderAngle;};
	float GetVerDesiredRudderAngle(){return VerDesiredRudderAngle;};
	float GetPitch(){return pitch;};
	float GetThrottleRate(){return throttleRate;};
	float GetTacticalDiameter(){return tacticalDiameter;};
	float GetShaftHP(){return shaftHP;};
	float GetDisplacement(){return displacement;};
	float GetDesiredRudderAngle(){return desiredRudderAngle;};
	float GetDesiredAddAngle(){return addAngle;};
	float GetThrottle(){return throttle;};
	float GetRudderAngle(){return rudderAngle;};
	float GetEffRudderAngle(){return effRudderAngle;};
	float GetDesiredThrottle(){return desiredThrottle;};

	bool GetIsTarget( ) {return mInitSwitchTarget; };
	bool IsNight( ) {return mIsNight; };

	int GetModeGuidance(){return modeGuidance;};
	int GetModeAltitude(){return modeAltitude;};

	dtCore::Transform GetPosition(){return position;};
	int GetVehicleID() { return mVehicleID;}
	CoordSys& GetCoordSys(){return *mCoordSys;};

	std::vector<dtCore::Scene::CollisionData> mCollisionData;

protected:
      
	bool mEngineRunning;
	CoordSys *mCoordSys;
	dtCore::Transform position;

	float speed;
	float pitch;
	float VerRudderAngle;
	float VerDesiredRudderAngle;
	float VerEffRudderAngle;	
	float trim;	
	float trimFactor;
	float maxRudderAngle;		//degrees (+/-)
	float maxAsternSpeed;		//knots
	float addAngle;		// BAWE-20101206: SEPERATE_RUDDER_AND_ADDANGLE
	float course;				//0 <= degrees < 360, absolute course
	float desiredThrottle;		//knots, desired throttle
	float desiredRudderAngle;	//degrees
	float desiredAddAngle;		// BAWE-20101206: SEPERATE_RUDDER_AND_ADDANGLE
	float maxAheadSpeed;		//knots
	float effRudderAngle;		//degrees (+/-), considers momentum of ship
	float rudderAngle;			//degrees, actual rudder angle
	float throttle;				//knots, answered throttle 
	float throttleRate;			//knots/second, (engine spool)
	float rudderSwingRate;		//degrees/second, movement of rudder
	float tacticalDiameter;		//yards
	float heel;					//degrees
	float displacement;			//tons
	float heelFactor;			//heeling tendency, 0..1
	float shaftHP;				//shaft horsepower

	float deltaTime,xtime; // dt from sampling [6/18/2013 DID RKT2]
	float lastSpeed, lastSpeed2; // last speed [6/19/2013 DID RKT2]
	bool IsGetLastSpeed, IsGetLastSpeed2, isStepOne; //  [6/19/2013 DID RKT2]
	bool IsUpdateSpeed; //  [6/19/2013 DID RKT2]

	bool mIsNight;
	bool mInitSwitchTarget;

	int modeGuidance;
	int modeAltitude;
	int damage;
	
	dtCore::RefPtr <osg::Switch> targetswitches; 
	dtCore::RefPtr<dtAudio::Sound> stackSound;
	dtCore::Transform stackSoundPosition;

	/// Destructor
	virtual ~VehicleActor();

	void SetStackSound(dtAudio::Sound *tStackSound, dtCore::Transform tStackSoundPosition);
	void PlayStackSound();
	void StopStackSound();
	void FreeSound(dtAudio::Sound *tmpSound);
	void CeckDataCollision();
	void UpdateStatusSoundCollision(int OrderID, int mValue );

private:
	int mVehicleID;
	//std::vector<dtCore::Scene::CollisionData> mCollisionData;

	float GetAdjustedTacticalPitch();

	/*
	* Adjusted Tactical Diameter is a function of speed and ruddeer angle.
	* The adjustment is based on the graph of the function f(x) = x/(x^2).
	* It is a loose approximation of the effects of speed and rudder angle
	* on the tactical diameter.
	*/
	float GetAdjustedTacticalDiameter();   
};

class DID_ACTORS_EXPORT VehicleActorProxy : public dtGame::GameActorProxy
{
public:
	/// Constructor
	VehicleActorProxy();

	/// Builds the properties of this actor
	virtual void BuildPropertyMap();

	/// Builds the invokables of this actor
	virtual void BuildInvokables();

	/// Instantiates the actor itself
	virtual void CreateActor() { SetActor(*new VehicleActor(*this)); }

	/**
	* Gets the billboard used to represent static meshes if this proxy's
	* render mode is RenderMode::DRAW_BILLBOARD_ICON.
	* @return
	*/
	dtDAL::ActorProxyIcon* GetBillBoardIcon();

	virtual const dtDAL::ActorProxy::RenderMode& GetRenderMode()
	{
		return dtDAL::ActorProxy::RenderMode::DRAW_ACTOR_AND_BILLBOARD_ICON;
	};


protected:
	/// Destructor
	virtual ~VehicleActorProxy();
	virtual void OnEnteredWorld();

private:
	dtCore::RefPtr<dtDAL::ActorProxyIcon> mBillboardIcon;
};

#endif