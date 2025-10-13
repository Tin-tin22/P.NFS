// $Id: YakhontMissileActor.cpp

/**
 * @file YakhontMissileActor.cpp
 *
 * @author Bawenang R. P. P.
 *
 * @date March 15th, 2012
 *
 * @brief The source file for YakhontMissileActor actor.
 *
 * YakhontMissileActor is the class for the Yakhont Missile.
 *
 */
 
//++ BAWE-20120315: YAKHONT_MISSILE_ACTOR
 
//INCLUDES
#include "YakhontMissileActor.h"

#include "didactorssources.h"

#include <dtDAL/intactorproperty.h>
#include <dtDAL/floatactorproperty.h>

//++ Constants
const float YakhontMissileActor::MAX_SPEED_ALTITUDE = DEF_MACH_TO_METRE * 2.5f;      //Max speed at max altitude = 2.5 mach
const float YakhontMissileActor::MAX_SPEED_CRUISE = DEF_MACH_TO_METRE * 2.0f;        //Max speed at cruising = 2 mach
const float YakhontMissileActor::MAX_HIGH_ALTITUDE = 14000.0f;                       //Max high altitude in B2 mode = 14 km
const float YakhontMissileActor::MAX_LOW_ALTITUDE = 300.0f;                          //Max low altitude in B1 & B2 mode = 300 m
const double YakhontMissileActor::MAX_LOW_DISTANCE = 3800.0f;                        //Max missile distance from ship at low altitude in B1 & B2 mode = 4 km. Set to 3.5 km so it can adjust
const float YakhontMissileActor::MAX_CRUISE_ALTITUDE = 15.0f;                        //Max cruise altitude in B1 & B2 mode = 15 m. 
const float YakhontMissileActor::MAX_POPUP_ALTITUDE = 250.0f;                        //Max popup altitude when cannot find target = 250 m
//-- Constants
 
 //++ YakhontMissileActorProxy

///////////////////////////////////////////////////////////////////////////////
YakhontMissileActorProxy::YakhontMissileActorProxy()
{
   SetClassName("Yakhont Missile Actor");
}

///////////////////////////////////////////////////////////////////////////////
void YakhontMissileActorProxy::BuildPropertyMap()
{
   //const std::string GROUP = "Base Missile Actor";
   const std::string GROUP = C_TYPE_MISSILE;

   BaseMissileActorProxy::BuildPropertyMap();
   YakhontMissileActor* actor = NULL;
   GetActor(actor);
   

       
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////       

    AddProperty(new dtDAL::IntActorProperty(C_MSG_PHASE,C_MSG_PHASE,
        dtDAL::IntActorProperty::SetFuncType(actor, &YakhontMissileActor::SetPhase),
        dtDAL::IntActorProperty::GetFuncType(actor, &YakhontMissileActor::GetPhase), 
        "Sets/gets max speed.", GROUP));            

    AddProperty(new dtDAL::FloatActorProperty(C_MSG_YAKHONT_BEARING,C_MSG_YAKHONT_BEARING,
        dtDAL::FloatActorProperty::SetFuncType(actor, &YakhontMissileActor::SetBearingToTarget),
        dtDAL::FloatActorProperty::GetFuncType(actor, &YakhontMissileActor::GetBearingToTarget), 
        "Sets/gets course to target settings.", GROUP));
        
    AddProperty(new dtDAL::FloatActorProperty(C_MSG_YAKHONT_DISTANCE,C_MSG_YAKHONT_DISTANCE,
        dtDAL::FloatActorProperty::SetFuncType(actor, &YakhontMissileActor::SetDistanceToTarget),
        dtDAL::FloatActorProperty::GetFuncType(actor, &YakhontMissileActor::GetDistanceToTarget), 
        "Sets/gets distance to target settings.", GROUP));    

    AddProperty(new dtDAL::IntActorProperty(C_MSG_YAKHONT_MODE,C_MSG_YAKHONT_MODE,
        dtDAL::IntActorProperty::SetFuncType(actor, &YakhontMissileActor::SetMode),
        dtDAL::IntActorProperty::GetFuncType(actor, &YakhontMissileActor::GetMode), 
        "Sets/gets mode", GROUP));            

        
}

///////////////////////////////////////////////////////////////////////////////
void YakhontMissileActorProxy::BuildInvokables()
{           
    BaseMissileActorProxy::BuildInvokables();
}

///////////////////////////////////////////////////////////////////////////////
void YakhontMissileActorProxy::CreateActor()
{
   SetActor(*new YakhontMissileActor(*this));
}

