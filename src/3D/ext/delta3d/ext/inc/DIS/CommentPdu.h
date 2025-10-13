#ifndef COMMENTPDU_H
#define COMMENTPDU_H

#include <DIS/FixedDatum.h>
#include <DIS/VariableDatum.h>
#include <vector>
#include <DIS/SimulationManagementFamilyPdu.h>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.3.6.12. Arbitrary messages can be entered into the data stream via use of this PDU. COMPLETE

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO CommentPdu : public SimulationManagementFamilyPdu
{
protected:
  // Number of fixed datum records
  unsigned int _numberOfFixedDatumRecords; 

  // Number of variable datum records
  unsigned int _numberOfVariableDatumRecords; 

  // variable length list of fixed datums
  std::vector<FixedDatum> _fixedDatums; 

  // variable length list of variable length datums
  std::vector<VariableDatum> _variableDatums; 


 public:
    CommentPdu();
    virtual ~CommentPdu();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    unsigned int getNumberOfFixedDatumRecords() const; 

    unsigned int getNumberOfVariableDatumRecords() const; 

    std::vector<FixedDatum>& getFixedDatums(); 
    const std::vector<FixedDatum>& getFixedDatums() const; 
    void setFixedDatums(const std::vector<FixedDatum>&    pX);

    std::vector<VariableDatum>& getVariableDatums(); 
    const std::vector<VariableDatum>& getVariableDatums() const; 
    void setVariableDatums(const std::vector<VariableDatum>&    pX);


virtual int getMarshalledSize() const;

     bool operator  ==(const CommentPdu& rhs) const;
};
}

#endif
