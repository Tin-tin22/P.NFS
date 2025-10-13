#ifndef REMOVEENTITYRELIABLEPDU_H
#define REMOVEENTITYRELIABLEPDU_H

#include <DIS/SimulationManagementWithReliabilityFamilyPdu.h>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.3.12.2: Removal of an entity , reliable. COMPLETE

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO RemoveEntityReliablePdu : public SimulationManagementWithReliabilityFamilyPdu
{
protected:
  // level of reliability service used for this transaction
  unsigned char _requiredReliabilityService; 

  // padding
  unsigned short _pad1; 

  // padding
  unsigned char _pad2; 

  // Request ID
  unsigned int _requestID; 


 public:
    RemoveEntityReliablePdu();
    virtual ~RemoveEntityReliablePdu();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    unsigned char getRequiredReliabilityService() const; 
    void setRequiredReliabilityService(unsigned char pX); 

    unsigned short getPad1() const; 
    void setPad1(unsigned short pX); 

    unsigned char getPad2() const; 
    void setPad2(unsigned char pX); 

    unsigned int getRequestID() const; 
    void setRequestID(unsigned int pX); 


virtual int getMarshalledSize() const;

     bool operator  ==(const RemoveEntityReliablePdu& rhs) const;
};
}

#endif
