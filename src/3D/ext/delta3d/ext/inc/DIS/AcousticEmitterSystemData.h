#ifndef ACOUSTICEMITTERSYSTEMDATA_H
#define ACOUSTICEMITTERSYSTEMDATA_H

#include <DIS/AcousticEmitterSystem.h>
#include <DIS/Vector3Float.h>
#include <DIS/AcousticBeamData.h>
#include <vector>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Used in the UA pdu; ties together an emmitter and a location. This requires manual cleanup; the beam data should not be attached to each emitter system.

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO AcousticEmitterSystemData
{
protected:
  // Length of emitter system data
  unsigned char _emitterSystemDataLength; 

  // Number of beams
  unsigned char _numberOfBeams; 

  // padding
  unsigned short _pad2; 

  // This field shall specify the system for a particular UA emitter.
  AcousticEmitterSystem _acousticEmitterSystem; 

  // Represents the location wrt the entity
  Vector3Float _emitterLocation; 

  // For each beam in numberOfBeams, an emitter system. This is not right--the beam records need to be at the end of the PDU, rather than attached to each system.
  std::vector<AcousticBeamData> _beamRecords; 


 public:
    AcousticEmitterSystemData();
    virtual ~AcousticEmitterSystemData();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    unsigned char getEmitterSystemDataLength() const; 
    void setEmitterSystemDataLength(unsigned char pX); 

    unsigned char getNumberOfBeams() const; 

    unsigned short getPad2() const; 
    void setPad2(unsigned short pX); 

    AcousticEmitterSystem& getAcousticEmitterSystem(); 
    const AcousticEmitterSystem&  getAcousticEmitterSystem() const; 
    void setAcousticEmitterSystem(const AcousticEmitterSystem    &pX);

    Vector3Float& getEmitterLocation(); 
    const Vector3Float&  getEmitterLocation() const; 
    void setEmitterLocation(const Vector3Float    &pX);

    std::vector<AcousticBeamData>& getBeamRecords(); 
    const std::vector<AcousticBeamData>& getBeamRecords() const; 
    void setBeamRecords(const std::vector<AcousticBeamData>&    pX);


virtual int getMarshalledSize() const;

     bool operator  ==(const AcousticEmitterSystemData& rhs) const;
};
}

#endif
