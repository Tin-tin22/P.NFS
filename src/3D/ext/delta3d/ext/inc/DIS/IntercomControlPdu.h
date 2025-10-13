#ifndef INTERCOMCONTROLPDU_H
#define INTERCOMCONTROLPDU_H

#include <DIS/EntityID.h>
#include <DIS/EntityID.h>
#include <DIS/IntercomCommunicationsParameters.h>
#include <vector>
#include <DIS/RadioCommunicationsFamilyPdu.h>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.3.8.5. Detailed inofrmation about the state of an intercom device and the actions it is requestion         of another intercom device, or the response to a requested action. Required manual intervention to fix the intercom parameters,        which can be of varialbe length. UNFINSISHED

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO IntercomControlPdu : public RadioCommunicationsFamilyPdu
{
protected:
  // control type
  unsigned char _controlType; 

  // control type
  unsigned char _communicationsChannelType; 

  // Source entity ID
  EntityID _sourceEntityID; 

  // The specific intercom device being simulated within an entity.
  unsigned char _sourceCommunicationsDeviceID; 

  // Line number to which the intercom control refers
  unsigned char _sourceLineID; 

  // priority of this message relative to transmissons from other intercom devices
  unsigned char _transmitPriority; 

  // current transmit state of the line
  unsigned char _transmitLineState; 

  // detailed type requested.
  unsigned char _command; 

  // eid of the entity that has created this intercom channel.
  EntityID _masterEntityID; 

  // specific intercom device that has created this intercom channel
  unsigned short _masterCommunicationsDeviceID; 

  // number of intercom parameters
  unsigned int _intercomParametersLength; 

  // @@@This is wrong--the length of the data field is variable. Using a long for now.
  std::vector<IntercomCommunicationsParameters> _intercomParameters; 


 public:
    IntercomControlPdu();
    virtual ~IntercomControlPdu();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    unsigned char getControlType() const; 
    void setControlType(unsigned char pX); 

    unsigned char getCommunicationsChannelType() const; 
    void setCommunicationsChannelType(unsigned char pX); 

    EntityID& getSourceEntityID(); 
    const EntityID&  getSourceEntityID() const; 
    void setSourceEntityID(const EntityID    &pX);

    unsigned char getSourceCommunicationsDeviceID() const; 
    void setSourceCommunicationsDeviceID(unsigned char pX); 

    unsigned char getSourceLineID() const; 
    void setSourceLineID(unsigned char pX); 

    unsigned char getTransmitPriority() const; 
    void setTransmitPriority(unsigned char pX); 

    unsigned char getTransmitLineState() const; 
    void setTransmitLineState(unsigned char pX); 

    unsigned char getCommand() const; 
    void setCommand(unsigned char pX); 

    EntityID& getMasterEntityID(); 
    const EntityID&  getMasterEntityID() const; 
    void setMasterEntityID(const EntityID    &pX);

    unsigned short getMasterCommunicationsDeviceID() const; 
    void setMasterCommunicationsDeviceID(unsigned short pX); 

    unsigned int getIntercomParametersLength() const; 

    std::vector<IntercomCommunicationsParameters>& getIntercomParameters(); 
    const std::vector<IntercomCommunicationsParameters>& getIntercomParameters() const; 
    void setIntercomParameters(const std::vector<IntercomCommunicationsParameters>&    pX);


virtual int getMarshalledSize() const;

     bool operator  ==(const IntercomControlPdu& rhs) const;
};
}

#endif
