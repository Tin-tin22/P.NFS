// $Id: BaseSensor.cpp

/**
 * @file BaseSensor.cpp
 *
 * @author Bawenang R. P. P.
 *
 * @date March 7th, 2012
 *
 * @brief The source file for BaseSensor class.
 *
 * BaseSensor is the base class for any sensor / seeker in a missile / rocket. 
 * Should be implemented with a child in each missile / rocket.
 *
 */
 
//++ BAWE-20120307: BASE_SENSOR

//INCLUDES
#include "BaseSensor.h"
#include "../didCommon/BaseConstant.h"
#include "didactorsheaders.h"

#include <math.h>
#include <utility>
#include <iostream>

#include <dtCore/transformable.h>

#include <dtDAL/ActorType.h>

#include <dtUtil/matrixutil.h>

/**
 * Constructor
 *
 */
BaseSensor::BaseSensor()
            : mAngle(0.0f)
            //, mAngleH(0.0f)
            //, mAngleV(0.0f)
            , mRadius(0.0f)
            , mIsActive(false)
{
    mMMapDetectedObjects.clear();
}
/**
 * Destructor
 *
 */
BaseSensor::~BaseSensor()
{

}

/**
 * Check if an object inside the sensor's radar sweep conic area or not.
 * Virtual because not all sensor use the same checking method (eg. Exocet= sensor area)
 *
 * @param sensorXform   The transform of the sensor's point of origin
 * @param objXform      The transform of the object to be checked
 *
 * @return true if object is inside the conic area of the sensor radar sweep.
 */
//bool BaseSensor::CheckInsideCone(const dtCore::Transform& sensorXform, const dtCore::Transform& objXform) const
//bool BaseSensor::CheckInsideCone(dtCore::Transform sensorXform, dtCore::Transform objXform)
bool BaseSensor::CheckInsideCone(const dtCore::Transform& sensorXform, const dtCore::Transform& objXform, float& distance) const
{
    //distance = sensorXform.CalcDistance(objXform);
    if ( distance <= GetRadius() )
    {
        osg::Vec3 forwardVec, objectVec;
        osg::Vec3 sensorTrans, objTrans;
        osg::Matrix sensorRot;

        sensorXform.GetRotation(sensorRot);
        sensorXform.GetTranslation(sensorTrans);

        objXform.GetTranslation(objTrans);

        forwardVec = dtUtil::MatrixUtil::GetRow3(sensorRot, 1);
        forwardVec.normalize();
        objectVec = objTrans - sensorTrans;
        objectVec.normalize(); 
        
        //Get angle between sensor-object and forward vector;
        float objAngle = acosf(forwardVec * objectVec);
        objAngle = osg::RadiansToDegrees(objAngle);
        
		//std::cout<<"BaseSensor : objAngle = "<< objAngle <<std::endl;
		//std::cout<<"BaseSensor : distance = "<< distance <<std::endl;
		        
		//if (objAngle <= mAngle)
		//{
		//std::cout<<"BaseSensor : objAngle = "<< objAngle <<std::endl;
		//std::cout<<"BaseSensor : distance = "<< distance <<std::endl;
		//}
        
        return (objAngle <= mAngle);
    
    }   
    
    return false; 
}

/**
 * Check for all objects that are detected by the sensor and store in mVecDetectedObjects.
 *
 * @param gm   The game manager instance
 *
 */        
void BaseSensor::CheckDetectedObjects(dtGame::GameManager* gm, const dtCore::Transform& sensorXform)
{
    //SensorSearchFunc searchFunc(this, sensorXform);
    //gm->FindActorsIf(searchFunc, mVecDetectedObjects);

    std::vector<dtGame::GameActorProxy*> vActors;
    std::vector<dtGame::GameActorProxy*>::iterator iter;
    dtCore::Transformable* actor;
    dtCore::Transform xform;
    
    bool isInCone;
    float distance;
    
    mMMapDetectedObjects.clear();
    gm->GetAllGameActors(vActors);    

	//std::cout<<"BaseSensor : mAngle = "<< mAngle <<std::endl;

    for (iter = vActors.begin(); iter < vActors.end(); iter++)
    {
        if (((*iter)->GetActorType().GetName()== C_CN_SHIP ) || ((*iter)->GetActorType().GetName()== C_CN_SUBMARINE )
            || ((*iter)->GetActorType().GetName()== C_CN_HELICOPTER )) 
        {
            actor = dynamic_cast<dtCore::Transformable*> ((*iter)->GetActor());
            if (actor)
                actor->GetTransform(xform);

	//std::cout<<"BaseSensor : Object Name = "<< actor->GetName() <<std::endl;
            isInCone = CheckInsideCone(sensorXform, xform, distance);
            
            if (isInCone)
            {
                mMMapDetectedObjects.insert(std::pair<float, dtGame::GameActorProxy*>(distance,(*iter)));
            }
        }
    
    }
    
    if (mMMapDetectedObjects.size())
    {
        SetNeedUpdate(false);
    }
    
    //exit(1);
}

/**
 * Get the vector of all objects that are detected by the sensor.
 *
 * @return The vector of all detected objects
 */        
//std::multimap<float, dtGame::GameActorProxy*> BaseSensor::GetDetectedObjects( ) const
//{
//    return mMMapDetectedObjects;
//}

/**
 * Get the closest object in the detected objects container
 *
 * @return The pointer to actor proxy
 */        
dtGame::GameActorProxy* BaseSensor::GetClosestDetectedObject( ) const
{
    if (mMMapDetectedObjects.size() > 0)
        return (mMMapDetectedObjects.begin())->second;
    
    return NULL;
}

//-- BAWE-20120307: BASE_SENSOR


