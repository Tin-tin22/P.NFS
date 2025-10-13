#ifndef AREALOBJECTSTATEPDU_H
#define AREALOBJECTSTATEPDU_H

#include <DIS/EntityID.h>
#include <DIS/EntityID.h>
#include <DIS/EntityType.h>
#include <DIS/SixByteChunk.h>
#include <DIS/SimulationAddress.h>
#include <DIS/SimulationAddress.h>
#include <DIS/Vector3Double.h>
#include <vector>
#include <DIS/SyntheticEnvironmentFamilyPdu.h>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.3.11.5: Information about the addition/modification of an oobject that is geometrically      achored to the terrain with a set of three or more points that come to a closure. COMPLETE

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO ArealObjectStatePdu : public SyntheticEnvironmentFamilyPdu
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

  // modifications enumeration
  unsigned char _modifications; 

  // Object type
  EntityType _objectType; 

  // Object appearance
  SixByteChunk _objectAppearance; 

  // Number of points
  unsigned short _numberOfPoints; 

  // requesterID
  SimulationAddress _requesterID; 

  // receiver ID
  SimulationAddress _receivingID; 

  // location of object
  std::vector<Vector3Double> _objectLocation; 


 public:
    ArealObjectStatePdu();
    virtual ~ArealObjectStatePdu();

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

    EntityType& getObjectType(); 
    const EntityType&  getObjectType() const; 
    void setObjectType(const EntityType    &pX);

    SixByteChunk& getObjectAppearance(); 
    const SixByteChunk&  getObjectAppearance() const; 
    void setObjectAppearance(const SixByteChunk    &pX);

    unsigned short getNumberOfPoints() const; 

    SimulationAddress& getRequesterID(); 
    const SimulationAddress&  getRequesterID() const; 
    void setRequesterID(const SimulationAddress    &pX);

    SimulationAddress& getReceivingID(); 
    const SimulationAddress&  getReceivingID() const; 
    void setReceivingID(const SimulationAddress    &pX);

    std::vector<Vector3Double>& getObjectLocation(); 
    const std::vector<Vector3Double>& getObjectLocation() const; 
    void setObjectLocation(const std::vector<Vector3Double>&    pX);


virtual int getMarshalledSize() const;

     bool operator  ==(const ArealObjectStatePdu& rhs) const;
};
}

#endif
