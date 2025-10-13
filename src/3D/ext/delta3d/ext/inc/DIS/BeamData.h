#ifndef BEAMDATA_H
#define BEAMDATA_H

#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.2.39. Specification of the data necessary to  describe the scan volume of an emitter.

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO BeamData
{
protected:
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
    BeamData();
    virtual ~BeamData();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

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

     bool operator  ==(const BeamData& rhs) const;
};
}

#endif
