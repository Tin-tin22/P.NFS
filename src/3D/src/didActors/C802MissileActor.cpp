// $Id: C802MissileActor.cpp

/**
 * @file C802MissileActor.cpp
 *
 * @author Bawenang R. P. P.
 *
 * @date February 27th, 2012
 *
 * @brief The source file for C802MissileActor actor.
 *
 * C802MissileActor is the class for the C802 Yingji Missile.
 *
 */
 
//++ BAWE-20120227: C802_MISSILE_ACTOR
 
//INCLUDES
#include "C802MissileActor.h"
#include "didactorssources.h"

#include <dtDAL/intactorproperty.h>
#include <dtDAL/floatactorproperty.h>

//++ Constants
const int C802MissileActor::GATE_NEAR = 0;                              // Near Gate setting. 10km <= R <= 15km.
const int C802MissileActor::GATE_FAR1 = 1;                              // Far 1 Gate setting. 15km < R <= 25km. 
const int C802MissileActor::GATE_FAR2 = 2;                              // Far 2 Gate setting. R > 25km. Default. If gate > Far1 Gate, then gate = Far gate.

const float C802MissileActor::K0_TIME = 1.2f;       
const float C802MissileActor::K1_TIME = 8.0f;
const float C802MissileActor::K2_TIME = 19.0f;
const float C802MissileActor::SELF_CONTROL_FLIGHT_TIME_MIN = 10.0f;     // Minimum mSelfControlFlightTime (K3_TIME). K5 = K3 + 2.5s
const float C802MissileActor::SELF_CONTROL_FLIGHT_TIME_MAX = 400.0f;    // Maximum mSelfControlFlightTime (K3_TIME). K5 = K3 + 2.5s
const float C802MissileActor::ALTITUDE_MAX = 125.0f;                    // Maximum altitude of the missile at HALF phase / C-D (+- 130-140 meters). 128 meters so it can turn first with the pitch to 0 degree.
const float C802MissileActor::ALTITUDE_G   = 110.0f;                    // The altitude to send G command (dive to cruise altitude)
const float C802MissileActor::ALTITUDE_CRUISE_START = 60.0f;            // The altitude to start Level Flight Phase (E-F). 49 meters so the missile can pitch to 0 degree at ALTITUDE_CRUISE_LEVEL, hopefully.
const float C802MissileActor::ALTITUDE_CRUISE_LEVEL = 20.0f;            // Cruise altitude at Level Flight Phase (E-F). 
const float C802MissileActor::DISTANCE_CLIMB_PHASE = 400.0f;            // Distance from ship before detaching booster and starting the climb phase (+- 500 meters)
const float C802MissileActor::HIGH_SEA_STATE_ALT = 7.0f;                // Diving altitude if the sea state is high (>3)
const float C802MissileActor::LOW_SEA_STATE_ALT = 5.0f;                 // Diving altitude if the sea state is low (<=3)
const float C802MissileActor::DIVING_COMMAND_RANGE = 500.0f;            // Max range to locked target to send the diving command in Diving Phase



//-- Constants
 
 //++ C802MissileActorProxy

///////////////////////////////////////////////////////////////////////////////
C802MissileActorProxy::C802MissileActorProxy()
{
   SetClassName("C802 Missile Actor");
}

