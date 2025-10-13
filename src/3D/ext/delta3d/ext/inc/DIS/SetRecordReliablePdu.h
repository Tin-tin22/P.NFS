#ifndef SETRECORDRELIABLEPDU_H
#define SETRECORDRELIABLEPDU_H

#include <DIS/RecordSet.h>
#include <vector>
#include <DIS/SimulationManagementWithReliabilityFamilyPdu.h>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.3.12.14: Initializing or changing internal parameter info. Needs manual intervention     to fix padding in recrod set PDUs. UNFINISHED

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO SetRecordReliablePdu : public SimulationManagementWithReliabilityFamilyPdu
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

  // Number of record sets in list
  unsigned int _numberOfRecordSets; 

  // record sets
  std::vector<RecordSet> _recordSets; 


 public:
    SetRecordReliablePdu();
    virtual ~SetRecordReliablePdu();

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

    unsigned int getNumberOfRecordSets() const; 

    std::vector<RecordSet>& getRecordSets(); 
    const std::vector<RecordSet>& getRecordSets() const; 
    void setRecordSets(const std::vector<RecordSet>&    pX);


virtual int getMarshalledSize() const;

     bool operator  ==(const SetRecordReliablePdu& rhs) const;
};
}

#endif
