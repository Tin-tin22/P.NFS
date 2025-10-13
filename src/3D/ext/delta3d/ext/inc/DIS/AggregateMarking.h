#ifndef AGGREGATEMARKING_H
#define AGGREGATEMARKING_H

#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.2.37. Specifies the character set used inthe first byte, followed by up to 31 characters of text data.

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO AggregateMarking
{
protected:
  // The character set
  unsigned char _characterSet; 

  // The characters
  char _characters[31]; 


 public:
    AggregateMarking();
    virtual ~AggregateMarking();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    unsigned char getCharacterSet() const; 
    void setCharacterSet(unsigned char pX); 

    char*  getCharacters(); 
    const char*  getCharacters() const; 
    void setCharacters( const char*    pX);


virtual int getMarshalledSize() const;

     bool operator  ==(const AggregateMarking& rhs) const;
};
}

#endif
