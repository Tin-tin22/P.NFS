#ifndef ACKNOWLEDGEPDU_H
#define ACKNOWLEDGEPDU_H

#include <DIS/SimulationManagementFamilyPdu.h>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.3.6.5. Acknowledge the receiptof a start/resume, stop/freeze, or RemoveEntityPDU. COMPLETE

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO AcknowledgePdu : public SimulationManagementFamilyPdu
{
protected:
  // type of message being acknowledged
  unsigned short _acknowledgeFlag; 

  // Whether or not the receiving entity was able to comply with the request
  unsigned short _responseFlag; 

  // Request ID that is unique
  unsigned int _requestID; 


 public:
    AcknowledgePdu();
    virtual ~AcknowledgePdu();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    unsigned short getAcknowledgeFlag() const; 
    void setAcknowledgeFlag(unsigned short pX); 

    unsigned short getResponseFlag() const; 
    void setResponseFlag(unsigned short pX); 

    unsigned int getRequestID() const; 
    void setRequestID(unsigned int pX); 


virtual int getMarshalledSize() const;

     bool operator  ==(const AcknowledgePdu& rhs) const;
};
}

#endif
