#ifndef POINTOBJECTSTATEPDU_H
#define POINTOBJECTSTATEPDU_H

#include <DIS/EntityID.h>
#include <DIS/EntityID.h>
#include <DIS/ObjectType.h>
#include <DIS/Vector3Double.h>
#include <DIS/Orientation.h>
#include <DIS/SimulationAddress.h>
#include <DIS/SimulationAddress.h>
#include <DIS/SyntheticEnvironmentFamilyPdu.h>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.3.11.3: Inormation abut the addition or modification of a synthecic enviroment object that is anchored      to the terrain with a single point. COMPLETE

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO PointObjectStatePdu : public SyntheticEnvironmentFamilyPdu
{
protected:
  // Object in synthetic environment
  EntityID _objectID; 

  // Object with which this point object is associated
  EntityID _referencedObjectID; 

  // unique update number of each state transition of an object
  unsigned short _updateNumber; 

  // force ID
  unsigned char _forceID; 

  // modifications
  unsigned char _modifications; 

  // Object type
  ObjectType _objectType; 

  // Object location
  Vector3Double _objectLocation; 

  // Object orientation
  Orientation _objectOrientation; 

  // Object apperance
  double _objectAppearance; 

  // requesterID
  SimulationAddress _requesterID; 

  // receiver ID
  SimulationAddress _receivingID; 

  // padding
  unsigned int _pad2; 


 public:
    PointObjectStatePdu();
    virtual ~PointObjectStatePdu();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    EntityID& getObjectID(); 
    const EntityID&  getObjectID() const; 
    void setObjectID(const EntityID    &pX);

    EntityID& getReferencedObjectID(); 
    const EntityID&  getReferencedObjectID() const; 
    void setReferencedObjectID(const EntityID    &pX);

    unsigned short getUpdateNumber() const; 
    void setUpdateNumber(unsigned short pX); 

    unsigned char getForceID() const; 
    void setForceID(unsigned char pX); 

    unsigned char getModifications() const; 
    void setModifications(unsigned char pX); 

    ObjectType& getObjectType(); 
    const ObjectType&  getObjectType() const; 
    void setObjectType(const ObjectType    &pX);

    Vector3Double& getObjectLocation(); 
    const Vector3Double&  getObjectLocation() const; 
    void setObjectLocation(const Vector3Double    &pX);

    Orientation& getObjectOrientation(); 
    const Orientation&  getObjectOrientation() const; 
    void setObjectOrientation(const Orientation    &pX);

    double getObjectAppearance() const; 
    void setObjectAppearance(double pX); 

    SimulationAddress& getRequesterID(); 
    const SimulationAddress&  getRequesterID() const; 
    void setRequesterID(const SimulationAddress    &pX);

    SimulationAddress& getReceivingID(); 
    const SimulationAddress&  getReceivingID() const; 
    void setReceivingID(const SimulationAddress    &pX);

    unsigned int getPad2() const; 
    void setPad2(unsigned int pX); 


virtual int getMarshalledSize() const;

     bool operator  ==(const PointObjectStatePdu& rhs) const;
};
}

#endif
