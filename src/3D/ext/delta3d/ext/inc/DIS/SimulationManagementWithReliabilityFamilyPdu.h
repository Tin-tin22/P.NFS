#ifndef SIMULATIONMANAGEMENTWITHRELIABILITYFAMILYPDU_H
#define SIMULATIONMANAGEMENTWITHRELIABILITYFAMILYPDU_H

#include <DIS/EntityID.h>
#include <DIS/EntityID.h>
#include <DIS/Pdu.h>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.3.12: Abstract superclass for reliable simulation management PDUs

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO SimulationManagementWithReliabilityFamilyPdu : public Pdu
{
protected:
  // Object originatig the request
  EntityID _originatingEntityID; 

  // Object with which this point object is associated
  EntityID _receivingEntityID; 


 public:
    SimulationManagementWithReliabilityFamilyPdu();
    virtual ~SimulationManagementWithReliabilityFamilyPdu();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    EntityID& getOriginatingEntityID(); 
    const EntityID&  getOriginatingEntityID() const; 
    void setOriginatingEntityID(const EntityID    &pX);

    EntityID& getReceivingEntityID(); 
    const EntityID&  getReceivingEntityID() const; 
    void setReceivingEntityID(const EntityID    &pX);


virtual int getMarshalledSize() const;

     bool operator  ==(const SimulationManagementWithReliabilityFamilyPdu& rhs) const;
};
}

#endif
