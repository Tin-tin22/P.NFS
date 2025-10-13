#ifndef SIGNALPDU_H
#define SIGNALPDU_H

#include <DIS/RadioCommunicationsFamilyPdu.h>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.3.8.2. Detailed information about a radio transmitter. This PDU requires        manually written code to complete. The encodingScheme field can be used in multiple        ways, which requires hand-written code to finish. UNFINISHED

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO SignalPdu : public RadioCommunicationsFamilyPdu
{
protected:
  // encoding scheme used, and enumeration
  unsigned short _encodingScheme; 

  // tdl type
  unsigned short _tdlType; 

  // sample rate
  int _sampleRate; 

  // length od data
  short _dataLength; 

  // number of samples
  short _samples; 


 public:
    SignalPdu();
    virtual ~SignalPdu();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    unsigned short getEncodingScheme() const; 
    void setEncodingScheme(unsigned short pX); 

    unsigned short getTdlType() const; 
    void setTdlType(unsigned short pX); 

    int getSampleRate() const; 
    void setSampleRate(int pX); 

    short getDataLength() const; 
    void setDataLength(short pX); 

    short getSamples() const; 
    void setSamples(short pX); 


virtual int getMarshalledSize() const;

     bool operator  ==(const SignalPdu& rhs) const;
};
}

#endif
