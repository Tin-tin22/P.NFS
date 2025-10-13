#ifndef SPHERICALHARMONICANTENNAPATTERN_H
#define SPHERICALHARMONICANTENNAPATTERN_H

#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.2.4.3. Used when the antenna pattern type in the transmitter pdu is of value 2.         Specified the direction and radiation pattern from a radio transmitter's antenna.        NOTE: this class must be hand-coded to clean up some implementation details.

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO SphericalHarmonicAntennaPattern
{
protected:
  char _order; 


 public:
    SphericalHarmonicAntennaPattern();
    virtual ~SphericalHarmonicAntennaPattern();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    char getOrder() const; 
    void setOrder(char pX); 


virtual int getMarshalledSize() const;

     bool operator  ==(const SphericalHarmonicAntennaPattern& rhs) const;
};
}

#endif
