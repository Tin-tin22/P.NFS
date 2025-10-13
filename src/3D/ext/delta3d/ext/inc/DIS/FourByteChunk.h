#ifndef FOURBYTECHUNK_H
#define FOURBYTECHUNK_H

#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// 32 bit piece of data

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO FourByteChunk
{
protected:
  // four bytes of arbitrary data
  char _otherParameters[4]; 


 public:
    FourByteChunk();
    virtual ~FourByteChunk();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    char*  getOtherParameters(); 
    const char*  getOtherParameters() const; 
    void setOtherParameters( const char*    pX);


virtual int getMarshalledSize() const;

     bool operator  ==(const FourByteChunk& rhs) const;
};
}

#endif
