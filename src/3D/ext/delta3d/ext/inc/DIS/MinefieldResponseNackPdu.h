#ifndef MINEFIELDRESPONSENACKPDU_H
#define MINEFIELDRESPONSENACKPDU_H

#include <DIS/EntityID.h>
#include <DIS/EntityID.h>
#include <DIS/EightByteChunk.h>
#include <vector>
#include <DIS/MinefieldFamilyPdu.h>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.3.10.4 proivde the means to request a retransmit of a minefield data pdu. COMPLETE

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO MinefieldResponseNackPdu : public MinefieldFamilyPdu
{
protected:
  // Minefield ID
  EntityID _minefieldID; 

  // entity ID making the request
  EntityID _requestingEntityID; 

  // request ID
  unsigned char _requestID; 

  // how many pdus were missing
  unsigned char _numberOfMissingPdus; 

  // PDU sequence numbers that were missing
  std::vector<EightByteChunk> _missingPduSequenceNumbers; 


 public:
    MinefieldResponseNackPdu();
    virtual ~MinefieldResponseNackPdu();

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

    unsigned char getNumberOfMissingPdus() const; 

    std::vector<EightByteChunk>& getMissingPduSequenceNumbers(); 
    const std::vector<EightByteChunk>& getMissingPduSequenceNumbers() const; 
    void setMissingPduSequenceNumbers(const std::vector<EightByteChunk>&    pX);


virtual int getMarshalledSize() const;

     bool operator  ==(const MinefieldResponseNackPdu& rhs) const;
};
}

#endif
