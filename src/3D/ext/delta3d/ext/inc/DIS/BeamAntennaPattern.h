#ifndef BEAMANTENNAPATTERN_H
#define BEAMANTENNAPATTERN_H

#include <DIS/Orientation.h>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.2.4.2. Used when the antenna pattern type field has a value of 1. Specifies           the direction, patter, and polarization of radiation from an antenna.

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO BeamAntennaPattern
{
protected:
  // The rotation that transformst he reference coordinate sytem     into the beam coordinate system. Either world coordinates or entity coordinates may be used as the     reference coordinate system, as specified by teh reference system field of the antenna pattern record.
  Orientation _beamDirection; 

  float _azimuthBeamwidth; 

  float _referenceSystem; 

  short _padding1; 

  char _padding2; 

  // Magnigute of the z-component in beam coordinates at some arbitrary      single point in the mainbeam      and in the far field of the antenna.
  float _ez; 

  // Magnigute of the x-component in beam coordinates at some arbitrary      single point in the mainbeam      and in the far field of the antenna.
  float _ex; 

  // THe phase angle between Ez and Ex in radians.
  float _phase; 


 public:
    BeamAntennaPattern();
    virtual ~BeamAntennaPattern();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    Orientation& getBeamDirection(); 
    const Orientation&  getBeamDirection() const; 
    void setBeamDirection(const Orientation    &pX);

    float getAzimuthBeamwidth() const; 
    void setAzimuthBeamwidth(float pX); 

    float getReferenceSystem() const; 
    void setReferenceSystem(float pX); 

    short getPadding1() const; 
    void setPadding1(short pX); 

    char getPadding2() const; 
    void setPadding2(char pX); 

    float getEz() const; 
    void setEz(float pX); 

    float getEx() const; 
    void setEx(float pX); 

    float getPhase() const; 
    void setPhase(float pX); 


virtual int getMarshalledSize() const;

     bool operator  ==(const BeamAntennaPattern& rhs) const;
};
}

#endif