///////////////////////////////////////////////////////////////////////////////
void C802MissileActorProxy::BuildPropertyMap()
{
   //const std::string GROUP = "Base Missile Actor";
   const std::string GROUP = C_TYPE_MISSILE;

   BaseMissileActorProxy::BuildPropertyMap();
   C802MissileActor* actor = NULL;
   GetActor(actor);
   

       
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    AddProperty(new dtDAL::FloatActorProperty(C_MSG_COURSE_LEAD_ANGLE,C_MSG_COURSE_LEAD_ANGLE,
        dtDAL::FloatActorProperty::SetFuncType(actor, &C802MissileActor::SetCourseLeadAngle),
        dtDAL::FloatActorProperty::GetFuncType(actor, &C802MissileActor::GetCourseLeadAngle), 
        "Sets/gets speed.", GROUP));

    AddProperty(new dtDAL::FloatActorProperty(C_MSG_PITCH_ANGLE,C_MSG_PITCH_ANGLE,
        dtDAL::FloatActorProperty::SetFuncType(actor, &C802MissileActor::SetPitchAngle),
        dtDAL::FloatActorProperty::GetFuncType(actor, &C802MissileActor::GetPitchAngle), 
        "Sets/gets max speed.", GROUP));
        
    AddProperty(new dtDAL::FloatActorProperty(C_MSG_ROLL_ANGLE,C_MSG_ROLL_ANGLE,
        dtDAL::FloatActorProperty::SetFuncType(actor, &C802MissileActor::SetRollAngle),
        dtDAL::FloatActorProperty::GetFuncType(actor, &C802MissileActor::GetRollAngle), 
        "Sets/gets speed.", GROUP));

    AddProperty(new dtDAL::FloatActorProperty(C_MSG_SELF_CTRL_FL_TIME,C_MSG_SELF_CTRL_FL_TIME,
        dtDAL::FloatActorProperty::SetFuncType(actor, &C802MissileActor::SetSelfControlFlightTime),
        dtDAL::FloatActorProperty::GetFuncType(actor, &C802MissileActor::GetSelfControlFlightTime), 
        "Sets/gets max speed.", GROUP));

    AddProperty(new dtDAL::IntActorProperty(C_MSG_SEA_STATE,C_MSG_SEA_STATE,
        dtDAL::IntActorProperty::SetFuncType(actor, &C802MissileActor::SetSeaState),
        dtDAL::IntActorProperty::GetFuncType(actor, &C802MissileActor::GetSeaState), 
        "Sets/gets speed.", GROUP));

    AddProperty(new dtDAL::FloatActorProperty(C_MSG_SELF_GUIDE_RNG_GATE,C_MSG_SELF_GUIDE_RNG_GATE,
        dtDAL::FloatActorProperty::SetFuncType(actor, &C802MissileActor::SetSelfGuideRangeGate),
        dtDAL::FloatActorProperty::GetFuncType(actor, &C802MissileActor::GetSelfGuideRangeGate), 
        "Sets/gets max speed.", GROUP));                

    AddProperty(new dtDAL::IntActorProperty(C_MSG_PHASE,C_MSG_PHASE,
        dtDAL::IntActorProperty::SetFuncType(actor, &C802MissileActor::SetPhase),
        dtDAL::IntActorProperty::GetFuncType(actor, &C802MissileActor::GetPhase), 
        "Sets/gets max speed.", GROUP));            
        
}

///////////////////////////////////////////////////////////////////////////////
void C802MissileActorProxy::BuildInvokables()
{           
    BaseMissileActorProxy::BuildInvokables();
}

///////////////////////////////////////////////////////////////////////////////
void C802MissileActorProxy::CreateActor()
{
   SetActor(*new C802MissileActor(*this));
}

///////////////////////////////////////////////////////////////////////////////
void C802MissileActorProxy::OnEnteredWorld()
{
    // Note we did not create any of these Invokables.  ProcessMessage(), TickLocal(),
    // and TickRemote() are created for us in GameActorProxy::BuildInvokables().

    //Register an invokable for C802_EVENT
    //RegisterForMessages(SimMessageType::C802_EVENT, dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
    RegisterForMessages(SimMessageType::C802_EVENT);        

    BaseMissileActorProxy::OnEnteredWorld();    
}

//-- C802MissileActorProxy



//++ C802MissileActor

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                  Constructor / destructor
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Constructs a default base missile actor.
 * @param proxy The actor proxy owning this task actor.
 */
C802MissileActor::C802MissileActor(dtGame::GameActorProxy& proxy)
                : BaseMissileActor(proxy)
                , mCourseLeadAngle (0.0f)
                , mPitchAngle (0.0f)
                , mRollAngle (0.0f)
                , mSelfControlFlightTime (0.0f)
                , mSeaState (0)
                , mSelfGuideRangeGate (0)         
                , mPhase(PHASE_NONE)               

