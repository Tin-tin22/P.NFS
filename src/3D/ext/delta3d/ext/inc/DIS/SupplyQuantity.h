#ifndef SUPPLYQUANTITY_H
#define SUPPLYQUANTITY_H

#include <DIS/EntityID.h>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.2.30. A supply, and the amount of that supply. Similar to an entity kind but with the addition of a quantity.

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO SupplyQuantity
{
protected:
  // Type of supply
  EntityID _supplyType; 

  // quantity to be supplied
  unsigned char _quantity; 


 public:
    SupplyQuantity();
    virtual ~SupplyQuantity();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    EntityID& getSupplyType(); 
    const EntityID&  getSupplyType() const; 
    void setSupplyType(const EntityID    &pX);

    unsigned char getQuantity() const; 
    void setQuantity(unsigned char pX); 


virtual int getMarshalledSize() const;

     bool operator  ==(const SupplyQuantity& rhs) const;
};
}

#endif
