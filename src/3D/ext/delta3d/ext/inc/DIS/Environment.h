#ifndef ENVIRONMENT_H
#define ENVIRONMENT_H

#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.2.40. Information about a geometry, a state associated with a geometry, a bounding volume, or an associated entity ID. NOTE: this class requires hand coding.

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO Environment
{
protected:
  // Record type
  unsigned int _environmentType; 

  // length, in bits
  unsigned char _length; 

  // Identify the sequentially numbered record index
  unsigned char _index; 

  // padding
  unsigned char _padding1; 

  // Geometry or state record
  unsigned char _geometry; 

  // padding to bring the total size up to a 64 bit boundry
  unsigned char _padding2; 


 public:
    Environment();
    virtual ~Environment();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    unsigned int getEnvironmentType() const; 
    void setEnvironmentType(unsigned int pX); 

    unsigned char getLength() const; 
    void setLength(unsigned char pX); 

    unsigned char getIndex() const; 
    void setIndex(unsigned char pX); 

    unsigned char getPadding1() const; 
    void setPadding1(unsigned char pX); 

    unsigned char getGeometry() const; 
    void setGeometry(unsigned char pX); 

    unsigned char getPadding2() const; 
    void setPadding2(unsigned char pX); 


virtual int getMarshalledSize() const;

     bool operator  ==(const Environment& rhs) const;
};
}

#endif
