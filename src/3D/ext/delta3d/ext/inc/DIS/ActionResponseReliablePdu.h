#ifndef ACTIONRESPONSERELIABLEPDU_H
#define ACTIONRESPONSERELIABLEPDU_H

#include <DIS/FixedDatum.h>
#include <DIS/VariableDatum.h>
#include <vector>
#include <DIS/SimulationManagementWithReliabilityFamilyPdu.h>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.3.12.7: Response from an entity to an action request PDU. COMPLETE

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO ActionResponseReliablePdu : public SimulationManagementWithReliabilityFamilyPdu
{
protected:
  // request ID
  unsigned int _requestID; 

  // status of response
  unsigned int _responseStatus; 

  // Fixed datum record count
  unsigned int _numberOfFixedDatumRecords; 

  // variable datum record count
  unsigned int _numberOfVariableDatumRecords; 

  // Fixed datum records
  std::vector<FixedDatum> _fixedDatumRecords; 

  // Variable datum records
  std::vector<VariableDatum> _variableDatumRecords; 


 public:
    ActionResponseReliablePdu();
    virtual ~ActionResponseReliablePdu();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    unsigned int getRequestID() const; 
    void setRequestID(unsigned int pX); 

    unsigned int getResponseStatus() const; 
    void setResponseStatus(unsigned int pX); 

    unsigned int getNumberOfFixedDatumRecords() const; 

    unsigned int getNumberOfVariableDatumRecords() const; 

    std::vector<FixedDatum>& getFixedDatumRecords(); 
    const std::vector<FixedDatum>& getFixedDatumRecords() const; 
    void setFixedDatumRecords(const std::vector<FixedDatum>&    pX);

    std::vector<VariableDatum>& getVariableDatumRecords(); 
    const std::vector<VariableDatum>& getVariableDatumRecords() const; 
    void setVariableDatumRecords(const std::vector<VariableDatum>&    pX);


virtual int getMarshalledSize() const;

     bool operator  ==(const ActionResponseReliablePdu& rhs) const;
};
}

#endif
