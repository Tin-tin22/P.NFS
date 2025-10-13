#ifndef CREATEENTITYPDU_H
#define CREATEENTITYPDU_H

#include <DIS/SimulationManagementFamilyPdu.h>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.3.6.1. Create a new entity. COMPLETE

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO CreateEntityPdu : public SimulationManagementFamilyPdu
{
protected:
  // Identifier for the request
  unsigned int _requestID; 


 public:
    CreateEntityPdu();
    virtual ~CreateEntityPdu();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    unsigned int getRequestID() const; 
    void setRequestID(unsigned int pX); 


virtual int getMarshalledSize() const;

     bool operator  ==(const CreateEntityPdu& rhs) const;
};
}

#endif