{
    SetMissileType(CT_C802);
    
    SetMaxLifeParamType(MAX_LIFE_DISTANCE);
    SetMaxLifeParamValue(130000); //130km max distance
    
    //Set missile konfigurasi
    SetMaxSpeed(DEF_MACH_TO_METRE * 0.9f);  //Max speed = 0.9 mach
    SetAcceleration(1000.0f);               //Missile acceleration 1000 m/s2 (maybe)
    
    SetSensor(new BaseSensor());
    GetSensor()->SetAngle(22.16); //NEAR
    GetSensor()->SetRadius(5000); //NEAR = 9KM FROM TARGET
}

/**
 * Destroys a default base missile actor.
 */
//C802MissileActor::~C802MissileActor()
//{
//
//}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                  Mutator / accessor methods
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

void C802MissileActor::SetCourseLeadAngle(float val)
{
    mCourseLeadAngle = val;
}
float C802MissileActor::GetCourseLeadAngle()
{
    return mCourseLeadAngle;
}

void C802MissileActor::SetPitchAngle(float val)
{
    mPitchAngle = val;
}
float C802MissileActor::GetPitchAngle()
{
    return mPitchAngle;
}

void C802MissileActor::SetRollAngle(float val)
{
    mRollAngle = val;           
}
float C802MissileActor::GetRollAngle()
{
    return mRollAngle;
}

void C802MissileActor::SetSelfControlFlightTime(float val)
{
    mSelfControlFlightTime = val;
    dtUtil::Clamp(mSelfControlFlightTime, SELF_CONTROL_FLIGHT_TIME_MIN,  SELF_CONTROL_FLIGHT_TIME_MAX);
}
float C802MissileActor::GetSelfControlFlightTime()
{
    return mSelfControlFlightTime;
}

void C802MissileActor::SetSeaState(int val)
{
    mSeaState = val;
}
int C802MissileActor::GetSeaState()
{
    return mSeaState;
}

void C802MissileActor::SetSelfGuideRangeGate(int val)
{
    mSelfGuideRangeGate = val;
    switch (val)
    {
        case GATE_NEAR:
            GetSensor()->SetAngle(22.16); //NEAR
            GetSensor()->SetRadius(5000); //NEAR = 5KM HOMING RANGE
            break;
        case GATE_FAR1:
            GetSensor()->SetAngle(22.16); //FAR
            GetSensor()->SetRadius(9000); //FAR = 9KM HOMING RANGE
            break;
        case GATE_FAR2:
        default:
            GetSensor()->SetAngle(22.16); //FAR
            GetSensor()->SetRadius(9000); //FAR = 9KM HOMING RANGE
            break;

    }
}
int C802MissileActor::GetSelfGuideRangeGate()
{
    return mSelfGuideRangeGate;    
}

void C802MissileActor::SetPhase(int val)
{
    mPhase = val;    
}
int C802MissileActor::GetPhase()
{
    return mPhase;
}

void C802MissileActor::OnEnteredWorld()
{
    BaseMissileActor::OnEnteredWorld();
    
    AddSender(&(GetGameActorProxy().GetGameManager()->GetScene()));
}

/**
 * Determine the changes of the missiles based on the rules. Should be overloaded by each concrete missile classes. Empty function in this class.  
 *
 */
void C802MissileActor::DetermineBehaviour(float dt)
{
    if (IsLaunched())
    {
        
        //Check behaviour per-phase
        switch(mPhase)
        {
            case PHASE_BOOST:           //A-B
                OnPhaseBoost();
                break;
            case PHASE_CLIMB:           //B-C
                OnPhaseClimb();
                break;
            case PHASE_HALF:            //C-D. High Altitude Level Flight Phase.
                OnPhaseHALF();
                break;
            case PHASE_GLIDING:         //D-E
                OnPhaseGliding();
                break;
            case PHASE_LEVEL_FLIGHT:    //E-F
                OnPhaseLevelFlight();
                break;
            case PHASE_SAD:             //F-G-H. Secondary Altitude Descending Phase.
                OnPhaseSAD();
                break;
            case PHASE_DIVING:          //H-I
                OnPhaseDiving();
                break;

        }
    }    
}


