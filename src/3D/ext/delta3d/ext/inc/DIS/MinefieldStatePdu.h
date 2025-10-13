#ifndef MINEFIELDSTATEPDU_H
#define MINEFIELDSTATEPDU_H

#include <DIS/EntityID.h>
#include <DIS/EntityType.h>
#include <DIS/Vector3Double.h>
#include <DIS/Orientation.h>
#include <DIS/Point.h>
#include <DIS/EntityType.h>
#include <vector>
#include <DIS/MinefieldFamilyPdu.h>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.3.10.1 Abstract superclass for PDUs relating to minefields. COMPLETE

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO MinefieldStatePdu : public MinefieldFamilyPdu
{
protected:
  // Minefield ID
  EntityID _minefieldID; 

  // Minefield sequence
  unsigned short _minefieldSequence; 

  // force ID
  unsigned char _forceID; 

  // Number of permieter points
  unsigned char _numberOfPerimeterPoints; 

  // type of minefield
  EntityType _minefieldType; 

  // how many mine types
  unsigned short _numberOfMineTypes; 

  // location of minefield in world coords
  Vector3Double _minefieldLocation; 

  // orientation of minefield
  Orientation _minefieldOrientation; 

  // appearance bitflags
  unsigned short _appearance; 

  // protocolMode
  unsigned short _protocolMode; 

  // perimeter points for the minefield
  std::vector<Point> _perimeterPoints; 

  // Type of mines
  std::vector<EntityType> _mineType; 


 public:
    MinefieldStatePdu();
    virtual ~MinefieldStatePdu();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    EntityID& getMinefieldID(); 
    const EntityID&  getMinefieldID() const; 
    void setMinefieldID(const EntityID    &pX);

    unsigned short getMinefieldSequence() const; 
    void setMinefieldSequence(unsigned short pX); 

    unsigned char getForceID() const; 
    void setForceID(unsigned char pX); 

    unsigned char getNumberOfPerimeterPoints() const; 

    EntityType& getMinefieldType(); 
    const EntityType&  getMinefieldType() const; 
    void setMinefieldType(const EntityType    &pX);

    unsigned short getNumberOfMineTypes() const; 

    Vector3Double& getMinefieldLocation(); 
    const Vector3Double&  getMinefieldLocation() const; 
    void setMinefieldLocation(const Vector3Double    &pX);

    Orientation& getMinefieldOrientation(); 
    const Orientation&  getMinefieldOrientation() const; 
    void setMinefieldOrientation(const Orientation    &pX);

    unsigned short getAppearance() const; 
    void setAppearance(unsigned short pX); 

    unsigned short getProtocolMode() const; 
    void setProtocolMode(unsigned short pX); 

    std::vector<Point>& getPerimeterPoints(); 
    const std::vector<Point>& getPerimeterPoints() const; 
    void setPerimeterPoints(const std::vector<Point>&    pX);

    std::vector<EntityType>& getMineType(); 
    const std::vector<EntityType>& getMineType() const; 
    void setMineType(const std::vector<EntityType>&    pX);


virtual int getMarshalledSize() const;

     bool operator  ==(const MinefieldStatePdu& rhs) const;
};
}

#endif
