#ifndef DEADRECKONINGPARAMETER_H
#define DEADRECKONINGPARAMETER_H

#include <DIS/Vector3Float.h>
#include <DIS/Vector3Float.h>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// represents values used in dead reckoning algorithms

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO DeadReckoningParameter
{
protected:
  // enumeration of what dead reckoning algorighm to use
  unsigned char _deadReckoningAlgorithm; 

  // other parameters to use in the dead reckoning algorithm
  char _otherParameters[15]; 

  // Linear acceleration of the entity
  Vector3Float _entityLinearAcceleration; 

  // angular velocity of the entity
  Vector3Float _entityAngularVelocity; 


 public:
    DeadReckoningParameter();
    virtual ~DeadReckoningParameter();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    unsigned char getDeadReckoningAlgorithm() const; 
    void setDeadReckoningAlgorithm(unsigned char pX); 

    char*  getOtherParameters(); 
    const char*  getOtherParameters() const; 
    void setOtherParameters( const char*    pX);

    Vector3Float& getEntityLinearAcceleration(); 
    const Vector3Float&  getEntityLinearAcceleration() const; 
    void setEntityLinearAcceleration(const Vector3Float    &pX);

    Vector3Float& getEntityAngularVelocity(); 
    const Vector3Float&  getEntityAngularVelocity() const; 
    void setEntityAngularVelocity(const Vector3Float    &pX);


virtual int getMarshalledSize() const;

     bool operator  ==(const DeadReckoningParameter& rhs) const;
};
}

#endif
