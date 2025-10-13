#ifndef STOPFREEZERELIABLEPDU_H
#define STOPFREEZERELIABLEPDU_H

#include <DIS/ClockTime.h>
#include <DIS/SimulationManagementWithReliabilityFamilyPdu.h>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.3.12.4: Stop freeze simulation, relaible. COMPLETE

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO StopFreezeReliablePdu : public SimulationManagementWithReliabilityFamilyPdu
{
protected:
  // time in real world for this operation to happen
  ClockTime _realWorldTime; 

  // Reason for stopping/freezing simulation
  unsigned char _reason; 

  // internal behvior of the simulation while frozen
  unsigned char _frozenBehavior; 

  // reliablity level
  unsigned char _requiredReliablityService; 

  // padding
  unsigned char _pad1; 

  // Request ID
  unsigned int _requestID; 


 public:
    StopFreezeReliablePdu();
    virtual ~StopFreezeReliablePdu();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    ClockTime& getRealWorldTime(); 
    const ClockTime&  getRealWorldTime() const; 
    void setRealWorldTime(const ClockTime    &pX);

    unsigned char getReason() const; 
    void setReason(unsigned char pX); 

    unsigned char getFrozenBehavior() const; 
    void setFrozenBehavior(unsigned char pX); 

    unsigned char getRequiredReliablityService() const; 
    void setRequiredReliablityService(unsigned char pX); 

    unsigned char getPad1() const; 
    void setPad1(unsigned char pX); 

    unsigned int getRequestID() const; 
    void setRequestID(unsigned int pX); 


virtual int getMarshalledSize() const;

     bool operator  ==(const StopFreezeReliablePdu& rhs) const;
};
}

#endif
