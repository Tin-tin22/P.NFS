#ifndef REPAIRRESPONSEPDU_H
#define REPAIRRESPONSEPDU_H

#include <DIS/EntityID.h>
#include <DIS/EntityID.h>
#include <DIS/LogisticsFamilyPdu.h>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.2.5.6. Sent after repair complete PDU. COMPLETE

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO RepairResponsePdu : public LogisticsFamilyPdu
{
protected:
  // Entity that is receiving service
  EntityID _receivingEntityID; 

  // Entity that is supplying
  EntityID _repairingEntityID; 

  // Result of repair operation
  unsigned char _repairResult; 

  // padding
  short _padding1; 

  // padding
  char _padding2; 


 public:
    RepairResponsePdu();
    virtual ~RepairResponsePdu();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    EntityID& getReceivingEntityID(); 
    const EntityID&  getReceivingEntityID() const; 
    void setReceivingEntityID(const EntityID    &pX);

    EntityID& getRepairingEntityID(); 
    const EntityID&  getRepairingEntityID() const; 
    void setRepairingEntityID(const EntityID    &pX);

    unsigned char getRepairResult() const; 
    void setRepairResult(unsigned char pX); 

    short getPadding1() const; 
    void setPadding1(short pX); 

    char getPadding2() const; 
    void setPadding2(char pX); 


virtual int getMarshalledSize() const;

     bool operator  ==(const RepairResponsePdu& rhs) const;
};
}

#endif
