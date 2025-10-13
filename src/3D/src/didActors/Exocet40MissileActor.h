// $Id: Exocet40MissileActor.h

/**
 * @file Exocet40MissileActor.h
 *
 * @author Bawenang R. P. P.
 *
 * @date March 15th, 2012
 *
 * @brief The header file for Exocet40MissileActor actor.
 *
 * Exocet40MissileActor is the class for the Exocet MM 40 Missile.
 *
 */
 
//++ BAWE-20120315: EXOCET_MM40_MISSILE_ACTOR
 
// INCLUDES
#include "export.h"
#include "baseMissileActor.h"


class DID_ACTORS_EXPORT Exocet40MissileActorProxy : public BaseMissileActorProxy
{
    public:
    
        /**
         * Constructs the proxy.
         */
        Exocet40MissileActorProxy();

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
        virtual ~Exocet40MissileActorProxy() {}

        /**
         * Called by the game manager during creation of the proxy.  This method
         * creates the real actor and returns it.
         */
        virtual void CreateActor();

    private:


};

class DID_ACTORS_EXPORT Exocet40MissileActor: public BaseMissileActor
{
    public:
        //Static constants
        static const float ALTITUDE_MAX;            // Maximum altitude of the missile 
        static const float ALTITUDE_CRUISE;          // Cruise altitude at Level Flight Phase (E-F). 
        static const float ALTITUDE_DIVE;            // Cruise altitude at Level Flight Phase (E-F).
        static const float DISTANCE_CRUISE;        // Cruise altitude at Level Flight Phase (E-F).
        static const float DEVIATION_ANGLE;        // Cruise altitude at Level Flight Phase (E-F).
        static const float APPROACH_ANGLE;        // Cruise altitude at Level Flight Phase (E-F).
        static const float SIN_DEVIATION_ANGLE;                // Cruise altitude at Level Flight Phase (E-F).
        static const float COS_DEVIATION_ANGLE;                // Cruise altitude at Level Flight Phase (E-F).
        static const float TAN_DEVIATION_ANGLE;                // Cruise altitude at Level Flight Phase (E-F).
        static const float SIN_APPROACH_ANGLE;                // Cruise altitude at Level Flight Phase (E-F).
        static const float COS_APPROACH_ANGLE;                // Cruise altitude at Level Flight Phase (E-F).
        static const float TAN_APPROACH_ANGLE;                // Cruise altitude at Level Flight Phase (E-F).

        
        //Enumeration
        /**
         * Phase enumeration
         *
         */
        enum ePhaseEnum 
        {
            PHASE_NONE = 0
            , PHASE_1           //A-B
            , PHASE_2           //B-C
            , PHASE_3            //C-D. High Altitude Level Flight Phase.
            , PHASE_4         //D-E
            , PHASE_5    //E-F
            , PHASE_6             //F-G-H. Secondary Altitude Descending Phase.
            , PHASE_7          //H-I        
        };

        /**
         * Constructs a default base missile actor.
         * @param proxy The actor proxy owning this task actor.
         * @param desc An optional description of this task actor.
         */
        Exocet40MissileActor(dtGame::GameActorProxy& proxy);
        
        void SetDistance(float val);
        const float GetDistance() const;        
                
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
        virtual void OnLaunch();  
        
        /**
         *
         *
         */
        void CalculateTrajectory();      
        
        /**
         *
         *
         */        
        void OnPhase1();        
        
        /**
         *
         *
         */        
        void OnPhase2();
        
        /**
         *
         *
         */        
        void OnPhase3();

        /**
         *
         *
         */        
        void OnPhase4();
        
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
        virtual ~Exocet40MissileActor() {};

        
    private:

        float   mDistance;                  ///< Distance from the target
        float   mDistanceToTurn;            ///< Distance before turning to approach the target
        int     mPhase;                     ///< The phase of the missile. Taken from ePhaseEnum.
                                                             
        //BAWE-NOTE: Heading, pitch, altitude, position, etc from the transform.    
};

//-- BAWE-20120315: EXOCET_MM40_MISSILE_ACTOR
