// $Id: C802MissileActor.h

/**
 * @file C802MissileActor.h
 *
 * @author Bawenang R. P. P.
 *
 * @date February 24th, 2012
 *
 * @brief The header file for C802MissileActor actor.
 *
 * C802MissileActor is the class for the C802 Yingji Missile.
 *
 */
 
//++ BAWE-20120227: C802_MISSILE_ACTOR
 
// INCLUDES
#include "export.h"
#include "baseMissileActor.h"


class DID_ACTORS_EXPORT C802MissileActorProxy : public BaseMissileActorProxy
{
    public:
    
        /**
         * Constructs the proxy.
         */
        C802MissileActorProxy();

        /**
         * Builds the property map for the task actor proxy.  These properties
         * wrap the specified properties located in the actor.
         */
        virtual void BuildPropertyMap();

        /**
         * Registers any invokables used by the proxy.  The invokables
         * allow the actor to hook into the game manager messages system.
         */
        virtual void BuildInvokables();
        
        /**
         * Called when this proxy is added to the game manager (ie, the "world")
         * You can respond to OnEnteredWorld on either the proxy or actor or both.
         */
        virtual void OnEnteredWorld();
        
    protected:

        /**
         * Destroys the proxy.
         */
        virtual ~C802MissileActorProxy() {}

        /**
         * Called by the game manager during creation of the proxy.  This method
         * creates the real actor and returns it.
         */
        virtual void CreateActor();

    private:


};

class DID_ACTORS_EXPORT C802MissileActor: public BaseMissileActor
{
    public:
        //Constants
        static const int GATE_NEAR;                              // Near Gate setting. 10km <= R <= 15km.
        static const int GATE_FAR1;                              // Far 1 Gate setting. 15km < R <= 25km. 
        static const int GATE_FAR2;                              // Far 2 Gate setting. R > 25km. Default. If gate > Far1 Gate, then gate = Far gate.
        static const float K0_TIME;       
        static const float K1_TIME;
        static const float K2_TIME;
        static const float SELF_CONTROL_FLIGHT_TIME_MIN;    // Minimum mSelfControlFlightTime (K3_TIME). K5 = K3 + 2.5s
        static const float SELF_CONTROL_FLIGHT_TIME_MAX;    // Maximum mSelfControlFlightTime (K3_TIME). K5 = K3 + 2.5s
        static const float ALTITUDE_MAX;                    // Maximum altitude of the missile at HALF phase (+- 130-140 meters)
        static const float ALTITUDE_G;                      // The altitude to send G command (dive to cruise altitude)
        static const float ALTITUDE_CRUISE_START;           // The altitude to start Level Flight Phase (E-F). 49 meters so the missile can pitch to 0 degree at ALTITUDE_CRUISE_LEVEL, hopefully.
        static const float ALTITUDE_CRUISE_LEVEL;           // Cruise altitude at Level Flight Phase (E-F). 
        static const float DISTANCE_CLIMB_PHASE;            // Distance from ship before detaching booster (+- 500 meters)
        static const float HIGH_SEA_STATE_ALT;              // Diving altitude if the sea state is high (>=4)
        static const float LOW_SEA_STATE_ALT;               // Diving altitude if the sea state is low (<4)
        static const float DIVING_COMMAND_RANGE;            // Max range to locked target to send the diving command in Diving Phase
        
        //Enumeration
        /**
         * Phase enumeration
         *
         */
        enum ePhaseEnum 
        {
            PHASE_NONE = 0
            , PHASE_BOOST           //A-B
            , PHASE_CLIMB           //B-C
            , PHASE_HALF            //C-D. High Altitude Level Flight Phase.
            , PHASE_GLIDING         //D-E
            , PHASE_LEVEL_FLIGHT    //E-F
            , PHASE_SAD             //F-G-H. Secondary Altitude Descending Phase.
            , PHASE_DIVING          //H-I        
        };

        /**
         * Constructs a default base missile actor.
         * @param proxy The actor proxy owning this task actor.
         * @param desc An optional description of this task actor.
         */
        C802MissileActor(dtGame::GameActorProxy& proxy);
        
        //Mutator / accessor methods
        
        void SetCourseLeadAngle(float val);
        float GetCourseLeadAngle();
        
        void SetPitchAngle(float val);
        float GetPitchAngle();

        void SetRollAngle(float val);
        float GetRollAngle();

        void SetSelfControlFlightTime(float val);
        float GetSelfControlFlightTime();

        void SetSeaState(int val);
        int GetSeaState();

        void SetSelfGuideRangeGate(int val);
        int GetSelfGuideRangeGate();

              
                
        void SetPhase(int val);
        int GetPhase();
        
        //Virtual base methods
        /**
         * Determine the changes of the missiles based on the rules. Should be overloaded by each concrete missile classes. Empty function in this class.  
         *
         */
        virtual void DetermineBehaviour(float dt); 
        
        /**
         * Reposition the missile after attachment: rotate the missile relative to the DOF, translate the missile relative to the DOF, etc. Depending on the missile type (overloadable).
         *
         * @param  [in,out] The missile's transform. Input from origin (0,0,0,0,0,0), output to relative transform.
         * @return Bool if the transform is successfully changed. (maybe not needed. change to void?)
         */
        virtual bool RepositionOnDOF(dtCore::Transform &xform);
        
        /**
         * Called when the missile is launched
         *
         */
        virtual void OnLaunch( );
        
        /**
         *
         *
         */
        virtual void OnEnteredWorld();
        
        /**
         * Generic handler (Invokable) for messages. Overridden from base class.
         * This is the default invokable on GameActorProxy.
         */
        virtual void ProcessMessage(const dtGame::Message& message);

        /**
         *
         *
         */        
        virtual void ProcessOrderEvent(const dtGame::Message &message);
        
    protected:

        /**
         * Destroys this actor.
         */
        virtual ~C802MissileActor() {}

        /**
         *
         *
         */        
        void OnPhaseBoost();
        
        /**
         *
         *
         */        
        void OnPhaseClimb();
        
        /**
         *
         *
         */
        void OnPhaseHALF();
        
        /**
         *
         *
         */
        void OnPhaseGliding();
        
        /**
         *
         *
         */
        void OnPhaseLevelFlight();
        
        /**
         *
         *
         */
        void OnPhaseSAD();
        
        /**
         *
         *
         */
        void OnPhaseDiving();

        
    private:
    
        float   mCourseLeadAngle;           ///< The Psi-q-Z in the manual. The course leading angle if the missile. 
        float   mPitchAngle;                ///< The delta-Z in the manual. The pitch angle of the missile. 
        float   mRollAngle;                 ///< The gamma-Z in the manual. The roll angle of the missile. 
        float   mSelfControlFlightTime;     ///< The TZK in the manual. The self-control flight time
        int     mSeaState;                  ///< The sea state. 1 - 5
        int     mSelfGuideRangeGate;        ///< The self-guide range gate. Near / Far
        int     mPhase;                     ///< The phase of the missile. Taken from ePhaseEnum.
                                                             
        
        
        //BAWE-NOTE: Heading, pitch, altitude, position, etc from the transform.    


};

//-- BAWE-20120227: C802_MISSILE_ACTOR
