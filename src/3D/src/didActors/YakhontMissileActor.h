// $Id: YakhontMissileActor.h

/**
 * @file YakhontMissileActor.h
 *
 * @author Bawenang R. P. P.
 *
 * @date March 15th, 2012
 *
 * @brief The header file for YakhontMissileActor actor.
 *
 * YakhontMissileActor is the class for the Yakhont Missile.
 *
 */
 
//++ BAWE-20120315: YAKHONT_MISSILE_ACTOR
 
// INCLUDES
#include "baseMissileActor.h"


class DID_ACTORS_EXPORT YakhontMissileActorProxy : public BaseMissileActorProxy
{
    public:
    
        /**
         * Constructs the proxy.
         */
        YakhontMissileActorProxy();

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
        virtual ~YakhontMissileActorProxy() {}

        /**
         * Called by the game manager during creation of the proxy.  This method
         * creates the real actor and returns it.
         */
        virtual void CreateActor();

    private:


};

class DID_ACTORS_EXPORT YakhontMissileActor: public BaseMissileActor
{
    public:
        //Constants
        static const float MAX_SPEED_ALTITUDE;                          //Max speed at max altitude
        static const float MAX_SPEED_CRUISE;                            //Max speed at cruising
        static const float MAX_HIGH_ALTITUDE;                           //Max high altitude in B2 mode = 14 km
        static const float MAX_LOW_ALTITUDE;                            //Max low altitude in B1 & B2 mode = 300 m
        static const double MAX_LOW_DISTANCE;                           //Max missile distance from ship at low altitude in B1 & B2 mode = 4 km
        static const float MAX_CRUISE_ALTITUDE;                         //Max cruise altitude in B1 & B2 mode = 15 m. 
        static const float MAX_POPUP_ALTITUDE;                          //Max popup altitude when cannot find target
        
        //Enumeration
        /**
         * Phase enumeration
         *
         */
        enum ePhaseEnum 
        {
            PHASE_NONE = 0
            , PHASE_1
            , PHASE_2
            , PHASE_3
            , PHASE_4
            , PHASE_5
            , PHASE_6
            , PHASE_7
        };
        enum eMode
        {
            B1 = 0,
            B2
        };

        /**
         * Constructs a default base missile actor.
         * @param proxy The actor proxy owning this task actor.
         * @param desc An optional description of this task actor.
         */
        YakhontMissileActor(dtGame::GameActorProxy& proxy);
        
                                        
        void SetPhase(int val);
        int GetPhase();
        
        void SetDistanceToTarget(float val);
        const float GetDistanceToTarget() const;        

        void SetBearingToTarget(float val);
        const float GetBearingToTarget() const;        

        void SetMode(int val);
        int GetMode();
        
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
        void OnPhase5();        
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
        virtual ~YakhontMissileActor() {}

        
    private:
    
        eMode   mMode;                      ///< The phase of the missile. Taken from ePhaseEnum.
        
        float   mDistanceToTarget;          ///< Distance from the target
        float   mBearingToTarget;           ///< Distance from the target
        int     mPhase;                     ///< The phase of the missile. Taken from ePhaseEnum.
        float   mPhaseDT;                   ///< Delta time of current phase

                                                             
        //BAWE-NOTE: Heading, pitch, altitude, position, etc from the transform.    
};

//-- BAWE-20120315: YAKHONT_MISSILE_ACTOR
