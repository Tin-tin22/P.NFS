#ifndef STARTRESUMEPDU_H
#define STARTRESUMEPDU_H

#include <DIS/ClockTime.h>
#include <DIS/ClockTime.h>
#include <DIS/SimulationManagementFamilyPdu.h>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.2.6.3. Start or resume an exercise. COMPLETE

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO StartResumePdu : public SimulationManagementFamilyPdu
{
protected:
  // UTC time at which the simulation shall start or resume
  ClockTime _realWorldTime; 

  // Simulation clock time at which the simulation shall start or resume
  ClockTime _simulationTime; 

  // Identifier for the request
  unsigned int _requestID; 


 public:
    StartResumePdu();
    virtual ~StartResumePdu();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    ClockTime& getRealWorldTime(); 
    const ClockTime&  getRealWorldTime() const; 
    void setRealWorldTime(const ClockTime    &pX);

    ClockTime& getSimulationTime(); 
    const ClockTime&  getSimulationTime() const; 
    void setSimulationTime(const ClockTime    &pX);

    unsigned int getRequestID() const; 
    void setRequestID(unsigned int pX); 


virtual int getMarshalledSize() const;

     bool operator  ==(const StartResumePdu& rhs) const;
};
}

#endif
