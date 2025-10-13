#ifndef COLLISIONELASTICPDU_H
#define COLLISIONELASTICPDU_H

#include <DIS/EntityID.h>
#include <DIS/EntityID.h>
#include <DIS/EventID.h>
#include <DIS/Vector3Float.h>
#include <DIS/Vector3Float.h>
#include <DIS/Vector3Float.h>
#include <DIS/EntityInformationFamilyPdu.h>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// 5.3.3.3. Information about elastic collisions in a DIS exercise shall be communicated using a Collision-Elastic PDU. COMPLETE

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO CollisionElasticPdu : public EntityInformationFamilyPdu
{
protected:
  // ID of the entity that issued the collision PDU
  EntityID _issuingEntityID; 

  // ID of entity that has collided with the issuing entity ID
  EntityID _collidingEntityID; 

  // ID of event
  EventID _collisionEventID; 

  // some padding
  short _pad; 

  // velocity at collision
  Vector3Float _contactVelocity; 

  // mass of issuing entity
  float _mass; 

  // Location with respect to entity the issuing entity collided with
  Vector3Float _location; 

  // tensor values
  float _collisionResultXX; 

  // tensor values
  float _collisionResultXY; 

  // tensor values
  float _collisionResultXZ; 

  // tensor values
  float _collisionResultYY; 

  // tensor values
  float _collisionResultYZ; 

  // tensor values
  float _collisionResultZZ; 

  // This record shall represent the normal vector to the surface at the point of collision detection. The surface normal shall be represented in world coordinates.
  Vector3Float _unitSurfaceNormal; 

  // This field shall represent the degree to which energy is conserved in a collision
  float _coefficientOfRestitution; 


 public:
    CollisionElasticPdu();
    virtual ~CollisionElasticPdu();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    EntityID& getIssuingEntityID(); 
    const EntityID&  getIssuingEntityID() const; 
    void setIssuingEntityID(const EntityID    &pX);

    EntityID& getCollidingEntityID(); 
    const EntityID&  getCollidingEntityID() const; 
    void setCollidingEntityID(const EntityID    &pX);

    EventID& getCollisionEventID(); 
    const EventID&  getCollisionEventID() const; 
    void setCollisionEventID(const EventID    &pX);

    short getPad() const; 
    void setPad(short pX); 

    Vector3Float& getContactVelocity(); 
    const Vector3Float&  getContactVelocity() const; 
    void setContactVelocity(const Vector3Float    &pX);

    float getMass() const; 
    void setMass(float pX); 

    Vector3Float& getLocation(); 
    const Vector3Float&  getLocation() const; 
    void setLocation(const Vector3Float    &pX);

    float getCollisionResultXX() const; 
    void setCollisionResultXX(float pX); 

    float getCollisionResultXY() const; 
    void setCollisionResultXY(float pX); 

    float getCollisionResultXZ() const; 
    void setCollisionResultXZ(float pX); 

    float getCollisionResultYY() const; 
    void setCollisionResultYY(float pX); 

    float getCollisionResultYZ() const; 
    void setCollisionResultYZ(float pX); 

    float getCollisionResultZZ() const; 
    void setCollisionResultZZ(float pX); 

    Vector3Float& getUnitSurfaceNormal(); 
    const Vector3Float&  getUnitSurfaceNormal() const; 
    void setUnitSurfaceNormal(const Vector3Float    &pX);

    float getCoefficientOfRestitution() const; 
    void setCoefficientOfRestitution(float pX); 


virtual int getMarshalledSize() const;

     bool operator  ==(const CollisionElasticPdu& rhs) const;
};
}

#endif
