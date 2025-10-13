#ifndef ACKNOWLEDGERELIABLEPDU_H
#define ACKNOWLEDGERELIABLEPDU_H

#include <DIS/SimulationManagementWithReliabilityFamilyPdu.h>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.3.12.5: Ack receipt of a start-resume, stop-freeze, create-entity or remove enitty (reliable) pdus. COMPLETE

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO AcknowledgeReliablePdu : public SimulationManagementWithReliabilityFamilyPdu
{
protected:
  // ack flags
  unsigned short _acknowledgeFlag; 

  // response flags
  unsigned short _responseFlag; 

  // Request ID
  unsigned int _requestID; 


 public:
    AcknowledgeReliablePdu();
    virtual ~AcknowledgeReliablePdu();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    unsigned short getAcknowledgeFlag() const; 
    void setAcknowledgeFlag(unsigned short pX); 

    unsigned short getResponseFlag() const; 
    void setResponseFlag(unsigned short pX); 

    unsigned int getRequestID() const; 
    void setRequestID(unsigned int pX); 


virtual int getMarshalledSize() const;

     bool operator  ==(const AcknowledgeReliablePdu& rhs) const;
};
}

#endif
