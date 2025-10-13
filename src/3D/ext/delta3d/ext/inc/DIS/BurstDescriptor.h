#ifndef BURSTDESCRIPTOR_H
#define BURSTDESCRIPTOR_H

#include <DIS/EntityType.h>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.2.7. Specifies the type of muntion fired, the type of warhead, the         type of fuse, the number of rounds fired, and the rate at which the roudns are fired in         rounds per minute.

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO BurstDescriptor
{
protected:
  // What munition was used in the burst
  EntityType _munition; 

  // type of warhead
  unsigned short _warhead; 

  // type of fuse used
  unsigned short _fuse; 

  // how many of the munition were fired
  unsigned short _quantity; 

  // rate at which the munition was fired
  unsigned short _rate; 


 public:
    BurstDescriptor();
    virtual ~BurstDescriptor();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    EntityType& getMunition(); 
    const EntityType&  getMunition() const; 
    void setMunition(const EntityType    &pX);

    unsigned short getWarhead() const; 
    void setWarhead(unsigned short pX); 

    unsigned short getFuse() const; 
    void setFuse(unsigned short pX); 

    unsigned short getQuantity() const; 
    void setQuantity(unsigned short pX); 

    unsigned short getRate() const; 
    void setRate(unsigned short pX); 


virtual int getMarshalledSize() const;

     bool operator  ==(const BurstDescriptor& rhs) const;
};
}

#endif
