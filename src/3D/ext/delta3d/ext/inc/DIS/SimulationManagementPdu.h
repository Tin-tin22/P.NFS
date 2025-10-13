#ifndef SIMULATIONMANAGEMENTPDU_H
#define SIMULATIONMANAGEMENTPDU_H

#include <DIS/EntityID.h>
#include <DIS/EntityID.h>
#include <DIS/Pdu.h>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Abstract superclass for PDUs relating to the simulation itself
class EXPORT_MACRO SimulationManagementPdu : public Pdu
{
protected:
  // Entity that is sending message
  EntityID _originatingEntityID; 

  // Entity that is intended to receive message
  EntityID _receivingEntityID; 


 public:
    SimulationManagementPdu();
    virtual ~SimulationManagementPdu();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    EntityID& getOriginatingEntityID(); 
    const EntityID&  getOriginatingEntityID() const; 
    void setOriginatingEntityID(const EntityID    &pX);

    EntityID& getReceivingEntityID(); 
    const EntityID&  getReceivingEntityID() const; 
    void setReceivingEntityID(const EntityID    &pX);


virtual int getMarshalledSize() const;

     bool operator  ==(const SimulationManagementPdu& rhs) const;
};
}

#endif
