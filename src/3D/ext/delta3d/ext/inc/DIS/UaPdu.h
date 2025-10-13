#ifndef UAPDU_H
#define UAPDU_H

#include <DIS/EntityID.h>
#include <DIS/EventID.h>
#include <DIS/ShaftRPMs.h>
#include <DIS/ApaData.h>
#include <DIS/AcousticEmitterSystemData.h>
#include <vector>
#include <DIS/DistributedEmissionsFamilyPdu.h>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.3.7.3. Information about underwater acoustic emmissions. This requires manual cleanup.  The beam data records should ALL be a the finish, rather than attached to each emitter system. UNFINISHED

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO UaPdu : public DistributedEmissionsFamilyPdu
{
protected:
  // ID of the entity that is the source of the emission
  EntityID _emittingEntityID; 

  // ID of event
  EventID _eventID; 

  // This field shall be used to indicate whether the data in the UA PDU represent a state update or data that have changed since issuance of the last UA PDU
  char _stateChangeIndicator; 

  // padding
  char _pad; 

  // This field indicates which database record (or file) shall be used in the definition of passive signature (unintentional) emissions of the entity. The indicated database record (or  file) shall define all noise generated as a function of propulsion plant configurations and associated  auxiliaries.
  unsigned short _passiveParameterIndex; 

  // This field shall specify the entity propulsion plant configuration. This field is used to determine the passive signature characteristics of an entity.
  unsigned char _propulsionPlantConfiguration; 

  //  This field shall represent the number of shafts on a platform
  unsigned char _numberOfShafts; 

  // This field shall indicate the number of APAs described in the current UA PDU
  unsigned char _numberOfAPAs; 

  // This field shall specify the number of UA emitter systems being described in the current UA PDU
  unsigned char _numberOfUAEmitterSystems; 

  // shaft RPM values
  std::vector<ShaftRPMs> _shaftRPMs; 

  // apaData
  std::vector<ApaData> _apaData; 

  std::vector<AcousticEmitterSystemData> _emitterSystems; 


 public:
    UaPdu();
    virtual ~UaPdu();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    EntityID& getEmittingEntityID(); 
    const EntityID&  getEmittingEntityID() const; 
    void setEmittingEntityID(const EntityID    &pX);

    EventID& getEventID(); 
    const EventID&  getEventID() const; 
    void setEventID(const EventID    &pX);

    char getStateChangeIndicator() const; 
    void setStateChangeIndicator(char pX); 

    char getPad() const; 
    void setPad(char pX); 

    unsigned short getPassiveParameterIndex() const; 
    void setPassiveParameterIndex(unsigned short pX); 

    unsigned char getPropulsionPlantConfiguration() const; 
    void setPropulsionPlantConfiguration(unsigned char pX); 

    unsigned char getNumberOfShafts() const; 

    unsigned char getNumberOfAPAs() const; 

    unsigned char getNumberOfUAEmitterSystems() const; 

    std::vector<ShaftRPMs>& getShaftRPMs(); 
    const std::vector<ShaftRPMs>& getShaftRPMs() const; 
    void setShaftRPMs(const std::vector<ShaftRPMs>&    pX);

    std::vector<ApaData>& getApaData(); 
    const std::vector<ApaData>& getApaData() const; 
    void setApaData(const std::vector<ApaData>&    pX);

    std::vector<AcousticEmitterSystemData>& getEmitterSystems(); 
    const std::vector<AcousticEmitterSystemData>& getEmitterSystems() const; 
    void setEmitterSystems(const std::vector<AcousticEmitterSystemData>&    pX);


virtual int getMarshalledSize() const;

     bool operator  ==(const UaPdu& rhs) const;
};
}

#endif
