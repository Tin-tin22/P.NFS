#ifndef VECTOR3DOUBLE_H
#define VECTOR3DOUBLE_H

#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.3.34. Three double precision floating point values, x, y, and z

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO Vector3Double
{
protected:
  // X value
  double _x; 

  // Y value
  double _y; 

  // Z value
  double _z; 


 public:
    Vector3Double();
    virtual ~Vector3Double();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    double getX() const; 
    void setX(double pX); 

    double getY() const; 
    void setY(double pX); 

    double getZ() const; 
    void setZ(double pX); 


virtual int getMarshalledSize() const;

     bool operator  ==(const Vector3Double& rhs) const;
};
}

#endif
