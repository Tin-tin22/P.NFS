#ifndef IFFFUNDAMENTALDATA_H
#define IFFFUNDAMENTALDATA_H

#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// 5.2.42. Basic operational data ofr IFF ATC NAVAIDS

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO IffFundamentalData
{
protected:
  // system status
  unsigned char _systemStatus; 

  // Alternate parameter 4
  unsigned char _alternateParameter4; 

  // eight boolean fields
  unsigned char _informationLayers; 

  // enumeration
  unsigned char _modifier; 

  // parameter, enumeration
  unsigned short _parameter1; 

  // parameter, enumeration
  unsigned short _parameter2; 

  // parameter, enumeration
  unsigned short _parameter3; 

  // parameter, enumeration
  unsigned short _parameter4; 

  // parameter, enumeration
  unsigned short _parameter5; 

  // parameter, enumeration
  unsigned short _parameter6; 


 public:
    IffFundamentalData();
    virtual ~IffFundamentalData();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    unsigned char getSystemStatus() const; 
    void setSystemStatus(unsigned char pX); 

    unsigned char getAlternateParameter4() const; 
    void setAlternateParameter4(unsigned char pX); 

    unsigned char getInformationLayers() const; 
    void setInformationLayers(unsigned char pX); 

    unsigned char getModifier() const; 
    void setModifier(unsigned char pX); 

    unsigned short getParameter1() const; 
    void setParameter1(unsigned short pX); 

    unsigned short getParameter2() const; 
    void setParameter2(unsigned short pX); 

    unsigned short getParameter3() const; 
    void setParameter3(unsigned short pX); 

    unsigned short getParameter4() const; 
    void setParameter4(unsigned short pX); 

    unsigned short getParameter5() const; 
    void setParameter5(unsigned short pX); 

    unsigned short getParameter6() const; 
    void setParameter6(unsigned short pX); 


virtual int getMarshalledSize() const;

     bool operator  ==(const IffFundamentalData& rhs) const;
};
}

#endif
