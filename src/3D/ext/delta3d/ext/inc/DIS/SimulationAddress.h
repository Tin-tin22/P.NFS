#ifndef SIMULATIONADDRESS_H
#define SIMULATIONADDRESS_H

#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.2.14.1. A Simulation Address  record shall consist of the Site Identification number and the Application Identification number.

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO SimulationAddress
{
protected:
  // The site ID
  unsigned short _site; 

  // The application ID
  unsigned short _application; 


 public:
    SimulationAddress();
    virtual ~SimulationAddress();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    unsigned short getSite() const; 
    void setSite(unsigned short pX); 

    unsigned short getApplication() const; 
    void setApplication(unsigned short pX); 


virtual int getMarshalledSize() const;

     bool operator  ==(const SimulationAddress& rhs) const;
};
}

#endif
