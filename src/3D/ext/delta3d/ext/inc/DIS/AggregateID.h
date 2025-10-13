#ifndef AGGREGATEID_H
#define AGGREGATEID_H

#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.2.36. Each agregate in a given simulation app is given an aggregate identifier number unique for all other aggregates in that app and in that exercise. The id is valid for the duration of the the exercise.

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO AggregateID
{
protected:
  // The site ID
  unsigned short _site; 

  // The application ID
  unsigned short _application; 

  // the aggregate ID
  unsigned short _aggregateID; 


 public:
    AggregateID();
    virtual ~AggregateID();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    unsigned short getSite() const; 
    void setSite(unsigned short pX); 

    unsigned short getApplication() const; 
    void setApplication(unsigned short pX); 

    unsigned short getAggregateID() const; 
    void setAggregateID(unsigned short pX); 


virtual int getMarshalledSize() const;

     bool operator  ==(const AggregateID& rhs) const;
};
}

#endif
