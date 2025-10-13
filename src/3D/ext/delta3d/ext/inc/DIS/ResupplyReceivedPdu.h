#ifndef RESUPPLYRECEIVEDPDU_H
#define RESUPPLYRECEIVEDPDU_H

#include <DIS/EntityID.h>
#include <DIS/EntityID.h>
#include <DIS/SupplyQuantity.h>
#include <vector>
#include <DIS/LogisticsFamilyPdu.h>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.3.5.3. Receipt of supplies is communiated. COMPLETE

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO ResupplyReceivedPdu : public LogisticsFamilyPdu
{
protected:
  // Entity that is receiving service
  EntityID _receivingEntityID; 

  // Entity that is supplying
  EntityID _supplyingEntityID; 

  // how many supplies are being offered
  unsigned char _numberOfSupplyTypes; 

  // padding
  short _padding1; 

  // padding
  char _padding2; 

  std::vector<SupplyQuantity> _supplies; 


 public:
    ResupplyReceivedPdu();
    virtual ~ResupplyReceivedPdu();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    EntityID& getReceivingEntityID(); 
    const EntityID&  getReceivingEntityID() const; 
    void setReceivingEntityID(const EntityID    &pX);

    EntityID& getSupplyingEntityID(); 
    const EntityID&  getSupplyingEntityID() const; 
    void setSupplyingEntityID(const EntityID    &pX);

    unsigned char getNumberOfSupplyTypes() const; 

    short getPadding1() const; 
    void setPadding1(short pX); 

    char getPadding2() const; 
    void setPadding2(char pX); 

    std::vector<SupplyQuantity>& getSupplies(); 
    const std::vector<SupplyQuantity>& getSupplies() const; 
    void setSupplies(const std::vector<SupplyQuantity>&    pX);


virtual int getMarshalledSize() const;

     bool operator  ==(const ResupplyReceivedPdu& rhs) const;
};
}

#endif
