#ifndef EVENTREPORTRELIABLEPDU_H
#define EVENTREPORTRELIABLEPDU_H

#include <DIS/FixedDatum.h>
#include <DIS/VariableDatum.h>
#include <vector>
#include <DIS/SimulationManagementWithReliabilityFamilyPdu.h>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.3.12.11: reports the occurance of a significatnt event to the simulation manager. Needs manual     intervention to fix padding in variable datums. UNFINISHED.

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO EventReportReliablePdu : public SimulationManagementWithReliabilityFamilyPdu
{
protected:
  // Event type
  unsigned short _eventType; 

  // padding
  unsigned int _pad1; 

  // Fixed datum record count
  unsigned int _numberOfFixedDatumRecords; 

  // variable datum record count
  unsigned int _numberOfVariableDatumRecords; 

  // Fixed datum records
  std::vector<FixedDatum> _fixedDatumRecords; 

  // Variable datum records
  std::vector<VariableDatum> _variableDatumRecords; 


 public:
    EventReportReliablePdu();
    virtual ~EventReportReliablePdu();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    unsigned short getEventType() const; 
    void setEventType(unsigned short pX); 

    unsigned int getPad1() const; 
    void setPad1(unsigned int pX); 

    unsigned int getNumberOfFixedDatumRecords() const; 

    unsigned int getNumberOfVariableDatumRecords() const; 

    std::vector<FixedDatum>& getFixedDatumRecords(); 
    const std::vector<FixedDatum>& getFixedDatumRecords() const; 
    void setFixedDatumRecords(const std::vector<FixedDatum>&    pX);

    std::vector<VariableDatum>& getVariableDatumRecords(); 
    const std::vector<VariableDatum>& getVariableDatumRecords() const; 
    void setVariableDatumRecords(const std::vector<VariableDatum>&    pX);


virtual int getMarshalledSize() const;

     bool operator  ==(const EventReportReliablePdu& rhs) const;
};
}

#endif
