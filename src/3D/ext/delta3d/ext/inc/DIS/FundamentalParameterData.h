#ifndef FUNDAMENTALPARAMETERDATA_H
#define FUNDAMENTALPARAMETERDATA_H

#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.2.22. Contains electromagnetic emmision regineratin parameters that are        variable throughout a scenario dependent on the actions of the participants in the simulation. Also provides basic parametric data that may be used to support low-fidelity simulations.

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO FundamentalParameterData
{
protected:
  // center frequency of the emission in hertz.
  float _frequency; 

  // Bandwidth of the frequencies corresponding to the fequency field.
  float _frequencyRange; 

  // Effective radiated power for the emission in DdBm. For a      radar noise jammer, indicates the peak of the transmitted power.
  float _effectiveRadiatedPower; 

  // Average repetition frequency of the emission in hertz.
  float _pulseRepetitionFrequency; 

  // Average pulse width  of the emission in microseconds.
  float _pulseWidth; 

  // Specifies the beam azimuth an elevation centers and corresponding half-angles     to describe the scan volume
  float _beamAzimuthCenter; 

  // Specifies the beam azimuth sweep to determine scan volume
  float _beamAzimuthSweep; 

  // Specifies the beam elevation center to determine scan volume
  float _beamElevationCenter; 

  // Specifies the beam elevation sweep to determine scan volume
  float _beamElevationSweep; 

  // allows receiver to synchronize its regenerated scan pattern to     that of the emmitter. Specifies the percentage of time a scan is through its pattern from its origion.
  float _beamSweepSync; 


 public:
    FundamentalParameterData();
    virtual ~FundamentalParameterData();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    float getFrequency() const; 
    void setFrequency(float pX); 

    float getFrequencyRange() const; 
    void setFrequencyRange(float pX); 

    float getEffectiveRadiatedPower() const; 
    void setEffectiveRadiatedPower(float pX); 

    float getPulseRepetitionFrequency() const; 
    void setPulseRepetitionFrequency(float pX); 

    float getPulseWidth() const; 
    void setPulseWidth(float pX); 

    float getBeamAzimuthCenter() const; 
    void setBeamAzimuthCenter(float pX); 

    float getBeamAzimuthSweep() const; 
    void setBeamAzimuthSweep(float pX); 

    float getBeamElevationCenter() const; 
    void setBeamElevationCenter(float pX); 

    float getBeamElevationSweep() const; 
    void setBeamElevationSweep(float pX); 

    float getBeamSweepSync() const; 
    void setBeamSweepSync(float pX); 


virtual int getMarshalledSize() const;

     bool operator  ==(const FundamentalParameterData& rhs) const;
};
}

#endif
