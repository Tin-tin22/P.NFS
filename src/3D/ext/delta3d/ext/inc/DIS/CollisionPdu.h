#ifndef COLLISIONPDU_H
#define COLLISIONPDU_H

#include <DIS/EntityID.h>
#include <DIS/EntityID.h>
#include <DIS/EventID.h>
#include <DIS/Vector3Float.h>
#include <DIS/Vector3Float.h>
#include <DIS/EntityInformationFamilyPdu.h>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.3.3.2. Information about a collision. COMPLETE

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO CollisionPdu : public EntityInformationFamilyPdu
{
protected:
  // ID of the entity that issued the collision PDU
  EntityID _issuingEntityID; 

  // ID of entity that has collided with the issuing entity ID
  EntityID _collidingEntityID; 

  // ID of event
  EventID _eventID; 

  // ID of event
  unsigned char _collisionType; 

  // some padding
  char _pad; 

  // velocity at collision
  Vector3Float _velocity; 

  // mass of issuing entity
  float _mass; 

  // Location with respect to entity the issuing entity collided with
  Vector3Float _location; 


 public:
    CollisionPdu();
    virtual ~CollisionPdu();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    EntityID& getIssuingEntityID(); 
    const EntityID&  getIssuingEntityID() const; 
    void setIssuingEntityID(const EntityID    &pX);

    EntityID& getCollidingEntityID(); 
    const EntityID&  getCollidingEntityID() const; 
    void setCollidingEntityID(const EntityID    &pX);

    EventID& getEventID(); 
    const EventID&  getEventID() const; 
    void setEventID(const EventID    &pX);

    unsigned char getCollisionType() const; 
    void setCollisionType(unsigned char pX); 

    char getPad() const; 
    void setPad(char pX); 

    Vector3Float& getVelocity(); 
    const Vector3Float&  getVelocity() const; 
    void setVelocity(const Vector3Float    &pX);

    float getMass() const; 
    void setMass(float pX); 

    Vector3Float& getLocation(); 
    const Vector3Float&  getLocation() const; 
    void setLocation(const Vector3Float    &pX);


virtual int getMarshalledSize() const;

     bool operator  ==(const CollisionPdu& rhs) const;
};
}

#endif
