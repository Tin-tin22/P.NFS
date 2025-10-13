#ifndef PDU_H
#define PDU_H

#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// The superclass for all PDUs. This incorporates the PduHeader record, section 5.2.29.

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO Pdu
{
protected:
  // The version of the protocol. 5=DIS-1995, 6=DIS-1998.
  unsigned char _protocolVersion; 

  // Exercise ID
  unsigned char _exerciseID; 

  // Type of pdu, unique for each PDU class
  unsigned char _pduType; 

  // value that refers to the protocol family, eg SimulationManagement, et
  unsigned char _protocolFamily; 

  // Timestamp value
  unsigned int _timestamp; 

  // Length, in bytes, of the PDU
  unsigned short _length; 

  // zero-filled array of padding
  short _padding; 


 public:
    Pdu();
    virtual ~Pdu();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    unsigned char getProtocolVersion() const; 
    void setProtocolVersion(unsigned char pX); 

    unsigned char getExerciseID() const; 
    void setExerciseID(unsigned char pX); 

    unsigned char getPduType() const; 
    void setPduType(unsigned char pX); 

    unsigned char getProtocolFamily() const; 
    void setProtocolFamily(unsigned char pX); 

    unsigned int getTimestamp() const; 
    void setTimestamp(unsigned int pX); 

    unsigned short getLength() const; 
    void setLength(unsigned short pX); 

    short getPadding() const; 
    void setPadding(short pX); 


virtual int getMarshalledSize() const;

     bool operator  ==(const Pdu& rhs) const;
};
}

#endif
