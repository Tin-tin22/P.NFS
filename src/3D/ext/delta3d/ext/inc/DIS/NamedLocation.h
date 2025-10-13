#ifndef NAMEDLOCATION_H
#define NAMEDLOCATION_H

#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// discrete ostional relationsihip 

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO NamedLocation
{
protected:
  // station name enumeration
  unsigned short _stationName; 

  // station number
  unsigned short _stationNumber; 


 public:
    NamedLocation();
    virtual ~NamedLocation();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    unsigned short getStationName() const; 
    void setStationName(unsigned short pX); 

    unsigned short getStationNumber() const; 
    void setStationNumber(unsigned short pX); 


virtual int getMarshalledSize() const;

     bool operator  ==(const NamedLocation& rhs) const;
};
}

#endif