void C802MissileActor::ProcessMessage(const dtGame::Message &message)
{
    BaseMissileActor::ProcessMessage(message);
    
//    std::cout<<"void C802MissileActor::ProcessMessage(const dtGame::Message &message)"<< std::endl;
	if(GetGameActorProxy().IsInGM()){
		if(message.GetMessageType().GetName() == SimMessageType::C802_EVENT.GetName())
		{
			ProcessOrderEvent(message);
		}
	}
}

void C802MissileActor::ProcessOrderEvent(const dtGame::Message &message)
{
    const MsgSetC802 &Msg = static_cast<const MsgSetC802&>(message);
    if (!IsLaunched() && GetVehicleID() == Msg.GetVehicleID())
    {
        dtCore::RefPtr<dtDAL::ActorProxy> parentProxy = FindShipActorByVehicleID(Msg.GetVehicleID());
        if ( parentProxy.valid() )
        {
            dtCore::RefPtr<ShipActor> parent = static_cast<ShipActor*>(parentProxy->GetActor());
            switch (Msg.GetOrderID())
            {
                case ORD_C802_FIRE : 
                    int count = Msg.GetMissileID();
                    if (count == GetMissileID())
                    {
                        SetCourseLeadAngle(Msg.GetCourseLeadAngle());
                        SetPitchAngle(Msg.GetPitchAngle());
                        SetRollAngle(Msg.GetRollAngle());
                        SetSelfControlFlightTime(Msg.GetSelfControlFlightTime());
                        SetSeaState(Msg.GetSeaState());
                        SetSelfGuideRangeGate(Msg.GetSelfGuideRangeGate());
                            
                        LaunchMissile();
                        UpdateStatusDBEffectTo2D(ST_MISSILE_RUN);
                							
                    }
                    break;
            }
        }
    }
}

/**
 *
 *
 */        
bool C802MissileActor::RepositionOnDOF(dtCore::Transform &xform)
{
    osg::Vec3 rot = xform.GetRotation();
    
    if (GetAttachmentDOFName() == C_DOF_NAME_C802_MISSILE_1 || GetAttachmentDOFName() == C_DOF_NAME_C802_MISSILE_2)
    {
        rot.x() = 90.0f;
        rot.y() = 15.0f;
        
        xform.SetRotation(rot);
        
        return true;
    }
    else if (GetAttachmentDOFName() == C_DOF_NAME_C802_MISSILE_3 || GetAttachmentDOFName() == C_DOF_NAME_C802_MISSILE_4)
    {
        rot.x() = -90.0f;
        rot.y() = 15.0f;
        
        xform.SetRotation(rot);
        
        return true;
    }
    
    return false;
}

/**
 * Called when the missile is launched
 *
 */
void C802MissileActor::OnLaunch( )
{
    SetIntendedPitch(GetPitchAngle());
    SetPitchAcceleration(2.0f);
    SetMaxPitchSpeed(5.0f);

    SetCurrentRoll(GetRollAngle());
    
    SetCourse(GetCourseLeadAngle()); 
    SetHeadingAcceleration(5.0f);
    SetMaxHeadingSpeed(5.0f);
    
    SetAcceleration(100.0f); //Booster acceleration = 100 m/s2
    SetPhase(PHASE_BOOST);
    std::cout<<"C802MissileActor "<< GetName() <<" : Entering Boost Phase!" <<std::endl;
}

/**
 *
 *
 */        
void C802MissileActor::OnPhaseBoost()
{
    float curAlt = GetCurrentAltitude();
//std::cout<<"Current Altitude:"<< curAlt <<std::endl;
    if (GetTimeSinceLaunch() > K0_TIME)
    {
        SetIntendedPitch(0.0f);
        SetCurrentPitchSpeed(0.0f);
        SetPitchAcceleration(0.5f);
        SetMaxPitchSpeed(2.0f);

        SetPhase(PHASE_CLIMB);    
        std::cout<<"C802MissileActor "<< GetName() <<" : Entering Climb Phase!" <<std::endl;
    }
    
}

