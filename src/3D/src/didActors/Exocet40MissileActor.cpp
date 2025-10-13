// $Id: Exocet40MissileActor.cpp

/**
 * @file Exocet40MissileActor.cpp
 *
 * @author Bawenang R. P. P.
 *
 * @date March 15th, 2012
 *
 * @brief The source file for Exocet40MissileActor actor.
 *
 * Exocet40MissileActor is the class for the Exocet MM 40 Missile.
 *
 */
 
//++ BAWE-20120315: EXOCET_MM40_MISSILE_ACTOR
 
//INCLUDES
#include "Exocet40MissileActor.h"

#include "didactorssources.h"

#include <math.h>

#include <dtUtil/mathdefines.h>

#include <dtDAL/intactorproperty.h>
#include <dtDAL/floatactorproperty.h>

//++ Constants
const float Exocet40MissileActor::ALTITUDE_MAX = 100.0f;            // Maximum altitude of the missile 
const float Exocet40MissileActor::ALTITUDE_CRUISE = 20.0f;          // Cruise altitude at Level Flight Phase (E-F). 
const float Exocet40MissileActor::ALTITUDE_DIVE = 4.0f;             // Cruise altitude at Level Flight Phase (E-F).
const float Exocet40MissileActor::DISTANCE_CRUISE = 1000.0f;        // Cruise altitude at Level Flight Phase (E-F).
const float Exocet40MissileActor::DEVIATION_ANGLE = 10.0f;        // Cruise altitude at Level Flight Phase (E-F).
const float Exocet40MissileActor::APPROACH_ANGLE  = 45.0f;        // Cruise altitude at Level Flight Phase (E-F).
const float Exocet40MissileActor::SIN_DEVIATION_ANGLE = sin(osg::DegreesToRadians(DEVIATION_ANGLE));                // Cruise altitude at Level Flight Phase (E-F).
const float Exocet40MissileActor::COS_DEVIATION_ANGLE = cos(osg::DegreesToRadians(DEVIATION_ANGLE));                // Cruise altitude at Level Flight Phase (E-F).
const float Exocet40MissileActor::TAN_DEVIATION_ANGLE = tan(osg::DegreesToRadians(DEVIATION_ANGLE));                // Cruise altitude at Level Flight Phase (E-F).
const float Exocet40MissileActor::SIN_APPROACH_ANGLE = sin(osg::DegreesToRadians(APPROACH_ANGLE));              // Cruise altitude at Level Flight Phase (E-F).
const float Exocet40MissileActor::COS_APPROACH_ANGLE = cos(osg::DegreesToRadians(APPROACH_ANGLE));              // Cruise altitude at Level Flight Phase (E-F).
const float Exocet40MissileActor::TAN_APPROACH_ANGLE = tan(osg::DegreesToRadians(APPROACH_ANGLE));              // Cruise altitude at Level Flight Phase (E-F).

//-- Constants
 
 //++ Exocet40MissileActorProxy

///////////////////////////////////////////////////////////////////////////////
Exocet40MissileActorProxy::Exocet40MissileActorProxy()
{
   SetClassName("Exocet MM 40 Missile Actor");
}

///////////////////////////////////////////////////////////////////////////////
void Exocet40MissileActorProxy::BuildPropertyMap()
{
   //const std::string GROUP = "Base Missile Actor";
   const std::string GROUP = C_TYPE_MISSILE;

   BaseMissileActorProxy::BuildPropertyMap();
   Exocet40MissileActor* actor = NULL;
   GetActor(actor);
   

       
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



    AddProperty(new dtDAL::FloatActorProperty("Distance To Target","Distance To Target",
        dtDAL::FloatActorProperty::SetFuncType(actor, &Exocet40MissileActor::SetDistance),
        dtDAL::FloatActorProperty::GetFuncType(actor, &Exocet40MissileActor::GetDistance), 
        "Sets/gets distance to target settings.", GROUP));    
                  
        
}

///////////////////////////////////////////////////////////////////////////////
void Exocet40MissileActorProxy::BuildInvokables()
{           
    BaseMissileActorProxy::BuildInvokables();
}

