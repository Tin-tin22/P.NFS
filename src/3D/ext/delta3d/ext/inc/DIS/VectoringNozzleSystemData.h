#ifndef VECTORINGNOZZLESYSTEMDATA_H
#define VECTORINGNOZZLESYSTEMDATA_H

#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Data about a vectoring nozzle system

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO VectoringNozzleSystemData
{
protected:
  // horizontal deflection angle
  float _horizontalDeflectionAngle; 

  // vertical deflection angle
  float _verticalDeflectionAngle; 


 public:
    VectoringNozzleSystemData();
    virtual ~VectoringNozzleSystemData();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    float getHorizontalDeflectionAngle() const; 
    void setHorizontalDeflectionAngle(float pX); 

    float getVerticalDeflectionAngle() const; 
    void setVerticalDeflectionAngle(float pX); 


virtual int getMarshalledSize() const;

     bool operator  ==(const VectoringNozzleSystemData& rhs) const;
};
}

#endif
