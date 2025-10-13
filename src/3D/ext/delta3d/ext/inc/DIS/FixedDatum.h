#ifndef FIXEDDATUM_H
#define FIXEDDATUM_H

#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.2.18. Fixed Datum Record

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO FixedDatum
{
protected:
  // ID of the fixed datum
  unsigned int _fixedDatumID; 

  // Value for the fixed datum
  unsigned int _fixedDatumValue; 


 public:
    FixedDatum();
    virtual ~FixedDatum();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    unsigned int getFixedDatumID() const; 
    void setFixedDatumID(unsigned int pX); 

    unsigned int getFixedDatumValue() const; 
    void setFixedDatumValue(unsigned int pX); 


virtual int getMarshalledSize() const;

     bool operator  ==(const FixedDatum& rhs) const;
};
}

#endif
