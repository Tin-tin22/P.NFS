#ifndef EVENTID_H
#define EVENTID_H

#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.2.18. Identifies a unique event in a simulation via the combination of three values

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO EventID
{
protected:
  // The application ID
  unsigned short _application; 

  // The site ID
  unsigned short _site; 

  // the number of the event
  unsigned short _eventNumber; 


 public:
    EventID();
    virtual ~EventID();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    unsigned short getApplication() const; 
    void setApplication(unsigned short pX); 

    unsigned short getSite() const; 
    void setSite(unsigned short pX); 

    unsigned short getEventNumber() const; 
    void setEventNumber(unsigned short pX); 


virtual int getMarshalledSize() const;

     bool operator  ==(const EventID& rhs) const;
};
}

#endif
