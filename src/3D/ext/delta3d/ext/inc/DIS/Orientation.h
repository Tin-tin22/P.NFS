#ifndef ORIENTATION_H
#define ORIENTATION_H

#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.2.17. Three floating point values representing an orientation, psi, theta, and phi, aka the euler angles, in radians

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO Orientation
{
protected:
  float _psi; 

  float _theta; 

  float _phi; 


 public:
    Orientation();
    virtual ~Orientation();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    float getPsi() const; 
    void setPsi(float pX); 

    float getTheta() const; 
    void setTheta(float pX); 

    float getPhi() const; 
    void setPhi(float pX); 


virtual int getMarshalledSize() const;

     bool operator  ==(const Orientation& rhs) const;
};
}

#endif
