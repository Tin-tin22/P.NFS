#ifndef INTERCOMSIGNALPDU_H
#define INTERCOMSIGNALPDU_H

#include <DIS/EntityID.h>
#include <DIS/OneByteChunk.h>
#include <vector>
#include <DIS/RadioCommunicationsFamilyPdu.h>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.3.8.4. Actual transmission of intercome voice data. COMPLETE

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO IntercomSignalPdu : public RadioCommunicationsFamilyPdu
{
protected:
  // entity ID
  EntityID _entityID; 

  // ID of communications device
  unsigned short _communicationsDeviceID; 

  // encoding scheme
  unsigned short _encodingScheme; 

  // tactical data link type
  unsigned short _TdlType; 

  // sample rate
  unsigned int _sampleRate; 

  // data length
  unsigned short _dataLength; 

  // samples
  unsigned short _samples; 

  // data bytes
  std::vector<OneByteChunk> _data; 


 public:
    IntercomSignalPdu();
    virtual ~IntercomSignalPdu();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    EntityID& getEntityID(); 
    const EntityID&  getEntityID() const; 
    void setEntityID(const EntityID    &pX);

    unsigned short getCommunicationsDeviceID() const; 
    void setCommunicationsDeviceID(unsigned short pX); 

    unsigned short getEncodingScheme() const; 
    void setEncodingScheme(unsigned short pX); 

    unsigned short getTdlType() const; 
    void setTdlType(unsigned short pX); 

    unsigned int getSampleRate() const; 
    void setSampleRate(unsigned int pX); 

    unsigned short getDataLength() const; 

    unsigned short getSamples() const; 
    void setSamples(unsigned short pX); 

    std::vector<OneByteChunk>& getData(); 
    const std::vector<OneByteChunk>& getData() const; 
    void setData(const std::vector<OneByteChunk>&    pX);


virtual int getMarshalledSize() const;

     bool operator  ==(const IntercomSignalPdu& rhs) const;
};
}

#endif
