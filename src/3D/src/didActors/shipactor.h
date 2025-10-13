#ifndef APP_SHIP_ACTOR
#define APP_SHIP_ACTOR

#ifdef USE_VLD

#include <vld.h>

#endif

#include "didactorsheaders.h"
#include "vehicleactor.h"

namespace dtCore
{
	class ParticleSystem;
}

namespace dtAudio
{
	class Sound;
}

class DID_ACTORS_EXPORT ShipActor : public VehicleActor
{
public:  
	class DID_ACTORS_EXPORT LampTypes : public dtUtil::Enumeration
	{
		DECLARE_ENUM(LampTypes);

	public:
			static LampTypes ANCHOR_LIGHT; 
			static LampTypes STERN_LIGHT;	
			static LampTypes MASTHEAD_LIGHT;	
			static LampTypes MASTHEAD_LIGHT2;	
			static LampTypes PORT_LIGHT;			
			static LampTypes STARBOARD_LIGHT;
			static LampTypes SPECIAL_LIGHT_TOP;	
			static LampTypes SPECIAL_LIGHT_MIDDLE;	
			static LampTypes SPECIAL_LIGHT_BOTTOM;		
			static LampTypes OPS_DANGER_LIGHT_PAIR;
			static LampTypes SPECIAL_CBD_MODE;
			static LampTypes SPECIAL_RAM_MODE;
			static LampTypes SPECIAL_NUC_MODE;

			int GetValue() { return mCValue; }

	private:
			LampTypes(const std::string &name, const int cValue) : 
			dtUtil::Enumeration(name), mCValue(cValue)
			{
				AddInstance(this);
			}
			const int mCValue;
	};

	class DID_ACTORS_EXPORT ThrottlePosition : public dtUtil::Enumeration
	{
		DECLARE_ENUM(ThrottlePosition);
	
	public:
		static ThrottlePosition BACK_EMERGENCY; //max astern speed
		static ThrottlePosition BACK_FULL;		//~-15 knots
		static ThrottlePosition BACK_TWO_THIRDS;	//~-10 knots
		static ThrottlePosition BACK_ONE_THIRD;	//~-5 knots ordered
		static ThrottlePosition STOP;			//zero knots ordered
		static ThrottlePosition AHEAD_ONE_THIRD;	//~5 knots ordered
		static ThrottlePosition AHEAD_TWO_THIRDS;	//~10 knots ordered
		static ThrottlePosition AHEAD_STANDARD;	//~15 knots ordered
		static ThrottlePosition AHEAD_FULL;		//~20 knots ordered
		static ThrottlePosition AHEAD_FLANK;		//max ahead speed
	 
		int GetValue() { return mCValue; }

	 private:
		ThrottlePosition(const std::string &name, const int cValue) : 
		   dtUtil::Enumeration(name), mCValue(cValue)
		{
		   AddInstance(this);
		}

		const int mCValue;
	};

	/// Constructor
	ShipActor(dtGame::GameActorProxy &proxy);

	void EngageShaft(){shaftEngaged = true;};
	void DisengageShaft(){shaftEngaged = false;};

	void SetCameraAttached( const bool state ) {mIsCameraAttached = state; };	
	void SetIsTarget( const bool val ) {mInitSwitchTarget = val; };

	bool GetIsTarget( ) {return mInitSwitchTarget; };
	bool IsCameraAttached( ) {return mIsCameraAttached; };

protected:
	bool CheckWake(dtCore::ParticleSystem* wake);

	dtCore::RefPtr<dtCore::ParticleSystem> stbdWake;

	dtCore::RefPtr<dtAudio::Sound> wakeSound;

	dtCore::Transform portWakePosition;
	dtCore::Transform stbdWakePosition;
	dtCore::Transform portBowWakePosition;
	dtCore::Transform stbdBowWakePosition;
	dtCore::Transform portRoosterPosition;
	dtCore::Transform stbdRoosterPosition;
	dtCore::Transform wakeSoundPosition;

	bool shaftEngaged;
	bool mIsCameraAttached;

protected:
	virtual ~ShipActor();

private:
public :
};

class DID_ACTORS_EXPORT ShipActorProxy : public VehicleActorProxy
{
public:
	/// Constructor
	ShipActorProxy();

	/// Builds the properties of this actor
	virtual void BuildPropertyMap();

	/// Builds the invokables of this actor
	virtual void BuildInvokables();

	/// Instantiates the actor itself
	virtual void CreateActor() { SetActor(*new ShipActor(*this)); }

protected:
	/// Destructor
	virtual ~ShipActorProxy();

private:
};

#endif