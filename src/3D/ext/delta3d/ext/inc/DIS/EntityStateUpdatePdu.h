#ifndef ENTITYSTATEUPDATEPDU_H
#define ENTITYSTATEUPDATEPDU_H

#include <DIS/EntityID.h>
#include <DIS/Vector3Float.h>
#include <DIS/Vector3Double.h>
#include <DIS/Orientation.h>
#include <DIS/ArticulationParameter.h>
#include <vector>
#include <DIS/EntityInformationFamilyPdu.h>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// 5.3.3.4. Nonstatic information about a particular entity may be communicated by issuing an Entity State Update PDU. COMPLETE

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO EntityStateUpdatePdu : public EntityInformationFamilyPdu
{
protected:
  // This field shall identify the entity issuing the PDU
  EntityID _entityID; 

  // How many articulation parameters are in the variable length list
  char _numberOfArticulationParameters; 

  // Describes the speed of the entity in the world
  Vector3Float _entityLinearVelocity; 

  // describes the location of the entity in the world
  Vector3Double _entityLocation; 

  // describes the orientation of the entity, in euler angles
  Orientation _entityOrientation; 

  // a series of bit flags that are used to help draw the entity, such as smoking, on fire, etc.
  int _entityAppearance; 

  std::vector<ArticulationParameter> _articulationParameters; 


 public:
    EntityStateUpdatePdu();
    virtual ~EntityStateUpdatePdu();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    EntityID& getEntityID(); 
    const EntityID&  getEntityID() const; 
    void setEntityID(const EntityID    &pX);

    char getNumberOfArticulationParameters() const; 

    Vector3Float& getEntityLinearVelocity(); 
    const Vector3Float&  getEntityLinearVelocity() const; 
    void setEntityLinearVelocity(const Vector3Float    &pX);

    Vector3Double& getEntityLocation(); 
    const Vector3Double&  getEntityLocation() const; 
    void setEntityLocation(const Vector3Double    &pX);

    Orientation& getEntityOrientation(); 
    const Orientation&  getEntityOrientation() const; 
    void setEntityOrientation(const Orientation    &pX);

    int getEntityAppearance() const; 
    void setEntityAppearance(int pX); 

    std::vector<ArticulationParameter>& getArticulationParameters(); 
    const std::vector<ArticulationParameter>& getArticulationParameters() const; 
    void setArticulationParameters(const std::vector<ArticulationParameter>&    pX);


virtual int getMarshalledSize() const;

     bool operator  ==(const EntityStateUpdatePdu& rhs) const;
};
}

#endif
