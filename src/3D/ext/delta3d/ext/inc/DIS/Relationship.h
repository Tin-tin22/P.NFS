#ifndef RELATIONSHIP_H
#define RELATIONSHIP_H

#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// 5.2.56. Purpose for joinging two entities

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO Relationship
{
protected:
  // Nature of join
  unsigned short _nature; 

  // position of join
  unsigned short _position; 


 public:
    Relationship();
    virtual ~Relationship();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    unsigned short getNature() const; 
    void setNature(unsigned short pX); 

    unsigned short getPosition() const; 
    void setPosition(unsigned short pX); 


virtual int getMarshalledSize() const;

     bool operator  ==(const Relationship& rhs) const;
};
}

#endif
