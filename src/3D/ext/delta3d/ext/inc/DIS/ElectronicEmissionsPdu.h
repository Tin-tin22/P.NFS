#ifndef ELECTRONICEMISSIONSPDU_H
#define ELECTRONICEMISSIONSPDU_H

#include <DIS/EntityID.h>
#include <DIS/EventID.h>
#include <DIS/ElectronicEmissionSystemData.h>
#include <vector>
#include <DIS/DistributedEmissionsFamilyPdu.h>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.3.7.1. Information about active electronic warfare (EW) emissions and active EW countermeasures shall be communicated using an Electromagnetic Emission PDU. COMPLETE (I think)

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO ElectronicEmissionsPdu : public DistributedEmissionsFamilyPdu
{
protected:
  // ID of the entity emitting
  EntityID _emittingEntityID; 

  // ID of event
  EventID _eventID; 

  // This field shall be used to indicate if the data in the PDU represents a state update or just data that has changed since issuance of the last Electromagnetic Emission PDU [relative to the identified entity and emission system(s)].
  unsigned char _stateUpdateIndicator; 

  // This field shall specify the number of emission systems being described in the current PDU.
  unsigned char _numberOfSystems; 

  // Electronic emmissions systems
  std::vector<ElectronicEmissionSystemData> _systems; 


 public:
    ElectronicEmissionsPdu();
    virtual ~ElectronicEmissionsPdu();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    EntityID& getEmittingEntityID(); 
    const EntityID&  getEmittingEntityID() const; 
    void setEmittingEntityID(const EntityID    &pX);

    EventID& getEventID(); 
    const EventID&  getEventID() const; 
    void setEventID(const EventID    &pX);

    unsigned char getStateUpdateIndicator() const; 
    void setStateUpdateIndicator(unsigned char pX); 

    unsigned char getNumberOfSystems() const; 

    std::vector<ElectronicEmissionSystemData>& getSystems(); 
    const std::vector<ElectronicEmissionSystemData>& getSystems() const; 
    void setSystems(const std::vector<ElectronicEmissionSystemData>&    pX);


virtual int getMarshalledSize() const;

     bool operator  ==(const ElectronicEmissionsPdu& rhs) const;
};
}

#endif
