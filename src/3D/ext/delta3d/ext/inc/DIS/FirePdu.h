#ifndef FIREPDU_H
#define FIREPDU_H

#include <DIS/EntityID.h>
#include <DIS/EventID.h>
#include <DIS/Vector3Double.h>
#include <DIS/BurstDescriptor.h>
#include <DIS/Vector3Float.h>
#include <DIS/WarfareFamilyPdu.h>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Sectioin 5.3.4.1. Information about someone firing something. COMPLETE

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO FirePdu : public WarfareFamilyPdu
{
protected:
  // ID of the munition that is being shot
  EntityID _munitionID; 

  // ID of event
  EventID _eventID; 

  int _fireMissionIndex; 

  // location of the firing event
  Vector3Double _locationInWorldCoordinates; 

  // Describes munitions used in the firing event
  BurstDescriptor _burstDescriptor; 

  // Velocity of the ammunition
  Vector3Float _velocity; 

  // range to the target
  float _range; 


 public:
    FirePdu();
    virtual ~FirePdu();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    EntityID& getMunitionID(); 
    const EntityID&  getMunitionID() const; 
    void setMunitionID(const EntityID    &pX);

    EventID& getEventID(); 
    const EventID&  getEventID() const; 
    void setEventID(const EventID    &pX);

    int getFireMissionIndex() const; 
    void setFireMissionIndex(int pX); 

    Vector3Double& getLocationInWorldCoordinates(); 
    const Vector3Double&  getLocationInWorldCoordinates() const; 
    void setLocationInWorldCoordinates(const Vector3Double    &pX);

    BurstDescriptor& getBurstDescriptor(); 
    const BurstDescriptor&  getBurstDescriptor() const; 
    void setBurstDescriptor(const BurstDescriptor    &pX);

    Vector3Float& getVelocity(); 
    const Vector3Float&  getVelocity() const; 
    void setVelocity(const Vector3Float    &pX);

    float getRange() const; 
    void setRange(float pX); 


virtual int getMarshalledSize() const;

     bool operator  ==(const FirePdu& rhs) const;
};
}

#endif
