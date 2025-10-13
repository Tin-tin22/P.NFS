#ifndef RECORDQUERYRELIABLEPDU_H
#define RECORDQUERYRELIABLEPDU_H

#include <DIS/FourByteChunk.h>
#include <vector>
#include <DIS/SimulationManagementWithReliabilityFamilyPdu.h>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.3.12.13: A request for one or more records of data from an entity. COMPLETE

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO RecordQueryReliablePdu : public SimulationManagementWithReliabilityFamilyPdu
{
protected:
  // request ID
  unsigned int _requestID; 

  // level of reliability service used for this transaction
  unsigned char _requiredReliabilityService; 

  // padding. The spec is unclear and contradictory here.
  unsigned short _pad1; 

  // padding
  unsigned char _pad2; 

  // event type
  unsigned short _eventType; 

  // time
  unsigned int _time; 

  // numberOfRecords
  unsigned int _numberOfRecords; 

  // record IDs
  std::vector<FourByteChunk> _recordIDs; 


 public:
    RecordQueryReliablePdu();
    virtual ~RecordQueryReliablePdu();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    unsigned int getRequestID() const; 
    void setRequestID(unsigned int pX); 

    unsigned char getRequiredReliabilityService() const; 
    void setRequiredReliabilityService(unsigned char pX); 

    unsigned short getPad1() const; 
    void setPad1(unsigned short pX); 

    unsigned char getPad2() const; 
    void setPad2(unsigned char pX); 

    unsigned short getEventType() const; 
    void setEventType(unsigned short pX); 

    unsigned int getTime() const; 
    void setTime(unsigned int pX); 

    unsigned int getNumberOfRecords() const; 

    std::vector<FourByteChunk>& getRecordIDs(); 
    const std::vector<FourByteChunk>& getRecordIDs() const; 
    void setRecordIDs(const std::vector<FourByteChunk>&    pX);


virtual int getMarshalledSize() const;

     bool operator  ==(const RecordQueryReliablePdu& rhs) const;
};
}

#endif
