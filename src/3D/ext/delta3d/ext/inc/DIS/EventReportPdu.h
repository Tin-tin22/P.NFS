#ifndef EVENTREPORTPDU_H
#define EVENTREPORTPDU_H

#include <DIS/FixedDatum.h>
#include <DIS/VariableDatum.h>
#include <vector>
#include <DIS/SimulationManagementFamilyPdu.h>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.3.6.11. Reports occurance of a significant event to the simulation manager. COMPLETE

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO EventReportPdu : public SimulationManagementFamilyPdu
{
protected:
  // Type of event
  unsigned int _eventType; 

  // padding
  unsigned int _padding1; 

  // Number of fixed datum records
  unsigned int _numberOfFixedDatumRecords; 

  // Number of variable datum records
  unsigned int _numberOfVariableDatumRecords; 

  // variable length list of fixed datums
  std::vector<FixedDatum> _fixedDatums; 

  // variable length list of variable length datums
  std::vector<VariableDatum> _variableDatums; 


 public:
    EventReportPdu();
    virtual ~EventReportPdu();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    unsigned int getEventType() const; 
    void setEventType(unsigned int pX); 

    unsigned int getPadding1() const; 
    void setPadding1(unsigned int pX); 

    unsigned int getNumberOfFixedDatumRecords() const; 

    unsigned int getNumberOfVariableDatumRecords() const; 

    std::vector<FixedDatum>& getFixedDatums(); 
    const std::vector<FixedDatum>& getFixedDatums() const; 
    void setFixedDatums(const std::vector<FixedDatum>&    pX);

    std::vector<VariableDatum>& getVariableDatums(); 
    const std::vector<VariableDatum>& getVariableDatums() const; 
    void setVariableDatums(const std::vector<VariableDatum>&    pX);


virtual int getMarshalledSize() const;

     bool operator  ==(const EventReportPdu& rhs) const;
};
}

#endif
