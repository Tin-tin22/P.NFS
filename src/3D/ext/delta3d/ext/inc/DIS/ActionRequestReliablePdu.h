#ifndef ACTIONREQUESTRELIABLEPDU_H
#define ACTIONREQUESTRELIABLEPDU_H

#include <DIS/FixedDatum.h>
#include <DIS/VariableDatum.h>
#include <vector>
#include <DIS/SimulationManagementWithReliabilityFamilyPdu.h>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.3.12.6: request from a simulation manager to a managed entity to perform a specified action. COMPLETE

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO ActionRequestReliablePdu : public SimulationManagementWithReliabilityFamilyPdu
{
protected:
  // level of reliability service used for this transaction
  unsigned char _requiredReliabilityService; 

  // padding
  unsigned short _pad1; 

  // padding
  unsigned char _pad2; 

  // request ID
  unsigned int _requestID; 

  // request ID
  unsigned int _actionID; 

  // Fixed datum record count
  unsigned int _numberOfFixedDatumRecords; 

  // variable datum record count
  unsigned int _numberOfVariableDatumRecords; 

  // Fixed datum records
  std::vector<FixedDatum> _fixedDatumRecords; 

  // Variable datum records
  std::vector<VariableDatum> _variableDatumRecords; 


 public:
    ActionRequestReliablePdu();
    virtual ~ActionRequestReliablePdu();

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

    unsigned int getActionID() const; 
    void setActionID(unsigned int pX); 

    unsigned int getNumberOfFixedDatumRecords() const; 

    unsigned int getNumberOfVariableDatumRecords() const; 

    std::vector<FixedDatum>& getFixedDatumRecords(); 
    const std::vector<FixedDatum>& getFixedDatumRecords() const; 
    void setFixedDatumRecords(const std::vector<FixedDatum>&    pX);

    std::vector<VariableDatum>& getVariableDatumRecords(); 
    const std::vector<VariableDatum>& getVariableDatumRecords() const; 
    void setVariableDatumRecords(const std::vector<VariableDatum>&    pX);


virtual int getMarshalledSize() const;

     bool operator  ==(const ActionRequestReliablePdu& rhs) const;
};
}

#endif
