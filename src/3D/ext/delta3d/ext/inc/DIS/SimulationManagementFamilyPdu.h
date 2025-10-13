#ifndef SIMULATIONMANAGEMENTFAMILYPDU_H
#define SIMULATIONMANAGEMENTFAMILYPDU_H

#include <DIS/EntityID.h>
#include <DIS/EntityID.h>
#include <DIS/Pdu.h>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.3.6. Abstract superclass for PDUs relating to the simulation itself. COMPLETE

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO SimulationManagementFamilyPdu : public Pdu
{
protected:
  // Entity that is sending message
  EntityID _originatingEntityID; 

  // Entity that is intended to receive message
  EntityID _receivingEntityID; 


 public:
    SimulationManagementFamilyPdu();
    virtual ~SimulationManagementFamilyPdu();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    EntityID& getOriginatingEntityID(); 
    const EntityID&  getOriginatingEntityID() const; 
    void setOriginatingEntityID(const EntityID    &pX);

    EntityID& getReceivingEntityID(); 
    const EntityID&  getReceivingEntityID() const; 
    void setReceivingEntityID(const EntityID    &pX);


virtual int getMarshalledSize() const;

     bool operator  ==(const SimulationManagementFamilyPdu& rhs) const;
};
}

#endif
