#ifndef ACOUSTICBEAMDATA_H
#define ACOUSTICBEAMDATA_H

#include <DIS/AcousticBeamFundamentalParameter.h>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Used in UA PDU

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO AcousticBeamData
{
protected:
  // beam data length
  unsigned short _beamDataLength; 

  // beamIDNumber
  unsigned char _beamIDNumber; 

  // padding
  unsigned short _pad2; 

  // fundamental data parameters
  AcousticBeamFundamentalParameter _fundamentalDataParameters; 


 public:
    AcousticBeamData();
    virtual ~AcousticBeamData();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    unsigned short getBeamDataLength() const; 
    void setBeamDataLength(unsigned short pX); 

    unsigned char getBeamIDNumber() const; 
    void setBeamIDNumber(unsigned char pX); 

    unsigned short getPad2() const; 
    void setPad2(unsigned short pX); 

    AcousticBeamFundamentalParameter& getFundamentalDataParameters(); 
    const AcousticBeamFundamentalParameter&  getFundamentalDataParameters() const; 
    void setFundamentalDataParameters(const AcousticBeamFundamentalParameter    &pX);


virtual int getMarshalledSize() const;

     bool operator  ==(const AcousticBeamData& rhs) const;
};
}

#endif
