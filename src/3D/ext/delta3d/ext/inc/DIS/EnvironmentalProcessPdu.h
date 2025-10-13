#ifndef ENVIRONMENTALPROCESSPDU_H
#define ENVIRONMENTALPROCESSPDU_H

#include <DIS/EntityID.h>
#include <DIS/EntityType.h>
#include <DIS/Environment.h>
#include <vector>
#include <DIS/SyntheticEnvironmentFamilyPdu.h>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.3.11.1: Information about environmental effects and processes. This requires manual cleanup. the environmental        record is variable, as is the padding. UNFINISHED

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO EnvironmentalProcessPdu : public SyntheticEnvironmentFamilyPdu
{
protected:
  // Environmental process ID
  EntityID _environementalProcessID; 

  // Environment type
  EntityType _environmentType; 

  // model type
  unsigned char _modelType; 

  // Environment status
  unsigned char _environmentStatus; 

  // number of environment records 
  unsigned char _numberOfEnvironmentRecords; 

  // PDU sequence number for the environmentla process if pdu sequencing required
  unsigned short _sequenceNumber; 

  // environemt records
  std::vector<Environment> _environmentRecords; 


 public:
    EnvironmentalProcessPdu();
    virtual ~EnvironmentalProcessPdu();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    EntityID& getEnvironementalProcessID(); 
    const EntityID&  getEnvironementalProcessID() const; 
    void setEnvironementalProcessID(const EntityID    &pX);

    EntityType& getEnvironmentType(); 
    const EntityType&  getEnvironmentType() const; 
    void setEnvironmentType(const EntityType    &pX);

    unsigned char getModelType() const; 
    void setModelType(unsigned char pX); 

    unsigned char getEnvironmentStatus() const; 
    void setEnvironmentStatus(unsigned char pX); 

    unsigned char getNumberOfEnvironmentRecords() const; 

    unsigned short getSequenceNumber() const; 
    void setSequenceNumber(unsigned short pX); 

    std::vector<Environment>& getEnvironmentRecords(); 
    const std::vector<Environment>& getEnvironmentRecords() const; 
    void setEnvironmentRecords(const std::vector<Environment>&    pX);


virtual int getMarshalledSize() const;

     bool operator  ==(const EnvironmentalProcessPdu& rhs) const;
};
}

#endif