/**
 *
 *
 */        
void C802MissileActor::OnPhaseClimb()
{
    SetAcceleration(1000.0f); //Turbojet on. Accelerate!
           
    float dist = GetDistanceToParentShip();
//std::cout<<"Distance to ship = "<<dist<<std::endl;
    float curAlt = GetCurrentAltitude();
//std::cout<<"Current Altitude:"<< curAlt <<std::endl;    
    if (dist>=DISTANCE_CLIMB_PHASE) //Release booster from missile 
    {
        //std::cout<<"C802MissileActor "<< GetName() <<" : Releasing booster and using turbojet thruster!"<<std::endl;        
        //SetPitchAcceleration(1.0f);
        //SetMaxPitchSpeed(5.0f);
    }

    if (GetCurrentAltitude() >= ALTITUDE_MAX) //If reaching max altitude, go to HALF Phase
    {
        SetIntendedPitch(0.0f);
        SetCurrentPitchSpeed(0.0f);
        SetPitchAcceleration(20.0f);
        SetMaxPitchSpeed(30.0f);
        SetPhase(PHASE_HALF);
        std::cout<<"C802MissileActor "<< GetName() <<" : Entering HALF Phase!" <<std::endl;
    }
}

/**
 *
 *
 */
void C802MissileActor::OnPhaseHALF()
{
    float curAlt = GetCurrentAltitude();
//std::cout<<"Current Altitude:"<< curAlt <<std::endl;
    if ( GetTimeSinceLaunch() >= K1_TIME )
    {
        SetIntendedPitch(-1.0f);
        SetCurrentPitchSpeed(0.0f);
        SetPitchAcceleration(1.0f);
        SetMaxPitchSpeed(2.0f);
        SetPhase(PHASE_GLIDING);
        std::cout<<"C802MissileActor "<< GetName() <<" : Entering Gliding Phase!" <<std::endl;        
    }
}

/**
 *
 *
 */
void C802MissileActor::OnPhaseGliding()
{
    float curAlt = GetCurrentAltitude();
//std::cout<<"Current Altitude:"<< curAlt <<std::endl;
    if (curAlt <= ALTITUDE_CRUISE_START)
    {
        SetIntendedPitch(-1.0f);
//        SetCurrentPitchSpeed(0.0f);
        SetPitchAcceleration(10.0f);
        SetMaxPitchSpeed(20.0f);
        SetPhase(PHASE_LEVEL_FLIGHT);
        std::cout<<"C802MissileActor "<< GetName() <<" : Entering Level Flight Phase!" <<std::endl;        
//        std::cout<<"C802MissileActor "<< GetName() <<" : Current pitch = " << GetCurrentPitch() <<std::endl;        
            
    }
    else if (curAlt <= ALTITUDE_G) //dive to cruise altitude / 20 m
    {
        SetIntendedPitch(-20.0f);
        SetPitchAcceleration(60.0f);
        SetMaxPitchSpeed(30.0f);            
    }
    
    //Set sensor based on time
    if (!GetSensor()->IsActive() && GetTimeSinceLaunch() > GetSelfControlFlightTime())
    {
        GetSensor()->SetActive(true);
        std::cout<<"C802MissileActor "<< GetName() <<" : Sensor activated!" <<std::endl;
    } 
}

/**
 *
 *
 */
