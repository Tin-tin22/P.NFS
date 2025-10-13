#ifndef RECEIVERPDU_H
#define RECEIVERPDU_H

#include <DIS/EntityID.h>
#include <DIS/RadioCommunicationsFamilyPdu.h>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.3.8.3. Communication of a receiver state. COMPLETE

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO ReceiverPdu : public RadioCommunicationsFamilyPdu
{
protected:
  // encoding scheme used, and enumeration
  unsigned short _receiverState; 

  // padding
  unsigned short _padding1; 

  // received power
  float _receivedPoser; 

  // ID of transmitter
  EntityID _transmitterEntityId; 

  // ID of transmitting radio
  unsigned short _transmitterRadioId; 


 public:
    ReceiverPdu();
    virtual ~ReceiverPdu();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    unsigned short getReceiverState() const; 
    void setReceiverState(unsigned short pX); 

    unsigned short getPadding1() const; 
    void setPadding1(unsigned short pX); 

    float getReceivedPoser() const; 
    void setReceivedPoser(float pX); 

    EntityID& getTransmitterEntityId(); 
    const EntityID&  getTransmitterEntityId() const; 
    void setTransmitterEntityId(const EntityID    &pX);

    unsigned short getTransmitterRadioId() const; 
    void setTransmitterRadioId(unsigned short pX); 


virtual int getMarshalledSize() const;

     bool operator  ==(const ReceiverPdu& rhs) const;
};
}

#endif
