#ifndef ANGULARVELOCITYVECTOR_H
#define ANGULARVELOCITYVECTOR_H

#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// 5.2.2: angular velocity measured in radians per second out each of the entity's own coordinate axes.

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO AngularVelocityVector
{
protected:
  // velocity about the x axis
  float _x; 

  // velocity about the y axis
  float _y; 

  // velocity about the zaxis
  float _z; 


 public:
    AngularVelocityVector();
    virtual ~AngularVelocityVector();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    float getX() const; 
    void setX(float pX); 

    float getY() const; 
    void setY(float pX); 

    float getZ() const; 
    void setZ(float pX); 


virtual int getMarshalledSize() const;

     bool operator  ==(const AngularVelocityVector& rhs) const;
};
}

#endif
