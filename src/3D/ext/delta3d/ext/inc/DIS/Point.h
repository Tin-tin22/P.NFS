#ifndef POINT_H
#define POINT_H

#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// x,y point

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO Point
{
protected:
  // x
  float _x; 

  // y
  float _y; 


 public:
    Point();
    virtual ~Point();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    float getX() const; 
    void setX(float pX); 

    float getY() const; 
    void setY(float pX); 


virtual int getMarshalledSize() const;

     bool operator  ==(const Point& rhs) const;
};
}

#endif
