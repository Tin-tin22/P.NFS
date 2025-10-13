#ifndef GRIDAXISRECORDREPRESENTATION2_H
#define GRIDAXISRECORDREPRESENTATION2_H

#include <DIS/FourByteChunk.h>
#include <vector>
#include <DIS/GridAxisRecord.h>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// 5.2.44: Grid data record, representation 1

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO GridAxisRecordRepresentation2 : public GridAxisRecord
{
protected:
  // number of values
  unsigned short _numberOfValues; 

  // variable length list of data parameters @@@this is wrong--need padding as well
  std::vector<FourByteChunk> _dataValues; 


 public:
    GridAxisRecordRepresentation2();
    virtual ~GridAxisRecordRepresentation2();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    unsigned short getNumberOfValues() const; 

    std::vector<FourByteChunk>& getDataValues(); 
    const std::vector<FourByteChunk>& getDataValues() const; 
    void setDataValues(const std::vector<FourByteChunk>&    pX);


virtual int getMarshalledSize() const;

     bool operator  ==(const GridAxisRecordRepresentation2& rhs) const;
};
}

#endif
