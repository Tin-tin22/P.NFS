#ifndef VECTOR3FLOAT_H
#define VECTOR3FLOAT_H

#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.2.33. Three floating point values, x, y, and z

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO Vector3Float
{
protected:
  // X value
  float _x; 

  // y Value
  float _y; 

  // Z value
  float _z; 


 public:
    Vector3Float();
    virtual ~Vector3Float();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    float getX() const; 
    void setX(float pX); 

    float getY() const; 
    void setY(float pX); 

    float getZ() const; 
    void setZ(float pX); 


virtual int getMarshalledSize() const;

     bool operator  ==(const Vector3Float& rhs) const;
};
}

#endif
