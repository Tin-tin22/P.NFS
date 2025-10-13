#ifndef MODULATIONTYPE_H
#define MODULATIONTYPE_H

#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Radio modulation

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO ModulationType
{
protected:
  // spread spectrum, 16 bit boolean array
  unsigned short _spreadSpectrum; 

  // major
  unsigned short _major; 

  // detail
  unsigned short _detail; 

  // system
  unsigned short _system; 


 public:
    ModulationType();
    virtual ~ModulationType();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    unsigned short getSpreadSpectrum() const; 
    void setSpreadSpectrum(unsigned short pX); 

    unsigned short getMajor() const; 
    void setMajor(unsigned short pX); 

    unsigned short getDetail() const; 
    void setDetail(unsigned short pX); 

    unsigned short getSystem() const; 
    void setSystem(unsigned short pX); 


virtual int getMarshalledSize() const;

     bool operator  ==(const ModulationType& rhs) const;
};
}

#endif
