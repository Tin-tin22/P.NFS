#ifndef EMITTERSYSTEM_H
#define EMITTERSYSTEM_H

#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.2.11. This field shall specify information about a particular emitter system

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO EmitterSystem
{
protected:
  // Name of the emitter, 16 bit enumeration
  unsigned short _emitterName; 

  // function of the emitter, 8 bit enumeration
  unsigned char _function; 

  // emitter ID, 8 bit enumeration
  unsigned char _emitterIdNumber; 


 public:
    EmitterSystem();
    virtual ~EmitterSystem();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    unsigned short getEmitterName() const; 
    void setEmitterName(unsigned short pX); 

    unsigned char getFunction() const; 
    void setFunction(unsigned char pX); 

    unsigned char getEmitterIdNumber() const; 
    void setEmitterIdNumber(unsigned char pX); 


virtual int getMarshalledSize() const;

     bool operator  ==(const EmitterSystem& rhs) const;
};
}

#endif
