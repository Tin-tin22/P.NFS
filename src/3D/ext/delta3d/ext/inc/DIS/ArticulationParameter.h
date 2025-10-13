#ifndef ARTICULATIONPARAMETER_H
#define ARTICULATIONPARAMETER_H

#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.2.5. Articulation parameters for  movable parts and attached parts of an entity. Specifes wether or not a change has occured,  the part identifcation of the articulated part to which it is attached, and the type and value of each parameter.

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO ArticulationParameter
{
protected:
  unsigned char _parameterTypeDesignator; 

  unsigned char _changeIndicator; 

  unsigned short _partAttachedTo; 

  int _parameterType; 

  double _parameterValue; 


 public:
    ArticulationParameter();
    virtual ~ArticulationParameter();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    unsigned char getParameterTypeDesignator() const; 
    void setParameterTypeDesignator(unsigned char pX); 

    unsigned char getChangeIndicator() const; 
    void setChangeIndicator(unsigned char pX); 

    unsigned short getPartAttachedTo() const; 
    void setPartAttachedTo(unsigned short pX); 

    int getParameterType() const; 
    void setParameterType(int pX); 

    double getParameterValue() const; 
    void setParameterValue(double pX); 


virtual int getMarshalledSize() const;

     bool operator  ==(const ArticulationParameter& rhs) const;
};
}

#endif