void C802MissileActor::OnPhaseLevelFlight()
{
    float curAlt = GetCurrentAltitude();
//std::cout<<"Current Altitude:"<< curAlt <<std::endl; 
//std::cout<<"C802MissileActor "<< GetName() <<" : Current pitch = " << GetCurrentPitch() <<std::endl;                  
    if (GetLockedTarget()) //Target acquired
    {
        SetIntendedPitch(-10.0f);
        //        SetCurrentPitchSpeed(0.0f);
        SetPitchAcceleration(10.0f);
        SetMaxPitchSpeed(20.0f);
        SetPhase(PHASE_SAD);
        std::cout<<"C802MissileActor "<< GetName() <<" : Entering Secondary Altitude Descending Phase!" <<std::endl;        
    
    }

    // Level the missile
    if ( curAlt > ALTITUDE_CRUISE_LEVEL-1.0f && curAlt < (ALTITUDE_CRUISE_LEVEL+1.0f) ) // Level if in range of 19-21 meters above water
    {
        SetIntendedPitch(0.0f);
        SetPitchAcceleration(10.0f);
        SetMaxPitchSpeed(20.0f);

    }
    else if ( curAlt < ALTITUDE_CRUISE_LEVEL )
    {
        SetIntendedPitch(1.0f);
        SetPitchAcceleration(5.0f);
        SetMaxPitchSpeed(10.0f);    
    }
    else if ( curAlt > ALTITUDE_CRUISE_LEVEL )
    {
        SetIntendedPitch(-1.0f);
        SetPitchAcceleration(5.0f);
        SetMaxPitchSpeed(10.0f);    
    }

    
    //Set sensor based on time
    if (!GetSensor()->IsActive() && GetTimeSinceLaunch() > GetSelfControlFlightTime())
    {
        GetSensor()->SetActive(true);
        std::cout<<"C802MissileActor "<< GetName() <<" : Sensor activated!" <<std::endl;
    } 
    
}

/**
 *
 *
 */
void C802MissileActor::OnPhaseSAD()
{
    float curAlt = GetCurrentAltitude();
//std::cout<<"Current Altitude:"<< curAlt <<std::endl; 
    
    if ( GetDistanceToLockedTarget() <= DIVING_COMMAND_RANGE )
    {
        SetIntendedPitch(-2.0f);
        SetPitchAcceleration(5.0f);
        SetMaxPitchSpeed(10.0f);    
        
        SetPhase(PHASE_DIVING);
        std::cout<<"C802MissileActor "<< GetName() <<" : Entering Diving Phase!" <<std::endl;        
        
    }
    

    // Get the altitude based on Sea State
    float homingAlt;
    switch (mSeaState)
    {
        case 0:
        case 1:
        case 2:
        case 3:
            homingAlt = LOW_SEA_STATE_ALT;
            break;
        case 4:
        case 5:
        default:        
            homingAlt = HIGH_SEA_STATE_ALT;
            break;
    }
    // Level the missile
    if ( curAlt > (homingAlt-1.0f) && curAlt < (homingAlt+1.0f) ) // Level missile
    {
        SetIntendedPitch(0.0f);
        SetPitchAcceleration(10.0f);
        SetMaxPitchSpeed(20.0f);

    }
    else if ( curAlt < homingAlt )
    {
        SetIntendedPitch(1.0f);
        SetPitchAcceleration(5.0f);
        SetMaxPitchSpeed(10.0f);    
    }
    else if ( curAlt > homingAlt )
    {
        SetIntendedPitch(-1.0f);
        SetPitchAcceleration(5.0f);
        SetMaxPitchSpeed(10.0f);    
    }

}

/**
 *
 *
 */
void C802MissileActor::OnPhaseDiving()
{
    float curAlt = GetCurrentAltitude();
//std::cout<<"Current Altitude:"<< curAlt <<std::endl; 

    // Level the missile
    if ( curAlt > 0.0f && curAlt < 2.0f ) // Level missile
    {
        SetIntendedPitch(0.0f);
        SetPitchAcceleration(10.0f);
        SetMaxPitchSpeed(20.0f);

    }
    else if ( curAlt < 1.0f )
    {
        SetIntendedPitch(1.0f);
        SetPitchAcceleration(5.0f);
        SetMaxPitchSpeed(10.0f);    
    }
    else if ( curAlt > 1.0f )
    {
        SetIntendedPitch(-1.0f);
        SetPitchAcceleration(5.0f);
        SetMaxPitchSpeed(10.0f);    
    }

}


//-- C802MissileActor

//-- BAWE-20120227: C802_MISSILE_ACTOR
