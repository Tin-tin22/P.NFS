#ifndef ANTENNALOCATION_H
#define ANTENNALOCATION_H

#include <DIS/Vector3Double.h>
#include <DIS/Vector3Float.h>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// 5.2.3: location of the radiating portion of the antenna, specified in world coordinates and         entity coordinates.

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO AntennaLocation
{
protected:
  // Location of the radiating portion of the antenna in world    coordinates
  Vector3Double _antennaLocation; 

  // Location of the radiating portion of the antenna     in entity coordinates
  Vector3Float _relativeAntennaLocation; 


 public:
    AntennaLocation();
    virtual ~AntennaLocation();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    Vector3Double& getAntennaLocation(); 
    const Vector3Double&  getAntennaLocation() const; 
    void setAntennaLocation(const Vector3Double    &pX);

    Vector3Float& getRelativeAntennaLocation(); 
    const Vector3Float&  getRelativeAntennaLocation() const; 
    void setRelativeAntennaLocation(const Vector3Float    &pX);


virtual int getMarshalledSize() const;

     bool operator  ==(const AntennaLocation& rhs) const;
};
}

#endif
