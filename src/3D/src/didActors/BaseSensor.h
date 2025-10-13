// $Id: BaseSensor.h

/**
 * @file BaseSensor.h
 *
 * @author Bawenang R. P. P.
 *
 * @date March 7th, 2012
 *
 * @brief The header file for BaseSensor class.
 *
 * BaseSensor is the base class for any sensor / seeker in a missile / rocket. 
 * Should be implemented with a child in each missile / rocket.
 *
 */
 
//INCLUDES
//#include <vector>
#include <map>

#include <dtCore/transform.h>

#include <dtDAL/baseactorobject.h>

#include <dtGame/gamemanager.h>
 
//++ BAWE-20120307: BASE_SENSOR
class BaseSensor
{
    public:
        // Ctor & Dtor
        /**
         * Constructor
         *
         */
        BaseSensor();
        /**
         * Destructor
         *
         */
        ~BaseSensor();
        
        //Mutators / accessors
        inline void SetActive(const bool state)
        {
            mIsActive = state;
        };
        inline const bool IsActive( ) const
        {
            return(mIsActive);
        };      

        inline void SetNeedUpdate(const bool state)
        {
            mIsNeedUpdate = state;
        };        
        inline bool IsNeedUpdate() const
        {
            return mIsNeedUpdate;
        };
  
        
        //inline void SetHorizontalAngle(const float angle)
        //{
        //    mAngleH = angle;
        //}
        //inline const float GetHorizontalAngle( ) const
        //{
        //    return(mAngleH);
        //}

        //inline void SetVerticalAngle(const float angle)
        //{
        //    mAngleV = angle;
        //}
        //inline const float GetVerticalAngle( ) const
        //{
        //    return(mAngleV);
        //}
        
        inline void SetAngle(const float angle)
        {
            mAngle = angle;
        };
        inline const float GetAngle( ) const
        {
            return(mAngle);
        };        

        inline void SetRadius(const float rad)
        {
            mRadius = rad;
        };
        inline const float GetRadius( ) const
        {
            return(mRadius);
        };
                
        /**
         * Check if an object inside the sensor's radar sweep conic area or not.
         * Virtual because not all sensor use the same checking method (eg. Exocet= sensor area)
         *
         * @param sensorXform   The transform of the sensor's point of origin
         * @param objXform      The transform of the object to be checked
         * @param distance      The distance of the sensor to object. Output.
         *
         * @return true if object is inside the conic area of the sensor radar sweep.
         */
        //virtual bool CheckInsideCone(const dtCore::Transform& sensorXform, const dtCore::Transform& objXform) const;
        //virtual bool CheckInsideCone(dtCore::Transform sensorXform, dtCore::Transform objXform);
        virtual bool CheckInsideCone(const dtCore::Transform& sensorXform, const dtCore::Transform& objXform, float& distance) const;

        /**
         * Check for all objects that are detected by the sensor and store in mVecDetectedObjects.
         *
         * @param gm            The game manager instance
         * @param sensorXform   The transform of the sensor's point of origin
         *
         */        
        void CheckDetectedObjects(dtGame::GameManager* gm, const dtCore::Transform& sensorXform);

        /**
         * Get the vector of all objects that are detected by the sensor.
         *
         *
         * @return The vector of all detected objects
         */        
        //std::multimap<float, dtGame::GameActorProxy*> GetDetectedObjects( ) const;        

        /**
         * Get the closest object in the detected objects container
         *
         * @return The game actor proxy of the closest object
         */        
        dtGame::GameActorProxy* GetClosestDetectedObject( ) const;                
        
    protected:
    private:
        bool        mIsActive;      ///< Is the sensor active or not.
        bool        mIsNeedUpdate;  ///< Do we need to update the sensor check?
    
        /*float       mAngleH;        ///< Horizontal angle of the seeker's radar sweep
        float       mAngleV;        ///< Vertical angle of the seeker's radar sweep*/
        float       mAngle;         ///< Angle of the seeker's radar sweep (round)
        float       mRadius;        ///< Radius / distance of the seeker's radar sweep
        
        std::multimap<float, dtGame::GameActorProxy*>    mMMapDetectedObjects;
        
};

//Helper class for actor finding function
//NOT USED
//class SensorSearchFunc
//{
//    public:
//        SensorSearchFunc(const BaseSensor* sensor, const dtCore::Transform& sensorXform)
//            : mSensor(sensor)
//            , mSensorXform(sensorXform)
//            {
//            }
//
//        bool operator()(dtDAL::BaseActorObject& proxy)
//        {
//            dtCore::Transform xform;
//            if ((proxy->GetActorType().GetName()== C_CN_SHIP ) || (proxy->GetActorType().GetName()== C_CN_SUBMARINE )
//                || (proxy->GetActorType().GetName()== C_CN_HELICOPTER ))
//            {
//                dtCore::Transformable* actor = dynamic_cast<dtCore::Transformable*> (proxy.GetActor());
//                if (actor)
//                    actor->GetTransform(xform);
//                return mSensor->CheckInsideCone(mSensorXform, xform);
//            }
//            return false;
//        }
//
//        const BaseSensor* mSensor;
//        const dtCore::Transform& mSensorXform;
//};
//-- BAWE-20120307: BASE_SENSOR