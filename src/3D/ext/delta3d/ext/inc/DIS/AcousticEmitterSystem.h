#ifndef ACOUSTICEMITTERSYSTEM_H
#define ACOUSTICEMITTERSYSTEM_H

#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// 5.3.35: Information about a particular UA emitter shall be represented using an Acoustic Emitter System record. This record shall consist of three fields: Acoustic Name, Function, and Acoustic ID Number

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO AcousticEmitterSystem
{
protected:
  // This field shall specify the system for a particular UA emitter.
  unsigned short _acousticName; 

  // This field shall describe the function of the acoustic system. 
  unsigned char _acousticFunction; 

  // This field shall specify the UA emitter identification number relative to a specific system. This field shall be represented by an 8-bit unsigned integer. This field allows the differentiation of multiple systems on an entity, even if in some instances two or more of the systems may be identical UA emitter types. Numbering of systems shall begin with the value 1. 
  unsigned char _acousticID; 


 public:
    AcousticEmitterSystem();
    virtual ~AcousticEmitterSystem();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    unsigned short getAcousticName() const; 
    void setAcousticName(unsigned short pX); 

    unsigned char getAcousticFunction() const; 
    void setAcousticFunction(unsigned char pX); 

    unsigned char getAcousticID() const; 
    void setAcousticID(unsigned char pX); 


virtual int getMarshalledSize() const;

     bool operator  ==(const AcousticEmitterSystem& rhs) const;
};
}

#endif
