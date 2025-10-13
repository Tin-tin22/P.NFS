#ifndef ENTITYSTATEPDU_H
#define ENTITYSTATEPDU_H

#include <DIS/EntityID.h>
#include <DIS/EntityType.h>
#include <DIS/EntityType.h>
#include <DIS/Vector3Float.h>
#include <DIS/Vector3Double.h>
#include <DIS/Orientation.h>
#include <DIS/DeadReckoningParameter.h>
#include <DIS/Marking.h>
#include <DIS/ArticulationParameter.h>
#include <vector>
#include <DIS/EntityInformationFamilyPdu.h>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.3.3.1. Represents the postion and state of one entity in the world. COMPLETE

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO EntityStatePdu : public EntityInformationFamilyPdu
{
protected:
  // Unique ID for an entity that is tied to this state information
  EntityID _entityID; 

  // What force this entity is affiliated with, eg red, blue, neutral, etc
  unsigned char _forceId; 

  // How many articulation parameters are in the variable length list
  char _numberOfArticulationParameters; 

  // Describes the type of entity in the world
  EntityType _entityType; 

  EntityType _alternativeEntityType; 

  // Describes the speed of the entity in the world
  Vector3Float _entityLinearVelocity; 

  // describes the location of the entity in the world
  Vector3Double _entityLocation; 

  // describes the orientation of the entity, in euler angles
  Orientation _entityOrientation; 

  // a series of bit flags that are used to help draw the entity, such as smoking, on fire, etc.
  int _entityAppearance; 

  // parameters used for dead reckoning
  DeadReckoningParameter _deadReckoningParameters; 

  // characters that can be used for debugging, or to draw unique strings on the side of entities in the world
  Marking _marking; 

  // a series of bit flags
  int _capabilities; 

  // variable length list of articulation parameters
  std::vector<ArticulationParameter> _articulationParameters; 


 public:
    EntityStatePdu();
    virtual ~EntityStatePdu();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    EntityID& getEntityID(); 
    const EntityID&  getEntityID() const; 
    void setEntityID(const EntityID    &pX);

    unsigned char getForceId() const; 
    void setForceId(unsigned char pX); 

    char getNumberOfArticulationParameters() const; 

    EntityType& getEntityType(); 
    const EntityType&  getEntityType() const; 
    void setEntityType(const EntityType    &pX);

    EntityType& getAlternativeEntityType(); 
    const EntityType&  getAlternativeEntityType() const; 
    void setAlternativeEntityType(const EntityType    &pX);

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

    DeadReckoningParameter& getDeadReckoningParameters(); 
    const DeadReckoningParameter&  getDeadReckoningParameters() const; 
    void setDeadReckoningParameters(const DeadReckoningParameter    &pX);

    Marking& getMarking(); 
    const Marking&  getMarking() const; 
    void setMarking(const Marking    &pX);

    int getCapabilities() const; 
    void setCapabilities(int pX); 

    std::vector<ArticulationParameter>& getArticulationParameters(); 
    const std::vector<ArticulationParameter>& getArticulationParameters() const; 
    void setArticulationParameters(const std::vector<ArticulationParameter>&    pX);


virtual int getMarshalledSize() const;

     bool operator  ==(const EntityStatePdu& rhs) const;
};
}

#endif
