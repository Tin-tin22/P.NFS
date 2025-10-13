#ifndef GRIDAXISRECORD_H
#define GRIDAXISRECORD_H

#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// 5.2.44: Grid data record, a common abstract superclass for several subtypes 

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO GridAxisRecord
{
protected:
  // type of environmental sample
  unsigned short _sampleType; 

  // value that describes data representation
  unsigned short _dataRepresentation; 


 public:
    GridAxisRecord();
    virtual ~GridAxisRecord();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    unsigned short getSampleType() const; 
    void setSampleType(unsigned short pX); 

    unsigned short getDataRepresentation() const; 
    void setDataRepresentation(unsigned short pX); 


virtual int getMarshalledSize() const;

     bool operator  ==(const GridAxisRecord& rhs) const;
};
}

#endif
