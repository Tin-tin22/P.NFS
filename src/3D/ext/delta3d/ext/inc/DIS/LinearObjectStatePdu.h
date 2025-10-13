#ifndef LINEAROBJECTSTATEPDU_H
#define LINEAROBJECTSTATEPDU_H

#include <DIS/EntityID.h>
#include <DIS/EntityID.h>
#include <DIS/SimulationAddress.h>
#include <DIS/SimulationAddress.h>
#include <DIS/ObjectType.h>
#include <DIS/LinearSegmentParameter.h>
#include <vector>
#include <DIS/SyntheticEnvironmentFamilyPdu.h>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.3.11.4: Information abut the addition or modification of a synthecic enviroment object that      is anchored to the terrain with a single point and has size or orientation. COMPLETE

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO LinearObjectStatePdu : public SyntheticEnvironmentFamilyPdu
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

  // number of linear segment parameters
  unsigned char _numberOfSegments; 

  // requesterID
  SimulationAddress _requesterID; 

  // receiver ID
  SimulationAddress _receivingID; 

  // Object type
  ObjectType _objectType; 

  // Linear segment parameters
  std::vector<LinearSegmentParameter> _linearSegmentParameters; 


 public:
    LinearObjectStatePdu();
    virtual ~LinearObjectStatePdu();

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

    unsigned char getNumberOfSegments() const; 

    SimulationAddress& getRequesterID(); 
    const SimulationAddress&  getRequesterID() const; 
    void setRequesterID(const SimulationAddress    &pX);

    SimulationAddress& getReceivingID(); 
    const SimulationAddress&  getReceivingID() const; 
    void setReceivingID(const SimulationAddress    &pX);

    ObjectType& getObjectType(); 
    const ObjectType&  getObjectType() const; 
    void setObjectType(const ObjectType    &pX);

    std::vector<LinearSegmentParameter>& getLinearSegmentParameters(); 
    const std::vector<LinearSegmentParameter>& getLinearSegmentParameters() const; 
    void setLinearSegmentParameters(const std::vector<LinearSegmentParameter>&    pX);


virtual int getMarshalledSize() const;

     bool operator  ==(const LinearObjectStatePdu& rhs) const;
};
}

#endif
