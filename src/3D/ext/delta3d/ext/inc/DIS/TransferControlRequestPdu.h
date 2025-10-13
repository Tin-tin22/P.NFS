#ifndef TRANSFERCONTROLREQUESTPDU_H
#define TRANSFERCONTROLREQUESTPDU_H

#include <DIS/EntityID.h>
#include <DIS/EntityID.h>
#include <DIS/EntityID.h>
#include <DIS/RecordSet.h>
#include <vector>
#include <DIS/EntityManagementFamilyPdu.h>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.3.9.3 Information initiating the dyanic allocation and control of simulation entities         between two simulation applications. Requires manual cleanup. The padding between record sets is variable. UNFINISHED

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO TransferControlRequestPdu : public EntityManagementFamilyPdu
{
protected:
  // ID of entity originating request
  EntityID _orginatingEntityID; 

  // ID of entity receiving request
  EntityID _recevingEntityID; 

  // ID ofrequest
  unsigned int _requestID; 

  // required level of reliabliity service.
  unsigned char _requiredReliabilityService; 

  // type of transfer desired
  unsigned char _tranferType; 

  // The entity for which control is being requested to transfer
  EntityID _transferEntityID; 

  // number of record sets to transfer
  unsigned char _numberOfRecordSets; 

  // @@@This is wrong--the RecordSet class needs more work
  std::vector<RecordSet> _recordSets; 


 public:
    TransferControlRequestPdu();
    virtual ~TransferControlRequestPdu();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    EntityID& getOrginatingEntityID(); 
    const EntityID&  getOrginatingEntityID() const; 
    void setOrginatingEntityID(const EntityID    &pX);

    EntityID& getRecevingEntityID(); 
    const EntityID&  getRecevingEntityID() const; 
    void setRecevingEntityID(const EntityID    &pX);

    unsigned int getRequestID() const; 
    void setRequestID(unsigned int pX); 

    unsigned char getRequiredReliabilityService() const; 
    void setRequiredReliabilityService(unsigned char pX); 

    unsigned char getTranferType() const; 
    void setTranferType(unsigned char pX); 

    EntityID& getTransferEntityID(); 
    const EntityID&  getTransferEntityID() const; 
    void setTransferEntityID(const EntityID    &pX);

    unsigned char getNumberOfRecordSets() const; 

    std::vector<RecordSet>& getRecordSets(); 
    const std::vector<RecordSet>& getRecordSets() const; 
    void setRecordSets(const std::vector<RecordSet>&    pX);


virtual int getMarshalledSize() const;

     bool operator  ==(const TransferControlRequestPdu& rhs) const;
};
}

#endif
