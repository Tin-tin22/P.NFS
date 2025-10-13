#ifndef SHAFTRPMS_H
#define SHAFTRPMS_H

#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Shaft RPMs, used in underwater acoustic clacluations.

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO ShaftRPMs
{
protected:
  // Current shaft RPMs
  short _currentShaftRPMs; 

  // ordered shaft rpms
  short _orderedShaftRPMs; 

  // rate of change of shaft RPMs
  float _shaftRPMRateOfChange; 


 public:
    ShaftRPMs();
    virtual ~ShaftRPMs();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    short getCurrentShaftRPMs() const; 
    void setCurrentShaftRPMs(short pX); 

    short getOrderedShaftRPMs() const; 
    void setOrderedShaftRPMs(short pX); 

    float getShaftRPMRateOfChange() const; 
    void setShaftRPMRateOfChange(float pX); 


virtual int getMarshalledSize() const;

     bool operator  ==(const ShaftRPMs& rhs) const;
};
}

#endif
