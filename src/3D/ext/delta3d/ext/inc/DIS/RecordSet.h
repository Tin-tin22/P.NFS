#ifndef RECORDSET_H
#define RECORDSET_H

#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Record sets, used in transfer control request PDU

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO RecordSet
{
protected:
  // record ID
  unsigned int _recordID; 

  // record set serial number
  unsigned int _recordSetSerialNumber; 

  // record length
  unsigned short _recordLength; 

  // record count
  unsigned short _recordCount; 

  // @@@This is wrong--variable sized data records
  unsigned short _recordValues; 

  // @@@This is wrong--variable sized padding
  unsigned char _pad4; 


 public:
    RecordSet();
    virtual ~RecordSet();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    unsigned int getRecordID() const; 
    void setRecordID(unsigned int pX); 

    unsigned int getRecordSetSerialNumber() const; 
    void setRecordSetSerialNumber(unsigned int pX); 

    unsigned short getRecordLength() const; 
    void setRecordLength(unsigned short pX); 

    unsigned short getRecordCount() const; 
    void setRecordCount(unsigned short pX); 

    unsigned short getRecordValues() const; 
    void setRecordValues(unsigned short pX); 

    unsigned char getPad4() const; 
    void setPad4(unsigned char pX); 


virtual int getMarshalledSize() const;

     bool operator  ==(const RecordSet& rhs) const;
};
}

#endif
