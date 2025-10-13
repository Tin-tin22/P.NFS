#ifndef ACOUSTICBEAMFUNDAMENTALPARAMETER_H
#define ACOUSTICBEAMFUNDAMENTALPARAMETER_H

#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Used in UaPdu

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO AcousticBeamFundamentalParameter
{
protected:
  // parameter index
  unsigned short _activeEmissionParameterIndex; 

  // scan pattern
  unsigned short _scanPattern; 

  // beam center azimuth
  float _beamCenterAzimuth; 

  // azimuthal beamwidth
  float _azimuthalBeamwidth; 

  // beam center
  float _beamCenterDE; 

  // DE beamwidth (vertical beamwidth)
  float _deBeamwidth; 


 public:
    AcousticBeamFundamentalParameter();
    virtual ~AcousticBeamFundamentalParameter();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    unsigned short getActiveEmissionParameterIndex() const; 
    void setActiveEmissionParameterIndex(unsigned short pX); 

    unsigned short getScanPattern() const; 
    void setScanPattern(unsigned short pX); 

    float getBeamCenterAzimuth() const; 
    void setBeamCenterAzimuth(float pX); 

    float getAzimuthalBeamwidth() const; 
    void setAzimuthalBeamwidth(float pX); 

    float getBeamCenterDE() const; 
    void setBeamCenterDE(float pX); 

    float getDeBeamwidth() const; 
    void setDeBeamwidth(float pX); 


virtual int getMarshalledSize() const;

     bool operator  ==(const AcousticBeamFundamentalParameter& rhs) const;
};
}

#endif