///////////////////////////////////////////////////////////////////////////////
void YakhontMissileActorProxy::OnEnteredWorld()
{
    // Note we did not create any of these Invokables.  ProcessMessage(), TickLocal(),
    // and TickRemote() are created for us in GameActorProxy::BuildInvokables().

    //Register an invokable for C802_EVENT
    //RegisterForMessages(SimMessageType::C802_EVENT, dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
    RegisterForMessages(SimMessageType::YAKHONT_EVENT);        

    BaseMissileActorProxy::OnEnteredWorld();    
}

//-- YakhontMissileActorProxy



//++ YakhontMissileActor

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                  Constructor / destructor
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Constructs a default base missile actor.
 * @param proxy The actor proxy owning this task actor.
 */
YakhontMissileActor::YakhontMissileActor(dtGame::GameActorProxy& proxy)
                : BaseMissileActor(proxy)
                , mPhase(PHASE_NONE)
                , mDistanceToTarget(0.0f)
                , mBearingToTarget(0.0f)
                , mPhaseDT(0.0f)
                               

{
    SetMissileType(CT_YAKHONT);
    
    SetMaxLifeParamType(MAX_LIFE_DISTANCE);
    SetMaxLifeParamValue(310000); //300km max distance + 10 just in case :D
    
    //Set missile konfigurasi
    SetAcceleration(1000.0f);               //Missile acceleration 1000 m/s2 (maybe)
    
    SetSensor(new BaseSensor());
    GetSensor()->SetAngle(22.16); 
    GetSensor()->SetRadius(50000); 
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                  Mutator / accessor methods
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

void YakhontMissileActor::SetPhase(int val)
{
    mPhase = val;    
}
int YakhontMissileActor::GetPhase()
{
    return mPhase;
}

void YakhontMissileActor::SetMode(int val)
{
    mMode = (eMode) val;    
}
int YakhontMissileActor::GetMode()
{
    return mMode;
}

void YakhontMissileActor::SetDistanceToTarget(float val)
{
    mDistanceToTarget = val;

}
const float YakhontMissileActor::GetDistanceToTarget() const
{
    return mDistanceToTarget;
}

void YakhontMissileActor::SetBearingToTarget(float val)
{
    mBearingToTarget = val;

}
const float YakhontMissileActor::GetBearingToTarget() const
{
    return mBearingToTarget;
}

void YakhontMissileActor::OnEnteredWorld()
{
    BaseMissileActor::OnEnteredWorld();
    
    AddSender(&(GetGameActorProxy().GetGameManager()->GetScene()));
}

/**
 * Determine the changes of the missiles based on the rules. Should be overloaded by each concrete missile classes. Empty function in this class.  
 *
 */
void YakhontMissileActor::DetermineBehaviour(float dt)
{
    if (IsLaunched())
    {
        mPhaseDT+=dt;
        //Check behaviour per-phase
        switch(mPhase)
        {
            case PHASE_1:
                OnPhase1();
                break;
            case PHASE_2:
                OnPhase2();
                break;
            case PHASE_3:
                OnPhase3();
                break;
            case PHASE_4:
                OnPhase4();
                break;
            case PHASE_5:
                OnPhase5();
                break;
            case PHASE_6:
                break;
            case PHASE_7:
                break;

        }
    }    
}


void YakhontMissileActor::ProcessMessage(const dtGame::Message &message)
{
    BaseMissileActor::ProcessMessage(message);
    
//    std::cout<<"void C802MissileActor::ProcessMessage(const dtGame::Message &message)"<< std::endl;
	if(GetGameActorProxy().IsInGM()){
		if(message.GetMessageType().GetName() == SimMessageType::YAKHONT_EVENT.GetName())
		{
			ProcessOrderEvent(message);
		}
	}
}

void YakhontMissileActor::ProcessOrderEvent(const dtGame::Message &message)
{
    const MsgSetYakhont &Msg = static_cast<const MsgSetYakhont&>(message);
    if (!IsLaunched() && GetVehicleID() == Msg.GetVehicleID())
    {
        dtCore::RefPtr<dtDAL::ActorProxy> parentProxy = FindShipActorByVehicleID(Msg.GetVehicleID());
        if ( parentProxy.valid() )
        {
            dtCore::RefPtr<ShipActor> parent = static_cast<ShipActor*>(parentProxy->GetActor());
            switch (Msg.GetOrderID())
            {
                case ORD_YAKHONT_FIRE : 
                    int count = Msg.GetMissileID();
                    if (count == GetMissileID())
                    {
                        //SetMode(Msg.GetMode());
                        SetBearingToTarget(Msg.GetBearingToTarget());
                        SetDistanceToTarget(Msg.GetDistanceToTarget());
                            
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
bool YakhontMissileActor::RepositionOnDOF(dtCore::Transform &xform)
{
    osg::Vec3 rot = xform.GetRotation();
    
    rot.y() = 90.0f;
        
    xform.SetRotation(rot);
        
    return true;

}

/**
 * Called when the missile is launched
 *
 */
void YakhontMissileActor::OnLaunch( )
{
    SetAcceleration(20.0f); //Booster acceleration = 20 m/s2. maybe
    SetMaxSpeed(100.0f);
    SetPhase(PHASE_1);
    std::cout<<"YakhontMissileActor "<< GetName() <<" : Entering Phase 1!" <<std::endl;
}

/**
 *
 *
 */        
void YakhontMissileActor::OnPhase1()
{
    float curAlt = GetCurrentAltitude();
//std::cout<<"Current Altitude:"<< curAlt <<std::endl;
    if (curAlt > MAX_LOW_ALTITUDE)
    {
        //@TODO ADD EFFECT THRUSTER PARTICLE
        SetIntendedPitch(0.0f);
        SetCurrentPitchSpeed(0.0f);
        SetPitchAcceleration(90.0f);
        SetMaxPitchSpeed(90.0f);
        
        SetMaxSpeed(MAX_SPEED_ALTITUDE);
        SetAcceleration(1000.0f); //Jet acceleration. maybe
        
        mPhaseDT = 0.0f;
        SetPhase(PHASE_2);    
        std::cout<<"YakhontMissileActor "<< GetName() <<" : Entering Phase 2!" <<std::endl;
    }
    
}

/**
 *
 *
 */        
void YakhontMissileActor::OnPhase2()
{
    float curAlt = GetCurrentAltitude();
//std::cout<<"Current Altitude:"<< curAlt <<std::endl;
    if (mPhaseDT > 1.0f) //1 sec phase time
    {
        //@TODO ADD EFFECT THRUSTER PARTICLE
        SetCourse(GetBearingToTarget()); 
        SetCurrentHeadingSpeed(0.0f);
        SetHeadingAcceleration(90.0f);
        SetMaxHeadingSpeed(90.0f);

        

        SetPhase(PHASE_3);    
        std::cout<<"YakhontMissileActor "<< GetName() <<" : Entering Phase 3!" <<std::endl;
    }
    
}

/**
 *
 *
 */        
void YakhontMissileActor::OnPhase3()
{
    float curAlt = GetCurrentAltitude();
//std::cout<<"Current Altitude:"<< curAlt <<std::endl;
    if (GetDistanceSinceLaunch() > MAX_LOW_DISTANCE)
    {
        //@TODO ADD EFFECT THRUSTER PARTICLE
        SetIntendedPitch(-60.0f);
        SetCurrentPitchSpeed(0.0f);
        SetPitchAcceleration(90.0f);
        SetMaxPitchSpeed(90.0f);

        SetPhase(PHASE_4);    
        std::cout<<"YakhontMissileActor "<< GetName() <<" : Entering Phase 4!" <<std::endl;
    }
    
}

/**
 *
 *
 */        
void YakhontMissileActor::OnPhase4()
{
    float curAlt = GetCurrentAltitude();
//std::cout<<"Current Altitude:"<< curAlt <<std::endl;
    if (curAlt > MAX_CRUISE_ALTITUDE+5.0f) // Add 5 so the missile doesn't drop too far
    {
        //@TODO ADD EFFECT THRUSTER PARTICLE
        SetIntendedPitch(0.0f);
        SetCurrentPitchSpeed(0.0f);
        SetPitchAcceleration(90.0f);
        SetMaxPitchSpeed(90.0f);
        
        SetMaxSpeed(MAX_SPEED_CRUISE);

        SetPhase(PHASE_5);    
        std::cout<<"YakhontMissileActor "<< GetName() <<" : Entering Phase 5!" <<std::endl;
    }
    
}

/**
 *
 *
 */        
void YakhontMissileActor::OnPhase5()
{
    float curAlt = GetCurrentAltitude();
//std::cout<<"Current Altitude:"<< curAlt <<std::endl;

    // Level the missile
    if ( curAlt > MAX_CRUISE_ALTITUDE-1.0f && curAlt < (MAX_CRUISE_ALTITUDE+1.0f) ) // Level if in range of 19-21 meters above water
    {
        SetIntendedPitch(0.0f);
        SetPitchAcceleration(10.0f);
        SetMaxPitchSpeed(20.0f);

    }
    else if ( curAlt < MAX_CRUISE_ALTITUDE )
    {
        SetIntendedPitch(1.0f);
        SetPitchAcceleration(5.0f);
        SetMaxPitchSpeed(10.0f);    
    }
    else if ( curAlt > MAX_CRUISE_ALTITUDE )
    {
        SetIntendedPitch(-1.0f);
        SetPitchAcceleration(5.0f);
        SetMaxPitchSpeed(10.0f);    
    }

    
}



//-- YakhontMissileActor

//++ BAWE-20120315: YAKHONT_MISSILE_ACTOR
