#ifndef MINEFIELDDATAPDU_H
#define MINEFIELDDATAPDU_H

#include <DIS/EntityID.h>
#include <DIS/EntityID.h>
#include <DIS/EntityType.h>
#include <DIS/TwoByteChunk.h>
#include <DIS/Vector3Float.h>
#include <vector>
#include <DIS/MinefieldFamilyPdu.h>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.3.10.3 Information about individual mines within a minefield. This is very, very wrong. UNFINISHED

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO MinefieldDataPdu : public MinefieldFamilyPdu
{
protected:
  // Minefield ID
  EntityID _minefieldID; 

  // ID of entity making request
  EntityID _requestingEntityID; 

  // Minefield sequence number
  unsigned short _minefieldSequenceNumbeer; 

  // request ID
  unsigned char _requestID; 

  // pdu sequence number
  unsigned char _pduSequenceNumber; 

  // number of pdus in response
  unsigned char _numberOfPdus; 

  // how many mines are in this PDU
  unsigned char _numberOfMinesInThisPdu; 

  // how many sensor type are in this PDU
  unsigned char _numberOfSensorTypes; 

  // padding
  unsigned char _pad2; 

  // 32 boolean fields
  unsigned int _dataFilter; 

  // Mine type
  EntityType _mineType; 

  // Sensor types, each 16 bits long
  std::vector<TwoByteChunk> _sensorTypes; 

  // Padding to get things 32-bit aligned. @@@this is wrong--dyanmically sized padding needed
  unsigned char _pad3; 

  // Mine locations
  std::vector<Vector3Float> _mineLocation; 


 public:
    MinefieldDataPdu();
    virtual ~MinefieldDataPdu();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    EntityID& getMinefieldID(); 
    const EntityID&  getMinefieldID() const; 
    void setMinefieldID(const EntityID    &pX);

    EntityID& getRequestingEntityID(); 
    const EntityID&  getRequestingEntityID() const; 
    void setRequestingEntityID(const EntityID    &pX);

    unsigned short getMinefieldSequenceNumbeer() const; 
    void setMinefieldSequenceNumbeer(unsigned short pX); 

    unsigned char getRequestID() const; 
    void setRequestID(unsigned char pX); 

    unsigned char getPduSequenceNumber() const; 
    void setPduSequenceNumber(unsigned char pX); 

    unsigned char getNumberOfPdus() const; 
    void setNumberOfPdus(unsigned char pX); 

    unsigned char getNumberOfMinesInThisPdu() const; 

    unsigned char getNumberOfSensorTypes() const; 

    unsigned char getPad2() const; 
    void setPad2(unsigned char pX); 

    unsigned int getDataFilter() const; 
    void setDataFilter(unsigned int pX); 

    EntityType& getMineType(); 
    const EntityType&  getMineType() const; 
    void setMineType(const EntityType    &pX);

    std::vector<TwoByteChunk>& getSensorTypes(); 
    const std::vector<TwoByteChunk>& getSensorTypes() const; 
    void setSensorTypes(const std::vector<TwoByteChunk>&    pX);

    unsigned char getPad3() const; 
    void setPad3(unsigned char pX); 

    std::vector<Vector3Float>& getMineLocation(); 
    const std::vector<Vector3Float>& getMineLocation() const; 
    void setMineLocation(const std::vector<Vector3Float>&    pX);


virtual int getMarshalledSize() const;

     bool operator  ==(const MinefieldDataPdu& rhs) const;
};
}

#endif
