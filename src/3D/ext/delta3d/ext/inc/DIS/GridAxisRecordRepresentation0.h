#ifndef GRIDAXISRECORDREPRESENTATION0_H
#define GRIDAXISRECORDREPRESENTATION0_H

#include <DIS/OneByteChunk.h>
#include <vector>
#include <DIS/GridAxisRecord.h>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// 5.2.44: Grid data record, representation 0

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO GridAxisRecordRepresentation0 : public GridAxisRecord
{
protected:
  // number of bytes of environmental state data
  unsigned short _numberOfBytes; 

  // variable length list of data parameters @@@this is wrong--need padding as well
  std::vector<OneByteChunk> _dataValues; 


 public:
    GridAxisRecordRepresentation0();
    virtual ~GridAxisRecordRepresentation0();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    unsigned short getNumberOfBytes() const; 

    std::vector<OneByteChunk>& getDataValues(); 
    const std::vector<OneByteChunk>& getDataValues() const; 
    void setDataValues(const std::vector<OneByteChunk>&    pX);


virtual int getMarshalledSize() const;

     bool operator  ==(const GridAxisRecordRepresentation0& rhs) const;
};
}

#endif
