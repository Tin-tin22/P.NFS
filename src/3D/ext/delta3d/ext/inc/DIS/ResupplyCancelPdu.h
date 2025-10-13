#ifndef RESUPPLYCANCELPDU_H
#define RESUPPLYCANCELPDU_H

#include <DIS/EntityID.h>
#include <DIS/EntityID.h>
#include <DIS/LogisticsFamilyPdu.h>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.2.5.4. Cancel of resupply by either the receiving or supplying entity. COMPLETE

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO ResupplyCancelPdu : public LogisticsFamilyPdu
{
protected:
  // Entity that is receiving service
  EntityID _receivingEntityID; 

  // Entity that is supplying
  EntityID _supplyingEntityID; 


 public:
    ResupplyCancelPdu();
    virtual ~ResupplyCancelPdu();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    EntityID& getReceivingEntityID(); 
    const EntityID&  getReceivingEntityID() const; 
    void setReceivingEntityID(const EntityID    &pX);

    EntityID& getSupplyingEntityID(); 
    const EntityID&  getSupplyingEntityID() const; 
    void setSupplyingEntityID(const EntityID    &pX);


virtual int getMarshalledSize() const;

     bool operator  ==(const ResupplyCancelPdu& rhs) const;
};
}

#endif
