#ifndef GRIDAXISRECORDREPRESENTATION1_H
#define GRIDAXISRECORDREPRESENTATION1_H

#include <DIS/TwoByteChunk.h>
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

class EXPORT_MACRO GridAxisRecordRepresentation1 : public GridAxisRecord
{
protected:
  // constant scale factor
  float _fieldScale; 

  // constant offset used to scale grid data
  float _fieldOffset; 

  // Number of data values
  unsigned short _numberOfValues; 

  // variable length list of data parameters @@@this is wrong--need padding as well
  std::vector<TwoByteChunk> _dataValues; 


 public:
    GridAxisRecordRepresentation1();
    virtual ~GridAxisRecordRepresentation1();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    float getFieldScale() const; 
    void setFieldScale(float pX); 

    float getFieldOffset() const; 
    void setFieldOffset(float pX); 

    unsigned short getNumberOfValues() const; 

    std::vector<TwoByteChunk>& getDataValues(); 
    const std::vector<TwoByteChunk>& getDataValues() const; 
    void setDataValues(const std::vector<TwoByteChunk>&    pX);


virtual int getMarshalledSize() const;

     bool operator  ==(const GridAxisRecordRepresentation1& rhs) const;
};
}

#endif
