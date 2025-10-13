#ifndef APADATA_H
#define APADATA_H

#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Used in UA PDU

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO ApaData
{
protected:
  // Index of APA parameter
  unsigned short _parameterIndex; 

  // Index of APA parameter
  short _parameterValue; 


 public:
    ApaData();
    virtual ~ApaData();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    unsigned short getParameterIndex() const; 
    void setParameterIndex(unsigned short pX); 

    short getParameterValue() const; 
    void setParameterValue(short pX); 


virtual int getMarshalledSize() const;

     bool operator  ==(const ApaData& rhs) const;
};
}

#endif
