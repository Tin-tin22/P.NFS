#ifndef CLOCKTIME_H
#define CLOCKTIME_H

#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.2.8. Time measurements that exceed one hour. Hours is the number of           hours since January 1, 1970, UTC

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO ClockTime
{
protected:
  // Hours in UTC
  int _hour; 

  // Time past the hour
  unsigned int _timePastHour; 


 public:
    ClockTime();
    virtual ~ClockTime();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    int getHour() const; 
    void setHour(int pX); 

    unsigned int getTimePastHour() const; 
    void setTimePastHour(unsigned int pX); 


virtual int getMarshalledSize() const;

     bool operator  ==(const ClockTime& rhs) const;
};
}

#endif
