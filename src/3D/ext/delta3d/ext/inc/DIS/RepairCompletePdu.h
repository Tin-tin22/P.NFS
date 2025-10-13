#ifndef REPAIRCOMPLETEPDU_H
#define REPAIRCOMPLETEPDU_H

#include <DIS/EntityID.h>
#include <DIS/EntityID.h>
#include <DIS/LogisticsFamilyPdu.h>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.2.5.5. Repair is complete. COMPLETE

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO RepairCompletePdu : public LogisticsFamilyPdu
{
protected:
  // Entity that is receiving service
  EntityID _receivingEntityID; 

  // Entity that is supplying
  EntityID _repairingEntityID; 

  // Enumeration for type of repair
  unsigned short _repair; 

  // padding
  short _padding; 


 public:
    RepairCompletePdu();
    virtual ~RepairCompletePdu();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    EntityID& getReceivingEntityID(); 
    const EntityID&  getReceivingEntityID() const; 
    void setReceivingEntityID(const EntityID    &pX);

    EntityID& getRepairingEntityID(); 
    const EntityID&  getRepairingEntityID() const; 
    void setRepairingEntityID(const EntityID    &pX);

    unsigned short getRepair() const; 
    void setRepair(unsigned short pX); 

    short getPadding() const; 
    void setPadding(short pX); 


virtual int getMarshalledSize() const;

     bool operator  ==(const RepairCompletePdu& rhs) const;
};
}

#endif
