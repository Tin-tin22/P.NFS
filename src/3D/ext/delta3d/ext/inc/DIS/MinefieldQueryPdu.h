#ifndef MINEFIELDQUERYPDU_H
#define MINEFIELDQUERYPDU_H

#include <DIS/EntityID.h>
#include <DIS/EntityID.h>
#include <DIS/EntityType.h>
#include <DIS/Point.h>
#include <DIS/TwoByteChunk.h>
#include <vector>
#include <DIS/MinefieldFamilyPdu.h>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.3.10.2 Query a minefield for information about individual mines. Requires manual clean up to get the padding right. UNFINISHED

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO MinefieldQueryPdu : public MinefieldFamilyPdu
{
protected:
  // Minefield ID
  EntityID _minefieldID; 

  // EID of entity making the request
  EntityID _requestingEntityID; 

  // request ID
  unsigned char _requestID; 

  // Number of perimeter points for the minefield
  unsigned char _numberOfPerimeterPoints; 

  // Padding
  unsigned char _pad2; 

  // Number of sensor types
  unsigned char _numberOfSensorTypes; 

  // data filter, 32 boolean fields
  unsigned int _dataFilter; 

  // Entity type of mine being requested
  EntityType _requestedMineType; 

  // perimeter points of request
  std::vector<Point> _requestedPerimeterPoints; 

  // Sensor types, each 16 bits long
  std::vector<TwoByteChunk> _sensorTypes; 


 public:
    MinefieldQueryPdu();
    virtual ~MinefieldQueryPdu();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    EntityID& getMinefieldID(); 
    const EntityID&  getMinefieldID() const; 
    void setMinefieldID(const EntityID    &pX);

    EntityID& getRequestingEntityID(); 
    const EntityID&  getRequestingEntityID() const; 
    void setRequestingEntityID(const EntityID    &pX);

    unsigned char getRequestID() const; 
    void setRequestID(unsigned char pX); 

    unsigned char getNumberOfPerimeterPoints() const; 

    unsigned char getPad2() const; 
    void setPad2(unsigned char pX); 

    unsigned char getNumberOfSensorTypes() const; 

    unsigned int getDataFilter() const; 
    void setDataFilter(unsigned int pX); 

    EntityType& getRequestedMineType(); 
    const EntityType&  getRequestedMineType() const; 
    void setRequestedMineType(const EntityType    &pX);

    std::vector<Point>& getRequestedPerimeterPoints(); 
    const std::vector<Point>& getRequestedPerimeterPoints() const; 
    void setRequestedPerimeterPoints(const std::vector<Point>&    pX);

    std::vector<TwoByteChunk>& getSensorTypes(); 
    const std::vector<TwoByteChunk>& getSensorTypes() const; 
    void setSensorTypes(const std::vector<TwoByteChunk>&    pX);


virtual int getMarshalledSize() const;

     bool operator  ==(const MinefieldQueryPdu& rhs) const;
};
}

#endif
