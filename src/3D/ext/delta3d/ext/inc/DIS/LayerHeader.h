#ifndef LAYERHEADER_H
#define LAYERHEADER_H

#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// 5.2.47.  Layer header.

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO LayerHeader
{
protected:
  // Layer number
  unsigned char _layerNumber; 

  // Layer speccific information enumeration
  unsigned char _layerSpecificInformaiton; 

  // information length
  unsigned short _length; 


 public:
    LayerHeader();
    virtual ~LayerHeader();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    unsigned char getLayerNumber() const; 
    void setLayerNumber(unsigned char pX); 

    unsigned char getLayerSpecificInformaiton() const; 
    void setLayerSpecificInformaiton(unsigned char pX); 

    unsigned short getLength() const; 
    void setLength(unsigned short pX); 


virtual int getMarshalledSize() const;

     bool operator  ==(const LayerHeader& rhs) const;
};
}

#endif
