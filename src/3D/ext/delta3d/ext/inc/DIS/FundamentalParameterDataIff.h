#ifndef FUNDAMENTALPARAMETERDATAIFF_H
#define FUNDAMENTALPARAMETERDATAIFF_H

#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// 5.2.45. Fundamental IFF atc data

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO FundamentalParameterDataIff
{
protected:
  // ERP
  float _erp; 

  // frequency
  float _frequency; 

  // pgrf
  float _pgrf; 

  // Pulse width
  float _pulseWidth; 

  // Burst length
  unsigned int _burstLength; 

  // Applicable modes enumeration
  unsigned char _applicableModes; 

  // padding
  unsigned short _pad2; 

  // padding
  unsigned char _pad3; 


 public:
    FundamentalParameterDataIff();
    virtual ~FundamentalParameterDataIff();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    float getErp() const; 
    void setErp(float pX); 

    float getFrequency() const; 
    void setFrequency(float pX); 

    float getPgrf() const; 
    void setPgrf(float pX); 

    float getPulseWidth() const; 
    void setPulseWidth(float pX); 

    unsigned int getBurstLength() const; 
    void setBurstLength(unsigned int pX); 

    unsigned char getApplicableModes() const; 
    void setApplicableModes(unsigned char pX); 

    unsigned short getPad2() const; 
    void setPad2(unsigned short pX); 

    unsigned char getPad3() const; 
    void setPad3(unsigned char pX); 


virtual int getMarshalledSize() const;

     bool operator  ==(const FundamentalParameterDataIff& rhs) const;
};
}

#endif
