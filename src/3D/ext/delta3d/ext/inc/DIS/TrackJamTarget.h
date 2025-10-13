#ifndef TRACKJAMTARGET_H
#define TRACKJAMTARGET_H

#include <DIS/EntityID.h>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// One track/jam target

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO TrackJamTarget
{
protected:
  // track/jam target
  EntityID _trackJam; 

  // Emitter ID
  unsigned char _emitterID; 

  // beam ID
  unsigned char _beamID; 


 public:
    TrackJamTarget();
    virtual ~TrackJamTarget();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    EntityID& getTrackJam(); 
    const EntityID&  getTrackJam() const; 
    void setTrackJam(const EntityID    &pX);

    unsigned char getEmitterID() const; 
    void setEmitterID(unsigned char pX); 

    unsigned char getBeamID() const; 
    void setBeamID(unsigned char pX); 


virtual int getMarshalledSize() const;

     bool operator  ==(const TrackJamTarget& rhs) const;
};
}

#endif