///////////////////////////////////////////////////////////////////////////////
void Exocet40MissileActorProxy::CreateActor()
{
   SetActor(*new Exocet40MissileActor(*this));
}

///////////////////////////////////////////////////////////////////////////////
void Exocet40MissileActorProxy::OnEnteredWorld()
{
    // Note we did not create any of these Invokables.  ProcessMessage(), TickLocal(),
    // and TickRemote() are created for us in GameActorProxy::BuildInvokables().

    //Register an invokable for C802_EVENT
    //RegisterForMessages(SimMessageType::C802_EVENT, dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);

    RegisterForMessages(SimMessageType::EXOCET_40_EVENT, dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);        

    BaseMissileActorProxy::OnEnteredWorld();    
}

//-- Exocet40MissileActorProxy



//++ Exocet40MissileActor

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                  Constructor / destructor
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Constructs a default base missile actor.
 * @param proxy The actor proxy owning this task actor.
 */
Exocet40MissileActor::Exocet40MissileActor(dtGame::GameActorProxy& proxy)
                : BaseMissileActor(proxy)
                , mDistance(0.0f)
                , mDistanceToTurn(0.0f)
                , mPhase(PHASE_NONE)               

{
    SetMissileType(CT_EXOCET_40);
    
    SetMaxLifeParamType(MAX_LIFE_DISTANCE);
    SetMaxLifeParamValue(180000); //180km max distance
//    SetMaxLifeParamValue(5000); //5km max distance. test only
    
    //Set missile konfigurasi
    SetMaxSpeed(DEF_MACH_TO_METRE * 1.0f);  //Max speed = 0.9 mach
    SetAcceleration(1000.0f);               //Missile acceleration 1000 m/s2 (maybe)
    
    SetSensor(new BaseSensor());
    GetSensor()->SetAngle(10.0); 
    GetSensor()->SetRadius(8000); 
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                  Mutator / accessor methods
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

void Exocet40MissileActor::SetDistance(float val)
{
    mDistance = val;

}
const float Exocet40MissileActor::GetDistance() const
{
    return mDistance;
}

void Exocet40MissileActor::SetPhase(int val)
{
    mPhase = val;    
}
int Exocet40MissileActor::GetPhase()
{
    return mPhase;
}

void Exocet40MissileActor::OnEnteredWorld()
{
    BaseMissileActor::OnEnteredWorld();
    
    AddSender(&(GetGameActorProxy().GetGameManager()->GetScene()));
}

/**
 * Determine the changes of the missiles based on the rules. Should be overloaded by each concrete missile classes. Empty function in this class.  
 *
 */
void Exocet40MissileActor::DetermineBehaviour(float dt)
{
    if (IsLaunched())
    {
        
        //Check behaviour per-phase
        switch(mPhase)
        {
            case PHASE_1:
                OnPhase1();           
                break;
            case PHASE_2:           //B-C
                OnPhase2();
                break;
            case PHASE_3:            //C-D. High Altitude Level Flight Phase.
                OnPhase3();
                break;
            case PHASE_4:         //D-E
                OnPhase4();
                break;
            case PHASE_5:    //E-F
                break;
            case PHASE_6:             //F-G-H. Secondary Altitude Descending Phase.
                break;
            case PHASE_7:          //H-I
                break;

        }
    }    
}


void Exocet40MissileActor::ProcessMessage(const dtGame::Message &message)
{
    BaseMissileActor::ProcessMessage(message);
    
//    std::cout<<"void C802MissileActor::ProcessMessage(const dtGame::Message &message)"<< std::endl;
	if(GetGameActorProxy().IsInGM()){
		if(message.GetMessageType().GetName() == SimMessageType::EXOCET_40_EVENT.GetName())
		{
			ProcessOrderEvent(message);
		}
	}
}

void Exocet40MissileActor::ProcessOrderEvent(const dtGame::Message &message)
{
    const MsgSetExocet40 &Msg = dynamic_cast<const MsgSetExocet40&>(message);
    if (!IsLaunched() && GetVehicleID() == Msg.GetVehicleID())
    {
        dtCore::RefPtr<dtDAL::ActorProxy> parentProxy = FindShipActorByVehicleID(Msg.GetVehicleID());
        if ( parentProxy.valid() )
        {
            dtCore::RefPtr<ShipActor> parent = static_cast<ShipActor*>(parentProxy->GetActor());
            switch (Msg.GetOrderID())
            {
                case ORD_EXOCET_FIRE : 
                    int count = Msg.GetMissileID();
                    if (count == GetMissileID())
                    {

                        SetCourse(Msg.GetCourse());
                        SetDistance(Msg.GetDistance());                           
                            
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
bool Exocet40MissileActor::RepositionOnDOF(dtCore::Transform &xform)
{
    osg::Vec3 rot = xform.GetRotation();
    osg::Vec3 trans = xform.GetTranslation();
    trans.z() += 3.5f;
    
    if (GetAttachmentDOFName() == C_DOF_NAME_EXOCET_40_MISSILE_1 || GetAttachmentDOFName() == C_DOF_NAME_EXOCET_40_MISSILE_2)
    {
        rot.x() = 90.0f;
        rot.y() = 15.0f;
        
        xform.SetRotation(rot);
        xform.SetTranslation(trans);
        
        return true;
    }
    else if (GetAttachmentDOFName() == C_DOF_NAME_EXOCET_40_MISSILE_3 || GetAttachmentDOFName() == C_DOF_NAME_EXOCET_40_MISSILE_4)
    {
        rot.x() = -90.0f;
        rot.y() = 15.0f;
        
        xform.SetRotation(rot);
        xform.SetTranslation(trans);
        
        return true;
    }
    
    return false;
}

/**
 * Called when the missile is launched
 *
 */
void Exocet40MissileActor::OnLaunch( )
{
    SetIntendedPitch(GetCurrentPitch());
    SetPitchAcceleration(2.0f);
    SetMaxPitchSpeed(5.0f);

    //SetCurrentRoll();
    
    SetCourse(GetCourse()+DEVIATION_ANGLE); //approach from right 
    SetHeadingAcceleration(2.0f);
    SetMaxHeadingSpeed(2.0f);
    SetAcceleration(200.0f); //Booster acceleration = 200 m/s2
    
    CalculateTrajectory();
    
    SetPhase(PHASE_1);
    std::cout<<"Exocet40MissileActor "<< GetName() <<" : Entering Phase 1!" <<std::endl;
}

/**
 *
 *
 */
void Exocet40MissileActor::CalculateTrajectory()
{
    float y = GetDistance() * SIN_DEVIATION_ANGLE;
    float x = GetDistance() * COS_DEVIATION_ANGLE;
    float deltaDistToturn = y / TAN_APPROACH_ANGLE;
    mDistanceToTurn = x - deltaDistToturn; 

//std::cout<<"Distance:"<< GetDistance() <<std::endl;       
//std::cout<<"Y:"<< y <<std::endl;       
//std::cout<<"Distance To Turn:"<< mDistanceToTurn <<std::endl;   
}


/**
 *
 *
 */        
void Exocet40MissileActor::OnPhase1()
{
    float curAlt = GetCurrentAltitude();
//std::cout<<"Current Altitude:"<< curAlt <<std::endl;
    if (curAlt > ALTITUDE_MAX)
    {
        SetIntendedPitch(0.0f);
        SetCurrentPitchSpeed(0.0f);
        SetPitchAcceleration(5.0f);
        SetMaxPitchSpeed(5.0f);

        SetPhase(PHASE_2);    
        std::cout<<"Exocet40MissileActor "<< GetName() <<" : Entering Phase 2!" <<std::endl;
    }
    
}


/**
 *
 *
 */        
void Exocet40MissileActor::OnPhase2()
{
    float curAlt = GetCurrentAltitude();
    float curDist = GetDistanceToParentShip();
//std::cout<<"Current Altitude:"<< curAlt <<std::endl;
    if (curDist > DISTANCE_CRUISE)
    {
        SetIntendedPitch(-10.0f);
        SetCurrentPitchSpeed(0.0f);
        SetPitchAcceleration(5.0f);
        SetMaxPitchSpeed(5.0f);

        SetPhase(PHASE_3);    
        std::cout<<"Exocet40MissileActor "<< GetName() <<" : Entering Phase 3!" <<std::endl;
    }
    
}

/**
 *
 *
 */        
void Exocet40MissileActor::OnPhase3()
{
    float curAlt = GetCurrentAltitude();
    float distShip = GetDistanceToParentShip();
//std::cout<<"Current Altitude:"<< curAlt <<std::endl;
//std::cout<<"Current Distance:"<< distShip <<std::endl;
    
    ////Set sensor based on time
    //if (!GetSensor()->IsActive())
    //{
    //    GetSensor()->SetActive(true);
    //    std::cout<<"Exocet40MissileActor "<< GetName() <<" : Sensor activated!" <<std::endl;
    //} 
    
    //
    if (distShip >= mDistanceToTurn - 1000 )
    {
        SetIntendedPitch(-5.0f);
        SetCurrentPitchSpeed(0.0f);
        SetPitchAcceleration(5.0f);
        SetMaxPitchSpeed(5.0f);

        SetPhase(PHASE_4);    
        std::cout<<"Exocet40MissileActor "<< GetName() <<" : Entering Phase 4!" <<std::endl;
    
    }


    // Level the missile
    if ( curAlt > ALTITUDE_CRUISE-1.0f && curAlt < (ALTITUDE_CRUISE+1.0f) ) // Level if in range of 19-21 meters above water
    {
        SetIntendedPitch(0.0f);
        SetPitchAcceleration(10.0f);
        SetMaxPitchSpeed(20.0f);

    }
    else if ( curAlt < ALTITUDE_CRUISE )
    {
        SetIntendedPitch(1.0f);
        SetPitchAcceleration(5.0f);
        SetMaxPitchSpeed(10.0f);    
    }
    else if ( curAlt > ALTITUDE_CRUISE && GetIntendedPitch() > 0.0f)
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
void Exocet40MissileActor::OnPhase4()
{
    float curAlt = GetCurrentAltitude();
    float distShip = GetDistanceToParentShip();
    
    //Set sensor based on time
    if (!GetSensor()->IsActive())
    {
        GetSensor()->SetActive(true);
        std::cout<<"Exocet40MissileActor "<< GetName() <<" : Sensor activated!" <<std::endl;
    } 
    
    //
    if (distShip >= mDistanceToTurn)
    {
        SetIntendedPitch(0.0f);
        SetCourse(GetCourse()-APPROACH_ANGLE-4.0f); //approach
        SetCurrentHeadingSpeed(0.0f);
        SetHeadingAcceleration(2.0f);
        SetMaxHeadingSpeed(5.0f);

        SetPhase(PHASE_5);    
        std::cout<<"Exocet40MissileActor "<< GetName() <<" : Entering Phase 5!" <<std::endl;
    
    }


    // Level the missile
    if ( curAlt > ALTITUDE_DIVE-1.0f && curAlt < (ALTITUDE_DIVE+1.0f) ) // Level if in range of 19-21 meters above water
    {
        SetIntendedPitch(0.0f);
        SetPitchAcceleration(10.0f);
        SetMaxPitchSpeed(20.0f);

    }
    else if ( curAlt < ALTITUDE_DIVE )
    {
        SetIntendedPitch(1.0f);
        SetPitchAcceleration(5.0f);
        SetMaxPitchSpeed(10.0f);    
    }
    else if ( curAlt > ALTITUDE_DIVE )
    {
        SetIntendedPitch(-1.0f);
        SetPitchAcceleration(5.0f);
        SetMaxPitchSpeed(10.0f);    
    }

}


//-- Exocet40MissileActor

//++ BAWE-20120315: EXOCET_MM40_MISSILE_ACTOR
