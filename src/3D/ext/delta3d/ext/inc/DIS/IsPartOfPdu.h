#ifndef ISPARTOFPDU_H
#define ISPARTOFPDU_H

#include <DIS/EntityID.h>
#include <DIS/EntityID.h>
#include <DIS/Relationship.h>
#include <DIS/Vector3Float.h>
#include <DIS/NamedLocation.h>
#include <DIS/EntityType.h>
#include <DIS/EntityManagementFamilyPdu.h>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.3.9.4 The joining of two or more simulation entities is communicated by this PDU. COMPLETE

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO IsPartOfPdu : public EntityManagementFamilyPdu
{
protected:
  // ID of entity originating PDU
  EntityID _orginatingEntityID; 

  // ID of entity receiving PDU
  EntityID _receivingEntityID; 

  // relationship of joined parts
  Relationship _relationship; 

  // location of part; centroid of part in host's coordinate system. x=range, y=bearing, z=0
  Vector3Float _partLocation; 

  // named location
  NamedLocation _namedLocationID; 

  // entity type
  EntityType _partEntityType; 


 public:
    IsPartOfPdu();
    virtual ~IsPartOfPdu();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    EntityID& getOrginatingEntityID(); 
    const EntityID&  getOrginatingEntityID() const; 
    void setOrginatingEntityID(const EntityID    &pX);

    EntityID& getReceivingEntityID(); 
    const EntityID&  getReceivingEntityID() const; 
    void setReceivingEntityID(const EntityID    &pX);

    Relationship& getRelationship(); 
    const Relationship&  getRelationship() const; 
    void setRelationship(const Relationship    &pX);

    Vector3Float& getPartLocation(); 
    const Vector3Float&  getPartLocation() const; 
    void setPartLocation(const Vector3Float    &pX);

    NamedLocation& getNamedLocationID(); 
    const NamedLocation&  getNamedLocationID() const; 
    void setNamedLocationID(const NamedLocation    &pX);

    EntityType& getPartEntityType(); 
    const EntityType&  getPartEntityType() const; 
    void setPartEntityType(const EntityType    &pX);


virtual int getMarshalledSize() const;

     bool operator  ==(const IsPartOfPdu& rhs) const;
};
}

#endif
