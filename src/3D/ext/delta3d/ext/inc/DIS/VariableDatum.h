#ifndef VARIABLEDATUM_H
#define VARIABLEDATUM_H

#include <DIS/EightByteChunk.h>
#include <vector>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.2.32. Variable Datum Record

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO VariableDatum
{
protected:
  // ID of the variable datum
  unsigned int _variableDatumID; 

  // length of the variable datums
  unsigned int _variableDatumLength; 

  // variable length list of 64-bit datums
  std::vector<EightByteChunk> _variableDatums; 


 public:
    VariableDatum();
    virtual ~VariableDatum();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    unsigned int getVariableDatumID() const; 
    void setVariableDatumID(unsigned int pX); 

    unsigned int getVariableDatumLength() const; 

    std::vector<EightByteChunk>& getVariableDatums(); 
    const std::vector<EightByteChunk>& getVariableDatums() const; 
    void setVariableDatums(const std::vector<EightByteChunk>&    pX);


virtual int getMarshalledSize() const;

     bool operator  ==(const VariableDatum& rhs) const;
};
}

#endif
