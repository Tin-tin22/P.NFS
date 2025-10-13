#ifndef STOPFREEZEPDU_H
#define STOPFREEZEPDU_H

#include <DIS/ClockTime.h>
#include <DIS/SimulationManagementFamilyPdu.h>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.2.3.4. Stop or freeze an exercise. COMPLETE

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO StopFreezePdu : public SimulationManagementFamilyPdu
{
protected:
  // UTC time at which the simulation shall stop or freeze
  ClockTime _realWorldTime; 

  // Reason the simulation was stopped or frozen
  unsigned char _reason; 

  // Internal behavior of the simulation and its appearance while frozento the other participants
  unsigned char _frozenBehavior; 

  // padding
  short _padding1; 

  // Request ID that is unique
  unsigned int _requestID; 


 public:
    StopFreezePdu();
    virtual ~StopFreezePdu();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    ClockTime& getRealWorldTime(); 
    const ClockTime&  getRealWorldTime() const; 
    void setRealWorldTime(const ClockTime    &pX);

    unsigned char getReason() const; 
    void setReason(unsigned char pX); 

    unsigned char getFrozenBehavior() const; 
    void setFrozenBehavior(unsigned char pX); 

    short getPadding1() const; 
    void setPadding1(short pX); 

    unsigned int getRequestID() const; 
    void setRequestID(unsigned int pX); 


virtual int getMarshalledSize() const;

     bool operator  ==(const StopFreezePdu& rhs) const;
};
}

#endif
