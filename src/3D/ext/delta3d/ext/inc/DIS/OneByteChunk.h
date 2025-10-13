#ifndef ONEBYTECHUNK_H
#define ONEBYTECHUNK_H

#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// 8 bit piece of data

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO OneByteChunk
{
protected:
  // one byte of arbitrary data
  char _otherParameters[1]; 


 public:
    OneByteChunk();
    virtual ~OneByteChunk();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    char*  getOtherParameters(); 
    const char*  getOtherParameters() const; 
    void setOtherParameters( const char*    pX);


virtual int getMarshalledSize() const;

     bool operator  ==(const OneByteChunk& rhs) const;
};
}

#endif
