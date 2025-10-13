#ifndef SYSTEMID_H
#define SYSTEMID_H

#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// 5.2.58. Used in IFF ATC PDU

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO SystemID
{
protected:
  // System Type
  unsigned short _systemType; 

  // System name, an enumeration
  unsigned short _systemName; 

  // System mode
  unsigned char _systemMode; 

  // Change Options
  unsigned char _changeOptions; 


 public:
    SystemID();
    virtual ~SystemID();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    unsigned short getSystemType() const; 
    void setSystemType(unsigned short pX); 

    unsigned short getSystemName() const; 
    void setSystemName(unsigned short pX); 

    unsigned char getSystemMode() const; 
    void setSystemMode(unsigned char pX); 

    unsigned char getChangeOptions() const; 
    void setChangeOptions(unsigned char pX); 


virtual int getMarshalledSize() const;

     bool operator  ==(const SystemID& rhs) const;
};
}

#endif
