#ifndef LINEARSEGMENTPARAMETER_H
#define LINEARSEGMENTPARAMETER_H

#include <DIS/SixByteChunk.h>
#include <DIS/Vector3Double.h>
#include <DIS/Orientation.h>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// 5.2.48: Linear segment parameters

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO LinearSegmentParameter
{
protected:
  // number of segments
  unsigned char _segmentNumber; 

  // segment appearance
  SixByteChunk _segmentAppearance; 

  // location
  Vector3Double _location; 

  // orientation
  Orientation _orientation; 

  // segmentLength
  unsigned short _segmentLength; 

  // segmentWidth
  unsigned short _segmentWidth; 

  // segmentHeight
  unsigned short _segmentHeight; 

  // segment Depth
  unsigned short _segmentDepth; 

  // segment Depth
  unsigned int _pad1; 


 public:
    LinearSegmentParameter();
    virtual ~LinearSegmentParameter();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    unsigned char getSegmentNumber() const; 
    void setSegmentNumber(unsigned char pX); 

    SixByteChunk& getSegmentAppearance(); 
    const SixByteChunk&  getSegmentAppearance() const; 
    void setSegmentAppearance(const SixByteChunk    &pX);

    Vector3Double& getLocation(); 
    const Vector3Double&  getLocation() const; 
    void setLocation(const Vector3Double    &pX);

    Orientation& getOrientation(); 
    const Orientation&  getOrientation() const; 
    void setOrientation(const Orientation    &pX);

    unsigned short getSegmentLength() const; 
    void setSegmentLength(unsigned short pX); 

    unsigned short getSegmentWidth() const; 
    void setSegmentWidth(unsigned short pX); 

    unsigned short getSegmentHeight() const; 
    void setSegmentHeight(unsigned short pX); 

    unsigned short getSegmentDepth() const; 
    void setSegmentDepth(unsigned short pX); 

    unsigned int getPad1() const; 
    void setPad1(unsigned int pX); 


virtual int getMarshalledSize() const;

     bool operator  ==(const LinearSegmentParameter& rhs) const;
};
}

#endif
