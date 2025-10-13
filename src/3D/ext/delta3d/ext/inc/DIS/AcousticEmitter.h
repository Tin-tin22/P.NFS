#ifndef ACOUSTICEMITTER_H
#define ACOUSTICEMITTER_H

#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.2.35. information about a specific UA emmtter

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO AcousticEmitter
{
protected:
  // the system for a particular UA emitter, and an enumeration
  unsigned short _acousticName; 

  // The function of the acoustic system
  unsigned char _function; 

  // The UA emitter identification number relative to a specific system
  unsigned char _acousticIdNumber; 


 public:
    AcousticEmitter();
    virtual ~AcousticEmitter();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    unsigned short getAcousticName() const; 
    void setAcousticName(unsigned short pX); 

    unsigned char getFunction() const; 
    void setFunction(unsigned char pX); 

    unsigned char getAcousticIdNumber() const; 
    void setAcousticIdNumber(unsigned char pX); 


virtual int getMarshalledSize() const;

     bool operator  ==(const AcousticEmitter& rhs) const;
};
}

#endif
