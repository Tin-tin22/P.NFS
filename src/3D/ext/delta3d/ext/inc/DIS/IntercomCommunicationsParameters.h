#ifndef INTERCOMCOMMUNICATIONSPARAMETERS_H
#define INTERCOMCOMMUNICATIONSPARAMETERS_H

#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// 5.2.46.  Intercom communcations parameters

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO IntercomCommunicationsParameters
{
protected:
  // Type of intercom parameters record
  unsigned short _recordType; 

  // length of record
  unsigned short _recordLength; 

  // Jerks. Looks like the committee is forcing a lookup of the record type parameter to find out how long the field is. This is a placeholder.
  unsigned int _recordSpecificField; 


 public:
    IntercomCommunicationsParameters();
    virtual ~IntercomCommunicationsParameters();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    unsigned short getRecordType() const; 
    void setRecordType(unsigned short pX); 

    unsigned short getRecordLength() const; 
    void setRecordLength(unsigned short pX); 

    unsigned int getRecordSpecificField() const; 
    void setRecordSpecificField(unsigned int pX); 


virtual int getMarshalledSize() const;

     bool operator  ==(const IntercomCommunicationsParameters& rhs) const;
};
}

#endif
